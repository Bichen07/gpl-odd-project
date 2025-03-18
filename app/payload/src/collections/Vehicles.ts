import { CollectionConfig } from "payload/types";
import { ComboField } from "@nouance/payload-better-fields-plugin";
import { usersAccess } from "../access";
import xmlFormat from "xml-formatter";

const Vehicles: CollectionConfig = {
  slug: "vehicles",
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    useAsTitle: "id",
    group: "Configs",
  },
  hooks: {
    beforeChange: [
      async ({ data }) => {
        if (data.vehicleDataFormat === "OpenSCENARIO") {
          delete data.itriVehicleConfig; // somehow not working.
        }
        if (data.vehicleDataFormat === "ITRI") {
          delete data.openScenarioVehicleConfig; // works here
        }
        return data;
      },
    ],
  },
  endpoints: [
    {
      path: "/:id/config",
      method: "get",
      handler: async (req, res) => {
        try {
          const vehicle = await req.payload.findByID({
            collection: "vehicles",
            id: req.params.id,
          });
          if (!vehicle) {
            return res.status(404).send({ message: "Vehicle not found" });
          }
          if (vehicle.vehicleDataFormat === "OpenSCENARIO") {
            var xml = xmlFormat.minify(
              vehicle.openScenarioVehicleConfig as string,
              {
                filter: (node) => node.type !== "Comment",
                collapseContent: true,
              }
            );
            xml = JSON.stringify({ xml });
            console.log(xml);
            return res.send(xml);
          }
          if (vehicle.vehicleDataFormat === "ITRI") {
            return res.send(vehicle.itriVehicleConfig);
          }
          return res.status(404).send({ message: "Vehicle config not found" });
        } catch (error) {
          console.log(error);
          return res.status(400).send(error);
        }
      },
    },
  ],
  fields: [
    ...ComboField(
      {
        name: "id",
        label: "Vehicle ID",
        admin: { readOnly: true },
      },
      ["vehicleDataFormat", "name"],
      {
        initial: "",
        separator: "-",
        callback: (field) =>
          field
            .toLowerCase()
            .replace("openscenario", "osc")
            .replace(/[^a-z0-9]/g, "-"),
      }
    ),
    {
      name: "name",
      type: "text",
      label: "Vehicle Model",
      required: true,
      access: {
        update: () => false,
      },
    },
    {
      name: "vehicleDataFormat",
      type: "select",
      label: "Vehicle Data Format",
      options: ["OpenSCENARIO", "ITRI", "Other"],
    },
    {
      name: "openScenarioVehicleConfig",
      type: "code",
      label: "OpenSCENARIO Vehicle Config",
      admin: {
        condition: (_, siblingData) =>
          siblingData.vehicleDataFormat === "OpenSCENARIO",
        language: "xml",
        editorOptions: {
          formatOnPaste: true,
          formatOnType: true,
          autoIndent: "advanced",
          folding: true,
          tabCompletion: "on",
          tabSize: 4,
        },
      },
      hooks: {
        beforeValidate: [
          ({ value }) => {
            return value
              ? xmlFormat.minify(value, {
                  filter: (node) => node.type !== "Comment",
                  collapseContent: true,
                })
              : "";
          },
        ],
        afterRead: [({ value }) => (value ? xmlFormat(value) : "")],
      },
    },
    {
      name: "itriVehicleConfig",
      type: "group",
      label: "ITRI Vehicle Config",
      admin: {
        condition: (_, siblingData) => siblingData.vehicleDataFormat === "ITRI",
      },
      fields: [
        {
          name: "dragCoefficient",
          type: "number",
          label: "Drag Coefficient",
          defaultValue: 0.36,
          required: true,
        },
        {
          name: "frontAxis",
          type: "number",
          label: "Front Axis",
          required: true,
        },
        {
          name: "frontStiffness",
          type: "number",
          label: "Front Stiffness",
          defaultValue: 150000,
          required: true,
        },
        {
          name: "rearAxis",
          type: "number",
          label: "Rear Axis",
          required: true,
        },
        {
          name: "RearStiffness",
          type: "number",
          label: "Rear Stiffness",
          defaultValue: 150000,
          required: true,
        },
        {
          name: "mass",
          type: "number",
          label: "Mass",
          required: true,
        },
        {
          name: "length",
          type: "number",
          label: "Length",
          required: true,
        },
        {
          name: "width",
          type: "number",
          label: "Width",
          required: true,
        },
        {
          name: "longitudinalOffset",
          type: "number",
          label: "Longitudinal Offset",
          required: true,
        },
        {
          name: "epsModel",
          type: "group",
          label: "EPS Model",
          fields: [
            {
              name: "r1",
              type: "group",
              label: "Row 1",
              fields: [
                {
                  name: "c11",
                  type: "number",
                  label: "Column 1",
                  defaultValue: 64.0,
                  required: true,
                },
              ],
            },
            {
              name: "r2",
              type: "group",
              label: "Row 2",
              fields: [
                {
                  name: "c21",
                  type: "number",
                  label: "Column 1",
                  defaultValue: 1.0,
                  required: true,
                },
                {
                  name: "c22",
                  type: "number",
                  label: "Column 2",
                  defaultValue: 16.0,
                  required: true,
                },
                {
                  name: "c23",
                  type: "number",
                  label: "Column 3",
                  defaultValue: 64.0,
                  required: true,
                },
              ],
            },
          ],
        },
      ],
    },
  ],
};

export default Vehicles;
function getUrl(arg0: string): string {
  throw new Error("Function not implemented.");
}
