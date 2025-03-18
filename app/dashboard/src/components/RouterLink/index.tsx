import { Box } from "@mui/material";
import { SxProps } from "@mui/material/styles";
import { PropsWithChildren } from "react";
import { NavLink } from "react-router-dom";

type Props = {
  className?: string;
  sx?: SxProps;
  to: string;
};

function RouterLink({
  className,
  sx,
  to,
  children,
}: Props & PropsWithChildren) {
  return (
    <Box className={className} sx={sx}>
      <NavLink style={{ textDecoration: "none", color: "inherit" }} to={to}>
        {children}
      </NavLink>
    </Box>
  );
}

export default RouterLink;
