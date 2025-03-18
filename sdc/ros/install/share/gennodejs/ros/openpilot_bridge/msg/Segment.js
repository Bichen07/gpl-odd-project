// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LatLng = require('./LatLng.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Segment {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.distance = null;
      this.updateTime = null;
      this.from = null;
      this.instruction = null;
      this.parts = null;
      this.to = null;
      this.crossTime = null;
      this.exitNo = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0;
      }
      if (initObj.hasOwnProperty('updateTime')) {
        this.updateTime = initObj.updateTime
      }
      else {
        this.updateTime = 0;
      }
      if (initObj.hasOwnProperty('from')) {
        this.from = initObj.from
      }
      else {
        this.from = new LatLng();
      }
      if (initObj.hasOwnProperty('instruction')) {
        this.instruction = initObj.instruction
      }
      else {
        this.instruction = 0;
      }
      if (initObj.hasOwnProperty('parts')) {
        this.parts = initObj.parts
      }
      else {
        this.parts = [];
      }
      if (initObj.hasOwnProperty('to')) {
        this.to = initObj.to
      }
      else {
        this.to = new LatLng();
      }
      if (initObj.hasOwnProperty('crossTime')) {
        this.crossTime = initObj.crossTime
      }
      else {
        this.crossTime = 0;
      }
      if (initObj.hasOwnProperty('exitNo')) {
        this.exitNo = initObj.exitNo
      }
      else {
        this.exitNo = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Segment
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.int32(obj.distance, buffer, bufferOffset);
    // Serialize message field [updateTime]
    bufferOffset = _serializer.int32(obj.updateTime, buffer, bufferOffset);
    // Serialize message field [from]
    bufferOffset = LatLng.serialize(obj.from, buffer, bufferOffset);
    // Serialize message field [instruction]
    bufferOffset = _serializer.uint32(obj.instruction, buffer, bufferOffset);
    // Serialize message field [parts]
    // Serialize the length for message field [parts]
    bufferOffset = _serializer.uint32(obj.parts.length, buffer, bufferOffset);
    obj.parts.forEach((val) => {
      bufferOffset = LatLng.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [to]
    bufferOffset = LatLng.serialize(obj.to, buffer, bufferOffset);
    // Serialize message field [crossTime]
    bufferOffset = _serializer.int32(obj.crossTime, buffer, bufferOffset);
    // Serialize message field [exitNo]
    bufferOffset = _serializer.int32(obj.exitNo, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Segment
    let len;
    let data = new Segment(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [updateTime]
    data.updateTime = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [from]
    data.from = LatLng.deserialize(buffer, bufferOffset);
    // Deserialize message field [instruction]
    data.instruction = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [parts]
    // Deserialize array length for message field [parts]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.parts = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.parts[i] = LatLng.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [to]
    data.to = LatLng.deserialize(buffer, bufferOffset);
    // Deserialize message field [crossTime]
    data.crossTime = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [exitNo]
    data.exitNo = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += LatLng.getMessageSize(object.from);
    object.parts.forEach((val) => {
      length += LatLng.getMessageSize(val);
    });
    length += LatLng.getMessageSize(object.to);
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Segment';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dfbd5c3557c55dec73407d19d628c5ef';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 distance
    int32 updateTime
    LatLng from
    uint32 instruction # enum const: Instruction
    LatLng[] parts
    LatLng to
    int32 crossTime
    int32 exitNo
    
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
    MSG: openpilot_bridge/LatLng
    Header header
    
    float32 lat
    float32 lng
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Segment(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0
    }

    if (msg.updateTime !== undefined) {
      resolved.updateTime = msg.updateTime;
    }
    else {
      resolved.updateTime = 0
    }

    if (msg.from !== undefined) {
      resolved.from = LatLng.Resolve(msg.from)
    }
    else {
      resolved.from = new LatLng()
    }

    if (msg.instruction !== undefined) {
      resolved.instruction = msg.instruction;
    }
    else {
      resolved.instruction = 0
    }

    if (msg.parts !== undefined) {
      resolved.parts = new Array(msg.parts.length);
      for (let i = 0; i < resolved.parts.length; ++i) {
        resolved.parts[i] = LatLng.Resolve(msg.parts[i]);
      }
    }
    else {
      resolved.parts = []
    }

    if (msg.to !== undefined) {
      resolved.to = LatLng.Resolve(msg.to)
    }
    else {
      resolved.to = new LatLng()
    }

    if (msg.crossTime !== undefined) {
      resolved.crossTime = msg.crossTime;
    }
    else {
      resolved.crossTime = 0
    }

    if (msg.exitNo !== undefined) {
      resolved.exitNo = msg.exitNo;
    }
    else {
      resolved.exitNo = 0
    }

    return resolved;
    }
};

module.exports = Segment;
