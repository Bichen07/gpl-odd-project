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

class LateralLQRState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.saturated = null;
      this.i = null;
      this.lqrOutput = null;
      this.active = null;
      this.output = null;
      this.steerAngle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('saturated')) {
        this.saturated = initObj.saturated
      }
      else {
        this.saturated = false;
      }
      if (initObj.hasOwnProperty('i')) {
        this.i = initObj.i
      }
      else {
        this.i = 0.0;
      }
      if (initObj.hasOwnProperty('lqrOutput')) {
        this.lqrOutput = initObj.lqrOutput
      }
      else {
        this.lqrOutput = 0.0;
      }
      if (initObj.hasOwnProperty('active')) {
        this.active = initObj.active
      }
      else {
        this.active = false;
      }
      if (initObj.hasOwnProperty('output')) {
        this.output = initObj.output
      }
      else {
        this.output = 0.0;
      }
      if (initObj.hasOwnProperty('steerAngle')) {
        this.steerAngle = initObj.steerAngle
      }
      else {
        this.steerAngle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LateralLQRState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [saturated]
    bufferOffset = _serializer.bool(obj.saturated, buffer, bufferOffset);
    // Serialize message field [i]
    bufferOffset = _serializer.float32(obj.i, buffer, bufferOffset);
    // Serialize message field [lqrOutput]
    bufferOffset = _serializer.float32(obj.lqrOutput, buffer, bufferOffset);
    // Serialize message field [active]
    bufferOffset = _serializer.bool(obj.active, buffer, bufferOffset);
    // Serialize message field [output]
    bufferOffset = _serializer.float32(obj.output, buffer, bufferOffset);
    // Serialize message field [steerAngle]
    bufferOffset = _serializer.float32(obj.steerAngle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LateralLQRState
    let len;
    let data = new LateralLQRState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [saturated]
    data.saturated = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [i]
    data.i = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lqrOutput]
    data.lqrOutput = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [active]
    data.active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [output]
    data.output = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerAngle]
    data.steerAngle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 18;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LateralLQRState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ff5983ad96ee2fa8c9b3219e5644acd9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool saturated
    float32 i
    float32 lqrOutput
    bool active
    float32 output
    float32 steerAngle
    
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
    const resolved = new LateralLQRState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.saturated !== undefined) {
      resolved.saturated = msg.saturated;
    }
    else {
      resolved.saturated = false
    }

    if (msg.i !== undefined) {
      resolved.i = msg.i;
    }
    else {
      resolved.i = 0.0
    }

    if (msg.lqrOutput !== undefined) {
      resolved.lqrOutput = msg.lqrOutput;
    }
    else {
      resolved.lqrOutput = 0.0
    }

    if (msg.active !== undefined) {
      resolved.active = msg.active;
    }
    else {
      resolved.active = false
    }

    if (msg.output !== undefined) {
      resolved.output = msg.output;
    }
    else {
      resolved.output = 0.0
    }

    if (msg.steerAngle !== undefined) {
      resolved.steerAngle = msg.steerAngle;
    }
    else {
      resolved.steerAngle = 0.0
    }

    return resolved;
    }
};

module.exports = LateralLQRState;
