import { Endpoint } from "payload/config";
import { PaginatedDocs } from "payload/database";
import { File } from "payload/dist/uploads/types";
import { Observation, Trial } from "payload/generated-types";

export const helloWorld: Endpoint = {
  path: "/helloWorld",
  method: "get",
  handler: async (req, res, next) => {
    try {
      const data = await fetch(process.env.PAYLOAD_ANALYSIS_API).then(
        (response) => response.json()
      );
      return res.status(200).send(data);
    } catch (error) {
      console.error(error);
      return res.status(400).send({ message: error.message });
    }
  },
};

export const clusteringMethods = ["hdbscan", "hdbscan_flat", "cmeans"] as const;
export type ClusteringMethod = (typeof clusteringMethods)[number];
export const clusteringSpaces = ["umap", "mds", "original", "pca"] as const;
export type ClusteringSpace = (typeof clusteringSpaces)[number];
type ClusterTask = {
  space: ClusteringSpace;
  method: ClusteringMethod;
  nClusters: number;
};
type ClustersRequestBody = {
  tasks: ClusterTask[];
  trialIds: string[];
  features: string[];
  metric: string;
};
type Cluster = {
  label: string;
  probability: number;
  embedding: number[];
};
export type ClustersResponseData = {
  method: ClusteringMethod;
  space: ClusteringSpace;
  nClusters: number;
  data: Cluster[];
  featureImportances: {
    [cluster: string]: { fValue: number; pValue: number }[];
  };
  anova: {
    [cluster: string]: {
      [cluster: string]: { fValue: number; pValue: number }[];
    };
  };
  pca?: {
    explainedVarianceRatio: number[];
  };
  calinskiHarabazScore: number;
  silhouetteScore: number;
  daviesBouldinScore: number;
  gapStatisticScore: number;
  sDbwScore: number;
  dbcvScore: number;
};
export const cluster: Endpoint = {
  path: "/cluster",
  method: "post",
  handler: async (req, res, _next) => {
    try {
      const requestBody = req.body as ClustersRequestBody;
      const trialIds = requestBody["trialIds"];

      let promises: Promise<Trial>[] = [];
      for (const trialId of trialIds) {
        promises.push(
          req.payload.findByID({
            collection: "trials",
            id: trialId,
            depth: 0,
          })
        );
      }

      let trials: Trial[] = null;
      await Promise.all(promises)
        .then((results) => {
          trials = results;
        })
        .catch((error) => {
          return res.status(400).send({
            error: "some of the trials are failed to find",
          });
        });

      const samplingPeriod = 0.15; // Should be adjustable
      const twoSecondsIndexStep = Math.floor(2 / samplingPeriod);

      const observationIdMapping: { [id: string]: Observation } = {};
      const trialsObservationIds: { [key: string]: string }[] = [];

      console.time("observations");
      if (requestBody.metric === "ttc_min") {
        const getWorstObservation = async (trial: Trial) => {
          const trialWithDepth = await req.payload.findByID({
            collection: "trials",
            id: trial.id,
          });
          const observations = trialWithDepth.observations as Observation[];

          // const observations = await req.payload
          //   .find({
          //     collection: "observations",
          //     where: { trial: { equals: trial.id } },
          //     depth: 0,
          //   })
          //   .then((response) => response.docs);

          // const promises = [] as Promise<Observation>[];
          // for (const observationId of trial.observations) {
          //   promises.push(
          //     req.payload.findByID({
          //       collection: "observations",
          //       id: observationId as string,
          //     })
          //   );
          // }
          // const worstObservation = await Promise.all(promises).then(
          //   (observations) => {
          //     observations.sort(
          //       (a, b) =>
          //         Math.min(...a.agents.map((agent) => agent.ttc)) -
          //         Math.min(...b.agents.map((agent) => agent.ttc))
          //     );
          //     const worstObservation = observations[0];
          //     return worstObservation;
          //   }
          // );

          observations.sort(
            (a, b) =>
              Math.min(...a.agents.map((agent) => agent.ttc)) -
              Math.min(...b.agents.map((agent) => agent.ttc))
          );
          const worstObservation = observations[0];
          const observationIds: { [key: string]: string } = {};
          observationIds["worst"] = worstObservation.id;
          trialsObservationIds[trial.id] = observationIds;
          return worstObservation;
        };
        // const worstObservationsPromises: Promise<Observation>[] = [];
        for (const trial of trials) {
          console.time("worst observation");
          const worstObservation = await getWorstObservation(trial);
          observationIdMapping[worstObservation.id] = worstObservation;
          console.timeEnd("worst observation");
          // worstObservationsPromises.push(getWorstObservation(trial));
        }

        // await Promise.all(worstObservationsPromises)
        //   .then((results) => {
        //     for (const result of results) {
        //       observationIdMapping[result.id] = result;
        //     }
        //   })
        //   .catch((error) => {
        //     return res.status(400).send({
        //       error: "some of the trials are failed to find",
        //     });
        //   });

        // return res.status(400).send({ message: "not supported" });
        // if (requestBody.metric === "ttc_min") {
        //   console.time("trialWithDepth");
        //   const trialWithDepth = await req.payload.findByID({
        //     collection: "trials",
        //     id: trial.id,
        //   });
        //   const observations = trialWithDepth.observations as Observation[];
        //   observations.sort(
        //     (a, b) =>
        //       Math.min(...a.agents.map((agent) => agent.ttc)) -
        //       Math.min(...b.agents.map((agent) => agent.ttc))
        //   );
        //   observationIds["worst"] = observations[0].id;
        //   const dummyAsyncGetObservation = async () => {
        //     return observations[0];
        //   };
        //   observationPromises.push(dummyAsyncGetObservation());
        //   console.timeEnd("trialWithDepth");
        // }
      } else {
        const observationPromises: Promise<Observation>[] = [];
        for (const trial of trials) {
          const observationIds: { [key: string]: string } = {};
          for (const feature of requestBody.features) {
            if (
              !("worst" in observationIds) &&
              feature.includes("worst") &&
              trial.observations
            ) {
              const observationId = trial.observations[
                trial.observations.length - 1
              ] as string;
              observationIds["worst"] = observationId;
              observationPromises.push(
                req.payload.findByID({
                  collection: "observations",
                  id: observationId,
                })
              );
            }
            if (
              !("2SecondsBeforeWorst" in observationIds) &&
              feature.includes("2SecondsBeforeWorst") &&
              trial.observations
            ) {
              const observationId = trial.observations[
                trial.observations.length - 1 - twoSecondsIndexStep
              ] as string;
              observationIds["2SecondsBeforeWorst"] = observationId;
              observationPromises.push(
                req.payload.findByID({
                  collection: "observations",
                  id: observationId,
                  depth: 0,
                })
              );
            }
          }
          trialsObservationIds.push(observationIds);
        }

        await Promise.all(observationPromises)
          .then((results) => {
            for (const result of results) {
              observationIdMapping[result.id] = result;
            }
          })
          .catch((error) => {
            return res.status(400).send({
              error: "some of the trials are failed to find",
            });
          });
      }
      console.timeEnd("observations");

      console.time("trial observation and x");
      const trialObservationMapping: {
        [trialId: string]: { [snapshotType: string]: Observation };
      } = {};
      const usedTrialIds: string[] = [];
      const x: number[][] = [];
      for (
        let trialIndex = 0;
        trialIndex < trialsObservationIds.length;
        trialIndex++
      ) {
        const trialObservationIds = trialsObservationIds[trialIndex];
        const row: number[] = [];
        const trialObservation: { [snapshotType: string]: Observation } = {};
        let failed = false;
        for (const feature of requestBody.features) {
          if (failed) {
            break;
          }
          let observation: Observation | null = null;
          let snapshotType = "";
          if (feature.includes("worst")) {
            observation = observationIdMapping[trialObservationIds["worst"]];
            snapshotType = "worst";
            trialObservation[snapshotType] = observation;
          } else if (feature.includes("2SecondsBeforeWorst")) {
            observation =
              observationIdMapping[trialObservationIds["2SecondsBeforeWorst"]];
            snapshotType = "2SecondsBeforeWorst";
            trialObservation[snapshotType] = observation;
          }
          if (!observation) {
            console.log("Observation FAILED");
            failed = true;
            continue;
          }
          if (feature.includes("ego")) {
            const key = feature.replace(snapshotType + "_", "");
            row.push(observation[key]);
          } else {
            const agentKey = feature.replace(snapshotType + "_", "");
            let [agentName, key] = agentKey.split("_");
            key = key.charAt(0).toLowerCase() + key.slice(1);
            const agent = observation.agents.find(
              (agent) => agent.name === agentName
            );
            if (!agent) {
              console.log("agent FAILED");
              failed = true;
              continue;
            }
            row.push(agent[key]);
          }
        }
        if (!failed) {
          x.push(row);
          usedTrialIds.push(trials[trialIndex].id);
          trialObservationMapping[trials[trialIndex].id] = trialObservation;
        }
      }
      console.timeEnd("trial observation and x");

      console.time("analysis cluster");
      const data: ClustersResponseData[] = await fetch(
        process.env.PAYLOAD_ANALYSIS_API + "/cluster_list",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            x,
            tasks: requestBody.tasks,
          }),
        }
      ).then((response) => response.json());
      console.timeEnd("analysis cluster");

      return res.status(200).send({
        data: data,
        trialObservations: usedTrialIds.map(
          (trialId) => trialObservationMapping[trialId as string]
        ),
      });
    } catch (error) {
      return res.status(400).send({ message: error.message });
    }
  },
};

