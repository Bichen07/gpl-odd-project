// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class LineParm {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.parm0 = null;
      this.parm1 = null;
      this.parm2 = null;
      this.confidentScore = null;
      this.frameIdx = null;
    }
    else {
      if (initObj.hasOwnProperty('parm0')) {
        this.parm0 = initObj.parm0
      }
      else {
        this.parm0 = 0.0;
      }
      if (initObj.hasOwnProperty('parm1')) {
        this.parm1 = initObj.parm1
      }
      else {
        this.parm1 = 0.0;
      }
      if (initObj.hasOwnProperty('parm2')) {
        this.parm2 = initObj.parm2
      }
      else {
        this.parm2 = 0.0;
      }
      if (initObj.hasOwnProperty('confidentScore')) {
        this.confidentScore = initObj.confidentScore
      }
      else {
        this.confidentScore = 0;
      }
      if (initObj.hasOwnProperty('frameIdx')) {
        this.frameIdx = initObj.frameIdx
      }
      else {
        this.frameIdx = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LineParm
    // Serialize message field [parm0]
    bufferOffset = _serializer.float32(obj.parm0, buffer, bufferOffset);
    // Serialize message field [parm1]
    bufferOffset = _serializer.float32(obj.parm1, buffer, bufferOffset);
    // Serialize message field [parm2]
    bufferOffset = _serializer.float32(obj.parm2, buffer, bufferOffset);
    // Serialize message field [confidentScore]
    bufferOffset = _serializer.uint16(obj.confidentScore, buffer, bufferOffset);
    // Serialize message field [frameIdx]
    bufferOffset = _serializer.uint16(obj.frameIdx, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LineParm
    let len;
    let data = new LineParm(null);
    // Deserialize message field [parm0]
    data.parm0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [parm1]
    data.parm1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [parm2]
    data.parm2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [confidentScore]
    data.confidentScore = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [frameIdx]
    data.frameIdx = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/LineParm';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4ba0e2d1442ddcc8696bcf7cb4f9b46e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 parm0
    float32 parm1
    float32 parm2
    uint16 confidentScore
    uint16 frameIdx
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LineParm(null);
    if (msg.parm0 !== undefined) {
      resolved.parm0 = msg.parm0;
    }
    else {
      resolved.parm0 = 0.0
    }

    if (msg.parm1 !== undefined) {
      resolved.parm1 = msg.parm1;
    }
    else {
      resolved.parm1 = 0.0
    }

    if (msg.parm2 !== undefined) {
      resolved.parm2 = msg.parm2;
    }
    else {
      resolved.parm2 = 0.0
    }

    if (msg.confidentScore !== undefined) {
      resolved.confidentScore = msg.confidentScore;
    }
    else {
      resolved.confidentScore = 0
    }

    if (msg.frameIdx !== undefined) {
      resolved.frameIdx = msg.frameIdx;
    }
    else {
      resolved.frameIdx = 0
    }

    return resolved;
    }
};

module.exports = LineParm;
