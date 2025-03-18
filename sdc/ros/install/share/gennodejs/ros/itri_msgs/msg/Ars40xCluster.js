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

class Ars40xCluster {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.pose = null;
      this.velocity = null;
      this.radar_cross_section = null;
      this.dynamic = null;
      this.ambiguity = null;
      this.validity = null;
      this.probability = null;
      this.is_near = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('radar_cross_section')) {
        this.radar_cross_section = initObj.radar_cross_section
      }
      else {
        this.radar_cross_section = 0.0;
      }
      if (initObj.hasOwnProperty('dynamic')) {
        this.dynamic = initObj.dynamic
      }
      else {
        this.dynamic = 0;
      }
      if (initObj.hasOwnProperty('ambiguity')) {
        this.ambiguity = initObj.ambiguity
      }
      else {
        this.ambiguity = 0;
      }
      if (initObj.hasOwnProperty('validity')) {
        this.validity = initObj.validity
      }
      else {
        this.validity = 0;
      }
      if (initObj.hasOwnProperty('probability')) {
        this.probability = initObj.probability
      }
      else {
        this.probability = 0.0;
      }
      if (initObj.hasOwnProperty('is_near')) {
        this.is_near = initObj.is_near
      }
      else {
        this.is_near = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ars40xCluster
    // Serialize message field [id]
    bufferOffset = _serializer.uint8(obj.id, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [velocity]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.velocity, buffer, bufferOffset);
    // Serialize message field [radar_cross_section]
    bufferOffset = _serializer.float32(obj.radar_cross_section, buffer, bufferOffset);
    // Serialize message field [dynamic]
    bufferOffset = _serializer.uint8(obj.dynamic, buffer, bufferOffset);
    // Serialize message field [ambiguity]
    bufferOffset = _serializer.uint8(obj.ambiguity, buffer, bufferOffset);
    // Serialize message field [validity]
    bufferOffset = _serializer.uint8(obj.validity, buffer, bufferOffset);
    // Serialize message field [probability]
    bufferOffset = _serializer.float32(obj.probability, buffer, bufferOffset);
    // Serialize message field [is_near]
    bufferOffset = _serializer.bool(obj.is_near, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ars40xCluster
    let len;
    let data = new Ars40xCluster(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [radar_cross_section]
    data.radar_cross_section = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dynamic]
    data.dynamic = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ambiguity]
    data.ambiguity = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [validity]
    data.validity = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [probability]
    data.probability = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [is_near]
    data.is_near = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 117;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Ars40xCluster';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '04db439c9c17d17c68474bb1a9a0c1c8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Ars40xCluster(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.velocity !== undefined) {
      resolved.velocity = geometry_msgs.msg.Twist.Resolve(msg.velocity)
    }
    else {
      resolved.velocity = new geometry_msgs.msg.Twist()
    }

    if (msg.radar_cross_section !== undefined) {
      resolved.radar_cross_section = msg.radar_cross_section;
    }
    else {
      resolved.radar_cross_section = 0.0
    }

    if (msg.dynamic !== undefined) {
      resolved.dynamic = msg.dynamic;
    }
    else {
      resolved.dynamic = 0
    }

    if (msg.ambiguity !== undefined) {
      resolved.ambiguity = msg.ambiguity;
    }
    else {
      resolved.ambiguity = 0
    }

    if (msg.validity !== undefined) {
      resolved.validity = msg.validity;
    }
    else {
      resolved.validity = 0
    }

    if (msg.probability !== undefined) {
      resolved.probability = msg.probability;
    }
    else {
      resolved.probability = 0.0
    }

    if (msg.is_near !== undefined) {
      resolved.is_near = msg.is_near;
    }
    else {
      resolved.is_near = false
    }

    return resolved;
    }
};

// Constants for message
Ars40xCluster.Constants = {
  MOVING: 0,
  STATIONARY: 1,
  ONCOMING: 2,
  STATIONARY_CANDIDATE: 3,
  UNKNOWN: 4,
  CROSSING_STATIONARY: 5,
  CROSSING_MOVING: 6,
  STOPPED: 7,
  INVALID: 0,
  AMBIGUOUS: 1,
  STAGGERED_RAMP: 2,
  UNAMBIGUOUS: 3,
  STATIONARY_CANDIDATES: 4,
  VALID: 0,
  INVALID_DUE_TO_LOW_RCS: 1,
  INVALID_DUE_TO_NEAR_FIELD_ARTEFACT: 2,
  INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE: 3,
  VALID_WITH_LOW_RCS: 4,
  INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY: 6,
  INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW: 7,
  VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION: 8,
  VALID_WITH_HIGH_CHILD_PROB: 9,
  VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT: 10,
  VALID_BUT_NO_LOCAL_MAXIMUM: 11,
  VALID_WITH_HIGH_ARTEFACT_PROB: 12,
  INVALID_BECAUSE_IT_IS_HARMONIC: 14,
  VALID_ABOVE_95M_IN_NEAR_RANGE: 15,
  VALID_WITH_HIGH_MULTI_TARGET_PROB: 16,
  VALID_WITH_SUSPICIOUS_ANGLE: 17,
}

module.exports = Ars40xCluster;
