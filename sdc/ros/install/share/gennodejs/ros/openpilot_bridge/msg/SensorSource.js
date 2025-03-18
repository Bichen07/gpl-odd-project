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

class SensorSource {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SensorSource
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SensorSource
    let len;
    let data = new SensorSource(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SensorSource';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4e71318379cc48f045877905e946e09e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 timing=3
    uint32 dummy=4
    uint32 orbslam=2
    uint32 applanix=0
    uint32 kalman=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SensorSource(null);
    return resolved;
    }
};

// Constants for message
SensorSource.Constants = {
  TIMING: 3,
  DUMMY: 4,
  ORBSLAM: 2,
  APPLANIX: 0,
  KALMAN: 1,
}

module.exports = SensorSource;
