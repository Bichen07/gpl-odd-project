// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ParkingLot = require('./ParkingLot.js');

//-----------------------------------------------------------

class ParkingLotArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lots = null;
    }
    else {
      if (initObj.hasOwnProperty('lots')) {
        this.lots = initObj.lots
      }
      else {
        this.lots = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParkingLotArray
    // Serialize message field [lots]
    // Serialize the length for message field [lots]
    bufferOffset = _serializer.uint32(obj.lots.length, buffer, bufferOffset);
    obj.lots.forEach((val) => {
      bufferOffset = ParkingLot.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParkingLotArray
    let len;
    let data = new ParkingLotArray(null);
    // Deserialize message field [lots]
    // Deserialize array length for message field [lots]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lots = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lots[i] = ParkingLot.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.lots.forEach((val) => {
      length += ParkingLot.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/ParkingLotArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4c437145053afac28f11d22149a5aaf7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ParkingLot[] lots
    
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
    const resolved = new ParkingLotArray(null);
    if (msg.lots !== undefined) {
      resolved.lots = new Array(msg.lots.length);
      for (let i = 0; i < resolved.lots.length; ++i) {
        resolved.lots[i] = ParkingLot.Resolve(msg.lots[i]);
      }
    }
    else {
      resolved.lots = []
    }

    return resolved;
    }
};

module.exports = ParkingLotArray;
