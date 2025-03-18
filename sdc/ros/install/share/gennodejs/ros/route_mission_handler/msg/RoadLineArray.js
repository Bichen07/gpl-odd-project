// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let RoadLine = require('./RoadLine.js');

//-----------------------------------------------------------

class RoadLineArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lines = null;
    }
    else {
      if (initObj.hasOwnProperty('lines')) {
        this.lines = initObj.lines
      }
      else {
        this.lines = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RoadLineArray
    // Serialize message field [lines]
    // Serialize the length for message field [lines]
    bufferOffset = _serializer.uint32(obj.lines.length, buffer, bufferOffset);
    obj.lines.forEach((val) => {
      bufferOffset = RoadLine.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RoadLineArray
    let len;
    let data = new RoadLineArray(null);
    // Deserialize message field [lines]
    // Deserialize array length for message field [lines]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lines = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lines[i] = RoadLine.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.lines.forEach((val) => {
      length += RoadLine.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/RoadLineArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '328e2a15a161447b2069ea6540b246dc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    RoadLine[] lines
    
    ================================================================================
    MSG: route_mission_handler/RoadLine
    int32 id
    RoadLinePoint[] points
    
    ================================================================================
    MSG: route_mission_handler/RoadLinePoint
    int32 id
    int32 type
    geometry_msgs/Point position
    
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
    const resolved = new RoadLineArray(null);
    if (msg.lines !== undefined) {
      resolved.lines = new Array(msg.lines.length);
      for (let i = 0; i < resolved.lines.length; ++i) {
        resolved.lines[i] = RoadLine.Resolve(msg.lines[i]);
      }
    }
    else {
      resolved.lines = []
    }

    return resolved;
    }
};

module.exports = RoadLineArray;
