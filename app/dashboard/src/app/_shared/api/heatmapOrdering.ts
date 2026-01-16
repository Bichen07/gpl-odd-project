export const heatmapOrdering = async <T>(body: {
  [label: string]: { [trialId: string]: number[] };
}): Promise<{ [label: string]: string[] }> => {
  const docs: { [label: string]: string[] } = await fetch(
    `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/heatmap_ordering`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    }
  )
    ?.then((res) => res.json())
    ?.then((res) => {
      if (res.errors)
        throw new Error(
          res?.errors?.[0]?.message ?? "Error fetching heatmap ordering"
        );
      return res;
    });

  return docs;
};
