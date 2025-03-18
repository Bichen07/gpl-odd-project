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

class FrameType {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FrameType
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FrameType
    let len;
    let data = new FrameType(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/FrameType';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2a992a2c8d63e13eb9c0cdee6ef2a62f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 front=3
    uint32 unknown=0
    uint32 chffrAndroid=2
    uint32 neo=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FrameType(null);
    return resolved;
    }
};

// Constants for message
FrameType.Constants = {
  FRONT: 3,
  UNKNOWN: 0,
  CHFFRANDROID: 2,
  NEO: 1,
}

module.exports = FrameType;