async function streamToBuffer(
  stream: ReadableStream<Uint8Array>
): Promise<Buffer> {
  const reader = stream.getReader();
  const chunks: Uint8Array[] = [];

  try {
    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      if (value) {
        chunks.push(value);
      }
    }
    // Concatenate all Uint8Array chunks into one Uint8Array
    const totalLength = chunks.reduce((acc, chunk) => acc + chunk.length, 0);
    const concatenated = new Uint8Array(totalLength);
    let offset = 0;
    for (const chunk of chunks) {
      concatenated.set(chunk, offset);
      offset += chunk.length;
    }
    // Convert Uint8Array to Buffer
    const buffer = Buffer.from(concatenated);
    return buffer;
  } finally {
    reader.releaseLock();
  }
}
type DendrogramRequestBody = {
  x: number[][];
};
export const dendrogram: Endpoint = {
  path: "/dendrogram",
  method: "post",
  handler: async (req, res, next) => {
    try {
      const requestBody = req.body as DendrogramRequestBody;
      const response = await fetch(
        process.env.PAYLOAD_ANALYSIS_API + "/dendrogram",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestBody),
        }
      );

      const buffer = await streamToBuffer(response.body);
      const file: File = {
        data: buffer,
        mimetype: "image/png",
        name: "dendrogram.png",
        size: buffer.length,
      };

      try {
        await req.payload.delete({
          collection: "media",
          where: {
            filename: { like: "dendrogram" },
          },
        });
      } catch (error) {
        console.error(error.message);
      }

      const image = await req.payload.create({
        collection: "media",
        file: file,
        data: {},
      });
      return res.status(200).send(image);
    } catch (error) {
      console.error(error);
      return res.status(400).send({ message: error.message });
    }
  },
};

type AnovaRequestBody = {
  features: string[];
  groups: { [cluster: number]: { [feature: string]: number[] } };
};
export const anova: Endpoint = {
  path: "/anova",
  method: "post",
  handler: async (req, res, next) => {
    try {
      const requestBody = req.body as AnovaRequestBody;
      const data = await fetch(process.env.PAYLOAD_ANALYSIS_API + "/anova", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(requestBody),
      }).then((response) => response.json());
      return res.status(200).send(data);
    } catch (error) {
      console.error(error);
      return res.status(400).send({ message: error.message });
    }
  },
};
