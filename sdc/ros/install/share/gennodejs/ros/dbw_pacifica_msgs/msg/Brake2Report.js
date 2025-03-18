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

class Brake2Report {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.brake_pressure = null;
      this.estimated_road_slope = null;
      this.speed_setpt = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('brake_pressure')) {
        this.brake_pressure = initObj.brake_pressure
      }
      else {
        this.brake_pressure = 0.0;
      }
      if (initObj.hasOwnProperty('estimated_road_slope')) {
        this.estimated_road_slope = initObj.estimated_road_slope
      }
      else {
        this.estimated_road_slope = 0.0;
      }
      if (initObj.hasOwnProperty('speed_setpt')) {
        this.speed_setpt = initObj.speed_setpt
      }
      else {
        this.speed_setpt = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Brake2Report
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [brake_pressure]
    bufferOffset = _serializer.float32(obj.brake_pressure, buffer, bufferOffset);
    // Serialize message field [estimated_road_slope]
    bufferOffset = _serializer.float32(obj.estimated_road_slope, buffer, bufferOffset);
    // Serialize message field [speed_setpt]
    bufferOffset = _serializer.float32(obj.speed_setpt, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Brake2Report
    let len;
    let data = new Brake2Report(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [brake_pressure]
    data.brake_pressure = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [estimated_road_slope]
    data.estimated_road_slope = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed_setpt]
    data.speed_setpt = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/Brake2Report';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8583a20888957d7b6a8c8423931dbe91';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 brake_pressure # units are bars, gauge pressure
    
    float32 estimated_road_slope # degrees
    
    float32 speed_setpt
    
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
    const resolved = new Brake2Report(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.brake_pressure !== undefined) {
      resolved.brake_pressure = msg.brake_pressure;
    }
    else {
      resolved.brake_pressure = 0.0
    }

    if (msg.estimated_road_slope !== undefined) {
      resolved.estimated_road_slope = msg.estimated_road_slope;
    }
    else {
      resolved.estimated_road_slope = 0.0
    }

    if (msg.speed_setpt !== undefined) {
      resolved.speed_setpt = msg.speed_setpt;
    }
    else {
      resolved.speed_setpt = 0.0
    }

    return resolved;
    }
};

module.exports = Brake2Report;
