// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ParkingBrake = require('./ParkingBrake.js');
let ActuatorControlMode = require('./ActuatorControlMode.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class BrakeReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.pedal_position = null;
      this.pedal_output = null;
      this.enabled = null;
      this.driver_activity = null;
      this.fault_brake_system = null;
      this.fault_ch1 = null;
      this.fault_ch2 = null;
      this.rolling_counter = null;
      this.brake_torque_actual = null;
      this.intervention_active = null;
      this.intervention_ready = null;
      this.parking_brake = null;
      this.control_type = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('pedal_position')) {
        this.pedal_position = initObj.pedal_position
      }
      else {
        this.pedal_position = 0.0;
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
      if (initObj.hasOwnProperty('driver_activity')) {
        this.driver_activity = initObj.driver_activity
      }
      else {
        this.driver_activity = false;
      }
      if (initObj.hasOwnProperty('fault_brake_system')) {
        this.fault_brake_system = initObj.fault_brake_system
      }
      else {
        this.fault_brake_system = false;
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
      if (initObj.hasOwnProperty('brake_torque_actual')) {
        this.brake_torque_actual = initObj.brake_torque_actual
      }
      else {
        this.brake_torque_actual = 0.0;
      }
      if (initObj.hasOwnProperty('intervention_active')) {
        this.intervention_active = initObj.intervention_active
      }
      else {
        this.intervention_active = false;
      }
      if (initObj.hasOwnProperty('intervention_ready')) {
        this.intervention_ready = initObj.intervention_ready
      }
      else {
        this.intervention_ready = false;
      }
      if (initObj.hasOwnProperty('parking_brake')) {
        this.parking_brake = initObj.parking_brake
      }
      else {
        this.parking_brake = new ParkingBrake();
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
    // Serializes a message object of type BrakeReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [pedal_position]
    bufferOffset = _serializer.float32(obj.pedal_position, buffer, bufferOffset);
    // Serialize message field [pedal_output]
    bufferOffset = _serializer.float32(obj.pedal_output, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    // Serialize message field [driver_activity]
    bufferOffset = _serializer.bool(obj.driver_activity, buffer, bufferOffset);
    // Serialize message field [fault_brake_system]
    bufferOffset = _serializer.bool(obj.fault_brake_system, buffer, bufferOffset);
    // Serialize message field [fault_ch1]
    bufferOffset = _serializer.bool(obj.fault_ch1, buffer, bufferOffset);
    // Serialize message field [fault_ch2]
    bufferOffset = _serializer.bool(obj.fault_ch2, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [brake_torque_actual]
    bufferOffset = _serializer.float32(obj.brake_torque_actual, buffer, bufferOffset);
    // Serialize message field [intervention_active]
    bufferOffset = _serializer.bool(obj.intervention_active, buffer, bufferOffset);
    // Serialize message field [intervention_ready]
    bufferOffset = _serializer.bool(obj.intervention_ready, buffer, bufferOffset);
    // Serialize message field [parking_brake]
    bufferOffset = ParkingBrake.serialize(obj.parking_brake, buffer, bufferOffset);
    // Serialize message field [control_type]
    bufferOffset = ActuatorControlMode.serialize(obj.control_type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BrakeReport
    let len;
    let data = new BrakeReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [pedal_position]
    data.pedal_position = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pedal_output]
    data.pedal_output = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [driver_activity]
    data.driver_activity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_brake_system]
    data.fault_brake_system = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_ch1]
    data.fault_ch1 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fault_ch2]
    data.fault_ch2 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_torque_actual]
    data.brake_torque_actual = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [intervention_active]
    data.intervention_active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [intervention_ready]
    data.intervention_ready = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [parking_brake]
    data.parking_brake = ParkingBrake.deserialize(buffer, bufferOffset);
    // Deserialize message field [control_type]
    data.control_type = ActuatorControlMode.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 22;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/BrakeReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c23e437775db686330778b5ba5b0b41b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Brake pedal (%)
    float32 pedal_position
    float32 pedal_output
    
    # Status
    bool enabled  # Enabled
    bool driver_activity   # Driver activity
    
    bool fault_brake_system
    
    # Faults
    bool fault_ch1
    bool fault_ch2
    
    uint8 rolling_counter
    
    float32 brake_torque_actual # 0 to 100%
    
    # Anti-lock Brakes and  Stability Control
    bool intervention_active
    bool intervention_ready
    
    # Parking Brake
    ParkingBrake parking_brake
    
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
    MSG: dbw_pacifica_msgs/ParkingBrake
    uint8 status
    
    uint8 RESERVED=0
    uint8 OFF=1
    uint8 ON=2
    uint8 FAULT=3
    
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
    const resolved = new BrakeReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.pedal_position !== undefined) {
      resolved.pedal_position = msg.pedal_position;
    }
    else {
      resolved.pedal_position = 0.0
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

    if (msg.driver_activity !== undefined) {
      resolved.driver_activity = msg.driver_activity;
    }
    else {
      resolved.driver_activity = false
    }

    if (msg.fault_brake_system !== undefined) {
      resolved.fault_brake_system = msg.fault_brake_system;
    }
    else {
      resolved.fault_brake_system = false
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

    if (msg.brake_torque_actual !== undefined) {
      resolved.brake_torque_actual = msg.brake_torque_actual;
    }
    else {
      resolved.brake_torque_actual = 0.0
    }

    if (msg.intervention_active !== undefined) {
      resolved.intervention_active = msg.intervention_active;
    }
    else {
      resolved.intervention_active = false
    }

    if (msg.intervention_ready !== undefined) {
      resolved.intervention_ready = msg.intervention_ready;
    }
    else {
      resolved.intervention_ready = false
    }

    if (msg.parking_brake !== undefined) {
      resolved.parking_brake = ParkingBrake.Resolve(msg.parking_brake)
    }
    else {
      resolved.parking_brake = new ParkingBrake()
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

module.exports = BrakeReport;
