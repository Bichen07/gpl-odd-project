// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


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
      this.pose = null;
      this.twist = null;
      this.laneId = null;
      this.pointId = null;
      this.point = null;
      this.heading = null;
      this.curvature = null;
      this.speed_limit = null;
      this.point_id = null;
      this.lane_id = null;
      this.nroad_id = null;
      this.s = null;
      this.d = null;
      this.left_space = null;
      this.right_space = null;
      this.width = null;
      this.road_type = null;
    }
    else {
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.PoseStamped();
      }
      if (initObj.hasOwnProperty('twist')) {
        this.twist = initObj.twist
      }
      else {
        this.twist = new geometry_msgs.msg.TwistStamped();
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
      if (initObj.hasOwnProperty('point')) {
        this.point = initObj.point
      }
      else {
        this.point = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('heading')) {
        this.heading = initObj.heading
      }
      else {
        this.heading = 0.0;
      }
      if (initObj.hasOwnProperty('curvature')) {
        this.curvature = initObj.curvature
      }
      else {
        this.curvature = 0.0;
      }
      if (initObj.hasOwnProperty('speed_limit')) {
        this.speed_limit = initObj.speed_limit
      }
      else {
        this.speed_limit = 0.0;
      }
      if (initObj.hasOwnProperty('point_id')) {
        this.point_id = initObj.point_id
      }
      else {
        this.point_id = 0;
      }
      if (initObj.hasOwnProperty('lane_id')) {
        this.lane_id = initObj.lane_id
      }
      else {
        this.lane_id = 0;
      }
      if (initObj.hasOwnProperty('nroad_id')) {
        this.nroad_id = initObj.nroad_id
      }
      else {
        this.nroad_id = 0;
      }
      if (initObj.hasOwnProperty('s')) {
        this.s = initObj.s
      }
      else {
        this.s = 0.0;
      }
      if (initObj.hasOwnProperty('d')) {
        this.d = initObj.d
      }
      else {
        this.d = 0.0;
      }
      if (initObj.hasOwnProperty('left_space')) {
        this.left_space = initObj.left_space
      }
      else {
        this.left_space = 0.0;
      }
      if (initObj.hasOwnProperty('right_space')) {
        this.right_space = initObj.right_space
      }
      else {
        this.right_space = 0.0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
      if (initObj.hasOwnProperty('road_type')) {
        this.road_type = initObj.road_type
      }
      else {
        this.road_type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Waypoint
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.PoseStamped.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [twist]
    bufferOffset = geometry_msgs.msg.TwistStamped.serialize(obj.twist, buffer, bufferOffset);
    // Serialize message field [laneId]
    bufferOffset = _serializer.int32(obj.laneId, buffer, bufferOffset);
    // Serialize message field [pointId]
    bufferOffset = _serializer.int32(obj.pointId, buffer, bufferOffset);
    // Serialize message field [point]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.point, buffer, bufferOffset);
    // Serialize message field [heading]
    bufferOffset = _serializer.float32(obj.heading, buffer, bufferOffset);
    // Serialize message field [curvature]
    bufferOffset = _serializer.float32(obj.curvature, buffer, bufferOffset);
    // Serialize message field [speed_limit]
    bufferOffset = _serializer.float32(obj.speed_limit, buffer, bufferOffset);
    // Serialize message field [point_id]
    bufferOffset = _serializer.int32(obj.point_id, buffer, bufferOffset);
    // Serialize message field [lane_id]
    bufferOffset = _serializer.int32(obj.lane_id, buffer, bufferOffset);
    // Serialize message field [nroad_id]
    bufferOffset = _serializer.int32(obj.nroad_id, buffer, bufferOffset);
    // Serialize message field [s]
    bufferOffset = _serializer.float32(obj.s, buffer, bufferOffset);
    // Serialize message field [d]
    bufferOffset = _serializer.float32(obj.d, buffer, bufferOffset);
    // Serialize message field [left_space]
    bufferOffset = _serializer.float32(obj.left_space, buffer, bufferOffset);
    // Serialize message field [right_space]
    bufferOffset = _serializer.float32(obj.right_space, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float32(obj.width, buffer, bufferOffset);
    // Serialize message field [road_type]
    bufferOffset = _serializer.int32(obj.road_type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Waypoint
    let len;
    let data = new Waypoint(null);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.PoseStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [twist]
    data.twist = geometry_msgs.msg.TwistStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [laneId]
    data.laneId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pointId]
    data.pointId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [point]
    data.point = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [heading]
    data.heading = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [curvature]
    data.curvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed_limit]
    data.speed_limit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [point_id]
    data.point_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lane_id]
    data.lane_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nroad_id]
    data.nroad_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [s]
    data.s = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [d]
    data.d = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [left_space]
    data.left_space = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [right_space]
    data.right_space = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [road_type]
    data.road_type = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseStamped.getMessageSize(object.pose);
    length += geometry_msgs.msg.TwistStamped.getMessageSize(object.twist);
    return length + 80;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Waypoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6a22ab0ae1bcbcabcacf956439f4fd96';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Waypoint(null);
    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.PoseStamped.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.PoseStamped()
    }

    if (msg.twist !== undefined) {
      resolved.twist = geometry_msgs.msg.TwistStamped.Resolve(msg.twist)
    }
    else {
      resolved.twist = new geometry_msgs.msg.TwistStamped()
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

    if (msg.point !== undefined) {
      resolved.point = geometry_msgs.msg.Point.Resolve(msg.point)
    }
    else {
      resolved.point = new geometry_msgs.msg.Point()
    }

    if (msg.heading !== undefined) {
      resolved.heading = msg.heading;
    }
    else {
      resolved.heading = 0.0
    }

    if (msg.curvature !== undefined) {
      resolved.curvature = msg.curvature;
    }
    else {
      resolved.curvature = 0.0
    }

    if (msg.speed_limit !== undefined) {
      resolved.speed_limit = msg.speed_limit;
    }
    else {
      resolved.speed_limit = 0.0
    }

    if (msg.point_id !== undefined) {
      resolved.point_id = msg.point_id;
    }
    else {
      resolved.point_id = 0
    }

    if (msg.lane_id !== undefined) {
      resolved.lane_id = msg.lane_id;
    }
    else {
      resolved.lane_id = 0
    }

    if (msg.nroad_id !== undefined) {
      resolved.nroad_id = msg.nroad_id;
    }
    else {
      resolved.nroad_id = 0
    }

    if (msg.s !== undefined) {
      resolved.s = msg.s;
    }
    else {
      resolved.s = 0.0
    }

    if (msg.d !== undefined) {
      resolved.d = msg.d;
    }
    else {
      resolved.d = 0.0
    }

    if (msg.left_space !== undefined) {
      resolved.left_space = msg.left_space;
    }
    else {
      resolved.left_space = 0.0
    }

    if (msg.right_space !== undefined) {
      resolved.right_space = msg.right_space;
    }
    else {
      resolved.right_space = 0.0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    if (msg.road_type !== undefined) {
      resolved.road_type = msg.road_type;
    }
    else {
      resolved.road_type = 0
    }

    return resolved;
    }
};

module.exports = Waypoint;
