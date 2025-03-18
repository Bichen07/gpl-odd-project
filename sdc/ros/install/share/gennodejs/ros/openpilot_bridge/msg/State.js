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

class State {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type State
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type State
    let len;
    let data = new State(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/State';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e9a71513332f5cfbf861cb985b6c816e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 bdsD2BitSync=9
    uint32 towDecoded=4
    uint32 galE1bcCodeLock=11
    uint32 sbasSync=14
    uint32 symbolSync=6
    uint32 unknown=0
    uint32 bdsD2SubframeSync=10
    uint32 codeLock=1
    uint32 subframeSync=3
    uint32 galE1bPageSync=13
    uint32 bitSync=2
    uint32 galE1c2ndCodeLock=12
    uint32 gloStringSync=7
    uint32 gloTodDecoded=8
    uint32 msecAmbiguous=5
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new State(null);
    return resolved;
    }
};

// Constants for message
State.Constants = {
  BDSD2BITSYNC: 9,
  TOWDECODED: 4,
  GALE1BCCODELOCK: 11,
  SBASSYNC: 14,
  SYMBOLSYNC: 6,
  UNKNOWN: 0,
  BDSD2SUBFRAMESYNC: 10,
  CODELOCK: 1,
  SUBFRAMESYNC: 3,
  GALE1BPAGESYNC: 13,
  BITSYNC: 2,
  GALE1C2NDCODELOCK: 12,
  GLOSTRINGSYNC: 7,
  GLOTODDECODED: 8,
  MSECAMBIGUOUS: 5,
}

module.exports = State;
