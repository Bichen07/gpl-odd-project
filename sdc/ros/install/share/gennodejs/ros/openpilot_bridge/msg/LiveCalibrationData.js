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

class LiveCalibrationData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.warpMatrix2 = null;
      this.warpMatrix = null;
      this.rpyCalib = null;
      this.warpMatrixBig = null;
      this.calCycle = null;
      this.extrinsicMatrix = null;
      this.calPerc = null;
      this.calStatus = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('warpMatrix2')) {
        this.warpMatrix2 = initObj.warpMatrix2
      }
      else {
        this.warpMatrix2 = [];
      }
      if (initObj.hasOwnProperty('warpMatrix')) {
        this.warpMatrix = initObj.warpMatrix
      }
      else {
        this.warpMatrix = [];
      }
      if (initObj.hasOwnProperty('rpyCalib')) {
        this.rpyCalib = initObj.rpyCalib
      }
      else {
        this.rpyCalib = [];
      }
      if (initObj.hasOwnProperty('warpMatrixBig')) {
        this.warpMatrixBig = initObj.warpMatrixBig
      }
      else {
        this.warpMatrixBig = [];
      }
      if (initObj.hasOwnProperty('calCycle')) {
        this.calCycle = initObj.calCycle
      }
      else {
        this.calCycle = 0;
      }
      if (initObj.hasOwnProperty('extrinsicMatrix')) {
        this.extrinsicMatrix = initObj.extrinsicMatrix
      }
      else {
        this.extrinsicMatrix = [];
      }
      if (initObj.hasOwnProperty('calPerc')) {
        this.calPerc = initObj.calPerc
      }
      else {
        this.calPerc = 0;
      }
      if (initObj.hasOwnProperty('calStatus')) {
        this.calStatus = initObj.calStatus
      }
      else {
        this.calStatus = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveCalibrationData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [warpMatrix2]
    bufferOffset = _arraySerializer.float32(obj.warpMatrix2, buffer, bufferOffset, null);
    // Serialize message field [warpMatrix]
    bufferOffset = _arraySerializer.float32(obj.warpMatrix, buffer, bufferOffset, null);
    // Serialize message field [rpyCalib]
    bufferOffset = _arraySerializer.float32(obj.rpyCalib, buffer, bufferOffset, null);
    // Serialize message field [warpMatrixBig]
    bufferOffset = _arraySerializer.float32(obj.warpMatrixBig, buffer, bufferOffset, null);
    // Serialize message field [calCycle]
    bufferOffset = _serializer.int32(obj.calCycle, buffer, bufferOffset);
    // Serialize message field [extrinsicMatrix]
    bufferOffset = _arraySerializer.float32(obj.extrinsicMatrix, buffer, bufferOffset, null);
    // Serialize message field [calPerc]
    bufferOffset = _serializer.int32(obj.calPerc, buffer, bufferOffset);
    // Serialize message field [calStatus]
    bufferOffset = _serializer.int32(obj.calStatus, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveCalibrationData
    let len;
    let data = new LiveCalibrationData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [warpMatrix2]
    data.warpMatrix2 = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [warpMatrix]
    data.warpMatrix = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [rpyCalib]
    data.rpyCalib = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [warpMatrixBig]
    data.warpMatrixBig = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [calCycle]
    data.calCycle = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [extrinsicMatrix]
    data.extrinsicMatrix = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [calPerc]
    data.calPerc = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [calStatus]
    data.calStatus = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.warpMatrix2.length;
    length += 4 * object.warpMatrix.length;
    length += 4 * object.rpyCalib.length;
    length += 4 * object.warpMatrixBig.length;
    length += 4 * object.extrinsicMatrix.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveCalibrationData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'db636023439d7c81d14cf8eb57e5cb27';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] warpMatrix2
    float32[] warpMatrix
    float32[] rpyCalib
    float32[] warpMatrixBig
    int32 calCycle
    float32[] extrinsicMatrix
    int32 calPerc
    int32 calStatus
    
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
    const resolved = new LiveCalibrationData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.warpMatrix2 !== undefined) {
      resolved.warpMatrix2 = msg.warpMatrix2;
    }
    else {
      resolved.warpMatrix2 = []
    }

    if (msg.warpMatrix !== undefined) {
      resolved.warpMatrix = msg.warpMatrix;
    }
    else {
      resolved.warpMatrix = []
    }

    if (msg.rpyCalib !== undefined) {
      resolved.rpyCalib = msg.rpyCalib;
    }
    else {
      resolved.rpyCalib = []
    }

    if (msg.warpMatrixBig !== undefined) {
      resolved.warpMatrixBig = msg.warpMatrixBig;
    }
    else {
      resolved.warpMatrixBig = []
    }

    if (msg.calCycle !== undefined) {
      resolved.calCycle = msg.calCycle;
    }
    else {
      resolved.calCycle = 0
    }

    if (msg.extrinsicMatrix !== undefined) {
      resolved.extrinsicMatrix = msg.extrinsicMatrix;
    }
    else {
      resolved.extrinsicMatrix = []
    }

    if (msg.calPerc !== undefined) {
      resolved.calPerc = msg.calPerc;
    }
    else {
      resolved.calPerc = 0
    }

    if (msg.calStatus !== undefined) {
      resolved.calStatus = msg.calStatus;
    }
    else {
      resolved.calStatus = 0
    }

    return resolved;
    }
};

module.exports = LiveCalibrationData;
