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

class Ecu {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ecu
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ecu
    let len;
    let data = new Ecu(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Ecu';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b4567db0d123c6b76edb282c1d1130de';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 engine=4
    uint32 esp=1
    uint32 unknown=5
    uint32 dsu=6
    uint32 eps=0
    uint32 apgs=7
    uint32 fwdRadar=2
    uint32 fwdCamera=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Ecu(null);
    return resolved;
    }
};

// Constants for message
Ecu.Constants = {
  ENGINE: 4,
  ESP: 1,
  UNKNOWN: 5,
  DSU: 6,
  EPS: 0,
  APGS: 7,
  FWDRADAR: 2,
  FWDCAMERA: 3,
}

module.exports = Ecu;
