import { useState } from "react";
import { Chip, IconButton, InputBase, Stack, SxProps } from "@mui/material";
import { useSearchParams } from "react-router-dom";
import { FilterAlt } from "@mui/icons-material";
import FilterModal from "./FilterModal";

type Props = {
  sx?: SxProps;
  keywords: Set<string>;
  setKeywords: React.Dispatch<React.SetStateAction<Set<string>>>;
};
function Filter({ keywords, setKeywords, sx }: Props) {
  const [inputKeyword, setInputKeyword] = useState<string>("");
  const [filterModal, setFilterModal] = useState<boolean>(false);

  return (
    <>
      <Stack
        sx={{
          position: "relative",
          zIndex: 10,
          pb: "20px",
          ...sx,
        }}
      >
        <Stack
          direction="row"
          sx={{
            width: "100%",
            backgroundColor: "background.paper",
            borderRadius: "50px",
            padding: "0 20px",
            marginBottom: "15px",
          }}
        >
          <InputBase
            sx={{ ml: 1, flex: 1 }}
            placeholder="Search..."
            value={inputKeyword}
            onChange={(evt) => setInputKeyword(evt.target.value)}
            onKeyDown={(evt) => {
              if (evt.key === "Enter") {
                setKeywords((prev) => new Set([...prev, inputKeyword]));
              }
            }}
          />
          <IconButton
            type="button"
            sx={{ p: "10px", color: "text.disabled" }}
            onClick={() => setFilterModal(true)}
          >
            <FilterAlt />
          </IconButton>
        </Stack>
        <Stack direction="row" gap={1} flexWrap="wrap">
          {[...keywords].map((word) => (
            <Chip
              label={`Keyword： ${word}`}
              sx={{
                "& .MuiChip-deleteIcon": {
                  color: "primary.main",
                },
              }}
              onDelete={() => {
                setKeywords((prev) => {
                  const updated = new Set([...prev]);
                  updated.delete(word);
                  return updated;
                });
              }}
            />
          ))}
          {/* {tagTree && ( */}
          {/*   <Chip */}
          {/*     label={"TagTree"} */}
          {/*     sx={{ */}
          {/*       "& .MuiChip-deleteIcon": { */}
          {/*         color: "primary.main", */}
          {/*       }, */}
          {/*     }} */}
          {/*     onDelete={() => { */}
          {/*       setSearchParams((prev) => { */}
          {/*         let search = new URLSearchParams(prev); */}
          {/*         for (const key of search.keys()) { */}
          {/*           if (key.includes("tagTree")) { */}
          {/*             search.delete(key); */}
          {/*           } */}
          {/*         } */}
          {/*         return search; */}
          {/*       }); */}
          {/*     }} */}
          {/*   /> */}
          {/* )} */}
        </Stack>
      </Stack>
      <FilterModal open={filterModal} onClose={() => setFilterModal(false)} />
    </>
  );
}

export default Filter;
