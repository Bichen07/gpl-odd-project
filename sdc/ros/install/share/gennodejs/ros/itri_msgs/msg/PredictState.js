// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PredictState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.quaternion = null;
      this.translation = null;
      this.rotation = null;
      this.rotation_rate_bias = null;
      this.acceleration_bias = null;
      this.acceleration_scale = null;
      this.speed = null;
      this.covariance = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('quaternion')) {
        this.quaternion = initObj.quaternion
      }
      else {
        this.quaternion = new Array(4).fill(0);
      }
      if (initObj.hasOwnProperty('translation')) {
        this.translation = initObj.translation
      }
      else {
        this.translation = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('rotation')) {
        this.rotation = initObj.rotation
      }
      else {
        this.rotation = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('rotation_rate_bias')) {
        this.rotation_rate_bias = initObj.rotation_rate_bias
      }
      else {
        this.rotation_rate_bias = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('acceleration_bias')) {
        this.acceleration_bias = initObj.acceleration_bias
      }
      else {
        this.acceleration_bias = 0.0;
      }
      if (initObj.hasOwnProperty('acceleration_scale')) {
        this.acceleration_scale = initObj.acceleration_scale
      }
      else {
        this.acceleration_scale = 0.0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('covariance')) {
        this.covariance = initObj.covariance
      }
      else {
        this.covariance = new Array(121).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PredictState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Check that the constant length array field [quaternion] has the right length
    if (obj.quaternion.length !== 4) {
      throw new Error('Unable to serialize array field quaternion - length must be 4')
    }
    // Serialize message field [quaternion]
    bufferOffset = _arraySerializer.float32(obj.quaternion, buffer, bufferOffset, 4);
    // Check that the constant length array field [translation] has the right length
    if (obj.translation.length !== 3) {
      throw new Error('Unable to serialize array field translation - length must be 3')
    }
    // Serialize message field [translation]
    bufferOffset = _arraySerializer.float32(obj.translation, buffer, bufferOffset, 3);
    // Check that the constant length array field [rotation] has the right length
    if (obj.rotation.length !== 3) {
      throw new Error('Unable to serialize array field rotation - length must be 3')
    }
    // Serialize message field [rotation]
    bufferOffset = _arraySerializer.float32(obj.rotation, buffer, bufferOffset, 3);
    // Check that the constant length array field [rotation_rate_bias] has the right length
    if (obj.rotation_rate_bias.length !== 3) {
      throw new Error('Unable to serialize array field rotation_rate_bias - length must be 3')
    }
    // Serialize message field [rotation_rate_bias]
    bufferOffset = _arraySerializer.float32(obj.rotation_rate_bias, buffer, bufferOffset, 3);
    // Serialize message field [acceleration_bias]
    bufferOffset = _serializer.float32(obj.acceleration_bias, buffer, bufferOffset);
    // Serialize message field [acceleration_scale]
    bufferOffset = _serializer.float32(obj.acceleration_scale, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Check that the constant length array field [covariance] has the right length
    if (obj.covariance.length !== 121) {
      throw new Error('Unable to serialize array field covariance - length must be 121')
    }
    // Serialize message field [covariance]
    bufferOffset = _arraySerializer.float32(obj.covariance, buffer, bufferOffset, 121);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PredictState
    let len;
    let data = new PredictState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [quaternion]
    data.quaternion = _arrayDeserializer.float32(buffer, bufferOffset, 4)
    // Deserialize message field [translation]
    data.translation = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [rotation]
    data.rotation = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [rotation_rate_bias]
    data.rotation_rate_bias = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [acceleration_bias]
    data.acceleration_bias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [acceleration_scale]
    data.acceleration_scale = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [covariance]
    data.covariance = _arrayDeserializer.float32(buffer, bufferOffset, 121)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 548;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/PredictState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '72d0803d1465f548e6ee4eb9d0ba77d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[4] quaternion
    float32[3] translation
    float32[3] rotation
    float32[3] rotation_rate_bias
    float32 acceleration_bias
    float32 acceleration_scale
    float32 speed
    
    float32[121] covariance
    
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
    const resolved = new PredictState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.quaternion !== undefined) {
      resolved.quaternion = msg.quaternion;
    }
    else {
      resolved.quaternion = new Array(4).fill(0)
    }

    if (msg.translation !== undefined) {
      resolved.translation = msg.translation;
    }
    else {
      resolved.translation = new Array(3).fill(0)
    }

    if (msg.rotation !== undefined) {
      resolved.rotation = msg.rotation;
    }
    else {
      resolved.rotation = new Array(3).fill(0)
    }

    if (msg.rotation_rate_bias !== undefined) {
      resolved.rotation_rate_bias = msg.rotation_rate_bias;
    }
    else {
      resolved.rotation_rate_bias = new Array(3).fill(0)
    }

    if (msg.acceleration_bias !== undefined) {
      resolved.acceleration_bias = msg.acceleration_bias;
    }
    else {
      resolved.acceleration_bias = 0.0
    }

    if (msg.acceleration_scale !== undefined) {
      resolved.acceleration_scale = msg.acceleration_scale;
    }
    else {
      resolved.acceleration_scale = 0.0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.covariance !== undefined) {
      resolved.covariance = msg.covariance;
    }
    else {
      resolved.covariance = new Array(121).fill(0)
    }

    return resolved;
    }
};

module.exports = PredictState;
