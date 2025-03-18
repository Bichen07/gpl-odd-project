import chroma from "chroma-js";
import { kdTree } from "kd-tree-javascript";
import { Theme } from "@mui/material/styles";
import { MRT_RowData } from "material-react-table";
import {
  KeyPerformanceIndicator,
  Observation,
  Scenario,
} from "src/__generated__/graphql";
import { Trial } from "src/api/services/Batches";
import { TrajectoryAnalysisResponse } from "./api/services/TrajectoryAnalysis";
import { DEG2RAD, RAD2DEG } from "three/src/math/MathUtils.js";
import { ClusterInfo } from "./redux/slices/session";
import { ClusteringResult } from "./api/services/Clustering";

export const displayValue = (value: number, attribute: string) => {
  let result = value;
  if (
    attribute === "speed" ||
    attribute.includes("Speed") ||
    attribute.includes("Velocity")
  ) {
    result = value * 3.6;
  } else if (attribute === "yawRate" || attribute.includes("Yaw")) {
    result = value * RAD2DEG;
  } else if (attribute.includes("EgoAcc")) {
    if (value < -10) {
      result = -10;
    }
  }
  return Number(result.toFixed(2));
};

export const display2originalValue = (value: number, attribute: string) => {
  if (
    attribute === "speed" ||
    attribute.includes("Speed") ||
    attribute.includes("Velocity")
  ) {
    return value / 3.6;
  } else if (attribute === "yawRate" || attribute.includes("Yaw")) {
    return value * DEG2RAD;
  } else if (attribute.includes("EgoAcc")) {
    if (value < -10) {
      value = -10;
    }
    return value;
  } else {
    return value;
  }
};

export const getUnit = (attribute: string) => {
  if (
    attribute === "speed" ||
    attribute.includes("Speed") ||
    attribute.includes("Velocity")
  ) {
    return "kph";
  } else if (attribute.includes("awRate")) {
    return "deg/s";
  } else if (attribute.includes("Yaw")) {
    return "deg";
  } else if (attribute.includes("Acceleration")) {
    return "mps2";
  } else if (attribute.includes("istance")) {
    return "m";
  }
  return "?";
};
export const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

export function generateColors(numColors: number) {
  return chroma
    .scale([
      "#a0af00",

      "#BD82BC",
      "#FFDD00",
      "#FF3366",

      "#9F75FF",
      // "#ff33a0",

      // "#7f9800",
      "#47A980",
      "#FF33BD",
      "#aaffc3",
      "#1188ff",
      // "#82B0D1",
      // "#FF5733",
      // "#FFBD33",
      // "#75FF33",
      // "#33FF57",
      // "#33FFBD",
      // "#3375FF",
      // "#8D33FF",
      // "#FF33BD",
    ])
    .mode("lab")
    .colors(numColors);

  // return chroma
  //   .scale(chroma.brewer.Set3.slice(0, -3))
  //   .mode("lch")
  //   .colors(numColors);

  // const colors = [
  //   "#e6194B",
  //   "#3cb44b",
  //   "#ffe119",
  //   "#4363d8",
  //   "#f58231",
  //   "#911eb4",
  //   "#42d4f4",
  //   "#f032e6",
  //   "#bfef45",
  //   "#fabed4",
  //   "#469990",
  //   "#dcbeff",
  //   "#9A6324",
  //   "#fffac8",
  //   "#808000",
  //   "#aaffc3",
  //   "#ffd8b1",
  //   "#800000",
  //   "#000075",
  // ];
  // const colors = [
  //   "#a6cee3",
  //   "#1f78b4",
  //   "#b2df8a",
  //   "#33a02c",
  //   "#fb9a99",
  //   "#e31a1c",
  //   "#fdbf6f",
  //   "#ff7f00",
  //   "#cab2d6",
  //   "#6a3d9a",
  //   "#ffff99",
  // ];
  // return chroma.scale(colors).mode("lch").colors(numColors);

  // const colors = [
  //   "#FF5733",
  //   "#FF8D33",
  //   "#FFD133",
  //   "#A4FF33",
  //   "#33FF57",
  //   "#33FF8D",
  //   "#33FFD1",
  //   "#338DFF",
  //   "#3357FF",
  //   "#8D33FF",
  //   "#D133FF",
  //   "#FF33D1",
  //   "#FF33A4",
  //   "#FF3366",
  //   "#A45133",
  //   "#8DFF33",
  //   "#D1AFFF",
  //   "#FFD700",
  // ];

  // const palette = mangoFusionPaletteDark;
  // return chroma.scale(palette).mode("lrgb").colors(numColors);
}

