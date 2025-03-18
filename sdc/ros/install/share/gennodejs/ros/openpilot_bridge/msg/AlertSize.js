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

class AlertSize {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AlertSize
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AlertSize
    let len;
    let data = new AlertSize(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AlertSize';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0ea349938bab8f497baa9a2b7b4823c9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 small=1
    uint32 none=0
    uint32 full=3
    uint32 mid=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AlertSize(null);
    return resolved;
    }
};

// Constants for message
AlertSize.Constants = {
  SMALL: 1,
  NONE: 0,
  FULL: 3,
  MID: 2,
}

module.exports = AlertSize;
