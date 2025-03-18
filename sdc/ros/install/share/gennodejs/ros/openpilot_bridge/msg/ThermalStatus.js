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

class ThermalStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ThermalStatus
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ThermalStatus
    let len;
    let data = new ThermalStatus(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ThermalStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8ca17fd4cb32043ad3a4b48c68d9d536';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 green=0
    uint32 red=2
    uint32 yellow=1
    uint32 danger=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ThermalStatus(null);
    return resolved;
    }
};

// Constants for message
ThermalStatus.Constants = {
  GREEN: 0,
  RED: 2,
  YELLOW: 1,
  DANGER: 3,
}

module.exports = ThermalStatus;
