import React, { useEffect, useState, useCallback } from "react";
import { useFormFields } from "payload/components/forms";
import "./styles.scss";
import requestFilter from "../../utils/requestFilter";
import { ScenarioBrief } from "../../types";
import { Fields } from "payload/types";
import _ from "lodash";

const getTagTreeFiltersFromSiblingField = (
  field: Fields,
  status: "interested" | "unwanted" | "required"
) => {
  const keys = Object.keys(field)
    .filter(
      (key) =>
        key.includes(status + ".") &&
        key.includes("tagTrees") &&
        !key.includes("id")
    )
    .map((key) => key.split(".").slice(3).join("."))
    .sort();

  let numberOfTagTrees = 0;
  for (const key of keys) {
    numberOfTagTrees = Math.max(
      Number(key.split(".")[0]) + 1,
      numberOfTagTrees
    );
  }

  const result: any[] = [];
  for (
    let tagTreeIndex = 0;
    tagTreeIndex < numberOfTagTrees;
    tagTreeIndex++
  ) {
    let numberOfActors = 0;
    for (const key of keys) {
      if (key.includes("actors")) {
        const splits = key.split(".");
        if (splits.length <= 2) {
          continue;
        }
        numberOfActors = Math.max(
          Number(splits[2]) + 1,
          numberOfActors
        );
      }
    }
    const tagTree: any = { actors: [] };
    for (const key of keys) {
      const splits = key.split(".");
      if (Number(splits[0]) !== tagTreeIndex) {
        continue;
      }
      const fieldValue = field[`filter.tagTrees.${status}.${key}`].value;
      if (!fieldValue) {
        continue;
      }
      if (key.includes("actors")) {
        if (splits.length <= 2) {
          continue;
        }
        const actorIndex = Number(splits[2]);
        const keyInTagTreeActors = key.replace(
          `${tagTreeIndex}.actors.${actorIndex}.`,
          ""
        );
        if (tagTree.actors[actorIndex] === undefined) {
          tagTree.actors[actorIndex] = {};
        }
        _.set(
          tagTree.actors[actorIndex],
          keyInTagTreeActors,
          fieldValue
        );
        continue;
      } else {
        const keyInTagTree = key.replace(`${tagTreeIndex}.`, "");
        _.set(tagTree, keyInTagTree, fieldValue);
      }
    }
    result.push(tagTree);
  }
  return result;
};

/**
 * Renders a preview field that displays a filtered scenario list
 * based on the selected tags and tagTrees.
 */
const PreviewField: React.FC = () => {
  const siblingField = useFormFields(([fields, dispatch]) => fields);

  const [scenarioBriefs, setScenarioBriefs] = useState<ScenarioBrief[]>([]);
  const [filterPattern, setFilterPattern] = useState({
    tags: {
      interested: "",
      unwanted: "",
      required: "",
    },
    tagTrees: {
      interested: [],
      unwanted: [],
      required: [],
    },
  });

  const updateFilterPattern = useCallback(
    _.debounce((siblingField) => {
      const interestedTags =
        (
          siblingField["filter.tags.interested"].value as String[]
        )?.join(",") || " ";
      const unwantedTags =
        (siblingField["filter.tags.unwanted"].value as String[])?.join(
          ","
        ) || " ";
      const requiredTags =
        (siblingField["filter.tags.required"].value as String[])?.join(
          ","
        ) || " ";
      const newFilterPattern = {
        tags: {
          interested: (interestedTags as string).trim(),
          unwanted: (unwantedTags as string).trim(),
          required: (requiredTags as string).trim(),
        },
        tagTrees: {
          interested: getTagTreeFiltersFromSiblingField(
            siblingField,
            "interested"
          ),
          unwanted: getTagTreeFiltersFromSiblingField(
            siblingField,
            "unwanted"
          ),
          required: getTagTreeFiltersFromSiblingField(
            siblingField,
            "required"
          ),
        },
      };
      if (!_.isEqual(filterPattern, newFilterPattern)) {
        setFilterPattern(newFilterPattern);
      }
    }, 300),
    [filterPattern]
  );

  useEffect(() => {
    updateFilterPattern(siblingField);
  }, [siblingField]);

  useEffect(() => {
    const updateScenarioList = async () => {
      const briefs = await requestFilter({
        value: filterPattern,
        field: "brief",
      });
      setScenarioBriefs(briefs);
    };
    updateScenarioList();
  }, [filterPattern]);

  return (
    <div>
      <br />
      <hr />
      {scenarioBriefs.length === 0 && (
        <span className="scenario-list-label not-found">
          No scenarios found.
        </span>
      )}
      {scenarioBriefs.length > 0 && (
        <div id="scenario-list">
          <span className="scenario-list-label">
            Filtered Scenario List ({scenarioBriefs.length}) -{" "}
          </span>
          {scenarioBriefs
            .sort((a, b) => a.id.localeCompare(b.id))
            .map((scenario, index) => (
              <span
                className="scenario"
                key={index}
                title={scenario.tags
                  .sort()
                  .map((tag: string) => "tag: " + tag)
                  .join("\n")}
              >
                {scenario.id}
              </span>
            ))}
        </div>
      )}
      <hr />
      <br />
    </div>
  );
};

export default PreviewField;
