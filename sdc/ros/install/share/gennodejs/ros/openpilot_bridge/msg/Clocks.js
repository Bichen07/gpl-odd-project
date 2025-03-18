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

class Clocks {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.modemUptimeMillis = null;
      this.wallTimeNanos = null;
      this.bootTimeNanos = null;
      this.monotonicRawNanos = null;
      this.monotonicNanos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('modemUptimeMillis')) {
        this.modemUptimeMillis = initObj.modemUptimeMillis
      }
      else {
        this.modemUptimeMillis = 0;
      }
      if (initObj.hasOwnProperty('wallTimeNanos')) {
        this.wallTimeNanos = initObj.wallTimeNanos
      }
      else {
        this.wallTimeNanos = 0;
      }
      if (initObj.hasOwnProperty('bootTimeNanos')) {
        this.bootTimeNanos = initObj.bootTimeNanos
      }
      else {
        this.bootTimeNanos = 0;
      }
      if (initObj.hasOwnProperty('monotonicRawNanos')) {
        this.monotonicRawNanos = initObj.monotonicRawNanos
      }
      else {
        this.monotonicRawNanos = 0;
      }
      if (initObj.hasOwnProperty('monotonicNanos')) {
        this.monotonicNanos = initObj.monotonicNanos
      }
      else {
        this.monotonicNanos = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Clocks
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [modemUptimeMillis]
    bufferOffset = _serializer.int64(obj.modemUptimeMillis, buffer, bufferOffset);
    // Serialize message field [wallTimeNanos]
    bufferOffset = _serializer.int64(obj.wallTimeNanos, buffer, bufferOffset);
    // Serialize message field [bootTimeNanos]
    bufferOffset = _serializer.int64(obj.bootTimeNanos, buffer, bufferOffset);
    // Serialize message field [monotonicRawNanos]
    bufferOffset = _serializer.int64(obj.monotonicRawNanos, buffer, bufferOffset);
    // Serialize message field [monotonicNanos]
    bufferOffset = _serializer.int64(obj.monotonicNanos, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Clocks
    let len;
    let data = new Clocks(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [modemUptimeMillis]
    data.modemUptimeMillis = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [wallTimeNanos]
    data.wallTimeNanos = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bootTimeNanos]
    data.bootTimeNanos = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [monotonicRawNanos]
    data.monotonicRawNanos = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [monotonicNanos]
    data.monotonicNanos = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Clocks';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a00c35b464cff74388a274b01c607034';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 modemUptimeMillis
    int64 wallTimeNanos
    int64 bootTimeNanos
    int64 monotonicRawNanos
    int64 monotonicNanos
    
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
    const resolved = new Clocks(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.modemUptimeMillis !== undefined) {
      resolved.modemUptimeMillis = msg.modemUptimeMillis;
    }
    else {
      resolved.modemUptimeMillis = 0
    }

    if (msg.wallTimeNanos !== undefined) {
      resolved.wallTimeNanos = msg.wallTimeNanos;
    }
    else {
      resolved.wallTimeNanos = 0
    }

    if (msg.bootTimeNanos !== undefined) {
      resolved.bootTimeNanos = msg.bootTimeNanos;
    }
    else {
      resolved.bootTimeNanos = 0
    }

    if (msg.monotonicRawNanos !== undefined) {
      resolved.monotonicRawNanos = msg.monotonicRawNanos;
    }
    else {
      resolved.monotonicRawNanos = 0
    }

    if (msg.monotonicNanos !== undefined) {
      resolved.monotonicNanos = msg.monotonicNanos;
    }
    else {
      resolved.monotonicNanos = 0
    }

    return resolved;
    }
};

module.exports = Clocks;
