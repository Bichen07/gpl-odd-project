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

class LaneChangeDirection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LaneChangeDirection
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LaneChangeDirection
    let len;
    let data = new LaneChangeDirection(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LaneChangeDirection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c3f618df475623ce28a1741078c37b19';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 right=2
    uint32 left=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LaneChangeDirection(null);
    return resolved;
    }
};

// Constants for message
LaneChangeDirection.Constants = {
  NONE: 0,
  RIGHT: 2,
  LEFT: 1,
}

module.exports = LaneChangeDirection;
