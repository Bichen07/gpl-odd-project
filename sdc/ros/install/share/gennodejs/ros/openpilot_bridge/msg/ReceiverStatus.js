// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ReceiverStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.leapSecValid = null;
      this.clkReset = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('leapSecValid')) {
        this.leapSecValid = initObj.leapSecValid
      }
      else {
        this.leapSecValid = false;
      }
      if (initObj.hasOwnProperty('clkReset')) {
        this.clkReset = initObj.clkReset
      }
      else {
        this.clkReset = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ReceiverStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [leapSecValid]
    bufferOffset = _serializer.bool(obj.leapSecValid, buffer, bufferOffset);
    // Serialize message field [clkReset]
    bufferOffset = _serializer.bool(obj.clkReset, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ReceiverStatus
    let len;
    let data = new ReceiverStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [leapSecValid]
    data.leapSecValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [clkReset]
    data.clkReset = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 2;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ReceiverStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '37035768a9037c3faee5bf61b59c4cd4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool leapSecValid
    bool clkReset
    
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
    const resolved = new ReceiverStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.leapSecValid !== undefined) {
      resolved.leapSecValid = msg.leapSecValid;
    }
    else {
      resolved.leapSecValid = false
    }

    if (msg.clkReset !== undefined) {
      resolved.clkReset = msg.clkReset;
    }
    else {
      resolved.clkReset = false
    }

    return resolved;
    }
};

module.exports = ReceiverStatus;
