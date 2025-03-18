// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PointArray = require('./PointArray.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PointSet {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.left_lane = null;
      this.right_lane = null;
      this.next_left_lane = null;
      this.next_right_lane = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('left_lane')) {
        this.left_lane = initObj.left_lane
      }
      else {
        this.left_lane = new PointArray();
      }
      if (initObj.hasOwnProperty('right_lane')) {
        this.right_lane = initObj.right_lane
      }
      else {
        this.right_lane = new PointArray();
      }
      if (initObj.hasOwnProperty('next_left_lane')) {
        this.next_left_lane = initObj.next_left_lane
      }
      else {
        this.next_left_lane = new PointArray();
      }
      if (initObj.hasOwnProperty('next_right_lane')) {
        this.next_right_lane = initObj.next_right_lane
      }
      else {
        this.next_right_lane = new PointArray();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PointSet
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [left_lane]
    bufferOffset = PointArray.serialize(obj.left_lane, buffer, bufferOffset);
    // Serialize message field [right_lane]
    bufferOffset = PointArray.serialize(obj.right_lane, buffer, bufferOffset);
    // Serialize message field [next_left_lane]
    bufferOffset = PointArray.serialize(obj.next_left_lane, buffer, bufferOffset);
    // Serialize message field [next_right_lane]
    bufferOffset = PointArray.serialize(obj.next_right_lane, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PointSet
    let len;
    let data = new PointSet(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [left_lane]
    data.left_lane = PointArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [right_lane]
    data.right_lane = PointArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [next_left_lane]
    data.next_left_lane = PointArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [next_right_lane]
    data.next_right_lane = PointArray.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += PointArray.getMessageSize(object.left_lane);
    length += PointArray.getMessageSize(object.right_lane);
    length += PointArray.getMessageSize(object.next_left_lane);
    length += PointArray.getMessageSize(object.next_right_lane);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/PointSet';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '23be87864922d3c27fd77ea6bdfa8034';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    PointArray left_lane
    PointArray right_lane
    PointArray next_left_lane
    PointArray next_right_lane
    
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
    MSG: itri_msgs/PointArray
    geometry_msgs/Point[] points
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PointSet(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.left_lane !== undefined) {
      resolved.left_lane = PointArray.Resolve(msg.left_lane)
    }
    else {
      resolved.left_lane = new PointArray()
    }

    if (msg.right_lane !== undefined) {
      resolved.right_lane = PointArray.Resolve(msg.right_lane)
    }
    else {
      resolved.right_lane = new PointArray()
    }

    if (msg.next_left_lane !== undefined) {
      resolved.next_left_lane = PointArray.Resolve(msg.next_left_lane)
    }
    else {
      resolved.next_left_lane = new PointArray()
    }

    if (msg.next_right_lane !== undefined) {
      resolved.next_right_lane = PointArray.Resolve(msg.next_right_lane)
    }
    else {
      resolved.next_right_lane = new PointArray()
    }

    return resolved;
    }
};

module.exports = PointSet;
