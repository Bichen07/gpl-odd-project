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

class EsrObj {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.trackId = null;
      this.status = null;
      this.medRangeMode = null;
      this.pose = null;
      this.twist = null;
      this.oncoming = null;
      this.isBridge = null;
      this.groupingChanged = null;
      this.width = null;
      this.rangeAccel = null;
    }
    else {
      if (initObj.hasOwnProperty('trackId')) {
        this.trackId = initObj.trackId
      }
      else {
        this.trackId = 0;
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('medRangeMode')) {
        this.medRangeMode = initObj.medRangeMode
      }
      else {
        this.medRangeMode = 0;
      }
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
      if (initObj.hasOwnProperty('oncoming')) {
        this.oncoming = initObj.oncoming
      }
      else {
        this.oncoming = false;
      }
      if (initObj.hasOwnProperty('isBridge')) {
        this.isBridge = initObj.isBridge
      }
      else {
        this.isBridge = false;
      }
      if (initObj.hasOwnProperty('groupingChanged')) {
        this.groupingChanged = initObj.groupingChanged
      }
      else {
        this.groupingChanged = false;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
      if (initObj.hasOwnProperty('rangeAccel')) {
        this.rangeAccel = initObj.rangeAccel
      }
      else {
        this.rangeAccel = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsrObj
    // Serialize message field [trackId]
    bufferOffset = _serializer.uint8(obj.trackId, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    // Serialize message field [medRangeMode]
    bufferOffset = _serializer.uint8(obj.medRangeMode, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.PoseStamped.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [twist]
    bufferOffset = geometry_msgs.msg.TwistStamped.serialize(obj.twist, buffer, bufferOffset);
    // Serialize message field [oncoming]
    bufferOffset = _serializer.bool(obj.oncoming, buffer, bufferOffset);
    // Serialize message field [isBridge]
    bufferOffset = _serializer.bool(obj.isBridge, buffer, bufferOffset);
    // Serialize message field [groupingChanged]
    bufferOffset = _serializer.bool(obj.groupingChanged, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float32(obj.width, buffer, bufferOffset);
    // Serialize message field [rangeAccel]
    bufferOffset = _serializer.float32(obj.rangeAccel, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsrObj
    let len;
    let data = new EsrObj(null);
    // Deserialize message field [trackId]
    data.trackId = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [medRangeMode]
    data.medRangeMode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.PoseStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [twist]
    data.twist = geometry_msgs.msg.TwistStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [oncoming]
    data.oncoming = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [isBridge]
    data.isBridge = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [groupingChanged]
    data.groupingChanged = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rangeAccel]
    data.rangeAccel = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseStamped.getMessageSize(object.pose);
    length += geometry_msgs.msg.TwistStamped.getMessageSize(object.twist);
    return length + 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/EsrObj';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '42716c128968ac8bfa26684b875a1ee1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new EsrObj(null);
    if (msg.trackId !== undefined) {
      resolved.trackId = msg.trackId;
    }
    else {
      resolved.trackId = 0
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.medRangeMode !== undefined) {
      resolved.medRangeMode = msg.medRangeMode;
    }
    else {
      resolved.medRangeMode = 0
    }

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

    if (msg.oncoming !== undefined) {
      resolved.oncoming = msg.oncoming;
    }
    else {
      resolved.oncoming = false
    }

    if (msg.isBridge !== undefined) {
      resolved.isBridge = msg.isBridge;
    }
    else {
      resolved.isBridge = false
    }

    if (msg.groupingChanged !== undefined) {
      resolved.groupingChanged = msg.groupingChanged;
    }
    else {
      resolved.groupingChanged = false
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    if (msg.rangeAccel !== undefined) {
      resolved.rangeAccel = msg.rangeAccel;
    }
    else {
      resolved.rangeAccel = 0.0
    }

    return resolved;
    }
};

module.exports = EsrObj;
