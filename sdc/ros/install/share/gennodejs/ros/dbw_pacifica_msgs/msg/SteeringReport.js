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
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class SteeringReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.steering_wheel_angle = null;
      this.steering_wheel_angle_cmd = null;
      this.steering_wheel_torque = null;
      this.enabled = null;
      this.driver_activity = null;
      this.fault_steering_system = null;
      this.overheat_prevention_mode = null;
      this.rolling_counter = null;
      this.control_type = null;
      this.steering_over_heat_warning = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('steering_wheel_angle')) {
        this.steering_wheel_angle = initObj.steering_wheel_angle
      }
      else {
        this.steering_wheel_angle = 0.0;
      }
      if (initObj.hasOwnProperty('steering_wheel_angle_cmd')) {
        this.steering_wheel_angle_cmd = initObj.steering_wheel_angle_cmd
      }
      else {
        this.steering_wheel_angle_cmd = 0.0;
      }
      if (initObj.hasOwnProperty('steering_wheel_torque')) {
        this.steering_wheel_torque = initObj.steering_wheel_torque
      }
      else {
        this.steering_wheel_torque = 0.0;
      }
      if (initObj.hasOwnProperty('enabled')) {
        this.enabled = initObj.enabled
      }
      else {
        this.enabled = false;
      }
      if (initObj.hasOwnProperty('driver_activity')) {
        this.driver_activity = initObj.driver_activity
      }
      else {
        this.driver_activity = false;
      }
      if (initObj.hasOwnProperty('fault_steering_system')) {
        this.fault_steering_system = initObj.fault_steering_system
      }
      else {
        this.fault_steering_system = false;
      }
      if (initObj.hasOwnProperty('overheat_prevention_mode')) {
        this.overheat_prevention_mode = initObj.overheat_prevention_mode
      }
      else {
        this.overheat_prevention_mode = false;
      }
      if (initObj.hasOwnProperty('rolling_counter')) {
        this.rolling_counter = initObj.rolling_counter
      }
      else {
        this.rolling_counter = 0;
      }
      if (initObj.hasOwnProperty('control_type')) {
        this.control_type = initObj.control_type
      }
      else {
        this.control_type = new ActuatorControlMode();
      }
      if (initObj.hasOwnProperty('steering_over_heat_warning')) {
        this.steering_over_heat_warning = initObj.steering_over_heat_warning
      }
      else {
        this.steering_over_heat_warning = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SteeringReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [steering_wheel_angle]
    bufferOffset = _serializer.float32(obj.steering_wheel_angle, buffer, bufferOffset);
    // Serialize message field [steering_wheel_angle_cmd]
    bufferOffset = _serializer.float32(obj.steering_wheel_angle_cmd, buffer, bufferOffset);
    // Serialize message field [steering_wheel_torque]
    bufferOffset = _serializer.float32(obj.steering_wheel_torque, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    // Serialize message field [driver_activity]
    bufferOffset = _serializer.bool(obj.driver_activity, buffer, bufferOffset);
    // Serialize message field [fault_steering_system]
    bufferOffset = _serializer.bool(obj.fault_steering_system, buffer, bufferOffset);
    // Serialize message field [overheat_prevention_mode]
    bufferOffset = _serializer.bool(obj.overheat_prevention_mode, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    // Serialize message field [steering_over_heat_warning]
    bufferOffset = _serializer.bool(obj.steering_over_heat_warning, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SteeringReport
    let len;
    let data = new SteeringReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [steering_wheel_angle]
    data.steering_wheel_angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steering_wheel_angle_cmd]
    data.steering_wheel_angle_cmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steering_wheel_torque]
    data.steering_wheel_torque = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [driver_activity]
    data.driver_activity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_steering_system]
    data.fault_steering_system = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [overheat_prevention_mode]
    data.overheat_prevention_mode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [steering_over_heat_warning]
    data.steering_over_heat_warning = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 19;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/SteeringReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3d804816a4b20624da24c6e1d360c70b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Steering Wheel
    float32 steering_wheel_angle      # degrees
    float32 steering_wheel_angle_cmd  # degrees
    float32 steering_wheel_torque     # 0 to 100%
    
    # Status
    bool enabled
    bool driver_activity
    
    bool fault_steering_system
    
    bool overheat_prevention_mode
    
    uint8 rolling_counter
    
    ActuatorControlMode control_type
    
    bool steering_over_heat_warning
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
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
    const resolved = new SteeringReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.steering_wheel_angle !== undefined) {
      resolved.steering_wheel_angle = msg.steering_wheel_angle;
    }
    else {
      resolved.steering_wheel_angle = 0.0
    }

    if (msg.steering_wheel_angle_cmd !== undefined) {
      resolved.steering_wheel_angle_cmd = msg.steering_wheel_angle_cmd;
    }
    else {
      resolved.steering_wheel_angle_cmd = 0.0
    }

    if (msg.steering_wheel_torque !== undefined) {
      resolved.steering_wheel_torque = msg.steering_wheel_torque;
    }
    else {
      resolved.steering_wheel_torque = 0.0
    }

    if (msg.enabled !== undefined) {
      resolved.enabled = msg.enabled;
    }
    else {
      resolved.enabled = false
    }

    if (msg.driver_activity !== undefined) {
      resolved.driver_activity = msg.driver_activity;
    }
    else {
      resolved.driver_activity = false
    }

    if (msg.fault_steering_system !== undefined) {
      resolved.fault_steering_system = msg.fault_steering_system;
    }
    else {
      resolved.fault_steering_system = false
    }

    if (msg.overheat_prevention_mode !== undefined) {
      resolved.overheat_prevention_mode = msg.overheat_prevention_mode;
    }
    else {
      resolved.overheat_prevention_mode = false
    }

    if (msg.rolling_counter !== undefined) {
      resolved.rolling_counter = msg.rolling_counter;
    }
    else {
      resolved.rolling_counter = 0
    }

    if (msg.control_type !== undefined) {
      resolved.control_type = ActuatorControlMode.Resolve(msg.control_type)
    }
    else {
      resolved.control_type = new ActuatorControlMode()
    }

    if (msg.steering_over_heat_warning !== undefined) {
      resolved.steering_over_heat_warning = msg.steering_over_heat_warning;
    }
    else {
      resolved.steering_over_heat_warning = false
    }

    return resolved;
    }
};

module.exports = SteeringReport;
