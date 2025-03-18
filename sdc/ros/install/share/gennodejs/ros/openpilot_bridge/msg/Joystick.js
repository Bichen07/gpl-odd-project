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

class Joystick {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.buttons = null;
      this.axes = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('buttons')) {
        this.buttons = initObj.buttons
      }
      else {
        this.buttons = [];
      }
      if (initObj.hasOwnProperty('axes')) {
        this.axes = initObj.axes
      }
      else {
        this.axes = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Joystick
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [buttons]
    bufferOffset = _arraySerializer.bool(obj.buttons, buffer, bufferOffset, null);
    // Serialize message field [axes]
    bufferOffset = _arraySerializer.float32(obj.axes, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Joystick
    let len;
    let data = new Joystick(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [buttons]
    data.buttons = _arrayDeserializer.bool(buffer, bufferOffset, null)
    // Deserialize message field [axes]
    data.axes = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.buttons.length;
    length += 4 * object.axes.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Joystick';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7ac6f48951afbf0bc6ae7b9a64b04d72';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool[] buttons
    float32[] axes
    
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
    const resolved = new Joystick(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.buttons !== undefined) {
      resolved.buttons = msg.buttons;
    }
    else {
      resolved.buttons = []
    }

    if (msg.axes !== undefined) {
      resolved.axes = msg.axes;
    }
    else {
      resolved.axes = []
    }

    return resolved;
    }
};

module.exports = Joystick;
