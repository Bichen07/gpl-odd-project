// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let RadarPoint = require('./RadarPoint.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class RadarData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.canMonoTimes = null;
      this.errors = null;
      this.points = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('canMonoTimes')) {
        this.canMonoTimes = initObj.canMonoTimes
      }
      else {
        this.canMonoTimes = [];
      }
      if (initObj.hasOwnProperty('errors')) {
        this.errors = initObj.errors
      }
      else {
        this.errors = [];
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RadarData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [canMonoTimes]
    bufferOffset = _arraySerializer.int64(obj.canMonoTimes, buffer, bufferOffset, null);
    // Serialize message field [errors]
    bufferOffset = _arraySerializer.uint32(obj.errors, buffer, bufferOffset, null);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = RadarPoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RadarData
    let len;
    let data = new RadarData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [canMonoTimes]
    data.canMonoTimes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [errors]
    data.errors = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = RadarPoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 8 * object.canMonoTimes.length;
    length += 4 * object.errors.length;
    object.points.forEach((val) => {
      length += RadarPoint.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/RadarData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '76b62543761f0d42ee75ec49ef018fe1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64[] canMonoTimes
    uint32[] errors # enum const: Error
    RadarPoint[] points
    
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
    MSG: openpilot_bridge/RadarPoint
    Header header
    
    float32 yRel
    int64 trackId
    float32 aRel
    float32 vRel
    float32 dRel
    float32 yvRel
    bool measured
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RadarData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.canMonoTimes !== undefined) {
      resolved.canMonoTimes = msg.canMonoTimes;
    }
    else {
      resolved.canMonoTimes = []
    }

    if (msg.errors !== undefined) {
      resolved.errors = msg.errors;
    }
    else {
      resolved.errors = []
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = RadarPoint.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    return resolved;
    }
};

module.exports = RadarData;
