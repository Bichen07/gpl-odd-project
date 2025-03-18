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

class AcceleratorPedalReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.pedal_input = null;
      this.pedal_output = null;
      this.enabled = null;
      this.ignore_driver = null;
      this.driver_activity = null;
      this.fault_accel_pedal_system = null;
      this.fault_ch1 = null;
      this.fault_ch2 = null;
      this.rolling_counter = null;
      this.torque_actual = null;
      this.control_type = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('pedal_input')) {
        this.pedal_input = initObj.pedal_input
      }
      else {
        this.pedal_input = 0.0;
      }
      if (initObj.hasOwnProperty('pedal_output')) {
        this.pedal_output = initObj.pedal_output
      }
      else {
        this.pedal_output = 0.0;
      }
      if (initObj.hasOwnProperty('enabled')) {
        this.enabled = initObj.enabled
      }
      else {
        this.enabled = false;
      }
      if (initObj.hasOwnProperty('ignore_driver')) {
        this.ignore_driver = initObj.ignore_driver
      }
      else {
        this.ignore_driver = false;
      }
      if (initObj.hasOwnProperty('driver_activity')) {
        this.driver_activity = initObj.driver_activity
      }
      else {
        this.driver_activity = false;
      }
      if (initObj.hasOwnProperty('fault_accel_pedal_system')) {
        this.fault_accel_pedal_system = initObj.fault_accel_pedal_system
      }
      else {
        this.fault_accel_pedal_system = false;
      }
      if (initObj.hasOwnProperty('fault_ch1')) {
        this.fault_ch1 = initObj.fault_ch1
      }
      else {
        this.fault_ch1 = false;
      }
      if (initObj.hasOwnProperty('fault_ch2')) {
        this.fault_ch2 = initObj.fault_ch2
      }
      else {
        this.fault_ch2 = false;
      }
      if (initObj.hasOwnProperty('rolling_counter')) {
        this.rolling_counter = initObj.rolling_counter
      }
      else {
        this.rolling_counter = 0;
      }
      if (initObj.hasOwnProperty('torque_actual')) {
        this.torque_actual = initObj.torque_actual
      }
      else {
        this.torque_actual = 0.0;
      }
      if (initObj.hasOwnProperty('control_type')) {
        this.control_type = initObj.control_type
      }
      else {
        this.control_type = new ActuatorControlMode();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AcceleratorPedalReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [pedal_input]
    bufferOffset = _serializer.float32(obj.pedal_input, buffer, bufferOffset);
    // Serialize message field [pedal_output]
    bufferOffset = _serializer.float32(obj.pedal_output, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    // Serialize message field [ignore_driver]
    bufferOffset = _serializer.bool(obj.ignore_driver, buffer, bufferOffset);
    // Serialize message field [driver_activity]
    bufferOffset = _serializer.bool(obj.driver_activity, buffer, bufferOffset);
    // Serialize message field [fault_accel_pedal_system]
    bufferOffset = _serializer.bool(obj.fault_accel_pedal_system, buffer, bufferOffset);
    // Serialize message field [fault_ch1]
    bufferOffset = _serializer.bool(obj.fault_ch1, buffer, bufferOffset);
    // Serialize message field [fault_ch2]
    bufferOffset = _serializer.bool(obj.fault_ch2, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [torque_actual]
    bufferOffset = _serializer.float32(obj.torque_actual, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AcceleratorPedalReport
    let len;
    let data = new AcceleratorPedalReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [pedal_input]
    data.pedal_input = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pedal_output]
    data.pedal_output = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ignore_driver]
    data.ignore_driver = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [driver_activity]
    data.driver_activity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_accel_pedal_system]
    data.fault_accel_pedal_system = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_ch1]
    data.fault_ch1 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_ch2]
    data.fault_ch2 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [torque_actual]
    data.torque_actual = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/AcceleratorPedalReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '79e5f58f94a8fa77ed7d602d29d0230c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Accelerator pedal
    # 0 to 100%
    float32 pedal_input
    float32 pedal_output
    
    # Status
    bool enabled
    bool ignore_driver
    bool driver_activity   # Driver activity
    
    bool fault_accel_pedal_system
    
    # Faults
    bool fault_ch1
    bool fault_ch2
    
    uint8 rolling_counter
    
    float32 torque_actual # 0 to 100%
    
    ActuatorControlMode control_type
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
    const resolved = new AcceleratorPedalReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.pedal_input !== undefined) {
      resolved.pedal_input = msg.pedal_input;
    }
    else {
      resolved.pedal_input = 0.0
    }

    if (msg.pedal_output !== undefined) {
      resolved.pedal_output = msg.pedal_output;
    }
    else {
      resolved.pedal_output = 0.0
    }

    if (msg.enabled !== undefined) {
      resolved.enabled = msg.enabled;
    }
    else {
      resolved.enabled = false
    }

    if (msg.ignore_driver !== undefined) {
      resolved.ignore_driver = msg.ignore_driver;
    }
    else {
      resolved.ignore_driver = false
    }

    if (msg.driver_activity !== undefined) {
      resolved.driver_activity = msg.driver_activity;
    }
    else {
      resolved.driver_activity = false
    }

    if (msg.fault_accel_pedal_system !== undefined) {
      resolved.fault_accel_pedal_system = msg.fault_accel_pedal_system;
    }
    else {
      resolved.fault_accel_pedal_system = false
    }

    if (msg.fault_ch1 !== undefined) {
      resolved.fault_ch1 = msg.fault_ch1;
    }
    else {
      resolved.fault_ch1 = false
    }

    if (msg.fault_ch2 !== undefined) {
      resolved.fault_ch2 = msg.fault_ch2;
    }
    else {
      resolved.fault_ch2 = false
    }

    if (msg.rolling_counter !== undefined) {
      resolved.rolling_counter = msg.rolling_counter;
    }
    else {
      resolved.rolling_counter = 0
    }

    if (msg.torque_actual !== undefined) {
      resolved.torque_actual = msg.torque_actual;
    }
    else {
      resolved.torque_actual = 0.0
    }

    if (msg.control_type !== undefined) {
      resolved.control_type = ActuatorControlMode.Resolve(msg.control_type)
    }
    else {
      resolved.control_type = new ActuatorControlMode()
    }

    return resolved;
    }
};

module.exports = AcceleratorPedalReport;
