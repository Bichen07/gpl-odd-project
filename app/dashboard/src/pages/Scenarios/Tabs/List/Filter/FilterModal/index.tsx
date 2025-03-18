import qs from "qs";
import { Box, Button, Modal, Stack, Typography } from "@mui/material";
import { useSearchParams } from "react-router-dom";
import { useState } from "react";
import {
  ScenarioVersion_Version_TagTree,
  ScenarioVersion_Version_TagTree_Ego_VehicleLateralActivity_Mode,
} from "src/__generated__/graphql";

type Props = {
  open: boolean;
  onClose: () => void;
};
export default ({ open, onClose }: Props) => {
  const [_searchParams, setSearchParams] = useSearchParams();
  const [tagTree, setTagTree] = useState<ScenarioVersion_Version_TagTree>({
    // example default value
    ego: {
      vehicleLateralActivity: {
        mode: ScenarioVersion_Version_TagTree_Ego_VehicleLateralActivity_Mode.GoingStraight,
      },
    },
  });

  return (
    <Modal open={open} onClose={onClose}>
      <Box
        sx={{
          position: "absolute",
          top: "50%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          width: "95%",
          maxWidth: 400,
          bgcolor: "background.paper",
          borderRadius: "10px",
          boxShadow: 24,
          padding: "20px 20px",
          "& > *": {
            marginBottom: "20px",
          },
          "& > div:last-of-type": {
            marginBottom: "0px",
          },
        }}
      >
        <Box>
          <Typography variant="h5" component="h2">
            Filter
          </Typography>
        </Box>
        <Stack>
          <Stack>
            <Typography variant="subtitle1">Tag Tree</Typography>
            {/* TODO: create tag tree interface */}
            <Typography variant="body2" sx={{ color: "text.disabled" }}>
              TODO: Tag Tree Filter Interface
            </Typography>
          </Stack>
          <Button
            sx={{ mt: 3 }}
            onClick={() => {
              setSearchParams((prev) => {
                let search = new URLSearchParams(prev);

                // Delete the previous tagTree query and create a new one based on the current tagTree
                for (const key of search.keys()) {
                  if (key.includes("tagTree")) {
                    search.delete(key);
                  }
                }
                const stringifiedTagTreeQuery = qs.stringify(
                  { tagTree },
                  {
                    addQueryPrefix: true,
                  },
                );

                return [stringifiedTagTreeQuery, search.toString()].join("&");
              });
              onClose();
            }}
            variant="contained"
            color="primary"
          >
            Filter
          </Button>
        </Stack>
      </Box>
    </Modal>
  );
};
