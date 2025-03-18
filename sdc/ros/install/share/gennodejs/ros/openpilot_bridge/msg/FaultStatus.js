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

class FaultStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FaultStatus
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FaultStatus
    let len;
    let data = new FaultStatus(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/FaultStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f810ab59824d94736267917644323f17';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 faultPerm=2
    uint32 faultTemp=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FaultStatus(null);
    return resolved;
    }
};

// Constants for message
FaultStatus.Constants = {
  NONE: 0,
  FAULTPERM: 2,
  FAULTTEMP: 1,
}

module.exports = FaultStatus;
