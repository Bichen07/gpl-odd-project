// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SonarArcNum = require('./SonarArcNum.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class SurroundReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.front_radar_object_distance = null;
      this.rear_radar_object_distance = null;
      this.rear_right = null;
      this.rear_left = null;
      this.rear_center = null;
      this.front_right = null;
      this.front_left = null;
      this.front_center = null;
      this.front_radar_distance_valid = null;
      this.parking_sonar_data_valid = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('front_radar_object_distance')) {
        this.front_radar_object_distance = initObj.front_radar_object_distance
      }
      else {
        this.front_radar_object_distance = 0.0;
      }
      if (initObj.hasOwnProperty('rear_radar_object_distance')) {
        this.rear_radar_object_distance = initObj.rear_radar_object_distance
      }
      else {
        this.rear_radar_object_distance = 0.0;
      }
      if (initObj.hasOwnProperty('rear_right')) {
        this.rear_right = initObj.rear_right
      }
      else {
        this.rear_right = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('rear_left')) {
        this.rear_left = initObj.rear_left
      }
      else {
        this.rear_left = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('rear_center')) {
        this.rear_center = initObj.rear_center
      }
      else {
        this.rear_center = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('front_right')) {
        this.front_right = initObj.front_right
      }
      else {
        this.front_right = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('front_left')) {
        this.front_left = initObj.front_left
      }
      else {
        this.front_left = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('front_center')) {
        this.front_center = initObj.front_center
      }
      else {
        this.front_center = new SonarArcNum();
      }
      if (initObj.hasOwnProperty('front_radar_distance_valid')) {
        this.front_radar_distance_valid = initObj.front_radar_distance_valid
      }
      else {
        this.front_radar_distance_valid = false;
      }
      if (initObj.hasOwnProperty('parking_sonar_data_valid')) {
        this.parking_sonar_data_valid = initObj.parking_sonar_data_valid
      }
      else {
        this.parking_sonar_data_valid = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SurroundReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [front_radar_object_distance]
    bufferOffset = _serializer.float32(obj.front_radar_object_distance, buffer, bufferOffset);
    // Serialize message field [rear_radar_object_distance]
    bufferOffset = _serializer.float32(obj.rear_radar_object_distance, buffer, bufferOffset);
    // Serialize message field [rear_right]
    bufferOffset = SonarArcNum.serialize(obj.rear_right, buffer, bufferOffset);
    // Serialize message field [rear_left]
    bufferOffset = SonarArcNum.serialize(obj.rear_left, buffer, bufferOffset);
    // Serialize message field [rear_center]
    bufferOffset = SonarArcNum.serialize(obj.rear_center, buffer, bufferOffset);
    // Serialize message field [front_right]
    bufferOffset = SonarArcNum.serialize(obj.front_right, buffer, bufferOffset);
    // Serialize message field [front_left]
    bufferOffset = SonarArcNum.serialize(obj.front_left, buffer, bufferOffset);
    // Serialize message field [front_center]
    bufferOffset = SonarArcNum.serialize(obj.front_center, buffer, bufferOffset);
    // Serialize message field [front_radar_distance_valid]
    bufferOffset = _serializer.bool(obj.front_radar_distance_valid, buffer, bufferOffset);
    // Serialize message field [parking_sonar_data_valid]
    bufferOffset = _serializer.bool(obj.parking_sonar_data_valid, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SurroundReport
    let len;
    let data = new SurroundReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_radar_object_distance]
    data.front_radar_object_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rear_radar_object_distance]
    data.rear_radar_object_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rear_right]
    data.rear_right = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [rear_left]
    data.rear_left = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [rear_center]
    data.rear_center = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_right]
    data.front_right = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_left]
    data.front_left = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_center]
    data.front_center = SonarArcNum.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_radar_distance_valid]
    data.front_radar_distance_valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [parking_sonar_data_valid]
    data.parking_sonar_data_valid = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/SurroundReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7fb6baa192c10e400b9071053bd9c683';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 front_radar_object_distance # meters
    float32 rear_radar_object_distance # meters
    
    SonarArcNum rear_right
    SonarArcNum rear_left
    SonarArcNum rear_center
    SonarArcNum front_right
    SonarArcNum front_left
    SonarArcNum front_center
    
    bool front_radar_distance_valid
    bool parking_sonar_data_valid
    
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
    MSG: dbw_pacifica_msgs/SonarArcNum
    uint8 status
    
    # Unitless - based on bars on display
    uint8 NO_DISTANCE = 0
    uint8 ARC1 = 1
    uint8 ARC2 = 2
    uint8 ARC3 = 3
    uint8 ARC4 = 4
    uint8 ARC5 = 5
    uint8 ARC6 = 6
    uint8 ARC7 = 7
    uint8 ARC8 = 8
    uint8 NO_ARC = 15
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SurroundReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.front_radar_object_distance !== undefined) {
      resolved.front_radar_object_distance = msg.front_radar_object_distance;
    }
    else {
      resolved.front_radar_object_distance = 0.0
    }

    if (msg.rear_radar_object_distance !== undefined) {
      resolved.rear_radar_object_distance = msg.rear_radar_object_distance;
    }
    else {
      resolved.rear_radar_object_distance = 0.0
    }

    if (msg.rear_right !== undefined) {
      resolved.rear_right = SonarArcNum.Resolve(msg.rear_right)
    }
    else {
      resolved.rear_right = new SonarArcNum()
    }

    if (msg.rear_left !== undefined) {
      resolved.rear_left = SonarArcNum.Resolve(msg.rear_left)
    }
    else {
      resolved.rear_left = new SonarArcNum()
    }

    if (msg.rear_center !== undefined) {
      resolved.rear_center = SonarArcNum.Resolve(msg.rear_center)
    }
    else {
      resolved.rear_center = new SonarArcNum()
    }

    if (msg.front_right !== undefined) {
      resolved.front_right = SonarArcNum.Resolve(msg.front_right)
    }
    else {
      resolved.front_right = new SonarArcNum()
    }

    if (msg.front_left !== undefined) {
      resolved.front_left = SonarArcNum.Resolve(msg.front_left)
    }
    else {
      resolved.front_left = new SonarArcNum()
    }

    if (msg.front_center !== undefined) {
      resolved.front_center = SonarArcNum.Resolve(msg.front_center)
    }
    else {
      resolved.front_center = new SonarArcNum()
    }

    if (msg.front_radar_distance_valid !== undefined) {
      resolved.front_radar_distance_valid = msg.front_radar_distance_valid;
    }
    else {
      resolved.front_radar_distance_valid = false
    }

    if (msg.parking_sonar_data_valid !== undefined) {
      resolved.parking_sonar_data_valid = msg.parking_sonar_data_valid;
    }
    else {
      resolved.parking_sonar_data_valid = false
    }

    return resolved;
    }
};

module.exports = SurroundReport;
