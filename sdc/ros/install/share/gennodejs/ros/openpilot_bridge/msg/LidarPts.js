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

class LidarPts {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.reflect = null;
      this.theta = null;
      this.r = null;
      this.pkt = null;
      this.idx = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('reflect')) {
        this.reflect = initObj.reflect
      }
      else {
        this.reflect = [];
      }
      if (initObj.hasOwnProperty('theta')) {
        this.theta = initObj.theta
      }
      else {
        this.theta = [];
      }
      if (initObj.hasOwnProperty('r')) {
        this.r = initObj.r
      }
      else {
        this.r = [];
      }
      if (initObj.hasOwnProperty('pkt')) {
        this.pkt = initObj.pkt
      }
      else {
        this.pkt = [];
      }
      if (initObj.hasOwnProperty('idx')) {
        this.idx = initObj.idx
      }
      else {
        this.idx = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LidarPts
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [reflect]
    bufferOffset = _arraySerializer.int64(obj.reflect, buffer, bufferOffset, null);
    // Serialize message field [theta]
    bufferOffset = _arraySerializer.int64(obj.theta, buffer, bufferOffset, null);
    // Serialize message field [r]
    bufferOffset = _arraySerializer.int64(obj.r, buffer, bufferOffset, null);
    // Serialize message field [pkt]
    bufferOffset = _arraySerializer.string(obj.pkt, buffer, bufferOffset, null);
    // Serialize message field [idx]
    bufferOffset = _serializer.int64(obj.idx, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LidarPts
    let len;
    let data = new LidarPts(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [reflect]
    data.reflect = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [theta]
    data.theta = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [r]
    data.r = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [pkt]
    data.pkt = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [idx]
    data.idx = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 8 * object.reflect.length;
    length += 8 * object.theta.length;
    length += 8 * object.r.length;
    object.pkt.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LidarPts';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'da97df91c5556c584248994eba8b3d23';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64[] reflect
    int64[] theta
    int64[] r
    string[] pkt
    int64 idx
    
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
    const resolved = new LidarPts(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.reflect !== undefined) {
      resolved.reflect = msg.reflect;
    }
    else {
      resolved.reflect = []
    }

    if (msg.theta !== undefined) {
      resolved.theta = msg.theta;
    }
    else {
      resolved.theta = []
    }

    if (msg.r !== undefined) {
      resolved.r = msg.r;
    }
    else {
      resolved.r = []
    }

    if (msg.pkt !== undefined) {
      resolved.pkt = msg.pkt;
    }
    else {
      resolved.pkt = []
    }

    if (msg.idx !== undefined) {
      resolved.idx = msg.idx;
    }
    else {
      resolved.idx = 0
    }

    return resolved;
    }
};

module.exports = LidarPts;
