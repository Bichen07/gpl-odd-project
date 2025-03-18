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

class MeasurementStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.glonassTimeMarkValid = null;
      this.lockPointValid = null;
      this.imdJammingIndicator = null;
      this.measuredVelocity = null;
      this.fineOrCoarseVelocity = null;
      this.gpsHighBandwidthNu4 = null;
      this.gpsRxDiversity = null;
      this.gpsHighBandwidthUniform = null;
      this.gpsHighBandwidthNu8 = null;
      this.subMillisecondIsValid = null;
      this.lastUpdateFromDifference = null;
      this.tentativeMeasurement = null;
      this.probationMode = null;
      this.directionIsValid = null;
      this.bitEdgeConfirmedFromSignal = null;
      this.gpsRoundRobinRxDiversity = null;
      this.freshMeasurementIndicator = null;
      this.lteB13TxJammingIndicator = null;
      this.lastUpdateFromVelocityDifference = null;
      this.measurementNotUsable = null;
      this.glonassMeanderBitEdgeValid = null;
      this.gpsLowBandwidthRxDiversityCombined = null;
      this.satelliteTimeIsKnown = null;
      this.strongIndicationOfCrossCorelation = null;
      this.subBitTimeIsKnown = null;
      this.lockPointPositive = null;
      this.multipathIndicator = null;
      this.sirCheckIsNeeded = null;
      this.multipathEstimateIsValid = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('glonassTimeMarkValid')) {
        this.glonassTimeMarkValid = initObj.glonassTimeMarkValid
      }
      else {
        this.glonassTimeMarkValid = false;
      }
      if (initObj.hasOwnProperty('lockPointValid')) {
        this.lockPointValid = initObj.lockPointValid
      }
      else {
        this.lockPointValid = false;
      }
      if (initObj.hasOwnProperty('imdJammingIndicator')) {
        this.imdJammingIndicator = initObj.imdJammingIndicator
      }
      else {
        this.imdJammingIndicator = false;
      }
      if (initObj.hasOwnProperty('measuredVelocity')) {
        this.measuredVelocity = initObj.measuredVelocity
      }
      else {
        this.measuredVelocity = false;
      }
      if (initObj.hasOwnProperty('fineOrCoarseVelocity')) {
        this.fineOrCoarseVelocity = initObj.fineOrCoarseVelocity
      }
      else {
        this.fineOrCoarseVelocity = false;
      }
      if (initObj.hasOwnProperty('gpsHighBandwidthNu4')) {
        this.gpsHighBandwidthNu4 = initObj.gpsHighBandwidthNu4
      }
      else {
        this.gpsHighBandwidthNu4 = false;
      }
      if (initObj.hasOwnProperty('gpsRxDiversity')) {
        this.gpsRxDiversity = initObj.gpsRxDiversity
      }
      else {
        this.gpsRxDiversity = false;
      }
      if (initObj.hasOwnProperty('gpsHighBandwidthUniform')) {
        this.gpsHighBandwidthUniform = initObj.gpsHighBandwidthUniform
      }
      else {
        this.gpsHighBandwidthUniform = false;
      }
      if (initObj.hasOwnProperty('gpsHighBandwidthNu8')) {
        this.gpsHighBandwidthNu8 = initObj.gpsHighBandwidthNu8
      }
      else {
        this.gpsHighBandwidthNu8 = false;
      }
      if (initObj.hasOwnProperty('subMillisecondIsValid')) {
        this.subMillisecondIsValid = initObj.subMillisecondIsValid
      }
      else {
        this.subMillisecondIsValid = false;
      }
      if (initObj.hasOwnProperty('lastUpdateFromDifference')) {
        this.lastUpdateFromDifference = initObj.lastUpdateFromDifference
      }
      else {
        this.lastUpdateFromDifference = false;
      }
      if (initObj.hasOwnProperty('tentativeMeasurement')) {
        this.tentativeMeasurement = initObj.tentativeMeasurement
      }
      else {
        this.tentativeMeasurement = false;
      }
      if (initObj.hasOwnProperty('probationMode')) {
        this.probationMode = initObj.probationMode
      }
      else {
        this.probationMode = false;
      }
      if (initObj.hasOwnProperty('directionIsValid')) {
        this.directionIsValid = initObj.directionIsValid
      }
      else {
        this.directionIsValid = false;
      }
      if (initObj.hasOwnProperty('bitEdgeConfirmedFromSignal')) {
        this.bitEdgeConfirmedFromSignal = initObj.bitEdgeConfirmedFromSignal
      }
      else {
        this.bitEdgeConfirmedFromSignal = false;
      }
      if (initObj.hasOwnProperty('gpsRoundRobinRxDiversity')) {
        this.gpsRoundRobinRxDiversity = initObj.gpsRoundRobinRxDiversity
      }
      else {
        this.gpsRoundRobinRxDiversity = false;
      }
      if (initObj.hasOwnProperty('freshMeasurementIndicator')) {
        this.freshMeasurementIndicator = initObj.freshMeasurementIndicator
      }
      else {
        this.freshMeasurementIndicator = false;
      }
      if (initObj.hasOwnProperty('lteB13TxJammingIndicator')) {
        this.lteB13TxJammingIndicator = initObj.lteB13TxJammingIndicator
      }
      else {
        this.lteB13TxJammingIndicator = false;
      }
      if (initObj.hasOwnProperty('lastUpdateFromVelocityDifference')) {
        this.lastUpdateFromVelocityDifference = initObj.lastUpdateFromVelocityDifference
      }
      else {
        this.lastUpdateFromVelocityDifference = false;
      }
      if (initObj.hasOwnProperty('measurementNotUsable')) {
        this.measurementNotUsable = initObj.measurementNotUsable
      }
      else {
        this.measurementNotUsable = false;
      }
      if (initObj.hasOwnProperty('glonassMeanderBitEdgeValid')) {
        this.glonassMeanderBitEdgeValid = initObj.glonassMeanderBitEdgeValid
      }
      else {
        this.glonassMeanderBitEdgeValid = false;
      }
      if (initObj.hasOwnProperty('gpsLowBandwidthRxDiversityCombined')) {
        this.gpsLowBandwidthRxDiversityCombined = initObj.gpsLowBandwidthRxDiversityCombined
      }
      else {
        this.gpsLowBandwidthRxDiversityCombined = false;
      }
      if (initObj.hasOwnProperty('satelliteTimeIsKnown')) {
        this.satelliteTimeIsKnown = initObj.satelliteTimeIsKnown
      }
      else {
        this.satelliteTimeIsKnown = false;
      }
      if (initObj.hasOwnProperty('strongIndicationOfCrossCorelation')) {
        this.strongIndicationOfCrossCorelation = initObj.strongIndicationOfCrossCorelation
      }
      else {
        this.strongIndicationOfCrossCorelation = false;
      }
      if (initObj.hasOwnProperty('subBitTimeIsKnown')) {
        this.subBitTimeIsKnown = initObj.subBitTimeIsKnown
      }
      else {
        this.subBitTimeIsKnown = false;
      }
      if (initObj.hasOwnProperty('lockPointPositive')) {
        this.lockPointPositive = initObj.lockPointPositive
      }
      else {
        this.lockPointPositive = false;
      }
      if (initObj.hasOwnProperty('multipathIndicator')) {
        this.multipathIndicator = initObj.multipathIndicator
      }
      else {
        this.multipathIndicator = false;
      }
      if (initObj.hasOwnProperty('sirCheckIsNeeded')) {
        this.sirCheckIsNeeded = initObj.sirCheckIsNeeded
      }
      else {
        this.sirCheckIsNeeded = false;
      }
      if (initObj.hasOwnProperty('multipathEstimateIsValid')) {
        this.multipathEstimateIsValid = initObj.multipathEstimateIsValid
      }
      else {
        this.multipathEstimateIsValid = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MeasurementStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [glonassTimeMarkValid]
    bufferOffset = _serializer.bool(obj.glonassTimeMarkValid, buffer, bufferOffset);
    // Serialize message field [lockPointValid]
    bufferOffset = _serializer.bool(obj.lockPointValid, buffer, bufferOffset);
    // Serialize message field [imdJammingIndicator]
    bufferOffset = _serializer.bool(obj.imdJammingIndicator, buffer, bufferOffset);
    // Serialize message field [measuredVelocity]
    bufferOffset = _serializer.bool(obj.measuredVelocity, buffer, bufferOffset);
    // Serialize message field [fineOrCoarseVelocity]
    bufferOffset = _serializer.bool(obj.fineOrCoarseVelocity, buffer, bufferOffset);
    // Serialize message field [gpsHighBandwidthNu4]
    bufferOffset = _serializer.bool(obj.gpsHighBandwidthNu4, buffer, bufferOffset);
    // Serialize message field [gpsRxDiversity]
    bufferOffset = _serializer.bool(obj.gpsRxDiversity, buffer, bufferOffset);
    // Serialize message field [gpsHighBandwidthUniform]
    bufferOffset = _serializer.bool(obj.gpsHighBandwidthUniform, buffer, bufferOffset);
    // Serialize message field [gpsHighBandwidthNu8]
    bufferOffset = _serializer.bool(obj.gpsHighBandwidthNu8, buffer, bufferOffset);
    // Serialize message field [subMillisecondIsValid]
    bufferOffset = _serializer.bool(obj.subMillisecondIsValid, buffer, bufferOffset);
    // Serialize message field [lastUpdateFromDifference]
    bufferOffset = _serializer.bool(obj.lastUpdateFromDifference, buffer, bufferOffset);
    // Serialize message field [tentativeMeasurement]
    bufferOffset = _serializer.bool(obj.tentativeMeasurement, buffer, bufferOffset);
    // Serialize message field [probationMode]
    bufferOffset = _serializer.bool(obj.probationMode, buffer, bufferOffset);
    // Serialize message field [directionIsValid]
    bufferOffset = _serializer.bool(obj.directionIsValid, buffer, bufferOffset);
    // Serialize message field [bitEdgeConfirmedFromSignal]
    bufferOffset = _serializer.bool(obj.bitEdgeConfirmedFromSignal, buffer, bufferOffset);
    // Serialize message field [gpsRoundRobinRxDiversity]
    bufferOffset = _serializer.bool(obj.gpsRoundRobinRxDiversity, buffer, bufferOffset);
    // Serialize message field [freshMeasurementIndicator]
    bufferOffset = _serializer.bool(obj.freshMeasurementIndicator, buffer, bufferOffset);
    // Serialize message field [lteB13TxJammingIndicator]
    bufferOffset = _serializer.bool(obj.lteB13TxJammingIndicator, buffer, bufferOffset);
    // Serialize message field [lastUpdateFromVelocityDifference]
    bufferOffset = _serializer.bool(obj.lastUpdateFromVelocityDifference, buffer, bufferOffset);
    // Serialize message field [measurementNotUsable]
    bufferOffset = _serializer.bool(obj.measurementNotUsable, buffer, bufferOffset);
    // Serialize message field [glonassMeanderBitEdgeValid]
    bufferOffset = _serializer.bool(obj.glonassMeanderBitEdgeValid, buffer, bufferOffset);
    // Serialize message field [gpsLowBandwidthRxDiversityCombined]
    bufferOffset = _serializer.bool(obj.gpsLowBandwidthRxDiversityCombined, buffer, bufferOffset);
    // Serialize message field [satelliteTimeIsKnown]
    bufferOffset = _serializer.bool(obj.satelliteTimeIsKnown, buffer, bufferOffset);
    // Serialize message field [strongIndicationOfCrossCorelation]
    bufferOffset = _serializer.bool(obj.strongIndicationOfCrossCorelation, buffer, bufferOffset);
    // Serialize message field [subBitTimeIsKnown]
    bufferOffset = _serializer.bool(obj.subBitTimeIsKnown, buffer, bufferOffset);
    // Serialize message field [lockPointPositive]
    bufferOffset = _serializer.bool(obj.lockPointPositive, buffer, bufferOffset);
    // Serialize message field [multipathIndicator]
    bufferOffset = _serializer.bool(obj.multipathIndicator, buffer, bufferOffset);
    // Serialize message field [sirCheckIsNeeded]
    bufferOffset = _serializer.bool(obj.sirCheckIsNeeded, buffer, bufferOffset);
    // Serialize message field [multipathEstimateIsValid]
    bufferOffset = _serializer.bool(obj.multipathEstimateIsValid, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MeasurementStatus
    let len;
    let data = new MeasurementStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [glonassTimeMarkValid]
    data.glonassTimeMarkValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lockPointValid]
    data.lockPointValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [imdJammingIndicator]
    data.imdJammingIndicator = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [measuredVelocity]
    data.measuredVelocity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fineOrCoarseVelocity]
    data.fineOrCoarseVelocity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsHighBandwidthNu4]
    data.gpsHighBandwidthNu4 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsRxDiversity]
    data.gpsRxDiversity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsHighBandwidthUniform]
    data.gpsHighBandwidthUniform = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsHighBandwidthNu8]
    data.gpsHighBandwidthNu8 = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [subMillisecondIsValid]
    data.subMillisecondIsValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lastUpdateFromDifference]
    data.lastUpdateFromDifference = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [tentativeMeasurement]
    data.tentativeMeasurement = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [probationMode]
    data.probationMode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [directionIsValid]
    data.directionIsValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bitEdgeConfirmedFromSignal]
    data.bitEdgeConfirmedFromSignal = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsRoundRobinRxDiversity]
    data.gpsRoundRobinRxDiversity = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [freshMeasurementIndicator]
    data.freshMeasurementIndicator = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lteB13TxJammingIndicator]
    data.lteB13TxJammingIndicator = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lastUpdateFromVelocityDifference]
    data.lastUpdateFromVelocityDifference = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [measurementNotUsable]
    data.measurementNotUsable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [glonassMeanderBitEdgeValid]
    data.glonassMeanderBitEdgeValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsLowBandwidthRxDiversityCombined]
    data.gpsLowBandwidthRxDiversityCombined = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [satelliteTimeIsKnown]
    data.satelliteTimeIsKnown = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [strongIndicationOfCrossCorelation]
    data.strongIndicationOfCrossCorelation = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [subBitTimeIsKnown]
    data.subBitTimeIsKnown = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lockPointPositive]
    data.lockPointPositive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [multipathIndicator]
    data.multipathIndicator = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [sirCheckIsNeeded]
    data.sirCheckIsNeeded = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [multipathEstimateIsValid]
    data.multipathEstimateIsValid = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/MeasurementStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a21dccf859aded23d20028d0485351fb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new MeasurementStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.glonassTimeMarkValid !== undefined) {
      resolved.glonassTimeMarkValid = msg.glonassTimeMarkValid;
    }
    else {
      resolved.glonassTimeMarkValid = false
    }

    if (msg.lockPointValid !== undefined) {
      resolved.lockPointValid = msg.lockPointValid;
    }
    else {
      resolved.lockPointValid = false
    }

    if (msg.imdJammingIndicator !== undefined) {
      resolved.imdJammingIndicator = msg.imdJammingIndicator;
    }
    else {
      resolved.imdJammingIndicator = false
    }

    if (msg.measuredVelocity !== undefined) {
      resolved.measuredVelocity = msg.measuredVelocity;
    }
    else {
      resolved.measuredVelocity = false
    }

    if (msg.fineOrCoarseVelocity !== undefined) {
      resolved.fineOrCoarseVelocity = msg.fineOrCoarseVelocity;
    }
    else {
      resolved.fineOrCoarseVelocity = false
    }

    if (msg.gpsHighBandwidthNu4 !== undefined) {
      resolved.gpsHighBandwidthNu4 = msg.gpsHighBandwidthNu4;
    }
    else {
      resolved.gpsHighBandwidthNu4 = false
    }

    if (msg.gpsRxDiversity !== undefined) {
      resolved.gpsRxDiversity = msg.gpsRxDiversity;
    }
    else {
      resolved.gpsRxDiversity = false
    }

    if (msg.gpsHighBandwidthUniform !== undefined) {
      resolved.gpsHighBandwidthUniform = msg.gpsHighBandwidthUniform;
    }
    else {
      resolved.gpsHighBandwidthUniform = false
    }

    if (msg.gpsHighBandwidthNu8 !== undefined) {
      resolved.gpsHighBandwidthNu8 = msg.gpsHighBandwidthNu8;
    }
    else {
      resolved.gpsHighBandwidthNu8 = false
    }

    if (msg.subMillisecondIsValid !== undefined) {
      resolved.subMillisecondIsValid = msg.subMillisecondIsValid;
    }
    else {
      resolved.subMillisecondIsValid = false
    }

    if (msg.lastUpdateFromDifference !== undefined) {
      resolved.lastUpdateFromDifference = msg.lastUpdateFromDifference;
    }
    else {
      resolved.lastUpdateFromDifference = false
    }

    if (msg.tentativeMeasurement !== undefined) {
      resolved.tentativeMeasurement = msg.tentativeMeasurement;
    }
    else {
      resolved.tentativeMeasurement = false
    }

    if (msg.probationMode !== undefined) {
      resolved.probationMode = msg.probationMode;
    }
    else {
      resolved.probationMode = false
    }

    if (msg.directionIsValid !== undefined) {
      resolved.directionIsValid = msg.directionIsValid;
    }
    else {
      resolved.directionIsValid = false
    }

    if (msg.bitEdgeConfirmedFromSignal !== undefined) {
      resolved.bitEdgeConfirmedFromSignal = msg.bitEdgeConfirmedFromSignal;
    }
    else {
      resolved.bitEdgeConfirmedFromSignal = false
    }

    if (msg.gpsRoundRobinRxDiversity !== undefined) {
      resolved.gpsRoundRobinRxDiversity = msg.gpsRoundRobinRxDiversity;
    }
    else {
      resolved.gpsRoundRobinRxDiversity = false
    }

    if (msg.freshMeasurementIndicator !== undefined) {
      resolved.freshMeasurementIndicator = msg.freshMeasurementIndicator;
    }
    else {
      resolved.freshMeasurementIndicator = false
    }

    if (msg.lteB13TxJammingIndicator !== undefined) {
      resolved.lteB13TxJammingIndicator = msg.lteB13TxJammingIndicator;
    }
    else {
      resolved.lteB13TxJammingIndicator = false
    }

    if (msg.lastUpdateFromVelocityDifference !== undefined) {
      resolved.lastUpdateFromVelocityDifference = msg.lastUpdateFromVelocityDifference;
    }
    else {
      resolved.lastUpdateFromVelocityDifference = false
    }

    if (msg.measurementNotUsable !== undefined) {
      resolved.measurementNotUsable = msg.measurementNotUsable;
    }
    else {
      resolved.measurementNotUsable = false
    }

    if (msg.glonassMeanderBitEdgeValid !== undefined) {
      resolved.glonassMeanderBitEdgeValid = msg.glonassMeanderBitEdgeValid;
    }
    else {
      resolved.glonassMeanderBitEdgeValid = false
    }

    if (msg.gpsLowBandwidthRxDiversityCombined !== undefined) {
      resolved.gpsLowBandwidthRxDiversityCombined = msg.gpsLowBandwidthRxDiversityCombined;
    }
    else {
      resolved.gpsLowBandwidthRxDiversityCombined = false
    }

    if (msg.satelliteTimeIsKnown !== undefined) {
      resolved.satelliteTimeIsKnown = msg.satelliteTimeIsKnown;
    }
    else {
      resolved.satelliteTimeIsKnown = false
    }

    if (msg.strongIndicationOfCrossCorelation !== undefined) {
      resolved.strongIndicationOfCrossCorelation = msg.strongIndicationOfCrossCorelation;
    }
    else {
      resolved.strongIndicationOfCrossCorelation = false
    }

    if (msg.subBitTimeIsKnown !== undefined) {
      resolved.subBitTimeIsKnown = msg.subBitTimeIsKnown;
    }
    else {
      resolved.subBitTimeIsKnown = false
    }

    if (msg.lockPointPositive !== undefined) {
      resolved.lockPointPositive = msg.lockPointPositive;
    }
    else {
      resolved.lockPointPositive = false
    }

    if (msg.multipathIndicator !== undefined) {
      resolved.multipathIndicator = msg.multipathIndicator;
    }
    else {
      resolved.multipathIndicator = false
    }

    if (msg.sirCheckIsNeeded !== undefined) {
      resolved.sirCheckIsNeeded = msg.sirCheckIsNeeded;
    }
    else {
      resolved.sirCheckIsNeeded = false
    }

    if (msg.multipathEstimateIsValid !== undefined) {
      resolved.multipathEstimateIsValid = msg.multipathEstimateIsValid;
    }
    else {
      resolved.multipathEstimateIsValid = false
    }

    return resolved;
    }
};

module.exports = MeasurementStatus;
