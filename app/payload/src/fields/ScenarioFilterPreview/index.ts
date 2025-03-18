import { Field } from "payload/types";
import previewField from "./previewField";

const ScenarioFilterPreviewField: Field = {
    name: "color",
    type: "ui",
    admin: {
        components: {
            Field: previewField,
        },
    },
};

export default ScenarioFilterPreviewField;
