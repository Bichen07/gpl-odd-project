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

class SVObservationState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SVObservationState
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SVObservationState
    let len;
    let data = new SVObservationState(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SVObservationState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ca9b9510f6b206850baa3731f543e7df';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 search=1
    uint32 bitEdge=3
    uint32 track=5
    uint32 glo10msAt=9
    uint32 idle=0
    uint32 trackVerify=4
    uint32 searchVerify=2
    uint32 dpo=7
    uint32 restart=6
    uint32 glo10msBe=8
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SVObservationState(null);
    return resolved;
    }
};

// Constants for message
SVObservationState.Constants = {
  SEARCH: 1,
  BITEDGE: 3,
  TRACK: 5,
  GLO10MSAT: 9,
  IDLE: 0,
  TRACKVERIFY: 4,
  SEARCHVERIFY: 2,
  DPO: 7,
  RESTART: 6,
  GLO10MSBE: 8,
}

module.exports = SVObservationState;
