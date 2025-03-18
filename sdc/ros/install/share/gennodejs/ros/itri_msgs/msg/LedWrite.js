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

class LedWrite {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.data = null;
      this.mode = null;
      this.length = null;
      this.action = null;
      this.speed = null;
      this.stop_time = null;
      this.frame = null;
      this.numViews = null;
    }
    else {
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = [];
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
      if (initObj.hasOwnProperty('length')) {
        this.length = initObj.length
      }
      else {
        this.length = 0;
      }
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = 0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0;
      }
      if (initObj.hasOwnProperty('stop_time')) {
        this.stop_time = initObj.stop_time
      }
      else {
        this.stop_time = 0;
      }
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = 0;
      }
      if (initObj.hasOwnProperty('numViews')) {
        this.numViews = initObj.numViews
      }
      else {
        this.numViews = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LedWrite
    // Serialize message field [data]
    bufferOffset = _arraySerializer.char(obj.data, buffer, bufferOffset, null);
    // Serialize message field [mode]
    bufferOffset = _serializer.uint8(obj.mode, buffer, bufferOffset);
    // Serialize message field [length]
    bufferOffset = _serializer.uint8(obj.length, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = _serializer.uint8(obj.action, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.uint8(obj.speed, buffer, bufferOffset);
    // Serialize message field [stop_time]
    bufferOffset = _serializer.uint8(obj.stop_time, buffer, bufferOffset);
    // Serialize message field [frame]
    bufferOffset = _serializer.uint8(obj.frame, buffer, bufferOffset);
    // Serialize message field [numViews]
    bufferOffset = _serializer.uint8(obj.numViews, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LedWrite
    let len;
    let data = new LedWrite(null);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.char(buffer, bufferOffset, null)
    // Deserialize message field [mode]
    data.mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [length]
    data.length = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [stop_time]
    data.stop_time = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [frame]
    data.frame = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [numViews]
    data.numViews = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.data.length;
    return length + 11;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/LedWrite';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0d492c2637a3aced37a6325f8359af16';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    char[] data
    uint8 mode
    uint8 length
    uint8 action
    uint8 speed
    uint8 stop_time
    uint8 frame
    uint8 numViews
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LedWrite(null);
    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = []
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    if (msg.length !== undefined) {
      resolved.length = msg.length;
    }
    else {
      resolved.length = 0
    }

    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = 0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0
    }

    if (msg.stop_time !== undefined) {
      resolved.stop_time = msg.stop_time;
    }
    else {
      resolved.stop_time = 0
    }

    if (msg.frame !== undefined) {
      resolved.frame = msg.frame;
    }
    else {
      resolved.frame = 0
    }

    if (msg.numViews !== undefined) {
      resolved.numViews = msg.numViews;
    }
    else {
      resolved.numViews = 0
    }

    return resolved;
    }
};

module.exports = LedWrite;
