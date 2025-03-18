// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let GPS = require('./GPS.js');

//-----------------------------------------------------------

class PointsMapInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.num_submaps = null;
      this.total_points = null;
      this.gps_reference = null;
    }
    else {
      if (initObj.hasOwnProperty('num_submaps')) {
        this.num_submaps = initObj.num_submaps
      }
      else {
        this.num_submaps = 0;
      }
      if (initObj.hasOwnProperty('total_points')) {
        this.total_points = initObj.total_points
      }
      else {
        this.total_points = 0;
      }
      if (initObj.hasOwnProperty('gps_reference')) {
        this.gps_reference = initObj.gps_reference
      }
      else {
        this.gps_reference = new GPS();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PointsMapInfo
    // Serialize message field [num_submaps]
    bufferOffset = _serializer.uint32(obj.num_submaps, buffer, bufferOffset);
    // Serialize message field [total_points]
    bufferOffset = _serializer.uint32(obj.total_points, buffer, bufferOffset);
    // Serialize message field [gps_reference]
    bufferOffset = GPS.serialize(obj.gps_reference, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PointsMapInfo
    let len;
    let data = new PointsMapInfo(null);
    // Deserialize message field [num_submaps]
    data.num_submaps = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [total_points]
    data.total_points = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [gps_reference]
    data.gps_reference = GPS.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/PointsMapInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd0f5e60c33a648ff40401f308be12589';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 num_submaps
    uint32 total_points
    GPS gps_reference
    
    ================================================================================
    MSG: itri_msgs/GPS
    float64 latitude
    float64 longitude
    float64 altitude
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PointsMapInfo(null);
    if (msg.num_submaps !== undefined) {
      resolved.num_submaps = msg.num_submaps;
    }
    else {
      resolved.num_submaps = 0
    }

    if (msg.total_points !== undefined) {
      resolved.total_points = msg.total_points;
    }
    else {
      resolved.total_points = 0
    }

    if (msg.gps_reference !== undefined) {
      resolved.gps_reference = GPS.Resolve(msg.gps_reference)
    }
    else {
      resolved.gps_reference = new GPS()
    }

    return resolved;
    }
};

module.exports = PointsMapInfo;
