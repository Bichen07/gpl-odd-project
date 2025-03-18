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
let StationInfo = require('./StationInfo.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class lane_info {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lane_id = null;
      this.lane_num = null;
      this.lane_width = null;
      this.line_pos = null;
      this.line_type = null;
      this.front_line_dis = null;
      this.on_route_hint = null;
      this.traffic_stop_line = null;
      this.bumper = null;
      this.start_right_turn = null;
      this.end_right_turn = null;
      this.start_left_turn = null;
      this.end_left_turn = null;
      this.front_marker_point = null;
      this.stations = null;
      this.station_msg = null;
      this.remind_distance = null;
      this.remind_time = null;
      this.turn_type = null;
      this.length_to_turn = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lane_id')) {
        this.lane_id = initObj.lane_id
      }
      else {
        this.lane_id = 0;
      }
      if (initObj.hasOwnProperty('lane_num')) {
        this.lane_num = initObj.lane_num
      }
      else {
        this.lane_num = 0;
      }
      if (initObj.hasOwnProperty('lane_width')) {
        this.lane_width = initObj.lane_width
      }
      else {
        this.lane_width = 0.0;
      }
      if (initObj.hasOwnProperty('line_pos')) {
        this.line_pos = initObj.line_pos
      }
      else {
        this.line_pos = [];
      }
      if (initObj.hasOwnProperty('line_type')) {
        this.line_type = initObj.line_type
      }
      else {
        this.line_type = [];
      }
      if (initObj.hasOwnProperty('front_line_dis')) {
        this.front_line_dis = initObj.front_line_dis
      }
      else {
        this.front_line_dis = 0.0;
      }
      if (initObj.hasOwnProperty('on_route_hint')) {
        this.on_route_hint = initObj.on_route_hint
      }
      else {
        this.on_route_hint = [];
      }
      if (initObj.hasOwnProperty('traffic_stop_line')) {
        this.traffic_stop_line = initObj.traffic_stop_line
      }
      else {
        this.traffic_stop_line = [];
      }
      if (initObj.hasOwnProperty('bumper')) {
        this.bumper = initObj.bumper
      }
      else {
        this.bumper = [];
      }
      if (initObj.hasOwnProperty('start_right_turn')) {
        this.start_right_turn = initObj.start_right_turn
      }
      else {
        this.start_right_turn = [];
      }
      if (initObj.hasOwnProperty('end_right_turn')) {
        this.end_right_turn = initObj.end_right_turn
      }
      else {
        this.end_right_turn = [];
      }
      if (initObj.hasOwnProperty('start_left_turn')) {
        this.start_left_turn = initObj.start_left_turn
      }
      else {
        this.start_left_turn = [];
      }
      if (initObj.hasOwnProperty('end_left_turn')) {
        this.end_left_turn = initObj.end_left_turn
      }
      else {
        this.end_left_turn = [];
      }
      if (initObj.hasOwnProperty('front_marker_point')) {
        this.front_marker_point = initObj.front_marker_point
      }
      else {
        this.front_marker_point = new Waypoint();
      }
      if (initObj.hasOwnProperty('stations')) {
        this.stations = initObj.stations
      }
      else {
        this.stations = [];
      }
      if (initObj.hasOwnProperty('station_msg')) {
        this.station_msg = initObj.station_msg
      }
      else {
        this.station_msg = '';
      }
      if (initObj.hasOwnProperty('remind_distance')) {
        this.remind_distance = initObj.remind_distance
      }
      else {
        this.remind_distance = 0.0;
      }
      if (initObj.hasOwnProperty('remind_time')) {
        this.remind_time = initObj.remind_time
      }
      else {
        this.remind_time = 0;
      }
      if (initObj.hasOwnProperty('turn_type')) {
        this.turn_type = initObj.turn_type
      }
      else {
        this.turn_type = 0;
      }
      if (initObj.hasOwnProperty('length_to_turn')) {
        this.length_to_turn = initObj.length_to_turn
      }
      else {
        this.length_to_turn = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lane_info
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lane_id]
    bufferOffset = _serializer.int32(obj.lane_id, buffer, bufferOffset);
    // Serialize message field [lane_num]
    bufferOffset = _serializer.int32(obj.lane_num, buffer, bufferOffset);
    // Serialize message field [lane_width]
    bufferOffset = _serializer.float32(obj.lane_width, buffer, bufferOffset);
    // Serialize message field [line_pos]
    bufferOffset = _arraySerializer.string(obj.line_pos, buffer, bufferOffset, null);
    // Serialize message field [line_type]
    bufferOffset = _arraySerializer.uint32(obj.line_type, buffer, bufferOffset, null);
    // Serialize message field [front_line_dis]
    bufferOffset = _serializer.float64(obj.front_line_dis, buffer, bufferOffset);
    // Serialize message field [on_route_hint]
    bufferOffset = _arraySerializer.bool(obj.on_route_hint, buffer, bufferOffset, null);
    // Serialize message field [traffic_stop_line]
    bufferOffset = _arraySerializer.int32(obj.traffic_stop_line, buffer, bufferOffset, null);
    // Serialize message field [bumper]
    bufferOffset = _arraySerializer.int32(obj.bumper, buffer, bufferOffset, null);
    // Serialize message field [start_right_turn]
    bufferOffset = _arraySerializer.int32(obj.start_right_turn, buffer, bufferOffset, null);
    // Serialize message field [end_right_turn]
    bufferOffset = _arraySerializer.int32(obj.end_right_turn, buffer, bufferOffset, null);
    // Serialize message field [start_left_turn]
    bufferOffset = _arraySerializer.int32(obj.start_left_turn, buffer, bufferOffset, null);
    // Serialize message field [end_left_turn]
    bufferOffset = _arraySerializer.int32(obj.end_left_turn, buffer, bufferOffset, null);
    // Serialize message field [front_marker_point]
    bufferOffset = Waypoint.serialize(obj.front_marker_point, buffer, bufferOffset);
    // Serialize message field [stations]
    // Serialize the length for message field [stations]
    bufferOffset = _serializer.uint32(obj.stations.length, buffer, bufferOffset);
    obj.stations.forEach((val) => {
      bufferOffset = StationInfo.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [station_msg]
    bufferOffset = _serializer.string(obj.station_msg, buffer, bufferOffset);
    // Serialize message field [remind_distance]
    bufferOffset = _serializer.float64(obj.remind_distance, buffer, bufferOffset);
    // Serialize message field [remind_time]
    bufferOffset = _serializer.int32(obj.remind_time, buffer, bufferOffset);
    // Serialize message field [turn_type]
    bufferOffset = _serializer.int32(obj.turn_type, buffer, bufferOffset);
    // Serialize message field [length_to_turn]
    bufferOffset = _serializer.float64(obj.length_to_turn, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lane_info
    let len;
    let data = new lane_info(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lane_id]
    data.lane_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lane_num]
    data.lane_num = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lane_width]
    data.lane_width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [line_pos]
    data.line_pos = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [line_type]
    data.line_type = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [front_line_dis]
    data.front_line_dis = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [on_route_hint]
    data.on_route_hint = _arrayDeserializer.bool(buffer, bufferOffset, null)
    // Deserialize message field [traffic_stop_line]
    data.traffic_stop_line = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [bumper]
    data.bumper = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [start_right_turn]
    data.start_right_turn = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [end_right_turn]
    data.end_right_turn = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [start_left_turn]
    data.start_left_turn = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [end_left_turn]
    data.end_left_turn = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [front_marker_point]
    data.front_marker_point = Waypoint.deserialize(buffer, bufferOffset);
    // Deserialize message field [stations]
    // Deserialize array length for message field [stations]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.stations = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.stations[i] = StationInfo.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [station_msg]
    data.station_msg = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [remind_distance]
    data.remind_distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [remind_time]
    data.remind_time = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [turn_type]
    data.turn_type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [length_to_turn]
    data.length_to_turn = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.line_pos.forEach((val) => {
      length += 4 + val.length;
    });
    length += 4 * object.line_type.length;
    length += object.on_route_hint.length;
    length += 4 * object.traffic_stop_line.length;
    length += 4 * object.bumper.length;
    length += 4 * object.start_right_turn.length;
    length += 4 * object.end_right_turn.length;
    length += 4 * object.start_left_turn.length;
    length += 4 * object.end_left_turn.length;
    length += Waypoint.getMessageSize(object.front_marker_point);
    object.stations.forEach((val) => {
      length += StationInfo.getMessageSize(val);
    });
    length += object.station_msg.length;
    return length + 88;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/lane_info';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '57b78446a83947a2f7f242b41660c9ea';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new lane_info(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lane_id !== undefined) {
      resolved.lane_id = msg.lane_id;
    }
    else {
      resolved.lane_id = 0
    }

    if (msg.lane_num !== undefined) {
      resolved.lane_num = msg.lane_num;
    }
    else {
      resolved.lane_num = 0
    }

    if (msg.lane_width !== undefined) {
      resolved.lane_width = msg.lane_width;
    }
    else {
      resolved.lane_width = 0.0
    }

    if (msg.line_pos !== undefined) {
      resolved.line_pos = msg.line_pos;
    }
    else {
      resolved.line_pos = []
    }

    if (msg.line_type !== undefined) {
      resolved.line_type = msg.line_type;
    }
    else {
      resolved.line_type = []
    }

    if (msg.front_line_dis !== undefined) {
      resolved.front_line_dis = msg.front_line_dis;
    }
    else {
      resolved.front_line_dis = 0.0
    }

    if (msg.on_route_hint !== undefined) {
      resolved.on_route_hint = msg.on_route_hint;
    }
    else {
      resolved.on_route_hint = []
    }

    if (msg.traffic_stop_line !== undefined) {
      resolved.traffic_stop_line = msg.traffic_stop_line;
    }
    else {
      resolved.traffic_stop_line = []
    }

    if (msg.bumper !== undefined) {
      resolved.bumper = msg.bumper;
    }
    else {
      resolved.bumper = []
    }

    if (msg.start_right_turn !== undefined) {
      resolved.start_right_turn = msg.start_right_turn;
    }
    else {
      resolved.start_right_turn = []
    }

    if (msg.end_right_turn !== undefined) {
      resolved.end_right_turn = msg.end_right_turn;
    }
    else {
      resolved.end_right_turn = []
    }

    if (msg.start_left_turn !== undefined) {
      resolved.start_left_turn = msg.start_left_turn;
    }
    else {
      resolved.start_left_turn = []
    }

    if (msg.end_left_turn !== undefined) {
      resolved.end_left_turn = msg.end_left_turn;
    }
    else {
      resolved.end_left_turn = []
    }

    if (msg.front_marker_point !== undefined) {
      resolved.front_marker_point = Waypoint.Resolve(msg.front_marker_point)
    }
    else {
      resolved.front_marker_point = new Waypoint()
    }

    if (msg.stations !== undefined) {
      resolved.stations = new Array(msg.stations.length);
      for (let i = 0; i < resolved.stations.length; ++i) {
        resolved.stations[i] = StationInfo.Resolve(msg.stations[i]);
      }
    }
    else {
      resolved.stations = []
    }

    if (msg.station_msg !== undefined) {
      resolved.station_msg = msg.station_msg;
    }
    else {
      resolved.station_msg = ''
    }

    if (msg.remind_distance !== undefined) {
      resolved.remind_distance = msg.remind_distance;
    }
    else {
      resolved.remind_distance = 0.0
    }

    if (msg.remind_time !== undefined) {
      resolved.remind_time = msg.remind_time;
    }
    else {
      resolved.remind_time = 0
    }

    if (msg.turn_type !== undefined) {
      resolved.turn_type = msg.turn_type;
    }
    else {
      resolved.turn_type = 0
    }

    if (msg.length_to_turn !== undefined) {
      resolved.length_to_turn = msg.length_to_turn;
    }
    else {
      resolved.length_to_turn = 0.0
    }

    return resolved;
    }
};

module.exports = lane_info;