type Point = [number, number];
export function findPairsFromTwoGroups(
  selectedMetric: CriticalityMetric | null,
  trajectoryAnalysisResponse: TrajectoryAnalysisResponse | null,
  tree: kdTree<{ [key: string]: number }> | null,
  treePoints:
    | {
        trial: any;
        parameters: { [key: string]: number };
      }[]
    | null,
  groups: { safer: string[]; unsafer: string[] },
) {
  const trials = trajectoryAnalysisResponse?.trials;

  const result: { [saferTrialId: string]: string } = {};
  if (selectedMetric && trajectoryAnalysisResponse && trials && tree) {
    for (const [index, trial] of Object.values(trials ?? {}).entries()) {
      if (!groups.safer.includes(trial.id ?? "")) {
        continue;
      }

      const metric = selectedMetric;
      const metricName = selectedMetric.kpi.name;
      if (
        !(metricName in trajectoryAnalysisResponse.clustering.metricGradients)
      ) {
        continue;
      }

      const parameters = trajectoryAnalysisResponse.clustering.parameters;
      if (parameters == null) {
        console.log("no parameters");
        continue;
      }

      if (treePoints == null) {
        console.log("treepoints == null, conitnue");
        continue;
      }

      if (
        !(
          (trial.id ?? "unknown") in
          trajectoryAnalysisResponse.clustering.metricGradients[metricName].data
        )
      ) {
        console.log("trial id not in metric gradients data, conitnue");
        continue;
      }

      const selectedTreePoint = treePoints.find((p) => p.trial.id === trial.id);
      if (selectedTreePoint == null) {
        console.log("selectedTreePoint is null, conitnue..");
        continue;
      }

      const nNeighbors = 15;
      const nearestTreePointIndices = tree
        ?.nearest(selectedTreePoint.parameters, nNeighbors)
        .map((item) => item[0]["treeIndex"]);
      const nearestTreePoints = nearestTreePointIndices.map((i) =>
        treePoints != null ? treePoints[i] : null,
      );
      // .sort((a, b) => {
      //   const aMetricValue = a?.trial["testObjectives"][
      //     "criticalityMetrics"
      //   ].find(
      //     (item: any) =>
      //       item["keyPerformanceIndicator"]["name"] == metricName,
      //   )["value"];
      //
      //   const bMetricValue = b?.trial["testObjectives"][
      //     "criticalityMetrics"
      //   ].find(
      //     (item: any) =>
      //       item["keyPerformanceIndicator"]["name"] == metricName,
      //   )["value"];
      //   return metric.kpi.rule == "lessThan"
      //     ? aMetricValue - bMetricValue
      //     : bMetricValue - aMetricValue;
      // });

      const gradient = trajectoryAnalysisResponse.clustering.metricGradients[
        metricName
      ].data[trial.id ?? ""].map((row) => row[0]);
      const gradientUnit: Point = [gradient[0], gradient[1]];

      let minDistance = Infinity;
      let minTrialId = null;
      let minAngleDiff = Infinity;

      const selectedPoint: number[] = [];
      for (const parameter of parameters) {
        selectedPoint.push(selectedTreePoint.parameters[parameter.id ?? ""]);
      }
      for (const [i, treePoint] of nearestTreePoints.entries()) {
        if (
          treePoint == null ||
          groups.safer.includes(treePoint.trial["id"]) ||
          !groups.unsafer.includes(treePoint.trial["id"])
        ) {
          continue;
        }
        const point: number[] = [];
        for (const parameter of parameters) {
          point.push(treePoint.parameters[parameter.id ?? ""]);
        }
        const v: Point = [
          point[0] - selectedPoint[0],
          point[1] - selectedPoint[1],
        ];
        const gradAng = Math.atan2(gradientUnit[1], gradientUnit[0]);
        const vAng = Math.atan2(v[1], v[0]);
        const angDiff = Math.abs(vAng - gradAng);
        // if (Math.abs(angDiff) < 30 * DEG2RAD) {
        //   minTrialId = treePoint.trial.id ?? "";
        //   minAngleDiff = angDiff;
        //   break;
        // }
        if (angDiff < minAngleDiff && Math.abs(angDiff) < 90 * DEG2RAD) {
          minTrialId = treePoint.trial.id ?? "";
          minAngleDiff = angDiff;
        }
      }

      if (minTrialId && minTrialId != "" && trial?.id != null) {
        result[trial.id] = minTrialId;
      } else {
        // console.log("not found min trial id, continue");
        // console.log(nearestTreePoints.length);
      }
    }
  }
  return result;
}

