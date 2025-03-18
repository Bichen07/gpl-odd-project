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

class TrafficLight {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.laneIds = null;
      this.type = null;
      this.lightNum = null;
      this.vps = null;
      this.vpe = null;
      this.heading = null;
      this.points = null;
      this.lights = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('laneIds')) {
        this.laneIds = initObj.laneIds
      }
      else {
        this.laneIds = [];
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('lightNum')) {
        this.lightNum = initObj.lightNum
      }
      else {
        this.lightNum = 0;
      }
      if (initObj.hasOwnProperty('vps')) {
        this.vps = initObj.vps
      }
      else {
        this.vps = '';
      }
      if (initObj.hasOwnProperty('vpe')) {
        this.vpe = initObj.vpe
      }
      else {
        this.vpe = '';
      }
      if (initObj.hasOwnProperty('heading')) {
        this.heading = initObj.heading
      }
      else {
        this.heading = 0.0;
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('lights')) {
        this.lights = initObj.lights
      }
      else {
        this.lights = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficLight
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [laneIds]
    bufferOffset = _arraySerializer.int32(obj.laneIds, buffer, bufferOffset, null);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [lightNum]
    bufferOffset = _serializer.int32(obj.lightNum, buffer, bufferOffset);
    // Serialize message field [vps]
    bufferOffset = _serializer.string(obj.vps, buffer, bufferOffset);
    // Serialize message field [vpe]
    bufferOffset = _serializer.string(obj.vpe, buffer, bufferOffset);
    // Serialize message field [heading]
    bufferOffset = _serializer.float32(obj.heading, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [lights]
    bufferOffset = _arraySerializer.string(obj.lights, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficLight
    let len;
    let data = new TrafficLight(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [laneIds]
    data.laneIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lightNum]
    data.lightNum = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [vps]
    data.vps = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [vpe]
    data.vpe = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [heading]
    data.heading = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [lights]
    data.lights = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.laneIds.length;
    length += object.vps.length;
    length += object.vpe.length;
    length += 24 * object.points.length;
    object.lights.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/TrafficLight';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '48c6cfe6d51fe7a3ff894f880970f709';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 id
    int32[] laneIds
    int32 type
    int32 lightNum
    string vps
    string vpe
    float32 heading
    geometry_msgs/Point[] points
    string[] lights
    
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
    const resolved = new TrafficLight(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.laneIds !== undefined) {
      resolved.laneIds = msg.laneIds;
    }
    else {
      resolved.laneIds = []
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.lightNum !== undefined) {
      resolved.lightNum = msg.lightNum;
    }
    else {
      resolved.lightNum = 0
    }

    if (msg.vps !== undefined) {
      resolved.vps = msg.vps;
    }
    else {
      resolved.vps = ''
    }

    if (msg.vpe !== undefined) {
      resolved.vpe = msg.vpe;
    }
    else {
      resolved.vpe = ''
    }

    if (msg.heading !== undefined) {
      resolved.heading = msg.heading;
    }
    else {
      resolved.heading = 0.0
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

    if (msg.lights !== undefined) {
      resolved.lights = msg.lights;
    }
    else {
      resolved.lights = []
    }

    return resolved;
    }
};

module.exports = TrafficLight;
