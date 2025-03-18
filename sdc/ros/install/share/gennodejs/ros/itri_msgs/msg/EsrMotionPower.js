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

class EsrMotionPower {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.track_moving = null;
      this.track_movable_fast = null;
      this.track_movable_slow = null;
      this.track_power = null;
    }
    else {
      if (initObj.hasOwnProperty('track_moving')) {
        this.track_moving = initObj.track_moving
      }
      else {
        this.track_moving = false;
      }
      if (initObj.hasOwnProperty('track_movable_fast')) {
        this.track_movable_fast = initObj.track_movable_fast
      }
      else {
        this.track_movable_fast = false;
      }
      if (initObj.hasOwnProperty('track_movable_slow')) {
        this.track_movable_slow = initObj.track_movable_slow
      }
      else {
        this.track_movable_slow = false;
      }
      if (initObj.hasOwnProperty('track_power')) {
        this.track_power = initObj.track_power
      }
      else {
        this.track_power = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsrMotionPower
    // Serialize message field [track_moving]
    bufferOffset = _serializer.bool(obj.track_moving, buffer, bufferOffset);
    // Serialize message field [track_movable_fast]
    bufferOffset = _serializer.bool(obj.track_movable_fast, buffer, bufferOffset);
    // Serialize message field [track_movable_slow]
    bufferOffset = _serializer.bool(obj.track_movable_slow, buffer, bufferOffset);
    // Serialize message field [track_power]
    bufferOffset = _serializer.int16(obj.track_power, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsrMotionPower
    let len;
    let data = new EsrMotionPower(null);
    // Deserialize message field [track_moving]
    data.track_moving = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [track_movable_fast]
    data.track_movable_fast = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [track_movable_slow]
    data.track_movable_slow = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [track_power]
    data.track_power = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/EsrMotionPower';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'adcd31c77e7090178d8bc4c127ff383f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool track_moving
    bool track_movable_fast
    bool track_movable_slow
    int16 track_power
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EsrMotionPower(null);
    if (msg.track_moving !== undefined) {
      resolved.track_moving = msg.track_moving;
    }
    else {
      resolved.track_moving = false
    }

    if (msg.track_movable_fast !== undefined) {
      resolved.track_movable_fast = msg.track_movable_fast;
    }
    else {
      resolved.track_movable_fast = false
    }

    if (msg.track_movable_slow !== undefined) {
      resolved.track_movable_slow = msg.track_movable_slow;
    }
    else {
      resolved.track_movable_slow = false
    }

    if (msg.track_power !== undefined) {
      resolved.track_power = msg.track_power;
    }
    else {
      resolved.track_power = 0
    }

    return resolved;
    }
};

module.exports = EsrMotionPower;
