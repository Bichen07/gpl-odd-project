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

class EncodeIndex {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.segmentId = null;
      this.segmentIdEncode = null;
      this.frameId = null;
      this.encodeId = null;
      this.type = null;
      this.segmentNum = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('segmentId')) {
        this.segmentId = initObj.segmentId
      }
      else {
        this.segmentId = 0;
      }
      if (initObj.hasOwnProperty('segmentIdEncode')) {
        this.segmentIdEncode = initObj.segmentIdEncode
      }
      else {
        this.segmentIdEncode = 0;
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
      if (initObj.hasOwnProperty('encodeId')) {
        this.encodeId = initObj.encodeId
      }
      else {
        this.encodeId = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('segmentNum')) {
        this.segmentNum = initObj.segmentNum
      }
      else {
        this.segmentNum = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EncodeIndex
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [segmentId]
    bufferOffset = _serializer.int64(obj.segmentId, buffer, bufferOffset);
    // Serialize message field [segmentIdEncode]
    bufferOffset = _serializer.int64(obj.segmentIdEncode, buffer, bufferOffset);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    // Serialize message field [encodeId]
    bufferOffset = _serializer.int64(obj.encodeId, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint32(obj.type, buffer, bufferOffset);
    // Serialize message field [segmentNum]
    bufferOffset = _serializer.int32(obj.segmentNum, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EncodeIndex
    let len;
    let data = new EncodeIndex(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [segmentId]
    data.segmentId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [segmentIdEncode]
    data.segmentIdEncode = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [encodeId]
    data.encodeId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [segmentNum]
    data.segmentNum = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/EncodeIndex';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8777c88982f7111522c38f60cd2e924a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 segmentId
    int64 segmentIdEncode
    int64 frameId
    int64 encodeId
    uint32 type # enum const: Type
    int32 segmentNum
    
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
    const resolved = new EncodeIndex(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.segmentId !== undefined) {
      resolved.segmentId = msg.segmentId;
    }
    else {
      resolved.segmentId = 0
    }

    if (msg.segmentIdEncode !== undefined) {
      resolved.segmentIdEncode = msg.segmentIdEncode;
    }
    else {
      resolved.segmentIdEncode = 0
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    if (msg.encodeId !== undefined) {
      resolved.encodeId = msg.encodeId;
    }
    else {
      resolved.encodeId = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.segmentNum !== undefined) {
      resolved.segmentNum = msg.segmentNum;
    }
    else {
      resolved.segmentNum = 0
    }

    return resolved;
    }
};

module.exports = EncodeIndex;
