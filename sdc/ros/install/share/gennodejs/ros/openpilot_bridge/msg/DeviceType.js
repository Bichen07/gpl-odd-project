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

class DeviceType {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DeviceType
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DeviceType
    let len;
    let data = new DeviceType(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/DeviceType';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '82413ac418dda4ec5bf96c9c7090008f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 chffrIos=3
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
    const resolved = new DeviceType(null);
    return resolved;
    }
};

// Constants for message
DeviceType.Constants = {
  CHFFRIOS: 3,
  UNKNOWN: 0,
  CHFFRANDROID: 2,
  NEO: 1,
}

module.exports = DeviceType;
