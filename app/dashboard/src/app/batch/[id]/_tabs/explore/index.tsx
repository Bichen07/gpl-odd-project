import { A } from "ts-toolbelt";
import { getTrials } from "@/app/_shared/graphql/queries/trials";
import Dock from "./components/dock";
import {
  Batch,
  getBatch,
  getTrajectoryAnalysisSaves,
  SavedTrajectoryAnalysis,
} from "@/app/_shared/graphql/queries/batches";

type Props = {
  batchId: string;
  savedFilename?: string;
};
export default async function Explore(props: Props) {
  const { batchId } = props;

  let saves: SavedTrajectoryAnalysis = null;
  let batch: Batch = null;
  let trials: A.Await<ReturnType<typeof getTrials>> = [];
  try {
    trials = await getTrials({
      limit: 0,
      where: {
        // @ts-ignore
        batch: {
          equals: Number(batchId),
        },
      },
    });
    batch = await getBatch({ id: Number(batchId) });
    saves = await getTrajectoryAnalysisSaves(Number(batchId));
    console.log(saves);
  } catch (err) {
    console.error(err);
  }

  return <Dock batchId={batchId} saves={saves} trials={trials} batch={batch} />;
}
