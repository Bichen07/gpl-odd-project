import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { setModalOpen } from "src/redux/slices/trialFilters";
import Table from "./Table";
import TableModal from "src/components/TableModal";

export default () => {
  const dispatch = useAppDispatch();
  const open = useAppSelector((state) => state.trialFilters.modalOpen);
  return (
    <TableModal open={open} onClose={() => dispatch(setModalOpen(false))}>
      <Table />
    </TableModal>
  );
};
