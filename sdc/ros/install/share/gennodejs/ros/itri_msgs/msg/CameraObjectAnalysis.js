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

class CameraObjectAnalysis {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.center_distance = null;
      this.diou = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('center_distance')) {
        this.center_distance = initObj.center_distance
      }
      else {
        this.center_distance = 0.0;
      }
      if (initObj.hasOwnProperty('diou')) {
        this.diou = initObj.diou
      }
      else {
        this.diou = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraObjectAnalysis
    // Serialize message field [id]
    bufferOffset = _serializer.uint32(obj.id, buffer, bufferOffset);
    // Serialize message field [center_distance]
    bufferOffset = _serializer.float32(obj.center_distance, buffer, bufferOffset);
    // Serialize message field [diou]
    bufferOffset = _serializer.float32(obj.diou, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraObjectAnalysis
    let len;
    let data = new CameraObjectAnalysis(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [center_distance]
    data.center_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [diou]
    data.diou = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/CameraObjectAnalysis';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ced6441f7a38e34baaa1c710d22e6e89';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 id
    float32 center_distance
    float32 diou
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CameraObjectAnalysis(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.center_distance !== undefined) {
      resolved.center_distance = msg.center_distance;
    }
    else {
      resolved.center_distance = 0.0
    }

    if (msg.diou !== undefined) {
      resolved.diou = msg.diou;
    }
    else {
      resolved.diou = 0.0
    }

    return resolved;
    }
};

module.exports = CameraObjectAnalysis;
