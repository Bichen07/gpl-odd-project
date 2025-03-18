import axios from "axios";
import { Scenario, Tag } from "payload/generated-types";
import { ScenarioBrief } from "../types";

/**
 * Filters scenarios based on the provided value and field.
 * @param value - The value to filter scenarios by.
 * @param field - The field to filter scenarios on. Can be either "id" or "name".
 * @returns An array of filtered scenarios' ids or names.
 */
async function requestFilter({
  value,
  field,
}: {
  value: any;
  field: "id";
}): Promise<string[]>;
async function requestFilter({
  value,
  field,
}: {
  value: any;
  field: "name";
}): Promise<string>;
async function requestFilter({
  value,
  field,
}: {
  value: any;
  field: "brief";
}): Promise<ScenarioBrief[]>;
async function requestFilter({
  value,
  field,
}: {
  value: any;
  field: "id" | "name" | "brief";
}) {
  try {
    // Fetching scenarios based on tags
    if (process.env.PAYLOAD_PUBLIC_API_BASEURL === undefined) {
      throw new Error(
        "PAYLOAD_PUBLIC_API_BASEURL is not set. Please set it in payload/.env file."
      );
    }
    const baseURL = process.env.PAYLOAD_PUBLIC_API_BASEURL;
    const endpoint = "/scenarios/filterByTags";
    let request = "limit=100000";
    if (value.tags.interested.trim()) {
      request += "&interested=" + value.tags.interested;
    }
    if (value.tags.required.trim()) {
      request += "&required=" + value.tags.required;
    }
    if (value.tags.unwanted.trim()) {
      request += "&unwanted=" + value.tags.unwanted;
    }
    const scenariosFilterByTags: Scenario[] = await axios({
      url: baseURL + endpoint + "?" + request,
      method: "get",
    }).then((response) => response.data.docs);

    // Fetching scenarios based on tag trees
    const scenariosFilterByTagTrees: Scenario[] = await axios({
      url: baseURL + "/scenarios/tagTreeFilter",
      method: "post",
      data: { ...value.tagTrees },
    }).then((response) => response.data);

    // Get intersected scenarios
    const scenarioIdsFilterByTags = scenariosFilterByTags.map(
      (scenario) => scenario.id
    );
    const scenarioIdsFilterByTagTrees = new Set(
      scenariosFilterByTagTrees.map((scenario) => scenario.id)
    );
    const intersectedIds = new Set(
      scenarioIdsFilterByTags.filter((id) =>
        scenarioIdsFilterByTagTrees.has(id)
      )
    );
    const intersectedScenarios = scenariosFilterByTags.filter((scenario) =>
      intersectedIds.has(scenario.id)
    );

    // Return
    if (field === "id") {
      return intersectedScenarios.map((scenario) => scenario.id);
    } else if (field === "brief") {
      return intersectedScenarios.map((scenario) => ({
        id: scenario.id,
        tags: scenario?.tags?.map((tag: Tag) => tag.name) ?? [],
      }));
    } else {
      return intersectedScenarios.map((scenario) => scenario.id).join(",");
    }
  } catch (error) {
    console.error("Error:", error);
    return field === "id" ? [] : "";
  }
}

export default requestFilter;
