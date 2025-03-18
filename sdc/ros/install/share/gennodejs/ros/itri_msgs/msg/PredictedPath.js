// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class PredictedPath {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.probability = null;
      this.predicted_path = null;
      this.predicted_velocity = null;
    }
    else {
      if (initObj.hasOwnProperty('probability')) {
        this.probability = initObj.probability
      }
      else {
        this.probability = 0.0;
      }
      if (initObj.hasOwnProperty('predicted_path')) {
        this.predicted_path = initObj.predicted_path
      }
      else {
        this.predicted_path = [];
      }
      if (initObj.hasOwnProperty('predicted_velocity')) {
        this.predicted_velocity = initObj.predicted_velocity
      }
      else {
        this.predicted_velocity = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PredictedPath
    // Serialize message field [probability]
    bufferOffset = _serializer.float32(obj.probability, buffer, bufferOffset);
    // Serialize message field [predicted_path]
    // Serialize the length for message field [predicted_path]
    bufferOffset = _serializer.uint32(obj.predicted_path.length, buffer, bufferOffset);
    obj.predicted_path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [predicted_velocity]
    // Serialize the length for message field [predicted_velocity]
    bufferOffset = _serializer.uint32(obj.predicted_velocity.length, buffer, bufferOffset);
    obj.predicted_velocity.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PredictedPath
    let len;
    let data = new PredictedPath(null);
    // Deserialize message field [probability]
    data.probability = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [predicted_path]
    // Deserialize array length for message field [predicted_path]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.predicted_path = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.predicted_path[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [predicted_velocity]
    // Deserialize array length for message field [predicted_velocity]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.predicted_velocity = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.predicted_velocity[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.predicted_path.length;
    length += 24 * object.predicted_velocity.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/PredictedPath';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '46863c23a206bf9673e0a4bf16fae636';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 probability
    geometry_msgs/Point[] predicted_path
    geometry_msgs/Point[] predicted_velocity
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PredictedPath(null);
    if (msg.probability !== undefined) {
      resolved.probability = msg.probability;
    }
    else {
      resolved.probability = 0.0
    }

    if (msg.predicted_path !== undefined) {
      resolved.predicted_path = new Array(msg.predicted_path.length);
      for (let i = 0; i < resolved.predicted_path.length; ++i) {
        resolved.predicted_path[i] = geometry_msgs.msg.Point.Resolve(msg.predicted_path[i]);
      }
    }
    else {
      resolved.predicted_path = []
    }

    if (msg.predicted_velocity !== undefined) {
      resolved.predicted_velocity = new Array(msg.predicted_velocity.length);
      for (let i = 0; i < resolved.predicted_velocity.length; ++i) {
        resolved.predicted_velocity[i] = geometry_msgs.msg.Point.Resolve(msg.predicted_velocity[i]);
      }
    }
    else {
      resolved.predicted_velocity = []
    }

    return resolved;
    }
};

module.exports = PredictedPath;
