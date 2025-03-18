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

class SteeringCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.angle_cmd = null;
      this.angle_velocity = null;
      this.enable = null;
      this.ignore = null;
      this.rolling_counter = null;
      this.torque_cmd = null;
      this.vehicle_curvature_cmd = null;
      this.control_type = null;
      this.steering_cmd_checksum = null;
    }
    else {
      if (initObj.hasOwnProperty('angle_cmd')) {
        this.angle_cmd = initObj.angle_cmd
      }
      else {
        this.angle_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('angle_velocity')) {
        this.angle_velocity = initObj.angle_velocity
      }
      else {
        this.angle_velocity = 0.0;
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
      if (initObj.hasOwnProperty('torque_cmd')) {
        this.torque_cmd = initObj.torque_cmd
      }
      else {
        this.torque_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('vehicle_curvature_cmd')) {
        this.vehicle_curvature_cmd = initObj.vehicle_curvature_cmd
      }
      else {
        this.vehicle_curvature_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('control_type')) {
        this.control_type = initObj.control_type
      }
      else {
        this.control_type = new ActuatorControlMode();
      }
      if (initObj.hasOwnProperty('steering_cmd_checksum')) {
        this.steering_cmd_checksum = initObj.steering_cmd_checksum
      }
      else {
        this.steering_cmd_checksum = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SteeringCmd
    // Serialize message field [angle_cmd]
    bufferOffset = _serializer.float32(obj.angle_cmd, buffer, bufferOffset);
    // Serialize message field [angle_velocity]
    bufferOffset = _serializer.float32(obj.angle_velocity, buffer, bufferOffset);
    // Serialize message field [enable]
    bufferOffset = _serializer.bool(obj.enable, buffer, bufferOffset);
    // Serialize message field [ignore]
    bufferOffset = _serializer.bool(obj.ignore, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [torque_cmd]
    bufferOffset = _serializer.float32(obj.torque_cmd, buffer, bufferOffset);
    // Serialize message field [vehicle_curvature_cmd]
    bufferOffset = _serializer.float32(obj.vehicle_curvature_cmd, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    // Serialize message field [steering_cmd_checksum]
    bufferOffset = _serializer.float32(obj.steering_cmd_checksum, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SteeringCmd
    let len;
    let data = new SteeringCmd(null);
    // Deserialize message field [angle_cmd]
    data.angle_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angle_velocity]
    data.angle_velocity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enable]
    data.enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ignore]
    data.ignore = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [torque_cmd]
    data.torque_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vehicle_curvature_cmd]
    data.vehicle_curvature_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [steering_cmd_checksum]
    data.steering_cmd_checksum = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/SteeringCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '01afefccdc79bc13944f883510af8807';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Steering Wheel
    float32 angle_cmd        # degrees, range -500 to 500
    float32 angle_velocity   # degrees/s, range 0 to 498, 0 = maximum
    
    # Enable
    bool enable
    
    # Ignore driver overrides
    bool ignore
    
    # Watchdog counter (optional)
    uint8 rolling_counter
    
    float32 torque_cmd # %-torque
    
    float32 vehicle_curvature_cmd # 1/m
    
    ActuatorControlMode control_type
    
    float32 steering_cmd_checksum
    
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
    const resolved = new SteeringCmd(null);
    if (msg.angle_cmd !== undefined) {
      resolved.angle_cmd = msg.angle_cmd;
    }
    else {
      resolved.angle_cmd = 0.0
    }

    if (msg.angle_velocity !== undefined) {
      resolved.angle_velocity = msg.angle_velocity;
    }
    else {
      resolved.angle_velocity = 0.0
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

    if (msg.torque_cmd !== undefined) {
      resolved.torque_cmd = msg.torque_cmd;
    }
    else {
      resolved.torque_cmd = 0.0
    }

    if (msg.vehicle_curvature_cmd !== undefined) {
      resolved.vehicle_curvature_cmd = msg.vehicle_curvature_cmd;
    }
    else {
      resolved.vehicle_curvature_cmd = 0.0
    }

    if (msg.control_type !== undefined) {
      resolved.control_type = ActuatorControlMode.Resolve(msg.control_type)
    }
    else {
      resolved.control_type = new ActuatorControlMode()
    }

    if (msg.steering_cmd_checksum !== undefined) {
      resolved.steering_cmd_checksum = msg.steering_cmd_checksum;
    }
    else {
      resolved.steering_cmd_checksum = 0.0
    }

    return resolved;
    }
};

module.exports = SteeringCmd;
