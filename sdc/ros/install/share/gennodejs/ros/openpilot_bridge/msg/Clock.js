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

class Clock {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.hasDriftUncertaintyNanosPerSecond = null;
      this.timeNanos = null;
      this.driftUncertaintyNanosPerSecond = null;
      this.hasBiasNanos = null;
      this.timeUncertaintyNanos = null;
      this.fullBiasNanos = null;
      this.hasLeapSecond = null;
      this.leapSecond = null;
      this.hasTimeUncertaintyNanos = null;
      this.hardwareClockDiscontinuityCount = null;
      this.driftNanosPerSecond = null;
      this.biasNanos = null;
      this.hasDriftNanosPerSecond = null;
      this.hasFullBiasNanos = null;
      this.biasUncertaintyNanos = null;
      this.hasBiasUncertaintyNanos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('hasDriftUncertaintyNanosPerSecond')) {
        this.hasDriftUncertaintyNanosPerSecond = initObj.hasDriftUncertaintyNanosPerSecond
      }
      else {
        this.hasDriftUncertaintyNanosPerSecond = false;
      }
      if (initObj.hasOwnProperty('timeNanos')) {
        this.timeNanos = initObj.timeNanos
      }
      else {
        this.timeNanos = 0;
      }
      if (initObj.hasOwnProperty('driftUncertaintyNanosPerSecond')) {
        this.driftUncertaintyNanosPerSecond = initObj.driftUncertaintyNanosPerSecond
      }
      else {
        this.driftUncertaintyNanosPerSecond = 0.0;
      }
      if (initObj.hasOwnProperty('hasBiasNanos')) {
        this.hasBiasNanos = initObj.hasBiasNanos
      }
      else {
        this.hasBiasNanos = false;
      }
      if (initObj.hasOwnProperty('timeUncertaintyNanos')) {
        this.timeUncertaintyNanos = initObj.timeUncertaintyNanos
      }
      else {
        this.timeUncertaintyNanos = 0.0;
      }
      if (initObj.hasOwnProperty('fullBiasNanos')) {
        this.fullBiasNanos = initObj.fullBiasNanos
      }
      else {
        this.fullBiasNanos = 0;
      }
      if (initObj.hasOwnProperty('hasLeapSecond')) {
        this.hasLeapSecond = initObj.hasLeapSecond
      }
      else {
        this.hasLeapSecond = false;
      }
      if (initObj.hasOwnProperty('leapSecond')) {
        this.leapSecond = initObj.leapSecond
      }
      else {
        this.leapSecond = 0;
      }
      if (initObj.hasOwnProperty('hasTimeUncertaintyNanos')) {
        this.hasTimeUncertaintyNanos = initObj.hasTimeUncertaintyNanos
      }
      else {
        this.hasTimeUncertaintyNanos = false;
      }
      if (initObj.hasOwnProperty('hardwareClockDiscontinuityCount')) {
        this.hardwareClockDiscontinuityCount = initObj.hardwareClockDiscontinuityCount
      }
      else {
        this.hardwareClockDiscontinuityCount = 0;
      }
      if (initObj.hasOwnProperty('driftNanosPerSecond')) {
        this.driftNanosPerSecond = initObj.driftNanosPerSecond
      }
      else {
        this.driftNanosPerSecond = 0.0;
      }
      if (initObj.hasOwnProperty('biasNanos')) {
        this.biasNanos = initObj.biasNanos
      }
      else {
        this.biasNanos = 0.0;
      }
      if (initObj.hasOwnProperty('hasDriftNanosPerSecond')) {
        this.hasDriftNanosPerSecond = initObj.hasDriftNanosPerSecond
      }
      else {
        this.hasDriftNanosPerSecond = false;
      }
      if (initObj.hasOwnProperty('hasFullBiasNanos')) {
        this.hasFullBiasNanos = initObj.hasFullBiasNanos
      }
      else {
        this.hasFullBiasNanos = false;
      }
      if (initObj.hasOwnProperty('biasUncertaintyNanos')) {
        this.biasUncertaintyNanos = initObj.biasUncertaintyNanos
      }
      else {
        this.biasUncertaintyNanos = 0.0;
      }
      if (initObj.hasOwnProperty('hasBiasUncertaintyNanos')) {
        this.hasBiasUncertaintyNanos = initObj.hasBiasUncertaintyNanos
      }
      else {
        this.hasBiasUncertaintyNanos = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Clock
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [hasDriftUncertaintyNanosPerSecond]
    bufferOffset = _serializer.bool(obj.hasDriftUncertaintyNanosPerSecond, buffer, bufferOffset);
    // Serialize message field [timeNanos]
    bufferOffset = _serializer.int32(obj.timeNanos, buffer, bufferOffset);
    // Serialize message field [driftUncertaintyNanosPerSecond]
    bufferOffset = _serializer.float32(obj.driftUncertaintyNanosPerSecond, buffer, bufferOffset);
    // Serialize message field [hasBiasNanos]
    bufferOffset = _serializer.bool(obj.hasBiasNanos, buffer, bufferOffset);
    // Serialize message field [timeUncertaintyNanos]
    bufferOffset = _serializer.float32(obj.timeUncertaintyNanos, buffer, bufferOffset);
    // Serialize message field [fullBiasNanos]
    bufferOffset = _serializer.int32(obj.fullBiasNanos, buffer, bufferOffset);
    // Serialize message field [hasLeapSecond]
    bufferOffset = _serializer.bool(obj.hasLeapSecond, buffer, bufferOffset);
    // Serialize message field [leapSecond]
    bufferOffset = _serializer.int32(obj.leapSecond, buffer, bufferOffset);
    // Serialize message field [hasTimeUncertaintyNanos]
    bufferOffset = _serializer.bool(obj.hasTimeUncertaintyNanos, buffer, bufferOffset);
    // Serialize message field [hardwareClockDiscontinuityCount]
    bufferOffset = _serializer.int32(obj.hardwareClockDiscontinuityCount, buffer, bufferOffset);
    // Serialize message field [driftNanosPerSecond]
    bufferOffset = _serializer.float32(obj.driftNanosPerSecond, buffer, bufferOffset);
    // Serialize message field [biasNanos]
    bufferOffset = _serializer.float32(obj.biasNanos, buffer, bufferOffset);
    // Serialize message field [hasDriftNanosPerSecond]
    bufferOffset = _serializer.bool(obj.hasDriftNanosPerSecond, buffer, bufferOffset);
    // Serialize message field [hasFullBiasNanos]
    bufferOffset = _serializer.bool(obj.hasFullBiasNanos, buffer, bufferOffset);
    // Serialize message field [biasUncertaintyNanos]
    bufferOffset = _serializer.float32(obj.biasUncertaintyNanos, buffer, bufferOffset);
    // Serialize message field [hasBiasUncertaintyNanos]
    bufferOffset = _serializer.bool(obj.hasBiasUncertaintyNanos, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Clock
    let len;
    let data = new Clock(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [hasDriftUncertaintyNanosPerSecond]
    data.hasDriftUncertaintyNanosPerSecond = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [timeNanos]
    data.timeNanos = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [driftUncertaintyNanosPerSecond]
    data.driftUncertaintyNanosPerSecond = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasBiasNanos]
    data.hasBiasNanos = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [timeUncertaintyNanos]
    data.timeUncertaintyNanos = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fullBiasNanos]
    data.fullBiasNanos = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [hasLeapSecond]
    data.hasLeapSecond = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [leapSecond]
    data.leapSecond = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [hasTimeUncertaintyNanos]
    data.hasTimeUncertaintyNanos = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [hardwareClockDiscontinuityCount]
    data.hardwareClockDiscontinuityCount = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [driftNanosPerSecond]
    data.driftNanosPerSecond = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [biasNanos]
    data.biasNanos = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasDriftNanosPerSecond]
    data.hasDriftNanosPerSecond = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [hasFullBiasNanos]
    data.hasFullBiasNanos = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [biasUncertaintyNanos]
    data.biasUncertaintyNanos = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasBiasUncertaintyNanos]
    data.hasBiasUncertaintyNanos = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 43;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Clock';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '17720c4456ed360b148a53bf937ff2b3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Clock(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.hasDriftUncertaintyNanosPerSecond !== undefined) {
      resolved.hasDriftUncertaintyNanosPerSecond = msg.hasDriftUncertaintyNanosPerSecond;
    }
    else {
      resolved.hasDriftUncertaintyNanosPerSecond = false
    }

    if (msg.timeNanos !== undefined) {
      resolved.timeNanos = msg.timeNanos;
    }
    else {
      resolved.timeNanos = 0
    }

    if (msg.driftUncertaintyNanosPerSecond !== undefined) {
      resolved.driftUncertaintyNanosPerSecond = msg.driftUncertaintyNanosPerSecond;
    }
    else {
      resolved.driftUncertaintyNanosPerSecond = 0.0
    }

    if (msg.hasBiasNanos !== undefined) {
      resolved.hasBiasNanos = msg.hasBiasNanos;
    }
    else {
      resolved.hasBiasNanos = false
    }

    if (msg.timeUncertaintyNanos !== undefined) {
      resolved.timeUncertaintyNanos = msg.timeUncertaintyNanos;
    }
    else {
      resolved.timeUncertaintyNanos = 0.0
    }

    if (msg.fullBiasNanos !== undefined) {
      resolved.fullBiasNanos = msg.fullBiasNanos;
    }
    else {
      resolved.fullBiasNanos = 0
    }

    if (msg.hasLeapSecond !== undefined) {
      resolved.hasLeapSecond = msg.hasLeapSecond;
    }
    else {
      resolved.hasLeapSecond = false
    }

    if (msg.leapSecond !== undefined) {
      resolved.leapSecond = msg.leapSecond;
    }
    else {
      resolved.leapSecond = 0
    }

    if (msg.hasTimeUncertaintyNanos !== undefined) {
      resolved.hasTimeUncertaintyNanos = msg.hasTimeUncertaintyNanos;
    }
    else {
      resolved.hasTimeUncertaintyNanos = false
    }

    if (msg.hardwareClockDiscontinuityCount !== undefined) {
      resolved.hardwareClockDiscontinuityCount = msg.hardwareClockDiscontinuityCount;
    }
    else {
      resolved.hardwareClockDiscontinuityCount = 0
    }

    if (msg.driftNanosPerSecond !== undefined) {
      resolved.driftNanosPerSecond = msg.driftNanosPerSecond;
    }
    else {
      resolved.driftNanosPerSecond = 0.0
    }

    if (msg.biasNanos !== undefined) {
      resolved.biasNanos = msg.biasNanos;
    }
    else {
      resolved.biasNanos = 0.0
    }

    if (msg.hasDriftNanosPerSecond !== undefined) {
      resolved.hasDriftNanosPerSecond = msg.hasDriftNanosPerSecond;
    }
    else {
      resolved.hasDriftNanosPerSecond = false
    }

    if (msg.hasFullBiasNanos !== undefined) {
      resolved.hasFullBiasNanos = msg.hasFullBiasNanos;
    }
    else {
      resolved.hasFullBiasNanos = false
    }

    if (msg.biasUncertaintyNanos !== undefined) {
      resolved.biasUncertaintyNanos = msg.biasUncertaintyNanos;
    }
    else {
      resolved.biasUncertaintyNanos = 0.0
    }

    if (msg.hasBiasUncertaintyNanos !== undefined) {
      resolved.hasBiasUncertaintyNanos = msg.hasBiasUncertaintyNanos;
    }
    else {
      resolved.hasBiasUncertaintyNanos = false
    }

    return resolved;
    }
};

module.exports = Clock;
