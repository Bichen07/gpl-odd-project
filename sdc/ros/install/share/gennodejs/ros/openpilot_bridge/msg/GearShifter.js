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

class GearShifter {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GearShifter
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GearShifter
    let len;
    let data = new GearShifter(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/GearShifter';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '273b4e52e60e160fcc38ba4e49c7ae28';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 reverse=4
    uint32 eco=8
    uint32 unknown=0
    uint32 park=1
    uint32 drive=2
    uint32 manumatic=9
    uint32 neutral=3
    uint32 brake=7
    uint32 low=6
    uint32 sport=5
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GearShifter(null);
    return resolved;
    }
};

// Constants for message
GearShifter.Constants = {
  REVERSE: 4,
  ECO: 8,
  UNKNOWN: 0,
  PARK: 1,
  DRIVE: 2,
  MANUMATIC: 9,
  NEUTRAL: 3,
  BRAKE: 7,
  LOW: 6,
  SPORT: 5,
}

module.exports = GearShifter;
