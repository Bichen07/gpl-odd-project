import TableModal from "src/components/TableModal";
import TrialTable from "../../TrialTable";

type Props = {
  open: boolean;
  kpiId?: string;
  passed?: boolean;
  onClose: () => void;
};
export default ({ open, onClose, kpiId, passed }: Props) => {
  return (
    <TableModal open={open} onClose={onClose}>
      <TrialTable kpiId={kpiId} passed={passed} />
    </TableModal>
  );
};
