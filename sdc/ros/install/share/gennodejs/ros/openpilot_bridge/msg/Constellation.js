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

class Constellation {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Constellation
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Constellation
    let len;
    let data = new Constellation(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Constellation';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '10e258dff61ddb857e38cc71c876c0f6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 glonass=3
    uint32 sbas=2
    uint32 unknown=0
    uint32 qzss=4
    uint32 galileo=6
    uint32 beidou=5
    uint32 gps=1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Constellation(null);
    return resolved;
    }
};

// Constants for message
Constellation.Constants = {
  GLONASS: 3,
  SBAS: 2,
  UNKNOWN: 0,
  QZSS: 4,
  GALILEO: 6,
  BEIDOU: 5,
  GPS: 1,
}

module.exports = Constellation;
