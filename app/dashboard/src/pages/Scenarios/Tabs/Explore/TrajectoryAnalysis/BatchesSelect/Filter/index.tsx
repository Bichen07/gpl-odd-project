import { useEffect, useState } from "react";
import { Chip, IconButton, InputBase, Stack } from "@mui/material";
import { FilterAlt } from "@mui/icons-material";
import FilterModal from "./FilterModal";
import { useAppSelector } from "src/redux/hooks";
import { useSessionBatches } from "src/api/services/Batches";
import { useParams } from "react-router-dom";

type Props = {
  setFilteredBatchIds: React.Dispatch<React.SetStateAction<Set<string>>>;
};
function Filter({ setFilteredBatchIds }: Props) {
  const params = useParams();

  const { data } = useSessionBatches(params["sessionId"]);
  let batches = data?.Batches;

  const [keyword, setKeyword] = useState<string>("");
  const [keywords, setKeywords] = useState<Set<string>>(new Set<string>());
  const [filterModal, setFilterModal] = useState<boolean>(false);

  // const tagTree = qs.parse(searchParams.toString())["tagTree"];

  useEffect(() => {
    const updatedFilteredBatchIds: string[] = [];
    for (const batch of batches?.docs ?? []) {
      const batchId = batch?.id;
      if (!batchId) {
        continue;
      }
      const scenarioName = batch.scenario.name;
      if (!scenarioName) {
        continue;
      }
      let found = false;
      for (const keyword of keywords) {
        found = scenarioName.includes(keyword);
        if (found) {
          break;
        }
      }
      if (!found) {
        continue;
      }
      updatedFilteredBatchIds.push(batchId);
    }
    setFilteredBatchIds(new Set<string>(updatedFilteredBatchIds));
  }, [keywords, data]);

  return (
    <>
      <Stack
        sx={{
          position: "relative",
          zIndex: 10,
        }}
      >
        <Stack
          direction="row"
          sx={{
            width: "100%",
            backgroundColor: "background.default",
            borderRadius: "50px",
            padding: "0 20px",
            marginBottom: "15px",
          }}
        >
          <InputBase
            sx={{ ml: 1, flex: 1 }}
            placeholder="Keyword..."
            value={keyword}
            onChange={(evt) => setKeyword(evt.target.value)}
            onKeyDown={(evt) => {
              if (evt.key === "Enter") {
                setKeywords((prev) => new Set([...prev, keyword]));
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
