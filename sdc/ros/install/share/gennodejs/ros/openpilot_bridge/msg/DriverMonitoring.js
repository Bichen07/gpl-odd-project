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

class DriverMonitoring {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.faceOrientation = null;
      this.stdDEPRECATED = null;
      this.irPwrDEPRECATED = null;
      this.faceOrientationStd = null;
      this.faceProb = null;
      this.frameId = null;
      this.descriptorDEPRECATED = null;
      this.rightBlinkProb = null;
      this.rightEyeProb = null;
      this.facePositionStd = null;
      this.leftBlinkProb = null;
      this.leftEyeProb = null;
      this.facePosition = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('faceOrientation')) {
        this.faceOrientation = initObj.faceOrientation
      }
      else {
        this.faceOrientation = [];
      }
      if (initObj.hasOwnProperty('stdDEPRECATED')) {
        this.stdDEPRECATED = initObj.stdDEPRECATED
      }
      else {
        this.stdDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('irPwrDEPRECATED')) {
        this.irPwrDEPRECATED = initObj.irPwrDEPRECATED
      }
      else {
        this.irPwrDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('faceOrientationStd')) {
        this.faceOrientationStd = initObj.faceOrientationStd
      }
      else {
        this.faceOrientationStd = [];
      }
      if (initObj.hasOwnProperty('faceProb')) {
        this.faceProb = initObj.faceProb
      }
      else {
        this.faceProb = 0.0;
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
      if (initObj.hasOwnProperty('descriptorDEPRECATED')) {
        this.descriptorDEPRECATED = initObj.descriptorDEPRECATED
      }
      else {
        this.descriptorDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('rightBlinkProb')) {
        this.rightBlinkProb = initObj.rightBlinkProb
      }
      else {
        this.rightBlinkProb = 0.0;
      }
      if (initObj.hasOwnProperty('rightEyeProb')) {
        this.rightEyeProb = initObj.rightEyeProb
      }
      else {
        this.rightEyeProb = 0.0;
      }
      if (initObj.hasOwnProperty('facePositionStd')) {
        this.facePositionStd = initObj.facePositionStd
      }
      else {
        this.facePositionStd = [];
      }
      if (initObj.hasOwnProperty('leftBlinkProb')) {
        this.leftBlinkProb = initObj.leftBlinkProb
      }
      else {
        this.leftBlinkProb = 0.0;
      }
      if (initObj.hasOwnProperty('leftEyeProb')) {
        this.leftEyeProb = initObj.leftEyeProb
      }
      else {
        this.leftEyeProb = 0.0;
      }
      if (initObj.hasOwnProperty('facePosition')) {
        this.facePosition = initObj.facePosition
      }
      else {
        this.facePosition = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DriverMonitoring
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [faceOrientation]
    bufferOffset = _arraySerializer.float32(obj.faceOrientation, buffer, bufferOffset, null);
    // Serialize message field [stdDEPRECATED]
    bufferOffset = _serializer.float32(obj.stdDEPRECATED, buffer, bufferOffset);
    // Serialize message field [irPwrDEPRECATED]
    bufferOffset = _serializer.float32(obj.irPwrDEPRECATED, buffer, bufferOffset);
    // Serialize message field [faceOrientationStd]
    bufferOffset = _arraySerializer.float32(obj.faceOrientationStd, buffer, bufferOffset, null);
    // Serialize message field [faceProb]
    bufferOffset = _serializer.float32(obj.faceProb, buffer, bufferOffset);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    // Serialize message field [descriptorDEPRECATED]
    bufferOffset = _arraySerializer.float32(obj.descriptorDEPRECATED, buffer, bufferOffset, null);
    // Serialize message field [rightBlinkProb]
    bufferOffset = _serializer.float32(obj.rightBlinkProb, buffer, bufferOffset);
    // Serialize message field [rightEyeProb]
    bufferOffset = _serializer.float32(obj.rightEyeProb, buffer, bufferOffset);
    // Serialize message field [facePositionStd]
    bufferOffset = _arraySerializer.float32(obj.facePositionStd, buffer, bufferOffset, null);
    // Serialize message field [leftBlinkProb]
    bufferOffset = _serializer.float32(obj.leftBlinkProb, buffer, bufferOffset);
    // Serialize message field [leftEyeProb]
    bufferOffset = _serializer.float32(obj.leftEyeProb, buffer, bufferOffset);
    // Serialize message field [facePosition]
    bufferOffset = _arraySerializer.float32(obj.facePosition, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DriverMonitoring
    let len;
    let data = new DriverMonitoring(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [faceOrientation]
    data.faceOrientation = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [stdDEPRECATED]
    data.stdDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [irPwrDEPRECATED]
    data.irPwrDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [faceOrientationStd]
    data.faceOrientationStd = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [faceProb]
    data.faceProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [descriptorDEPRECATED]
    data.descriptorDEPRECATED = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [rightBlinkProb]
    data.rightBlinkProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rightEyeProb]
    data.rightEyeProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [facePositionStd]
    data.facePositionStd = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [leftBlinkProb]
    data.leftBlinkProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [leftEyeProb]
    data.leftEyeProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [facePosition]
    data.facePosition = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.faceOrientation.length;
    length += 4 * object.faceOrientationStd.length;
    length += 4 * object.descriptorDEPRECATED.length;
    length += 4 * object.facePositionStd.length;
    length += 4 * object.facePosition.length;
    return length + 56;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/DriverMonitoring';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bc7bb5c40d657dda1ef2c99f7d9a20f7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] faceOrientation
    float32 stdDEPRECATED
    float32 irPwrDEPRECATED
    float32[] faceOrientationStd
    float32 faceProb
    int64 frameId
    float32[] descriptorDEPRECATED
    float32 rightBlinkProb
    float32 rightEyeProb
    float32[] facePositionStd
    float32 leftBlinkProb
    float32 leftEyeProb
    float32[] facePosition
    
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
    const resolved = new DriverMonitoring(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.faceOrientation !== undefined) {
      resolved.faceOrientation = msg.faceOrientation;
    }
    else {
      resolved.faceOrientation = []
    }

    if (msg.stdDEPRECATED !== undefined) {
      resolved.stdDEPRECATED = msg.stdDEPRECATED;
    }
    else {
      resolved.stdDEPRECATED = 0.0
    }

    if (msg.irPwrDEPRECATED !== undefined) {
      resolved.irPwrDEPRECATED = msg.irPwrDEPRECATED;
    }
    else {
      resolved.irPwrDEPRECATED = 0.0
    }

    if (msg.faceOrientationStd !== undefined) {
      resolved.faceOrientationStd = msg.faceOrientationStd;
    }
    else {
      resolved.faceOrientationStd = []
    }

    if (msg.faceProb !== undefined) {
      resolved.faceProb = msg.faceProb;
    }
    else {
      resolved.faceProb = 0.0
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    if (msg.descriptorDEPRECATED !== undefined) {
      resolved.descriptorDEPRECATED = msg.descriptorDEPRECATED;
    }
    else {
      resolved.descriptorDEPRECATED = []
    }

    if (msg.rightBlinkProb !== undefined) {
      resolved.rightBlinkProb = msg.rightBlinkProb;
    }
    else {
      resolved.rightBlinkProb = 0.0
    }

    if (msg.rightEyeProb !== undefined) {
      resolved.rightEyeProb = msg.rightEyeProb;
    }
    else {
      resolved.rightEyeProb = 0.0
    }

    if (msg.facePositionStd !== undefined) {
      resolved.facePositionStd = msg.facePositionStd;
    }
    else {
      resolved.facePositionStd = []
    }

    if (msg.leftBlinkProb !== undefined) {
      resolved.leftBlinkProb = msg.leftBlinkProb;
    }
    else {
      resolved.leftBlinkProb = 0.0
    }

    if (msg.leftEyeProb !== undefined) {
      resolved.leftEyeProb = msg.leftEyeProb;
    }
    else {
      resolved.leftEyeProb = 0.0
    }

    if (msg.facePosition !== undefined) {
      resolved.facePosition = msg.facePosition;
    }
    else {
      resolved.facePosition = []
    }

    return resolved;
    }
};

module.exports = DriverMonitoring;
