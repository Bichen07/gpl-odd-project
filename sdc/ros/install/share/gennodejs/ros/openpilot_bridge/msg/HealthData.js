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

class HealthData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gasInterceptorDetected = null;
      this.faultStatus = null;
      this.hasGps = null;
      this.fanSpeedRpm = null;
      this.startedSignalDetectedDeprecated = null;
      this.canRxErrs = null;
      this.faults = null;
      this.canFwdErrs = null;
      this.uptime = null;
      this.powerSaveEnabled = null;
      this.current = null;
      this.hwType = null;
      this.ignitionCan = null;
      this.voltage = null;
      this.canSendErrs = null;
      this.usbPowerMode = null;
      this.gmlanSendErrs = null;
      this.ignitionLine = null;
      this.safetyModel = null;
      this.controlsAllowed = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gasInterceptorDetected')) {
        this.gasInterceptorDetected = initObj.gasInterceptorDetected
      }
      else {
        this.gasInterceptorDetected = false;
      }
      if (initObj.hasOwnProperty('faultStatus')) {
        this.faultStatus = initObj.faultStatus
      }
      else {
        this.faultStatus = 0;
      }
      if (initObj.hasOwnProperty('hasGps')) {
        this.hasGps = initObj.hasGps
      }
      else {
        this.hasGps = false;
      }
      if (initObj.hasOwnProperty('fanSpeedRpm')) {
        this.fanSpeedRpm = initObj.fanSpeedRpm
      }
      else {
        this.fanSpeedRpm = 0;
      }
      if (initObj.hasOwnProperty('startedSignalDetectedDeprecated')) {
        this.startedSignalDetectedDeprecated = initObj.startedSignalDetectedDeprecated
      }
      else {
        this.startedSignalDetectedDeprecated = false;
      }
      if (initObj.hasOwnProperty('canRxErrs')) {
        this.canRxErrs = initObj.canRxErrs
      }
      else {
        this.canRxErrs = 0;
      }
      if (initObj.hasOwnProperty('faults')) {
        this.faults = initObj.faults
      }
      else {
        this.faults = [];
      }
      if (initObj.hasOwnProperty('canFwdErrs')) {
        this.canFwdErrs = initObj.canFwdErrs
      }
      else {
        this.canFwdErrs = 0;
      }
      if (initObj.hasOwnProperty('uptime')) {
        this.uptime = initObj.uptime
      }
      else {
        this.uptime = 0;
      }
      if (initObj.hasOwnProperty('powerSaveEnabled')) {
        this.powerSaveEnabled = initObj.powerSaveEnabled
      }
      else {
        this.powerSaveEnabled = false;
      }
      if (initObj.hasOwnProperty('current')) {
        this.current = initObj.current
      }
      else {
        this.current = 0;
      }
      if (initObj.hasOwnProperty('hwType')) {
        this.hwType = initObj.hwType
      }
      else {
        this.hwType = 0;
      }
      if (initObj.hasOwnProperty('ignitionCan')) {
        this.ignitionCan = initObj.ignitionCan
      }
      else {
        this.ignitionCan = false;
      }
      if (initObj.hasOwnProperty('voltage')) {
        this.voltage = initObj.voltage
      }
      else {
        this.voltage = 0;
      }
      if (initObj.hasOwnProperty('canSendErrs')) {
        this.canSendErrs = initObj.canSendErrs
      }
      else {
        this.canSendErrs = 0;
      }
      if (initObj.hasOwnProperty('usbPowerMode')) {
        this.usbPowerMode = initObj.usbPowerMode
      }
      else {
        this.usbPowerMode = 0;
      }
      if (initObj.hasOwnProperty('gmlanSendErrs')) {
        this.gmlanSendErrs = initObj.gmlanSendErrs
      }
      else {
        this.gmlanSendErrs = 0;
      }
      if (initObj.hasOwnProperty('ignitionLine')) {
        this.ignitionLine = initObj.ignitionLine
      }
      else {
        this.ignitionLine = false;
      }
      if (initObj.hasOwnProperty('safetyModel')) {
        this.safetyModel = initObj.safetyModel
      }
      else {
        this.safetyModel = 0;
      }
      if (initObj.hasOwnProperty('controlsAllowed')) {
        this.controlsAllowed = initObj.controlsAllowed
      }
      else {
        this.controlsAllowed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HealthData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gasInterceptorDetected]
    bufferOffset = _serializer.bool(obj.gasInterceptorDetected, buffer, bufferOffset);
    // Serialize message field [faultStatus]
    bufferOffset = _serializer.uint32(obj.faultStatus, buffer, bufferOffset);
    // Serialize message field [hasGps]
    bufferOffset = _serializer.bool(obj.hasGps, buffer, bufferOffset);
    // Serialize message field [fanSpeedRpm]
    bufferOffset = _serializer.int64(obj.fanSpeedRpm, buffer, bufferOffset);
    // Serialize message field [startedSignalDetectedDeprecated]
    bufferOffset = _serializer.bool(obj.startedSignalDetectedDeprecated, buffer, bufferOffset);
    // Serialize message field [canRxErrs]
    bufferOffset = _serializer.int64(obj.canRxErrs, buffer, bufferOffset);
    // Serialize message field [faults]
    bufferOffset = _arraySerializer.uint32(obj.faults, buffer, bufferOffset, null);
    // Serialize message field [canFwdErrs]
    bufferOffset = _serializer.int64(obj.canFwdErrs, buffer, bufferOffset);
    // Serialize message field [uptime]
    bufferOffset = _serializer.int64(obj.uptime, buffer, bufferOffset);
    // Serialize message field [powerSaveEnabled]
    bufferOffset = _serializer.bool(obj.powerSaveEnabled, buffer, bufferOffset);
    // Serialize message field [current]
    bufferOffset = _serializer.int64(obj.current, buffer, bufferOffset);
    // Serialize message field [hwType]
    bufferOffset = _serializer.uint32(obj.hwType, buffer, bufferOffset);
    // Serialize message field [ignitionCan]
    bufferOffset = _serializer.bool(obj.ignitionCan, buffer, bufferOffset);
    // Serialize message field [voltage]
    bufferOffset = _serializer.int64(obj.voltage, buffer, bufferOffset);
    // Serialize message field [canSendErrs]
    bufferOffset = _serializer.int64(obj.canSendErrs, buffer, bufferOffset);
    // Serialize message field [usbPowerMode]
    bufferOffset = _serializer.uint32(obj.usbPowerMode, buffer, bufferOffset);
    // Serialize message field [gmlanSendErrs]
    bufferOffset = _serializer.int64(obj.gmlanSendErrs, buffer, bufferOffset);
    // Serialize message field [ignitionLine]
    bufferOffset = _serializer.bool(obj.ignitionLine, buffer, bufferOffset);
    // Serialize message field [safetyModel]
    bufferOffset = _serializer.uint32(obj.safetyModel, buffer, bufferOffset);
    // Serialize message field [controlsAllowed]
    bufferOffset = _serializer.bool(obj.controlsAllowed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HealthData
    let len;
    let data = new HealthData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gasInterceptorDetected]
    data.gasInterceptorDetected = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [faultStatus]
    data.faultStatus = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [hasGps]
    data.hasGps = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fanSpeedRpm]
    data.fanSpeedRpm = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [startedSignalDetectedDeprecated]
    data.startedSignalDetectedDeprecated = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [canRxErrs]
    data.canRxErrs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [faults]
    data.faults = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [canFwdErrs]
    data.canFwdErrs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [uptime]
    data.uptime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [powerSaveEnabled]
    data.powerSaveEnabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [current]
    data.current = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [hwType]
    data.hwType = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [ignitionCan]
    data.ignitionCan = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [voltage]
    data.voltage = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [canSendErrs]
    data.canSendErrs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [usbPowerMode]
    data.usbPowerMode = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [gmlanSendErrs]
    data.gmlanSendErrs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [ignitionLine]
    data.ignitionLine = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [safetyModel]
    data.safetyModel = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [controlsAllowed]
    data.controlsAllowed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.faults.length;
    return length + 91;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/HealthData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '383ae8386ab9b895fcd32fe297b6db75';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool gasInterceptorDetected
    uint32 faultStatus # enum const: FaultStatus
    bool hasGps
    int64 fanSpeedRpm
    bool startedSignalDetectedDeprecated
    int64 canRxErrs
    uint32[] faults # enum const: FaultType
    int64 canFwdErrs
    int64 uptime
    bool powerSaveEnabled
    int64 current
    uint32 hwType # enum const: HwType
    bool ignitionCan
    int64 voltage
    int64 canSendErrs
    uint32 usbPowerMode # enum const: UsbPowerMode
    int64 gmlanSendErrs
    bool ignitionLine
    uint32 safetyModel # enum const: SafetyModel
    bool controlsAllowed
    
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
    const resolved = new HealthData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gasInterceptorDetected !== undefined) {
      resolved.gasInterceptorDetected = msg.gasInterceptorDetected;
    }
    else {
      resolved.gasInterceptorDetected = false
    }

    if (msg.faultStatus !== undefined) {
      resolved.faultStatus = msg.faultStatus;
    }
    else {
      resolved.faultStatus = 0
    }

    if (msg.hasGps !== undefined) {
      resolved.hasGps = msg.hasGps;
    }
    else {
      resolved.hasGps = false
    }

    if (msg.fanSpeedRpm !== undefined) {
      resolved.fanSpeedRpm = msg.fanSpeedRpm;
    }
    else {
      resolved.fanSpeedRpm = 0
    }

    if (msg.startedSignalDetectedDeprecated !== undefined) {
      resolved.startedSignalDetectedDeprecated = msg.startedSignalDetectedDeprecated;
    }
    else {
      resolved.startedSignalDetectedDeprecated = false
    }

    if (msg.canRxErrs !== undefined) {
      resolved.canRxErrs = msg.canRxErrs;
    }
    else {
      resolved.canRxErrs = 0
    }

    if (msg.faults !== undefined) {
      resolved.faults = msg.faults;
    }
    else {
      resolved.faults = []
    }

    if (msg.canFwdErrs !== undefined) {
      resolved.canFwdErrs = msg.canFwdErrs;
    }
    else {
      resolved.canFwdErrs = 0
    }

    if (msg.uptime !== undefined) {
      resolved.uptime = msg.uptime;
    }
    else {
      resolved.uptime = 0
    }

    if (msg.powerSaveEnabled !== undefined) {
      resolved.powerSaveEnabled = msg.powerSaveEnabled;
    }
    else {
      resolved.powerSaveEnabled = false
    }

    if (msg.current !== undefined) {
      resolved.current = msg.current;
    }
    else {
      resolved.current = 0
    }

    if (msg.hwType !== undefined) {
      resolved.hwType = msg.hwType;
    }
    else {
      resolved.hwType = 0
    }

    if (msg.ignitionCan !== undefined) {
      resolved.ignitionCan = msg.ignitionCan;
    }
    else {
      resolved.ignitionCan = false
    }

    if (msg.voltage !== undefined) {
      resolved.voltage = msg.voltage;
    }
    else {
      resolved.voltage = 0
    }

    if (msg.canSendErrs !== undefined) {
      resolved.canSendErrs = msg.canSendErrs;
    }
    else {
      resolved.canSendErrs = 0
    }

    if (msg.usbPowerMode !== undefined) {
      resolved.usbPowerMode = msg.usbPowerMode;
    }
    else {
      resolved.usbPowerMode = 0
    }

    if (msg.gmlanSendErrs !== undefined) {
      resolved.gmlanSendErrs = msg.gmlanSendErrs;
    }
    else {
      resolved.gmlanSendErrs = 0
    }

    if (msg.ignitionLine !== undefined) {
      resolved.ignitionLine = msg.ignitionLine;
    }
    else {
      resolved.ignitionLine = false
    }

    if (msg.safetyModel !== undefined) {
      resolved.safetyModel = msg.safetyModel;
    }
    else {
      resolved.safetyModel = 0
    }

    if (msg.controlsAllowed !== undefined) {
      resolved.controlsAllowed = msg.controlsAllowed;
    }
    else {
      resolved.controlsAllowed = false
    }

    return resolved;
    }
};

module.exports = HealthData;
