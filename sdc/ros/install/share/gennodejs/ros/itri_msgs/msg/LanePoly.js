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

class LanePoly {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.c0 = null;
      this.c1 = null;
      this.c2 = null;
      this.c3 = null;
      this.confidentScore = null;
      this.distance = null;
      this.width = null;
      this.right_bound = null;
      this.left_bound = null;
      this.prob = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('c0')) {
        this.c0 = initObj.c0
      }
      else {
        this.c0 = 0.0;
      }
      if (initObj.hasOwnProperty('c1')) {
        this.c1 = initObj.c1
      }
      else {
        this.c1 = 0.0;
      }
      if (initObj.hasOwnProperty('c2')) {
        this.c2 = initObj.c2
      }
      else {
        this.c2 = 0.0;
      }
      if (initObj.hasOwnProperty('c3')) {
        this.c3 = initObj.c3
      }
      else {
        this.c3 = 0.0;
      }
      if (initObj.hasOwnProperty('confidentScore')) {
        this.confidentScore = initObj.confidentScore
      }
      else {
        this.confidentScore = 0;
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
      if (initObj.hasOwnProperty('right_bound')) {
        this.right_bound = initObj.right_bound
      }
      else {
        this.right_bound = 0.0;
      }
      if (initObj.hasOwnProperty('left_bound')) {
        this.left_bound = initObj.left_bound
      }
      else {
        this.left_bound = 0.0;
      }
      if (initObj.hasOwnProperty('prob')) {
        this.prob = initObj.prob
      }
      else {
        this.prob = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LanePoly
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [c0]
    bufferOffset = _serializer.float32(obj.c0, buffer, bufferOffset);
    // Serialize message field [c1]
    bufferOffset = _serializer.float32(obj.c1, buffer, bufferOffset);
    // Serialize message field [c2]
    bufferOffset = _serializer.float32(obj.c2, buffer, bufferOffset);
    // Serialize message field [c3]
    bufferOffset = _serializer.float32(obj.c3, buffer, bufferOffset);
    // Serialize message field [confidentScore]
    bufferOffset = _serializer.uint16(obj.confidentScore, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float32(obj.distance, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float32(obj.width, buffer, bufferOffset);
    // Serialize message field [right_bound]
    bufferOffset = _serializer.float32(obj.right_bound, buffer, bufferOffset);
    // Serialize message field [left_bound]
    bufferOffset = _serializer.float32(obj.left_bound, buffer, bufferOffset);
    // Serialize message field [prob]
    bufferOffset = _serializer.float32(obj.prob, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LanePoly
    let len;
    let data = new LanePoly(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [c0]
    data.c0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [c1]
    data.c1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [c2]
    data.c2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [c3]
    data.c3 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [confidentScore]
    data.confidentScore = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [right_bound]
    data.right_bound = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [left_bound]
    data.left_bound = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [prob]
    data.prob = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 38;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/LanePoly';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e989af5a3e269fb4013d6d80ce03fad4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new LanePoly(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.c0 !== undefined) {
      resolved.c0 = msg.c0;
    }
    else {
      resolved.c0 = 0.0
    }

    if (msg.c1 !== undefined) {
      resolved.c1 = msg.c1;
    }
    else {
      resolved.c1 = 0.0
    }

    if (msg.c2 !== undefined) {
      resolved.c2 = msg.c2;
    }
    else {
      resolved.c2 = 0.0
    }

    if (msg.c3 !== undefined) {
      resolved.c3 = msg.c3;
    }
    else {
      resolved.c3 = 0.0
    }

    if (msg.confidentScore !== undefined) {
      resolved.confidentScore = msg.confidentScore;
    }
    else {
      resolved.confidentScore = 0
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    if (msg.right_bound !== undefined) {
      resolved.right_bound = msg.right_bound;
    }
    else {
      resolved.right_bound = 0.0
    }

    if (msg.left_bound !== undefined) {
      resolved.left_bound = msg.left_bound;
    }
    else {
      resolved.left_bound = 0.0
    }

    if (msg.prob !== undefined) {
      resolved.prob = msg.prob;
    }
    else {
      resolved.prob = 0.0
    }

    return resolved;
    }
};

module.exports = LanePoly;
