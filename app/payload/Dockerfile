FROM nikolaik/python-nodejs:python3.14-nodejs24-slim AS base

# --- DEPENDENCIES STAGE ---
FROM base AS deps
WORKDIR /app

# Install system build tools needed for scikit-learn/umap (Debian/Apt style)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Create venv and install ALL python packages in ONE logical block
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir numpy scipy scikit-learn umap-learn

# Install Node dependencies
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

# --- BUILDER STAGE ---
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# --- PRODUCTION STAGE ---
FROM base AS prod
WORKDIR /app

# Copy the entire virtual environment
COPY --from=deps /opt/venv /opt/venv
# Ensure the PATH is set so 'python' points to the venv version
ENV PATH="/opt/venv/bin:$PATH"

# Install runtime libraries (UMAP/Numba often needs libgomp1)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

EXPOSE 3000
ENV PORT 3000

CMD HOSTNAME="0.0.0.0" node server.js
