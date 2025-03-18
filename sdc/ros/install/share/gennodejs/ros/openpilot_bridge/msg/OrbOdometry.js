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

class OrbOdometry {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.endMonoTime = null;
      this.err = null;
      this.f = null;
      this.matches = null;
      this.inliers = null;
      this.startMonoTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('endMonoTime')) {
        this.endMonoTime = initObj.endMonoTime
      }
      else {
        this.endMonoTime = 0;
      }
      if (initObj.hasOwnProperty('err')) {
        this.err = initObj.err
      }
      else {
        this.err = 0.0;
      }
      if (initObj.hasOwnProperty('f')) {
        this.f = initObj.f
      }
      else {
        this.f = [];
      }
      if (initObj.hasOwnProperty('matches')) {
        this.matches = initObj.matches
      }
      else {
        this.matches = [];
      }
      if (initObj.hasOwnProperty('inliers')) {
        this.inliers = initObj.inliers
      }
      else {
        this.inliers = 0;
      }
      if (initObj.hasOwnProperty('startMonoTime')) {
        this.startMonoTime = initObj.startMonoTime
      }
      else {
        this.startMonoTime = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbOdometry
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [endMonoTime]
    bufferOffset = _serializer.int64(obj.endMonoTime, buffer, bufferOffset);
    // Serialize message field [err]
    bufferOffset = _serializer.float32(obj.err, buffer, bufferOffset);
    // Serialize message field [f]
    bufferOffset = _arraySerializer.float32(obj.f, buffer, bufferOffset, null);
    // Serialize message field [matches]
    bufferOffset = _arraySerializer.int32(obj.matches, buffer, bufferOffset, null);
    // Serialize message field [inliers]
    bufferOffset = _serializer.int32(obj.inliers, buffer, bufferOffset);
    // Serialize message field [startMonoTime]
    bufferOffset = _serializer.int64(obj.startMonoTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbOdometry
    let len;
    let data = new OrbOdometry(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [endMonoTime]
    data.endMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [err]
    data.err = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [f]
    data.f = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [matches]
    data.matches = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [inliers]
    data.inliers = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [startMonoTime]
    data.startMonoTime = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.f.length;
    length += 4 * object.matches.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbOdometry';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '36d7f564012932b3e82132f0ca864b87';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 endMonoTime
    float32 err
    float32[] f
    int32[] matches
    int32 inliers
    int64 startMonoTime
    
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
    const resolved = new OrbOdometry(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.endMonoTime !== undefined) {
      resolved.endMonoTime = msg.endMonoTime;
    }
    else {
      resolved.endMonoTime = 0
    }

    if (msg.err !== undefined) {
      resolved.err = msg.err;
    }
    else {
      resolved.err = 0.0
    }

    if (msg.f !== undefined) {
      resolved.f = msg.f;
    }
    else {
      resolved.f = []
    }

    if (msg.matches !== undefined) {
      resolved.matches = msg.matches;
    }
    else {
      resolved.matches = []
    }

    if (msg.inliers !== undefined) {
      resolved.inliers = msg.inliers;
    }
    else {
      resolved.inliers = 0
    }

    if (msg.startMonoTime !== undefined) {
      resolved.startMonoTime = msg.startMonoTime;
    }
    else {
      resolved.startMonoTime = 0
    }

    return resolved;
    }
};

module.exports = OrbOdometry;
