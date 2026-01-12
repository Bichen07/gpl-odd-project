"use client";
import { Box, Skeleton, Stack, SxProps, Typography } from "@mui/material";
import Link from "next/link";
// import DefaultImg from "@/assets/default.jpg";
import { Scenario } from "@/app/_shared/graphql/queries/batches";
import { urlify } from "@/app/_shared/utils";
import "./style.scss";

type Props = {
  to?: string;
  sx?: SxProps;
  scenario?: Scenario | null;
};
export default ({ to, scenario, sx }: Props) => {
  return (
    <Box
      component="div"
      sx={{
        cursor: "pointer",
        position: "relative",
        height: "100%",
        flexGrow: 0,
        flexShrink: 0,
        flexBasis: {
          xs: "50%",
          sm: "33.333%",
          md: "calc(25% - 10px)",
        },
        // flexBasis: {
        //   xs: "50%",
        //   sm: "33.333%",
        //   md: "25%",
        // },
        minWidth: 0,
        p: "0 5px",
        overflow: "hidden",
        "&:hover": {
          ".imageContainer": {
            transition: "transform 0.3s",
            transform: { md: "scale(1.1)", xs: "none" },
          },
        },
        ...sx,
      }}
    >
      <Link href={to ?? ""}>
        <Stack
          sx={{
            position: "relative",
            height: "100%",
          }}
        >
          <Box
            component="div"
            sx={{
              position: "relative",
              width: "100%",
              overflow: "hidden",
              borderRadius: "5px",
            }}
          >
            {scenario ? (
              <Box
                component="div"
                className="imageContainer"
                sx={{
                  overflow: "hidden",
                  position: "relative",
                  width: "100%",
                  flexShrink: 0,
                  boxSizing: "border-box",
                  backgroundImage: `url(${scenario?.schematic?.sizes?.tablet?.url
                      ? urlify(scenario.schematic.sizes.tablet.url)
                      : "/default.jpg"
                    })`,
                  backgroundPosition: "center center",
                  backgroundSize: "cover",
                  borderRadius: "5px",
                  "&::before": {
                    content: '""',
                    display: "block",
                    width: "100%",
                    paddingBottom: "56.25%",
                  },
                  transition: "transform 0.3s",
                }}
              />
            ) : (
              <Skeleton
                variant="rectangular"
                sx={{
                  position: "relative",
                  width: "100%",
                  flexShrink: 0,
                  boxSizing: "border-box",
                  borderRadius: "5px",
                  height: "auto",
                  "&::before": {
                    content: '""',
                    display: "block",
                    width: "100%",
                    paddingBottom: "56.25%",
                  },
                }}
              />
            )}
          </Box>
          <Stack
            sx={{
              padding: "3px 0",
              ".item": {
                mb: "2px",
              },
              ".item-text": {
                fontSize: { xs: 12, sm: 14 },
                display: "-webkit-box",
                WebkitLineClamp: 1,
                WebkitBoxOrient: "vertical",
                overflow: "hidden",
              },
              ".item-icon": {
                fontSize: { xs: 16, sm: 18 },
              },
            }}
          >
            <Typography
              fontWeight="bold"
              className="title"
              sx={{
                mt: 1,
                mb: 0.5,
                fontSize: { xs: 14, sm: 16 },
                display: "-webkit-box",
                WebkitLineClamp: 2,
                WebkitBoxOrient: "vertical",
                overflow: "hidden",
              }}
            >
              {scenario ? (
                (scenario?.name ?? scenario?.id)
              ) : (
                <>
                  <Skeleton />
                  <Skeleton />
                </>
              )}
            </Typography>
          </Stack>
        </Stack>
      </Link>
    </Box>
  );
};
