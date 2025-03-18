import { CollectionConfig } from "payload/types";
import {
  adminAccess,
  adminFieldAccess,
  selfAccess,
  selfFieldAccess,
  usersAccess,
} from "../access";

const Users: CollectionConfig = {
  slug: "users",
  auth: {
    useAPIKey: true,
  },
  admin: {
    useAsTitle: "name",
    group: "Users",
  },
  access: {
    read: () => true,
    // read: ({ req }) => {
    //   const isAdmin = req.user && req.user.role === "admin";
    //   if (isAdmin) {
    //     return true;
    //   } else {
    //     return {
    //       id: {
    //         equals: req.user.id,
    //       },
    //     };
    //   }
    // },
    create: usersAccess,
    delete: adminAccess,
    update: selfAccess,
  },
  fields: [
    {
      name: "name",
      label: "User Name",
      type: "text",
      required: true,
      access: {
        update: adminFieldAccess,
      },
    },
    {
      name: "role",
      label: "Role",
      type: "select",
      access: {
        read: selfFieldAccess,
        update: adminFieldAccess,
      },
      options: [
        { label: "Admin", value: "admin" },
        { label: "Developer", value: "developer" },
        { label: "User", value: "user" },
      ],
      defaultValue: "user",
    },
  ],
};

export default Users;
