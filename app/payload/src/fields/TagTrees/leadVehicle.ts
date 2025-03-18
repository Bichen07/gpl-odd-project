import { Field } from "payload/types";

const leadVehicleField: Field = {
  label: "Lead Vehicle",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "leadVehicle",
      label: false,
      type: "group",
      fields: [
        {
          name: "mode",
          label: "Mode",
          type: "select",
          options: [
            { label: "Appearing", value: "appearing" },
            { label: "Disappearing", value: "disappearing" },
            { label: "Following", value: "following" },
          ],
        },
        {
          name: "appearingMode",
          label: "Appearing Mode",
          type: "select",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined && sibilingData.mode === "appearing"
              );
            },
          },
          options: [
            { label: "Cutting-in", value: "cuttingIn" },
            { label: "Gap-closing", value: "gapClosing" },
          ],
        },
        {
          name: "disappearingMode",
          label: "Disappearing Mode",
          type: "select",
          admin: {
            condition: (_data, sibilingData) => {
              return (
                sibilingData !== undefined &&
                sibilingData.mode === "disappearing"
              );
            },
          },
          options: [
            { label: "Cutting-out", value: "cuttingOut" },
            { label: "Gap-opening", value: "gapOpening" },
          ],
        },
      ],
    },
  ],
};

export default leadVehicleField;
