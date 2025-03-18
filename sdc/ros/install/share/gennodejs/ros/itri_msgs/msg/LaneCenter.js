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

class LaneCenter {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.c0 = null;
      this.c1 = null;
      this.c2 = null;
      this.confidentScore = null;
      this.distance = null;
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LaneCenter
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [c0]
    bufferOffset = _serializer.float32(obj.c0, buffer, bufferOffset);
    // Serialize message field [c1]
    bufferOffset = _serializer.float32(obj.c1, buffer, bufferOffset);
    // Serialize message field [c2]
    bufferOffset = _serializer.float32(obj.c2, buffer, bufferOffset);
    // Serialize message field [confidentScore]
    bufferOffset = _serializer.uint16(obj.confidentScore, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float32(obj.distance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LaneCenter
    let len;
    let data = new LaneCenter(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [c0]
    data.c0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [c1]
    data.c1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [c2]
    data.c2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [confidentScore]
    data.confidentScore = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 18;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/LaneCenter';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '38aa69826866b610620ed64a00faddfa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    float32 c0
    float32 c1
    float32 c2
    
    uint16 confidentScore
    float32 distance
    
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
    const resolved = new LaneCenter(null);
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

    return resolved;
    }
};

module.exports = LaneCenter;
