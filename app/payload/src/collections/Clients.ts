import { CollectionConfig } from "payload/types";
import { TelephoneField } from "@nouance/payload-better-fields-plugin";
import { ComboField } from "@nouance/payload-better-fields-plugin";
import { usersAccess } from "../access";

const Clients: CollectionConfig = {
  slug: "clients",
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
  fields: [
    ...ComboField(
      {
        name: "id",
        label: "Client ID",
        admin: { readOnly: true },
      },
      ["clientId"],
      {
        initial: "client-",
        callback: (field) => field.toLowerCase().replace(/[^a-z0-9]/g, "-"),
      }
    ),
    {
      name: "name",
      type: "text",
      label: "Client Name",
      required: true,
    },
    {
      name: "clientId",
      type: "text",
      label: "Client ID",
      required: true,
      admin: {
        placeholder: "Unique identifier for the company",
      },
      minLength: 3,
      access: {
        update: () => false,
      },
    },
    {
      name: "email",
      type: "email",
      label: "Email",
      required: true,
    },
    {
      name: "taxID",
      type: "text",
      label: "Tax ID",
      required: false,
    },
    {
      name: "address",
      type: "text",
      label: "Address",
      required: false,
    },
    ...TelephoneField({
      name: "phone",
      label: "Phone",
      admin: {
        placeholder: "+886 1 234 5678",
      },
    }),
    {
      name: "autonomousSystems",
      type: "array",
      label: "Autonomous Systems",
      fields: [
        {
          name: "id",
          type: "text",
          access: {
            update: () => false,
          },
        },
        {
          name: "systemName",
          type: "text",
          label: "System Name",
          required: true,
        },
        {
          name: "alias",
          type: "text",
          label: "Alias",
          required: false,
        },
        {
          name: "description",
          type: "textarea",
          label: "Description",
          required: false,
        },
        {
          name: "versions",
          type: "array",
          label: "Versions",
          fields: [
            {
              name: "id",
              type: "text",
              access: {
                update: () => false,
              },
            },
            {
              name: "versionName",
              type: "text",
              label: "Version Name",
              required: true,
            },
            {
              name: "alias",
              type: "text",
              label: "Alias",
              required: false,
            },
            {
              name: "description",
              type: "textarea",
              label: "Description",
              required: false,
            },
          ],
        },
      ],
    },
  ],
};

export default Clients;
function getUrl(arg0: string): string {
  throw new Error("Function not implemented.");
}
