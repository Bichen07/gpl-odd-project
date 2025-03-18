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

class AndroidLogEntry {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.pid = null;
      this.ts = null;
      this.priority = null;
      this.tag = null;
      this.tid = null;
      this.message = null;
      this.id = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('pid')) {
        this.pid = initObj.pid
      }
      else {
        this.pid = 0;
      }
      if (initObj.hasOwnProperty('ts')) {
        this.ts = initObj.ts
      }
      else {
        this.ts = 0;
      }
      if (initObj.hasOwnProperty('priority')) {
        this.priority = initObj.priority
      }
      else {
        this.priority = 0;
      }
      if (initObj.hasOwnProperty('tag')) {
        this.tag = initObj.tag
      }
      else {
        this.tag = [];
      }
      if (initObj.hasOwnProperty('tid')) {
        this.tid = initObj.tid
      }
      else {
        this.tid = 0;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = [];
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AndroidLogEntry
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [pid]
    bufferOffset = _serializer.int32(obj.pid, buffer, bufferOffset);
    // Serialize message field [ts]
    bufferOffset = _serializer.int64(obj.ts, buffer, bufferOffset);
    // Serialize message field [priority]
    bufferOffset = _serializer.int64(obj.priority, buffer, bufferOffset);
    // Serialize message field [tag]
    bufferOffset = _arraySerializer.string(obj.tag, buffer, bufferOffset, null);
    // Serialize message field [tid]
    bufferOffset = _serializer.int32(obj.tid, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _arraySerializer.string(obj.message, buffer, bufferOffset, null);
    // Serialize message field [id]
    bufferOffset = _serializer.int64(obj.id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AndroidLogEntry
    let len;
    let data = new AndroidLogEntry(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [pid]
    data.pid = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [ts]
    data.ts = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [priority]
    data.priority = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [tag]
    data.tag = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [tid]
    data.tid = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [id]
    data.id = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.tag.forEach((val) => {
      length += 4 + val.length;
    });
    object.message.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AndroidLogEntry';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4b124521ab088e83f9d361692dbf5495';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 pid
    int64 ts
    int64 priority
    string[] tag
    int32 tid
    string[] message
    int64 id
    
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
    const resolved = new AndroidLogEntry(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.pid !== undefined) {
      resolved.pid = msg.pid;
    }
    else {
      resolved.pid = 0
    }

    if (msg.ts !== undefined) {
      resolved.ts = msg.ts;
    }
    else {
      resolved.ts = 0
    }

    if (msg.priority !== undefined) {
      resolved.priority = msg.priority;
    }
    else {
      resolved.priority = 0
    }

    if (msg.tag !== undefined) {
      resolved.tag = msg.tag;
    }
    else {
      resolved.tag = []
    }

    if (msg.tid !== undefined) {
      resolved.tid = msg.tid;
    }
    else {
      resolved.tid = 0
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = []
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    return resolved;
    }
};

module.exports = AndroidLogEntry;
