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

class FaultActionsReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.auto_disable_no_brakes = null;
      this.auto_disable_apply_brakes = null;
      this.dbw_can_gateway_disable = null;
      this.inverter_cnt_control_disable = null;
      this.prevent_enter_auto_mode = null;
      this.warn_driver_only = null;
      this.chime_fcw_beeps = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('auto_disable_no_brakes')) {
        this.auto_disable_no_brakes = initObj.auto_disable_no_brakes
      }
      else {
        this.auto_disable_no_brakes = false;
      }
      if (initObj.hasOwnProperty('auto_disable_apply_brakes')) {
        this.auto_disable_apply_brakes = initObj.auto_disable_apply_brakes
      }
      else {
        this.auto_disable_apply_brakes = false;
      }
      if (initObj.hasOwnProperty('dbw_can_gateway_disable')) {
        this.dbw_can_gateway_disable = initObj.dbw_can_gateway_disable
      }
      else {
        this.dbw_can_gateway_disable = false;
      }
      if (initObj.hasOwnProperty('inverter_cnt_control_disable')) {
        this.inverter_cnt_control_disable = initObj.inverter_cnt_control_disable
      }
      else {
        this.inverter_cnt_control_disable = false;
      }
      if (initObj.hasOwnProperty('prevent_enter_auto_mode')) {
        this.prevent_enter_auto_mode = initObj.prevent_enter_auto_mode
      }
      else {
        this.prevent_enter_auto_mode = false;
      }
      if (initObj.hasOwnProperty('warn_driver_only')) {
        this.warn_driver_only = initObj.warn_driver_only
      }
      else {
        this.warn_driver_only = false;
      }
      if (initObj.hasOwnProperty('chime_fcw_beeps')) {
        this.chime_fcw_beeps = initObj.chime_fcw_beeps
      }
      else {
        this.chime_fcw_beeps = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FaultActionsReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [auto_disable_no_brakes]
    bufferOffset = _serializer.bool(obj.auto_disable_no_brakes, buffer, bufferOffset);
    // Serialize message field [auto_disable_apply_brakes]
    bufferOffset = _serializer.bool(obj.auto_disable_apply_brakes, buffer, bufferOffset);
    // Serialize message field [dbw_can_gateway_disable]
    bufferOffset = _serializer.bool(obj.dbw_can_gateway_disable, buffer, bufferOffset);
    // Serialize message field [inverter_cnt_control_disable]
    bufferOffset = _serializer.bool(obj.inverter_cnt_control_disable, buffer, bufferOffset);
    // Serialize message field [prevent_enter_auto_mode]
    bufferOffset = _serializer.bool(obj.prevent_enter_auto_mode, buffer, bufferOffset);
    // Serialize message field [warn_driver_only]
    bufferOffset = _serializer.bool(obj.warn_driver_only, buffer, bufferOffset);
    // Serialize message field [chime_fcw_beeps]
    bufferOffset = _serializer.bool(obj.chime_fcw_beeps, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FaultActionsReport
    let len;
    let data = new FaultActionsReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [auto_disable_no_brakes]
    data.auto_disable_no_brakes = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [auto_disable_apply_brakes]
    data.auto_disable_apply_brakes = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [dbw_can_gateway_disable]
    data.dbw_can_gateway_disable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [inverter_cnt_control_disable]
    data.inverter_cnt_control_disable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [prevent_enter_auto_mode]
    data.prevent_enter_auto_mode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [warn_driver_only]
    data.warn_driver_only = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [chime_fcw_beeps]
    data.chime_fcw_beeps = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 7;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/FaultActionsReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c21ae693be0418da6826534ee549449c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool auto_disable_no_brakes
    bool auto_disable_apply_brakes
    bool dbw_can_gateway_disable
    bool inverter_cnt_control_disable
    bool prevent_enter_auto_mode
    bool warn_driver_only
    bool chime_fcw_beeps
    
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
    const resolved = new FaultActionsReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.auto_disable_no_brakes !== undefined) {
      resolved.auto_disable_no_brakes = msg.auto_disable_no_brakes;
    }
    else {
      resolved.auto_disable_no_brakes = false
    }

    if (msg.auto_disable_apply_brakes !== undefined) {
      resolved.auto_disable_apply_brakes = msg.auto_disable_apply_brakes;
    }
    else {
      resolved.auto_disable_apply_brakes = false
    }

    if (msg.dbw_can_gateway_disable !== undefined) {
      resolved.dbw_can_gateway_disable = msg.dbw_can_gateway_disable;
    }
    else {
      resolved.dbw_can_gateway_disable = false
    }

    if (msg.inverter_cnt_control_disable !== undefined) {
      resolved.inverter_cnt_control_disable = msg.inverter_cnt_control_disable;
    }
    else {
      resolved.inverter_cnt_control_disable = false
    }

    if (msg.prevent_enter_auto_mode !== undefined) {
      resolved.prevent_enter_auto_mode = msg.prevent_enter_auto_mode;
    }
    else {
      resolved.prevent_enter_auto_mode = false
    }

    if (msg.warn_driver_only !== undefined) {
      resolved.warn_driver_only = msg.warn_driver_only;
    }
    else {
      resolved.warn_driver_only = false
    }

    if (msg.chime_fcw_beeps !== undefined) {
      resolved.chime_fcw_beeps = msg.chime_fcw_beeps;
    }
    else {
      resolved.chime_fcw_beeps = false
    }

    return resolved;
    }
};

module.exports = FaultActionsReport;
