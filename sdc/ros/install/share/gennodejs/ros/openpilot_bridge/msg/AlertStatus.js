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

class AlertStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AlertStatus
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AlertStatus
    let len;
    let data = new AlertStatus(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AlertStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f1701a0e87965803964a3d98d28cc804';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 userPrompt=1
    uint32 critical=2
    uint32 normal=0
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AlertStatus(null);
    return resolved;
    }
};

// Constants for message
AlertStatus.Constants = {
  USERPROMPT: 1,
  CRITICAL: 2,
  NORMAL: 0,
}

module.exports = AlertStatus;
