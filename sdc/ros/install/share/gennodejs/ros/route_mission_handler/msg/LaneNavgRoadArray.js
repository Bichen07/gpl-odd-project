// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LaneNavgRoad = require('./LaneNavgRoad.js');

//-----------------------------------------------------------

class LaneNavgRoadArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lanenavgroads = null;
    }
    else {
      if (initObj.hasOwnProperty('lanenavgroads')) {
        this.lanenavgroads = initObj.lanenavgroads
      }
      else {
        this.lanenavgroads = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LaneNavgRoadArray
    // Serialize message field [lanenavgroads]
    // Serialize the length for message field [lanenavgroads]
    bufferOffset = _serializer.uint32(obj.lanenavgroads.length, buffer, bufferOffset);
    obj.lanenavgroads.forEach((val) => {
      bufferOffset = LaneNavgRoad.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LaneNavgRoadArray
    let len;
    let data = new LaneNavgRoadArray(null);
    // Deserialize message field [lanenavgroads]
    // Deserialize array length for message field [lanenavgroads]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lanenavgroads = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lanenavgroads[i] = LaneNavgRoad.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.lanenavgroads.forEach((val) => {
      length += LaneNavgRoad.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/LaneNavgRoadArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9dd8b7cd48bd0df0290a75d6bb5b2e91';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    LaneNavgRoad[] lanenavgroads
    
    ================================================================================
    MSG: route_mission_handler/LaneNavgRoad
    int32 lane_id
    int32 laneno
    int32 navgroad1
    bool isPositive1
    int32 navgroad2
    bool isPositive2
    string seqner
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LaneNavgRoadArray(null);
    if (msg.lanenavgroads !== undefined) {
      resolved.lanenavgroads = new Array(msg.lanenavgroads.length);
      for (let i = 0; i < resolved.lanenavgroads.length; ++i) {
        resolved.lanenavgroads[i] = LaneNavgRoad.Resolve(msg.lanenavgroads[i]);
      }
    }
    else {
      resolved.lanenavgroads = []
    }

    return resolved;
    }
};

module.exports = LaneNavgRoadArray;
