// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WaypointArray = require('./WaypointArray.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class RRTPlanningResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.valid_request = null;
      this.waypointArrays = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('valid_request')) {
        this.valid_request = initObj.valid_request
      }
      else {
        this.valid_request = false;
      }
      if (initObj.hasOwnProperty('waypointArrays')) {
        this.waypointArrays = initObj.waypointArrays
      }
      else {
        this.waypointArrays = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RRTPlanningResponse
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [valid_request]
    bufferOffset = _serializer.bool(obj.valid_request, buffer, bufferOffset);
    // Serialize message field [waypointArrays]
    // Serialize the length for message field [waypointArrays]
    bufferOffset = _serializer.uint32(obj.waypointArrays.length, buffer, bufferOffset);
    obj.waypointArrays.forEach((val) => {
      bufferOffset = WaypointArray.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RRTPlanningResponse
    let len;
    let data = new RRTPlanningResponse(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [valid_request]
    data.valid_request = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [waypointArrays]
    // Deserialize array length for message field [waypointArrays]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.waypointArrays = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.waypointArrays[i] = WaypointArray.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.waypointArrays.forEach((val) => {
      length += WaypointArray.getMessageSize(val);
    });
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/RRTPlanningResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'da3c34a66d10f37158e4a2e93421a6b1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool valid_request
    WaypointArray[] waypointArrays
    
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
    MSG: itri_msgs/WaypointArray
    Header header
    
    uint8 FORWARD = 0
    uint8 BACKWARD = 1
    uint8 direction
    
    uint8 REGULAR = 0
    uint8 RRT = 1
    uint8 NONE = 2
    uint8 type
    
    Waypoint[] waypoints
    
    uint8 updateId
    float32 prob
    
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RRTPlanningResponse(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.valid_request !== undefined) {
      resolved.valid_request = msg.valid_request;
    }
    else {
      resolved.valid_request = false
    }

    if (msg.waypointArrays !== undefined) {
      resolved.waypointArrays = new Array(msg.waypointArrays.length);
      for (let i = 0; i < resolved.waypointArrays.length; ++i) {
        resolved.waypointArrays[i] = WaypointArray.Resolve(msg.waypointArrays[i]);
      }
    }
    else {
      resolved.waypointArrays = []
    }

    return resolved;
    }
};

module.exports = RRTPlanningResponse;
