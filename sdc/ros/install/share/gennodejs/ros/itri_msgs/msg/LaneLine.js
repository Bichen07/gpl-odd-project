// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LanePoly = require('./LanePoly.js');

//-----------------------------------------------------------

class LaneLine {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.left_line = null;
      this.right_line = null;
    }
    else {
      if (initObj.hasOwnProperty('left_line')) {
        this.left_line = initObj.left_line
      }
      else {
        this.left_line = new LanePoly();
      }
      if (initObj.hasOwnProperty('right_line')) {
        this.right_line = initObj.right_line
      }
      else {
        this.right_line = new LanePoly();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LaneLine
    // Serialize message field [left_line]
    bufferOffset = LanePoly.serialize(obj.left_line, buffer, bufferOffset);
    // Serialize message field [right_line]
    bufferOffset = LanePoly.serialize(obj.right_line, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LaneLine
    let len;
    let data = new LaneLine(null);
    // Deserialize message field [left_line]
    data.left_line = LanePoly.deserialize(buffer, bufferOffset);
    // Deserialize message field [right_line]
    data.right_line = LanePoly.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += LanePoly.getMessageSize(object.left_line);
    length += LanePoly.getMessageSize(object.right_line);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/LaneLine';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'df0610fafa5521c03719095763a8f984';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    LanePoly left_line
    LanePoly right_line
    
    ================================================================================
    MSG: itri_msgs/LanePoly
    std_msgs/Header header
    float32 c0
    float32 c1
    float32 c2
    float32 c3
    
    uint16 confidentScore
    float32 distance
    float32 width
    float32 right_bound
    float32 left_bound
    float32 prob
    
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
    const resolved = new LaneLine(null);
    if (msg.left_line !== undefined) {
      resolved.left_line = LanePoly.Resolve(msg.left_line)
    }
    else {
      resolved.left_line = new LanePoly()
    }

    if (msg.right_line !== undefined) {
      resolved.right_line = LanePoly.Resolve(msg.right_line)
    }
    else {
      resolved.right_line = new LanePoly()
    }

    return resolved;
    }
};

module.exports = LaneLine;
