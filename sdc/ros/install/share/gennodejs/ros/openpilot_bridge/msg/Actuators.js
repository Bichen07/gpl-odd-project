// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Actuators {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.brake = null;
      this.gas = null;
      this.steerAngle = null;
      this.steer = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('brake')) {
        this.brake = initObj.brake
      }
      else {
        this.brake = 0.0;
      }
      if (initObj.hasOwnProperty('gas')) {
        this.gas = initObj.gas
      }
      else {
        this.gas = 0.0;
      }
      if (initObj.hasOwnProperty('steerAngle')) {
        this.steerAngle = initObj.steerAngle
      }
      else {
        this.steerAngle = 0.0;
      }
      if (initObj.hasOwnProperty('steer')) {
        this.steer = initObj.steer
      }
      else {
        this.steer = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Actuators
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [brake]
    bufferOffset = _serializer.float32(obj.brake, buffer, bufferOffset);
    // Serialize message field [gas]
    bufferOffset = _serializer.float32(obj.gas, buffer, bufferOffset);
    // Serialize message field [steerAngle]
    bufferOffset = _serializer.float32(obj.steerAngle, buffer, bufferOffset);
    // Serialize message field [steer]
    bufferOffset = _serializer.float32(obj.steer, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Actuators
    let len;
    let data = new Actuators(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [brake]
    data.brake = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gas]
    data.gas = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerAngle]
    data.steerAngle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steer]
    data.steer = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Actuators';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0435bf15641d212acad91b17b1a76f72';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 brake
    float32 gas
    float32 steerAngle
    float32 steer
    
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
    const resolved = new Actuators(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.brake !== undefined) {
      resolved.brake = msg.brake;
    }
    else {
      resolved.brake = 0.0
    }

    if (msg.gas !== undefined) {
      resolved.gas = msg.gas;
    }
    else {
      resolved.gas = 0.0
    }

    if (msg.steerAngle !== undefined) {
      resolved.steerAngle = msg.steerAngle;
    }
    else {
      resolved.steerAngle = 0.0
    }

    if (msg.steer !== undefined) {
      resolved.steer = msg.steer;
    }
    else {
      resolved.steer = 0.0
    }

    return resolved;
    }
};

module.exports = Actuators;
