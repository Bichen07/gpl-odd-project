import { Grid, InputLabel, SxProps, Theme, Typography } from "@mui/material";
import { PropsWithChildren } from "react";

type Props = {
  label: string;
  disabled?: boolean;
  sx?: SxProps<Theme>;
};

export default ({
  children,
  disabled,
  label,
  sx,
}: Props & PropsWithChildren) => {
  return (
    <Grid container className="labeler" sx={{ width: "auto", ...sx }}>
      <Grid item xs={12}>
        <InputLabel shrink={false} htmlFor={label}>
          <Typography
            fontSize={[12, null, null, 14, null]}
            sx={{
              mb: 0.5,
              color: `${disabled ? "divider" : "text.secondary"}`,
            }}
          >
            {label}
          </Typography>
        </InputLabel>
        {children}
      </Grid>
    </Grid>
  );
};
