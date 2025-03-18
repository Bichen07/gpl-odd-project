// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ParkingSpaceArray = require('./ParkingSpaceArray.js');
let LaneArray = require('./LaneArray.js');
let ParkingLane = require('./ParkingLane.js');
let ParkingSpace = require('./ParkingSpace.js');

//-----------------------------------------------------------

class ParkingLot {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.name = null;
      this.croad1_positive = null;
      this.croad2_positive = null;
      this.nav_croad_id = null;
      this.pointId1 = null;
      this.nav_croad_id2 = null;
      this.pointId2 = null;
      this.space_list = null;
      this.lot_lines = null;
      this.lanes = null;
      this.spaces = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('croad1_positive')) {
        this.croad1_positive = initObj.croad1_positive
      }
      else {
        this.croad1_positive = false;
      }
      if (initObj.hasOwnProperty('croad2_positive')) {
        this.croad2_positive = initObj.croad2_positive
      }
      else {
        this.croad2_positive = false;
      }
      if (initObj.hasOwnProperty('nav_croad_id')) {
        this.nav_croad_id = initObj.nav_croad_id
      }
      else {
        this.nav_croad_id = 0;
      }
      if (initObj.hasOwnProperty('pointId1')) {
        this.pointId1 = initObj.pointId1
      }
      else {
        this.pointId1 = 0;
      }
      if (initObj.hasOwnProperty('nav_croad_id2')) {
        this.nav_croad_id2 = initObj.nav_croad_id2
      }
      else {
        this.nav_croad_id2 = 0;
      }
      if (initObj.hasOwnProperty('pointId2')) {
        this.pointId2 = initObj.pointId2
      }
      else {
        this.pointId2 = 0;
      }
      if (initObj.hasOwnProperty('space_list')) {
        this.space_list = initObj.space_list
      }
      else {
        this.space_list = new ParkingSpaceArray();
      }
      if (initObj.hasOwnProperty('lot_lines')) {
        this.lot_lines = initObj.lot_lines
      }
      else {
        this.lot_lines = new LaneArray();
      }
      if (initObj.hasOwnProperty('lanes')) {
        this.lanes = initObj.lanes
      }
      else {
        this.lanes = [];
      }
      if (initObj.hasOwnProperty('spaces')) {
        this.spaces = initObj.spaces
      }
      else {
        this.spaces = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParkingLot
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [croad1_positive]
    bufferOffset = _serializer.bool(obj.croad1_positive, buffer, bufferOffset);
    // Serialize message field [croad2_positive]
    bufferOffset = _serializer.bool(obj.croad2_positive, buffer, bufferOffset);
    // Serialize message field [nav_croad_id]
    bufferOffset = _serializer.int32(obj.nav_croad_id, buffer, bufferOffset);
    // Serialize message field [pointId1]
    bufferOffset = _serializer.int32(obj.pointId1, buffer, bufferOffset);
    // Serialize message field [nav_croad_id2]
    bufferOffset = _serializer.int32(obj.nav_croad_id2, buffer, bufferOffset);
    // Serialize message field [pointId2]
    bufferOffset = _serializer.int32(obj.pointId2, buffer, bufferOffset);
    // Serialize message field [space_list]
    bufferOffset = ParkingSpaceArray.serialize(obj.space_list, buffer, bufferOffset);
    // Serialize message field [lot_lines]
    bufferOffset = LaneArray.serialize(obj.lot_lines, buffer, bufferOffset);
    // Serialize message field [lanes]
    // Serialize the length for message field [lanes]
    bufferOffset = _serializer.uint32(obj.lanes.length, buffer, bufferOffset);
    obj.lanes.forEach((val) => {
      bufferOffset = ParkingLane.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [spaces]
    // Serialize the length for message field [spaces]
    bufferOffset = _serializer.uint32(obj.spaces.length, buffer, bufferOffset);
    obj.spaces.forEach((val) => {
      bufferOffset = ParkingSpace.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParkingLot
    let len;
    let data = new ParkingLot(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [croad1_positive]
    data.croad1_positive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [croad2_positive]
    data.croad2_positive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [nav_croad_id]
    data.nav_croad_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointId1]
    data.pointId1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nav_croad_id2]
    data.nav_croad_id2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointId2]
    data.pointId2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [space_list]
    data.space_list = ParkingSpaceArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [lot_lines]
    data.lot_lines = LaneArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [lanes]
    // Deserialize array length for message field [lanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lanes[i] = ParkingLane.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [spaces]
    // Deserialize array length for message field [spaces]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.spaces = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.spaces[i] = ParkingSpace.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    length += ParkingSpaceArray.getMessageSize(object.space_list);
    length += LaneArray.getMessageSize(object.lot_lines);
    object.lanes.forEach((val) => {
      length += ParkingLane.getMessageSize(val);
    });
    object.spaces.forEach((val) => {
      length += ParkingSpace.getMessageSize(val);
    });
    return length + 34;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/ParkingLot';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '232125321c146d4640eb356f707cd0da';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 id
    string name
    bool croad1_positive
    bool croad2_positive
    int32 nav_croad_id
    int32 pointId1
    int32 nav_croad_id2
    int32 pointId2
    ParkingSpaceArray space_list
    LaneArray lot_lines
    ParkingLane[] lanes
    ParkingSpace[] spaces
    
    ================================================================================
    MSG: route_mission_handler/ParkingSpaceArray
    ParkingSpace[] spaces
    
    ================================================================================
    MSG: route_mission_handler/ParkingSpace
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
    
    ================================================================================
    MSG: route_mission_handler/LaneArray
    Lane[] lanes
    
    ================================================================================
    MSG: route_mission_handler/Lane
    int32 NORMAL=0
    int32 SPLIT_LEFT=1
    int32 SPLIT_RIGHT=2
    int32 MERGE_TO_RIGHT=3
    int32 MERGE_TO_LEFT=4
    int32 TOBE_MERGED=5
    int32 SPLIT_STRAIGHT=6
    
    int32 lane_id
    int32[] nroad_ids
    bool is_intersection
    bool is_positive
    Waypoint[] waypoints
    int32[] next_lanes
    int32[] left_lanes
    int32[] right_lanes
    int32 max_speed_limit
    uint32 order
    int32 roadType
    int32 type
    
    ================================================================================
    MSG: route_mission_handler/Waypoint
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
    MSG: route_mission_handler/ParkingLane
    int32 id
    int32 parkingLotId
    ParkingLanePoint[] points
    Waypoints[] waypoints
    
    ================================================================================
    MSG: route_mission_handler/ParkingLanePoint
    int32 laneId
    int32 pointId
    
    ================================================================================
    MSG: route_mission_handler/Waypoints
    int32 laneId
    int32 pointId
    float32 roadWidth
    float32 distToRightLine
    float32 distToLeftLine
    float32 right_road_bound
    float32 left_road_bound
    float32 curve
    float32 slope
    float32 bank_angle
    geometry_msgs/Pose pose
    int32[] markerIds
    int32[] markerTypes
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ParkingLot(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.croad1_positive !== undefined) {
      resolved.croad1_positive = msg.croad1_positive;
    }
    else {
      resolved.croad1_positive = false
    }

    if (msg.croad2_positive !== undefined) {
      resolved.croad2_positive = msg.croad2_positive;
    }
    else {
      resolved.croad2_positive = false
    }

    if (msg.nav_croad_id !== undefined) {
      resolved.nav_croad_id = msg.nav_croad_id;
    }
    else {
      resolved.nav_croad_id = 0
    }

    if (msg.pointId1 !== undefined) {
      resolved.pointId1 = msg.pointId1;
    }
    else {
      resolved.pointId1 = 0
    }

    if (msg.nav_croad_id2 !== undefined) {
      resolved.nav_croad_id2 = msg.nav_croad_id2;
    }
    else {
      resolved.nav_croad_id2 = 0
    }

    if (msg.pointId2 !== undefined) {
      resolved.pointId2 = msg.pointId2;
    }
    else {
      resolved.pointId2 = 0
    }

    if (msg.space_list !== undefined) {
      resolved.space_list = ParkingSpaceArray.Resolve(msg.space_list)
    }
    else {
      resolved.space_list = new ParkingSpaceArray()
    }

    if (msg.lot_lines !== undefined) {
      resolved.lot_lines = LaneArray.Resolve(msg.lot_lines)
    }
    else {
      resolved.lot_lines = new LaneArray()
    }

    if (msg.lanes !== undefined) {
      resolved.lanes = new Array(msg.lanes.length);
      for (let i = 0; i < resolved.lanes.length; ++i) {
        resolved.lanes[i] = ParkingLane.Resolve(msg.lanes[i]);
      }
    }
    else {
      resolved.lanes = []
    }

    if (msg.spaces !== undefined) {
      resolved.spaces = new Array(msg.spaces.length);
      for (let i = 0; i < resolved.spaces.length; ++i) {
        resolved.spaces[i] = ParkingSpace.Resolve(msg.spaces[i]);
      }
    }
    else {
      resolved.spaces = []
    }

    return resolved;
    }
};

module.exports = ParkingLot;
