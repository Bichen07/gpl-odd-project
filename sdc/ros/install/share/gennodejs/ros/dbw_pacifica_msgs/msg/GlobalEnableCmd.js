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

class GlobalEnableCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.global_enable = null;
      this.enable_joystick_limits = null;
      this.ecu_build_number = null;
      this.rolling_counter = null;
      this.global_cmd_checksum = null;
    }
    else {
      if (initObj.hasOwnProperty('global_enable')) {
        this.global_enable = initObj.global_enable
      }
      else {
        this.global_enable = false;
      }
      if (initObj.hasOwnProperty('enable_joystick_limits')) {
        this.enable_joystick_limits = initObj.enable_joystick_limits
      }
      else {
        this.enable_joystick_limits = false;
      }
      if (initObj.hasOwnProperty('ecu_build_number')) {
        this.ecu_build_number = initObj.ecu_build_number
      }
      else {
        this.ecu_build_number = 0;
      }
      if (initObj.hasOwnProperty('rolling_counter')) {
        this.rolling_counter = initObj.rolling_counter
      }
      else {
        this.rolling_counter = 0;
      }
      if (initObj.hasOwnProperty('global_cmd_checksum')) {
        this.global_cmd_checksum = initObj.global_cmd_checksum
      }
      else {
        this.global_cmd_checksum = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GlobalEnableCmd
    // Serialize message field [global_enable]
    bufferOffset = _serializer.bool(obj.global_enable, buffer, bufferOffset);
    // Serialize message field [enable_joystick_limits]
    bufferOffset = _serializer.bool(obj.enable_joystick_limits, buffer, bufferOffset);
    // Serialize message field [ecu_build_number]
    bufferOffset = _serializer.uint16(obj.ecu_build_number, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [global_cmd_checksum]
    bufferOffset = _serializer.float32(obj.global_cmd_checksum, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GlobalEnableCmd
    let len;
    let data = new GlobalEnableCmd(null);
    // Deserialize message field [global_enable]
    data.global_enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [enable_joystick_limits]
    data.enable_joystick_limits = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ecu_build_number]
    data.ecu_build_number = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [global_cmd_checksum]
    data.global_cmd_checksum = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/GlobalEnableCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6bed8b1974abe40f81a2b6c9d5a493f6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool global_enable
    
    bool enable_joystick_limits
    
    uint16 ecu_build_number
    
    uint8 rolling_counter
    
    float32 global_cmd_checksum
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GlobalEnableCmd(null);
    if (msg.global_enable !== undefined) {
      resolved.global_enable = msg.global_enable;
    }
    else {
      resolved.global_enable = false
    }

    if (msg.enable_joystick_limits !== undefined) {
      resolved.enable_joystick_limits = msg.enable_joystick_limits;
    }
    else {
      resolved.enable_joystick_limits = false
    }

    if (msg.ecu_build_number !== undefined) {
      resolved.ecu_build_number = msg.ecu_build_number;
    }
    else {
      resolved.ecu_build_number = 0
    }

    if (msg.rolling_counter !== undefined) {
      resolved.rolling_counter = msg.rolling_counter;
    }
    else {
      resolved.rolling_counter = 0
    }

    if (msg.global_cmd_checksum !== undefined) {
      resolved.global_cmd_checksum = msg.global_cmd_checksum;
    }
    else {
      resolved.global_cmd_checksum = 0.0
    }

    return resolved;
    }
};

module.exports = GlobalEnableCmd;
