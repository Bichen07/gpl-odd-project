// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SV = require('./SV.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class DrMeasurementReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gpsToGlonassTimeBiasMilliseconds = null;
      this.gpsMilliseconds = null;
      this.seqMax = null;
      this.gpsClockTimeUncertaintyMs = null;
      this.glonassClockSource = null;
      this.glonassTimeBias = null;
      this.gpsClockSource = null;
      this.clockFrequencyBias = null;
      this.source = null;
      this.rfLoss = null;
      this.fCount = null;
      this.gpsTimeBiasMs = null;
      this.clockFrequencyUncertainty = null;
      this.systemRtcTime = null;
      this.seqNum = null;
      this.frequencySource = null;
      this.glonassDay = null;
      this.reason = null;
      this.glonassMilliseconds = null;
      this.clockResets = null;
      this.sv = null;
      this.gpsLeapSeconds = null;
      this.glonassClockTimeUncertainty = null;
      this.gpsWeek = null;
      this.systemRtcValid = null;
      this.gpsToGlonassTimeBiasMillisecondsUncertainty = null;
      this.glonassYear = null;
      this.gpsLeapSecondsUncertainty = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gpsToGlonassTimeBiasMilliseconds')) {
        this.gpsToGlonassTimeBiasMilliseconds = initObj.gpsToGlonassTimeBiasMilliseconds
      }
      else {
        this.gpsToGlonassTimeBiasMilliseconds = 0.0;
      }
      if (initObj.hasOwnProperty('gpsMilliseconds')) {
        this.gpsMilliseconds = initObj.gpsMilliseconds
      }
      else {
        this.gpsMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('seqMax')) {
        this.seqMax = initObj.seqMax
      }
      else {
        this.seqMax = 0;
      }
      if (initObj.hasOwnProperty('gpsClockTimeUncertaintyMs')) {
        this.gpsClockTimeUncertaintyMs = initObj.gpsClockTimeUncertaintyMs
      }
      else {
        this.gpsClockTimeUncertaintyMs = 0;
      }
      if (initObj.hasOwnProperty('glonassClockSource')) {
        this.glonassClockSource = initObj.glonassClockSource
      }
      else {
        this.glonassClockSource = 0;
      }
      if (initObj.hasOwnProperty('glonassTimeBias')) {
        this.glonassTimeBias = initObj.glonassTimeBias
      }
      else {
        this.glonassTimeBias = 0.0;
      }
      if (initObj.hasOwnProperty('gpsClockSource')) {
        this.gpsClockSource = initObj.gpsClockSource
      }
      else {
        this.gpsClockSource = 0;
      }
      if (initObj.hasOwnProperty('clockFrequencyBias')) {
        this.clockFrequencyBias = initObj.clockFrequencyBias
      }
      else {
        this.clockFrequencyBias = 0.0;
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
      if (initObj.hasOwnProperty('rfLoss')) {
        this.rfLoss = initObj.rfLoss
      }
      else {
        this.rfLoss = 0;
      }
      if (initObj.hasOwnProperty('fCount')) {
        this.fCount = initObj.fCount
      }
      else {
        this.fCount = 0;
      }
      if (initObj.hasOwnProperty('gpsTimeBiasMs')) {
        this.gpsTimeBiasMs = initObj.gpsTimeBiasMs
      }
      else {
        this.gpsTimeBiasMs = 0;
      }
      if (initObj.hasOwnProperty('clockFrequencyUncertainty')) {
        this.clockFrequencyUncertainty = initObj.clockFrequencyUncertainty
      }
      else {
        this.clockFrequencyUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('systemRtcTime')) {
        this.systemRtcTime = initObj.systemRtcTime
      }
      else {
        this.systemRtcTime = 0;
      }
      if (initObj.hasOwnProperty('seqNum')) {
        this.seqNum = initObj.seqNum
      }
      else {
        this.seqNum = 0;
      }
      if (initObj.hasOwnProperty('frequencySource')) {
        this.frequencySource = initObj.frequencySource
      }
      else {
        this.frequencySource = 0;
      }
      if (initObj.hasOwnProperty('glonassDay')) {
        this.glonassDay = initObj.glonassDay
      }
      else {
        this.glonassDay = 0;
      }
      if (initObj.hasOwnProperty('reason')) {
        this.reason = initObj.reason
      }
      else {
        this.reason = 0;
      }
      if (initObj.hasOwnProperty('glonassMilliseconds')) {
        this.glonassMilliseconds = initObj.glonassMilliseconds
      }
      else {
        this.glonassMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('clockResets')) {
        this.clockResets = initObj.clockResets
      }
      else {
        this.clockResets = 0;
      }
      if (initObj.hasOwnProperty('sv')) {
        this.sv = initObj.sv
      }
      else {
        this.sv = [];
      }
      if (initObj.hasOwnProperty('gpsLeapSeconds')) {
        this.gpsLeapSeconds = initObj.gpsLeapSeconds
      }
      else {
        this.gpsLeapSeconds = 0;
      }
      if (initObj.hasOwnProperty('glonassClockTimeUncertainty')) {
        this.glonassClockTimeUncertainty = initObj.glonassClockTimeUncertainty
      }
      else {
        this.glonassClockTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0;
      }
      if (initObj.hasOwnProperty('systemRtcValid')) {
        this.systemRtcValid = initObj.systemRtcValid
      }
      else {
        this.systemRtcValid = false;
      }
      if (initObj.hasOwnProperty('gpsToGlonassTimeBiasMillisecondsUncertainty')) {
        this.gpsToGlonassTimeBiasMillisecondsUncertainty = initObj.gpsToGlonassTimeBiasMillisecondsUncertainty
      }
      else {
        this.gpsToGlonassTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('glonassYear')) {
        this.glonassYear = initObj.glonassYear
      }
      else {
        this.glonassYear = 0;
      }
      if (initObj.hasOwnProperty('gpsLeapSecondsUncertainty')) {
        this.gpsLeapSecondsUncertainty = initObj.gpsLeapSecondsUncertainty
      }
      else {
        this.gpsLeapSecondsUncertainty = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DrMeasurementReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gpsToGlonassTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.gpsToGlonassTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [gpsMilliseconds]
    bufferOffset = _serializer.int64(obj.gpsMilliseconds, buffer, bufferOffset);
    // Serialize message field [seqMax]
    bufferOffset = _serializer.int64(obj.seqMax, buffer, bufferOffset);
    // Serialize message field [gpsClockTimeUncertaintyMs]
    bufferOffset = _serializer.int64(obj.gpsClockTimeUncertaintyMs, buffer, bufferOffset);
    // Serialize message field [glonassClockSource]
    bufferOffset = _serializer.int64(obj.glonassClockSource, buffer, bufferOffset);
    // Serialize message field [glonassTimeBias]
    bufferOffset = _serializer.float32(obj.glonassTimeBias, buffer, bufferOffset);
    // Serialize message field [gpsClockSource]
    bufferOffset = _serializer.int64(obj.gpsClockSource, buffer, bufferOffset);
    // Serialize message field [clockFrequencyBias]
    bufferOffset = _serializer.float32(obj.clockFrequencyBias, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.uint32(obj.source, buffer, bufferOffset);
    // Serialize message field [rfLoss]
    bufferOffset = _serializer.int64(obj.rfLoss, buffer, bufferOffset);
    // Serialize message field [fCount]
    bufferOffset = _serializer.int64(obj.fCount, buffer, bufferOffset);
    // Serialize message field [gpsTimeBiasMs]
    bufferOffset = _serializer.int64(obj.gpsTimeBiasMs, buffer, bufferOffset);
    // Serialize message field [clockFrequencyUncertainty]
    bufferOffset = _serializer.float32(obj.clockFrequencyUncertainty, buffer, bufferOffset);
    // Serialize message field [systemRtcTime]
    bufferOffset = _serializer.int64(obj.systemRtcTime, buffer, bufferOffset);
    // Serialize message field [seqNum]
    bufferOffset = _serializer.int64(obj.seqNum, buffer, bufferOffset);
    // Serialize message field [frequencySource]
    bufferOffset = _serializer.int64(obj.frequencySource, buffer, bufferOffset);
    // Serialize message field [glonassDay]
    bufferOffset = _serializer.int64(obj.glonassDay, buffer, bufferOffset);
    // Serialize message field [reason]
    bufferOffset = _serializer.int64(obj.reason, buffer, bufferOffset);
    // Serialize message field [glonassMilliseconds]
    bufferOffset = _serializer.int64(obj.glonassMilliseconds, buffer, bufferOffset);
    // Serialize message field [clockResets]
    bufferOffset = _serializer.int64(obj.clockResets, buffer, bufferOffset);
    // Serialize message field [sv]
    // Serialize the length for message field [sv]
    bufferOffset = _serializer.uint32(obj.sv.length, buffer, bufferOffset);
    obj.sv.forEach((val) => {
      bufferOffset = SV.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [gpsLeapSeconds]
    bufferOffset = _serializer.int64(obj.gpsLeapSeconds, buffer, bufferOffset);
    // Serialize message field [glonassClockTimeUncertainty]
    bufferOffset = _serializer.float32(obj.glonassClockTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.int64(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [systemRtcValid]
    bufferOffset = _serializer.bool(obj.systemRtcValid, buffer, bufferOffset);
    // Serialize message field [gpsToGlonassTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.gpsToGlonassTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [glonassYear]
    bufferOffset = _serializer.int64(obj.glonassYear, buffer, bufferOffset);
    // Serialize message field [gpsLeapSecondsUncertainty]
    bufferOffset = _serializer.int64(obj.gpsLeapSecondsUncertainty, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DrMeasurementReport
    let len;
    let data = new DrMeasurementReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gpsToGlonassTimeBiasMilliseconds]
    data.gpsToGlonassTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsMilliseconds]
    data.gpsMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [seqMax]
    data.seqMax = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsClockTimeUncertaintyMs]
    data.gpsClockTimeUncertaintyMs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassClockSource]
    data.glonassClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassTimeBias]
    data.glonassTimeBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsClockSource]
    data.gpsClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [clockFrequencyBias]
    data.clockFrequencyBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [rfLoss]
    data.rfLoss = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [fCount]
    data.fCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsTimeBiasMs]
    data.gpsTimeBiasMs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [clockFrequencyUncertainty]
    data.clockFrequencyUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [systemRtcTime]
    data.systemRtcTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [seqNum]
    data.seqNum = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [frequencySource]
    data.frequencySource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassDay]
    data.glonassDay = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [reason]
    data.reason = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassMilliseconds]
    data.glonassMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [clockResets]
    data.clockResets = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [sv]
    // Deserialize array length for message field [sv]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.sv = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.sv[i] = SV.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [gpsLeapSeconds]
    data.gpsLeapSeconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassClockTimeUncertainty]
    data.glonassClockTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [systemRtcValid]
    data.systemRtcValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsToGlonassTimeBiasMillisecondsUncertainty]
    data.gpsToGlonassTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [glonassYear]
    data.glonassYear = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsLeapSecondsUncertainty]
    data.gpsLeapSecondsUncertainty = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.sv.forEach((val) => {
      length += SV.getMessageSize(val);
    });
    return length + 185;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/DrMeasurementReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '16e006938fe71bd40015db11503053ce';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 gpsToGlonassTimeBiasMilliseconds
    int64 gpsMilliseconds
    int64 seqMax
    int64 gpsClockTimeUncertaintyMs
    int64 glonassClockSource
    float32 glonassTimeBias
    int64 gpsClockSource
    float32 clockFrequencyBias
    uint32 source # enum const: MeasurementSource
    int64 rfLoss
    int64 fCount
    int64 gpsTimeBiasMs
    float32 clockFrequencyUncertainty
    int64 systemRtcTime
    int64 seqNum
    int64 frequencySource
    int64 glonassDay
    int64 reason
    int64 glonassMilliseconds
    int64 clockResets
    SV[] sv
    int64 gpsLeapSeconds
    float32 glonassClockTimeUncertainty
    int64 gpsWeek
    bool systemRtcValid
    float32 gpsToGlonassTimeBiasMillisecondsUncertainty
    int64 glonassYear
    int64 gpsLeapSecondsUncertainty
    
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
    MSG: openpilot_bridge/SV
    Header header
    
    float32 unfilteredTimeUncertainty
    int64 cycleSlipCount
    int64 unfilteredMeasurementIntegral
    MeasurementStatus measurementStatus
    float32 filteredSpeedUncertainty
    int64 predetectInterval
    float32 unfilteredMeasurementFraction
    float32 filteredTimeUncertainty
    int64 carrierNoise
    int64 postdetections
    int32 latency
    int64 filterStages
    int64 multipathEstimate
    int64 svId
    float32 filteredMeasurementFraction
    int64 rfLoss
    int64 observations
    int64 fCount
    float32 dopplerAcceleration
    float32 elevation
    float32 filteredSpeed
    float32 fineSpeed
    int64 goodObservations
    uint32 observationState # enum const: SVObservationState
    bool goodParity
    float32 carrierPhase
    int64 filteredMeasurementIntegral
    int64 parityErrorCount
    float32 unfilteredSpeedUncertainty
    float32 fineSpeedUncertainty
    float32 azimuth
    float32 unfilteredSpeed
    int32 glonassFrequencyIndex
    
    ================================================================================
    MSG: openpilot_bridge/MeasurementStatus
    Header header
    
    bool glonassTimeMarkValid
    bool lockPointValid
    bool imdJammingIndicator
    bool measuredVelocity
    bool fineOrCoarseVelocity
    bool gpsHighBandwidthNu4
    bool gpsRxDiversity
    bool gpsHighBandwidthUniform
    bool gpsHighBandwidthNu8
    bool subMillisecondIsValid
    bool lastUpdateFromDifference
    bool tentativeMeasurement
    bool probationMode
    bool directionIsValid
    bool bitEdgeConfirmedFromSignal
    bool gpsRoundRobinRxDiversity
    bool freshMeasurementIndicator
    bool lteB13TxJammingIndicator
    bool lastUpdateFromVelocityDifference
    bool measurementNotUsable
    bool glonassMeanderBitEdgeValid
    bool gpsLowBandwidthRxDiversityCombined
    bool satelliteTimeIsKnown
    bool strongIndicationOfCrossCorelation
    bool subBitTimeIsKnown
    bool lockPointPositive
    bool multipathIndicator
    bool sirCheckIsNeeded
    bool multipathEstimateIsValid
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DrMeasurementReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gpsToGlonassTimeBiasMilliseconds !== undefined) {
      resolved.gpsToGlonassTimeBiasMilliseconds = msg.gpsToGlonassTimeBiasMilliseconds;
    }
    else {
      resolved.gpsToGlonassTimeBiasMilliseconds = 0.0
    }

    if (msg.gpsMilliseconds !== undefined) {
      resolved.gpsMilliseconds = msg.gpsMilliseconds;
    }
    else {
      resolved.gpsMilliseconds = 0
    }

    if (msg.seqMax !== undefined) {
      resolved.seqMax = msg.seqMax;
    }
    else {
      resolved.seqMax = 0
    }

    if (msg.gpsClockTimeUncertaintyMs !== undefined) {
      resolved.gpsClockTimeUncertaintyMs = msg.gpsClockTimeUncertaintyMs;
    }
    else {
      resolved.gpsClockTimeUncertaintyMs = 0
    }

    if (msg.glonassClockSource !== undefined) {
      resolved.glonassClockSource = msg.glonassClockSource;
    }
    else {
      resolved.glonassClockSource = 0
    }

    if (msg.glonassTimeBias !== undefined) {
      resolved.glonassTimeBias = msg.glonassTimeBias;
    }
    else {
      resolved.glonassTimeBias = 0.0
    }

    if (msg.gpsClockSource !== undefined) {
      resolved.gpsClockSource = msg.gpsClockSource;
    }
    else {
      resolved.gpsClockSource = 0
    }

    if (msg.clockFrequencyBias !== undefined) {
      resolved.clockFrequencyBias = msg.clockFrequencyBias;
    }
    else {
      resolved.clockFrequencyBias = 0.0
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    if (msg.rfLoss !== undefined) {
      resolved.rfLoss = msg.rfLoss;
    }
    else {
      resolved.rfLoss = 0
    }

    if (msg.fCount !== undefined) {
      resolved.fCount = msg.fCount;
    }
    else {
      resolved.fCount = 0
    }

    if (msg.gpsTimeBiasMs !== undefined) {
      resolved.gpsTimeBiasMs = msg.gpsTimeBiasMs;
    }
    else {
      resolved.gpsTimeBiasMs = 0
    }

    if (msg.clockFrequencyUncertainty !== undefined) {
      resolved.clockFrequencyUncertainty = msg.clockFrequencyUncertainty;
    }
    else {
      resolved.clockFrequencyUncertainty = 0.0
    }

    if (msg.systemRtcTime !== undefined) {
      resolved.systemRtcTime = msg.systemRtcTime;
    }
    else {
      resolved.systemRtcTime = 0
    }

    if (msg.seqNum !== undefined) {
      resolved.seqNum = msg.seqNum;
    }
    else {
      resolved.seqNum = 0
    }

    if (msg.frequencySource !== undefined) {
      resolved.frequencySource = msg.frequencySource;
    }
    else {
      resolved.frequencySource = 0
    }

    if (msg.glonassDay !== undefined) {
      resolved.glonassDay = msg.glonassDay;
    }
    else {
      resolved.glonassDay = 0
    }

    if (msg.reason !== undefined) {
      resolved.reason = msg.reason;
    }
    else {
      resolved.reason = 0
    }

    if (msg.glonassMilliseconds !== undefined) {
      resolved.glonassMilliseconds = msg.glonassMilliseconds;
    }
    else {
      resolved.glonassMilliseconds = 0
    }

    if (msg.clockResets !== undefined) {
      resolved.clockResets = msg.clockResets;
    }
    else {
      resolved.clockResets = 0
    }

    if (msg.sv !== undefined) {
      resolved.sv = new Array(msg.sv.length);
      for (let i = 0; i < resolved.sv.length; ++i) {
        resolved.sv[i] = SV.Resolve(msg.sv[i]);
      }
    }
    else {
      resolved.sv = []
    }

    if (msg.gpsLeapSeconds !== undefined) {
      resolved.gpsLeapSeconds = msg.gpsLeapSeconds;
    }
    else {
      resolved.gpsLeapSeconds = 0
    }

    if (msg.glonassClockTimeUncertainty !== undefined) {
      resolved.glonassClockTimeUncertainty = msg.glonassClockTimeUncertainty;
    }
    else {
      resolved.glonassClockTimeUncertainty = 0.0
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0
    }

    if (msg.systemRtcValid !== undefined) {
      resolved.systemRtcValid = msg.systemRtcValid;
    }
    else {
      resolved.systemRtcValid = false
    }

    if (msg.gpsToGlonassTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.gpsToGlonassTimeBiasMillisecondsUncertainty = msg.gpsToGlonassTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.gpsToGlonassTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.glonassYear !== undefined) {
      resolved.glonassYear = msg.glonassYear;
    }
    else {
      resolved.glonassYear = 0
    }

    if (msg.gpsLeapSecondsUncertainty !== undefined) {
      resolved.gpsLeapSecondsUncertainty = msg.gpsLeapSecondsUncertainty;
    }
    else {
      resolved.gpsLeapSecondsUncertainty = 0
    }

    return resolved;
    }
};

module.exports = DrMeasurementReport;