export class MinMaxScaler {
  private min: number;
  private max: number;
  private scaledMin: number;
  private scaledMax: number;

  constructor(scaledMin: number = 0, scaledMax: number = 1) {
    this.min = 0;
    this.max = 1;
    this.scaledMin = scaledMin;
    this.scaledMax = scaledMax;
  }

  // Fit the scaler on the data and find min and max values
  public fit(data: number[]): void {
    this.min = Math.min(...data);
    this.max = Math.max(...data);
  }

  // Transform the data to the scaled range
  public transform(data: number[]): number[] {
    return data.map((x) => this.scale(x));
  }

  // Inverse transform to original scale
  public inverseTransform(data: number[]): number[] {
    return data.map((x) => this.inverseScale(x));
  }

  // Helper function to scale a single value
  private scale(x: number): number {
    return (
      this.scaledMin +
      ((x - this.min) * (this.scaledMax - this.scaledMin)) /
        (this.max - this.min)
    );
  }

  // Helper function to inverse scale a single value
  private inverseScale(x: number): number {
    return (
      this.min +
      ((x - this.scaledMin) * (this.max - this.min)) /
        (this.scaledMax - this.scaledMin)
    );
  }
}

export const titleizeCamelCase = (str: string) => {
  return str
    .replace(/([a-z])([A-Z])/g, "$1 $2") // Add space between lowercase and uppercase letters
    .replace(/^[a-z]/, function (match) {
      // Capitalize the first letter
      return match.toUpperCase();
    });
};

export const downloadFile = (url: string) => {
  // Create a temporary link element
  var link = document.createElement("a");
  link.href = url;

  // Set the download attribute to specify the file name
  link.download = "filename.ext";

  // Trigger a click on the link to initiate download
  link.click();

  // Clean up: remove the link from the DOM
  link.remove();
};

export type CriticalityMetric = {
  index: number;
  name: string;
  unit: string;
  rule: "greaterThan" | "lessThan";
  min: number;
  max: number;
  id: string;
  threshold: number;
};
export type CriticalityMetrics = {
  [id: string]: CriticalityMetric;
};
export const getCriticalityMetrics = (
  scenario: Scenario | null,
  trials: Trial[],
) => {
  if (
    scenario === null ||
    scenario.testObjectives === null ||
    scenario.testObjectives === undefined ||
    scenario.testObjectives.criticalityMetrics === null ||
    scenario.testObjectives.criticalityMetrics === undefined ||
    trials.length == 0
  ) {
    return null;
  }
  const newCriticalityMetrics: CriticalityMetrics = {};
  for (const [
    index,
    criticalityMetric,
  ] of scenario.testObjectives.criticalityMetrics.entries()) {
    const kpi = criticalityMetric.keyPerformanceIndicator;
    if (!kpi || !kpi.id) {
      continue;
    }
    const metricValues = Object.values(trials).map(
      (doc) => doc.testObjectives?.criticalityMetrics[index].value ?? NaN,
    );
    metricValues.sort();
    newCriticalityMetrics[kpi.id] = {
      index,
      unit: kpi.unit,
      id: kpi.id,
      name: kpi.name,
      rule: kpi.rule,
      threshold: criticalityMetric.threshold ?? 0,
      min: metricValues[0] ?? 0,
      max: metricValues[metricValues.length - 1] ?? 0,
    };
  }
  return newCriticalityMetrics;
};

export type Parameter = {
  index: number;
  name: string;
  unit: string;
  min: number;
  max: number;
  id: string;
};
export type Parameters = {
  [id: string]: Parameter;
};
export const getParameters = (scenario: Scenario) => {
  const result: Parameters = {};
  if (scenario.parameters === null || scenario.parameters === undefined) {
    return result;
  }
  for (const [index, parameter] of scenario.parameters.entries()) {
    result[parameter.id!] = {
      index,
      min: parameter.min ?? 0,
      max: parameter.max ?? 0,
      id: parameter.id!,
      name: parameter.name ?? "",
      unit: parameter.unit ?? "",
    };
  }
  return result;
};

