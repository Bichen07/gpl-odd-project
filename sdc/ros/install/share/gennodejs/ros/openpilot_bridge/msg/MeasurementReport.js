// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Measurement = require('./Measurement.js');
let ReceiverStatus = require('./ReceiverStatus.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MeasurementReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.measurements = null;
      this.gpsWeek = null;
      this.numMeas = null;
      this.receiverStatus = null;
      this.leapSeconds = null;
      this.rcvTow = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('measurements')) {
        this.measurements = initObj.measurements
      }
      else {
        this.measurements = [];
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0;
      }
      if (initObj.hasOwnProperty('numMeas')) {
        this.numMeas = initObj.numMeas
      }
      else {
        this.numMeas = 0;
      }
      if (initObj.hasOwnProperty('receiverStatus')) {
        this.receiverStatus = initObj.receiverStatus
      }
      else {
        this.receiverStatus = new ReceiverStatus();
      }
      if (initObj.hasOwnProperty('leapSeconds')) {
        this.leapSeconds = initObj.leapSeconds
      }
      else {
        this.leapSeconds = 0;
      }
      if (initObj.hasOwnProperty('rcvTow')) {
        this.rcvTow = initObj.rcvTow
      }
      else {
        this.rcvTow = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MeasurementReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [measurements]
    // Serialize the length for message field [measurements]
    bufferOffset = _serializer.uint32(obj.measurements.length, buffer, bufferOffset);
    obj.measurements.forEach((val) => {
      bufferOffset = Measurement.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.int64(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [numMeas]
    bufferOffset = _serializer.int64(obj.numMeas, buffer, bufferOffset);
    // Serialize message field [receiverStatus]
    bufferOffset = ReceiverStatus.serialize(obj.receiverStatus, buffer, bufferOffset);
    // Serialize message field [leapSeconds]
    bufferOffset = _serializer.int64(obj.leapSeconds, buffer, bufferOffset);
    // Serialize message field [rcvTow]
    bufferOffset = _serializer.float32(obj.rcvTow, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MeasurementReport
    let len;
    let data = new MeasurementReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [measurements]
    // Deserialize array length for message field [measurements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.measurements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.measurements[i] = Measurement.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [numMeas]
    data.numMeas = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [receiverStatus]
    data.receiverStatus = ReceiverStatus.deserialize(buffer, bufferOffset);
    // Deserialize message field [leapSeconds]
    data.leapSeconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [rcvTow]
    data.rcvTow = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.measurements.forEach((val) => {
      length += Measurement.getMessageSize(val);
    });
    length += ReceiverStatus.getMessageSize(object.receiverStatus);
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/MeasurementReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '72031e9f3d08f0e106b815c0c5630a15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    Measurement[] measurements
    int64 gpsWeek
    int64 numMeas
    ReceiverStatus receiverStatus
    int64 leapSeconds
    float32 rcvTow
    
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
    MSG: openpilot_bridge/Measurement
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
    MSG: openpilot_bridge/TrackingStatus
    Header header
    
    bool halfCycleSubtracted
    bool carrierPhaseValid
    bool pseudorangeValid
    bool halfCycleValid
    
    ================================================================================
    MSG: openpilot_bridge/ReceiverStatus
    Header header
    
    bool leapSecValid
    bool clkReset
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MeasurementReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.measurements !== undefined) {
      resolved.measurements = new Array(msg.measurements.length);
      for (let i = 0; i < resolved.measurements.length; ++i) {
        resolved.measurements[i] = Measurement.Resolve(msg.measurements[i]);
      }
    }
    else {
      resolved.measurements = []
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0
    }

    if (msg.numMeas !== undefined) {
      resolved.numMeas = msg.numMeas;
    }
    else {
      resolved.numMeas = 0
    }

    if (msg.receiverStatus !== undefined) {
      resolved.receiverStatus = ReceiverStatus.Resolve(msg.receiverStatus)
    }
    else {
      resolved.receiverStatus = new ReceiverStatus()
    }

    if (msg.leapSeconds !== undefined) {
      resolved.leapSeconds = msg.leapSeconds;
    }
    else {
      resolved.leapSeconds = 0
    }

    if (msg.rcvTow !== undefined) {
      resolved.rcvTow = msg.rcvTow;
    }
    else {
      resolved.rcvTow = 0.0
    }

    return resolved;
    }
};

module.exports = MeasurementReport;
