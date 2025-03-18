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

class MeasurementSource {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MeasurementSource
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MeasurementSource
    let len;
    let data = new MeasurementSource(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/MeasurementSource';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9647811c69840716207e5d777760409f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 beidou=2
    uint32 glonass=1
    uint32 gps=0
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MeasurementSource(null);
    return resolved;
    }
};

// Constants for message
MeasurementSource.Constants = {
  BEIDOU: 2,
  GLONASS: 1,
  GPS: 0,
}

module.exports = MeasurementSource;
