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

class LiveParametersData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.steerRatio = null;
      this.sensorValid = null;
      this.stiffnessFactor = null;
      this.posenetValid = null;
      this.angleOffset = null;
      this.yawRate = null;
      this.gyroBias = null;
      this.valid = null;
      this.posenetSpeed = null;
      this.angleOffsetAverage = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('steerRatio')) {
        this.steerRatio = initObj.steerRatio
      }
      else {
        this.steerRatio = 0.0;
      }
      if (initObj.hasOwnProperty('sensorValid')) {
        this.sensorValid = initObj.sensorValid
      }
      else {
        this.sensorValid = false;
      }
      if (initObj.hasOwnProperty('stiffnessFactor')) {
        this.stiffnessFactor = initObj.stiffnessFactor
      }
      else {
        this.stiffnessFactor = 0.0;
      }
      if (initObj.hasOwnProperty('posenetValid')) {
        this.posenetValid = initObj.posenetValid
      }
      else {
        this.posenetValid = false;
      }
      if (initObj.hasOwnProperty('angleOffset')) {
        this.angleOffset = initObj.angleOffset
      }
      else {
        this.angleOffset = 0.0;
      }
      if (initObj.hasOwnProperty('yawRate')) {
        this.yawRate = initObj.yawRate
      }
      else {
        this.yawRate = 0.0;
      }
      if (initObj.hasOwnProperty('gyroBias')) {
        this.gyroBias = initObj.gyroBias
      }
      else {
        this.gyroBias = 0.0;
      }
      if (initObj.hasOwnProperty('valid')) {
        this.valid = initObj.valid
      }
      else {
        this.valid = false;
      }
      if (initObj.hasOwnProperty('posenetSpeed')) {
        this.posenetSpeed = initObj.posenetSpeed
      }
      else {
        this.posenetSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('angleOffsetAverage')) {
        this.angleOffsetAverage = initObj.angleOffsetAverage
      }
      else {
        this.angleOffsetAverage = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveParametersData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [steerRatio]
    bufferOffset = _serializer.float32(obj.steerRatio, buffer, bufferOffset);
    // Serialize message field [sensorValid]
    bufferOffset = _serializer.bool(obj.sensorValid, buffer, bufferOffset);
    // Serialize message field [stiffnessFactor]
    bufferOffset = _serializer.float32(obj.stiffnessFactor, buffer, bufferOffset);
    // Serialize message field [posenetValid]
    bufferOffset = _serializer.bool(obj.posenetValid, buffer, bufferOffset);
    // Serialize message field [angleOffset]
    bufferOffset = _serializer.float32(obj.angleOffset, buffer, bufferOffset);
    // Serialize message field [yawRate]
    bufferOffset = _serializer.float32(obj.yawRate, buffer, bufferOffset);
    // Serialize message field [gyroBias]
    bufferOffset = _serializer.float32(obj.gyroBias, buffer, bufferOffset);
    // Serialize message field [valid]
    bufferOffset = _serializer.bool(obj.valid, buffer, bufferOffset);
    // Serialize message field [posenetSpeed]
    bufferOffset = _serializer.float32(obj.posenetSpeed, buffer, bufferOffset);
    // Serialize message field [angleOffsetAverage]
    bufferOffset = _serializer.float32(obj.angleOffsetAverage, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveParametersData
    let len;
    let data = new LiveParametersData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [steerRatio]
    data.steerRatio = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [sensorValid]
    data.sensorValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [stiffnessFactor]
    data.stiffnessFactor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [posenetValid]
    data.posenetValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [angleOffset]
    data.angleOffset = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yawRate]
    data.yawRate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gyroBias]
    data.gyroBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [valid]
    data.valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [posenetSpeed]
    data.posenetSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angleOffsetAverage]
    data.angleOffsetAverage = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 31;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveParametersData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c7f16316c870354eebb72d972911e81';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 steerRatio
    bool sensorValid
    float32 stiffnessFactor
    bool posenetValid
    float32 angleOffset
    float32 yawRate
    float32 gyroBias
    bool valid
    float32 posenetSpeed
    float32 angleOffsetAverage
    
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
    const resolved = new LiveParametersData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.steerRatio !== undefined) {
      resolved.steerRatio = msg.steerRatio;
    }
    else {
      resolved.steerRatio = 0.0
    }

    if (msg.sensorValid !== undefined) {
      resolved.sensorValid = msg.sensorValid;
    }
    else {
      resolved.sensorValid = false
    }

    if (msg.stiffnessFactor !== undefined) {
      resolved.stiffnessFactor = msg.stiffnessFactor;
    }
    else {
      resolved.stiffnessFactor = 0.0
    }

    if (msg.posenetValid !== undefined) {
      resolved.posenetValid = msg.posenetValid;
    }
    else {
      resolved.posenetValid = false
    }

    if (msg.angleOffset !== undefined) {
      resolved.angleOffset = msg.angleOffset;
    }
    else {
      resolved.angleOffset = 0.0
    }

    if (msg.yawRate !== undefined) {
      resolved.yawRate = msg.yawRate;
    }
    else {
      resolved.yawRate = 0.0
    }

    if (msg.gyroBias !== undefined) {
      resolved.gyroBias = msg.gyroBias;
    }
    else {
      resolved.gyroBias = 0.0
    }

    if (msg.valid !== undefined) {
      resolved.valid = msg.valid;
    }
    else {
      resolved.valid = false
    }

    if (msg.posenetSpeed !== undefined) {
      resolved.posenetSpeed = msg.posenetSpeed;
    }
    else {
      resolved.posenetSpeed = 0.0
    }

    if (msg.angleOffsetAverage !== undefined) {
      resolved.angleOffsetAverage = msg.angleOffsetAverage;
    }
    else {
      resolved.angleOffsetAverage = 0.0
    }

    return resolved;
    }
};

module.exports = LiveParametersData;
