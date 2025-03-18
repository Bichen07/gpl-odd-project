// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ActuatorControlMode = require('./ActuatorControlMode.js');

//-----------------------------------------------------------

class AcceleratorPedalCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pedal_cmd = null;
      this.torque_cmd = null;
      this.speed_cmd = null;
      this.enable = null;
      this.ignore = null;
      this.rolling_counter = null;
      this.road_slope = null;
      this.control_type = null;
      this.accel_cmd_checksum = null;
      this.accel_limit = null;
      this.pos_jerk_limit = null;
    }
    else {
      if (initObj.hasOwnProperty('pedal_cmd')) {
        this.pedal_cmd = initObj.pedal_cmd
      }
      else {
        this.pedal_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('torque_cmd')) {
        this.torque_cmd = initObj.torque_cmd
      }
      else {
        this.torque_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('speed_cmd')) {
        this.speed_cmd = initObj.speed_cmd
      }
      else {
        this.speed_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('enable')) {
        this.enable = initObj.enable
      }
      else {
        this.enable = false;
      }
      if (initObj.hasOwnProperty('ignore')) {
        this.ignore = initObj.ignore
      }
      else {
        this.ignore = false;
      }
      if (initObj.hasOwnProperty('rolling_counter')) {
        this.rolling_counter = initObj.rolling_counter
      }
      else {
        this.rolling_counter = 0;
      }
      if (initObj.hasOwnProperty('road_slope')) {
        this.road_slope = initObj.road_slope
      }
      else {
        this.road_slope = 0.0;
      }
      if (initObj.hasOwnProperty('control_type')) {
        this.control_type = initObj.control_type
      }
      else {
        this.control_type = new ActuatorControlMode();
      }
      if (initObj.hasOwnProperty('accel_cmd_checksum')) {
        this.accel_cmd_checksum = initObj.accel_cmd_checksum
      }
      else {
        this.accel_cmd_checksum = 0.0;
      }
      if (initObj.hasOwnProperty('accel_limit')) {
        this.accel_limit = initObj.accel_limit
      }
      else {
        this.accel_limit = 0.0;
      }
      if (initObj.hasOwnProperty('pos_jerk_limit')) {
        this.pos_jerk_limit = initObj.pos_jerk_limit
      }
      else {
        this.pos_jerk_limit = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AcceleratorPedalCmd
    // Serialize message field [pedal_cmd]
    bufferOffset = _serializer.float32(obj.pedal_cmd, buffer, bufferOffset);
    // Serialize message field [torque_cmd]
    bufferOffset = _serializer.float32(obj.torque_cmd, buffer, bufferOffset);
    // Serialize message field [speed_cmd]
    bufferOffset = _serializer.float32(obj.speed_cmd, buffer, bufferOffset);
    // Serialize message field [enable]
    bufferOffset = _serializer.bool(obj.enable, buffer, bufferOffset);
    // Serialize message field [ignore]
    bufferOffset = _serializer.bool(obj.ignore, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [road_slope]
    bufferOffset = _serializer.float32(obj.road_slope, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    // Serialize message field [accel_cmd_checksum]
    bufferOffset = _serializer.float32(obj.accel_cmd_checksum, buffer, bufferOffset);
    // Serialize message field [accel_limit]
    bufferOffset = _serializer.float32(obj.accel_limit, buffer, bufferOffset);
    // Serialize message field [pos_jerk_limit]
    bufferOffset = _serializer.float32(obj.pos_jerk_limit, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AcceleratorPedalCmd
    let len;
    let data = new AcceleratorPedalCmd(null);
    // Deserialize message field [pedal_cmd]
    data.pedal_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque_cmd]
    data.torque_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed_cmd]
    data.speed_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enable]
    data.enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ignore]
    data.ignore = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [road_slope]
    data.road_slope = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [accel_cmd_checksum]
    data.accel_cmd_checksum = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accel_limit]
    data.accel_limit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pos_jerk_limit]
    data.pos_jerk_limit = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/AcceleratorPedalCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a1a82e02e150ecb7c85bb191a9e67d46';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Accelerator pedal (%)
    float32 pedal_cmd
    
    float32 torque_cmd # %-torque
    
    float32 speed_cmd # m/s
    
    # Enable
    bool enable
    
    # Ignore driver overrides
    bool ignore
    
    # Watchdog counter (optional)
    uint8 rolling_counter
    
    float32 road_slope # degrees - used with speed mode
    
    ActuatorControlMode control_type
    
    float32 accel_cmd_checksum
    
    float32 accel_limit
    
    float32 pos_jerk_limit
    
    ================================================================================
    MSG: dbw_pacifica_msgs/ActuatorControlMode
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
    const resolved = new AcceleratorPedalCmd(null);
    if (msg.pedal_cmd !== undefined) {
      resolved.pedal_cmd = msg.pedal_cmd;
    }
    else {
      resolved.pedal_cmd = 0.0
    }

    if (msg.torque_cmd !== undefined) {
      resolved.torque_cmd = msg.torque_cmd;
    }
    else {
      resolved.torque_cmd = 0.0
    }

    if (msg.speed_cmd !== undefined) {
      resolved.speed_cmd = msg.speed_cmd;
    }
    else {
      resolved.speed_cmd = 0.0
    }

    if (msg.enable !== undefined) {
      resolved.enable = msg.enable;
    }
    else {
      resolved.enable = false
    }

    if (msg.ignore !== undefined) {
      resolved.ignore = msg.ignore;
    }
    else {
      resolved.ignore = false
    }

    if (msg.rolling_counter !== undefined) {
      resolved.rolling_counter = msg.rolling_counter;
    }
    else {
      resolved.rolling_counter = 0
    }

    if (msg.road_slope !== undefined) {
      resolved.road_slope = msg.road_slope;
    }
    else {
      resolved.road_slope = 0.0
    }

    if (msg.control_type !== undefined) {
      resolved.control_type = ActuatorControlMode.Resolve(msg.control_type)
    }
    else {
      resolved.control_type = new ActuatorControlMode()
    }

    if (msg.accel_cmd_checksum !== undefined) {
      resolved.accel_cmd_checksum = msg.accel_cmd_checksum;
    }
    else {
      resolved.accel_cmd_checksum = 0.0
    }

    if (msg.accel_limit !== undefined) {
      resolved.accel_limit = msg.accel_limit;
    }
    else {
      resolved.accel_limit = 0.0
    }

    if (msg.pos_jerk_limit !== undefined) {
      resolved.pos_jerk_limit = msg.pos_jerk_limit;
    }
    else {
      resolved.pos_jerk_limit = 0.0
    }

    return resolved;
    }
};

module.exports = AcceleratorPedalCmd;
