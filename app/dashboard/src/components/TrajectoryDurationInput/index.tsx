import Labeler from "src/components/Labeler";
import NumberInput from "src/components/NumberInput";

type Props = {
  trajectoryDuration: number;
  setTrajectoryDuration: React.Dispatch<React.SetStateAction<number>>;
};
export function TrajectoryDurationInput({
  trajectoryDuration,
  setTrajectoryDuration,
}: Props) {
  return (
    <Labeler label="trajectory duration" sx={{ input: { maxWidth: "40px" } }}>
      <NumberInput
        min={1}
        max={10}
        value={trajectoryDuration}
        onChange={(value) => {
          if (!value) {
            return;
          }
          setTrajectoryDuration(value);
        }}
        endAdornment="sec"
      />
    </Labeler>
  );
}
