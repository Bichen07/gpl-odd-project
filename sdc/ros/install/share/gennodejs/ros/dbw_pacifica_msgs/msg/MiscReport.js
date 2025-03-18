// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MiscReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.fuel_level = null;
      this.drive_by_wire_enabled = null;
      this.vehicle_speed = null;
      this.software_build_number = null;
      this.general_actuator_fault = null;
      this.by_wire_ready = null;
      this.general_driver_activity = null;
      this.comms_fault = null;
      this.ambient_temp = null;
      this.vehicle_ready_to_drive = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('fuel_level')) {
        this.fuel_level = initObj.fuel_level
      }
      else {
        this.fuel_level = 0.0;
      }
      if (initObj.hasOwnProperty('drive_by_wire_enabled')) {
        this.drive_by_wire_enabled = initObj.drive_by_wire_enabled
      }
      else {
        this.drive_by_wire_enabled = false;
      }
      if (initObj.hasOwnProperty('vehicle_speed')) {
        this.vehicle_speed = initObj.vehicle_speed
      }
      else {
        this.vehicle_speed = 0.0;
      }
      if (initObj.hasOwnProperty('software_build_number')) {
        this.software_build_number = initObj.software_build_number
      }
      else {
        this.software_build_number = 0;
      }
      if (initObj.hasOwnProperty('general_actuator_fault')) {
        this.general_actuator_fault = initObj.general_actuator_fault
      }
      else {
        this.general_actuator_fault = false;
      }
      if (initObj.hasOwnProperty('by_wire_ready')) {
        this.by_wire_ready = initObj.by_wire_ready
      }
      else {
        this.by_wire_ready = false;
      }
      if (initObj.hasOwnProperty('general_driver_activity')) {
        this.general_driver_activity = initObj.general_driver_activity
      }
      else {
        this.general_driver_activity = false;
      }
      if (initObj.hasOwnProperty('comms_fault')) {
        this.comms_fault = initObj.comms_fault
      }
      else {
        this.comms_fault = false;
      }
      if (initObj.hasOwnProperty('ambient_temp')) {
        this.ambient_temp = initObj.ambient_temp
      }
      else {
        this.ambient_temp = 0.0;
      }
      if (initObj.hasOwnProperty('vehicle_ready_to_drive')) {
        this.vehicle_ready_to_drive = initObj.vehicle_ready_to_drive
      }
      else {
        this.vehicle_ready_to_drive = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MiscReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [fuel_level]
    bufferOffset = _serializer.float32(obj.fuel_level, buffer, bufferOffset);
    // Serialize message field [drive_by_wire_enabled]
    bufferOffset = _serializer.bool(obj.drive_by_wire_enabled, buffer, bufferOffset);
    // Serialize message field [vehicle_speed]
    bufferOffset = _serializer.float32(obj.vehicle_speed, buffer, bufferOffset);
    // Serialize message field [software_build_number]
    bufferOffset = _serializer.uint16(obj.software_build_number, buffer, bufferOffset);
    // Serialize message field [general_actuator_fault]
    bufferOffset = _serializer.bool(obj.general_actuator_fault, buffer, bufferOffset);
    // Serialize message field [by_wire_ready]
    bufferOffset = _serializer.bool(obj.by_wire_ready, buffer, bufferOffset);
    // Serialize message field [general_driver_activity]
    bufferOffset = _serializer.bool(obj.general_driver_activity, buffer, bufferOffset);
    // Serialize message field [comms_fault]
    bufferOffset = _serializer.bool(obj.comms_fault, buffer, bufferOffset);
    // Serialize message field [ambient_temp]
    bufferOffset = _serializer.float32(obj.ambient_temp, buffer, bufferOffset);
    // Serialize message field [vehicle_ready_to_drive]
    bufferOffset = _serializer.bool(obj.vehicle_ready_to_drive, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MiscReport
    let len;
    let data = new MiscReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [fuel_level]
    data.fuel_level = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [drive_by_wire_enabled]
    data.drive_by_wire_enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vehicle_speed]
    data.vehicle_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [software_build_number]
    data.software_build_number = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [general_actuator_fault]
    data.general_actuator_fault = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [by_wire_ready]
    data.by_wire_ready = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [general_driver_activity]
    data.general_driver_activity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [comms_fault]
    data.comms_fault = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ambient_temp]
    data.ambient_temp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vehicle_ready_to_drive]
    data.vehicle_ready_to_drive = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/MiscReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '07d2b659403a0cbd241b5457fee2e270';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 fuel_level          # %
    bool drive_by_wire_enabled
    float32 vehicle_speed       # km/h
    uint16 software_build_number
    bool general_actuator_fault
    bool by_wire_ready
    bool general_driver_activity
    bool comms_fault
    float32 ambient_temp # degrees-C
    bool vehicle_ready_to_drive
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MiscReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.fuel_level !== undefined) {
      resolved.fuel_level = msg.fuel_level;
    }
    else {
      resolved.fuel_level = 0.0
    }

    if (msg.drive_by_wire_enabled !== undefined) {
      resolved.drive_by_wire_enabled = msg.drive_by_wire_enabled;
    }
    else {
      resolved.drive_by_wire_enabled = false
    }

    if (msg.vehicle_speed !== undefined) {
      resolved.vehicle_speed = msg.vehicle_speed;
    }
    else {
      resolved.vehicle_speed = 0.0
    }

    if (msg.software_build_number !== undefined) {
      resolved.software_build_number = msg.software_build_number;
    }
    else {
      resolved.software_build_number = 0
    }

    if (msg.general_actuator_fault !== undefined) {
      resolved.general_actuator_fault = msg.general_actuator_fault;
    }
    else {
      resolved.general_actuator_fault = false
    }

    if (msg.by_wire_ready !== undefined) {
      resolved.by_wire_ready = msg.by_wire_ready;
    }
    else {
      resolved.by_wire_ready = false
    }

    if (msg.general_driver_activity !== undefined) {
      resolved.general_driver_activity = msg.general_driver_activity;
    }
    else {
      resolved.general_driver_activity = false
    }

    if (msg.comms_fault !== undefined) {
      resolved.comms_fault = msg.comms_fault;
    }
    else {
      resolved.comms_fault = false
    }

    if (msg.ambient_temp !== undefined) {
      resolved.ambient_temp = msg.ambient_temp;
    }
    else {
      resolved.ambient_temp = 0.0
    }

    if (msg.vehicle_ready_to_drive !== undefined) {
      resolved.vehicle_ready_to_drive = msg.vehicle_ready_to_drive;
    }
    else {
      resolved.vehicle_ready_to_drive = false
    }

    return resolved;
    }
};

module.exports = MiscReport;
