// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Diagnostic {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.error_check = null;
      this.error_type = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('error_check')) {
        this.error_check = initObj.error_check
      }
      else {
        this.error_check = 0.0;
      }
      if (initObj.hasOwnProperty('error_type')) {
        this.error_type = initObj.error_type
      }
      else {
        this.error_type = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Diagnostic
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [error_check]
    bufferOffset = _serializer.float64(obj.error_check, buffer, bufferOffset);
    // Serialize message field [error_type]
    bufferOffset = _arraySerializer.uint32(obj.error_type, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Diagnostic
    let len;
    let data = new Diagnostic(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [error_check]
    data.error_check = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [error_type]
    data.error_type = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.error_type.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Diagnostic';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd6d59fac2aa89b7edcb4e4b955ef5683';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float64 error_check 
    uint32[] error_type
    
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
    const resolved = new Diagnostic(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.error_check !== undefined) {
      resolved.error_check = msg.error_check;
    }
    else {
      resolved.error_check = 0.0
    }

    if (msg.error_type !== undefined) {
      resolved.error_type = msg.error_type;
    }
    else {
      resolved.error_type = []
    }

    return resolved;
    }
};

module.exports = Diagnostic;
