import { Endpoint } from "payload/config";
import { EsminiCsv, Observation } from "payload/generated-types";
import { fromCSV, op, table } from "arquero";

async function withConcurrencyLimit(limit: number, tasks: any[]) {
  const semaphore = Array(limit).fill(Promise.resolve());
  const results = [];

  for (const task of tasks) {
    const current = semaphore.shift();

    semaphore.push(
      current.then(async () => {
        const result = await task();
        results.push(result);
      })
    );
  }

  await Promise.all(semaphore);
  return results;
}

export type TrajectoryData = {
  time: number[];
  x: number[];
  y: number[];
  h: number[];
  speed: number[];
};
export type TrajectoryItem = {
  trialId: string;
  actors: { [actor: string]: TrajectoryData };
};
export type TrajectoryResponseData = {
  fetchFailedTrialIds: string[];
  data: TrajectoryItem[];
};
export type RequestBody = {
  trialIds: string[];
  secondsBefore?: number;
};
export const collisionTrajectories: Endpoint = {
  path: "/collisionTrajectories",
  method: "post",
  handler: async (req, res, _next) => {
    try {
      const requestBody = req.body as RequestBody;

      const getTrajectory = async (trialId: string) => {
        try {
          const trial = await req.payload.findByID({
            collection: "trials",
            id: trialId,
            depth: 1,
          });
          const esminiCsv = trial.esminiCsv as EsminiCsv;
          if (!esminiCsv) {
            console.error(`[Error] Trial: ${trial.id}, No EsminiCsv`);
            return trial.id as string;
          }
          const fileUrl = esminiCsv.url;
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
          if (requestBody.secondsBefore) {
            const lastTime: number = dt.get("time", dt.numRows() - 1);
            dt = dt
              .params({ s: requestBody.secondsBefore, l: lastTime })
              .filter((d: any, $: any) => $.l - d.time <= $.s);
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
          console.log("SUCCESS");
          console.log(trialId);
          return item;
        } catch (error) {
          console.log(error);
          return trialId;
        }
      };

      const tasks = requestBody.trialIds.map(
        (trialId) => () => getTrajectory(trialId)
      );
      const result: TrajectoryResponseData = {
        fetchFailedTrialIds: [],
        data: [],
      };
      console.time("timer");
      await withConcurrencyLimit(10, tasks).then((items) => {
        for (const item of items) {
          if (typeof item == "string") {
            result.fetchFailedTrialIds.push(item);
          }
          result.data.push(item);
        }
      });
      console.timeEnd("timer");

      return res.status(200).send(result);
    } catch (error) {
      return res.status(400).send({ message: error.message });
    }
  },
};
