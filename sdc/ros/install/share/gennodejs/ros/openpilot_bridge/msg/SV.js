// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let MeasurementStatus = require('./MeasurementStatus.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class SV {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.unfilteredTimeUncertainty = null;
      this.cycleSlipCount = null;
      this.unfilteredMeasurementIntegral = null;
      this.measurementStatus = null;
      this.filteredSpeedUncertainty = null;
      this.predetectInterval = null;
      this.unfilteredMeasurementFraction = null;
      this.filteredTimeUncertainty = null;
      this.carrierNoise = null;
      this.postdetections = null;
      this.latency = null;
      this.filterStages = null;
      this.multipathEstimate = null;
      this.svId = null;
      this.filteredMeasurementFraction = null;
      this.rfLoss = null;
      this.observations = null;
      this.fCount = null;
      this.dopplerAcceleration = null;
      this.elevation = null;
      this.filteredSpeed = null;
      this.fineSpeed = null;
      this.goodObservations = null;
      this.observationState = null;
      this.goodParity = null;
      this.carrierPhase = null;
      this.filteredMeasurementIntegral = null;
      this.parityErrorCount = null;
      this.unfilteredSpeedUncertainty = null;
      this.fineSpeedUncertainty = null;
      this.azimuth = null;
      this.unfilteredSpeed = null;
      this.glonassFrequencyIndex = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('unfilteredTimeUncertainty')) {
        this.unfilteredTimeUncertainty = initObj.unfilteredTimeUncertainty
      }
      else {
        this.unfilteredTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('cycleSlipCount')) {
        this.cycleSlipCount = initObj.cycleSlipCount
      }
      else {
        this.cycleSlipCount = 0;
      }
      if (initObj.hasOwnProperty('unfilteredMeasurementIntegral')) {
        this.unfilteredMeasurementIntegral = initObj.unfilteredMeasurementIntegral
      }
      else {
        this.unfilteredMeasurementIntegral = 0;
      }
      if (initObj.hasOwnProperty('measurementStatus')) {
        this.measurementStatus = initObj.measurementStatus
      }
      else {
        this.measurementStatus = new MeasurementStatus();
      }
      if (initObj.hasOwnProperty('filteredSpeedUncertainty')) {
        this.filteredSpeedUncertainty = initObj.filteredSpeedUncertainty
      }
      else {
        this.filteredSpeedUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('predetectInterval')) {
        this.predetectInterval = initObj.predetectInterval
      }
      else {
        this.predetectInterval = 0;
      }
      if (initObj.hasOwnProperty('unfilteredMeasurementFraction')) {
        this.unfilteredMeasurementFraction = initObj.unfilteredMeasurementFraction
      }
      else {
        this.unfilteredMeasurementFraction = 0.0;
      }
      if (initObj.hasOwnProperty('filteredTimeUncertainty')) {
        this.filteredTimeUncertainty = initObj.filteredTimeUncertainty
      }
      else {
        this.filteredTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('carrierNoise')) {
        this.carrierNoise = initObj.carrierNoise
      }
      else {
        this.carrierNoise = 0;
      }
      if (initObj.hasOwnProperty('postdetections')) {
        this.postdetections = initObj.postdetections
      }
      else {
        this.postdetections = 0;
      }
      if (initObj.hasOwnProperty('latency')) {
        this.latency = initObj.latency
      }
      else {
        this.latency = 0;
      }
      if (initObj.hasOwnProperty('filterStages')) {
        this.filterStages = initObj.filterStages
      }
      else {
        this.filterStages = 0;
      }
      if (initObj.hasOwnProperty('multipathEstimate')) {
        this.multipathEstimate = initObj.multipathEstimate
      }
      else {
        this.multipathEstimate = 0;
      }
      if (initObj.hasOwnProperty('svId')) {
        this.svId = initObj.svId
      }
      else {
        this.svId = 0;
      }
      if (initObj.hasOwnProperty('filteredMeasurementFraction')) {
        this.filteredMeasurementFraction = initObj.filteredMeasurementFraction
      }
      else {
        this.filteredMeasurementFraction = 0.0;
      }
      if (initObj.hasOwnProperty('rfLoss')) {
        this.rfLoss = initObj.rfLoss
      }
      else {
        this.rfLoss = 0;
      }
      if (initObj.hasOwnProperty('observations')) {
        this.observations = initObj.observations
      }
      else {
        this.observations = 0;
      }
      if (initObj.hasOwnProperty('fCount')) {
        this.fCount = initObj.fCount
      }
      else {
        this.fCount = 0;
      }
      if (initObj.hasOwnProperty('dopplerAcceleration')) {
        this.dopplerAcceleration = initObj.dopplerAcceleration
      }
      else {
        this.dopplerAcceleration = 0.0;
      }
      if (initObj.hasOwnProperty('elevation')) {
        this.elevation = initObj.elevation
      }
      else {
        this.elevation = 0.0;
      }
      if (initObj.hasOwnProperty('filteredSpeed')) {
        this.filteredSpeed = initObj.filteredSpeed
      }
      else {
        this.filteredSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('fineSpeed')) {
        this.fineSpeed = initObj.fineSpeed
      }
      else {
        this.fineSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('goodObservations')) {
        this.goodObservations = initObj.goodObservations
      }
      else {
        this.goodObservations = 0;
      }
      if (initObj.hasOwnProperty('observationState')) {
        this.observationState = initObj.observationState
      }
      else {
        this.observationState = 0;
      }
      if (initObj.hasOwnProperty('goodParity')) {
        this.goodParity = initObj.goodParity
      }
      else {
        this.goodParity = false;
      }
      if (initObj.hasOwnProperty('carrierPhase')) {
        this.carrierPhase = initObj.carrierPhase
      }
      else {
        this.carrierPhase = 0.0;
      }
      if (initObj.hasOwnProperty('filteredMeasurementIntegral')) {
        this.filteredMeasurementIntegral = initObj.filteredMeasurementIntegral
      }
      else {
        this.filteredMeasurementIntegral = 0;
      }
      if (initObj.hasOwnProperty('parityErrorCount')) {
        this.parityErrorCount = initObj.parityErrorCount
      }
      else {
        this.parityErrorCount = 0;
      }
      if (initObj.hasOwnProperty('unfilteredSpeedUncertainty')) {
        this.unfilteredSpeedUncertainty = initObj.unfilteredSpeedUncertainty
      }
      else {
        this.unfilteredSpeedUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('fineSpeedUncertainty')) {
        this.fineSpeedUncertainty = initObj.fineSpeedUncertainty
      }
      else {
        this.fineSpeedUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('azimuth')) {
        this.azimuth = initObj.azimuth
      }
      else {
        this.azimuth = 0.0;
      }
      if (initObj.hasOwnProperty('unfilteredSpeed')) {
        this.unfilteredSpeed = initObj.unfilteredSpeed
      }
      else {
        this.unfilteredSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('glonassFrequencyIndex')) {
        this.glonassFrequencyIndex = initObj.glonassFrequencyIndex
      }
      else {
        this.glonassFrequencyIndex = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SV
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [unfilteredTimeUncertainty]
    bufferOffset = _serializer.float32(obj.unfilteredTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [cycleSlipCount]
    bufferOffset = _serializer.int64(obj.cycleSlipCount, buffer, bufferOffset);
    // Serialize message field [unfilteredMeasurementIntegral]
    bufferOffset = _serializer.int64(obj.unfilteredMeasurementIntegral, buffer, bufferOffset);
    // Serialize message field [measurementStatus]
    bufferOffset = MeasurementStatus.serialize(obj.measurementStatus, buffer, bufferOffset);
    // Serialize message field [filteredSpeedUncertainty]
    bufferOffset = _serializer.float32(obj.filteredSpeedUncertainty, buffer, bufferOffset);
    // Serialize message field [predetectInterval]
    bufferOffset = _serializer.int64(obj.predetectInterval, buffer, bufferOffset);
    // Serialize message field [unfilteredMeasurementFraction]
    bufferOffset = _serializer.float32(obj.unfilteredMeasurementFraction, buffer, bufferOffset);
    // Serialize message field [filteredTimeUncertainty]
    bufferOffset = _serializer.float32(obj.filteredTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [carrierNoise]
    bufferOffset = _serializer.int64(obj.carrierNoise, buffer, bufferOffset);
    // Serialize message field [postdetections]
    bufferOffset = _serializer.int64(obj.postdetections, buffer, bufferOffset);
    // Serialize message field [latency]
    bufferOffset = _serializer.int32(obj.latency, buffer, bufferOffset);
    // Serialize message field [filterStages]
    bufferOffset = _serializer.int64(obj.filterStages, buffer, bufferOffset);
    // Serialize message field [multipathEstimate]
    bufferOffset = _serializer.int64(obj.multipathEstimate, buffer, bufferOffset);
    // Serialize message field [svId]
    bufferOffset = _serializer.int64(obj.svId, buffer, bufferOffset);
    // Serialize message field [filteredMeasurementFraction]
    bufferOffset = _serializer.float32(obj.filteredMeasurementFraction, buffer, bufferOffset);
    // Serialize message field [rfLoss]
    bufferOffset = _serializer.int64(obj.rfLoss, buffer, bufferOffset);
    // Serialize message field [observations]
    bufferOffset = _serializer.int64(obj.observations, buffer, bufferOffset);
    // Serialize message field [fCount]
    bufferOffset = _serializer.int64(obj.fCount, buffer, bufferOffset);
    // Serialize message field [dopplerAcceleration]
    bufferOffset = _serializer.float32(obj.dopplerAcceleration, buffer, bufferOffset);
    // Serialize message field [elevation]
    bufferOffset = _serializer.float32(obj.elevation, buffer, bufferOffset);
    // Serialize message field [filteredSpeed]
    bufferOffset = _serializer.float32(obj.filteredSpeed, buffer, bufferOffset);
    // Serialize message field [fineSpeed]
    bufferOffset = _serializer.float32(obj.fineSpeed, buffer, bufferOffset);
    // Serialize message field [goodObservations]
    bufferOffset = _serializer.int64(obj.goodObservations, buffer, bufferOffset);
    // Serialize message field [observationState]
    bufferOffset = _serializer.uint32(obj.observationState, buffer, bufferOffset);
    // Serialize message field [goodParity]
    bufferOffset = _serializer.bool(obj.goodParity, buffer, bufferOffset);
    // Serialize message field [carrierPhase]
    bufferOffset = _serializer.float32(obj.carrierPhase, buffer, bufferOffset);
    // Serialize message field [filteredMeasurementIntegral]
    bufferOffset = _serializer.int64(obj.filteredMeasurementIntegral, buffer, bufferOffset);
    // Serialize message field [parityErrorCount]
    bufferOffset = _serializer.int64(obj.parityErrorCount, buffer, bufferOffset);
    // Serialize message field [unfilteredSpeedUncertainty]
    bufferOffset = _serializer.float32(obj.unfilteredSpeedUncertainty, buffer, bufferOffset);
    // Serialize message field [fineSpeedUncertainty]
    bufferOffset = _serializer.float32(obj.fineSpeedUncertainty, buffer, bufferOffset);
    // Serialize message field [azimuth]
    bufferOffset = _serializer.float32(obj.azimuth, buffer, bufferOffset);
    // Serialize message field [unfilteredSpeed]
    bufferOffset = _serializer.float32(obj.unfilteredSpeed, buffer, bufferOffset);
    // Serialize message field [glonassFrequencyIndex]
    bufferOffset = _serializer.int32(obj.glonassFrequencyIndex, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SV
    let len;
    let data = new SV(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [unfilteredTimeUncertainty]
    data.unfilteredTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cycleSlipCount]
    data.cycleSlipCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [unfilteredMeasurementIntegral]
    data.unfilteredMeasurementIntegral = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [measurementStatus]
    data.measurementStatus = MeasurementStatus.deserialize(buffer, bufferOffset);
    // Deserialize message field [filteredSpeedUncertainty]
    data.filteredSpeedUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [predetectInterval]
    data.predetectInterval = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [unfilteredMeasurementFraction]
    data.unfilteredMeasurementFraction = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [filteredTimeUncertainty]
    data.filteredTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [carrierNoise]
    data.carrierNoise = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [postdetections]
    data.postdetections = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [latency]
    data.latency = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [filterStages]
    data.filterStages = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [multipathEstimate]
    data.multipathEstimate = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [svId]
    data.svId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [filteredMeasurementFraction]
    data.filteredMeasurementFraction = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rfLoss]
    data.rfLoss = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [observations]
    data.observations = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [fCount]
    data.fCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [dopplerAcceleration]
    data.dopplerAcceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [elevation]
    data.elevation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [filteredSpeed]
    data.filteredSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fineSpeed]
    data.fineSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [goodObservations]
    data.goodObservations = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [observationState]
    data.observationState = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [goodParity]
    data.goodParity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [carrierPhase]
    data.carrierPhase = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [filteredMeasurementIntegral]
    data.filteredMeasurementIntegral = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [parityErrorCount]
    data.parityErrorCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [unfilteredSpeedUncertainty]
    data.unfilteredSpeedUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fineSpeedUncertainty]
    data.fineSpeedUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [azimuth]
    data.azimuth = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [unfilteredSpeed]
    data.unfilteredSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [glonassFrequencyIndex]
    data.glonassFrequencyIndex = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += MeasurementStatus.getMessageSize(object.measurementStatus);
    return length + 181;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SV';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c2b444a1bc5918386f94442af6fb62e1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new SV(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.unfilteredTimeUncertainty !== undefined) {
      resolved.unfilteredTimeUncertainty = msg.unfilteredTimeUncertainty;
    }
    else {
      resolved.unfilteredTimeUncertainty = 0.0
    }

    if (msg.cycleSlipCount !== undefined) {
      resolved.cycleSlipCount = msg.cycleSlipCount;
    }
    else {
      resolved.cycleSlipCount = 0
    }

    if (msg.unfilteredMeasurementIntegral !== undefined) {
      resolved.unfilteredMeasurementIntegral = msg.unfilteredMeasurementIntegral;
    }
    else {
      resolved.unfilteredMeasurementIntegral = 0
    }

    if (msg.measurementStatus !== undefined) {
      resolved.measurementStatus = MeasurementStatus.Resolve(msg.measurementStatus)
    }
    else {
      resolved.measurementStatus = new MeasurementStatus()
    }

    if (msg.filteredSpeedUncertainty !== undefined) {
      resolved.filteredSpeedUncertainty = msg.filteredSpeedUncertainty;
    }
    else {
      resolved.filteredSpeedUncertainty = 0.0
    }

    if (msg.predetectInterval !== undefined) {
      resolved.predetectInterval = msg.predetectInterval;
    }
    else {
      resolved.predetectInterval = 0
    }

    if (msg.unfilteredMeasurementFraction !== undefined) {
      resolved.unfilteredMeasurementFraction = msg.unfilteredMeasurementFraction;
    }
    else {
      resolved.unfilteredMeasurementFraction = 0.0
    }

    if (msg.filteredTimeUncertainty !== undefined) {
      resolved.filteredTimeUncertainty = msg.filteredTimeUncertainty;
    }
    else {
      resolved.filteredTimeUncertainty = 0.0
    }

    if (msg.carrierNoise !== undefined) {
      resolved.carrierNoise = msg.carrierNoise;
    }
    else {
      resolved.carrierNoise = 0
    }

    if (msg.postdetections !== undefined) {
      resolved.postdetections = msg.postdetections;
    }
    else {
      resolved.postdetections = 0
    }

    if (msg.latency !== undefined) {
      resolved.latency = msg.latency;
    }
    else {
      resolved.latency = 0
    }

    if (msg.filterStages !== undefined) {
      resolved.filterStages = msg.filterStages;
    }
    else {
      resolved.filterStages = 0
    }

    if (msg.multipathEstimate !== undefined) {
      resolved.multipathEstimate = msg.multipathEstimate;
    }
    else {
      resolved.multipathEstimate = 0
    }

    if (msg.svId !== undefined) {
      resolved.svId = msg.svId;
    }
    else {
      resolved.svId = 0
    }

    if (msg.filteredMeasurementFraction !== undefined) {
      resolved.filteredMeasurementFraction = msg.filteredMeasurementFraction;
    }
    else {
      resolved.filteredMeasurementFraction = 0.0
    }

    if (msg.rfLoss !== undefined) {
      resolved.rfLoss = msg.rfLoss;
    }
    else {
      resolved.rfLoss = 0
    }

    if (msg.observations !== undefined) {
      resolved.observations = msg.observations;
    }
    else {
      resolved.observations = 0
    }

    if (msg.fCount !== undefined) {
      resolved.fCount = msg.fCount;
    }
    else {
      resolved.fCount = 0
    }

    if (msg.dopplerAcceleration !== undefined) {
      resolved.dopplerAcceleration = msg.dopplerAcceleration;
    }
    else {
      resolved.dopplerAcceleration = 0.0
    }

    if (msg.elevation !== undefined) {
      resolved.elevation = msg.elevation;
    }
    else {
      resolved.elevation = 0.0
    }

    if (msg.filteredSpeed !== undefined) {
      resolved.filteredSpeed = msg.filteredSpeed;
    }
    else {
      resolved.filteredSpeed = 0.0
    }

    if (msg.fineSpeed !== undefined) {
      resolved.fineSpeed = msg.fineSpeed;
    }
    else {
      resolved.fineSpeed = 0.0
    }

    if (msg.goodObservations !== undefined) {
      resolved.goodObservations = msg.goodObservations;
    }
    else {
      resolved.goodObservations = 0
    }

    if (msg.observationState !== undefined) {
      resolved.observationState = msg.observationState;
    }
    else {
      resolved.observationState = 0
    }

    if (msg.goodParity !== undefined) {
      resolved.goodParity = msg.goodParity;
    }
    else {
      resolved.goodParity = false
    }

    if (msg.carrierPhase !== undefined) {
      resolved.carrierPhase = msg.carrierPhase;
    }
    else {
      resolved.carrierPhase = 0.0
    }

    if (msg.filteredMeasurementIntegral !== undefined) {
      resolved.filteredMeasurementIntegral = msg.filteredMeasurementIntegral;
    }
    else {
      resolved.filteredMeasurementIntegral = 0
    }

    if (msg.parityErrorCount !== undefined) {
      resolved.parityErrorCount = msg.parityErrorCount;
    }
    else {
      resolved.parityErrorCount = 0
    }

    if (msg.unfilteredSpeedUncertainty !== undefined) {
      resolved.unfilteredSpeedUncertainty = msg.unfilteredSpeedUncertainty;
    }
    else {
      resolved.unfilteredSpeedUncertainty = 0.0
    }

    if (msg.fineSpeedUncertainty !== undefined) {
      resolved.fineSpeedUncertainty = msg.fineSpeedUncertainty;
    }
    else {
      resolved.fineSpeedUncertainty = 0.0
    }

    if (msg.azimuth !== undefined) {
      resolved.azimuth = msg.azimuth;
    }
    else {
      resolved.azimuth = 0.0
    }

    if (msg.unfilteredSpeed !== undefined) {
      resolved.unfilteredSpeed = msg.unfilteredSpeed;
    }
    else {
      resolved.unfilteredSpeed = 0.0
    }

    if (msg.glonassFrequencyIndex !== undefined) {
      resolved.glonassFrequencyIndex = msg.glonassFrequencyIndex;
    }
    else {
      resolved.glonassFrequencyIndex = 0
    }

    return resolved;
    }
};

module.exports = SV;
