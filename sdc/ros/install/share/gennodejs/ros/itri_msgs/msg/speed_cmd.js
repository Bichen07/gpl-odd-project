// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class speed_cmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.type = null;
      this.kph = null;
      this.acceleration = null;
      this.velocityCmdState = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('kph')) {
        this.kph = initObj.kph
      }
      else {
        this.kph = 0.0;
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('velocityCmdState')) {
        this.velocityCmdState = initObj.velocityCmdState
      }
      else {
        this.velocityCmdState = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type speed_cmd
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint8(obj.type, buffer, bufferOffset);
    // Serialize message field [kph]
    bufferOffset = _serializer.float32(obj.kph, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = _serializer.float32(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [velocityCmdState]
    bufferOffset = _serializer.uint8(obj.velocityCmdState, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type speed_cmd
    let len;
    let data = new speed_cmd(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [kph]
    data.kph = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [velocityCmdState]
    data.velocityCmdState = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/speed_cmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '72fdcf92cab2efe452f034bb122ac210';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint8 OPEN_LOOP = 0
    uint8 CLOSE_LOOP = 1
    
    uint8 NON_DEFINE = 0
    uint8 ACCELERATION = 1
    uint8 CONSTANT_SPEED = 2
    uint8 DEACCELERATION = 3
    
    uint8 type
    float32 kph
    float32 acceleration
    uint8 velocityCmdState
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new speed_cmd(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.kph !== undefined) {
      resolved.kph = msg.kph;
    }
    else {
      resolved.kph = 0.0
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = msg.acceleration;
    }
    else {
      resolved.acceleration = 0.0
    }

    if (msg.velocityCmdState !== undefined) {
      resolved.velocityCmdState = msg.velocityCmdState;
    }
    else {
      resolved.velocityCmdState = 0
    }

    return resolved;
    }
};

// Constants for message
speed_cmd.Constants = {
  OPEN_LOOP: 0,
  CLOSE_LOOP: 1,
  NON_DEFINE: 0,
  ACCELERATION: 1,
  CONSTANT_SPEED: 2,
  DEACCELERATION: 3,
}

module.exports = speed_cmd;
