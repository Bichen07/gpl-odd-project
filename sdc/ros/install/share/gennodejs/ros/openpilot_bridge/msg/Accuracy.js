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

class Accuracy {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.vNEDError = null;
      this.rollError = null;
      this.headingError = null;
      this.ellipsoidSemiMajorError = null;
      this.ellipsoidOrientationError = null;
      this.pNEDError = null;
      this.ellipsoidSemiMinorError = null;
      this.pitchError = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('vNEDError')) {
        this.vNEDError = initObj.vNEDError
      }
      else {
        this.vNEDError = [];
      }
      if (initObj.hasOwnProperty('rollError')) {
        this.rollError = initObj.rollError
      }
      else {
        this.rollError = 0.0;
      }
      if (initObj.hasOwnProperty('headingError')) {
        this.headingError = initObj.headingError
      }
      else {
        this.headingError = 0.0;
      }
      if (initObj.hasOwnProperty('ellipsoidSemiMajorError')) {
        this.ellipsoidSemiMajorError = initObj.ellipsoidSemiMajorError
      }
      else {
        this.ellipsoidSemiMajorError = 0.0;
      }
      if (initObj.hasOwnProperty('ellipsoidOrientationError')) {
        this.ellipsoidOrientationError = initObj.ellipsoidOrientationError
      }
      else {
        this.ellipsoidOrientationError = 0.0;
      }
      if (initObj.hasOwnProperty('pNEDError')) {
        this.pNEDError = initObj.pNEDError
      }
      else {
        this.pNEDError = [];
      }
      if (initObj.hasOwnProperty('ellipsoidSemiMinorError')) {
        this.ellipsoidSemiMinorError = initObj.ellipsoidSemiMinorError
      }
      else {
        this.ellipsoidSemiMinorError = 0.0;
      }
      if (initObj.hasOwnProperty('pitchError')) {
        this.pitchError = initObj.pitchError
      }
      else {
        this.pitchError = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Accuracy
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [vNEDError]
    bufferOffset = _arraySerializer.float32(obj.vNEDError, buffer, bufferOffset, null);
    // Serialize message field [rollError]
    bufferOffset = _serializer.float32(obj.rollError, buffer, bufferOffset);
    // Serialize message field [headingError]
    bufferOffset = _serializer.float32(obj.headingError, buffer, bufferOffset);
    // Serialize message field [ellipsoidSemiMajorError]
    bufferOffset = _serializer.float32(obj.ellipsoidSemiMajorError, buffer, bufferOffset);
    // Serialize message field [ellipsoidOrientationError]
    bufferOffset = _serializer.float32(obj.ellipsoidOrientationError, buffer, bufferOffset);
    // Serialize message field [pNEDError]
    bufferOffset = _arraySerializer.float32(obj.pNEDError, buffer, bufferOffset, null);
    // Serialize message field [ellipsoidSemiMinorError]
    bufferOffset = _serializer.float32(obj.ellipsoidSemiMinorError, buffer, bufferOffset);
    // Serialize message field [pitchError]
    bufferOffset = _serializer.float32(obj.pitchError, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Accuracy
    let len;
    let data = new Accuracy(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [vNEDError]
    data.vNEDError = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [rollError]
    data.rollError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [headingError]
    data.headingError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ellipsoidSemiMajorError]
    data.ellipsoidSemiMajorError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ellipsoidOrientationError]
    data.ellipsoidOrientationError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pNEDError]
    data.pNEDError = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [ellipsoidSemiMinorError]
    data.ellipsoidSemiMinorError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pitchError]
    data.pitchError = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.vNEDError.length;
    length += 4 * object.pNEDError.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Accuracy';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'edfdee1e677d557df6dcfc54fda17a60';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] vNEDError
    float32 rollError
    float32 headingError
    float32 ellipsoidSemiMajorError
    float32 ellipsoidOrientationError
    float32[] pNEDError
    float32 ellipsoidSemiMinorError
    float32 pitchError
    
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
    const resolved = new Accuracy(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.vNEDError !== undefined) {
      resolved.vNEDError = msg.vNEDError;
    }
    else {
      resolved.vNEDError = []
    }

    if (msg.rollError !== undefined) {
      resolved.rollError = msg.rollError;
    }
    else {
      resolved.rollError = 0.0
    }

    if (msg.headingError !== undefined) {
      resolved.headingError = msg.headingError;
    }
    else {
      resolved.headingError = 0.0
    }

    if (msg.ellipsoidSemiMajorError !== undefined) {
      resolved.ellipsoidSemiMajorError = msg.ellipsoidSemiMajorError;
    }
    else {
      resolved.ellipsoidSemiMajorError = 0.0
    }

    if (msg.ellipsoidOrientationError !== undefined) {
      resolved.ellipsoidOrientationError = msg.ellipsoidOrientationError;
    }
    else {
      resolved.ellipsoidOrientationError = 0.0
    }

    if (msg.pNEDError !== undefined) {
      resolved.pNEDError = msg.pNEDError;
    }
    else {
      resolved.pNEDError = []
    }

    if (msg.ellipsoidSemiMinorError !== undefined) {
      resolved.ellipsoidSemiMinorError = msg.ellipsoidSemiMinorError;
    }
    else {
      resolved.ellipsoidSemiMinorError = 0.0
    }

    if (msg.pitchError !== undefined) {
      resolved.pitchError = msg.pitchError;
    }
    else {
      resolved.pitchError = 0.0
    }

    return resolved;
    }
};

module.exports = Accuracy;
