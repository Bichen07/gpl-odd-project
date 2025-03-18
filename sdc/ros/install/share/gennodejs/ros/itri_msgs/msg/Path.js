// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Waypoint = require('./Waypoint.js');
let PathSegment = require('./PathSegment.js');
let ParkingInfo = require('./ParkingInfo.js');

//-----------------------------------------------------------

class Path {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoints = null;
      this.segments = null;
      this.distances = null;
      this.directions = null;
      this.isParkingPath = null;
      this.parkingInfo = null;
      this.updateId = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoints')) {
        this.waypoints = initObj.waypoints
      }
      else {
        this.waypoints = [];
      }
      if (initObj.hasOwnProperty('segments')) {
        this.segments = initObj.segments
      }
      else {
        this.segments = [];
      }
      if (initObj.hasOwnProperty('distances')) {
        this.distances = initObj.distances
      }
      else {
        this.distances = [];
      }
      if (initObj.hasOwnProperty('directions')) {
        this.directions = initObj.directions
      }
      else {
        this.directions = [];
      }
      if (initObj.hasOwnProperty('isParkingPath')) {
        this.isParkingPath = initObj.isParkingPath
      }
      else {
        this.isParkingPath = false;
      }
      if (initObj.hasOwnProperty('parkingInfo')) {
        this.parkingInfo = initObj.parkingInfo
      }
      else {
        this.parkingInfo = new ParkingInfo();
      }
      if (initObj.hasOwnProperty('updateId')) {
        this.updateId = initObj.updateId
      }
      else {
        this.updateId = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Path
    // Serialize message field [waypoints]
    // Serialize the length for message field [waypoints]
    bufferOffset = _serializer.uint32(obj.waypoints.length, buffer, bufferOffset);
    obj.waypoints.forEach((val) => {
      bufferOffset = Waypoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [segments]
    // Serialize the length for message field [segments]
    bufferOffset = _serializer.uint32(obj.segments.length, buffer, bufferOffset);
    obj.segments.forEach((val) => {
      bufferOffset = PathSegment.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [distances]
    bufferOffset = _arraySerializer.float64(obj.distances, buffer, bufferOffset, null);
    // Serialize message field [directions]
    bufferOffset = _arraySerializer.uint32(obj.directions, buffer, bufferOffset, null);
    // Serialize message field [isParkingPath]
    bufferOffset = _serializer.bool(obj.isParkingPath, buffer, bufferOffset);
    // Serialize message field [parkingInfo]
    bufferOffset = ParkingInfo.serialize(obj.parkingInfo, buffer, bufferOffset);
    // Serialize message field [updateId]
    bufferOffset = _serializer.uint8(obj.updateId, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Path
    let len;
    let data = new Path(null);
    // Deserialize message field [waypoints]
    // Deserialize array length for message field [waypoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.waypoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.waypoints[i] = Waypoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [segments]
    // Deserialize array length for message field [segments]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.segments = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.segments[i] = PathSegment.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [distances]
    data.distances = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [directions]
    data.directions = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [isParkingPath]
    data.isParkingPath = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [parkingInfo]
    data.parkingInfo = ParkingInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [updateId]
    data.updateId = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.waypoints.forEach((val) => {
      length += Waypoint.getMessageSize(val);
    });
    length += 12 * object.segments.length;
    length += 8 * object.distances.length;
    length += 4 * object.directions.length;
    return length + 26;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Path';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bbb2b65af491134fde46ec00be05096f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Waypoint[] waypoints
    PathSegment[] segments
    float64[] distances
    uint32[] directions
    bool isParkingPath
    ParkingInfo parkingInfo
    uint8 updateId
    
    ================================================================================
    MSG: itri_msgs/Waypoint
    geometry_msgs/PoseStamped pose
    geometry_msgs/TwistStamped twist
    int32 laneId
    int32 pointId
    geometry_msgs/Point point
    float32 heading
    float32 curvature
    float32 speed_limit
    int32 point_id
    int32 lane_id
    int32 nroad_id
    float32 s
    float32 d
    float32 left_space
    float32 right_space
    float32 width
    int32 road_type
    
    ================================================================================
    MSG: geometry_msgs/PoseStamped
    # A Pose with reference coordinate frame and timestamp
    Header header
    Pose pose
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
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
    
    ================================================================================
    MSG: geometry_msgs/TwistStamped
    # A twist with reference coordinate frame and timestamp
    Header header
    Twist twist
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    ================================================================================
    MSG: itri_msgs/PathSegment
    int32 laneId
    int32 startPoint
    int32 endPoint
    ================================================================================
    MSG: itri_msgs/ParkingInfo
    int32 totalParkingPathCount
    int32 currentPathNumber
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Path(null);
    if (msg.waypoints !== undefined) {
      resolved.waypoints = new Array(msg.waypoints.length);
      for (let i = 0; i < resolved.waypoints.length; ++i) {
        resolved.waypoints[i] = Waypoint.Resolve(msg.waypoints[i]);
      }
    }
    else {
      resolved.waypoints = []
    }

    if (msg.segments !== undefined) {
      resolved.segments = new Array(msg.segments.length);
      for (let i = 0; i < resolved.segments.length; ++i) {
        resolved.segments[i] = PathSegment.Resolve(msg.segments[i]);
      }
    }
    else {
      resolved.segments = []
    }

    if (msg.distances !== undefined) {
      resolved.distances = msg.distances;
    }
    else {
      resolved.distances = []
    }

    if (msg.directions !== undefined) {
      resolved.directions = msg.directions;
    }
    else {
      resolved.directions = []
    }

    if (msg.isParkingPath !== undefined) {
      resolved.isParkingPath = msg.isParkingPath;
    }
    else {
      resolved.isParkingPath = false
    }

    if (msg.parkingInfo !== undefined) {
      resolved.parkingInfo = ParkingInfo.Resolve(msg.parkingInfo)
    }
    else {
      resolved.parkingInfo = new ParkingInfo()
    }

    if (msg.updateId !== undefined) {
      resolved.updateId = msg.updateId;
    }
    else {
      resolved.updateId = 0
    }

    return resolved;
    }
};

module.exports = Path;
