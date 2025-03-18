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

class ChannelWidth {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ChannelWidth
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ChannelWidth
    let len;
    let data = new ChannelWidth(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ChannelWidth';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9ae570201d6a8de5bc884fa5c20bf751';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 w40Mhz=1
    uint32 w160Mhz=3
    uint32 w80Mhz=2
    uint32 w80Plus80Mhz=4
    uint32 w20Mhz=0
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ChannelWidth(null);
    return resolved;
    }
};

// Constants for message
ChannelWidth.Constants = {
  W40MHZ: 1,
  W160MHZ: 3,
  W80MHZ: 2,
  W80PLUS80MHZ: 4,
  W20MHZ: 0,
}

module.exports = ChannelWidth;
