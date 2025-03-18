// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let CroadLanes = require('./CroadLanes.js');

//-----------------------------------------------------------

class CroadLanesArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.clanes = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('clanes')) {
        this.clanes = initObj.clanes
      }
      else {
        this.clanes = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CroadLanesArray
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [clanes]
    // Serialize the length for message field [clanes]
    bufferOffset = _serializer.uint32(obj.clanes.length, buffer, bufferOffset);
    obj.clanes.forEach((val) => {
      bufferOffset = CroadLanes.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CroadLanesArray
    let len;
    let data = new CroadLanesArray(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [clanes]
    // Deserialize array length for message field [clanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.clanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.clanes[i] = CroadLanes.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    object.clanes.forEach((val) => {
      length += CroadLanes.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/CroadLanesArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '498cf78e2ebab6d12896dc763a3009fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    CroadLanes[] clanes
    
    ================================================================================
    MSG: route_mission_handler/CroadLanes
    Croad cr1
    Croad cr2
    Lane[] lanes
    
    ================================================================================
    MSG: route_mission_handler/Croad
    int32 nroad_id
    bool isPositive
    int32 point_id
    int32[] lane_ids
    geometry_msgs/Point[] points
    bool fixed
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: route_mission_handler/Lane
    int32 NORMAL=0
    int32 SPLIT_LEFT=1
    int32 SPLIT_RIGHT=2
    int32 MERGE_TO_RIGHT=3
    int32 MERGE_TO_LEFT=4
    int32 TOBE_MERGED=5
    int32 SPLIT_STRAIGHT=6
    
    int32 lane_id
    int32[] nroad_ids
    bool is_intersection
    bool is_positive
    Waypoint[] waypoints
    int32[] next_lanes
    int32[] left_lanes
    int32[] right_lanes
    int32 max_speed_limit
    uint32 order
    int32 roadType
    int32 type
    
    ================================================================================
    MSG: route_mission_handler/Waypoint
    int32 lane_id
    int32 point_id
    int32 nroad_id
    float32 roadWidth
    float32 distToRightLine
    float32 distToLeftLine
    float32 right_road_bound
    float32 left_road_bound
    float32 curvature
    float32 heading
    geometry_msgs/Point point
    int32[] markerIds
    int32[] markerTypes
    int32 parkingLotId
    int32 parkingLotLaneId
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CroadLanesArray(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.clanes !== undefined) {
      resolved.clanes = new Array(msg.clanes.length);
      for (let i = 0; i < resolved.clanes.length; ++i) {
        resolved.clanes[i] = CroadLanes.Resolve(msg.clanes[i]);
      }
    }
    else {
      resolved.clanes = []
    }

    return resolved;
    }
};

module.exports = CroadLanesArray;
