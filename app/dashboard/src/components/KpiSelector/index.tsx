import { useKpis } from "src/api/services/KeyPerformanceIndicators";
import Labeler from "../Labeler";
import TextFieldSkeleton from "../TextFieldSkeleton";
import { FormControl, InputLabel, MenuItem, Select } from "@mui/material";
import { KeyPerformanceIndicator } from "src/__generated__/graphql";

type Props = {
  selectedKpi: KeyPerformanceIndicator | null;
  setSelectedKpi: (value: KeyPerformanceIndicator | null) => void;
  disabled?: boolean;
};
export default function KpiSelector({
  selectedKpi,
  setSelectedKpi,
  disabled,
}: Props) {
  const { data, isLoading } = useKpis();
  return (
    <>
      {isLoading ? (
        <TextFieldSkeleton />
      ) : (
        <FormControl sx={{ m: 0, mr: 1 }}>
          <InputLabel size="small" id="safety-metric-selection-label">
            Metric
          </InputLabel>
          <Select
            disabled={disabled}
            sx={{ minWidth: "120px" }}
            label="Metric"
            labelId="safety-metric-selection-label"
            id="safety-metric-selection"
            size="small"
            value={selectedKpi?.id ?? ""}
            renderValue={() => selectedKpi?.name ?? ""}
            onChange={(event) =>
              setSelectedKpi(
                data?.docs?.find(
                  (doc) => (doc?.id ?? "") === event.target.value,
                ) ?? null,
              )
            }
          >
            {data?.docs?.map((doc, index) => {
              return (
                <MenuItem key={doc?.id ?? index} value={doc?.id ?? ""}>
                  {doc?.name ?? "unknown"}
                </MenuItem>
              );
            })}
          </Select>
        </FormControl>
      )}
    </>
  );
}
