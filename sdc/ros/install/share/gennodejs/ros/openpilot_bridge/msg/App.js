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

class App {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type App
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type App
    let len;
    let data = new App(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/App';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4d8d5be50420b5f72e4c548858f9a27f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 home=0
    uint32 nav=2
    uint32 music=1
    uint32 settings=3
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new App(null);
    return resolved;
    }
};

// Constants for message
App.Constants = {
  HOME: 0,
  NAV: 2,
  MUSIC: 1,
  SETTINGS: 3,
}

module.exports = App;
