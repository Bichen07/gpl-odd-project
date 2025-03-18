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

class CanData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.dat = null;
      this.src = null;
      this.busTime = null;
      this.address = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('dat')) {
        this.dat = initObj.dat
      }
      else {
        this.dat = [];
      }
      if (initObj.hasOwnProperty('src')) {
        this.src = initObj.src
      }
      else {
        this.src = 0;
      }
      if (initObj.hasOwnProperty('busTime')) {
        this.busTime = initObj.busTime
      }
      else {
        this.busTime = 0;
      }
      if (initObj.hasOwnProperty('address')) {
        this.address = initObj.address
      }
      else {
        this.address = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CanData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [dat]
    bufferOffset = _arraySerializer.string(obj.dat, buffer, bufferOffset, null);
    // Serialize message field [src]
    bufferOffset = _serializer.int64(obj.src, buffer, bufferOffset);
    // Serialize message field [busTime]
    bufferOffset = _serializer.int64(obj.busTime, buffer, bufferOffset);
    // Serialize message field [address]
    bufferOffset = _serializer.int64(obj.address, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CanData
    let len;
    let data = new CanData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [dat]
    data.dat = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [src]
    data.src = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [busTime]
    data.busTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [address]
    data.address = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.dat.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CanData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2bb06e6e3a8a81e0172131c09a692026';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    string[] dat
    int64 src
    int64 busTime
    int64 address
    
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
    const resolved = new CanData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.dat !== undefined) {
      resolved.dat = msg.dat;
    }
    else {
      resolved.dat = []
    }

    if (msg.src !== undefined) {
      resolved.src = msg.src;
    }
    else {
      resolved.src = 0
    }

    if (msg.busTime !== undefined) {
      resolved.busTime = msg.busTime;
    }
    else {
      resolved.busTime = 0
    }

    if (msg.address !== undefined) {
      resolved.address = msg.address;
    }
    else {
      resolved.address = 0
    }

    return resolved;
    }
};

module.exports = CanData;
