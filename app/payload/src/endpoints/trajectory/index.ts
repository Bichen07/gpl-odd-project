import { Endpoint } from "payload/config";
import { EsminiCsv, Trial } from "payload/generated-types";
import pl from "nodejs-polars";
import { fromCSV, op, table } from "arquero";

export type TrajectoryData = {
  time: number[];
  x: number[];
  y: number[];
  h: number[];
};
export type TrajectoryItem = {
  trialId: string;
  actors: { [actor: string]: TrajectoryData };
};
export type TrajectoryResponseData = {
  fetchFailedTrialIds: string[];
  data: TrajectoryItem[];
};
export type TrajectoryQuery = {
  trialId: string;
  esminiStartSeconds?: number;
  esminiEndSeconds?: number;
};
export type RequestBody = {
  queries: TrajectoryQuery[];
};
export const trajectories: Endpoint = {
  path: "/trajectories",
  method: "post",
  handler: async (req, res, _next) => {
    try {
      const requestBody = req.body as RequestBody;
      const queries = requestBody.queries;

      const getTrajectoryItem = async (query: TrajectoryQuery) => {
        const trial = await req.payload.findByID({
          collection: "trials",
          id: query.trialId,
          depth: 1,
        });
        const esminiCsv = trial.esminiCsv as EsminiCsv;
        if (!esminiCsv) {
          console.error(`[Error] Trial: ${trial.id}, No EsminiCsv`);
          return trial.id as string;
        }
        try {
          const fileUrl = esminiCsv.url;
          // try {
          //   let response = await fetch(fileUrl);
          // } catch (error) {
          //   console.log(error);
          //   console.log(fileUrl);
          //   console.log("HELP");
          // }
          let response = await fetch(fileUrl);
          let data = await response.text();
          let dt = fromCSV(data, {
            skip: data.slice(0, 10).includes("Version") ? 1 : 0,
          });
          const columnNames = dt.columnNames();
          const renameObject = columnNames.reduce((acc, col) => {
            acc[col] = col.trim();
            return acc;
          }, {});
          dt = dt.rename(renameObject);
          if (query.esminiStartSeconds) {
            dt = dt
              .params({ s: query.esminiStartSeconds })
              .filter((d: any, $: any) => d.time >= $.s);
          }
          if (query.esminiEndSeconds) {
            dt = dt
              .params({ s: query.esminiEndSeconds })
              .filter((d: any, $: any) => d.time < $.s);
          }
          const names: string[] = dt.groupby("name").count().column("name")[
            "data"
          ];
          const item: TrajectoryItem = { trialId: trial.id, actors: {} };
          for (const name of names) {
            const data = dt
              .params({ n: name })
              .filter((d: any, $: any) => op.equal(d.name, $.n));
            let indices = Array.from(
              { length: data.numRows() },
              (_value, index) => index
            );
            let indicesTable = table({ index: indices });
            const newData = data
              .assign(indicesTable)
              .filter((d: any) => op.equal(d.index % 5, 0))
              .select("time", "x", "y", "h");
            item.actors[name] = JSON.parse(newData.toJSON({ schema: false }));
          }
          return item;
        } catch (error) {
          console.error(`[Error] Trial: ${trial.id}, ${error.message}`);
          return trial.id as string;
        }
      };

      const result: TrajectoryResponseData = {
        fetchFailedTrialIds: [],
        data: [],
      };
      for (const query of queries) {
        try {
          const item = await getTrajectoryItem(query);
          console.log("SUCCCESS");
          if (typeof item !== "string") {
            console.log(item.trialId);
            result.data.push(item);
          }
        } catch (error) {
          console.log("FAILED");
          console.log(error);
          result.fetchFailedTrialIds.push(error);
          continue;
        }
      }

      // const promises: Promise<TrajectoryItem | string>[] = [];
      // for (const query of queries) {
      //   promises.push(getTrajectoryItem(query));
      // }
      //
      // const result: TrajectoryResponseData = {
      //   fetchFailedTrialIds: [],
      //   data: [],
      // };
      // console.time("getall");
      // await Promise.all(promises)
      //   .then((items) => {
      //     for (const item of items) {
      //       if (typeof item === "string") {
      //         continue;
      //       }
      //       console.log("SUCCCESS");
      //       console.log(item.trialId);
      //       result.data.push(item);
      //     }
      //   })
      //   .catch((error) => {
      //     console.log("FAILED");
      //     console.log(error);
      //     result.fetchFailedTrialIds.push(error);
      //   });
      // console.timeEnd("getall");

      // console.log(result);
      return res.status(200).send(result);
    } catch (error) {
      console.log(400);
      return res.status(400).send({ message: error.message });
    }
  },
};
