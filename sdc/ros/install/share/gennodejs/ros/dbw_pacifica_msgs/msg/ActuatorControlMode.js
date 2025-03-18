// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ActuatorControlMode {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ActuatorControlMode
    // Serialize message field [value]
    bufferOffset = _serializer.uint8(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ActuatorControlMode
    let len;
    let data = new ActuatorControlMode(null);
    // Deserialize message field [value]
    data.value = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/ActuatorControlMode';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1994ebf1d0f443ac1da4b214c3affc7f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 value
    
    uint8 open_loop = 0
    uint8 closed_loop_actuator = 1
    uint8 closed_loop_vehicle = 2
    uint8 none = 255
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ActuatorControlMode(null);
    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = 0
    }

    return resolved;
    }
};

// Constants for message
ActuatorControlMode.Constants = {
  OPEN_LOOP: 0,
  CLOSED_LOOP_ACTUATOR: 1,
  CLOSED_LOOP_VEHICLE: 2,
  NONE: 255,
}

module.exports = ActuatorControlMode;
