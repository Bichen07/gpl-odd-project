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

class PathSegment {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.laneId = null;
      this.startPoint = null;
      this.endPoint = null;
    }
    else {
      if (initObj.hasOwnProperty('laneId')) {
        this.laneId = initObj.laneId
      }
      else {
        this.laneId = 0;
      }
      if (initObj.hasOwnProperty('startPoint')) {
        this.startPoint = initObj.startPoint
      }
      else {
        this.startPoint = 0;
      }
      if (initObj.hasOwnProperty('endPoint')) {
        this.endPoint = initObj.endPoint
      }
      else {
        this.endPoint = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathSegment
    // Serialize message field [laneId]
    bufferOffset = _serializer.int32(obj.laneId, buffer, bufferOffset);
    // Serialize message field [startPoint]
    bufferOffset = _serializer.int32(obj.startPoint, buffer, bufferOffset);
    // Serialize message field [endPoint]
    bufferOffset = _serializer.int32(obj.endPoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathSegment
    let len;
    let data = new PathSegment(null);
    // Deserialize message field [laneId]
    data.laneId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [startPoint]
    data.startPoint = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [endPoint]
    data.endPoint = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/PathSegment';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6ef80e49d1cec715d0fab363071a33fa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 laneId
    int32 startPoint
    int32 endPoint
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PathSegment(null);
    if (msg.laneId !== undefined) {
      resolved.laneId = msg.laneId;
    }
    else {
      resolved.laneId = 0
    }

    if (msg.startPoint !== undefined) {
      resolved.startPoint = msg.startPoint;
    }
    else {
      resolved.startPoint = 0
    }

    if (msg.endPoint !== undefined) {
      resolved.endPoint = msg.endPoint;
    }
    else {
      resolved.endPoint = 0
    }

    return resolved;
    }
};

module.exports = PathSegment;
