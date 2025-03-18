import { NumericFormat, NumericFormatProps } from "react-number-format";
import { TextField, TextFieldProps } from "@mui/material";

export type NumberInputProps = NumericFormatProps<TextFieldProps>;

export default function NumericInput(props: NumberInputProps) {
  return <NumericFormat customInput={TextField} {...props} />;
}
