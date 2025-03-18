import { Field } from "payload/types";

const roadLayoutField: Field = {
  label: "Road Layout",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "mode",
      label: "Mode",
      type: "select",
      options: [
        { label: "Straight", value: "straight" },
        { label: "Curved", value: "curved" },
        { label: "Junction", value: "junction" },
        { label: "Pedestrian crossing", value: "pedestrianCrossing" },
      ],
    },
    {
      name: "straightMode",
      label: "Straight Mode",
      type: "select",
      admin: {
        condition: (_data, sibilingData) => {
          return sibilingData !== undefined && sibilingData.mode === "straight";
        },
      },
      options: [
        { label: "Merge", value: "merge" },
        { label: "Entrance", value: "entrance" },
        { label: "Exit", value: "exit" },
        { label: "Other", value: "other" },
      ],
    },
    {
      name: "curvedMode",
      label: "Curved Mode",
      type: "select",
      admin: {
        condition: (_data, sibilingData) => {
          return sibilingData !== undefined && sibilingData.mode === "curved";
        },
      },
      options: [
        { label: "Merge", value: "merge" },
        { label: "Entrance", value: "entrance" },
        { label: "Exit", value: "exit" },
        { label: "Other", value: "other" },
      ],
    },
    {
      name: "junctionMode",
      label: "Junction Mode",
      type: "select",
      admin: {
        condition: (_data, sibilingData) => {
          return sibilingData !== undefined && sibilingData.mode === "junction";
        },
      },
      options: [
        { label: "Traffic light", value: "trafficLight" },
        { label: "No traffic light", value: "noTrafficLight" },
        { label: "Roundabout", value: "roundabout" },
      ],
    },
    {
      name: "pedestrianCrossingMode",
      label: "Pedestrian Crossing Mode",
      type: "select",
      admin: {
        condition: (_data, sibilingData) => {
          return (
            sibilingData !== undefined &&
            sibilingData.mode === "pedestrianCrossing"
          );
        },
      },
      options: [
        { label: "Traffic light", value: "trafficLight" },
        { label: "No traffic light", value: "noTrafficLight" },
      ],
    },
  ],
};

export default roadLayoutField;
