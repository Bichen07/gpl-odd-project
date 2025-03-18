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

class Error {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Error
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Error
    let len;
    let data = new Error(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Error';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '48460582da2a88bb26d24722889db26d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 fault=1
    uint32 canError=0
    uint32 wrongConfig=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Error(null);
    return resolved;
    }
};

// Constants for message
Error.Constants = {
  FAULT: 1,
  CANERROR: 0,
  WRONGCONFIG: 2,
}

module.exports = Error;
