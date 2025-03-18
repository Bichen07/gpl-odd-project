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
let Clock = require('./Clock.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Measurements {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.measurements = null;
      this.clock = null;
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
      if (initObj.hasOwnProperty('clock')) {
        this.clock = initObj.clock
      }
      else {
        this.clock = new Clock();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Measurements
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [measurements]
    // Serialize the length for message field [measurements]
    bufferOffset = _serializer.uint32(obj.measurements.length, buffer, bufferOffset);
    obj.measurements.forEach((val) => {
      bufferOffset = Measurement.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [clock]
    bufferOffset = Clock.serialize(obj.clock, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Measurements
    let len;
    let data = new Measurements(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [measurements]
    // Deserialize array length for message field [measurements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.measurements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.measurements[i] = Measurement.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [clock]
    data.clock = Clock.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.measurements.forEach((val) => {
      length += Measurement.getMessageSize(val);
    });
    length += Clock.getMessageSize(object.clock);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Measurements';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '415db0e73f1e2a0ab9033dcedb4bc3d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    Measurement[] measurements
    Clock clock
    
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
    MSG: openpilot_bridge/Clock
    Header header
    
    bool hasDriftUncertaintyNanosPerSecond
    int32 timeNanos
    float32 driftUncertaintyNanosPerSecond
    bool hasBiasNanos
    float32 timeUncertaintyNanos
    int32 fullBiasNanos
    bool hasLeapSecond
    int32 leapSecond
    bool hasTimeUncertaintyNanos
    int32 hardwareClockDiscontinuityCount
    float32 driftNanosPerSecond
    float32 biasNanos
    bool hasDriftNanosPerSecond
    bool hasFullBiasNanos
    float32 biasUncertaintyNanos
    bool hasBiasUncertaintyNanos
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Measurements(null);
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

    if (msg.clock !== undefined) {
      resolved.clock = Clock.Resolve(msg.clock)
    }
    else {
      resolved.clock = new Clock()
    }

    return resolved;
    }
};

module.exports = Measurements;
