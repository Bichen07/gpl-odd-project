import { Access } from "payload/config";
import { FieldAccess } from "payload/types";

export const usersAccess: Access = ({ req: { user } }) => {
  if (user) {
    return true;
  }
  return false;
};

export const selfAccess: Access = ({ data, id, req: { user } }) => {
  return user && (id === user.id || user.role === "admin");
};

export const selfFieldAccess: FieldAccess = ({ data, id, req: { user } }) => {
  return user && (id === user.id || user.role === "admin");
};

export const developerAccess: Access = ({ req: { user } }) => {
  return user && (user.role === "admin" || user.role === "developer");
};
export const developerFieldAccess: FieldAccess = ({ req: { user } }) => {
  return user && (user.role === "admin" || user.role === "developer");
};

export const adminAccess: Access = ({ req: { user } }) => {
  return user && user.role === "admin";
};
export const adminFieldAccess: FieldAccess = ({ req: { user } }) => {
  return user && user.role === "admin";
};
