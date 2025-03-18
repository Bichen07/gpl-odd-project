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

class ThermalData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.batteryVoltage = null;
      this.chargingError = null;
      this.cpuPerc = null;
      this.chargingDisabled = null;
      this.fanSpeed = null;
      this.batteryCurrent = null;
      this.started = null;
      this.pa0 = null;
      this.batteryPercent = null;
      this.gpu = null;
      this.thermalStatus = null;
      this.freeSpace = null;
      this.usbOnline = null;
      this.mem = null;
      this.cpu2 = null;
      this.cpu3 = null;
      this.cpu0 = null;
      this.cpu1 = null;
      this.startedTs = null;
      this.batteryStatus = null;
      this.memUsedPercent = null;
      this.bat = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('batteryVoltage')) {
        this.batteryVoltage = initObj.batteryVoltage
      }
      else {
        this.batteryVoltage = 0;
      }
      if (initObj.hasOwnProperty('chargingError')) {
        this.chargingError = initObj.chargingError
      }
      else {
        this.chargingError = false;
      }
      if (initObj.hasOwnProperty('cpuPerc')) {
        this.cpuPerc = initObj.cpuPerc
      }
      else {
        this.cpuPerc = 0;
      }
      if (initObj.hasOwnProperty('chargingDisabled')) {
        this.chargingDisabled = initObj.chargingDisabled
      }
      else {
        this.chargingDisabled = false;
      }
      if (initObj.hasOwnProperty('fanSpeed')) {
        this.fanSpeed = initObj.fanSpeed
      }
      else {
        this.fanSpeed = 0;
      }
      if (initObj.hasOwnProperty('batteryCurrent')) {
        this.batteryCurrent = initObj.batteryCurrent
      }
      else {
        this.batteryCurrent = 0;
      }
      if (initObj.hasOwnProperty('started')) {
        this.started = initObj.started
      }
      else {
        this.started = false;
      }
      if (initObj.hasOwnProperty('pa0')) {
        this.pa0 = initObj.pa0
      }
      else {
        this.pa0 = 0;
      }
      if (initObj.hasOwnProperty('batteryPercent')) {
        this.batteryPercent = initObj.batteryPercent
      }
      else {
        this.batteryPercent = 0;
      }
      if (initObj.hasOwnProperty('gpu')) {
        this.gpu = initObj.gpu
      }
      else {
        this.gpu = 0;
      }
      if (initObj.hasOwnProperty('thermalStatus')) {
        this.thermalStatus = initObj.thermalStatus
      }
      else {
        this.thermalStatus = 0;
      }
      if (initObj.hasOwnProperty('freeSpace')) {
        this.freeSpace = initObj.freeSpace
      }
      else {
        this.freeSpace = 0.0;
      }
      if (initObj.hasOwnProperty('usbOnline')) {
        this.usbOnline = initObj.usbOnline
      }
      else {
        this.usbOnline = false;
      }
      if (initObj.hasOwnProperty('mem')) {
        this.mem = initObj.mem
      }
      else {
        this.mem = 0;
      }
      if (initObj.hasOwnProperty('cpu2')) {
        this.cpu2 = initObj.cpu2
      }
      else {
        this.cpu2 = 0;
      }
      if (initObj.hasOwnProperty('cpu3')) {
        this.cpu3 = initObj.cpu3
      }
      else {
        this.cpu3 = 0;
      }
      if (initObj.hasOwnProperty('cpu0')) {
        this.cpu0 = initObj.cpu0
      }
      else {
        this.cpu0 = 0;
      }
      if (initObj.hasOwnProperty('cpu1')) {
        this.cpu1 = initObj.cpu1
      }
      else {
        this.cpu1 = 0;
      }
      if (initObj.hasOwnProperty('startedTs')) {
        this.startedTs = initObj.startedTs
      }
      else {
        this.startedTs = 0;
      }
      if (initObj.hasOwnProperty('batteryStatus')) {
        this.batteryStatus = initObj.batteryStatus
      }
      else {
        this.batteryStatus = [];
      }
      if (initObj.hasOwnProperty('memUsedPercent')) {
        this.memUsedPercent = initObj.memUsedPercent
      }
      else {
        this.memUsedPercent = 0;
      }
      if (initObj.hasOwnProperty('bat')) {
        this.bat = initObj.bat
      }
      else {
        this.bat = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ThermalData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [batteryVoltage]
    bufferOffset = _serializer.int32(obj.batteryVoltage, buffer, bufferOffset);
    // Serialize message field [chargingError]
    bufferOffset = _serializer.bool(obj.chargingError, buffer, bufferOffset);
    // Serialize message field [cpuPerc]
    bufferOffset = _serializer.int32(obj.cpuPerc, buffer, bufferOffset);
    // Serialize message field [chargingDisabled]
    bufferOffset = _serializer.bool(obj.chargingDisabled, buffer, bufferOffset);
    // Serialize message field [fanSpeed]
    bufferOffset = _serializer.int64(obj.fanSpeed, buffer, bufferOffset);
    // Serialize message field [batteryCurrent]
    bufferOffset = _serializer.int32(obj.batteryCurrent, buffer, bufferOffset);
    // Serialize message field [started]
    bufferOffset = _serializer.bool(obj.started, buffer, bufferOffset);
    // Serialize message field [pa0]
    bufferOffset = _serializer.int64(obj.pa0, buffer, bufferOffset);
    // Serialize message field [batteryPercent]
    bufferOffset = _serializer.int32(obj.batteryPercent, buffer, bufferOffset);
    // Serialize message field [gpu]
    bufferOffset = _serializer.int64(obj.gpu, buffer, bufferOffset);
    // Serialize message field [thermalStatus]
    bufferOffset = _serializer.uint32(obj.thermalStatus, buffer, bufferOffset);
    // Serialize message field [freeSpace]
    bufferOffset = _serializer.float32(obj.freeSpace, buffer, bufferOffset);
    // Serialize message field [usbOnline]
    bufferOffset = _serializer.bool(obj.usbOnline, buffer, bufferOffset);
    // Serialize message field [mem]
    bufferOffset = _serializer.int64(obj.mem, buffer, bufferOffset);
    // Serialize message field [cpu2]
    bufferOffset = _serializer.int64(obj.cpu2, buffer, bufferOffset);
    // Serialize message field [cpu3]
    bufferOffset = _serializer.int64(obj.cpu3, buffer, bufferOffset);
    // Serialize message field [cpu0]
    bufferOffset = _serializer.int64(obj.cpu0, buffer, bufferOffset);
    // Serialize message field [cpu1]
    bufferOffset = _serializer.int64(obj.cpu1, buffer, bufferOffset);
    // Serialize message field [startedTs]
    bufferOffset = _serializer.int64(obj.startedTs, buffer, bufferOffset);
    // Serialize message field [batteryStatus]
    bufferOffset = _arraySerializer.string(obj.batteryStatus, buffer, bufferOffset, null);
    // Serialize message field [memUsedPercent]
    bufferOffset = _serializer.int32(obj.memUsedPercent, buffer, bufferOffset);
    // Serialize message field [bat]
    bufferOffset = _serializer.int64(obj.bat, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ThermalData
    let len;
    let data = new ThermalData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [batteryVoltage]
    data.batteryVoltage = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [chargingError]
    data.chargingError = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cpuPerc]
    data.cpuPerc = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [chargingDisabled]
    data.chargingDisabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fanSpeed]
    data.fanSpeed = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [batteryCurrent]
    data.batteryCurrent = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [started]
    data.started = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [pa0]
    data.pa0 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [batteryPercent]
    data.batteryPercent = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [gpu]
    data.gpu = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [thermalStatus]
    data.thermalStatus = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [freeSpace]
    data.freeSpace = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [usbOnline]
    data.usbOnline = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mem]
    data.mem = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cpu2]
    data.cpu2 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cpu3]
    data.cpu3 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cpu0]
    data.cpu0 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cpu1]
    data.cpu1 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [startedTs]
    data.startedTs = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [batteryStatus]
    data.batteryStatus = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [memUsedPercent]
    data.memUsedPercent = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [bat]
    data.bat = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.batteryStatus.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 116;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ThermalData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b82c596c149fdb826f5238d89c0ed390';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 batteryVoltage
    bool chargingError
    int32 cpuPerc
    bool chargingDisabled
    int64 fanSpeed
    int32 batteryCurrent
    bool started
    int64 pa0
    int32 batteryPercent
    int64 gpu
    uint32 thermalStatus # enum const: ThermalStatus
    float32 freeSpace
    bool usbOnline
    int64 mem
    int64 cpu2
    int64 cpu3
    int64 cpu0
    int64 cpu1
    int64 startedTs
    string[] batteryStatus
    int32 memUsedPercent
    int64 bat
    
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
    const resolved = new ThermalData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.batteryVoltage !== undefined) {
      resolved.batteryVoltage = msg.batteryVoltage;
    }
    else {
      resolved.batteryVoltage = 0
    }

    if (msg.chargingError !== undefined) {
      resolved.chargingError = msg.chargingError;
    }
    else {
      resolved.chargingError = false
    }

    if (msg.cpuPerc !== undefined) {
      resolved.cpuPerc = msg.cpuPerc;
    }
    else {
      resolved.cpuPerc = 0
    }

    if (msg.chargingDisabled !== undefined) {
      resolved.chargingDisabled = msg.chargingDisabled;
    }
    else {
      resolved.chargingDisabled = false
    }

    if (msg.fanSpeed !== undefined) {
      resolved.fanSpeed = msg.fanSpeed;
    }
    else {
      resolved.fanSpeed = 0
    }

    if (msg.batteryCurrent !== undefined) {
      resolved.batteryCurrent = msg.batteryCurrent;
    }
    else {
      resolved.batteryCurrent = 0
    }

    if (msg.started !== undefined) {
      resolved.started = msg.started;
    }
    else {
      resolved.started = false
    }

    if (msg.pa0 !== undefined) {
      resolved.pa0 = msg.pa0;
    }
    else {
      resolved.pa0 = 0
    }

    if (msg.batteryPercent !== undefined) {
      resolved.batteryPercent = msg.batteryPercent;
    }
    else {
      resolved.batteryPercent = 0
    }

    if (msg.gpu !== undefined) {
      resolved.gpu = msg.gpu;
    }
    else {
      resolved.gpu = 0
    }

    if (msg.thermalStatus !== undefined) {
      resolved.thermalStatus = msg.thermalStatus;
    }
    else {
      resolved.thermalStatus = 0
    }

    if (msg.freeSpace !== undefined) {
      resolved.freeSpace = msg.freeSpace;
    }
    else {
      resolved.freeSpace = 0.0
    }

    if (msg.usbOnline !== undefined) {
      resolved.usbOnline = msg.usbOnline;
    }
    else {
      resolved.usbOnline = false
    }

    if (msg.mem !== undefined) {
      resolved.mem = msg.mem;
    }
    else {
      resolved.mem = 0
    }

    if (msg.cpu2 !== undefined) {
      resolved.cpu2 = msg.cpu2;
    }
    else {
      resolved.cpu2 = 0
    }

    if (msg.cpu3 !== undefined) {
      resolved.cpu3 = msg.cpu3;
    }
    else {
      resolved.cpu3 = 0
    }

    if (msg.cpu0 !== undefined) {
      resolved.cpu0 = msg.cpu0;
    }
    else {
      resolved.cpu0 = 0
    }

    if (msg.cpu1 !== undefined) {
      resolved.cpu1 = msg.cpu1;
    }
    else {
      resolved.cpu1 = 0
    }

    if (msg.startedTs !== undefined) {
      resolved.startedTs = msg.startedTs;
    }
    else {
      resolved.startedTs = 0
    }

    if (msg.batteryStatus !== undefined) {
      resolved.batteryStatus = msg.batteryStatus;
    }
    else {
      resolved.batteryStatus = []
    }

    if (msg.memUsedPercent !== undefined) {
      resolved.memUsedPercent = msg.memUsedPercent;
    }
    else {
      resolved.memUsedPercent = 0
    }

    if (msg.bat !== undefined) {
      resolved.bat = msg.bat;
    }
    else {
      resolved.bat = 0
    }

    return resolved;
    }
};

module.exports = ThermalData;
