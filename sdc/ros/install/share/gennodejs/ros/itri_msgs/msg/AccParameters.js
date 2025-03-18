// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class AccParameters {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Kp = null;
      this.Ki = null;
      this.Kd = null;
      this.velocitySetpoint = null;
      this.distanceSetpoint = null;
    }
    else {
      if (initObj.hasOwnProperty('Kp')) {
        this.Kp = initObj.Kp
      }
      else {
        this.Kp = 0.0;
      }
      if (initObj.hasOwnProperty('Ki')) {
        this.Ki = initObj.Ki
      }
      else {
        this.Ki = 0.0;
      }
      if (initObj.hasOwnProperty('Kd')) {
        this.Kd = initObj.Kd
      }
      else {
        this.Kd = 0.0;
      }
      if (initObj.hasOwnProperty('velocitySetpoint')) {
        this.velocitySetpoint = initObj.velocitySetpoint
      }
      else {
        this.velocitySetpoint = 0.0;
      }
      if (initObj.hasOwnProperty('distanceSetpoint')) {
        this.distanceSetpoint = initObj.distanceSetpoint
      }
      else {
        this.distanceSetpoint = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AccParameters
    // Serialize message field [Kp]
    bufferOffset = _serializer.float32(obj.Kp, buffer, bufferOffset);
    // Serialize message field [Ki]
    bufferOffset = _serializer.float32(obj.Ki, buffer, bufferOffset);
    // Serialize message field [Kd]
    bufferOffset = _serializer.float32(obj.Kd, buffer, bufferOffset);
    // Serialize message field [velocitySetpoint]
    bufferOffset = _serializer.float32(obj.velocitySetpoint, buffer, bufferOffset);
    // Serialize message field [distanceSetpoint]
    bufferOffset = _serializer.float32(obj.distanceSetpoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AccParameters
    let len;
    let data = new AccParameters(null);
    // Deserialize message field [Kp]
    data.Kp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Ki]
    data.Ki = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Kd]
    data.Kd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [velocitySetpoint]
    data.velocitySetpoint = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distanceSetpoint]
    data.distanceSetpoint = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/AccParameters';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5eeae744c2e67ea25e37fe82a1c8dd42';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 Kp
    float32 Ki
    float32 Kd
    float32 velocitySetpoint
    float32 distanceSetpoint
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AccParameters(null);
    if (msg.Kp !== undefined) {
      resolved.Kp = msg.Kp;
    }
    else {
      resolved.Kp = 0.0
    }

    if (msg.Ki !== undefined) {
      resolved.Ki = msg.Ki;
    }
    else {
      resolved.Ki = 0.0
    }

    if (msg.Kd !== undefined) {
      resolved.Kd = msg.Kd;
    }
    else {
      resolved.Kd = 0.0
    }

    if (msg.velocitySetpoint !== undefined) {
      resolved.velocitySetpoint = msg.velocitySetpoint;
    }
    else {
      resolved.velocitySetpoint = 0.0
    }

    if (msg.distanceSetpoint !== undefined) {
      resolved.distanceSetpoint = msg.distanceSetpoint;
    }
    else {
      resolved.distanceSetpoint = 0.0
    }

    return resolved;
    }
};

module.exports = AccParameters;
