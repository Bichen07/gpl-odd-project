// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let NavigationMessage = require('./NavigationMessage.js');
let Measurements = require('./Measurements.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class AndroidGnss {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.navigationMessage = null;
      this.measurements = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('navigationMessage')) {
        this.navigationMessage = initObj.navigationMessage
      }
      else {
        this.navigationMessage = new NavigationMessage();
      }
      if (initObj.hasOwnProperty('measurements')) {
        this.measurements = initObj.measurements
      }
      else {
        this.measurements = new Measurements();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AndroidGnss
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [navigationMessage]
    bufferOffset = NavigationMessage.serialize(obj.navigationMessage, buffer, bufferOffset);
    // Serialize message field [measurements]
    bufferOffset = Measurements.serialize(obj.measurements, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AndroidGnss
    let len;
    let data = new AndroidGnss(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [navigationMessage]
    data.navigationMessage = NavigationMessage.deserialize(buffer, bufferOffset);
    // Deserialize message field [measurements]
    data.measurements = Measurements.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += NavigationMessage.getMessageSize(object.navigationMessage);
    length += Measurements.getMessageSize(object.measurements);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AndroidGnss';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b7e8e88d266ebdcdd6f44e7888ccfd09';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    NavigationMessage navigationMessage
    Measurements measurements
    
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
    MSG: openpilot_bridge/NavigationMessage
    Header header
    
    uint32 status # enum const: Status
    string[] data
    int32 svId
    int32 messageId
    int32 submessageId
    int32 type
    
    ================================================================================
    MSG: openpilot_bridge/Measurements
    Header header
    
    Measurement[] measurements
    Clock clock
    
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
    const resolved = new AndroidGnss(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.navigationMessage !== undefined) {
      resolved.navigationMessage = NavigationMessage.Resolve(msg.navigationMessage)
    }
    else {
      resolved.navigationMessage = new NavigationMessage()
    }

    if (msg.measurements !== undefined) {
      resolved.measurements = Measurements.Resolve(msg.measurements)
    }
    else {
      resolved.measurements = new Measurements()
    }

    return resolved;
    }
};

module.exports = AndroidGnss;
