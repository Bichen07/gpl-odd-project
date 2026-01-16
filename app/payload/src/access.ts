import type { Access, FieldAccess } from 'payload'

/**
 * Allow logged-in users
 */
export const usersAccess: Access = ({ req: { user } }) => {
  return !!user
}

/**
 * Allow users to act on themselves OR admin
 */
export const selfAccess: Access = ({ id, req: { user } }) => {
  if (!user) return false
  return id === user.id
}

/**
 * Field-level version of selfAccess
 */
export const selfFieldAccess: FieldAccess = ({ id, req: { user } }) => {
  if (!user) return false
  return id === user.id
}
