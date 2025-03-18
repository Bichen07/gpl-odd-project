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

class Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Type
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Type
    let len;
    let data = new Type(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '15c6e84d22188be8e7284ad21b8ff2fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 decelCruise=4
    uint32 accelCruise=3
    uint32 leftBlinker=1
    uint32 unknown=0
    uint32 setCruise=9
    uint32 gapAdjustCruise=11
    uint32 resumeCruise=10
    uint32 rightBlinker=2
    uint32 altButton1=6
    uint32 cancel=5
    uint32 altButton3=8
    uint32 altButton2=7
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Type(null);
    return resolved;
    }
};

// Constants for message
Type.Constants = {
  DECELCRUISE: 4,
  ACCELCRUISE: 3,
  LEFTBLINKER: 1,
  UNKNOWN: 0,
  SETCRUISE: 9,
  GAPADJUSTCRUISE: 11,
  RESUMECRUISE: 10,
  RIGHTBLINKER: 2,
  ALTBUTTON1: 6,
  CANCEL: 5,
  ALTBUTTON3: 8,
  ALTBUTTON2: 7,
}

module.exports = Type;
