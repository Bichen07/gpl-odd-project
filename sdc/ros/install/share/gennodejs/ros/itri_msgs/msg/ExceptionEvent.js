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

class ExceptionEvent {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.event = null;
    }
    else {
      if (initObj.hasOwnProperty('event')) {
        this.event = initObj.event
      }
      else {
        this.event = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExceptionEvent
    // Serialize message field [event]
    bufferOffset = _serializer.uint32(obj.event, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExceptionEvent
    let len;
    let data = new ExceptionEvent(null);
    // Deserialize message field [event]
    data.event = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/ExceptionEvent';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8fe25700fd3ceb690ea90fb4ee026e1d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # exception event
    uint8 NORMAL = 0
    uint8 HARD_BRAKE = 1
    uint8 MILD_BRAKE = 2
    uint8 DETOUR     = 3
    uint8 PULL_OVER  = 4
    uint8 TIME_OUT  = 5
    
    uint32 event
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExceptionEvent(null);
    if (msg.event !== undefined) {
      resolved.event = msg.event;
    }
    else {
      resolved.event = 0
    }

    return resolved;
    }
};

// Constants for message
ExceptionEvent.Constants = {
  NORMAL: 0,
  HARD_BRAKE: 1,
  MILD_BRAKE: 2,
  DETOUR: 3,
  PULL_OVER: 4,
  TIME_OUT: 5,
}

module.exports = ExceptionEvent;
