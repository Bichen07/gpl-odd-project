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

class Thumbnail {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.timestampEof = null;
      this.thumbnail = null;
      this.frameId = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('thumbnail')) {
        this.thumbnail = initObj.thumbnail
      }
      else {
        this.thumbnail = [];
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Thumbnail
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [thumbnail]
    bufferOffset = _arraySerializer.string(obj.thumbnail, buffer, bufferOffset, null);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Thumbnail
    let len;
    let data = new Thumbnail(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [thumbnail]
    data.thumbnail = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.thumbnail.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Thumbnail';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e95421c73c7d4c3163bcff05eb1feea2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 timestampEof
    string[] thumbnail
    int64 frameId
    
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
    const resolved = new Thumbnail(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.thumbnail !== undefined) {
      resolved.thumbnail = msg.thumbnail;
    }
    else {
      resolved.thumbnail = []
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    return resolved;
    }
};

module.exports = Thumbnail;
