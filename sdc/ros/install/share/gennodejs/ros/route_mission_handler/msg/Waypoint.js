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

class Waypoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lane_id = null;
      this.point_id = null;
      this.nroad_id = null;
      this.roadWidth = null;
      this.distToRightLine = null;
      this.distToLeftLine = null;
      this.right_road_bound = null;
      this.left_road_bound = null;
      this.curvature = null;
      this.heading = null;
      this.point = null;
      this.markerIds = null;
      this.markerTypes = null;
      this.parkingLotId = null;
      this.parkingLotLaneId = null;
    }
    else {
      if (initObj.hasOwnProperty('lane_id')) {
        this.lane_id = initObj.lane_id
      }
      else {
        this.lane_id = 0;
      }
      if (initObj.hasOwnProperty('point_id')) {
        this.point_id = initObj.point_id
      }
      else {
        this.point_id = 0;
      }
      if (initObj.hasOwnProperty('nroad_id')) {
        this.nroad_id = initObj.nroad_id
      }
      else {
        this.nroad_id = 0;
      }
      if (initObj.hasOwnProperty('roadWidth')) {
        this.roadWidth = initObj.roadWidth
      }
      else {
        this.roadWidth = 0.0;
      }
      if (initObj.hasOwnProperty('distToRightLine')) {
        this.distToRightLine = initObj.distToRightLine
      }
      else {
        this.distToRightLine = 0.0;
      }
      if (initObj.hasOwnProperty('distToLeftLine')) {
        this.distToLeftLine = initObj.distToLeftLine
      }
      else {
        this.distToLeftLine = 0.0;
      }
      if (initObj.hasOwnProperty('right_road_bound')) {
        this.right_road_bound = initObj.right_road_bound
      }
      else {
        this.right_road_bound = 0.0;
      }
      if (initObj.hasOwnProperty('left_road_bound')) {
        this.left_road_bound = initObj.left_road_bound
      }
      else {
        this.left_road_bound = 0.0;
      }
      if (initObj.hasOwnProperty('curvature')) {
        this.curvature = initObj.curvature
      }
      else {
        this.curvature = 0.0;
      }
      if (initObj.hasOwnProperty('heading')) {
        this.heading = initObj.heading
      }
      else {
        this.heading = 0.0;
      }
      if (initObj.hasOwnProperty('point')) {
        this.point = initObj.point
      }
      else {
        this.point = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('markerIds')) {
        this.markerIds = initObj.markerIds
      }
      else {
        this.markerIds = [];
      }
      if (initObj.hasOwnProperty('markerTypes')) {
        this.markerTypes = initObj.markerTypes
      }
      else {
        this.markerTypes = [];
      }
      if (initObj.hasOwnProperty('parkingLotId')) {
        this.parkingLotId = initObj.parkingLotId
      }
      else {
        this.parkingLotId = 0;
      }
      if (initObj.hasOwnProperty('parkingLotLaneId')) {
        this.parkingLotLaneId = initObj.parkingLotLaneId
      }
      else {
        this.parkingLotLaneId = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Waypoint
    // Serialize message field [lane_id]
    bufferOffset = _serializer.int32(obj.lane_id, buffer, bufferOffset);
    // Serialize message field [point_id]
    bufferOffset = _serializer.int32(obj.point_id, buffer, bufferOffset);
    // Serialize message field [nroad_id]
    bufferOffset = _serializer.int32(obj.nroad_id, buffer, bufferOffset);
    // Serialize message field [roadWidth]
    bufferOffset = _serializer.float32(obj.roadWidth, buffer, bufferOffset);
    // Serialize message field [distToRightLine]
    bufferOffset = _serializer.float32(obj.distToRightLine, buffer, bufferOffset);
    // Serialize message field [distToLeftLine]
    bufferOffset = _serializer.float32(obj.distToLeftLine, buffer, bufferOffset);
    // Serialize message field [right_road_bound]
    bufferOffset = _serializer.float32(obj.right_road_bound, buffer, bufferOffset);
    // Serialize message field [left_road_bound]
    bufferOffset = _serializer.float32(obj.left_road_bound, buffer, bufferOffset);
    // Serialize message field [curvature]
    bufferOffset = _serializer.float32(obj.curvature, buffer, bufferOffset);
    // Serialize message field [heading]
    bufferOffset = _serializer.float32(obj.heading, buffer, bufferOffset);
    // Serialize message field [point]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.point, buffer, bufferOffset);
    // Serialize message field [markerIds]
    bufferOffset = _arraySerializer.int32(obj.markerIds, buffer, bufferOffset, null);
    // Serialize message field [markerTypes]
    bufferOffset = _arraySerializer.int32(obj.markerTypes, buffer, bufferOffset, null);
    // Serialize message field [parkingLotId]
    bufferOffset = _serializer.int32(obj.parkingLotId, buffer, bufferOffset);
    // Serialize message field [parkingLotLaneId]
    bufferOffset = _serializer.int32(obj.parkingLotLaneId, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Waypoint
    let len;
    let data = new Waypoint(null);
    // Deserialize message field [lane_id]
    data.lane_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [point_id]
    data.point_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nroad_id]
    data.nroad_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [roadWidth]
    data.roadWidth = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distToRightLine]
    data.distToRightLine = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distToLeftLine]
    data.distToLeftLine = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [right_road_bound]
    data.right_road_bound = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [left_road_bound]
    data.left_road_bound = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [curvature]
    data.curvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [heading]
    data.heading = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [point]
    data.point = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [markerIds]
    data.markerIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [markerTypes]
    data.markerTypes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [parkingLotId]
    data.parkingLotId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [parkingLotLaneId]
    data.parkingLotLaneId = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.markerIds.length;
    length += 4 * object.markerTypes.length;
    return length + 80;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Waypoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a3470e7d3e109ed20173633523dd455c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 lane_id
    int32 point_id
    int32 nroad_id
    float32 roadWidth
    float32 distToRightLine
    float32 distToLeftLine
    float32 right_road_bound
    float32 left_road_bound
    float32 curvature
    float32 heading
    geometry_msgs/Point point
    int32[] markerIds
    int32[] markerTypes
    int32 parkingLotId
    int32 parkingLotLaneId
    
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
    const resolved = new Waypoint(null);
    if (msg.lane_id !== undefined) {
      resolved.lane_id = msg.lane_id;
    }
    else {
      resolved.lane_id = 0
    }

    if (msg.point_id !== undefined) {
      resolved.point_id = msg.point_id;
    }
    else {
      resolved.point_id = 0
    }

    if (msg.nroad_id !== undefined) {
      resolved.nroad_id = msg.nroad_id;
    }
    else {
      resolved.nroad_id = 0
    }

    if (msg.roadWidth !== undefined) {
      resolved.roadWidth = msg.roadWidth;
    }
    else {
      resolved.roadWidth = 0.0
    }

    if (msg.distToRightLine !== undefined) {
      resolved.distToRightLine = msg.distToRightLine;
    }
    else {
      resolved.distToRightLine = 0.0
    }

    if (msg.distToLeftLine !== undefined) {
      resolved.distToLeftLine = msg.distToLeftLine;
    }
    else {
      resolved.distToLeftLine = 0.0
    }

    if (msg.right_road_bound !== undefined) {
      resolved.right_road_bound = msg.right_road_bound;
    }
    else {
      resolved.right_road_bound = 0.0
    }

    if (msg.left_road_bound !== undefined) {
      resolved.left_road_bound = msg.left_road_bound;
    }
    else {
      resolved.left_road_bound = 0.0
    }

    if (msg.curvature !== undefined) {
      resolved.curvature = msg.curvature;
    }
    else {
      resolved.curvature = 0.0
    }

    if (msg.heading !== undefined) {
      resolved.heading = msg.heading;
    }
    else {
      resolved.heading = 0.0
    }

    if (msg.point !== undefined) {
      resolved.point = geometry_msgs.msg.Point.Resolve(msg.point)
    }
    else {
      resolved.point = new geometry_msgs.msg.Point()
    }

    if (msg.markerIds !== undefined) {
      resolved.markerIds = msg.markerIds;
    }
    else {
      resolved.markerIds = []
    }

    if (msg.markerTypes !== undefined) {
      resolved.markerTypes = msg.markerTypes;
    }
    else {
      resolved.markerTypes = []
    }

    if (msg.parkingLotId !== undefined) {
      resolved.parkingLotId = msg.parkingLotId;
    }
    else {
      resolved.parkingLotId = 0
    }

    if (msg.parkingLotLaneId !== undefined) {
      resolved.parkingLotLaneId = msg.parkingLotLaneId;
    }
    else {
      resolved.parkingLotLaneId = 0
    }

    return resolved;
    }
};

module.exports = Waypoint;
