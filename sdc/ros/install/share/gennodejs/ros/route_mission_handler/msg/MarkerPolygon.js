// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Pair = require('./Pair.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class MarkerPolygon {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.type = null;
      this.navgId = null;
      this.pairs = null;
      this.center_point = null;
      this.corner_points = null;
      this.on = null;
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('navgId')) {
        this.navgId = initObj.navgId
      }
      else {
        this.navgId = 0;
      }
      if (initObj.hasOwnProperty('pairs')) {
        this.pairs = initObj.pairs
      }
      else {
        this.pairs = [];
      }
      if (initObj.hasOwnProperty('center_point')) {
        this.center_point = initObj.center_point
      }
      else {
        this.center_point = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('corner_points')) {
        this.corner_points = initObj.corner_points
      }
      else {
        this.corner_points = [];
      }
      if (initObj.hasOwnProperty('on')) {
        this.on = initObj.on
      }
      else {
        this.on = false;
      }
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MarkerPolygon
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [navgId]
    bufferOffset = _serializer.int32(obj.navgId, buffer, bufferOffset);
    // Serialize message field [pairs]
    // Serialize the length for message field [pairs]
    bufferOffset = _serializer.uint32(obj.pairs.length, buffer, bufferOffset);
    obj.pairs.forEach((val) => {
      bufferOffset = Pair.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [center_point]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.center_point, buffer, bufferOffset);
    // Serialize message field [corner_points]
    // Serialize the length for message field [corner_points]
    bufferOffset = _serializer.uint32(obj.corner_points.length, buffer, bufferOffset);
    obj.corner_points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [on]
    bufferOffset = _serializer.bool(obj.on, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.string(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MarkerPolygon
    let len;
    let data = new MarkerPolygon(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [navgId]
    data.navgId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pairs]
    // Deserialize array length for message field [pairs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pairs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pairs[i] = Pair.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [center_point]
    data.center_point = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [corner_points]
    // Deserialize array length for message field [corner_points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.corner_points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.corner_points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [on]
    data.on = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.pairs.forEach((val) => {
      length += Pair.getMessageSize(val);
    });
    length += 24 * object.corner_points.length;
    length += object.value.length;
    return length + 49;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/MarkerPolygon';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '040152815f20ff5033794b4d0e7f012f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 id
    int32 type
    int32 navgId
    Pair[] pairs
    geometry_msgs/Point center_point
    geometry_msgs/Point[] corner_points
    bool on
    string value
    
    ================================================================================
    MSG: route_mission_handler/Pair
    int32 laneId
    int32[] pointIds
    
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
    const resolved = new MarkerPolygon(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.navgId !== undefined) {
      resolved.navgId = msg.navgId;
    }
    else {
      resolved.navgId = 0
    }

    if (msg.pairs !== undefined) {
      resolved.pairs = new Array(msg.pairs.length);
      for (let i = 0; i < resolved.pairs.length; ++i) {
        resolved.pairs[i] = Pair.Resolve(msg.pairs[i]);
      }
    }
    else {
      resolved.pairs = []
    }

    if (msg.center_point !== undefined) {
      resolved.center_point = geometry_msgs.msg.Point.Resolve(msg.center_point)
    }
    else {
      resolved.center_point = new geometry_msgs.msg.Point()
    }

    if (msg.corner_points !== undefined) {
      resolved.corner_points = new Array(msg.corner_points.length);
      for (let i = 0; i < resolved.corner_points.length; ++i) {
        resolved.corner_points[i] = geometry_msgs.msg.Point.Resolve(msg.corner_points[i]);
      }
    }
    else {
      resolved.corner_points = []
    }

    if (msg.on !== undefined) {
      resolved.on = msg.on;
    }
    else {
      resolved.on = false
    }

    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = ''
    }

    return resolved;
    }
};

module.exports = MarkerPolygon;
