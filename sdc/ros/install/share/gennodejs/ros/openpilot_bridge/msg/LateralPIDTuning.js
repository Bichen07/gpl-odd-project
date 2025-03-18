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

class LateralPIDTuning {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.kiBP = null;
      this.kf = null;
      this.kiV = null;
      this.kpV = null;
      this.kpBP = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('kiBP')) {
        this.kiBP = initObj.kiBP
      }
      else {
        this.kiBP = [];
      }
      if (initObj.hasOwnProperty('kf')) {
        this.kf = initObj.kf
      }
      else {
        this.kf = 0.0;
      }
      if (initObj.hasOwnProperty('kiV')) {
        this.kiV = initObj.kiV
      }
      else {
        this.kiV = [];
      }
      if (initObj.hasOwnProperty('kpV')) {
        this.kpV = initObj.kpV
      }
      else {
        this.kpV = [];
      }
      if (initObj.hasOwnProperty('kpBP')) {
        this.kpBP = initObj.kpBP
      }
      else {
        this.kpBP = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LateralPIDTuning
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [kiBP]
    bufferOffset = _arraySerializer.float32(obj.kiBP, buffer, bufferOffset, null);
    // Serialize message field [kf]
    bufferOffset = _serializer.float32(obj.kf, buffer, bufferOffset);
    // Serialize message field [kiV]
    bufferOffset = _arraySerializer.float32(obj.kiV, buffer, bufferOffset, null);
    // Serialize message field [kpV]
    bufferOffset = _arraySerializer.float32(obj.kpV, buffer, bufferOffset, null);
    // Serialize message field [kpBP]
    bufferOffset = _arraySerializer.float32(obj.kpBP, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LateralPIDTuning
    let len;
    let data = new LateralPIDTuning(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [kiBP]
    data.kiBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kf]
    data.kf = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [kiV]
    data.kiV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kpV]
    data.kpV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kpBP]
    data.kpBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.kiBP.length;
    length += 4 * object.kiV.length;
    length += 4 * object.kpV.length;
    length += 4 * object.kpBP.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LateralPIDTuning';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '14a5c3b4c8e3b3c02e1965d864d407cd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] kiBP
    float32 kf
    float32[] kiV
    float32[] kpV
    float32[] kpBP
    
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
    const resolved = new LateralPIDTuning(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.kiBP !== undefined) {
      resolved.kiBP = msg.kiBP;
    }
    else {
      resolved.kiBP = []
    }

    if (msg.kf !== undefined) {
      resolved.kf = msg.kf;
    }
    else {
      resolved.kf = 0.0
    }

    if (msg.kiV !== undefined) {
      resolved.kiV = msg.kiV;
    }
    else {
      resolved.kiV = []
    }

    if (msg.kpV !== undefined) {
      resolved.kpV = msg.kpV;
    }
    else {
      resolved.kpV = []
    }

    if (msg.kpBP !== undefined) {
      resolved.kpBP = msg.kpBP;
    }
    else {
      resolved.kpBP = []
    }

    return resolved;
    }
};

module.exports = LateralPIDTuning;
