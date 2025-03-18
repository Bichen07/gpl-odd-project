// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Waypoint = require('./Waypoint.js');

//-----------------------------------------------------------

class Lane {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lane_id = null;
      this.nroad_ids = null;
      this.is_intersection = null;
      this.is_positive = null;
      this.waypoints = null;
      this.next_lanes = null;
      this.left_lanes = null;
      this.right_lanes = null;
      this.max_speed_limit = null;
      this.order = null;
      this.roadType = null;
      this.type = null;
    }
    else {
      if (initObj.hasOwnProperty('lane_id')) {
        this.lane_id = initObj.lane_id
      }
      else {
        this.lane_id = 0;
      }
      if (initObj.hasOwnProperty('nroad_ids')) {
        this.nroad_ids = initObj.nroad_ids
      }
      else {
        this.nroad_ids = [];
      }
      if (initObj.hasOwnProperty('is_intersection')) {
        this.is_intersection = initObj.is_intersection
      }
      else {
        this.is_intersection = false;
      }
      if (initObj.hasOwnProperty('is_positive')) {
        this.is_positive = initObj.is_positive
      }
      else {
        this.is_positive = false;
      }
      if (initObj.hasOwnProperty('waypoints')) {
        this.waypoints = initObj.waypoints
      }
      else {
        this.waypoints = [];
      }
      if (initObj.hasOwnProperty('next_lanes')) {
        this.next_lanes = initObj.next_lanes
      }
      else {
        this.next_lanes = [];
      }
      if (initObj.hasOwnProperty('left_lanes')) {
        this.left_lanes = initObj.left_lanes
      }
      else {
        this.left_lanes = [];
      }
      if (initObj.hasOwnProperty('right_lanes')) {
        this.right_lanes = initObj.right_lanes
      }
      else {
        this.right_lanes = [];
      }
      if (initObj.hasOwnProperty('max_speed_limit')) {
        this.max_speed_limit = initObj.max_speed_limit
      }
      else {
        this.max_speed_limit = 0;
      }
      if (initObj.hasOwnProperty('order')) {
        this.order = initObj.order
      }
      else {
        this.order = 0;
      }
      if (initObj.hasOwnProperty('roadType')) {
        this.roadType = initObj.roadType
      }
      else {
        this.roadType = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lane
    // Serialize message field [lane_id]
    bufferOffset = _serializer.int32(obj.lane_id, buffer, bufferOffset);
    // Serialize message field [nroad_ids]
    bufferOffset = _arraySerializer.int32(obj.nroad_ids, buffer, bufferOffset, null);
    // Serialize message field [is_intersection]
    bufferOffset = _serializer.bool(obj.is_intersection, buffer, bufferOffset);
    // Serialize message field [is_positive]
    bufferOffset = _serializer.bool(obj.is_positive, buffer, bufferOffset);
    // Serialize message field [waypoints]
    // Serialize the length for message field [waypoints]
    bufferOffset = _serializer.uint32(obj.waypoints.length, buffer, bufferOffset);
    obj.waypoints.forEach((val) => {
      bufferOffset = Waypoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [next_lanes]
    bufferOffset = _arraySerializer.int32(obj.next_lanes, buffer, bufferOffset, null);
    // Serialize message field [left_lanes]
    bufferOffset = _arraySerializer.int32(obj.left_lanes, buffer, bufferOffset, null);
    // Serialize message field [right_lanes]
    bufferOffset = _arraySerializer.int32(obj.right_lanes, buffer, bufferOffset, null);
    // Serialize message field [max_speed_limit]
    bufferOffset = _serializer.int32(obj.max_speed_limit, buffer, bufferOffset);
    // Serialize message field [order]
    bufferOffset = _serializer.uint32(obj.order, buffer, bufferOffset);
    // Serialize message field [roadType]
    bufferOffset = _serializer.int32(obj.roadType, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lane
    let len;
    let data = new Lane(null);
    // Deserialize message field [lane_id]
    data.lane_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nroad_ids]
    data.nroad_ids = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [is_intersection]
    data.is_intersection = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [is_positive]
    data.is_positive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [waypoints]
    // Deserialize array length for message field [waypoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.waypoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.waypoints[i] = Waypoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [next_lanes]
    data.next_lanes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [left_lanes]
    data.left_lanes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [right_lanes]
    data.right_lanes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [max_speed_limit]
    data.max_speed_limit = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [order]
    data.order = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [roadType]
    data.roadType = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.nroad_ids.length;
    object.waypoints.forEach((val) => {
      length += Waypoint.getMessageSize(val);
    });
    length += 4 * object.next_lanes.length;
    length += 4 * object.left_lanes.length;
    length += 4 * object.right_lanes.length;
    return length + 42;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Lane';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a85d726fdccc9baacc78994caaac890b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lane(null);
    if (msg.lane_id !== undefined) {
      resolved.lane_id = msg.lane_id;
    }
    else {
      resolved.lane_id = 0
    }

    if (msg.nroad_ids !== undefined) {
      resolved.nroad_ids = msg.nroad_ids;
    }
    else {
      resolved.nroad_ids = []
    }

    if (msg.is_intersection !== undefined) {
      resolved.is_intersection = msg.is_intersection;
    }
    else {
      resolved.is_intersection = false
    }

    if (msg.is_positive !== undefined) {
      resolved.is_positive = msg.is_positive;
    }
    else {
      resolved.is_positive = false
    }

    if (msg.waypoints !== undefined) {
      resolved.waypoints = new Array(msg.waypoints.length);
      for (let i = 0; i < resolved.waypoints.length; ++i) {
        resolved.waypoints[i] = Waypoint.Resolve(msg.waypoints[i]);
      }
    }
    else {
      resolved.waypoints = []
    }

    if (msg.next_lanes !== undefined) {
      resolved.next_lanes = msg.next_lanes;
    }
    else {
      resolved.next_lanes = []
    }

    if (msg.left_lanes !== undefined) {
      resolved.left_lanes = msg.left_lanes;
    }
    else {
      resolved.left_lanes = []
    }

    if (msg.right_lanes !== undefined) {
      resolved.right_lanes = msg.right_lanes;
    }
    else {
      resolved.right_lanes = []
    }

    if (msg.max_speed_limit !== undefined) {
      resolved.max_speed_limit = msg.max_speed_limit;
    }
    else {
      resolved.max_speed_limit = 0
    }

    if (msg.order !== undefined) {
      resolved.order = msg.order;
    }
    else {
      resolved.order = 0
    }

    if (msg.roadType !== undefined) {
      resolved.roadType = msg.roadType;
    }
    else {
      resolved.roadType = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    return resolved;
    }
};

// Constants for message
Lane.Constants = {
  NORMAL: 0,
  SPLIT_LEFT: 1,
  SPLIT_RIGHT: 2,
  MERGE_TO_RIGHT: 3,
  MERGE_TO_LEFT: 4,
  TOBE_MERGED: 5,
  SPLIT_STRAIGHT: 6,
}

module.exports = Lane;
