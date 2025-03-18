import { Field } from "payload/types";

const vehicleLateralActivityField: Field = {
  label: "Vehicle Lateral Activity",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "vehicleLateralActivity",
      label: false,
      type: "group",
      fields: [
        {
          name: "mode",
          label: "Mode",
          type: "select",
          options: [
            {
              label: "Going Straight",
              value: "goingStraight",
            },
            {
              label: "Changing Lane",
              value: "changingLane",
            },
            {
              label: "Turning",
              value: "turning",
            },
            {
              label: "Swerving",
              value: "swerving",
            },
          ],
        },
        {
          name: "direction",
          label: "Direction",
          type: "select",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined &&
                sibilingData.mode !== "goingStraight"
              );
            },
          },
          options: [
            {
              label: "Left",
              value: "left",
            },
            {
              label: "Right",
              value: "right",
            },
          ],
        },
      ],
    },
  ],
};

export default vehicleLateralActivityField;
