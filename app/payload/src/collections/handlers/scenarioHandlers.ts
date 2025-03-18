import { PayloadRequest } from "payload/dist/express/types";
import { Where } from "payload/types";
import { Scenario, Tag } from "payload/generated-types";
import { PaginatedDocs } from "payload/database";
import e from "express";
import _ from "lodash";

export async function FilterByTagTree(
    req: PayloadRequest,
    res: e.Response<any, Record<string, any>>
): Promise<PaginatedDocs<Scenario>> {
    const scenarios = await req.payload
        .find({
            collection: "scenarios",
            where: req.query.where as Where,
            limit: 100000,
        })
        .then((response) => response.docs);
    const filteredScenarios: Scenario[] = [];
    const tagTreeFilter = req.query.tagTree as object;
    for (const scenario of scenarios) {
        const tagTree = scenario.tagTree;
        if (_.isMatch(tagTree, tagTreeFilter)) {
            filteredScenarios.push(scenario);
        }
    }
    const limit =
        req.query.limit && !isNaN(Number(req.query.limit))
            ? Number(req.query.limit)
            : 10;
    const page =
        req.query.limit && !isNaN(Number(req.query.page))
            ? Number(req.query.page)
            : 1;
    const totalPages = Math.ceil(filteredScenarios.length / limit);
    const startIndex = Math.max((page - 1) * limit, 0);
    const result: PaginatedDocs<Scenario> = {
        docs: filteredScenarios.slice(startIndex, startIndex + limit),
        limit,
        page,
        totalPages: Math.ceil(filteredScenarios.length / limit),
        totalDocs: filteredScenarios.length,
        pagingCounter: startIndex,
        hasNextPage: page < totalPages,
        hasPrevPage: page > 1,
    };
    return result;
}

export async function FilterByTags(
    req: PayloadRequest,
    res: e.Response<any, Record<string, any>>
): Promise<PaginatedDocs<Scenario>> {
    const scenarios = await req.payload.find({
        collection: "scenarios",
        where: req.query.where as Where,
        limit: 100000,
    });
    const interestedTags = req.query.interested
        ? (req.query.interested as string).split(",")
        : [];
    const requiredTags = req.query.required
        ? (req.query.required as string).split(",")
        : [];
    const unwantedTags = req.query.unwanted
        ? (req.query.unwanted as string).split(",")
        : [];
    const filteredScenarios: Scenario[] = [];
    for (const scenario of scenarios.docs) {
        const tags = scenario.tags?.map((tag: Tag) => tag.id) || "";
        if (
            (interestedTags.length === 0 &&
                requiredTags.length === 0 &&
                !unwantedTags.some((tag) => tags.includes(tag))) ||
            (interestedTags.length > 0 &&
                interestedTags.some((tag) => tags.includes(tag)) &&
                requiredTags.length === 0 &&
                !unwantedTags.some((tag) => tags.includes(tag))) ||
            (interestedTags.length === 0 &&
                requiredTags.length > 0 &&
                requiredTags.every((tag) => tags.includes(tag)) &&
                !unwantedTags.some((tag) => tags.includes(tag))) ||
            (interestedTags.length > 0 &&
                interestedTags.some((tag) => tags.includes(tag)) &&
                requiredTags.length > 0 &&
                requiredTags.every((tag) => tags.includes(tag)) &&
                !unwantedTags.some((tag) => tags.includes(tag)))
        ) {
            filteredScenarios.push(scenario);
        }
    }
    if (filteredScenarios.length === 0) {
        return {
            docs: [],
            limit: 10,
            page: 1,
            totalPages: 1,
            totalDocs: 0,
            pagingCounter: 0,
            hasNextPage: false,
            hasPrevPage: false,
        };
    }
    const limit =
        req.query.limit && !isNaN(Number(req.query.limit))
            ? Number(req.query.limit)
            : 10;
    const page =
        req.query.limit && !isNaN(Number(req.query.page))
            ? Number(req.query.page)
            : 1;
    const totalPages = Math.ceil(filteredScenarios.length / limit);
    const startIndex = Math.max((page - 1) * limit, 0);
    const result: PaginatedDocs<Scenario> = {
        docs: filteredScenarios.slice(startIndex, startIndex + limit),
        limit,
        page,
        totalPages: Math.ceil(filteredScenarios.length / limit),
        totalDocs: filteredScenarios.length,
        pagingCounter: startIndex,
        hasNextPage: page < totalPages,
        hasPrevPage: page > 1,
    };
    return result;
}
