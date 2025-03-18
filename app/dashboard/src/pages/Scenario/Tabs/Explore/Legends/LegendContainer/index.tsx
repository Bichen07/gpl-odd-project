import { SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { PropsWithChildren } from "react";

type Props = {
  sx?: SxProps;
  title: string;
};
export default ({ sx, title, children }: Props & PropsWithChildren) => {
  return (
    <Stack
      justifyContent="center"
      sx={{
        width: "100%",
        // height: "100%",
        padding: "10px",
        margin: "5px",
        borderStyle: "solid",
        borderRadius: "8px",
        borderWidth: "0.5px",
        borderColor: "divider",
        ...sx,
      }}
    >
      <Typography className="title" sx={{ mb: 1 }}>
        {title}
      </Typography>
      {children}
    </Stack>
  );
};
