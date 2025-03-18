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

class visualDis {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.realDis_x = null;
      this.realDis_y = null;
      this.x = null;
      this.y = null;
      this.height = null;
      this.width = null;
      this.score = null;
    }
    else {
      if (initObj.hasOwnProperty('realDis_x')) {
        this.realDis_x = initObj.realDis_x
      }
      else {
        this.realDis_x = 0;
      }
      if (initObj.hasOwnProperty('realDis_y')) {
        this.realDis_y = initObj.realDis_y
      }
      else {
        this.realDis_y = 0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type visualDis
    // Serialize message field [realDis_x]
    bufferOffset = _serializer.int32(obj.realDis_x, buffer, bufferOffset);
    // Serialize message field [realDis_y]
    bufferOffset = _serializer.int32(obj.realDis_y, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.int32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.int32(obj.y, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.int32(obj.height, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.int32(obj.width, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float32(obj.score, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type visualDis
    let len;
    let data = new visualDis(null);
    // Deserialize message field [realDis_x]
    data.realDis_x = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [realDis_y]
    data.realDis_y = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/visualDis';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1d1e3a579add3817de8a1597d76c8b8e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 realDis_x
    int32 realDis_y
    int32 x
    int32 y
    int32 height
    int32 width
    float32 score
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new visualDis(null);
    if (msg.realDis_x !== undefined) {
      resolved.realDis_x = msg.realDis_x;
    }
    else {
      resolved.realDis_x = 0
    }

    if (msg.realDis_y !== undefined) {
      resolved.realDis_y = msg.realDis_y;
    }
    else {
      resolved.realDis_y = 0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    return resolved;
    }
};

module.exports = visualDis;
