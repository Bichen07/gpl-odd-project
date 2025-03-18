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

class RadarPoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.yRel = null;
      this.trackId = null;
      this.aRel = null;
      this.vRel = null;
      this.dRel = null;
      this.yvRel = null;
      this.measured = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('yRel')) {
        this.yRel = initObj.yRel
      }
      else {
        this.yRel = 0.0;
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
      if (initObj.hasOwnProperty('yvRel')) {
        this.yvRel = initObj.yvRel
      }
      else {
        this.yvRel = 0.0;
      }
      if (initObj.hasOwnProperty('measured')) {
        this.measured = initObj.measured
      }
      else {
        this.measured = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RadarPoint
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [yRel]
    bufferOffset = _serializer.float32(obj.yRel, buffer, bufferOffset);
    // Serialize message field [trackId]
    bufferOffset = _serializer.int64(obj.trackId, buffer, bufferOffset);
    // Serialize message field [aRel]
    bufferOffset = _serializer.float32(obj.aRel, buffer, bufferOffset);
    // Serialize message field [vRel]
    bufferOffset = _serializer.float32(obj.vRel, buffer, bufferOffset);
    // Serialize message field [dRel]
    bufferOffset = _serializer.float32(obj.dRel, buffer, bufferOffset);
    // Serialize message field [yvRel]
    bufferOffset = _serializer.float32(obj.yvRel, buffer, bufferOffset);
    // Serialize message field [measured]
    bufferOffset = _serializer.bool(obj.measured, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RadarPoint
    let len;
    let data = new RadarPoint(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [yRel]
    data.yRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [trackId]
    data.trackId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [aRel]
    data.aRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vRel]
    data.vRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dRel]
    data.dRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yvRel]
    data.yvRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [measured]
    data.measured = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/RadarPoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3ce9f9a91082e3c1c6436dc94453ce9e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 yRel
    int64 trackId
    float32 aRel
    float32 vRel
    float32 dRel
    float32 yvRel
    bool measured
    
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
    const resolved = new RadarPoint(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.yRel !== undefined) {
      resolved.yRel = msg.yRel;
    }
    else {
      resolved.yRel = 0.0
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

    if (msg.yvRel !== undefined) {
      resolved.yvRel = msg.yvRel;
    }
    else {
      resolved.yvRel = 0.0
    }

    if (msg.measured !== undefined) {
      resolved.measured = msg.measured;
    }
    else {
      resolved.measured = false
    }

    return resolved;
    }
};

module.exports = RadarPoint;
