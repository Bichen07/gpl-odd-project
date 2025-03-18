#!/usr/bin/env python

# Modified from
#    @file    jtcrouter.py
#    @author  Jakob Erdmann
#    @date    2019-11-07

"""
Generate routes like jtrrouter but based on count parameters at connections
The counts are used to derive the turn file and flow file for calling jtrrouter
"""

from __future__ import absolute_import
from __future__ import print_function

import os
import sys
from argparse import ArgumentParser
from collections import defaultdict, OrderedDict
import xml.etree.ElementTree as ET
import subprocess
import json

import numpy as np

if 'SUMO_HOME' in os.environ:
    sys.path.append(os.path.join(os.environ['SUMO_HOME'], 'tools'))
    sys.path.append(os.path.join(os.environ['SUMO_HOME'], 'tools/turn-defs'))
import sumolib  # noqa

EXCEPTION_DEALING_NOTWORKING = {
    "outgoing": {},
    "incoming":{}
}

def get_options(args=None):
    parser = ArgumentParser(description="Route by turn counts.")
    parser.add_argument("-n", "--net-file", dest="net", help="Input net file.")
    parser.add_argument("-t", "--turn-file", dest="turnFile", help="Input turn-count file.")
    parser.add_argument("-v", "--vehilce-file", dest="vehicleFile", help="Input vehicle definitions.")
    parser.add_argument("-o", "--output-file", dest="out", default="out.rou.xml",
                        help="Output route file")
    parser.add_argument("-f", "--flow-output", dest="flowOutput", default="flows.tmp.xml",
                        help="Intermediate flow file")
    parser.add_argument("-b", "--begin", default=0, help="begin time")
    parser.add_argument("-e", "--end",  default=3600, help="end time (default 3600)")

    parser.add_argument("-B", "--ban", nargs='+', type=str, help="Edge to be banned from travelling."\
        " Note that negative numbers should be ")

    parser.add_argument("-m", "--ego-model", dest="egoModel", default="pacifica",
                        help="The model of ego vehicle.")
    parser.add_argument("--turn-attribute", dest="turnAttr", default="count",
                        help="Read turning counts from the given attribute")
    parser.add_argument("-p", "--count-param", dest="countParam", default=3,
                        help="The amount to split each turn data.")
    parser.add_argument("--discount-sources", "-D",  action="store_true", default=False, dest="discountSources",
                        help="passes option --discount-sources to jtrrouter")
    parser.add_argument("--prefix", dest="prefix", default="",
                        help="prefix for the flow ids")
    parser.add_argument("-a", "--attributes", dest="flowattrs", default="",
                        help="additional flow attributes")
    parser.add_argument("-r", "--random",  action="store_true", help="random option for duarouter")
    parser.add_argument("-s", "--seed",  default=0, help="random seed for duarouter")
    options = parser.parse_args(args=args)
    if options.net is None:
        parser.print_help()
        sys.exit()
    if options.flowattrs and options.flowattrs[0] != ' ':
        options.flowattrs = ' ' + options.flowattrs

    for i, ban in enumerate(options.ban):
        options.ban[i] = ban.replace(" ", "")
    print("Banned edges: {}".format(options.ban))
    return options

def parseTurns(turnfile, attr, split=1):
    for interval in sumolib.xml.parse(turnfile, 'interval'):
        for edgeRel in interval.edgeRelation:
            count = int(edgeRel.__dict__.get("count"))
            remain = count
            each_split = int(count/split) + 1
            while remain > 0:
                rand_each_split = each_split + int((1 - np.random.rand()) * each_split / 2)
                sub_count = min(rand_each_split, remain)
                remain -= sub_count
                fromEdge = edgeRel.__dict__.get("attr_from")
                toEdge = edgeRel.__dict__.get("to")
                vtype = edgeRel.__dict__.get("type")
                assert fromEdge and toEdge and sub_count, "Either one should be assign in turns file: "\
                    "from:{} to:{} count:{}".format(fromEdge, toEdge, sub_count)
                yield fromEdge, toEdge, vtype, interval.begin, interval.end, sub_count


def writeVehicleType(ff, vehiclefile):
    if not vehiclefile.endswith(".add.xml"):
        raise ValueError(vehiclefile)
    with open(vehiclefile, 'r') as vf:
        ff.write("\n\n    <!-- Vehicle Definitions Head. -->\n")
        for line in vf.readlines():
            if "vType" in line or "vTypeDistribution" in line:
                ff.write("{}".format(line))
        ff.write("    <!-- Vehicle Definitions End. -->\n\n")


