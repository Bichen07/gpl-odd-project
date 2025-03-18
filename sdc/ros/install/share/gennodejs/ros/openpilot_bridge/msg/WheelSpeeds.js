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

class WheelSpeeds {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rl = null;
      this.fr = null;
      this.fl = null;
      this.rr = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rl')) {
        this.rl = initObj.rl
      }
      else {
        this.rl = 0.0;
      }
      if (initObj.hasOwnProperty('fr')) {
        this.fr = initObj.fr
      }
      else {
        this.fr = 0.0;
      }
      if (initObj.hasOwnProperty('fl')) {
        this.fl = initObj.fl
      }
      else {
        this.fl = 0.0;
      }
      if (initObj.hasOwnProperty('rr')) {
        this.rr = initObj.rr
      }
      else {
        this.rr = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WheelSpeeds
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rl]
    bufferOffset = _serializer.float32(obj.rl, buffer, bufferOffset);
    // Serialize message field [fr]
    bufferOffset = _serializer.float32(obj.fr, buffer, bufferOffset);
    // Serialize message field [fl]
    bufferOffset = _serializer.float32(obj.fl, buffer, bufferOffset);
    // Serialize message field [rr]
    bufferOffset = _serializer.float32(obj.rr, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WheelSpeeds
    let len;
    let data = new WheelSpeeds(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rl]
    data.rl = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fr]
    data.fr = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fl]
    data.fl = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rr]
    data.rr = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/WheelSpeeds';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '835b7f85819edc320a2569cabd6d06bb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 rl
    float32 fr
    float32 fl
    float32 rr
    
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
    const resolved = new WheelSpeeds(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rl !== undefined) {
      resolved.rl = msg.rl;
    }
    else {
      resolved.rl = 0.0
    }

    if (msg.fr !== undefined) {
      resolved.fr = msg.fr;
    }
    else {
      resolved.fr = 0.0
    }

    if (msg.fl !== undefined) {
      resolved.fl = msg.fl;
    }
    else {
      resolved.fl = 0.0
    }

    if (msg.rr !== undefined) {
      resolved.rr = msg.rr;
    }
    else {
      resolved.rr = 0.0
    }

    return resolved;
    }
};

module.exports = WheelSpeeds;
