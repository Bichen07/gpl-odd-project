import { Box, Modal } from "@mui/material";
import { PropsWithChildren } from "react";

type Props = {
  open: boolean;
  onClose: () => void;
};
export default ({ children, open, onClose }: Props & PropsWithChildren) => {
  return (
    <Modal open={open} onClose={onClose}>
      <Box
        sx={{
          position: "absolute",
          top: "50%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          maxWidth: "80%",
          maxHeight: "70%",
          overflowX: "hidden",
          boxShadow: 10,
        }}
      >
        {children}
      </Box>
    </Modal>
  );
};
