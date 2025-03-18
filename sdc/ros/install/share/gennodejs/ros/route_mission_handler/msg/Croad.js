// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Croad {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nroad_id = null;
      this.isPositive = null;
      this.point_id = null;
      this.lane_ids = null;
      this.points = null;
      this.fixed = null;
    }
    else {
      if (initObj.hasOwnProperty('nroad_id')) {
        this.nroad_id = initObj.nroad_id
      }
      else {
        this.nroad_id = 0;
      }
      if (initObj.hasOwnProperty('isPositive')) {
        this.isPositive = initObj.isPositive
      }
      else {
        this.isPositive = false;
      }
      if (initObj.hasOwnProperty('point_id')) {
        this.point_id = initObj.point_id
      }
      else {
        this.point_id = 0;
      }
      if (initObj.hasOwnProperty('lane_ids')) {
        this.lane_ids = initObj.lane_ids
      }
      else {
        this.lane_ids = [];
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('fixed')) {
        this.fixed = initObj.fixed
      }
      else {
        this.fixed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Croad
    // Serialize message field [nroad_id]
    bufferOffset = _serializer.int32(obj.nroad_id, buffer, bufferOffset);
    // Serialize message field [isPositive]
    bufferOffset = _serializer.bool(obj.isPositive, buffer, bufferOffset);
    // Serialize message field [point_id]
    bufferOffset = _serializer.int32(obj.point_id, buffer, bufferOffset);
    // Serialize message field [lane_ids]
    bufferOffset = _arraySerializer.int32(obj.lane_ids, buffer, bufferOffset, null);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [fixed]
    bufferOffset = _serializer.bool(obj.fixed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Croad
    let len;
    let data = new Croad(null);
    // Deserialize message field [nroad_id]
    data.nroad_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [isPositive]
    data.isPositive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [point_id]
    data.point_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lane_ids]
    data.lane_ids = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [fixed]
    data.fixed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.lane_ids.length;
    length += 24 * object.points.length;
    return length + 18;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Croad';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e73c05c21378699cef67e9582f6575b4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 nroad_id
    bool isPositive
    int32 point_id
    int32[] lane_ids
    geometry_msgs/Point[] points
    bool fixed
    
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
    const resolved = new Croad(null);
    if (msg.nroad_id !== undefined) {
      resolved.nroad_id = msg.nroad_id;
    }
    else {
      resolved.nroad_id = 0
    }

    if (msg.isPositive !== undefined) {
      resolved.isPositive = msg.isPositive;
    }
    else {
      resolved.isPositive = false
    }

    if (msg.point_id !== undefined) {
      resolved.point_id = msg.point_id;
    }
    else {
      resolved.point_id = 0
    }

    if (msg.lane_ids !== undefined) {
      resolved.lane_ids = msg.lane_ids;
    }
    else {
      resolved.lane_ids = []
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = geometry_msgs.msg.Point.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    if (msg.fixed !== undefined) {
      resolved.fixed = msg.fixed;
    }
    else {
      resolved.fixed = false
    }

    return resolved;
    }
};

module.exports = Croad;
