// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class LaneNavgRoad {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lane_id = null;
      this.laneno = null;
      this.navgroad1 = null;
      this.isPositive1 = null;
      this.navgroad2 = null;
      this.isPositive2 = null;
      this.seqner = null;
    }
    else {
      if (initObj.hasOwnProperty('lane_id')) {
        this.lane_id = initObj.lane_id
      }
      else {
        this.lane_id = 0;
      }
      if (initObj.hasOwnProperty('laneno')) {
        this.laneno = initObj.laneno
      }
      else {
        this.laneno = 0;
      }
      if (initObj.hasOwnProperty('navgroad1')) {
        this.navgroad1 = initObj.navgroad1
      }
      else {
        this.navgroad1 = 0;
      }
      if (initObj.hasOwnProperty('isPositive1')) {
        this.isPositive1 = initObj.isPositive1
      }
      else {
        this.isPositive1 = false;
      }
      if (initObj.hasOwnProperty('navgroad2')) {
        this.navgroad2 = initObj.navgroad2
      }
      else {
        this.navgroad2 = 0;
      }
      if (initObj.hasOwnProperty('isPositive2')) {
        this.isPositive2 = initObj.isPositive2
      }
      else {
        this.isPositive2 = false;
      }
      if (initObj.hasOwnProperty('seqner')) {
        this.seqner = initObj.seqner
      }
      else {
        this.seqner = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LaneNavgRoad
    // Serialize message field [lane_id]
    bufferOffset = _serializer.int32(obj.lane_id, buffer, bufferOffset);
    // Serialize message field [laneno]
    bufferOffset = _serializer.int32(obj.laneno, buffer, bufferOffset);
    // Serialize message field [navgroad1]
    bufferOffset = _serializer.int32(obj.navgroad1, buffer, bufferOffset);
    // Serialize message field [isPositive1]
    bufferOffset = _serializer.bool(obj.isPositive1, buffer, bufferOffset);
    // Serialize message field [navgroad2]
    bufferOffset = _serializer.int32(obj.navgroad2, buffer, bufferOffset);
    // Serialize message field [isPositive2]
    bufferOffset = _serializer.bool(obj.isPositive2, buffer, bufferOffset);
    // Serialize message field [seqner]
    bufferOffset = _serializer.string(obj.seqner, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LaneNavgRoad
    let len;
    let data = new LaneNavgRoad(null);
    // Deserialize message field [lane_id]
    data.lane_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [laneno]
    data.laneno = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [navgroad1]
    data.navgroad1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [isPositive1]
    data.isPositive1 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [navgroad2]
    data.navgroad2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [isPositive2]
    data.isPositive2 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [seqner]
    data.seqner = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.seqner.length;
    return length + 22;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/LaneNavgRoad';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '49966345243e73df88bc1cde32e2f8f0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new LaneNavgRoad(null);
    if (msg.lane_id !== undefined) {
      resolved.lane_id = msg.lane_id;
    }
    else {
      resolved.lane_id = 0
    }

    if (msg.laneno !== undefined) {
      resolved.laneno = msg.laneno;
    }
    else {
      resolved.laneno = 0
    }

    if (msg.navgroad1 !== undefined) {
      resolved.navgroad1 = msg.navgroad1;
    }
    else {
      resolved.navgroad1 = 0
    }

    if (msg.isPositive1 !== undefined) {
      resolved.isPositive1 = msg.isPositive1;
    }
    else {
      resolved.isPositive1 = false
    }

    if (msg.navgroad2 !== undefined) {
      resolved.navgroad2 = msg.navgroad2;
    }
    else {
      resolved.navgroad2 = 0
    }

    if (msg.isPositive2 !== undefined) {
      resolved.isPositive2 = msg.isPositive2;
    }
    else {
      resolved.isPositive2 = false
    }

    if (msg.seqner !== undefined) {
      resolved.seqner = msg.seqner;
    }
    else {
      resolved.seqner = ''
    }

    return resolved;
    }
};

module.exports = LaneNavgRoad;
