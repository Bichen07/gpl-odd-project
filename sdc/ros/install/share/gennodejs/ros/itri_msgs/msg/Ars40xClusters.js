// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Ars40xCluster = require('./Ars40xCluster.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Ars40xClusters {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.clusters = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('clusters')) {
        this.clusters = initObj.clusters
      }
      else {
        this.clusters = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ars40xClusters
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [clusters]
    // Serialize the length for message field [clusters]
    bufferOffset = _serializer.uint32(obj.clusters.length, buffer, bufferOffset);
    obj.clusters.forEach((val) => {
      bufferOffset = Ars40xCluster.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ars40xClusters
    let len;
    let data = new Ars40xClusters(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [clusters]
    // Deserialize array length for message field [clusters]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.clusters = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.clusters[i] = Ars40xCluster.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 117 * object.clusters.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Ars40xClusters';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9e30dcb8c03a99114825665a399d4d4b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    Ars40xCluster[] clusters
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
    MSG: itri_msgs/Ars40xCluster
    uint8 id
    
    geometry_msgs/Pose pose
    geometry_msgs/Twist velocity
    
    # dBm^2
    float32 radar_cross_section
    
    uint8 MOVING = 0
    uint8 STATIONARY = 1
    uint8 ONCOMING = 2
    uint8 STATIONARY_CANDIDATE = 3
    uint8 UNKNOWN = 4
    uint8 CROSSING_STATIONARY = 5
    uint8 CROSSING_MOVING = 6
    uint8 STOPPED = 7
    uint8 dynamic
    
    uint8 INVALID = 0
    uint8 AMBIGUOUS = 1
    uint8 STAGGERED_RAMP = 2
    uint8 UNAMBIGUOUS = 3
    uint8 STATIONARY_CANDIDATES = 4
    uint8 ambiguity
    
    uint8 VALID = 0
    uint8 INVALID_DUE_TO_LOW_RCS = 1
    uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2
    uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3
    uint8 VALID_WITH_LOW_RCS = 4
    uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6
    uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7
    uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8
    uint8 VALID_WITH_HIGH_CHILD_PROB = 9
    uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10
    uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11
    uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12
    uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14
    uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15
    uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16
    uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17
    uint8 validity
    
    # false alarm probability, percentage
    float32 probability
    
    bool is_near
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Ars40xClusters(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.clusters !== undefined) {
      resolved.clusters = new Array(msg.clusters.length);
      for (let i = 0; i < resolved.clusters.length; ++i) {
        resolved.clusters[i] = Ars40xCluster.Resolve(msg.clusters[i]);
      }
    }
    else {
      resolved.clusters = []
    }

    return resolved;
    }
};

module.exports = Ars40xClusters;
