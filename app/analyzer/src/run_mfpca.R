#!/usr/bin/env Rscript

# ----- Install & load required packages -----
required_pkgs <- c("funData", "MFPCA", "RcppCNPy")
for (pkg in required_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
  library(pkg, character.only = TRUE)
}

make_irreg <- function(mat, time_points) {
  N <- nrow(mat)
  arg_list <- vector("list", N)
  val_list <- vector("list", N)
  for (i in seq_len(N)) {
    ok <- which(!is.na(mat[i, ]))
    if (length(ok)) {
      arg_list[[i]] <- time_points[ok]   # observed times for subject i
      val_list[[i]] <- mat[i, ok]        # observed values for subject i
    } else {
      arg_list[[i]] <- numeric(0)
      val_list[[i]] <- numeric(0)
    }
  }
  irregFunData(argvals = arg_list, X = val_list)
}

# ----- Load data saved from Python -----
time_points <- npyLoad("time_points.npy")   # 1-D vector of times

# Find all variable files
var_files <- list.files(pattern = "^X_var[0-9]+\\.npy$")
n_vars    <- length(var_files)
if (n_vars == 0) stop("No X_var*.npy files found.")

fd_list <- vector("list", n_vars)

for (v in seq_len(n_vars)) {
  mat <- npyLoad(var_files[v])
  # mat[is.nan(mat)] <- NA
  f_obj <- funData(argvals = list(time_points), X = mat)
  fd_list[[v]] <- f_obj
}

# for (v in seq_len(n_vars)) {
#   mat <- npyLoad(var_files[v])
#   mat[is.nan(mat)] <- NA                   # convert NaN → NA if needed
#
#   fd_irreg <- make_irreg(mat, time_points)
#   fd_funNA   <- as.funData(fd_irreg)          # put on union grid, NAs where unobserved
#   fd_list[[v]] <- fd_funNA
# }

# Combine into multivariate functional data
mfd <- multiFunData(fd_list)

# ----- Run MFPCA -----
# 1) Fit once with a generously large M (larger than you’ll likely need)
tmp <- MFPCA(
  mFData        = mfd,
  M             = 20,          # or min(50, nObs - 1) etc.
  uniExpansions = replicate(n_vars, list(type = "uFPCA", pve = 0.99), simplify = FALSE),
  fit           = TRUE
)

# 2) Compute cumulative PVE from the multivariate eigenvalues
lambda <- tmp$values                 # multivariate eigenvalues
cum_pve <- cumsum(lambda) / sum(lambda)
M95 <- which(cum_pve >= 0.95)[1]     # smallest M hitting 95%

# (Optional) quick check
# plot(cum_pve, type = "b"); abline(h = 0.95, col = 2, lty = 2)

# 3) Refit with the data-driven M
fit <- MFPCA(
  mFData        = mfd,
  M             = M95,
  uniExpansions = replicate(n_vars, list(type = "uFPCA", pve = 0.99), simplify = FALSE),
  fit           = TRUE
)

print("Dimensions of scores:")
print(dim(fit$scores))
print("First few rows of scores:")
print(head(fit$scores))

# ----- Extract and save results -----
scores <- fit$scores
write.csv(scores, "mfpca_scores.csv", row.names = FALSE)

eigs     <- fit$values
prop_var <- eigs / sum(eigs)
cum_var  <- cumsum(prop_var)
ev_table <- data.frame(PC         = seq_along(eigs),
                       Eigenvalue = eigs,
                       PropVar    = prop_var,
                       CumVar     = cum_var)
write.csv(ev_table, "mfpca_explained_variance.csv", row.names = FALSE)
write.csv(eigs, "mfpca_eigs.csv", row.names = FALSE)

cat("MFPCA completed. Scores and explained variance saved.\n")
