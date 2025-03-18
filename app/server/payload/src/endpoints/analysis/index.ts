import { Endpoint } from "payload/config";

type PcaRequestBody = {
  x: number[][];
};
type PcaResponseData = { x: number[][]; explainedVarianceRatio: number[] };

export const analysisEndpoints: Endpoint[] = [
  {
    path: "/analysis/pca",
    method: "post",
    handler: async (req, res, next) => {
      const requestBody = req.body as PcaRequestBody;
      const x = requestBody.x;
      try {
        const response = await fetch("http://analysis:8001/pca", {
          method: "POST",
          body: JSON.stringify({ x }),
        });
        const pcaResponseData: PcaResponseData = await response.json();
        return res.status(200).send(pcaResponseData);
      } catch (error) {
        return res.status(400).send(error);
      }
    },
  },
];
