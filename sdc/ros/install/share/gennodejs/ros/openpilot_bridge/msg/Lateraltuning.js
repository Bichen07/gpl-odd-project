// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LateralINDITuning = require('./LateralINDITuning.js');
let LateralPIDTuning = require('./LateralPIDTuning.js');
let LateralLQRTuning = require('./LateralLQRTuning.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Lateraltuning {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.indi = null;
      this.pid = null;
      this.lqr = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('indi')) {
        this.indi = initObj.indi
      }
      else {
        this.indi = new LateralINDITuning();
      }
      if (initObj.hasOwnProperty('pid')) {
        this.pid = initObj.pid
      }
      else {
        this.pid = new LateralPIDTuning();
      }
      if (initObj.hasOwnProperty('lqr')) {
        this.lqr = initObj.lqr
      }
      else {
        this.lqr = new LateralLQRTuning();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lateraltuning
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [indi]
    bufferOffset = LateralINDITuning.serialize(obj.indi, buffer, bufferOffset);
    // Serialize message field [pid]
    bufferOffset = LateralPIDTuning.serialize(obj.pid, buffer, bufferOffset);
    // Serialize message field [lqr]
    bufferOffset = LateralLQRTuning.serialize(obj.lqr, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lateraltuning
    let len;
    let data = new Lateraltuning(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [indi]
    data.indi = LateralINDITuning.deserialize(buffer, bufferOffset);
    // Deserialize message field [pid]
    data.pid = LateralPIDTuning.deserialize(buffer, bufferOffset);
    // Deserialize message field [lqr]
    data.lqr = LateralLQRTuning.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += LateralINDITuning.getMessageSize(object.indi);
    length += LateralPIDTuning.getMessageSize(object.pid);
    length += LateralLQRTuning.getMessageSize(object.lqr);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Lateraltuning';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '91bf1863abb4aef4fc1990bbeead3dc0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    LateralINDITuning indi
    LateralPIDTuning pid
    LateralLQRTuning lqr
    
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
    MSG: openpilot_bridge/LateralINDITuning
    Header header
    
    float32 actuatorEffectiveness
    float32 outerLoopGain
    float32 innerLoopGain
    float32 timeConstant
    
    ================================================================================
    MSG: openpilot_bridge/LateralPIDTuning
    Header header
    
    float32[] kiBP
    float32 kf
    float32[] kiV
    float32[] kpV
    float32[] kpBP
    
    ================================================================================
    MSG: openpilot_bridge/LateralLQRTuning
    Header header
    
    float32[] a
    float32[] c
    float32 scale
    float32 ki
    float32[] l
    float32[] b
    float32 dcGain
    float32[] k
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lateraltuning(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.indi !== undefined) {
      resolved.indi = LateralINDITuning.Resolve(msg.indi)
    }
    else {
      resolved.indi = new LateralINDITuning()
    }

    if (msg.pid !== undefined) {
      resolved.pid = LateralPIDTuning.Resolve(msg.pid)
    }
    else {
      resolved.pid = new LateralPIDTuning()
    }

    if (msg.lqr !== undefined) {
      resolved.lqr = LateralLQRTuning.Resolve(msg.lqr)
    }
    else {
      resolved.lqr = new LateralLQRTuning()
    }

    return resolved;
    }
};

module.exports = Lateraltuning;
