import { redirect } from "next/navigation";

export default async function Page({
  params,
  searchParams,
}: {
  params?: Promise<any>;
  searchParams?: Promise<any>;
}) {
  const { id } = await params;
  const sp = (await searchParams) ?? {};
  const query = new URLSearchParams();
  if (sp.ego) query.set("ego", String(sp.ego));
  if (sp.k) query.set("k", String(sp.k));
  if (sp.s) query.set("s", String(sp.s));
  query.set("section", "medoid");
  redirect(`/batch/${id}?${query.toString()}`);
}
