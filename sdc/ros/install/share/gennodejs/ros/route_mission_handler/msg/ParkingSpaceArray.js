// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ParkingSpace = require('./ParkingSpace.js');

//-----------------------------------------------------------

class ParkingSpaceArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.spaces = null;
    }
    else {
      if (initObj.hasOwnProperty('spaces')) {
        this.spaces = initObj.spaces
      }
      else {
        this.spaces = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParkingSpaceArray
    // Serialize message field [spaces]
    // Serialize the length for message field [spaces]
    bufferOffset = _serializer.uint32(obj.spaces.length, buffer, bufferOffset);
    obj.spaces.forEach((val) => {
      bufferOffset = ParkingSpace.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParkingSpaceArray
    let len;
    let data = new ParkingSpaceArray(null);
    // Deserialize message field [spaces]
    // Deserialize array length for message field [spaces]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.spaces = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.spaces[i] = ParkingSpace.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.spaces.forEach((val) => {
      length += ParkingSpace.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/ParkingSpaceArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b8e941ec972f8a9821ad740811fc6845';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ParkingSpace[] spaces
    
    ================================================================================
    MSG: route_mission_handler/ParkingSpace
    int32 type
    int32 VERTICAL=0
    int32 PARALLEL=1
    int32 OBLIQUE=2
    
    int32 side
    int32 RIGHT=0
    int32 LEFT=1
    
    int32 id
    int32 parkingLotId
    int32 laneId
    int32 pointId
    int32 orderType
    geometry_msgs/Point[] points
    
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
    const resolved = new ParkingSpaceArray(null);
    if (msg.spaces !== undefined) {
      resolved.spaces = new Array(msg.spaces.length);
      for (let i = 0; i < resolved.spaces.length; ++i) {
        resolved.spaces[i] = ParkingSpace.Resolve(msg.spaces[i]);
      }
    }
    else {
      resolved.spaces = []
    }

    return resolved;
    }
};

module.exports = ParkingSpaceArray;
