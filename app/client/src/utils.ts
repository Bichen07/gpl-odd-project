import { MRT_RowData } from "material-react-table";
import { Observation, Trial } from "payload/payload-types";

export const titleizeCamelCase = (str: string) => {
  return str
    .replace(/([a-z])([A-Z])/g, "$1 $2") // Add space between lowercase and uppercase letters
    .replace(/^[a-z]/, function(match) {
      // Capitalize the first letter
      return match.toUpperCase();
    });
};

export const observationDocsToRows = (docs: Observation[]) => {
  const rows: MRT_RowData[] = [];
  for (const doc of docs) {
    let newRow: any = {
      trialId: (doc.trial as Trial).id,
      time: doc.time,
      isFinal: doc.isFinal ? "True" : "False",
      egoX: doc.egoX,
      egoY: doc.egoY,
      egoYaw: doc.egoYaw,
      egoRoadId: doc.egoRoadId,
      egoS: doc.egoS,
      egoT: doc.egoT,
      egoLaneId: doc.egoLaneId,
      egoLaneOffset: doc.egoLaneOffset,
      egoSpeed: doc.egoSpeed,
      egoAcceleration: doc.egoAcceleration,
      egoYawRate: doc.egoYawRate,
      egoSpeedCmd: doc.egoSpeedCmd,
      egoSteerCmd: doc.egoSteerCmd,
    };
    if (doc.agents) {
      for (const agent of doc.agents) {
        const name = agent.name ?? agent.id;
        newRow = {
          ...newRow,
          [`${name}X`]: agent.x,
          [`${name}Y`]: agent.y,
          [`${name}Yaw`]: agent.yaw,
          [`${name}RoadId`]: agent.roadId,
          [`${name}S`]: agent.s,
          [`${name}T`]: agent.t,
          [`${name}LaneId`]: agent.laneId,
          [`${name}LaneOffset`]: agent.laneOffset,
          [`${name}Speed`]: agent.speed,
          [`${name}Acceleration`]: agent.acceleration,
          [`${name}YawRate`]: agent.yawRate,
          [`${name}LocalX`]: agent.localX,
          [`${name}LocalY`]: agent.localY,
          [`${name}LocalYaw`]: agent.localYaw,
          [`${name}RelativeVelocityX`]: agent.relativeVelocityX,
          [`${name}RelativeVelocityY`]: agent.relativeVelocityY,
          [`${name}RelativeAccelerationX`]: agent.relativeAccelerationX,
          [`${name}RelativeAccelerationY`]: agent.relativeAccelerationY,
          [`${name}RelativeYawRate`]: agent.relativeYawRate,
        };
      }
    }
    rows.push(newRow);
  }
  return rows;
};
