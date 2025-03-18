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

class Pair {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.laneId = null;
      this.pointIds = null;
    }
    else {
      if (initObj.hasOwnProperty('laneId')) {
        this.laneId = initObj.laneId
      }
      else {
        this.laneId = 0;
      }
      if (initObj.hasOwnProperty('pointIds')) {
        this.pointIds = initObj.pointIds
      }
      else {
        this.pointIds = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Pair
    // Serialize message field [laneId]
    bufferOffset = _serializer.int32(obj.laneId, buffer, bufferOffset);
    // Serialize message field [pointIds]
    bufferOffset = _arraySerializer.int32(obj.pointIds, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Pair
    let len;
    let data = new Pair(null);
    // Deserialize message field [laneId]
    data.laneId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointIds]
    data.pointIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.pointIds.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Pair';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9c79f7b537dfd0f3480010c95f09d489';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 laneId
    int32[] pointIds
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Pair(null);
    if (msg.laneId !== undefined) {
      resolved.laneId = msg.laneId;
    }
    else {
      resolved.laneId = 0
    }

    if (msg.pointIds !== undefined) {
      resolved.pointIds = msg.pointIds;
    }
    else {
      resolved.pointIds = []
    }

    return resolved;
    }
};

module.exports = Pair;
