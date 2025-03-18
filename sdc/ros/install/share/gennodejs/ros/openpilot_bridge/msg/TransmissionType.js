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

class TransmissionType {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TransmissionType
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TransmissionType
    let len;
    let data = new TransmissionType(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/TransmissionType';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6a285d0e2a6ddfeacb68fed4d3099191';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 unknown=0
    uint32 automatic=1
    uint32 manual=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TransmissionType(null);
    return resolved;
    }
};

// Constants for message
TransmissionType.Constants = {
  UNKNOWN: 0,
  AUTOMATIC: 1,
  MANUAL: 2,
}

module.exports = TransmissionType;
