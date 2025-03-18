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

class Ars40xObject {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.width = null;
      this.length = null;
      this.pose = null;
      this.velocity = null;
      this.acceleration = null;
      this.radar_cross_section = null;
      this.Class = null;
      this.dynamic = null;
      this.measurment = null;
      this.probability = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
      if (initObj.hasOwnProperty('length')) {
        this.length = initObj.length
      }
      else {
        this.length = 0.0;
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
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = new geometry_msgs.msg.Accel();
      }
      if (initObj.hasOwnProperty('radar_cross_section')) {
        this.radar_cross_section = initObj.radar_cross_section
      }
      else {
        this.radar_cross_section = 0.0;
      }
      if (initObj.hasOwnProperty('Class')) {
        this.Class = initObj.Class
      }
      else {
        this.Class = 0;
      }
      if (initObj.hasOwnProperty('dynamic')) {
        this.dynamic = initObj.dynamic
      }
      else {
        this.dynamic = 0;
      }
      if (initObj.hasOwnProperty('measurment')) {
        this.measurment = initObj.measurment
      }
      else {
        this.measurment = 0;
      }
      if (initObj.hasOwnProperty('probability')) {
        this.probability = initObj.probability
      }
      else {
        this.probability = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ars40xObject
    // Serialize message field [id]
    bufferOffset = _serializer.uint8(obj.id, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float32(obj.width, buffer, bufferOffset);
    // Serialize message field [length]
    bufferOffset = _serializer.float32(obj.length, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [velocity]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.velocity, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = geometry_msgs.msg.Accel.serialize(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [radar_cross_section]
    bufferOffset = _serializer.float32(obj.radar_cross_section, buffer, bufferOffset);
    // Serialize message field [Class]
    bufferOffset = _serializer.uint8(obj.Class, buffer, bufferOffset);
    // Serialize message field [dynamic]
    bufferOffset = _serializer.uint8(obj.dynamic, buffer, bufferOffset);
    // Serialize message field [measurment]
    bufferOffset = _serializer.uint8(obj.measurment, buffer, bufferOffset);
    // Serialize message field [probability]
    bufferOffset = _serializer.float32(obj.probability, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ars40xObject
    let len;
    let data = new Ars40xObject(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [length]
    data.length = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = geometry_msgs.msg.Accel.deserialize(buffer, bufferOffset);
    // Deserialize message field [radar_cross_section]
    data.radar_cross_section = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Class]
    data.Class = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dynamic]
    data.dynamic = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [measurment]
    data.measurment = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [probability]
    data.probability = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 172;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Ars40xObject';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0f77a1c96789bbc33d08f7bf24542202';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Ars40xObject(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    if (msg.length !== undefined) {
      resolved.length = msg.length;
    }
    else {
      resolved.length = 0.0
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

    if (msg.acceleration !== undefined) {
      resolved.acceleration = geometry_msgs.msg.Accel.Resolve(msg.acceleration)
    }
    else {
      resolved.acceleration = new geometry_msgs.msg.Accel()
    }

    if (msg.radar_cross_section !== undefined) {
      resolved.radar_cross_section = msg.radar_cross_section;
    }
    else {
      resolved.radar_cross_section = 0.0
    }

    if (msg.Class !== undefined) {
      resolved.Class = msg.Class;
    }
    else {
      resolved.Class = 0
    }

    if (msg.dynamic !== undefined) {
      resolved.dynamic = msg.dynamic;
    }
    else {
      resolved.dynamic = 0
    }

    if (msg.measurment !== undefined) {
      resolved.measurment = msg.measurment;
    }
    else {
      resolved.measurment = 0
    }

    if (msg.probability !== undefined) {
      resolved.probability = msg.probability;
    }
    else {
      resolved.probability = 0.0
    }

    return resolved;
    }
};

// Constants for message
Ars40xObject.Constants = {
  POINT: 0,
  CAR: 1,
  TRUCK: 2,
  MOTORCYCLE: 4,
  BICYCLE: 5,
  WIDE: 6,
  MOVING: 0,
  STATIONARY: 1,
  ONCOMING: 2,
  STATIONARY_CANDIDATE: 3,
  UNKNOWN: 4,
  CROSSING_STATIONARY: 5,
  CROSSING_MOVING: 6,
  STOPPED: 7,
  DELETED: 0,
  NEW_CREATED: 1,
  MEASURED: 2,
  PREDICTED: 3,
  DELETED_FOR_MERGE: 4,
  NEW_FROM_MERGE: 5,
}

module.exports = Ars40xObject;
