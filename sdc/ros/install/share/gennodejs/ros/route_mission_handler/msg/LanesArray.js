// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Lanes = require('./Lanes.js');

//-----------------------------------------------------------

class LanesArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lanes = null;
    }
    else {
      if (initObj.hasOwnProperty('lanes')) {
        this.lanes = initObj.lanes
      }
      else {
        this.lanes = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LanesArray
    // Serialize message field [lanes]
    // Serialize the length for message field [lanes]
    bufferOffset = _serializer.uint32(obj.lanes.length, buffer, bufferOffset);
    obj.lanes.forEach((val) => {
      bufferOffset = Lanes.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LanesArray
    let len;
    let data = new LanesArray(null);
    // Deserialize message field [lanes]
    // Deserialize array length for message field [lanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lanes[i] = Lanes.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.lanes.forEach((val) => {
      length += Lanes.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/LanesArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd3abd4115c3fc87ecb0786239ac4161a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Lanes[] lanes
    
    ================================================================================
    MSG: route_mission_handler/Lanes
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
    const resolved = new LanesArray(null);
    if (msg.lanes !== undefined) {
      resolved.lanes = new Array(msg.lanes.length);
      for (let i = 0; i < resolved.lanes.length; ++i) {
        resolved.lanes[i] = Lanes.Resolve(msg.lanes[i]);
      }
    }
    else {
      resolved.lanes = []
    }

    return resolved;
    }
};

module.exports = LanesArray;
