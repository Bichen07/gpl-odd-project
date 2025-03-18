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
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Gnss {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.pose = null;
      this.gps_state = null;
      this.heading_info = null;
      this.gpgga_is_exit = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('gps_state')) {
        this.gps_state = initObj.gps_state
      }
      else {
        this.gps_state = 0;
      }
      if (initObj.hasOwnProperty('heading_info')) {
        this.heading_info = initObj.heading_info
      }
      else {
        this.heading_info = false;
      }
      if (initObj.hasOwnProperty('gpgga_is_exit')) {
        this.gpgga_is_exit = initObj.gpgga_is_exit
      }
      else {
        this.gpgga_is_exit = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Gnss
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [gps_state]
    bufferOffset = _serializer.uint8(obj.gps_state, buffer, bufferOffset);
    // Serialize message field [heading_info]
    bufferOffset = _serializer.bool(obj.heading_info, buffer, bufferOffset);
    // Serialize message field [gpgga_is_exit]
    bufferOffset = _serializer.bool(obj.gpgga_is_exit, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Gnss
    let len;
    let data = new Gnss(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [gps_state]
    data.gps_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [heading_info]
    data.heading_info = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpgga_is_exit]
    data.gpgga_is_exit = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 59;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Gnss';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '61f647323695d7fb42c71d38c42a68c5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 INVALID=0
    uint8 GPS=1
    uint8 DGPS=2
    uint8 RTK_FIXED=4
    uint8 RTK_FLOAT=5
    
    Header header
    geometry_msgs/Pose pose
    uint8 gps_state
    bool heading_info
    bool gpgga_is_exit
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Gnss(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.gps_state !== undefined) {
      resolved.gps_state = msg.gps_state;
    }
    else {
      resolved.gps_state = 0
    }

    if (msg.heading_info !== undefined) {
      resolved.heading_info = msg.heading_info;
    }
    else {
      resolved.heading_info = false
    }

    if (msg.gpgga_is_exit !== undefined) {
      resolved.gpgga_is_exit = msg.gpgga_is_exit;
    }
    else {
      resolved.gpgga_is_exit = false
    }

    return resolved;
    }
};

// Constants for message
Gnss.Constants = {
  INVALID: 0,
  GPS: 1,
  DGPS: 2,
  RTK_FIXED: 4,
  RTK_FLOAT: 5,
}

module.exports = Gnss;
