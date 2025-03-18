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

class LiveTracks {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.status = null;
      this.yRel = null;
      this.currentTime = null;
      this.trackId = null;
      this.aRel = null;
      this.vRel = null;
      this.dRel = null;
      this.timeStamp = null;
      this.stationary = null;
      this.oncoming = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0.0;
      }
      if (initObj.hasOwnProperty('yRel')) {
        this.yRel = initObj.yRel
      }
      else {
        this.yRel = 0.0;
      }
      if (initObj.hasOwnProperty('currentTime')) {
        this.currentTime = initObj.currentTime
      }
      else {
        this.currentTime = 0.0;
      }
      if (initObj.hasOwnProperty('trackId')) {
        this.trackId = initObj.trackId
      }
      else {
        this.trackId = 0;
      }
      if (initObj.hasOwnProperty('aRel')) {
        this.aRel = initObj.aRel
      }
      else {
        this.aRel = 0.0;
      }
      if (initObj.hasOwnProperty('vRel')) {
        this.vRel = initObj.vRel
      }
      else {
        this.vRel = 0.0;
      }
      if (initObj.hasOwnProperty('dRel')) {
        this.dRel = initObj.dRel
      }
      else {
        this.dRel = 0.0;
      }
      if (initObj.hasOwnProperty('timeStamp')) {
        this.timeStamp = initObj.timeStamp
      }
      else {
        this.timeStamp = 0.0;
      }
      if (initObj.hasOwnProperty('stationary')) {
        this.stationary = initObj.stationary
      }
      else {
        this.stationary = false;
      }
      if (initObj.hasOwnProperty('oncoming')) {
        this.oncoming = initObj.oncoming
      }
      else {
        this.oncoming = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveTracks
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.float32(obj.status, buffer, bufferOffset);
    // Serialize message field [yRel]
    bufferOffset = _serializer.float32(obj.yRel, buffer, bufferOffset);
    // Serialize message field [currentTime]
    bufferOffset = _serializer.float32(obj.currentTime, buffer, bufferOffset);
    // Serialize message field [trackId]
    bufferOffset = _serializer.int32(obj.trackId, buffer, bufferOffset);
    // Serialize message field [aRel]
    bufferOffset = _serializer.float32(obj.aRel, buffer, bufferOffset);
    // Serialize message field [vRel]
    bufferOffset = _serializer.float32(obj.vRel, buffer, bufferOffset);
    // Serialize message field [dRel]
    bufferOffset = _serializer.float32(obj.dRel, buffer, bufferOffset);
    // Serialize message field [timeStamp]
    bufferOffset = _serializer.float32(obj.timeStamp, buffer, bufferOffset);
    // Serialize message field [stationary]
    bufferOffset = _serializer.bool(obj.stationary, buffer, bufferOffset);
    // Serialize message field [oncoming]
    bufferOffset = _serializer.bool(obj.oncoming, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveTracks
    let len;
    let data = new LiveTracks(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yRel]
    data.yRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [currentTime]
    data.currentTime = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [trackId]
    data.trackId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [aRel]
    data.aRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vRel]
    data.vRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dRel]
    data.dRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [timeStamp]
    data.timeStamp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stationary]
    data.stationary = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [oncoming]
    data.oncoming = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 34;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveTracks';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bc07fabc68ac3d8a8dc415053006b7ba';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 status
    float32 yRel
    float32 currentTime
    int32 trackId
    float32 aRel
    float32 vRel
    float32 dRel
    float32 timeStamp
    bool stationary
    bool oncoming
    
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
    const resolved = new LiveTracks(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0.0
    }

    if (msg.yRel !== undefined) {
      resolved.yRel = msg.yRel;
    }
    else {
      resolved.yRel = 0.0
    }

    if (msg.currentTime !== undefined) {
      resolved.currentTime = msg.currentTime;
    }
    else {
      resolved.currentTime = 0.0
    }

    if (msg.trackId !== undefined) {
      resolved.trackId = msg.trackId;
    }
    else {
      resolved.trackId = 0
    }

    if (msg.aRel !== undefined) {
      resolved.aRel = msg.aRel;
    }
    else {
      resolved.aRel = 0.0
    }

    if (msg.vRel !== undefined) {
      resolved.vRel = msg.vRel;
    }
    else {
      resolved.vRel = 0.0
    }

    if (msg.dRel !== undefined) {
      resolved.dRel = msg.dRel;
    }
    else {
      resolved.dRel = 0.0
    }

    if (msg.timeStamp !== undefined) {
      resolved.timeStamp = msg.timeStamp;
    }
    else {
      resolved.timeStamp = 0.0
    }

    if (msg.stationary !== undefined) {
      resolved.stationary = msg.stationary;
    }
    else {
      resolved.stationary = false
    }

    if (msg.oncoming !== undefined) {
      resolved.oncoming = msg.oncoming;
    }
    else {
      resolved.oncoming = false
    }

    return resolved;
    }
};

module.exports = LiveTracks;
