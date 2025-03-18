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

class ClockReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.galToBdsTimeBiasMillisecondsUncertainty = null;
      this.hasFCount = null;
      this.bdsClockSource = null;
      this.clockFrequencyUncertainty = null;
      this.gpsMilliseconds = null;
      this.hasGpsWeek = null;
      this.gpsToGlonassTimeBiasMilliseconds = null;
      this.galWeek = null;
      this.bdsMilliseconds = null;
      this.gpsToGalTimeBiasMilliseconds = null;
      this.glonassTimeBias = null;
      this.gpsClockSource = null;
      this.bdsClockTimeUncertainty = null;
      this.gpsToBdsTimeBiasMillisecondsUncertainty = null;
      this.glonassYear = null;
      this.galToGloTimeBiasMilliseconds = null;
      this.galMilliseconds = null;
      this.galToGloTimeBiasMillisecondsUncertainty = null;
      this.clockFrequencyBias = null;
      this.fCount = null;
      this.gpsLeapSeconds = null;
      this.hasRtcTime = null;
      this.bdsWeek = null;
      this.glonassClockTimeUncertainty = null;
      this.hasGlonassMilliseconds = null;
      this.systemRtcTime = null;
      this.bdsTimeBias = null;
      this.frequencySource = null;
      this.glonassDay = null;
      this.hasGlonassDay = null;
      this.gpsToGalTimeBiasMillisecondsUncertainty = null;
      this.galTimeBias = null;
      this.galClockTimeUncertainty = null;
      this.gpsTimeBias = null;
      this.lpmRtcCount = null;
      this.glonassMilliseconds = null;
      this.fCountOffset = null;
      this.bdsToGloTimeBiasMilliseconds = null;
      this.clockResets = null;
      this.gpsLeapSecondsSource = null;
      this.galClockSource = null;
      this.hasGpsMilliseconds = null;
      this.gpsToBdsTimeBiasMilliseconds = null;
      this.gpsWeek = null;
      this.gpsClockTimeUncertainty = null;
      this.bdsToGloTimeBiasMillisecondsUncertainty = null;
      this.hasGlonassYear = null;
      this.gpsToGlonassTimeBiasMillisecondsUncertainty = null;
      this.glonassClockSource = null;
      this.galToBdsTimeBiasMilliseconds = null;
      this.gpsLeapSecondsUncertainty = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('galToBdsTimeBiasMillisecondsUncertainty')) {
        this.galToBdsTimeBiasMillisecondsUncertainty = initObj.galToBdsTimeBiasMillisecondsUncertainty
      }
      else {
        this.galToBdsTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('hasFCount')) {
        this.hasFCount = initObj.hasFCount
      }
      else {
        this.hasFCount = false;
      }
      if (initObj.hasOwnProperty('bdsClockSource')) {
        this.bdsClockSource = initObj.bdsClockSource
      }
      else {
        this.bdsClockSource = 0;
      }
      if (initObj.hasOwnProperty('clockFrequencyUncertainty')) {
        this.clockFrequencyUncertainty = initObj.clockFrequencyUncertainty
      }
      else {
        this.clockFrequencyUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('gpsMilliseconds')) {
        this.gpsMilliseconds = initObj.gpsMilliseconds
      }
      else {
        this.gpsMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('hasGpsWeek')) {
        this.hasGpsWeek = initObj.hasGpsWeek
      }
      else {
        this.hasGpsWeek = false;
      }
      if (initObj.hasOwnProperty('gpsToGlonassTimeBiasMilliseconds')) {
        this.gpsToGlonassTimeBiasMilliseconds = initObj.gpsToGlonassTimeBiasMilliseconds
      }
      else {
        this.gpsToGlonassTimeBiasMilliseconds = 0.0;
      }
      if (initObj.hasOwnProperty('galWeek')) {
        this.galWeek = initObj.galWeek
      }
      else {
        this.galWeek = 0;
      }
      if (initObj.hasOwnProperty('bdsMilliseconds')) {
        this.bdsMilliseconds = initObj.bdsMilliseconds
      }
      else {
        this.bdsMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('gpsToGalTimeBiasMilliseconds')) {
        this.gpsToGalTimeBiasMilliseconds = initObj.gpsToGalTimeBiasMilliseconds
      }
      else {
        this.gpsToGalTimeBiasMilliseconds = 0.0;
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
      if (initObj.hasOwnProperty('bdsClockTimeUncertainty')) {
        this.bdsClockTimeUncertainty = initObj.bdsClockTimeUncertainty
      }
      else {
        this.bdsClockTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('gpsToBdsTimeBiasMillisecondsUncertainty')) {
        this.gpsToBdsTimeBiasMillisecondsUncertainty = initObj.gpsToBdsTimeBiasMillisecondsUncertainty
      }
      else {
        this.gpsToBdsTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('glonassYear')) {
        this.glonassYear = initObj.glonassYear
      }
      else {
        this.glonassYear = 0;
      }
      if (initObj.hasOwnProperty('galToGloTimeBiasMilliseconds')) {
        this.galToGloTimeBiasMilliseconds = initObj.galToGloTimeBiasMilliseconds
      }
      else {
        this.galToGloTimeBiasMilliseconds = 0.0;
      }
      if (initObj.hasOwnProperty('galMilliseconds')) {
        this.galMilliseconds = initObj.galMilliseconds
      }
      else {
        this.galMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('galToGloTimeBiasMillisecondsUncertainty')) {
        this.galToGloTimeBiasMillisecondsUncertainty = initObj.galToGloTimeBiasMillisecondsUncertainty
      }
      else {
        this.galToGloTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('clockFrequencyBias')) {
        this.clockFrequencyBias = initObj.clockFrequencyBias
      }
      else {
        this.clockFrequencyBias = 0.0;
      }
      if (initObj.hasOwnProperty('fCount')) {
        this.fCount = initObj.fCount
      }
      else {
        this.fCount = 0;
      }
      if (initObj.hasOwnProperty('gpsLeapSeconds')) {
        this.gpsLeapSeconds = initObj.gpsLeapSeconds
      }
      else {
        this.gpsLeapSeconds = 0;
      }
      if (initObj.hasOwnProperty('hasRtcTime')) {
        this.hasRtcTime = initObj.hasRtcTime
      }
      else {
        this.hasRtcTime = false;
      }
      if (initObj.hasOwnProperty('bdsWeek')) {
        this.bdsWeek = initObj.bdsWeek
      }
      else {
        this.bdsWeek = 0;
      }
      if (initObj.hasOwnProperty('glonassClockTimeUncertainty')) {
        this.glonassClockTimeUncertainty = initObj.glonassClockTimeUncertainty
      }
      else {
        this.glonassClockTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('hasGlonassMilliseconds')) {
        this.hasGlonassMilliseconds = initObj.hasGlonassMilliseconds
      }
      else {
        this.hasGlonassMilliseconds = false;
      }
      if (initObj.hasOwnProperty('systemRtcTime')) {
        this.systemRtcTime = initObj.systemRtcTime
      }
      else {
        this.systemRtcTime = 0;
      }
      if (initObj.hasOwnProperty('bdsTimeBias')) {
        this.bdsTimeBias = initObj.bdsTimeBias
      }
      else {
        this.bdsTimeBias = 0.0;
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
      if (initObj.hasOwnProperty('hasGlonassDay')) {
        this.hasGlonassDay = initObj.hasGlonassDay
      }
      else {
        this.hasGlonassDay = false;
      }
      if (initObj.hasOwnProperty('gpsToGalTimeBiasMillisecondsUncertainty')) {
        this.gpsToGalTimeBiasMillisecondsUncertainty = initObj.gpsToGalTimeBiasMillisecondsUncertainty
      }
      else {
        this.gpsToGalTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('galTimeBias')) {
        this.galTimeBias = initObj.galTimeBias
      }
      else {
        this.galTimeBias = 0.0;
      }
      if (initObj.hasOwnProperty('galClockTimeUncertainty')) {
        this.galClockTimeUncertainty = initObj.galClockTimeUncertainty
      }
      else {
        this.galClockTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('gpsTimeBias')) {
        this.gpsTimeBias = initObj.gpsTimeBias
      }
      else {
        this.gpsTimeBias = 0.0;
      }
      if (initObj.hasOwnProperty('lpmRtcCount')) {
        this.lpmRtcCount = initObj.lpmRtcCount
      }
      else {
        this.lpmRtcCount = 0;
      }
      if (initObj.hasOwnProperty('glonassMilliseconds')) {
        this.glonassMilliseconds = initObj.glonassMilliseconds
      }
      else {
        this.glonassMilliseconds = 0;
      }
      if (initObj.hasOwnProperty('fCountOffset')) {
        this.fCountOffset = initObj.fCountOffset
      }
      else {
        this.fCountOffset = 0;
      }
      if (initObj.hasOwnProperty('bdsToGloTimeBiasMilliseconds')) {
        this.bdsToGloTimeBiasMilliseconds = initObj.bdsToGloTimeBiasMilliseconds
      }
      else {
        this.bdsToGloTimeBiasMilliseconds = 0.0;
      }
      if (initObj.hasOwnProperty('clockResets')) {
        this.clockResets = initObj.clockResets
      }
      else {
        this.clockResets = 0;
      }
      if (initObj.hasOwnProperty('gpsLeapSecondsSource')) {
        this.gpsLeapSecondsSource = initObj.gpsLeapSecondsSource
      }
      else {
        this.gpsLeapSecondsSource = 0;
      }
      if (initObj.hasOwnProperty('galClockSource')) {
        this.galClockSource = initObj.galClockSource
      }
      else {
        this.galClockSource = 0;
      }
      if (initObj.hasOwnProperty('hasGpsMilliseconds')) {
        this.hasGpsMilliseconds = initObj.hasGpsMilliseconds
      }
      else {
        this.hasGpsMilliseconds = false;
      }
      if (initObj.hasOwnProperty('gpsToBdsTimeBiasMilliseconds')) {
        this.gpsToBdsTimeBiasMilliseconds = initObj.gpsToBdsTimeBiasMilliseconds
      }
      else {
        this.gpsToBdsTimeBiasMilliseconds = 0.0;
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0;
      }
      if (initObj.hasOwnProperty('gpsClockTimeUncertainty')) {
        this.gpsClockTimeUncertainty = initObj.gpsClockTimeUncertainty
      }
      else {
        this.gpsClockTimeUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('bdsToGloTimeBiasMillisecondsUncertainty')) {
        this.bdsToGloTimeBiasMillisecondsUncertainty = initObj.bdsToGloTimeBiasMillisecondsUncertainty
      }
      else {
        this.bdsToGloTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('hasGlonassYear')) {
        this.hasGlonassYear = initObj.hasGlonassYear
      }
      else {
        this.hasGlonassYear = false;
      }
      if (initObj.hasOwnProperty('gpsToGlonassTimeBiasMillisecondsUncertainty')) {
        this.gpsToGlonassTimeBiasMillisecondsUncertainty = initObj.gpsToGlonassTimeBiasMillisecondsUncertainty
      }
      else {
        this.gpsToGlonassTimeBiasMillisecondsUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('glonassClockSource')) {
        this.glonassClockSource = initObj.glonassClockSource
      }
      else {
        this.glonassClockSource = 0;
      }
      if (initObj.hasOwnProperty('galToBdsTimeBiasMilliseconds')) {
        this.galToBdsTimeBiasMilliseconds = initObj.galToBdsTimeBiasMilliseconds
      }
      else {
        this.galToBdsTimeBiasMilliseconds = 0.0;
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
    // Serializes a message object of type ClockReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [galToBdsTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.galToBdsTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [hasFCount]
    bufferOffset = _serializer.bool(obj.hasFCount, buffer, bufferOffset);
    // Serialize message field [bdsClockSource]
    bufferOffset = _serializer.int64(obj.bdsClockSource, buffer, bufferOffset);
    // Serialize message field [clockFrequencyUncertainty]
    bufferOffset = _serializer.float32(obj.clockFrequencyUncertainty, buffer, bufferOffset);
    // Serialize message field [gpsMilliseconds]
    bufferOffset = _serializer.int64(obj.gpsMilliseconds, buffer, bufferOffset);
    // Serialize message field [hasGpsWeek]
    bufferOffset = _serializer.bool(obj.hasGpsWeek, buffer, bufferOffset);
    // Serialize message field [gpsToGlonassTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.gpsToGlonassTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [galWeek]
    bufferOffset = _serializer.int64(obj.galWeek, buffer, bufferOffset);
    // Serialize message field [bdsMilliseconds]
    bufferOffset = _serializer.int64(obj.bdsMilliseconds, buffer, bufferOffset);
    // Serialize message field [gpsToGalTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.gpsToGalTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [glonassTimeBias]
    bufferOffset = _serializer.float32(obj.glonassTimeBias, buffer, bufferOffset);
    // Serialize message field [gpsClockSource]
    bufferOffset = _serializer.int64(obj.gpsClockSource, buffer, bufferOffset);
    // Serialize message field [bdsClockTimeUncertainty]
    bufferOffset = _serializer.float32(obj.bdsClockTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [gpsToBdsTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.gpsToBdsTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [glonassYear]
    bufferOffset = _serializer.int64(obj.glonassYear, buffer, bufferOffset);
    // Serialize message field [galToGloTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.galToGloTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [galMilliseconds]
    bufferOffset = _serializer.int64(obj.galMilliseconds, buffer, bufferOffset);
    // Serialize message field [galToGloTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.galToGloTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [clockFrequencyBias]
    bufferOffset = _serializer.float32(obj.clockFrequencyBias, buffer, bufferOffset);
    // Serialize message field [fCount]
    bufferOffset = _serializer.int64(obj.fCount, buffer, bufferOffset);
    // Serialize message field [gpsLeapSeconds]
    bufferOffset = _serializer.int64(obj.gpsLeapSeconds, buffer, bufferOffset);
    // Serialize message field [hasRtcTime]
    bufferOffset = _serializer.bool(obj.hasRtcTime, buffer, bufferOffset);
    // Serialize message field [bdsWeek]
    bufferOffset = _serializer.int64(obj.bdsWeek, buffer, bufferOffset);
    // Serialize message field [glonassClockTimeUncertainty]
    bufferOffset = _serializer.float32(obj.glonassClockTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [hasGlonassMilliseconds]
    bufferOffset = _serializer.bool(obj.hasGlonassMilliseconds, buffer, bufferOffset);
    // Serialize message field [systemRtcTime]
    bufferOffset = _serializer.int64(obj.systemRtcTime, buffer, bufferOffset);
    // Serialize message field [bdsTimeBias]
    bufferOffset = _serializer.float32(obj.bdsTimeBias, buffer, bufferOffset);
    // Serialize message field [frequencySource]
    bufferOffset = _serializer.int64(obj.frequencySource, buffer, bufferOffset);
    // Serialize message field [glonassDay]
    bufferOffset = _serializer.int64(obj.glonassDay, buffer, bufferOffset);
    // Serialize message field [hasGlonassDay]
    bufferOffset = _serializer.bool(obj.hasGlonassDay, buffer, bufferOffset);
    // Serialize message field [gpsToGalTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.gpsToGalTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [galTimeBias]
    bufferOffset = _serializer.float32(obj.galTimeBias, buffer, bufferOffset);
    // Serialize message field [galClockTimeUncertainty]
    bufferOffset = _serializer.float32(obj.galClockTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [gpsTimeBias]
    bufferOffset = _serializer.float32(obj.gpsTimeBias, buffer, bufferOffset);
    // Serialize message field [lpmRtcCount]
    bufferOffset = _serializer.int64(obj.lpmRtcCount, buffer, bufferOffset);
    // Serialize message field [glonassMilliseconds]
    bufferOffset = _serializer.int64(obj.glonassMilliseconds, buffer, bufferOffset);
    // Serialize message field [fCountOffset]
    bufferOffset = _serializer.int64(obj.fCountOffset, buffer, bufferOffset);
    // Serialize message field [bdsToGloTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.bdsToGloTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [clockResets]
    bufferOffset = _serializer.int64(obj.clockResets, buffer, bufferOffset);
    // Serialize message field [gpsLeapSecondsSource]
    bufferOffset = _serializer.int64(obj.gpsLeapSecondsSource, buffer, bufferOffset);
    // Serialize message field [galClockSource]
    bufferOffset = _serializer.int64(obj.galClockSource, buffer, bufferOffset);
    // Serialize message field [hasGpsMilliseconds]
    bufferOffset = _serializer.bool(obj.hasGpsMilliseconds, buffer, bufferOffset);
    // Serialize message field [gpsToBdsTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.gpsToBdsTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.int64(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [gpsClockTimeUncertainty]
    bufferOffset = _serializer.float32(obj.gpsClockTimeUncertainty, buffer, bufferOffset);
    // Serialize message field [bdsToGloTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.bdsToGloTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [hasGlonassYear]
    bufferOffset = _serializer.bool(obj.hasGlonassYear, buffer, bufferOffset);
    // Serialize message field [gpsToGlonassTimeBiasMillisecondsUncertainty]
    bufferOffset = _serializer.float32(obj.gpsToGlonassTimeBiasMillisecondsUncertainty, buffer, bufferOffset);
    // Serialize message field [glonassClockSource]
    bufferOffset = _serializer.int64(obj.glonassClockSource, buffer, bufferOffset);
    // Serialize message field [galToBdsTimeBiasMilliseconds]
    bufferOffset = _serializer.float32(obj.galToBdsTimeBiasMilliseconds, buffer, bufferOffset);
    // Serialize message field [gpsLeapSecondsUncertainty]
    bufferOffset = _serializer.int64(obj.gpsLeapSecondsUncertainty, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ClockReport
    let len;
    let data = new ClockReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [galToBdsTimeBiasMillisecondsUncertainty]
    data.galToBdsTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasFCount]
    data.hasFCount = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bdsClockSource]
    data.bdsClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [clockFrequencyUncertainty]
    data.clockFrequencyUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsMilliseconds]
    data.gpsMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [hasGpsWeek]
    data.hasGpsWeek = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsToGlonassTimeBiasMilliseconds]
    data.gpsToGlonassTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [galWeek]
    data.galWeek = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bdsMilliseconds]
    data.bdsMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsToGalTimeBiasMilliseconds]
    data.gpsToGalTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [glonassTimeBias]
    data.glonassTimeBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsClockSource]
    data.gpsClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bdsClockTimeUncertainty]
    data.bdsClockTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsToBdsTimeBiasMillisecondsUncertainty]
    data.gpsToBdsTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [glonassYear]
    data.glonassYear = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [galToGloTimeBiasMilliseconds]
    data.galToGloTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [galMilliseconds]
    data.galMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [galToGloTimeBiasMillisecondsUncertainty]
    data.galToGloTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [clockFrequencyBias]
    data.clockFrequencyBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fCount]
    data.fCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsLeapSeconds]
    data.gpsLeapSeconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [hasRtcTime]
    data.hasRtcTime = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bdsWeek]
    data.bdsWeek = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassClockTimeUncertainty]
    data.glonassClockTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasGlonassMilliseconds]
    data.hasGlonassMilliseconds = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [systemRtcTime]
    data.systemRtcTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bdsTimeBias]
    data.bdsTimeBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [frequencySource]
    data.frequencySource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassDay]
    data.glonassDay = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [hasGlonassDay]
    data.hasGlonassDay = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsToGalTimeBiasMillisecondsUncertainty]
    data.gpsToGalTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [galTimeBias]
    data.galTimeBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [galClockTimeUncertainty]
    data.galClockTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsTimeBias]
    data.gpsTimeBias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lpmRtcCount]
    data.lpmRtcCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [glonassMilliseconds]
    data.glonassMilliseconds = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [fCountOffset]
    data.fCountOffset = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bdsToGloTimeBiasMilliseconds]
    data.bdsToGloTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [clockResets]
    data.clockResets = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsLeapSecondsSource]
    data.gpsLeapSecondsSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [galClockSource]
    data.galClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [hasGpsMilliseconds]
    data.hasGpsMilliseconds = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsToBdsTimeBiasMilliseconds]
    data.gpsToBdsTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsClockTimeUncertainty]
    data.gpsClockTimeUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [bdsToGloTimeBiasMillisecondsUncertainty]
    data.bdsToGloTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasGlonassYear]
    data.hasGlonassYear = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsToGlonassTimeBiasMillisecondsUncertainty]
    data.gpsToGlonassTimeBiasMillisecondsUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [glonassClockSource]
    data.glonassClockSource = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [galToBdsTimeBiasMilliseconds]
    data.galToBdsTimeBiasMilliseconds = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsLeapSecondsUncertainty]
    data.gpsLeapSecondsUncertainty = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 271;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ClockReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9c5d965bc1d857db6ee7aaa1ec215d3f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ClockReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.galToBdsTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.galToBdsTimeBiasMillisecondsUncertainty = msg.galToBdsTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.galToBdsTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.hasFCount !== undefined) {
      resolved.hasFCount = msg.hasFCount;
    }
    else {
      resolved.hasFCount = false
    }

    if (msg.bdsClockSource !== undefined) {
      resolved.bdsClockSource = msg.bdsClockSource;
    }
    else {
      resolved.bdsClockSource = 0
    }

    if (msg.clockFrequencyUncertainty !== undefined) {
      resolved.clockFrequencyUncertainty = msg.clockFrequencyUncertainty;
    }
    else {
      resolved.clockFrequencyUncertainty = 0.0
    }

    if (msg.gpsMilliseconds !== undefined) {
      resolved.gpsMilliseconds = msg.gpsMilliseconds;
    }
    else {
      resolved.gpsMilliseconds = 0
    }

    if (msg.hasGpsWeek !== undefined) {
      resolved.hasGpsWeek = msg.hasGpsWeek;
    }
    else {
      resolved.hasGpsWeek = false
    }

    if (msg.gpsToGlonassTimeBiasMilliseconds !== undefined) {
      resolved.gpsToGlonassTimeBiasMilliseconds = msg.gpsToGlonassTimeBiasMilliseconds;
    }
    else {
      resolved.gpsToGlonassTimeBiasMilliseconds = 0.0
    }

    if (msg.galWeek !== undefined) {
      resolved.galWeek = msg.galWeek;
    }
    else {
      resolved.galWeek = 0
    }

    if (msg.bdsMilliseconds !== undefined) {
      resolved.bdsMilliseconds = msg.bdsMilliseconds;
    }
    else {
      resolved.bdsMilliseconds = 0
    }

    if (msg.gpsToGalTimeBiasMilliseconds !== undefined) {
      resolved.gpsToGalTimeBiasMilliseconds = msg.gpsToGalTimeBiasMilliseconds;
    }
    else {
      resolved.gpsToGalTimeBiasMilliseconds = 0.0
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

    if (msg.bdsClockTimeUncertainty !== undefined) {
      resolved.bdsClockTimeUncertainty = msg.bdsClockTimeUncertainty;
    }
    else {
      resolved.bdsClockTimeUncertainty = 0.0
    }

    if (msg.gpsToBdsTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.gpsToBdsTimeBiasMillisecondsUncertainty = msg.gpsToBdsTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.gpsToBdsTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.glonassYear !== undefined) {
      resolved.glonassYear = msg.glonassYear;
    }
    else {
      resolved.glonassYear = 0
    }

    if (msg.galToGloTimeBiasMilliseconds !== undefined) {
      resolved.galToGloTimeBiasMilliseconds = msg.galToGloTimeBiasMilliseconds;
    }
    else {
      resolved.galToGloTimeBiasMilliseconds = 0.0
    }

    if (msg.galMilliseconds !== undefined) {
      resolved.galMilliseconds = msg.galMilliseconds;
    }
    else {
      resolved.galMilliseconds = 0
    }

    if (msg.galToGloTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.galToGloTimeBiasMillisecondsUncertainty = msg.galToGloTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.galToGloTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.clockFrequencyBias !== undefined) {
      resolved.clockFrequencyBias = msg.clockFrequencyBias;
    }
    else {
      resolved.clockFrequencyBias = 0.0
    }

    if (msg.fCount !== undefined) {
      resolved.fCount = msg.fCount;
    }
    else {
      resolved.fCount = 0
    }

    if (msg.gpsLeapSeconds !== undefined) {
      resolved.gpsLeapSeconds = msg.gpsLeapSeconds;
    }
    else {
      resolved.gpsLeapSeconds = 0
    }

    if (msg.hasRtcTime !== undefined) {
      resolved.hasRtcTime = msg.hasRtcTime;
    }
    else {
      resolved.hasRtcTime = false
    }

    if (msg.bdsWeek !== undefined) {
      resolved.bdsWeek = msg.bdsWeek;
    }
    else {
      resolved.bdsWeek = 0
    }

    if (msg.glonassClockTimeUncertainty !== undefined) {
      resolved.glonassClockTimeUncertainty = msg.glonassClockTimeUncertainty;
    }
    else {
      resolved.glonassClockTimeUncertainty = 0.0
    }

    if (msg.hasGlonassMilliseconds !== undefined) {
      resolved.hasGlonassMilliseconds = msg.hasGlonassMilliseconds;
    }
    else {
      resolved.hasGlonassMilliseconds = false
    }

    if (msg.systemRtcTime !== undefined) {
      resolved.systemRtcTime = msg.systemRtcTime;
    }
    else {
      resolved.systemRtcTime = 0
    }

    if (msg.bdsTimeBias !== undefined) {
      resolved.bdsTimeBias = msg.bdsTimeBias;
    }
    else {
      resolved.bdsTimeBias = 0.0
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

    if (msg.hasGlonassDay !== undefined) {
      resolved.hasGlonassDay = msg.hasGlonassDay;
    }
    else {
      resolved.hasGlonassDay = false
    }

    if (msg.gpsToGalTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.gpsToGalTimeBiasMillisecondsUncertainty = msg.gpsToGalTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.gpsToGalTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.galTimeBias !== undefined) {
      resolved.galTimeBias = msg.galTimeBias;
    }
    else {
      resolved.galTimeBias = 0.0
    }

    if (msg.galClockTimeUncertainty !== undefined) {
      resolved.galClockTimeUncertainty = msg.galClockTimeUncertainty;
    }
    else {
      resolved.galClockTimeUncertainty = 0.0
    }

    if (msg.gpsTimeBias !== undefined) {
      resolved.gpsTimeBias = msg.gpsTimeBias;
    }
    else {
      resolved.gpsTimeBias = 0.0
    }

    if (msg.lpmRtcCount !== undefined) {
      resolved.lpmRtcCount = msg.lpmRtcCount;
    }
    else {
      resolved.lpmRtcCount = 0
    }

    if (msg.glonassMilliseconds !== undefined) {
      resolved.glonassMilliseconds = msg.glonassMilliseconds;
    }
    else {
      resolved.glonassMilliseconds = 0
    }

    if (msg.fCountOffset !== undefined) {
      resolved.fCountOffset = msg.fCountOffset;
    }
    else {
      resolved.fCountOffset = 0
    }

    if (msg.bdsToGloTimeBiasMilliseconds !== undefined) {
      resolved.bdsToGloTimeBiasMilliseconds = msg.bdsToGloTimeBiasMilliseconds;
    }
    else {
      resolved.bdsToGloTimeBiasMilliseconds = 0.0
    }

    if (msg.clockResets !== undefined) {
      resolved.clockResets = msg.clockResets;
    }
    else {
      resolved.clockResets = 0
    }

    if (msg.gpsLeapSecondsSource !== undefined) {
      resolved.gpsLeapSecondsSource = msg.gpsLeapSecondsSource;
    }
    else {
      resolved.gpsLeapSecondsSource = 0
    }

    if (msg.galClockSource !== undefined) {
      resolved.galClockSource = msg.galClockSource;
    }
    else {
      resolved.galClockSource = 0
    }

    if (msg.hasGpsMilliseconds !== undefined) {
      resolved.hasGpsMilliseconds = msg.hasGpsMilliseconds;
    }
    else {
      resolved.hasGpsMilliseconds = false
    }

    if (msg.gpsToBdsTimeBiasMilliseconds !== undefined) {
      resolved.gpsToBdsTimeBiasMilliseconds = msg.gpsToBdsTimeBiasMilliseconds;
    }
    else {
      resolved.gpsToBdsTimeBiasMilliseconds = 0.0
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0
    }

    if (msg.gpsClockTimeUncertainty !== undefined) {
      resolved.gpsClockTimeUncertainty = msg.gpsClockTimeUncertainty;
    }
    else {
      resolved.gpsClockTimeUncertainty = 0.0
    }

    if (msg.bdsToGloTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.bdsToGloTimeBiasMillisecondsUncertainty = msg.bdsToGloTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.bdsToGloTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.hasGlonassYear !== undefined) {
      resolved.hasGlonassYear = msg.hasGlonassYear;
    }
    else {
      resolved.hasGlonassYear = false
    }

    if (msg.gpsToGlonassTimeBiasMillisecondsUncertainty !== undefined) {
      resolved.gpsToGlonassTimeBiasMillisecondsUncertainty = msg.gpsToGlonassTimeBiasMillisecondsUncertainty;
    }
    else {
      resolved.gpsToGlonassTimeBiasMillisecondsUncertainty = 0.0
    }

    if (msg.glonassClockSource !== undefined) {
      resolved.glonassClockSource = msg.glonassClockSource;
    }
    else {
      resolved.glonassClockSource = 0
    }

    if (msg.galToBdsTimeBiasMilliseconds !== undefined) {
      resolved.galToBdsTimeBiasMilliseconds = msg.galToBdsTimeBiasMilliseconds;
    }
    else {
      resolved.galToBdsTimeBiasMilliseconds = 0.0
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

module.exports = ClockReport;
