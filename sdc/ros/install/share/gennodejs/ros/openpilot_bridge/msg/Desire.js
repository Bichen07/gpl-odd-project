// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Desire {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Desire
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Desire
    let len;
    let data = new Desire(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Desire';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b80700589a9a6c06d4798f291a92dd6e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 turnLeft=1
    uint32 laneChangeRight=4
    uint32 laneChangeLeft=3
    uint32 turnRight=2
    uint32 keepRight=6
    uint32 keepLeft=5
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Desire(null);
    return resolved;
    }
};

// Constants for message
Desire.Constants = {
  NONE: 0,
  TURNLEFT: 1,
  LANECHANGERIGHT: 4,
  LANECHANGELEFT: 3,
  TURNRIGHT: 2,
  KEEPRIGHT: 6,
  KEEPLEFT: 5,
}

module.exports = Desire;
