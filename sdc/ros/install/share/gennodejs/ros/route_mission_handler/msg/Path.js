// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Croad = require('./Croad.js');
let Lane = require('./Lane.js');
let ParkingLot = require('./ParkingLot.js');

//-----------------------------------------------------------

class Path {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.nroads = null;
      this.lanes = null;
      this.opposite_lanes = null;
      this.parkinglots = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('nroads')) {
        this.nroads = initObj.nroads
      }
      else {
        this.nroads = [];
      }
      if (initObj.hasOwnProperty('lanes')) {
        this.lanes = initObj.lanes
      }
      else {
        this.lanes = [];
      }
      if (initObj.hasOwnProperty('opposite_lanes')) {
        this.opposite_lanes = initObj.opposite_lanes
      }
      else {
        this.opposite_lanes = [];
      }
      if (initObj.hasOwnProperty('parkinglots')) {
        this.parkinglots = initObj.parkinglots
      }
      else {
        this.parkinglots = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Path
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [nroads]
    // Serialize the length for message field [nroads]
    bufferOffset = _serializer.uint32(obj.nroads.length, buffer, bufferOffset);
    obj.nroads.forEach((val) => {
      bufferOffset = Croad.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [lanes]
    // Serialize the length for message field [lanes]
    bufferOffset = _serializer.uint32(obj.lanes.length, buffer, bufferOffset);
    obj.lanes.forEach((val) => {
      bufferOffset = Lane.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [opposite_lanes]
    // Serialize the length for message field [opposite_lanes]
    bufferOffset = _serializer.uint32(obj.opposite_lanes.length, buffer, bufferOffset);
    obj.opposite_lanes.forEach((val) => {
      bufferOffset = Lane.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [parkinglots]
    // Serialize the length for message field [parkinglots]
    bufferOffset = _serializer.uint32(obj.parkinglots.length, buffer, bufferOffset);
    obj.parkinglots.forEach((val) => {
      bufferOffset = ParkingLot.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Path
    let len;
    let data = new Path(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [nroads]
    // Deserialize array length for message field [nroads]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.nroads = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.nroads[i] = Croad.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [lanes]
    // Deserialize array length for message field [lanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lanes[i] = Lane.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [opposite_lanes]
    // Deserialize array length for message field [opposite_lanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.opposite_lanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.opposite_lanes[i] = Lane.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [parkinglots]
    // Deserialize array length for message field [parkinglots]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.parkinglots = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.parkinglots[i] = ParkingLot.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    object.nroads.forEach((val) => {
      length += Croad.getMessageSize(val);
    });
    object.lanes.forEach((val) => {
      length += Lane.getMessageSize(val);
    });
    object.opposite_lanes.forEach((val) => {
      length += Lane.getMessageSize(val);
    });
    object.parkinglots.forEach((val) => {
      length += ParkingLot.getMessageSize(val);
    });
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Path';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a3e40f12496a914a19bbb6f3f00e47a0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    Croad[] nroads
    Lane[] lanes
    Lane[] opposite_lanes
    ParkingLot[] parkinglots
    
    ================================================================================
    MSG: route_mission_handler/Croad
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
    MSG: route_mission_handler/ParkingLot
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
    MSG: route_mission_handler/LaneArray
    Lane[] lanes
    
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
    const resolved = new Path(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.nroads !== undefined) {
      resolved.nroads = new Array(msg.nroads.length);
      for (let i = 0; i < resolved.nroads.length; ++i) {
        resolved.nroads[i] = Croad.Resolve(msg.nroads[i]);
      }
    }
    else {
      resolved.nroads = []
    }

    if (msg.lanes !== undefined) {
      resolved.lanes = new Array(msg.lanes.length);
      for (let i = 0; i < resolved.lanes.length; ++i) {
        resolved.lanes[i] = Lane.Resolve(msg.lanes[i]);
      }
    }
    else {
      resolved.lanes = []
    }

    if (msg.opposite_lanes !== undefined) {
      resolved.opposite_lanes = new Array(msg.opposite_lanes.length);
      for (let i = 0; i < resolved.opposite_lanes.length; ++i) {
        resolved.opposite_lanes[i] = Lane.Resolve(msg.opposite_lanes[i]);
      }
    }
    else {
      resolved.opposite_lanes = []
    }

    if (msg.parkinglots !== undefined) {
      resolved.parkinglots = new Array(msg.parkinglots.length);
      for (let i = 0; i < resolved.parkinglots.length; ++i) {
        resolved.parkinglots[i] = ParkingLot.Resolve(msg.parkinglots[i]);
      }
    }
    else {
      resolved.parkinglots = []
    }

    return resolved;
    }
};

module.exports = Path;
