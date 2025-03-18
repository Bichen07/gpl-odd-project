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

class LateralINDIState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rateSetPoint = null;
      this.delayedOutput = null;
      this.saturated = null;
      this.steerAccel = null;
      this.steerRate = null;
      this.delta = null;
      this.accelError = null;
      this.accelSetPoint = null;
      this.active = null;
      this.output = null;
      this.steerAngle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rateSetPoint')) {
        this.rateSetPoint = initObj.rateSetPoint
      }
      else {
        this.rateSetPoint = 0.0;
      }
      if (initObj.hasOwnProperty('delayedOutput')) {
        this.delayedOutput = initObj.delayedOutput
      }
      else {
        this.delayedOutput = 0.0;
      }
      if (initObj.hasOwnProperty('saturated')) {
        this.saturated = initObj.saturated
      }
      else {
        this.saturated = false;
      }
      if (initObj.hasOwnProperty('steerAccel')) {
        this.steerAccel = initObj.steerAccel
      }
      else {
        this.steerAccel = 0.0;
      }
      if (initObj.hasOwnProperty('steerRate')) {
        this.steerRate = initObj.steerRate
      }
      else {
        this.steerRate = 0.0;
      }
      if (initObj.hasOwnProperty('delta')) {
        this.delta = initObj.delta
      }
      else {
        this.delta = 0.0;
      }
      if (initObj.hasOwnProperty('accelError')) {
        this.accelError = initObj.accelError
      }
      else {
        this.accelError = 0.0;
      }
      if (initObj.hasOwnProperty('accelSetPoint')) {
        this.accelSetPoint = initObj.accelSetPoint
      }
      else {
        this.accelSetPoint = 0.0;
      }
      if (initObj.hasOwnProperty('active')) {
        this.active = initObj.active
      }
      else {
        this.active = false;
      }
      if (initObj.hasOwnProperty('output')) {
        this.output = initObj.output
      }
      else {
        this.output = 0.0;
      }
      if (initObj.hasOwnProperty('steerAngle')) {
        this.steerAngle = initObj.steerAngle
      }
      else {
        this.steerAngle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LateralINDIState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rateSetPoint]
    bufferOffset = _serializer.float32(obj.rateSetPoint, buffer, bufferOffset);
    // Serialize message field [delayedOutput]
    bufferOffset = _serializer.float32(obj.delayedOutput, buffer, bufferOffset);
    // Serialize message field [saturated]
    bufferOffset = _serializer.bool(obj.saturated, buffer, bufferOffset);
    // Serialize message field [steerAccel]
    bufferOffset = _serializer.float32(obj.steerAccel, buffer, bufferOffset);
    // Serialize message field [steerRate]
    bufferOffset = _serializer.float32(obj.steerRate, buffer, bufferOffset);
    // Serialize message field [delta]
    bufferOffset = _serializer.float32(obj.delta, buffer, bufferOffset);
    // Serialize message field [accelError]
    bufferOffset = _serializer.float32(obj.accelError, buffer, bufferOffset);
    // Serialize message field [accelSetPoint]
    bufferOffset = _serializer.float32(obj.accelSetPoint, buffer, bufferOffset);
    // Serialize message field [active]
    bufferOffset = _serializer.bool(obj.active, buffer, bufferOffset);
    // Serialize message field [output]
    bufferOffset = _serializer.float32(obj.output, buffer, bufferOffset);
    // Serialize message field [steerAngle]
    bufferOffset = _serializer.float32(obj.steerAngle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LateralINDIState
    let len;
    let data = new LateralINDIState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rateSetPoint]
    data.rateSetPoint = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delayedOutput]
    data.delayedOutput = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [saturated]
    data.saturated = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steerAccel]
    data.steerAccel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerRate]
    data.steerRate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta]
    data.delta = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accelError]
    data.accelError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accelSetPoint]
    data.accelSetPoint = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [active]
    data.active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [output]
    data.output = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerAngle]
    data.steerAngle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 38;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LateralINDIState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bd5a4c19a89365a4aac92df08c09943f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new LateralINDIState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rateSetPoint !== undefined) {
      resolved.rateSetPoint = msg.rateSetPoint;
    }
    else {
      resolved.rateSetPoint = 0.0
    }

    if (msg.delayedOutput !== undefined) {
      resolved.delayedOutput = msg.delayedOutput;
    }
    else {
      resolved.delayedOutput = 0.0
    }

    if (msg.saturated !== undefined) {
      resolved.saturated = msg.saturated;
    }
    else {
      resolved.saturated = false
    }

    if (msg.steerAccel !== undefined) {
      resolved.steerAccel = msg.steerAccel;
    }
    else {
      resolved.steerAccel = 0.0
    }

    if (msg.steerRate !== undefined) {
      resolved.steerRate = msg.steerRate;
    }
    else {
      resolved.steerRate = 0.0
    }

    if (msg.delta !== undefined) {
      resolved.delta = msg.delta;
    }
    else {
      resolved.delta = 0.0
    }

    if (msg.accelError !== undefined) {
      resolved.accelError = msg.accelError;
    }
    else {
      resolved.accelError = 0.0
    }

    if (msg.accelSetPoint !== undefined) {
      resolved.accelSetPoint = msg.accelSetPoint;
    }
    else {
      resolved.accelSetPoint = 0.0
    }

    if (msg.active !== undefined) {
      resolved.active = msg.active;
    }
    else {
      resolved.active = false
    }

    if (msg.output !== undefined) {
      resolved.output = msg.output;
    }
    else {
      resolved.output = 0.0
    }

    if (msg.steerAngle !== undefined) {
      resolved.steerAngle = msg.steerAngle;
    }
    else {
      resolved.steerAngle = 0.0
    }

    return resolved;
    }
};

module.exports = LateralINDIState;
