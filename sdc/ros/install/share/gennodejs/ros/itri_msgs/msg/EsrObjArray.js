// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let EsrObj = require('./EsrObj.js');
let EsrMotionPower = require('./EsrMotionPower.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class EsrObjArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.objs = null;
      this.motion = null;
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
      if (initObj.hasOwnProperty('motion')) {
        this.motion = initObj.motion
      }
      else {
        this.motion = new Array(64).fill(new EsrMotionPower());
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsrObjArray
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [objs]
    // Serialize the length for message field [objs]
    bufferOffset = _serializer.uint32(obj.objs.length, buffer, bufferOffset);
    obj.objs.forEach((val) => {
      bufferOffset = EsrObj.serialize(val, buffer, bufferOffset);
    });
    // Check that the constant length array field [motion] has the right length
    if (obj.motion.length !== 64) {
      throw new Error('Unable to serialize array field motion - length must be 64')
    }
    // Serialize message field [motion]
    obj.motion.forEach((val) => {
      bufferOffset = EsrMotionPower.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsrObjArray
    let len;
    let data = new EsrObjArray(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [objs]
    // Deserialize array length for message field [objs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.objs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.objs[i] = EsrObj.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [motion]
    len = 64;
    data.motion = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.motion[i] = EsrMotionPower.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.objs.forEach((val) => {
      length += EsrObj.getMessageSize(val);
    });
    return length + 324;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/EsrObjArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9e3f4db5a2b7e811d4b4df0dff33e220';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    EsrObj[] objs
    EsrMotionPower[64] motion
    
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
    MSG: itri_msgs/EsrObj
    uint8 trackId
    uint8 status
    uint8 medRangeMode
    geometry_msgs/PoseStamped pose
    geometry_msgs/TwistStamped twist
    bool oncoming
    bool isBridge
    bool groupingChanged
    float32 width
    float32 rangeAccel
    
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
    MSG: itri_msgs/EsrMotionPower
    bool track_moving
    bool track_movable_fast
    bool track_movable_slow
    int16 track_power
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EsrObjArray(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.objs !== undefined) {
      resolved.objs = new Array(msg.objs.length);
      for (let i = 0; i < resolved.objs.length; ++i) {
        resolved.objs[i] = EsrObj.Resolve(msg.objs[i]);
      }
    }
    else {
      resolved.objs = []
    }

    if (msg.motion !== undefined) {
      resolved.motion = new Array(64)
      for (let i = 0; i < resolved.motion.length; ++i) {
        if (msg.motion.length > i) {
          resolved.motion[i] = EsrMotionPower.Resolve(msg.motion[i]);
        }
        else {
          resolved.motion[i] = new EsrMotionPower();
        }
      }
    }
    else {
      resolved.motion = new Array(64).fill(new EsrMotionPower())
    }

    return resolved;
    }
};

module.exports = EsrObjArray;
