// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let CarState = require('./CarState.js');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class RRTRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.wait_time = null;
      this.start = null;
      this.end = null;
      this.parking_space = null;
      this.set_radius = null;
      this.radius = null;
      this.directional = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('wait_time')) {
        this.wait_time = initObj.wait_time
      }
      else {
        this.wait_time = 0.0;
      }
      if (initObj.hasOwnProperty('start')) {
        this.start = initObj.start
      }
      else {
        this.start = new CarState();
      }
      if (initObj.hasOwnProperty('end')) {
        this.end = initObj.end
      }
      else {
        this.end = new CarState();
      }
      if (initObj.hasOwnProperty('parking_space')) {
        this.parking_space = initObj.parking_space
      }
      else {
        this.parking_space = [];
      }
      if (initObj.hasOwnProperty('set_radius')) {
        this.set_radius = initObj.set_radius
      }
      else {
        this.set_radius = false;
      }
      if (initObj.hasOwnProperty('radius')) {
        this.radius = initObj.radius
      }
      else {
        this.radius = 0.0;
      }
      if (initObj.hasOwnProperty('directional')) {
        this.directional = initObj.directional
      }
      else {
        this.directional = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RRTRequest
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [wait_time]
    bufferOffset = _serializer.float32(obj.wait_time, buffer, bufferOffset);
    // Serialize message field [start]
    bufferOffset = CarState.serialize(obj.start, buffer, bufferOffset);
    // Serialize message field [end]
    bufferOffset = CarState.serialize(obj.end, buffer, bufferOffset);
    // Serialize message field [parking_space]
    // Serialize the length for message field [parking_space]
    bufferOffset = _serializer.uint32(obj.parking_space.length, buffer, bufferOffset);
    obj.parking_space.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [set_radius]
    bufferOffset = _serializer.bool(obj.set_radius, buffer, bufferOffset);
    // Serialize message field [radius]
    bufferOffset = _serializer.float32(obj.radius, buffer, bufferOffset);
    // Serialize message field [directional]
    bufferOffset = _serializer.uint8(obj.directional, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RRTRequest
    let len;
    let data = new RRTRequest(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [wait_time]
    data.wait_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [start]
    data.start = CarState.deserialize(buffer, bufferOffset);
    // Deserialize message field [end]
    data.end = CarState.deserialize(buffer, bufferOffset);
    // Deserialize message field [parking_space]
    // Deserialize array length for message field [parking_space]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.parking_space = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.parking_space[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [set_radius]
    data.set_radius = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [radius]
    data.radius = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [directional]
    data.directional = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += CarState.getMessageSize(object.start);
    length += CarState.getMessageSize(object.end);
    length += 24 * object.parking_space.length;
    return length + 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/RRTRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '45ab4e6a1f02be793e6ab32ee1973a5e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 wait_time
    CarState start
    CarState end
    geometry_msgs/Point[] parking_space
    bool set_radius
    float32 radius
    
    uint8 ENTER = 0
    uint8 LEAVE = 1
    uint8 directional
    
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
    MSG: itri_msgs/CarState
    Header header
    geometry_msgs/PoseStamped pose
    geometry_msgs/TwistStamped twist
    bool is_stable
    
    uint8 RANDOM = 0
    uint8 DIRECTIONAL = 1
    uint8 REVERSE_DIRECTIONAL = 2
    uint8 sampler_type
    
    float32 acceleration
    float32 jerk
    
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
    const resolved = new RRTRequest(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.wait_time !== undefined) {
      resolved.wait_time = msg.wait_time;
    }
    else {
      resolved.wait_time = 0.0
    }

    if (msg.start !== undefined) {
      resolved.start = CarState.Resolve(msg.start)
    }
    else {
      resolved.start = new CarState()
    }

    if (msg.end !== undefined) {
      resolved.end = CarState.Resolve(msg.end)
    }
    else {
      resolved.end = new CarState()
    }

    if (msg.parking_space !== undefined) {
      resolved.parking_space = new Array(msg.parking_space.length);
      for (let i = 0; i < resolved.parking_space.length; ++i) {
        resolved.parking_space[i] = geometry_msgs.msg.Point.Resolve(msg.parking_space[i]);
      }
    }
    else {
      resolved.parking_space = []
    }

    if (msg.set_radius !== undefined) {
      resolved.set_radius = msg.set_radius;
    }
    else {
      resolved.set_radius = false
    }

    if (msg.radius !== undefined) {
      resolved.radius = msg.radius;
    }
    else {
      resolved.radius = 0.0
    }

    if (msg.directional !== undefined) {
      resolved.directional = msg.directional;
    }
    else {
      resolved.directional = 0
    }

    return resolved;
    }
};

// Constants for message
RRTRequest.Constants = {
  ENTER: 0,
  LEAVE: 1,
}

module.exports = RRTRequest;
