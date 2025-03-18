// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let AndroidCaptureResult = require('./AndroidCaptureResult.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class FrameData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.integLines = null;
      this.frameLength = null;
      this.timestampSof = null;
      this.lensTruePos = null;
      this.timestampEof = null;
      this.transform = null;
      this.frameId = null;
      this.encodeId = null;
      this.androidCaptureResult = null;
      this.gainFrac = null;
      this.lensSag = null;
      this.globalGain = null;
      this.lensErr = null;
      this.image = null;
      this.frameType = null;
      this.lensPos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('integLines')) {
        this.integLines = initObj.integLines
      }
      else {
        this.integLines = 0;
      }
      if (initObj.hasOwnProperty('frameLength')) {
        this.frameLength = initObj.frameLength
      }
      else {
        this.frameLength = 0;
      }
      if (initObj.hasOwnProperty('timestampSof')) {
        this.timestampSof = initObj.timestampSof
      }
      else {
        this.timestampSof = 0;
      }
      if (initObj.hasOwnProperty('lensTruePos')) {
        this.lensTruePos = initObj.lensTruePos
      }
      else {
        this.lensTruePos = 0.0;
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('transform')) {
        this.transform = initObj.transform
      }
      else {
        this.transform = [];
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
      if (initObj.hasOwnProperty('encodeId')) {
        this.encodeId = initObj.encodeId
      }
      else {
        this.encodeId = 0;
      }
      if (initObj.hasOwnProperty('androidCaptureResult')) {
        this.androidCaptureResult = initObj.androidCaptureResult
      }
      else {
        this.androidCaptureResult = new AndroidCaptureResult();
      }
      if (initObj.hasOwnProperty('gainFrac')) {
        this.gainFrac = initObj.gainFrac
      }
      else {
        this.gainFrac = 0.0;
      }
      if (initObj.hasOwnProperty('lensSag')) {
        this.lensSag = initObj.lensSag
      }
      else {
        this.lensSag = 0.0;
      }
      if (initObj.hasOwnProperty('globalGain')) {
        this.globalGain = initObj.globalGain
      }
      else {
        this.globalGain = 0;
      }
      if (initObj.hasOwnProperty('lensErr')) {
        this.lensErr = initObj.lensErr
      }
      else {
        this.lensErr = 0.0;
      }
      if (initObj.hasOwnProperty('image')) {
        this.image = initObj.image
      }
      else {
        this.image = [];
      }
      if (initObj.hasOwnProperty('frameType')) {
        this.frameType = initObj.frameType
      }
      else {
        this.frameType = 0;
      }
      if (initObj.hasOwnProperty('lensPos')) {
        this.lensPos = initObj.lensPos
      }
      else {
        this.lensPos = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FrameData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [integLines]
    bufferOffset = _serializer.int32(obj.integLines, buffer, bufferOffset);
    // Serialize message field [frameLength]
    bufferOffset = _serializer.int32(obj.frameLength, buffer, bufferOffset);
    // Serialize message field [timestampSof]
    bufferOffset = _serializer.int64(obj.timestampSof, buffer, bufferOffset);
    // Serialize message field [lensTruePos]
    bufferOffset = _serializer.float32(obj.lensTruePos, buffer, bufferOffset);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [transform]
    bufferOffset = _arraySerializer.float32(obj.transform, buffer, bufferOffset, null);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    // Serialize message field [encodeId]
    bufferOffset = _serializer.int64(obj.encodeId, buffer, bufferOffset);
    // Serialize message field [androidCaptureResult]
    bufferOffset = AndroidCaptureResult.serialize(obj.androidCaptureResult, buffer, bufferOffset);
    // Serialize message field [gainFrac]
    bufferOffset = _serializer.float32(obj.gainFrac, buffer, bufferOffset);
    // Serialize message field [lensSag]
    bufferOffset = _serializer.float32(obj.lensSag, buffer, bufferOffset);
    // Serialize message field [globalGain]
    bufferOffset = _serializer.int32(obj.globalGain, buffer, bufferOffset);
    // Serialize message field [lensErr]
    bufferOffset = _serializer.float32(obj.lensErr, buffer, bufferOffset);
    // Serialize message field [image]
    bufferOffset = _arraySerializer.string(obj.image, buffer, bufferOffset, null);
    // Serialize message field [frameType]
    bufferOffset = _serializer.uint32(obj.frameType, buffer, bufferOffset);
    // Serialize message field [lensPos]
    bufferOffset = _serializer.int32(obj.lensPos, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FrameData
    let len;
    let data = new FrameData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [integLines]
    data.integLines = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [frameLength]
    data.frameLength = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [timestampSof]
    data.timestampSof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lensTruePos]
    data.lensTruePos = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [transform]
    data.transform = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [encodeId]
    data.encodeId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [androidCaptureResult]
    data.androidCaptureResult = AndroidCaptureResult.deserialize(buffer, bufferOffset);
    // Deserialize message field [gainFrac]
    data.gainFrac = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lensSag]
    data.lensSag = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [globalGain]
    data.globalGain = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lensErr]
    data.lensErr = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [image]
    data.image = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [frameType]
    data.frameType = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [lensPos]
    data.lensPos = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.transform.length;
    length += AndroidCaptureResult.getMessageSize(object.androidCaptureResult);
    object.image.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 76;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/FrameData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7e0f94da917645797426b704505952d4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 integLines
    int32 frameLength
    int64 timestampSof
    float32 lensTruePos
    int64 timestampEof
    float32[] transform
    int64 frameId
    int64 encodeId
    AndroidCaptureResult androidCaptureResult
    float32 gainFrac
    float32 lensSag
    int32 globalGain
    float32 lensErr
    string[] image
    uint32 frameType # enum const: FrameType
    int32 lensPos
    
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
    MSG: openpilot_bridge/AndroidCaptureResult
    Header header
    
    int32 exposureTime
    int32 displayRotation
    float32[] colorCorrectionGains
    int32 sensitivity
    int64 rollingShutterSkew
    int32[] colorCorrectionTransform
    int32 frameDuration
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FrameData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.integLines !== undefined) {
      resolved.integLines = msg.integLines;
    }
    else {
      resolved.integLines = 0
    }

    if (msg.frameLength !== undefined) {
      resolved.frameLength = msg.frameLength;
    }
    else {
      resolved.frameLength = 0
    }

    if (msg.timestampSof !== undefined) {
      resolved.timestampSof = msg.timestampSof;
    }
    else {
      resolved.timestampSof = 0
    }

    if (msg.lensTruePos !== undefined) {
      resolved.lensTruePos = msg.lensTruePos;
    }
    else {
      resolved.lensTruePos = 0.0
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.transform !== undefined) {
      resolved.transform = msg.transform;
    }
    else {
      resolved.transform = []
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    if (msg.encodeId !== undefined) {
      resolved.encodeId = msg.encodeId;
    }
    else {
      resolved.encodeId = 0
    }

    if (msg.androidCaptureResult !== undefined) {
      resolved.androidCaptureResult = AndroidCaptureResult.Resolve(msg.androidCaptureResult)
    }
    else {
      resolved.androidCaptureResult = new AndroidCaptureResult()
    }

    if (msg.gainFrac !== undefined) {
      resolved.gainFrac = msg.gainFrac;
    }
    else {
      resolved.gainFrac = 0.0
    }

    if (msg.lensSag !== undefined) {
      resolved.lensSag = msg.lensSag;
    }
    else {
      resolved.lensSag = 0.0
    }

    if (msg.globalGain !== undefined) {
      resolved.globalGain = msg.globalGain;
    }
    else {
      resolved.globalGain = 0
    }

    if (msg.lensErr !== undefined) {
      resolved.lensErr = msg.lensErr;
    }
    else {
      resolved.lensErr = 0.0
    }

    if (msg.image !== undefined) {
      resolved.image = msg.image;
    }
    else {
      resolved.image = []
    }

    if (msg.frameType !== undefined) {
      resolved.frameType = msg.frameType;
    }
    else {
      resolved.frameType = 0
    }

    if (msg.lensPos !== undefined) {
      resolved.lensPos = msg.lensPos;
    }
    else {
      resolved.lensPos = 0
    }

    return resolved;
    }
};

module.exports = FrameData;
