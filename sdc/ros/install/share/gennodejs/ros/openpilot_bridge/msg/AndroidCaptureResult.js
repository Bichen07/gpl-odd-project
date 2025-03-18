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

class AndroidCaptureResult {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.exposureTime = null;
      this.displayRotation = null;
      this.colorCorrectionGains = null;
      this.sensitivity = null;
      this.rollingShutterSkew = null;
      this.colorCorrectionTransform = null;
      this.frameDuration = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('exposureTime')) {
        this.exposureTime = initObj.exposureTime
      }
      else {
        this.exposureTime = 0;
      }
      if (initObj.hasOwnProperty('displayRotation')) {
        this.displayRotation = initObj.displayRotation
      }
      else {
        this.displayRotation = 0;
      }
      if (initObj.hasOwnProperty('colorCorrectionGains')) {
        this.colorCorrectionGains = initObj.colorCorrectionGains
      }
      else {
        this.colorCorrectionGains = [];
      }
      if (initObj.hasOwnProperty('sensitivity')) {
        this.sensitivity = initObj.sensitivity
      }
      else {
        this.sensitivity = 0;
      }
      if (initObj.hasOwnProperty('rollingShutterSkew')) {
        this.rollingShutterSkew = initObj.rollingShutterSkew
      }
      else {
        this.rollingShutterSkew = 0;
      }
      if (initObj.hasOwnProperty('colorCorrectionTransform')) {
        this.colorCorrectionTransform = initObj.colorCorrectionTransform
      }
      else {
        this.colorCorrectionTransform = [];
      }
      if (initObj.hasOwnProperty('frameDuration')) {
        this.frameDuration = initObj.frameDuration
      }
      else {
        this.frameDuration = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AndroidCaptureResult
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [exposureTime]
    bufferOffset = _serializer.int32(obj.exposureTime, buffer, bufferOffset);
    // Serialize message field [displayRotation]
    bufferOffset = _serializer.int32(obj.displayRotation, buffer, bufferOffset);
    // Serialize message field [colorCorrectionGains]
    bufferOffset = _arraySerializer.float32(obj.colorCorrectionGains, buffer, bufferOffset, null);
    // Serialize message field [sensitivity]
    bufferOffset = _serializer.int32(obj.sensitivity, buffer, bufferOffset);
    // Serialize message field [rollingShutterSkew]
    bufferOffset = _serializer.int64(obj.rollingShutterSkew, buffer, bufferOffset);
    // Serialize message field [colorCorrectionTransform]
    bufferOffset = _arraySerializer.int32(obj.colorCorrectionTransform, buffer, bufferOffset, null);
    // Serialize message field [frameDuration]
    bufferOffset = _serializer.int32(obj.frameDuration, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AndroidCaptureResult
    let len;
    let data = new AndroidCaptureResult(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [exposureTime]
    data.exposureTime = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [displayRotation]
    data.displayRotation = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [colorCorrectionGains]
    data.colorCorrectionGains = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [sensitivity]
    data.sensitivity = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [rollingShutterSkew]
    data.rollingShutterSkew = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [colorCorrectionTransform]
    data.colorCorrectionTransform = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [frameDuration]
    data.frameDuration = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.colorCorrectionGains.length;
    length += 4 * object.colorCorrectionTransform.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AndroidCaptureResult';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '896962cc0ef44d3d658a8c60bd9f9307';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 exposureTime
    int32 displayRotation
    float32[] colorCorrectionGains
    int32 sensitivity
    int64 rollingShutterSkew
    int32[] colorCorrectionTransform
    int32 frameDuration
    
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
    const resolved = new AndroidCaptureResult(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.exposureTime !== undefined) {
      resolved.exposureTime = msg.exposureTime;
    }
    else {
      resolved.exposureTime = 0
    }

    if (msg.displayRotation !== undefined) {
      resolved.displayRotation = msg.displayRotation;
    }
    else {
      resolved.displayRotation = 0
    }

    if (msg.colorCorrectionGains !== undefined) {
      resolved.colorCorrectionGains = msg.colorCorrectionGains;
    }
    else {
      resolved.colorCorrectionGains = []
    }

    if (msg.sensitivity !== undefined) {
      resolved.sensitivity = msg.sensitivity;
    }
    else {
      resolved.sensitivity = 0
    }

    if (msg.rollingShutterSkew !== undefined) {
      resolved.rollingShutterSkew = msg.rollingShutterSkew;
    }
    else {
      resolved.rollingShutterSkew = 0
    }

    if (msg.colorCorrectionTransform !== undefined) {
      resolved.colorCorrectionTransform = msg.colorCorrectionTransform;
    }
    else {
      resolved.colorCorrectionTransform = []
    }

    if (msg.frameDuration !== undefined) {
      resolved.frameDuration = msg.frameDuration;
    }
    else {
      resolved.frameDuration = 0
    }

    return resolved;
    }
};

module.exports = AndroidCaptureResult;
