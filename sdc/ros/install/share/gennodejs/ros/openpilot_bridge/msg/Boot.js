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

class Boot {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.wallTimeNanos = null;
      this.lastKmsg = null;
      this.lastPmsg = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('wallTimeNanos')) {
        this.wallTimeNanos = initObj.wallTimeNanos
      }
      else {
        this.wallTimeNanos = 0;
      }
      if (initObj.hasOwnProperty('lastKmsg')) {
        this.lastKmsg = initObj.lastKmsg
      }
      else {
        this.lastKmsg = [];
      }
      if (initObj.hasOwnProperty('lastPmsg')) {
        this.lastPmsg = initObj.lastPmsg
      }
      else {
        this.lastPmsg = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Boot
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [wallTimeNanos]
    bufferOffset = _serializer.int64(obj.wallTimeNanos, buffer, bufferOffset);
    // Serialize message field [lastKmsg]
    bufferOffset = _arraySerializer.string(obj.lastKmsg, buffer, bufferOffset, null);
    // Serialize message field [lastPmsg]
    bufferOffset = _arraySerializer.string(obj.lastPmsg, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Boot
    let len;
    let data = new Boot(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [wallTimeNanos]
    data.wallTimeNanos = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lastKmsg]
    data.lastKmsg = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [lastPmsg]
    data.lastPmsg = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.lastKmsg.forEach((val) => {
      length += 4 + val.length;
    });
    object.lastPmsg.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Boot';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7d01aef315d1640ba9089c1530d651c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 wallTimeNanos
    string[] lastKmsg
    string[] lastPmsg
    
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
    const resolved = new Boot(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.wallTimeNanos !== undefined) {
      resolved.wallTimeNanos = msg.wallTimeNanos;
    }
    else {
      resolved.wallTimeNanos = 0
    }

    if (msg.lastKmsg !== undefined) {
      resolved.lastKmsg = msg.lastKmsg;
    }
    else {
      resolved.lastKmsg = []
    }

    if (msg.lastPmsg !== undefined) {
      resolved.lastPmsg = msg.lastPmsg;
    }
    else {
      resolved.lastPmsg = []
    }

    return resolved;
    }
};

module.exports = Boot;
