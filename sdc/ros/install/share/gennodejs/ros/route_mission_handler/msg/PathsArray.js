// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Paths = require('./Paths.js');

//-----------------------------------------------------------

class PathsArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.paths = null;
    }
    else {
      if (initObj.hasOwnProperty('paths')) {
        this.paths = initObj.paths
      }
      else {
        this.paths = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathsArray
    // Serialize message field [paths]
    // Serialize the length for message field [paths]
    bufferOffset = _serializer.uint32(obj.paths.length, buffer, bufferOffset);
    obj.paths.forEach((val) => {
      bufferOffset = Paths.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathsArray
    let len;
    let data = new PathsArray(null);
    // Deserialize message field [paths]
    // Deserialize array length for message field [paths]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.paths = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.paths[i] = Paths.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.paths.forEach((val) => {
      length += Paths.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/PathsArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '41d15ff121904e5150d2e5a68706b573';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Paths[] paths
    
    ================================================================================
    MSG: route_mission_handler/Paths
    string name
    string handdrive
    Lanes[] lanes
    float64[] distances
    uint32[] directions
    bool isParkingPath
    
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
    const resolved = new PathsArray(null);
    if (msg.paths !== undefined) {
      resolved.paths = new Array(msg.paths.length);
      for (let i = 0; i < resolved.paths.length; ++i) {
        resolved.paths[i] = Paths.Resolve(msg.paths[i]);
      }
    }
    else {
      resolved.paths = []
    }

    return resolved;
    }
};

module.exports = PathsArray;