def findFringe(edge, direction, options):
    incoming = edge.getIncoming()
    outgoing = edge.getOutgoing()

    valid_veh = lambda x: x.allows("evehicle") and x.allows("truck") and x.allows("authority") and x.allows("passenger") and x.allows("motorcycle") and x.allows("bicycle")
    valid = lambda x: valid_veh(x) and x.getID() not in options.ban
    if valid(edge) and (edge.is_fringe(edge._incoming) or edge.is_fringe(edge._outgoing)):
        return edge
    else:
        if direction == "incoming":
            edges = incoming
        elif direction == "outgoing":
            edges = outgoing
        else:
            raise ValueError(direction)

        if edge.getID() in EXCEPTION_DEALING_NOTWORKING[direction].keys():
            notWorkingList = EXCEPTION_DEALING_NOTWORKING[direction][str(edge.getID())]
        else:
            notWorkingList = []
        delList = []
        for e in edges.keys():
            if e.getID() in notWorkingList or not valid(e):
                delList.append(e)
        for delKey in delList:
            del edges[delKey]
        prev = edges.keys()

        if len(prev) == 0:
            print("No next working edge to be found from edge {}".format(edge.getID()))
            return edge
        else:
            prev = np.random.choice(prev)
            return findFringe(prev, direction, options)

def main(options):
    sinks = set()
    if True:
        net = sumolib.net.readNet(options.net)
        with open(options.flowOutput, 'w') as ff:
            sumolib.writeXMLHeader(ff, "$Id$", "routes")  # noqa
            if options.vehicleFile:
                writeVehicleType(ff, options.vehicleFile)
            idCount = 0
            splitCounts = int(options.countParam)

            allFlowDictList = []
            for demand in parseTurns(options.turnFile, options.turnAttr, splitCounts):
                fromEdgeID, toEdgeID, vtype, begins, ends, count = demand
                # flowID = "{}to{}#{}".format(fromEdgeID, toEdgeID, idCount)
                # flowID = "{}".format(idCount)
                flowDict = OrderedDict()
                flowDict["id"] = None
                fromEdge = net.getEdge(fromEdgeID.decode("utf-8"))
                toEdge = net.getEdge(toEdgeID.decode("utf-8"))
                viaEdges = []
                fromEdgeFringe = findFringe(fromEdge, "incoming", options)
                toEdgeFringe = findFringe(toEdge, "outgoing", options)
                flowDict["from"] = fromEdgeFringe.getID()
                flowDict["to"] = toEdgeFringe.getID()

                if fromEdge != fromEdgeFringe: viaEdges.append(fromEdgeID)
                if toEdge != toEdgeFringe: viaEdges.append(toEdgeID)
                if len(viaEdges):
                    flowDict["via"] = " ".join(viaEdges)
                flowDict["begin"] = begins
                flowDict["end"] = ends
                flowDict["vehsPerHour"] = count
                if vtype: flowDict["type"] = vtype
                allFlowDictList.append(flowDict)

            dummyEgoSet = False
            np.random.shuffle(allFlowDictList)
            for flowID, flowDict in enumerate(allFlowDictList):
                flowDict["id"] = flowID
                if not dummyEgoSet:
                    flowDict["type"] = options.egoModel
                    dummyEgoSet = True
                dataToWrite = "{}<flow".format(" " * 4)
                for key, val in flowDict.items():
                    dataToWrite += ' {}="{}"'.format(key, val)
                dataToWrite += "/>\n"
                ff.write(dataToWrite)
                idCount += 1
                sinks.add(str(flowDict["to"]))
            ff.write('\n</routes>\n')

        print("\n{}\nFlow file {} generated with dummy {} model."\
            "".format("="*20, options.flowOutput, options.egoModel))

    print("Call duarouter.\n{}\n".format("="*20))

    DUAROUTER = sumolib.checkBinary('duarouter')
    args = [DUAROUTER,
            '-n', options.net,
            '--route-files', options.flowOutput,
            '-o', options.out]
    if options.random:
        args += ["--random"]
        if options.seed:
            args += ["--seed", options.seed]

    subprocess.call(args)


if __name__ == "__main__":
    main(get_options())
