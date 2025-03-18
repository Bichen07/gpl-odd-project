// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let lane_info = require('./lane_info.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class lane_waypoints_info {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.point = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('point')) {
        this.point = initObj.point
      }
      else {
        this.point = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lane_waypoints_info
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [point]
    // Serialize the length for message field [point]
    bufferOffset = _serializer.uint32(obj.point.length, buffer, bufferOffset);
    obj.point.forEach((val) => {
      bufferOffset = lane_info.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lane_waypoints_info
    let len;
    let data = new lane_waypoints_info(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [point]
    // Deserialize array length for message field [point]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.point = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.point[i] = lane_info.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.point.forEach((val) => {
      length += lane_info.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/lane_waypoints_info';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '01267141f4f69eaeb661c3d3af07f166';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    lane_info[] point
    
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
    MSG: itri_msgs/lane_info
    Header header
    int32 lane_id   #current lane
    int32 lane_num  #total number of lane
    float32 lane_width
    
    string[] line_pos
    
    # Right = 'R'
    # Left  = 'L'
    # Front = 'F'
    
    uint32[] line_type
    
    # EMPTY = 0
    # WHITE_DASHED_LINE = 1
    # WHITE_SOLID_LINE = 2
    # WHITE_DOUBLE_LINE = 3
    # YELLOW_DASHED_LINE
    # YELLOW_SOLID_LINE
    # YELLOW_DOUBLE_LINE
    # RED_SOLID_LINE
    # STRAIGHT_ARROW
    # TURN_LEFT_ARROW
    # TURN_RIGHT_ARROW
    # STRAIGHT_OR_RIGHT_ARROW
    # STRAIGHT_OR_LEFT_ARROW
    # TURN_RIGHT_ONLY
    # STOP_LINE
    # LONGER_BUMP
    # SHORTER_BUMP
    # SLOWDOWN
    # YIELD
    # STOP_SIGN
    # SPEED_LIMIT_20KPH
    # SPEED_LIMIT_30KPH
    # SPEED_LIMIT_50KPH
    # SCOOTER_PARKING_PLACE
    # PARKING_SPACE
    
    float64 front_line_dis
    
    bool[] on_route_hint
    int32[] traffic_stop_line
    int32[] bumper
    int32[] start_right_turn
    int32[] end_right_turn
    int32[] start_left_turn
    int32[] end_left_turn
    
    Waypoint front_marker_point
    
    StationInfo[] stations
    string station_msg
    
    float64 remind_distance
    int32 remind_time
    
    int32 turn_type
    float64 length_to_turn
    
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
    MSG: itri_msgs/StationInfo
    string name
    bool isPass
    Waypoint location
    int32 nearPointIndex
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lane_waypoints_info(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.point !== undefined) {
      resolved.point = new Array(msg.point.length);
      for (let i = 0; i < resolved.point.length; ++i) {
        resolved.point[i] = lane_info.Resolve(msg.point[i]);
      }
    }
    else {
      resolved.point = []
    }

    return resolved;
    }
};

module.exports = lane_waypoints_info;
