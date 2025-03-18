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

class Steering2Report {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.vehicle_curvature_actual = null;
      this.steer_torque_driver = null;
      this.steer_torque_motor = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('vehicle_curvature_actual')) {
        this.vehicle_curvature_actual = initObj.vehicle_curvature_actual
      }
      else {
        this.vehicle_curvature_actual = 0.0;
      }
      if (initObj.hasOwnProperty('steer_torque_driver')) {
        this.steer_torque_driver = initObj.steer_torque_driver
      }
      else {
        this.steer_torque_driver = 0.0;
      }
      if (initObj.hasOwnProperty('steer_torque_motor')) {
        this.steer_torque_motor = initObj.steer_torque_motor
      }
      else {
        this.steer_torque_motor = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Steering2Report
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [vehicle_curvature_actual]
    bufferOffset = _serializer.float32(obj.vehicle_curvature_actual, buffer, bufferOffset);
    // Serialize message field [steer_torque_driver]
    bufferOffset = _serializer.float32(obj.steer_torque_driver, buffer, bufferOffset);
    // Serialize message field [steer_torque_motor]
    bufferOffset = _serializer.float32(obj.steer_torque_motor, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Steering2Report
    let len;
    let data = new Steering2Report(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [vehicle_curvature_actual]
    data.vehicle_curvature_actual = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steer_torque_driver]
    data.steer_torque_driver = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steer_torque_motor]
    data.steer_torque_motor = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/Steering2Report';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '009145df632b20263fd61a2cbd47cc87';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 vehicle_curvature_actual # units are 1/m
    float32 steer_torque_driver
    float32 steer_torque_motor
    
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
    const resolved = new Steering2Report(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.vehicle_curvature_actual !== undefined) {
      resolved.vehicle_curvature_actual = msg.vehicle_curvature_actual;
    }
    else {
      resolved.vehicle_curvature_actual = 0.0
    }

    if (msg.steer_torque_driver !== undefined) {
      resolved.steer_torque_driver = msg.steer_torque_driver;
    }
    else {
      resolved.steer_torque_driver = 0.0
    }

    if (msg.steer_torque_motor !== undefined) {
      resolved.steer_torque_motor = msg.steer_torque_motor;
    }
    else {
      resolved.steer_torque_motor = 0.0
    }

    return resolved;
    }
};

module.exports = Steering2Report;
