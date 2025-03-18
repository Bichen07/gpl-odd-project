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

class LongitudinalPIDTuning {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.kpV = null;
      this.kpBP = null;
      this.deadzoneBP = null;
      this.kiV = null;
      this.deadzoneV = null;
      this.kiBP = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
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
      if (initObj.hasOwnProperty('deadzoneBP')) {
        this.deadzoneBP = initObj.deadzoneBP
      }
      else {
        this.deadzoneBP = [];
      }
      if (initObj.hasOwnProperty('kiV')) {
        this.kiV = initObj.kiV
      }
      else {
        this.kiV = [];
      }
      if (initObj.hasOwnProperty('deadzoneV')) {
        this.deadzoneV = initObj.deadzoneV
      }
      else {
        this.deadzoneV = [];
      }
      if (initObj.hasOwnProperty('kiBP')) {
        this.kiBP = initObj.kiBP
      }
      else {
        this.kiBP = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LongitudinalPIDTuning
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [kpV]
    bufferOffset = _arraySerializer.float32(obj.kpV, buffer, bufferOffset, null);
    // Serialize message field [kpBP]
    bufferOffset = _arraySerializer.float32(obj.kpBP, buffer, bufferOffset, null);
    // Serialize message field [deadzoneBP]
    bufferOffset = _arraySerializer.float32(obj.deadzoneBP, buffer, bufferOffset, null);
    // Serialize message field [kiV]
    bufferOffset = _arraySerializer.float32(obj.kiV, buffer, bufferOffset, null);
    // Serialize message field [deadzoneV]
    bufferOffset = _arraySerializer.float32(obj.deadzoneV, buffer, bufferOffset, null);
    // Serialize message field [kiBP]
    bufferOffset = _arraySerializer.float32(obj.kiBP, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LongitudinalPIDTuning
    let len;
    let data = new LongitudinalPIDTuning(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [kpV]
    data.kpV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kpBP]
    data.kpBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [deadzoneBP]
    data.deadzoneBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kiV]
    data.kiV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [deadzoneV]
    data.deadzoneV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [kiBP]
    data.kiBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.kpV.length;
    length += 4 * object.kpBP.length;
    length += 4 * object.deadzoneBP.length;
    length += 4 * object.kiV.length;
    length += 4 * object.deadzoneV.length;
    length += 4 * object.kiBP.length;
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LongitudinalPIDTuning';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3d0bda3d864dac886bbca2412dcd8ad3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] kpV
    float32[] kpBP
    float32[] deadzoneBP
    float32[] kiV
    float32[] deadzoneV
    float32[] kiBP
    
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
    const resolved = new LongitudinalPIDTuning(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
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

    if (msg.deadzoneBP !== undefined) {
      resolved.deadzoneBP = msg.deadzoneBP;
    }
    else {
      resolved.deadzoneBP = []
    }

    if (msg.kiV !== undefined) {
      resolved.kiV = msg.kiV;
    }
    else {
      resolved.kiV = []
    }

    if (msg.deadzoneV !== undefined) {
      resolved.deadzoneV = msg.deadzoneV;
    }
    else {
      resolved.deadzoneV = []
    }

    if (msg.kiBP !== undefined) {
      resolved.kiBP = msg.kiBP;
    }
    else {
      resolved.kiBP = []
    }

    return resolved;
    }
};

module.exports = LongitudinalPIDTuning;
