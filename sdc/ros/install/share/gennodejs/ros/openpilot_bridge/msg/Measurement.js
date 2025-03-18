// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TrackingStatus = require('./TrackingStatus.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Measurement {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gnssId = null;
      this.carrierPhaseStdev = null;
      this.pseudorange = null;
      this.doppler = null;
      this.sigId = null;
      this.svId = null;
      this.carrierCycles = null;
      this.dopplerStdev = null;
      this.pseudorangeStdev = null;
      this.cno = null;
      this.locktime = null;
      this.glonassFrequencyIndex = null;
      this.trackingStatus = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gnssId')) {
        this.gnssId = initObj.gnssId
      }
      else {
        this.gnssId = 0;
      }
      if (initObj.hasOwnProperty('carrierPhaseStdev')) {
        this.carrierPhaseStdev = initObj.carrierPhaseStdev
      }
      else {
        this.carrierPhaseStdev = 0.0;
      }
      if (initObj.hasOwnProperty('pseudorange')) {
        this.pseudorange = initObj.pseudorange
      }
      else {
        this.pseudorange = 0.0;
      }
      if (initObj.hasOwnProperty('doppler')) {
        this.doppler = initObj.doppler
      }
      else {
        this.doppler = 0.0;
      }
      if (initObj.hasOwnProperty('sigId')) {
        this.sigId = initObj.sigId
      }
      else {
        this.sigId = 0;
      }
      if (initObj.hasOwnProperty('svId')) {
        this.svId = initObj.svId
      }
      else {
        this.svId = 0;
      }
      if (initObj.hasOwnProperty('carrierCycles')) {
        this.carrierCycles = initObj.carrierCycles
      }
      else {
        this.carrierCycles = 0.0;
      }
      if (initObj.hasOwnProperty('dopplerStdev')) {
        this.dopplerStdev = initObj.dopplerStdev
      }
      else {
        this.dopplerStdev = 0.0;
      }
      if (initObj.hasOwnProperty('pseudorangeStdev')) {
        this.pseudorangeStdev = initObj.pseudorangeStdev
      }
      else {
        this.pseudorangeStdev = 0.0;
      }
      if (initObj.hasOwnProperty('cno')) {
        this.cno = initObj.cno
      }
      else {
        this.cno = 0;
      }
      if (initObj.hasOwnProperty('locktime')) {
        this.locktime = initObj.locktime
      }
      else {
        this.locktime = 0;
      }
      if (initObj.hasOwnProperty('glonassFrequencyIndex')) {
        this.glonassFrequencyIndex = initObj.glonassFrequencyIndex
      }
      else {
        this.glonassFrequencyIndex = 0;
      }
      if (initObj.hasOwnProperty('trackingStatus')) {
        this.trackingStatus = initObj.trackingStatus
      }
      else {
        this.trackingStatus = new TrackingStatus();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Measurement
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gnssId]
    bufferOffset = _serializer.int64(obj.gnssId, buffer, bufferOffset);
    // Serialize message field [carrierPhaseStdev]
    bufferOffset = _serializer.float32(obj.carrierPhaseStdev, buffer, bufferOffset);
    // Serialize message field [pseudorange]
    bufferOffset = _serializer.float32(obj.pseudorange, buffer, bufferOffset);
    // Serialize message field [doppler]
    bufferOffset = _serializer.float32(obj.doppler, buffer, bufferOffset);
    // Serialize message field [sigId]
    bufferOffset = _serializer.int64(obj.sigId, buffer, bufferOffset);
    // Serialize message field [svId]
    bufferOffset = _serializer.int64(obj.svId, buffer, bufferOffset);
    // Serialize message field [carrierCycles]
    bufferOffset = _serializer.float32(obj.carrierCycles, buffer, bufferOffset);
    // Serialize message field [dopplerStdev]
    bufferOffset = _serializer.float32(obj.dopplerStdev, buffer, bufferOffset);
    // Serialize message field [pseudorangeStdev]
    bufferOffset = _serializer.float32(obj.pseudorangeStdev, buffer, bufferOffset);
    // Serialize message field [cno]
    bufferOffset = _serializer.int64(obj.cno, buffer, bufferOffset);
    // Serialize message field [locktime]
    bufferOffset = _serializer.int64(obj.locktime, buffer, bufferOffset);
    // Serialize message field [glonassFrequencyIndex]
    bufferOffset = _serializer.int64(obj.glonassFrequencyIndex, buffer, bufferOffset);
    // Serialize message field [trackingStatus]
    bufferOffset = TrackingStatus.serialize(obj.trackingStatus, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Measurement
    let len;
    let data = new Measurement(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gnssId]
    data.gnssId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [carrierPhaseStdev]
    data.carrierPhaseStdev = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pseudorange]
    data.pseudorange = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [doppler]
    data.doppler = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [sigId]
    data.sigId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [svId]
    data.svId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [carrierCycles]
    data.carrierCycles = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dopplerStdev]
    data.dopplerStdev = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pseudorangeStdev]
    data.pseudorangeStdev = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cno]
    data.cno = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [locktime]
    data.locktime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassFrequencyIndex]
    data.glonassFrequencyIndex = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [trackingStatus]
    data.trackingStatus = TrackingStatus.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += TrackingStatus.getMessageSize(object.trackingStatus);
    return length + 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Measurement';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c6c589e6cee294e9ee81e6cc927ed065';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 gnssId
    float32 carrierPhaseStdev
    float32 pseudorange
    float32 doppler
    int64 sigId
    int64 svId
    float32 carrierCycles
    float32 dopplerStdev
    float32 pseudorangeStdev
    int64 cno
    int64 locktime
    int64 glonassFrequencyIndex
    TrackingStatus trackingStatus
    
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
    MSG: openpilot_bridge/TrackingStatus
    Header header
    
    bool halfCycleSubtracted
    bool carrierPhaseValid
    bool pseudorangeValid
    bool halfCycleValid
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Measurement(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gnssId !== undefined) {
      resolved.gnssId = msg.gnssId;
    }
    else {
      resolved.gnssId = 0
    }

    if (msg.carrierPhaseStdev !== undefined) {
      resolved.carrierPhaseStdev = msg.carrierPhaseStdev;
    }
    else {
      resolved.carrierPhaseStdev = 0.0
    }

    if (msg.pseudorange !== undefined) {
      resolved.pseudorange = msg.pseudorange;
    }
    else {
      resolved.pseudorange = 0.0
    }

    if (msg.doppler !== undefined) {
      resolved.doppler = msg.doppler;
    }
    else {
      resolved.doppler = 0.0
    }

    if (msg.sigId !== undefined) {
      resolved.sigId = msg.sigId;
    }
    else {
      resolved.sigId = 0
    }

    if (msg.svId !== undefined) {
      resolved.svId = msg.svId;
    }
    else {
      resolved.svId = 0
    }

    if (msg.carrierCycles !== undefined) {
      resolved.carrierCycles = msg.carrierCycles;
    }
    else {
      resolved.carrierCycles = 0.0
    }

    if (msg.dopplerStdev !== undefined) {
      resolved.dopplerStdev = msg.dopplerStdev;
    }
    else {
      resolved.dopplerStdev = 0.0
    }

    if (msg.pseudorangeStdev !== undefined) {
      resolved.pseudorangeStdev = msg.pseudorangeStdev;
    }
    else {
      resolved.pseudorangeStdev = 0.0
    }

    if (msg.cno !== undefined) {
      resolved.cno = msg.cno;
    }
    else {
      resolved.cno = 0
    }

    if (msg.locktime !== undefined) {
      resolved.locktime = msg.locktime;
    }
    else {
      resolved.locktime = 0
    }

    if (msg.glonassFrequencyIndex !== undefined) {
      resolved.glonassFrequencyIndex = msg.glonassFrequencyIndex;
    }
    else {
      resolved.glonassFrequencyIndex = 0
    }

    if (msg.trackingStatus !== undefined) {
      resolved.trackingStatus = TrackingStatus.Resolve(msg.trackingStatus)
    }
    else {
      resolved.trackingStatus = new TrackingStatus()
    }

    return resolved;
    }
};

module.exports = Measurement;
