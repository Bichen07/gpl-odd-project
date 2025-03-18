import { Field } from "payload/types";

const vehicleLongitudinalActivityField: Field = {
  label: "Vehicle Longitudinal Activity",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "vehicleLongitudinalActivity",
      label: false,
      type: "group",
      fields: [
        {
          name: "mode",
          label: "Mode",
          type: "select",
          options: [
            {
              label: "Reversing",
              value: "reversing",
            },
            {
              label: "Standing still",
              value: "standingStill",
            },
            {
              label: "Driving forward",
              value: "drivingForward",
            },
          ],
        },
        {
          name: "drivingForwardMode",
          label: "Driving Forward Mode",
          type: "select",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined &&
                sibilingData.mode === "drivingForward"
              );
            },
          },
          options: [
            {
              label: "Braking",
              value: "braking",
            },
            {
              label: "Cruising",
              value: "cruising",
            },
            {
              label: "Accelerating",
              value: "accelerating",
            },
          ],
        },
      ],
    },
  ],
};

export default vehicleLongitudinalActivityField;
