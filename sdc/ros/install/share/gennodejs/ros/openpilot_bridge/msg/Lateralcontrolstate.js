// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LateralLQRState = require('./LateralLQRState.js');
let LateralPIDState = require('./LateralPIDState.js');
let LateralINDIState = require('./LateralINDIState.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Lateralcontrolstate {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lqrState = null;
      this.pidState = null;
      this.indiState = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lqrState')) {
        this.lqrState = initObj.lqrState
      }
      else {
        this.lqrState = new LateralLQRState();
      }
      if (initObj.hasOwnProperty('pidState')) {
        this.pidState = initObj.pidState
      }
      else {
        this.pidState = new LateralPIDState();
      }
      if (initObj.hasOwnProperty('indiState')) {
        this.indiState = initObj.indiState
      }
      else {
        this.indiState = new LateralINDIState();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lateralcontrolstate
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lqrState]
    bufferOffset = LateralLQRState.serialize(obj.lqrState, buffer, bufferOffset);
    // Serialize message field [pidState]
    bufferOffset = LateralPIDState.serialize(obj.pidState, buffer, bufferOffset);
    // Serialize message field [indiState]
    bufferOffset = LateralINDIState.serialize(obj.indiState, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lateralcontrolstate
    let len;
    let data = new Lateralcontrolstate(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lqrState]
    data.lqrState = LateralLQRState.deserialize(buffer, bufferOffset);
    // Deserialize message field [pidState]
    data.pidState = LateralPIDState.deserialize(buffer, bufferOffset);
    // Deserialize message field [indiState]
    data.indiState = LateralINDIState.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += LateralLQRState.getMessageSize(object.lqrState);
    length += LateralPIDState.getMessageSize(object.pidState);
    length += LateralINDIState.getMessageSize(object.indiState);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Lateralcontrolstate';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '598a6ef5d0f69fbeaacc25e00cbce69b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    LateralLQRState lqrState
    LateralPIDState pidState
    LateralINDIState indiState
    
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
    MSG: openpilot_bridge/LateralLQRState
    Header header
    
    bool saturated
    float32 i
    float32 lqrOutput
    bool active
    float32 output
    float32 steerAngle
    
    ================================================================================
    MSG: openpilot_bridge/LateralPIDState
    Header header
    
    bool saturated
    float32 p
    float32 steerRate
    float32 f
    float32 i
    float32 angleError
    bool active
    float32 output
    float32 steerAngle
    
    ================================================================================
    MSG: openpilot_bridge/LateralINDIState
    Header header
    
    float32 rateSetPoint
    float32 delayedOutput
    bool saturated
    float32 steerAccel
    float32 steerRate
    float32 delta
    float32 accelError
    float32 accelSetPoint
    bool active
    float32 output
    float32 steerAngle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lateralcontrolstate(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lqrState !== undefined) {
      resolved.lqrState = LateralLQRState.Resolve(msg.lqrState)
    }
    else {
      resolved.lqrState = new LateralLQRState()
    }

    if (msg.pidState !== undefined) {
      resolved.pidState = LateralPIDState.Resolve(msg.pidState)
    }
    else {
      resolved.pidState = new LateralPIDState()
    }

    if (msg.indiState !== undefined) {
      resolved.indiState = LateralINDIState.Resolve(msg.indiState)
    }
    else {
      resolved.indiState = new LateralINDIState()
    }

    return resolved;
    }
};

module.exports = Lateralcontrolstate;
