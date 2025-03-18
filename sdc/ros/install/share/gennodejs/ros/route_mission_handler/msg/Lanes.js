// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Waypoints = require('./Waypoints.js');

//-----------------------------------------------------------

class Lanes {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.type = null;
      this.id = null;
      this.isTurn = null;
      this.direction = null;
      this.laneno = null;
      this.nexts = null;
      this.roadLineIds = null;
      this.points = null;
      this.max_speed_limit = null;
      this.roadType = null;
    }
    else {
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('isTurn')) {
        this.isTurn = initObj.isTurn
      }
      else {
        this.isTurn = false;
      }
      if (initObj.hasOwnProperty('direction')) {
        this.direction = initObj.direction
      }
      else {
        this.direction = false;
      }
      if (initObj.hasOwnProperty('laneno')) {
        this.laneno = initObj.laneno
      }
      else {
        this.laneno = 0;
      }
      if (initObj.hasOwnProperty('nexts')) {
        this.nexts = initObj.nexts
      }
      else {
        this.nexts = [];
      }
      if (initObj.hasOwnProperty('roadLineIds')) {
        this.roadLineIds = initObj.roadLineIds
      }
      else {
        this.roadLineIds = [];
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('max_speed_limit')) {
        this.max_speed_limit = initObj.max_speed_limit
      }
      else {
        this.max_speed_limit = 0;
      }
      if (initObj.hasOwnProperty('roadType')) {
        this.roadType = initObj.roadType
      }
      else {
        this.roadType = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lanes
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [isTurn]
    bufferOffset = _serializer.bool(obj.isTurn, buffer, bufferOffset);
    // Serialize message field [direction]
    bufferOffset = _serializer.bool(obj.direction, buffer, bufferOffset);
    // Serialize message field [laneno]
    bufferOffset = _serializer.int32(obj.laneno, buffer, bufferOffset);
    // Serialize message field [nexts]
    bufferOffset = _arraySerializer.int32(obj.nexts, buffer, bufferOffset, null);
    // Serialize message field [roadLineIds]
    bufferOffset = _arraySerializer.int32(obj.roadLineIds, buffer, bufferOffset, null);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = Waypoints.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [max_speed_limit]
    bufferOffset = _serializer.int32(obj.max_speed_limit, buffer, bufferOffset);
    // Serialize message field [roadType]
    bufferOffset = _serializer.int32(obj.roadType, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lanes
    let len;
    let data = new Lanes(null);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [isTurn]
    data.isTurn = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [direction]
    data.direction = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [laneno]
    data.laneno = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nexts]
    data.nexts = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [roadLineIds]
    data.roadLineIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = Waypoints.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [max_speed_limit]
    data.max_speed_limit = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [roadType]
    data.roadType = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.nexts.length;
    length += 4 * object.roadLineIds.length;
    object.points.forEach((val) => {
      length += Waypoints.getMessageSize(val);
    });
    return length + 34;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Lanes';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ae56afad30bb76720a91ad99b362bf2c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 type
    int32 NORMAL=0
    int32 SPLIT_LEFT=1
    int32 SPLIT_RIGHT=2
    int32 MERGE_TO_RIGHT=3
    int32 MERGE_TO_LEFT=4
    int32 TOBE_MERGED=5
    int32 SPLIT_STRAIGHT=6
    
    int32 id
    bool isTurn
    bool direction
    int32 laneno
    int32[] nexts
    int32[] roadLineIds
    Waypoints[] points
    int32 max_speed_limit
    int32 roadType
    
    ================================================================================
    MSG: route_mission_handler/Waypoints
    int32 laneId
    int32 pointId
    float32 roadWidth
    float32 distToRightLine
    float32 distToLeftLine
    float32 right_road_bound
    float32 left_road_bound
    float32 curve
    float32 slope
    float32 bank_angle
    geometry_msgs/Pose pose
    int32[] markerIds
    int32[] markerTypes
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lanes(null);
    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.isTurn !== undefined) {
      resolved.isTurn = msg.isTurn;
    }
    else {
      resolved.isTurn = false
    }

    if (msg.direction !== undefined) {
      resolved.direction = msg.direction;
    }
    else {
      resolved.direction = false
    }

    if (msg.laneno !== undefined) {
      resolved.laneno = msg.laneno;
    }
    else {
      resolved.laneno = 0
    }

    if (msg.nexts !== undefined) {
      resolved.nexts = msg.nexts;
    }
    else {
      resolved.nexts = []
    }

    if (msg.roadLineIds !== undefined) {
      resolved.roadLineIds = msg.roadLineIds;
    }
    else {
      resolved.roadLineIds = []
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = Waypoints.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    if (msg.max_speed_limit !== undefined) {
      resolved.max_speed_limit = msg.max_speed_limit;
    }
    else {
      resolved.max_speed_limit = 0
    }

    if (msg.roadType !== undefined) {
      resolved.roadType = msg.roadType;
    }
    else {
      resolved.roadType = 0
    }

    return resolved;
    }
};

// Constants for message
Lanes.Constants = {
  NORMAL: 0,
  SPLIT_LEFT: 1,
  SPLIT_RIGHT: 2,
  MERGE_TO_RIGHT: 3,
  MERGE_TO_LEFT: 4,
  TOBE_MERGED: 5,
  SPLIT_STRAIGHT: 6,
}

module.exports = Lanes;
