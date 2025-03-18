// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let MeasurementReport = require('./MeasurementReport.js');
let DrSvPolyReport = require('./DrSvPolyReport.js');
let ClockReport = require('./ClockReport.js');
let DrMeasurementReport = require('./DrMeasurementReport.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class QcomGnss {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rawLog = null;
      this.measurementReport = null;
      this.logTs = null;
      this.drSvPoly = null;
      this.clockReport = null;
      this.drMeasurementReport = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rawLog')) {
        this.rawLog = initObj.rawLog
      }
      else {
        this.rawLog = [];
      }
      if (initObj.hasOwnProperty('measurementReport')) {
        this.measurementReport = initObj.measurementReport
      }
      else {
        this.measurementReport = new MeasurementReport();
      }
      if (initObj.hasOwnProperty('logTs')) {
        this.logTs = initObj.logTs
      }
      else {
        this.logTs = 0;
      }
      if (initObj.hasOwnProperty('drSvPoly')) {
        this.drSvPoly = initObj.drSvPoly
      }
      else {
        this.drSvPoly = new DrSvPolyReport();
      }
      if (initObj.hasOwnProperty('clockReport')) {
        this.clockReport = initObj.clockReport
      }
      else {
        this.clockReport = new ClockReport();
      }
      if (initObj.hasOwnProperty('drMeasurementReport')) {
        this.drMeasurementReport = initObj.drMeasurementReport
      }
      else {
        this.drMeasurementReport = new DrMeasurementReport();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type QcomGnss
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rawLog]
    bufferOffset = _arraySerializer.string(obj.rawLog, buffer, bufferOffset, null);
    // Serialize message field [measurementReport]
    bufferOffset = MeasurementReport.serialize(obj.measurementReport, buffer, bufferOffset);
    // Serialize message field [logTs]
    bufferOffset = _serializer.int64(obj.logTs, buffer, bufferOffset);
    // Serialize message field [drSvPoly]
    bufferOffset = DrSvPolyReport.serialize(obj.drSvPoly, buffer, bufferOffset);
    // Serialize message field [clockReport]
    bufferOffset = ClockReport.serialize(obj.clockReport, buffer, bufferOffset);
    // Serialize message field [drMeasurementReport]
    bufferOffset = DrMeasurementReport.serialize(obj.drMeasurementReport, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type QcomGnss
    let len;
    let data = new QcomGnss(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rawLog]
    data.rawLog = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [measurementReport]
    data.measurementReport = MeasurementReport.deserialize(buffer, bufferOffset);
    // Deserialize message field [logTs]
    data.logTs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [drSvPoly]
    data.drSvPoly = DrSvPolyReport.deserialize(buffer, bufferOffset);
    // Deserialize message field [clockReport]
    data.clockReport = ClockReport.deserialize(buffer, bufferOffset);
    // Deserialize message field [drMeasurementReport]
    data.drMeasurementReport = DrMeasurementReport.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.rawLog.forEach((val) => {
      length += 4 + val.length;
    });
    length += MeasurementReport.getMessageSize(object.measurementReport);
    length += DrSvPolyReport.getMessageSize(object.drSvPoly);
    length += ClockReport.getMessageSize(object.clockReport);
    length += DrMeasurementReport.getMessageSize(object.drMeasurementReport);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/QcomGnss';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bb37eb2c5e7693de7d76101f66f26778';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    string[] rawLog
    MeasurementReport measurementReport
    int64 logTs
    DrSvPolyReport drSvPoly
    ClockReport clockReport
    DrMeasurementReport drMeasurementReport
    
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
    MSG: openpilot_bridge/MeasurementReport
    Header header
    
    Measurement[] measurements
    int64 gpsWeek
    int64 numMeas
    ReceiverStatus receiverStatus
    int64 leapSeconds
    float32 rcvTow
    
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
    
    ================================================================================
    MSG: openpilot_bridge/DrSvPolyReport
    Header header
    
    float32[] xyzN
    bool hasSbasIono
    float32 positionUncertainty
    int64 svId
    float32 elevationUncertainty
    bool polyFromXtra
    float32[] other
    float32 ionoDot
    bool hasIono
    int32 frequencyIndex
    float32[] velocityCoeff
    float32 elevation
    float32 ionoDelay
    float32 sbasIonoDelay
    bool hasPosition
    bool hasElevation
    int64 iode
    float32 elevationDot
    float32 t0
    float32[] xyz0
    bool hasTropo
    float32 tropoDelay
    float32 sbasIonoDot
    
    ================================================================================
    MSG: openpilot_bridge/ClockReport
    Header header
    
    float32 galToBdsTimeBiasMillisecondsUncertainty
    bool hasFCount
    int64 bdsClockSource
    float32 clockFrequencyUncertainty
    int64 gpsMilliseconds
    bool hasGpsWeek
    float32 gpsToGlonassTimeBiasMilliseconds
    int64 galWeek
    int64 bdsMilliseconds
    float32 gpsToGalTimeBiasMilliseconds
    float32 glonassTimeBias
    int64 gpsClockSource
    float32 bdsClockTimeUncertainty
    float32 gpsToBdsTimeBiasMillisecondsUncertainty
    int64 glonassYear
    float32 galToGloTimeBiasMilliseconds
    int64 galMilliseconds
    float32 galToGloTimeBiasMillisecondsUncertainty
    float32 clockFrequencyBias
    int64 fCount
    int64 gpsLeapSeconds
    bool hasRtcTime
    int64 bdsWeek
    float32 glonassClockTimeUncertainty
    bool hasGlonassMilliseconds
    int64 systemRtcTime
    float32 bdsTimeBias
    int64 frequencySource
    int64 glonassDay
    bool hasGlonassDay
    float32 gpsToGalTimeBiasMillisecondsUncertainty
    float32 galTimeBias
    float32 galClockTimeUncertainty
    float32 gpsTimeBias
    int64 lpmRtcCount
    int64 glonassMilliseconds
    int64 fCountOffset
    float32 bdsToGloTimeBiasMilliseconds
    int64 clockResets
    int64 gpsLeapSecondsSource
    int64 galClockSource
    bool hasGpsMilliseconds
    float32 gpsToBdsTimeBiasMilliseconds
    int64 gpsWeek
    float32 gpsClockTimeUncertainty
    float32 bdsToGloTimeBiasMillisecondsUncertainty
    bool hasGlonassYear
    float32 gpsToGlonassTimeBiasMillisecondsUncertainty
    int64 glonassClockSource
    float32 galToBdsTimeBiasMilliseconds
    int64 gpsLeapSecondsUncertainty
    
    ================================================================================
    MSG: openpilot_bridge/DrMeasurementReport
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
    const resolved = new QcomGnss(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rawLog !== undefined) {
      resolved.rawLog = msg.rawLog;
    }
    else {
      resolved.rawLog = []
    }

    if (msg.measurementReport !== undefined) {
      resolved.measurementReport = MeasurementReport.Resolve(msg.measurementReport)
    }
    else {
      resolved.measurementReport = new MeasurementReport()
    }

    if (msg.logTs !== undefined) {
      resolved.logTs = msg.logTs;
    }
    else {
      resolved.logTs = 0
    }

    if (msg.drSvPoly !== undefined) {
      resolved.drSvPoly = DrSvPolyReport.Resolve(msg.drSvPoly)
    }
    else {
      resolved.drSvPoly = new DrSvPolyReport()
    }

    if (msg.clockReport !== undefined) {
      resolved.clockReport = ClockReport.Resolve(msg.clockReport)
    }
    else {
      resolved.clockReport = new ClockReport()
    }

    if (msg.drMeasurementReport !== undefined) {
      resolved.drMeasurementReport = DrMeasurementReport.Resolve(msg.drMeasurementReport)
    }
    else {
      resolved.drMeasurementReport = new DrMeasurementReport()
    }

    return resolved;
    }
};

module.exports = QcomGnss;
