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

class Action {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Action
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Action
    let len;
    let data = new Action(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Action';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f807133cfc56a455de4e9a8e5b57aa0a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 stop=2
    uint32 resumeReady=3
    uint32 yield=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Action(null);
    return resolved;
    }
};

// Constants for message
Action.Constants = {
  NONE: 0,
  STOP: 2,
  RESUMEREADY: 3,
  YIELD: 1,
}

module.exports = Action;
