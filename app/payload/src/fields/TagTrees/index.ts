import initialStateField from "./initialState";
import vehicleLateralActivityField from "./vehicleLateralActivity";
import vehicleLongitudinalActivityField from "./vehicleLongitudinalActivity";
import roadLayoutField from "./roadLayout";
import leadVehicleField from "./leadVehicle";
import { Field } from "payload/types";

const tagTreeField: Field = {
  label: "Tag Tree",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "ego",
      label: "Ego",
      type: "group",
      fields: [vehicleLongitudinalActivityField, vehicleLateralActivityField],
    },
    {
      name: "actors",
      label: "Actors",
      type: "array",
      fields: [
        vehicleLongitudinalActivityField,
        vehicleLateralActivityField,
        initialStateField,
        leadVehicleField,
      ],
    },
    {
      name: "roadLayout",
      label: "RoadLayout",
      type: "group",
      fields: [roadLayoutField],
    },
  ],
};

export default tagTreeField;
