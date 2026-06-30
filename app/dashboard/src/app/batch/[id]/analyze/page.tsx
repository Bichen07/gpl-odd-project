import AnalyzeClient from "./AnalyzeClient";

export default async function Page({
  params,
  searchParams,
}: {
  params?: Promise<any>;
  searchParams?: Promise<any>;
}) {
  const { id } = await params;
  const sp = (await searchParams) ?? {};
  return (
    <AnalyzeClient
      batchId={String(id)}
      ego={String(sp.ego ?? "ITRI")}
      k={String(sp.k ?? "")}
      s={String(sp.s ?? "")}
    />
  );
}
