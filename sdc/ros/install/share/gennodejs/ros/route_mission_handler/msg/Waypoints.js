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

class Waypoints {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.laneId = null;
      this.pointId = null;
      this.roadWidth = null;
      this.distToRightLine = null;
      this.distToLeftLine = null;
      this.right_road_bound = null;
      this.left_road_bound = null;
      this.curve = null;
      this.slope = null;
      this.bank_angle = null;
      this.pose = null;
      this.markerIds = null;
      this.markerTypes = null;
    }
    else {
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
      if (initObj.hasOwnProperty('curve')) {
        this.curve = initObj.curve
      }
      else {
        this.curve = 0.0;
      }
      if (initObj.hasOwnProperty('slope')) {
        this.slope = initObj.slope
      }
      else {
        this.slope = 0.0;
      }
      if (initObj.hasOwnProperty('bank_angle')) {
        this.bank_angle = initObj.bank_angle
      }
      else {
        this.bank_angle = 0.0;
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Waypoints
    // Serialize message field [laneId]
    bufferOffset = _serializer.int32(obj.laneId, buffer, bufferOffset);
    // Serialize message field [pointId]
    bufferOffset = _serializer.int32(obj.pointId, buffer, bufferOffset);
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
    // Serialize message field [curve]
    bufferOffset = _serializer.float32(obj.curve, buffer, bufferOffset);
    // Serialize message field [slope]
    bufferOffset = _serializer.float32(obj.slope, buffer, bufferOffset);
    // Serialize message field [bank_angle]
    bufferOffset = _serializer.float32(obj.bank_angle, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [markerIds]
    bufferOffset = _arraySerializer.int32(obj.markerIds, buffer, bufferOffset, null);
    // Serialize message field [markerTypes]
    bufferOffset = _arraySerializer.int32(obj.markerTypes, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Waypoints
    let len;
    let data = new Waypoints(null);
    // Deserialize message field [laneId]
    data.laneId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointId]
    data.pointId = _deserializer.int32(buffer, bufferOffset);
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
    // Deserialize message field [curve]
    data.curve = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [slope]
    data.slope = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [bank_angle]
    data.bank_angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [markerIds]
    data.markerIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [markerTypes]
    data.markerTypes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.markerIds.length;
    length += 4 * object.markerTypes.length;
    return length + 104;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/Waypoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2b80f75c6328a6dc05af65a457e56008';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
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
    const resolved = new Waypoints(null);
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

    if (msg.curve !== undefined) {
      resolved.curve = msg.curve;
    }
    else {
      resolved.curve = 0.0
    }

    if (msg.slope !== undefined) {
      resolved.slope = msg.slope;
    }
    else {
      resolved.slope = 0.0
    }

    if (msg.bank_angle !== undefined) {
      resolved.bank_angle = msg.bank_angle;
    }
    else {
      resolved.bank_angle = 0.0
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
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

    return resolved;
    }
};

module.exports = Waypoints;
