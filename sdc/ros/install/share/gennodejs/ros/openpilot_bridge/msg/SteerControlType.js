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

class SteerControlType {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SteerControlType
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SteerControlType
    let len;
    let data = new SteerControlType(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SteerControlType';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b226a11115e5e44a2546beb49ffa97fa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 angle=1
    uint32 torque=0
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SteerControlType(null);
    return resolved;
    }
};

// Constants for message
SteerControlType.Constants = {
  ANGLE: 1,
  TORQUE: 0,
}

module.exports = SteerControlType;
