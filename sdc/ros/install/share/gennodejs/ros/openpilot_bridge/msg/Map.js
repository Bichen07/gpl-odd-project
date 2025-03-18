// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Entry = require('./Entry.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Map {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.entries = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('entries')) {
        this.entries = initObj.entries
      }
      else {
        this.entries = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Map
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [entries]
    // Serialize the length for message field [entries]
    bufferOffset = _serializer.uint32(obj.entries.length, buffer, bufferOffset);
    obj.entries.forEach((val) => {
      bufferOffset = Entry.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Map
    let len;
    let data = new Map(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [entries]
    // Deserialize array length for message field [entries]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.entries = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.entries[i] = Entry.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.entries.forEach((val) => {
      length += Entry.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Map';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b9776cdbc871aef17603b3b11d5a6c95';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    Entry[] entries
    
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
    MSG: openpilot_bridge/Entry
    Header header
    
    string value
    string key
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Map(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.entries !== undefined) {
      resolved.entries = new Array(msg.entries.length);
      for (let i = 0; i < resolved.entries.length; ++i) {
        resolved.entries[i] = Entry.Resolve(msg.entries[i]);
      }
    }
    else {
      resolved.entries = []
    }

    return resolved;
    }
};

module.exports = Map;
