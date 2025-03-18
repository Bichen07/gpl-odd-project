// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Ars40xObject = require('./Ars40xObject.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Ars40xObjects {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.objs = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('objs')) {
        this.objs = initObj.objs
      }
      else {
        this.objs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ars40xObjects
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [objs]
    // Serialize the length for message field [objs]
    bufferOffset = _serializer.uint32(obj.objs.length, buffer, bufferOffset);
    obj.objs.forEach((val) => {
      bufferOffset = Ars40xObject.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ars40xObjects
    let len;
    let data = new Ars40xObjects(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [objs]
    // Deserialize array length for message field [objs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.objs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.objs[i] = Ars40xObject.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 172 * object.objs.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Ars40xObjects';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4164e9c06a4bd1d54578ef1b78fe9ad7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    Ars40xObject[] objs
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
    MSG: itri_msgs/Ars40xObject
    # while persists in consecutive messages - it is the same object, if disappears and appears again - new one
    uint8 id
    
    float32 width
    float32 length
    
    geometry_msgs/Pose pose
    geometry_msgs/Twist velocity
    geometry_msgs/Accel acceleration
    
    # dBm^2
    float32 radar_cross_section
    
    uint8 POINT = 0
    uint8 CAR = 1
    uint8 TRUCK = 2
    uint8 MOTORCYCLE = 4
    uint8 BICYCLE = 5
    uint8 WIDE = 6
    uint8 Class
    
    uint8 MOVING = 0
    uint8 STATIONARY = 1
    uint8 ONCOMING = 2
    uint8 STATIONARY_CANDIDATE = 3
    uint8 UNKNOWN = 4
    uint8 CROSSING_STATIONARY = 5
    uint8 CROSSING_MOVING = 6
    uint8 STOPPED = 7
    uint8 dynamic
    
    uint8 DELETED = 0
    uint8 NEW_CREATED = 1
    uint8 MEASURED = 2
    uint8 PREDICTED = 3
    uint8 DELETED_FOR_MERGE = 4
    uint8 NEW_FROM_MERGE = 5
    uint8 measurment
    
    # probability of existence, percentage
    float32 probability
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
    MSG: geometry_msgs/Accel
    # This expresses acceleration in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Ars40xObjects(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.objs !== undefined) {
      resolved.objs = new Array(msg.objs.length);
      for (let i = 0; i < resolved.objs.length; ++i) {
        resolved.objs[i] = Ars40xObject.Resolve(msg.objs[i]);
      }
    }
    else {
      resolved.objs = []
    }

    return resolved;
    }
};

module.exports = Ars40xObjects;
