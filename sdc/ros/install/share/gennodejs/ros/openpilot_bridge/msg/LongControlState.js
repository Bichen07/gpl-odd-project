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

class LongControlState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LongControlState
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LongControlState
    let len;
    let data = new LongControlState(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LongControlState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3b1d735b18fedde2cd52ffbcd57e63c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 stopping=2
    uint32 pid=1
    uint32 off=0
    uint32 starting=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LongControlState(null);
    return resolved;
    }
};

// Constants for message
LongControlState.Constants = {
  STOPPING: 2,
  PID: 1,
  OFF: 0,
  STARTING: 3,
}

module.exports = LongControlState;
