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

class OpenpilotState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OpenpilotState
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OpenpilotState
    let len;
    let data = new OpenpilotState(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OpenpilotState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c8df9612be1bf110e6fde5ec97fedc61';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 disabled=0
    uint32 enabled=2
    uint32 preEnabled=1
    uint32 softDisabling=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OpenpilotState(null);
    return resolved;
    }
};

// Constants for message
OpenpilotState.Constants = {
  DISABLED: 0,
  ENABLED: 2,
  PREENABLED: 1,
  SOFTDISABLING: 3,
}

module.exports = OpenpilotState;
