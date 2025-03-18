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

class HUDControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.leadVisible = null;
      this.setSpeed = null;
      this.leftLaneDepart = null;
      this.lanesVisible = null;
      this.leftLaneVisible = null;
      this.visualAlert = null;
      this.audibleAlert = null;
      this.speedVisible = null;
      this.rightLaneVisible = null;
      this.rightLaneDepart = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('leadVisible')) {
        this.leadVisible = initObj.leadVisible
      }
      else {
        this.leadVisible = false;
      }
      if (initObj.hasOwnProperty('setSpeed')) {
        this.setSpeed = initObj.setSpeed
      }
      else {
        this.setSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('leftLaneDepart')) {
        this.leftLaneDepart = initObj.leftLaneDepart
      }
      else {
        this.leftLaneDepart = false;
      }
      if (initObj.hasOwnProperty('lanesVisible')) {
        this.lanesVisible = initObj.lanesVisible
      }
      else {
        this.lanesVisible = false;
      }
      if (initObj.hasOwnProperty('leftLaneVisible')) {
        this.leftLaneVisible = initObj.leftLaneVisible
      }
      else {
        this.leftLaneVisible = false;
      }
      if (initObj.hasOwnProperty('visualAlert')) {
        this.visualAlert = initObj.visualAlert
      }
      else {
        this.visualAlert = 0;
      }
      if (initObj.hasOwnProperty('audibleAlert')) {
        this.audibleAlert = initObj.audibleAlert
      }
      else {
        this.audibleAlert = 0;
      }
      if (initObj.hasOwnProperty('speedVisible')) {
        this.speedVisible = initObj.speedVisible
      }
      else {
        this.speedVisible = false;
      }
      if (initObj.hasOwnProperty('rightLaneVisible')) {
        this.rightLaneVisible = initObj.rightLaneVisible
      }
      else {
        this.rightLaneVisible = false;
      }
      if (initObj.hasOwnProperty('rightLaneDepart')) {
        this.rightLaneDepart = initObj.rightLaneDepart
      }
      else {
        this.rightLaneDepart = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HUDControl
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [leadVisible]
    bufferOffset = _serializer.bool(obj.leadVisible, buffer, bufferOffset);
    // Serialize message field [setSpeed]
    bufferOffset = _serializer.float32(obj.setSpeed, buffer, bufferOffset);
    // Serialize message field [leftLaneDepart]
    bufferOffset = _serializer.bool(obj.leftLaneDepart, buffer, bufferOffset);
    // Serialize message field [lanesVisible]
    bufferOffset = _serializer.bool(obj.lanesVisible, buffer, bufferOffset);
    // Serialize message field [leftLaneVisible]
    bufferOffset = _serializer.bool(obj.leftLaneVisible, buffer, bufferOffset);
    // Serialize message field [visualAlert]
    bufferOffset = _serializer.uint32(obj.visualAlert, buffer, bufferOffset);
    // Serialize message field [audibleAlert]
    bufferOffset = _serializer.uint32(obj.audibleAlert, buffer, bufferOffset);
    // Serialize message field [speedVisible]
    bufferOffset = _serializer.bool(obj.speedVisible, buffer, bufferOffset);
    // Serialize message field [rightLaneVisible]
    bufferOffset = _serializer.bool(obj.rightLaneVisible, buffer, bufferOffset);
    // Serialize message field [rightLaneDepart]
    bufferOffset = _serializer.bool(obj.rightLaneDepart, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HUDControl
    let len;
    let data = new HUDControl(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [leadVisible]
    data.leadVisible = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [setSpeed]
    data.setSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [leftLaneDepart]
    data.leftLaneDepart = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lanesVisible]
    data.lanesVisible = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [leftLaneVisible]
    data.leftLaneVisible = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [visualAlert]
    data.visualAlert = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [audibleAlert]
    data.audibleAlert = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [speedVisible]
    data.speedVisible = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rightLaneVisible]
    data.rightLaneVisible = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rightLaneDepart]
    data.rightLaneDepart = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 19;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/HUDControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fae5883e88a08288a6e7673c35bc1b32';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool leadVisible
    float32 setSpeed
    bool leftLaneDepart
    bool lanesVisible
    bool leftLaneVisible
    uint32 visualAlert # enum const: VisualAlert
    uint32 audibleAlert # enum const: AudibleAlert
    bool speedVisible
    bool rightLaneVisible
    bool rightLaneDepart
    
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
    const resolved = new HUDControl(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.leadVisible !== undefined) {
      resolved.leadVisible = msg.leadVisible;
    }
    else {
      resolved.leadVisible = false
    }

    if (msg.setSpeed !== undefined) {
      resolved.setSpeed = msg.setSpeed;
    }
    else {
      resolved.setSpeed = 0.0
    }

    if (msg.leftLaneDepart !== undefined) {
      resolved.leftLaneDepart = msg.leftLaneDepart;
    }
    else {
      resolved.leftLaneDepart = false
    }

    if (msg.lanesVisible !== undefined) {
      resolved.lanesVisible = msg.lanesVisible;
    }
    else {
      resolved.lanesVisible = false
    }

    if (msg.leftLaneVisible !== undefined) {
      resolved.leftLaneVisible = msg.leftLaneVisible;
    }
    else {
      resolved.leftLaneVisible = false
    }

    if (msg.visualAlert !== undefined) {
      resolved.visualAlert = msg.visualAlert;
    }
    else {
      resolved.visualAlert = 0
    }

    if (msg.audibleAlert !== undefined) {
      resolved.audibleAlert = msg.audibleAlert;
    }
    else {
      resolved.audibleAlert = 0
    }

    if (msg.speedVisible !== undefined) {
      resolved.speedVisible = msg.speedVisible;
    }
    else {
      resolved.speedVisible = false
    }

    if (msg.rightLaneVisible !== undefined) {
      resolved.rightLaneVisible = msg.rightLaneVisible;
    }
    else {
      resolved.rightLaneVisible = false
    }

    if (msg.rightLaneDepart !== undefined) {
      resolved.rightLaneDepart = msg.rightLaneDepart;
    }
    else {
      resolved.rightLaneDepart = false
    }

    return resolved;
    }
};

module.exports = HUDControl;
