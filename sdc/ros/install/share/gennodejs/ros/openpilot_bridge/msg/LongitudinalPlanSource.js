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

class LongitudinalPlanSource {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LongitudinalPlanSource
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LongitudinalPlanSource
    let len;
    let data = new LongitudinalPlanSource(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LongitudinalPlanSource';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6dc6b7eb09997044411ec119a9eedd80';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 model=4
    uint32 mpc1=1
    uint32 mpc2=2
    uint32 mpc3=3
    uint32 cruise=0
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LongitudinalPlanSource(null);
    return resolved;
    }
};

// Constants for message
LongitudinalPlanSource.Constants = {
  MODEL: 4,
  MPC1: 1,
  MPC2: 2,
  MPC3: 3,
  CRUISE: 0,
}

module.exports = LongitudinalPlanSource;
