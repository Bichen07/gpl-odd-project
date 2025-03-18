import { Field } from "payload/types";

const initialStateField: Field = {
  label: "Initial State",
  type: "collapsible",
  admin: {
    initCollapsed: true,
  },
  fields: [
    {
      name: "initialState",
      label: false,
      type: "group",
      fields: [
        {
          name: "direction",
          label: "Direction",
          type: "select",
          options: [
            {
              label: "Same as ego",
              value: "sameAsEgo",
            },
            {
              label: "Oncoming",
              value: "oncoming",
            },
            {
              label: "Crossing",
              value: "crossing",
            },
          ],
        },
        {
          name: "dynamics",
          label: "Dynamics",
          type: "select",
          options: [
            {
              label: "Moving",
              value: "moving",
            },
            {
              label: "Standing still",
              value: "standingStill",
            },
          ],
        },
        {
          name: "lateralPosition",
          label: "Lateral Position",
          type: "select",
          options: [
            {
              label: "Same Lane",
              value: "sameLane",
            },
            {
              label: "Left of ego",
              value: "leftOfEgo",
            },
            {
              label: "Right of ego",
              value: "rightOfEgo",
            },
          ],
        },
        {
          name: "longitudinalPosition",
          label: "Longitudinal Position",
          type: "select",
          options: [
            {
              label: "In front of ego",
              value: "inFrontOfEgo",
            },
            {
              label: "Side of ego",
              value: "sideOfEgo",
            },
            {
              label: "Rear of ego",
              value: "rearOfEgo",
            },
          ],
        },
      ],
    },
  ],
};

export default initialStateField;
