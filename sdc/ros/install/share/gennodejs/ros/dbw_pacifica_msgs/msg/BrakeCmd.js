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
let ParkingBrkReq = require('./ParkingBrkReq.js');

//-----------------------------------------------------------

class BrakeCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pedal_cmd = null;
      this.enable = null;
      this.rolling_counter = null;
      this.torque_cmd = null;
      this.accel_limit = null;
      this.decel_limit = null;
      this.control_type = null;
      this.brake_cmd_checksum = null;
      this.parking_brake_req = null;
    }
    else {
      if (initObj.hasOwnProperty('pedal_cmd')) {
        this.pedal_cmd = initObj.pedal_cmd
      }
      else {
        this.pedal_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('enable')) {
        this.enable = initObj.enable
      }
      else {
        this.enable = false;
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
      if (initObj.hasOwnProperty('accel_limit')) {
        this.accel_limit = initObj.accel_limit
      }
      else {
        this.accel_limit = 0.0;
      }
      if (initObj.hasOwnProperty('decel_limit')) {
        this.decel_limit = initObj.decel_limit
      }
      else {
        this.decel_limit = 0.0;
      }
      if (initObj.hasOwnProperty('control_type')) {
        this.control_type = initObj.control_type
      }
      else {
        this.control_type = new ActuatorControlMode();
      }
      if (initObj.hasOwnProperty('brake_cmd_checksum')) {
        this.brake_cmd_checksum = initObj.brake_cmd_checksum
      }
      else {
        this.brake_cmd_checksum = 0.0;
      }
      if (initObj.hasOwnProperty('parking_brake_req')) {
        this.parking_brake_req = initObj.parking_brake_req
      }
      else {
        this.parking_brake_req = new ParkingBrkReq();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BrakeCmd
    // Serialize message field [pedal_cmd]
    bufferOffset = _serializer.float32(obj.pedal_cmd, buffer, bufferOffset);
    // Serialize message field [enable]
    bufferOffset = _serializer.bool(obj.enable, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [torque_cmd]
    bufferOffset = _serializer.float32(obj.torque_cmd, buffer, bufferOffset);
    // Serialize message field [accel_limit]
    bufferOffset = _serializer.float32(obj.accel_limit, buffer, bufferOffset);
    // Serialize message field [decel_limit]
    bufferOffset = _serializer.float32(obj.decel_limit, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    // Serialize message field [brake_cmd_checksum]
    bufferOffset = _serializer.float32(obj.brake_cmd_checksum, buffer, bufferOffset);
    // Serialize message field [parking_brake_req]
    bufferOffset = ParkingBrkReq.serialize(obj.parking_brake_req, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BrakeCmd
    let len;
    let data = new BrakeCmd(null);
    // Deserialize message field [pedal_cmd]
    data.pedal_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enable]
    data.enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [torque_cmd]
    data.torque_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accel_limit]
    data.accel_limit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [decel_limit]
    data.decel_limit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [brake_cmd_checksum]
    data.brake_cmd_checksum = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [parking_brake_req]
    data.parking_brake_req = ParkingBrkReq.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/BrakeCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'df5046f02deb0972bd5ea27261595bc6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Brake pedal (%)
    float32 pedal_cmd
    
    # Enable
    bool enable
    
    # Watchdog counter (optional)
    uint8 rolling_counter
    
    float32 torque_cmd # %-torque
    float32 accel_limit # m/s^2
    float32 decel_limit # m/s^2
    
    ActuatorControlMode control_type
    
    float32 brake_cmd_checksum
    
    ParkingBrkReq parking_brake_req
    
    ================================================================================
    MSG: dbw_pacifica_msgs/ActuatorControlMode
    uint8 value
    
    uint8 open_loop = 0
    uint8 closed_loop_actuator = 1
    uint8 closed_loop_vehicle = 2
    uint8 none = 255
    ================================================================================
    MSG: dbw_pacifica_msgs/ParkingBrkReq
    uint8 value
    
    uint8 NO_REQUEST=0
    uint8 OFF=1
    uint8 ON=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BrakeCmd(null);
    if (msg.pedal_cmd !== undefined) {
      resolved.pedal_cmd = msg.pedal_cmd;
    }
    else {
      resolved.pedal_cmd = 0.0
    }

    if (msg.enable !== undefined) {
      resolved.enable = msg.enable;
    }
    else {
      resolved.enable = false
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

    if (msg.accel_limit !== undefined) {
      resolved.accel_limit = msg.accel_limit;
    }
    else {
      resolved.accel_limit = 0.0
    }

    if (msg.decel_limit !== undefined) {
      resolved.decel_limit = msg.decel_limit;
    }
    else {
      resolved.decel_limit = 0.0
    }

    if (msg.control_type !== undefined) {
      resolved.control_type = ActuatorControlMode.Resolve(msg.control_type)
    }
    else {
      resolved.control_type = new ActuatorControlMode()
    }

    if (msg.brake_cmd_checksum !== undefined) {
      resolved.brake_cmd_checksum = msg.brake_cmd_checksum;
    }
    else {
      resolved.brake_cmd_checksum = 0.0
    }

    if (msg.parking_brake_req !== undefined) {
      resolved.parking_brake_req = ParkingBrkReq.Resolve(msg.parking_brake_req)
    }
    else {
      resolved.parking_brake_req = new ParkingBrkReq()
    }

    return resolved;
    }
};

module.exports = BrakeCmd;
