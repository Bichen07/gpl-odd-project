// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Gear = require('./Gear.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class GearReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.state = null;
      this.reject = null;
      this.driver_activity = null;
      this.enabled = null;
      this.gear_select_system_fault = null;
      this.trans_cur_gear = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = new Gear();
      }
      if (initObj.hasOwnProperty('reject')) {
        this.reject = initObj.reject
      }
      else {
        this.reject = false;
      }
      if (initObj.hasOwnProperty('driver_activity')) {
        this.driver_activity = initObj.driver_activity
      }
      else {
        this.driver_activity = false;
      }
      if (initObj.hasOwnProperty('enabled')) {
        this.enabled = initObj.enabled
      }
      else {
        this.enabled = false;
      }
      if (initObj.hasOwnProperty('gear_select_system_fault')) {
        this.gear_select_system_fault = initObj.gear_select_system_fault
      }
      else {
        this.gear_select_system_fault = false;
      }
      if (initObj.hasOwnProperty('trans_cur_gear')) {
        this.trans_cur_gear = initObj.trans_cur_gear
      }
      else {
        this.trans_cur_gear = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GearReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = Gear.serialize(obj.state, buffer, bufferOffset);
    // Serialize message field [reject]
    bufferOffset = _serializer.bool(obj.reject, buffer, bufferOffset);
    // Serialize message field [driver_activity]
    bufferOffset = _serializer.bool(obj.driver_activity, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    // Serialize message field [gear_select_system_fault]
    bufferOffset = _serializer.bool(obj.gear_select_system_fault, buffer, bufferOffset);
    // Serialize message field [trans_cur_gear]
    bufferOffset = _serializer.uint8(obj.trans_cur_gear, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GearReport
    let len;
    let data = new GearReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = Gear.deserialize(buffer, bufferOffset);
    // Deserialize message field [reject]
    data.reject = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [driver_activity]
    data.driver_activity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gear_select_system_fault]
    data.gear_select_system_fault = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [trans_cur_gear]
    data.trans_cur_gear = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/GearReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '82edf69509597cc6f96e7ba84e5d0077';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Current gear enumeration
    Gear state
    
    # Gear reject flag
    bool reject
    
    # Status
    bool driver_activity
    bool enabled
    
    # Faults
    bool gear_select_system_fault
    
    #TransCurGear
    uint8 trans_cur_gear
    
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
    MSG: dbw_pacifica_msgs/Gear
    uint8 gear
    
    uint8 NONE=0
    uint8 PARK=1
    uint8 REVERSE=2
    uint8 NEUTRAL=3
    uint8 DRIVE=4
    uint8 LOW=5
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GearReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.state !== undefined) {
      resolved.state = Gear.Resolve(msg.state)
    }
    else {
      resolved.state = new Gear()
    }

    if (msg.reject !== undefined) {
      resolved.reject = msg.reject;
    }
    else {
      resolved.reject = false
    }

    if (msg.driver_activity !== undefined) {
      resolved.driver_activity = msg.driver_activity;
    }
    else {
      resolved.driver_activity = false
    }

    if (msg.enabled !== undefined) {
      resolved.enabled = msg.enabled;
    }
    else {
      resolved.enabled = false
    }

    if (msg.gear_select_system_fault !== undefined) {
      resolved.gear_select_system_fault = msg.gear_select_system_fault;
    }
    else {
      resolved.gear_select_system_fault = false
    }

    if (msg.trans_cur_gear !== undefined) {
      resolved.trans_cur_gear = msg.trans_cur_gear;
    }
    else {
      resolved.trans_cur_gear = 0
    }

    return resolved;
    }
};

module.exports = GearReport;
