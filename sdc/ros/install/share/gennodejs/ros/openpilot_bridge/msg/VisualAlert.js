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

class VisualAlert {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VisualAlert
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VisualAlert
    let len;
    let data = new VisualAlert(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/VisualAlert';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '051a9c2f807a04756a4e6edeb17dd056';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 wrongGear=4
    uint32 fcw=1
    uint32 steerRequired=2
    uint32 speedTooHigh=6
    uint32 seatbeltUnbuckled=5
    uint32 ldw=7
    uint32 brakePressed=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new VisualAlert(null);
    return resolved;
    }
};

// Constants for message
VisualAlert.Constants = {
  NONE: 0,
  WRONGGEAR: 4,
  FCW: 1,
  STEERREQUIRED: 2,
  SPEEDTOOHIGH: 6,
  SEATBELTUNBUCKLED: 5,
  LDW: 7,
  BRAKEPRESSED: 3,
}

module.exports = VisualAlert;
