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

class Mem {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.available = null;
      this.cached = null;
      this.free = null;
      this.inactive = null;
      this.active = null;
      this.shared = null;
      this.total = null;
      this.buffers = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('available')) {
        this.available = initObj.available
      }
      else {
        this.available = 0;
      }
      if (initObj.hasOwnProperty('cached')) {
        this.cached = initObj.cached
      }
      else {
        this.cached = 0;
      }
      if (initObj.hasOwnProperty('free')) {
        this.free = initObj.free
      }
      else {
        this.free = 0;
      }
      if (initObj.hasOwnProperty('inactive')) {
        this.inactive = initObj.inactive
      }
      else {
        this.inactive = 0;
      }
      if (initObj.hasOwnProperty('active')) {
        this.active = initObj.active
      }
      else {
        this.active = 0;
      }
      if (initObj.hasOwnProperty('shared')) {
        this.shared = initObj.shared
      }
      else {
        this.shared = 0;
      }
      if (initObj.hasOwnProperty('total')) {
        this.total = initObj.total
      }
      else {
        this.total = 0;
      }
      if (initObj.hasOwnProperty('buffers')) {
        this.buffers = initObj.buffers
      }
      else {
        this.buffers = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Mem
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [available]
    bufferOffset = _serializer.int64(obj.available, buffer, bufferOffset);
    // Serialize message field [cached]
    bufferOffset = _serializer.int64(obj.cached, buffer, bufferOffset);
    // Serialize message field [free]
    bufferOffset = _serializer.int64(obj.free, buffer, bufferOffset);
    // Serialize message field [inactive]
    bufferOffset = _serializer.int64(obj.inactive, buffer, bufferOffset);
    // Serialize message field [active]
    bufferOffset = _serializer.int64(obj.active, buffer, bufferOffset);
    // Serialize message field [shared]
    bufferOffset = _serializer.int64(obj.shared, buffer, bufferOffset);
    // Serialize message field [total]
    bufferOffset = _serializer.int64(obj.total, buffer, bufferOffset);
    // Serialize message field [buffers]
    bufferOffset = _serializer.int64(obj.buffers, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Mem
    let len;
    let data = new Mem(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [available]
    data.available = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cached]
    data.cached = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [free]
    data.free = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [inactive]
    data.inactive = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [active]
    data.active = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [shared]
    data.shared = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [total]
    data.total = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [buffers]
    data.buffers = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Mem';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '37047380061a5ca52ba6cf08ff779e8e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 available
    int64 cached
    int64 free
    int64 inactive
    int64 active
    int64 shared
    int64 total
    int64 buffers
    
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
    const resolved = new Mem(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.available !== undefined) {
      resolved.available = msg.available;
    }
    else {
      resolved.available = 0
    }

    if (msg.cached !== undefined) {
      resolved.cached = msg.cached;
    }
    else {
      resolved.cached = 0
    }

    if (msg.free !== undefined) {
      resolved.free = msg.free;
    }
    else {
      resolved.free = 0
    }

    if (msg.inactive !== undefined) {
      resolved.inactive = msg.inactive;
    }
    else {
      resolved.inactive = 0
    }

    if (msg.active !== undefined) {
      resolved.active = msg.active;
    }
    else {
      resolved.active = 0
    }

    if (msg.shared !== undefined) {
      resolved.shared = msg.shared;
    }
    else {
      resolved.shared = 0
    }

    if (msg.total !== undefined) {
      resolved.total = msg.total;
    }
    else {
      resolved.total = 0
    }

    if (msg.buffers !== undefined) {
      resolved.buffers = msg.buffers;
    }
    else {
      resolved.buffers = 0
    }

    return resolved;
    }
};

module.exports = Mem;