export const getTree = (trials: Trial[], parameters: Parameters | null) => {
  if (trials === null || trials.length === 0 || parameters === null) {
    return null;
  }

  const trialValues = Object.values(trials);

  const points: { [key: string]: number }[] = [];

  for (const [index, trial] of trialValues.entries()) {
    const point: { [key: string]: number } = {};
    point["index"] = index;
    for (const parameter of trial.parameters) {
      point[parameter.parameterId as string] = parameter.value as number;
    }
    points.push(point);
  }

  const calculateDistance = (
    a: { [key: string]: number },
    b: { [key: string]: number },
  ) => {
    let sum = 0;
    for (const usedParameter of trialValues[0].parameters) {
      const id = usedParameter.parameterId as string;
      const parameter = parameters[id];
      const bound = [parameter.min, parameter.max];
      const aValue = a[id] / (bound[1] - bound[0]);
      const bValue = b[id] / (bound[1] - bound[0]);
      sum += Math.pow(aValue - bValue, 2);
    }

    return Math.sqrt(sum);
  };

  return new kdTree<{ [key: string]: number }>(
    points,
    calculateDistance,
    trialValues[0].parameters.map((p: any) => p.parameterId as string),
  );
};

export const observationDocsToRows = (docs: Observation[]) => {
  const rows: (MRT_RowData & { trialId: string | null })[] = [];
  for (const doc of docs) {
    let newRow: any = {
      trialId: doc.trial?.id ?? null,
      egoX: doc.egoX,
      egoY: doc.egoY,
      egoYaw: doc.egoYaw,
      egoYawRate: doc.egoYawRate,
      egoSteerCmd: doc.egoSteerCmd,
      egoSpeed: doc.egoSpeed,
      egoAcceleration: doc.egoAcceleration,
    };
    if (doc.agents) {
      for (const agent of doc.agents) {
        const name = agent.name ?? agent.id;
        newRow = {
          ...newRow,
          [`${name}_LocalX`]: agent.localX,
          [`${name}_LocalY`]: agent.localY,
        };
      }
    } else {
      newRow = { ...newRow, egoX: doc.egoX, egoY: doc.egoY };
    }
    rows.push(newRow);
  }
  return rows;
};

export const trialObservationsToRows = (
  docs: { [snapshotType: string]: Observation }[],
) => {
  const rows: (MRT_RowData & { trialId: string | null })[] = [];
  for (const docData of docs) {
    let newRow: any = {
      trialId: Object.values(docData)[0].trial?.id ?? null,
    };
    for (const snapshotType of Object.keys(docData)) {
      const doc = docData[snapshotType];
      newRow = {
        ...newRow,
        [`${snapshotType}_egoX`]: doc.egoX,
        [`${snapshotType}_egoY`]: doc.egoY,
        [`${snapshotType}_egoYaw`]: doc.egoYaw,
        [`${snapshotType}_egoYawRate`]: doc.egoYawRate,
        [`${snapshotType}_egoSteerCmd`]: doc.egoSteerCmd,
        [`${snapshotType}_egoSpeed`]: doc.egoSpeed,
        [`${snapshotType}_egoAcceleration`]: doc.egoAcceleration,
      };
      if (doc.agents) {
        for (const agent of doc.agents) {
          const name = agent.name ?? agent.id;
          newRow = {
            ...newRow,
            [`${snapshotType}_${name}_LocalX`]: agent.localX,
            [`${snapshotType}_${name}_LocalY`]: agent.localY,
          };
        }
      }
    }
    rows.push(newRow);
  }
  return rows;
};

export const urlify = (str: string): string => {
  if (str.length === 0) {
    return "";
  }
  if (str[0] === " ") {
    return "%20" + urlify(str.slice(1));
  }
  return str[0] + urlify(str.slice(1));
};

export const getOutputColorScale = (
  criticalityMetric: CriticalityMetric | null,
  theme: Theme,
): [number, string][] | null => {
  if (!criticalityMetric) {
    return null;
  }
  if (criticalityMetric.rule === "greaterThan") {
    return [
      [criticalityMetric.min, theme.palette.error.main],
      [criticalityMetric.threshold, theme.palette.warning.main],
      [criticalityMetric.max, theme.palette.success.main],
    ];
  } else {
    return [
      [criticalityMetric.min, theme.palette.success.main],
      [criticalityMetric.threshold, theme.palette.warning.main],
      [criticalityMetric.max, theme.palette.error.main],
    ];
  }
};

export const resizeObserver = new ResizeObserver((_entries) => {
  window.dispatchEvent(new Event("resize"));
});

export function formatDate(date: Date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are zero-based
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

export const getCriticalityMetricColor = (
  trial: Trial,
  selectedKpi: KeyPerformanceIndicator | null,
  theme: Theme,
) => {
  let color = chroma(theme.palette.divider).hex();
  const criticalityMetric = trial.testObjectives?.criticalityMetrics.find(
    (m) => `${m.keyPerformanceIndicator.id}` === selectedKpi?.id,
  );
  if (criticalityMetric) {
    color = criticalityMetric.passed
      ? theme.palette.success.main
      : theme.palette.error.main;
  }
  return color;
};
