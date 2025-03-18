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

class CruiseControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.cancel = null;
      this.override = null;
      this.speedOverride = null;
      this.accelOverride = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('cancel')) {
        this.cancel = initObj.cancel
      }
      else {
        this.cancel = false;
      }
      if (initObj.hasOwnProperty('override')) {
        this.override = initObj.override
      }
      else {
        this.override = false;
      }
      if (initObj.hasOwnProperty('speedOverride')) {
        this.speedOverride = initObj.speedOverride
      }
      else {
        this.speedOverride = 0.0;
      }
      if (initObj.hasOwnProperty('accelOverride')) {
        this.accelOverride = initObj.accelOverride
      }
      else {
        this.accelOverride = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CruiseControl
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [cancel]
    bufferOffset = _serializer.bool(obj.cancel, buffer, bufferOffset);
    // Serialize message field [override]
    bufferOffset = _serializer.bool(obj.override, buffer, bufferOffset);
    // Serialize message field [speedOverride]
    bufferOffset = _serializer.float32(obj.speedOverride, buffer, bufferOffset);
    // Serialize message field [accelOverride]
    bufferOffset = _serializer.float32(obj.accelOverride, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CruiseControl
    let len;
    let data = new CruiseControl(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [cancel]
    data.cancel = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [override]
    data.override = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speedOverride]
    data.speedOverride = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accelOverride]
    data.accelOverride = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CruiseControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '08f6bd5b4e57f59d4c99b2a0ea459283';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool cancel
    bool override
    float32 speedOverride
    float32 accelOverride
    
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
    const resolved = new CruiseControl(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.cancel !== undefined) {
      resolved.cancel = msg.cancel;
    }
    else {
      resolved.cancel = false
    }

    if (msg.override !== undefined) {
      resolved.override = msg.override;
    }
    else {
      resolved.override = false
    }

    if (msg.speedOverride !== undefined) {
      resolved.speedOverride = msg.speedOverride;
    }
    else {
      resolved.speedOverride = 0.0
    }

    if (msg.accelOverride !== undefined) {
      resolved.accelOverride = msg.accelOverride;
    }
    else {
      resolved.accelOverride = 0.0
    }

    return resolved;
    }
};

module.exports = CruiseControl;
