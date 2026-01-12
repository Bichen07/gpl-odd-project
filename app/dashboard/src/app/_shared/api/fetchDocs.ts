// import { RequestCookie } from "next/dist/compiled/@edge-runtime/cookies";
// const queryMap: { [collection: string]: { query: any, key: string } = {
//   // sessions: {
//   //   query: Sessions
//   // }
//   // pages: {
//   //   query: PAGES,
//   //   key: "Pages",
//   // },
// };
//
// export const fetchDocs = async <T>(
//   collection: keyof typeof queryMap,
//   variables: {
//     slug?: string;
//     id?: string;
//     locale?: string;
//     draft?: boolean;
//     limit?: number;
//     page?: number;
//     sort?: string;
//     where?: Record<string, unknown>;
//   },
// ): Promise<{ docs: T[]; limit: any; totalPages: any }> => {
//   const { draft, locale } = variables || {};
//   if (!queryMap[collection])
//     throw new Error(`Collection ${collection} not found`);
//   else {
//     variables.locale = "tw";
//   }
//   let token: RequestCookie | undefined;
//
//   if (draft) {
//     const { cookies } = await import("next/headers");
//     const cookieStore = await cookies();
//     token = cookieStore.get("payload-token");
//   }
//
//   const docs: { docs: T[]; limit: any; totalPages: any } = await fetch(
//     `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/graphql`,
//     {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         ...(token?.value && draft
//           ? { Authorization: `JWT ${token.value}` }
//           : {}),
//       },
//       next: { tags: [collection] },
//       body: JSON.stringify({
//         query: queryMap[collection].query,
//         variables,
//       }),
//     },
//   )
//     ?.then((res) => res.json())
//     ?.then((res) => {
//       if (res.errors)
//         throw new Error(res?.errors?.[0]?.message ?? "Error fetching docs");
//       return {
//         docs: res?.data?.[queryMap[collection].key]?.docs,
//         limit: res?.data?.[queryMap[collection].key]?.limit,
//         totalPages: res?.data?.[queryMap[collection].key]?.totalPages,
//       };
//     });
//
//   return docs;
// };
