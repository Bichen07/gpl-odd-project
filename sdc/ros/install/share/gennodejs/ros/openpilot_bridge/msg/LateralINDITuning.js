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

class LateralINDITuning {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.actuatorEffectiveness = null;
      this.outerLoopGain = null;
      this.innerLoopGain = null;
      this.timeConstant = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('actuatorEffectiveness')) {
        this.actuatorEffectiveness = initObj.actuatorEffectiveness
      }
      else {
        this.actuatorEffectiveness = 0.0;
      }
      if (initObj.hasOwnProperty('outerLoopGain')) {
        this.outerLoopGain = initObj.outerLoopGain
      }
      else {
        this.outerLoopGain = 0.0;
      }
      if (initObj.hasOwnProperty('innerLoopGain')) {
        this.innerLoopGain = initObj.innerLoopGain
      }
      else {
        this.innerLoopGain = 0.0;
      }
      if (initObj.hasOwnProperty('timeConstant')) {
        this.timeConstant = initObj.timeConstant
      }
      else {
        this.timeConstant = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LateralINDITuning
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [actuatorEffectiveness]
    bufferOffset = _serializer.float32(obj.actuatorEffectiveness, buffer, bufferOffset);
    // Serialize message field [outerLoopGain]
    bufferOffset = _serializer.float32(obj.outerLoopGain, buffer, bufferOffset);
    // Serialize message field [innerLoopGain]
    bufferOffset = _serializer.float32(obj.innerLoopGain, buffer, bufferOffset);
    // Serialize message field [timeConstant]
    bufferOffset = _serializer.float32(obj.timeConstant, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LateralINDITuning
    let len;
    let data = new LateralINDITuning(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [actuatorEffectiveness]
    data.actuatorEffectiveness = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [outerLoopGain]
    data.outerLoopGain = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [innerLoopGain]
    data.innerLoopGain = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [timeConstant]
    data.timeConstant = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LateralINDITuning';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9ff2e2f4cb8a2e149864fcfa0d8adca2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 actuatorEffectiveness
    float32 outerLoopGain
    float32 innerLoopGain
    float32 timeConstant
    
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
    const resolved = new LateralINDITuning(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.actuatorEffectiveness !== undefined) {
      resolved.actuatorEffectiveness = msg.actuatorEffectiveness;
    }
    else {
      resolved.actuatorEffectiveness = 0.0
    }

    if (msg.outerLoopGain !== undefined) {
      resolved.outerLoopGain = msg.outerLoopGain;
    }
    else {
      resolved.outerLoopGain = 0.0
    }

    if (msg.innerLoopGain !== undefined) {
      resolved.innerLoopGain = msg.innerLoopGain;
    }
    else {
      resolved.innerLoopGain = 0.0
    }

    if (msg.timeConstant !== undefined) {
      resolved.timeConstant = msg.timeConstant;
    }
    else {
      resolved.timeConstant = 0.0
    }

    return resolved;
    }
};

module.exports = LateralINDITuning;
