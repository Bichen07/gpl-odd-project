import { useQuery } from "@tanstack/react-query";
import { KeyPerformanceIndicators } from "src/__generated__/graphql";
import { getDocs } from "src/api/common";
import { toast } from "react-toastify";

const MAX_KPI_COUNT = 10000;

export const useKpis = (queryKey?: any[]) => {
  const response = useQuery({
    queryKey: queryKey ?? [],
    queryFn: async () =>
      await getDocs<KeyPerformanceIndicators>("keyPerformanceIndicators", {
        limit: MAX_KPI_COUNT,
      }).then((response) => response.data),
  });

  const { isError, error } = response;

  if (isError) {
    console.error(error);
    toast.error("Failed to fetch KPIs!");
  }

  return response;
};
