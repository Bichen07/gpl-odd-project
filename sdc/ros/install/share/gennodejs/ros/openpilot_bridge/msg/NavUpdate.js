// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Segment = require('./Segment.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class NavUpdate {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.isNavigating = null;
      this.segments = null;
      this.curSegment = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('isNavigating')) {
        this.isNavigating = initObj.isNavigating
      }
      else {
        this.isNavigating = false;
      }
      if (initObj.hasOwnProperty('segments')) {
        this.segments = initObj.segments
      }
      else {
        this.segments = [];
      }
      if (initObj.hasOwnProperty('curSegment')) {
        this.curSegment = initObj.curSegment
      }
      else {
        this.curSegment = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavUpdate
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [isNavigating]
    bufferOffset = _serializer.bool(obj.isNavigating, buffer, bufferOffset);
    // Serialize message field [segments]
    // Serialize the length for message field [segments]
    bufferOffset = _serializer.uint32(obj.segments.length, buffer, bufferOffset);
    obj.segments.forEach((val) => {
      bufferOffset = Segment.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [curSegment]
    bufferOffset = _serializer.int32(obj.curSegment, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavUpdate
    let len;
    let data = new NavUpdate(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [isNavigating]
    data.isNavigating = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [segments]
    // Deserialize array length for message field [segments]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.segments = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.segments[i] = Segment.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [curSegment]
    data.curSegment = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.segments.forEach((val) => {
      length += Segment.getMessageSize(val);
    });
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/NavUpdate';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4056f0b47c0dc06ca95711174632cd20';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool isNavigating
    Segment[] segments
    int32 curSegment
    
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
    MSG: openpilot_bridge/Segment
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
    const resolved = new NavUpdate(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.isNavigating !== undefined) {
      resolved.isNavigating = msg.isNavigating;
    }
    else {
      resolved.isNavigating = false
    }

    if (msg.segments !== undefined) {
      resolved.segments = new Array(msg.segments.length);
      for (let i = 0; i < resolved.segments.length; ++i) {
        resolved.segments[i] = Segment.Resolve(msg.segments[i]);
      }
    }
    else {
      resolved.segments = []
    }

    if (msg.curSegment !== undefined) {
      resolved.curSegment = msg.curSegment;
    }
    else {
      resolved.curSegment = 0
    }

    return resolved;
    }
};

module.exports = NavUpdate;
