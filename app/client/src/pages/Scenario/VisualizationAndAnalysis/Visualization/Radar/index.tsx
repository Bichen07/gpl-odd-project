import {
  Box,
  Checkbox,
  ListItemIcon,
  ListItemText,
  MenuItem,
  Select,
  Typography,
} from "@mui/material";
import { useEffect, useState } from "react";
import {
  Radar,
  RadarChart,
  PolarGrid,
  Legend,
  PolarAngleAxis,
  PolarRadiusAxis,
  ResponsiveContainer,
} from "recharts";
import Labeler from "src/components/Labeler";
import TextFieldSkeleton from "src/components/TextFieldSkeleton";
import { useAppSelector } from "src/redux/hooks";

type RadarData = {
  name: string;
  dataKey: string;
  stroke: string;
  fill: string;
  fillOpacity: number;
};

type Plot = {
  data: any[];
  radars: RadarData[];
};

export default () => {
  const selectedAttributes = useAppSelector(
    (state) => state.timeSeriesClustering.selectedAttributes
  );
  const clusters = useAppSelector(
    (state) => state.timeSeriesClustering.clusters
  );
  const clusterMemberData = useAppSelector(
    (state) => state.timeSeriesClustering.clusterMemberData
  );
  const representations = useAppSelector(
    (state) => state.timeSeriesClustering.representations
  );
  const [selectedClusters, setSelectedClusters] = useState<string[]>(["all"]);
  const clusterOptions =
    clusterMemberData === null
      ? []
      : Object.keys(clusterMemberData).filter((key) => key !== "-1");
  const isAllSelected =
    clusterMemberData !== null &&
    selectedAttributes !== null &&
    clusterOptions.length > 0 &&
    selectedClusters.length === clusterOptions.length;

  const [plot, setPlot] = useState<Plot | null>({ data: [], radars: [] });

  useEffect(() => {
    if (
      clusterMemberData === null ||
      clusters === null ||
      selectedAttributes === null ||
      representations === null
    ) {
      return;
    }
    const newPlot: Plot = { data: [], radars: [] };
    for (const [index, attribute] of selectedAttributes.entries()) {
      const attributeData: any = { attribute };
      const attributeMin = Math.min(
        ...Object.values(representations).map((r) => r[index])
      );
      const attributeMax = Math.max(
        ...Object.values(representations).map((r) => r[index])
      );
      for (const [cluster, memberData] of Object.entries(clusterMemberData)) {
        if (cluster === "-1") {
          continue;
        }
        const clusterTrialIds = Object.keys(representations).filter(
          (trialId) => clusters[trialId].cluster === Number(cluster)
        );
        let mean = 0;
        for (const trialId of clusterTrialIds) {
          mean += representations[trialId][index];
        }
        attributeData[String(cluster)] = mean / (attributeMax - attributeMin);
      }
      attributeData["fullMark"] = 1.0;
      newPlot.data.push(attributeData);
    }
    for (const [cluster, memberData] of Object.entries(clusterMemberData)) {
      if (cluster === "-1") {
        continue;
      }
      newPlot.radars.push({
        name: cluster,
        dataKey: cluster,
        stroke: memberData.color,
        fill: memberData.color,
        fillOpacity: 0.6,
      });
    }
    console.log(newPlot);
    setPlot(newPlot);
  }, [clusterMemberData, selectedAttributes, representations, clusters]);

  return (
    <Box>
      <Typography>Cluster Attributes Radar</Typography>
      <Box sx={{ width: "500px", height: "500px" }}>
        {clusterMemberData === null ? (
          <TextFieldSkeleton />
        ) : (
          <Labeler
            sx={{
              flexGrow: 1,
              ".MuiInputBase-root": {
                maxWidth: "none",
                flexShrink: 1,
                flexGrow: 1,
              },
            }}
            label="view clusters"
          >
            <Select
              multiple
              size="small"
              value={selectedClusters}
              sx={{ width: 300 }}
              onChange={(event) => {
                const value = event.target.value;
                if (value[value.length - 1] === "all") {
                  setSelectedClusters(
                    selectedClusters.length === clusterOptions.length
                      ? []
                      : clusterOptions
                  );
                  return;
                }
                setSelectedClusters(
                  typeof value === "string" ? [value] : value
                );
              }}
              renderValue={(selected) => selected.join(", ")}
            >
              <MenuItem value="all">
                <ListItemIcon>
                  <Checkbox
                    checked={isAllSelected}
                    indeterminate={
                      selectedClusters.length > 0 &&
                      selectedClusters.length < clusterOptions.length
                    }
                  />
                </ListItemIcon>
                <ListItemText primary="Select All" />
              </MenuItem>
              {Object.keys(clusterMemberData).map((option) => (
                <MenuItem key={option} value={option}>
                  <ListItemIcon>
                    <Checkbox checked={selectedClusters.indexOf(option) > -1} />
                  </ListItemIcon>
                  <ListItemText primary={option} />
                </MenuItem>
              ))}
            </Select>
          </Labeler>
        )}
        {plot === null ? null : (
          <ResponsiveContainer width="100%" height="100%">
            <RadarChart cx="50%" cy="50%" outerRadius="80%" data={plot.data}>
              <PolarGrid />
              <PolarAngleAxis dataKey="attribute" fontSize={10} />
              <PolarRadiusAxis angle={360 / plot.data.length} />
              {plot.radars
                .filter((radarData) =>
                  selectedClusters.find((key) => key === radarData.dataKey)
                )
                .map((radarData, index) => (
                  <Radar key={index} {...radarData} />
                ))}
              <Legend />
            </RadarChart>
          </ResponsiveContainer>
        )}
      </Box>
    </Box>
  );
};
