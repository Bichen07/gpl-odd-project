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

class ParkingSpace {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.type = null;
      this.side = null;
      this.id = null;
      this.parkingLotId = null;
      this.laneId = null;
      this.pointId = null;
      this.orderType = null;
      this.points = null;
    }
    else {
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('side')) {
        this.side = initObj.side
      }
      else {
        this.side = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('parkingLotId')) {
        this.parkingLotId = initObj.parkingLotId
      }
      else {
        this.parkingLotId = 0;
      }
      if (initObj.hasOwnProperty('laneId')) {
        this.laneId = initObj.laneId
      }
      else {
        this.laneId = 0;
      }
      if (initObj.hasOwnProperty('pointId')) {
        this.pointId = initObj.pointId
      }
      else {
        this.pointId = 0;
      }
      if (initObj.hasOwnProperty('orderType')) {
        this.orderType = initObj.orderType
      }
      else {
        this.orderType = 0;
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParkingSpace
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [side]
    bufferOffset = _serializer.int32(obj.side, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [parkingLotId]
    bufferOffset = _serializer.int32(obj.parkingLotId, buffer, bufferOffset);
    // Serialize message field [laneId]
    bufferOffset = _serializer.int32(obj.laneId, buffer, bufferOffset);
    // Serialize message field [pointId]
    bufferOffset = _serializer.int32(obj.pointId, buffer, bufferOffset);
    // Serialize message field [orderType]
    bufferOffset = _serializer.int32(obj.orderType, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParkingSpace
    let len;
    let data = new ParkingSpace(null);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [side]
    data.side = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [parkingLotId]
    data.parkingLotId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [laneId]
    data.laneId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointId]
    data.pointId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [orderType]
    data.orderType = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.points.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/ParkingSpace';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '98fbce91faa2b53804e2c7e966c04f2d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 type
    int32 VERTICAL=0
    int32 PARALLEL=1
    int32 OBLIQUE=2
    
    int32 side
    int32 RIGHT=0
    int32 LEFT=1
    
    int32 id
    int32 parkingLotId
    int32 laneId
    int32 pointId
    int32 orderType
    geometry_msgs/Point[] points
    
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
    const resolved = new ParkingSpace(null);
    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.side !== undefined) {
      resolved.side = msg.side;
    }
    else {
      resolved.side = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.parkingLotId !== undefined) {
      resolved.parkingLotId = msg.parkingLotId;
    }
    else {
      resolved.parkingLotId = 0
    }

    if (msg.laneId !== undefined) {
      resolved.laneId = msg.laneId;
    }
    else {
      resolved.laneId = 0
    }

    if (msg.pointId !== undefined) {
      resolved.pointId = msg.pointId;
    }
    else {
      resolved.pointId = 0
    }

    if (msg.orderType !== undefined) {
      resolved.orderType = msg.orderType;
    }
    else {
      resolved.orderType = 0
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

    return resolved;
    }
};

// Constants for message
ParkingSpace.Constants = {
  VERTICAL: 0,
  PARALLEL: 1,
  OBLIQUE: 2,
  RIGHT: 0,
  LEFT: 1,
}

module.exports = ParkingSpace;
