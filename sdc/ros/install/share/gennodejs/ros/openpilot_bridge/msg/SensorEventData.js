// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SensorVec = require('./SensorVec.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class SensorEventData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.acceleration = null;
      this.gyroUncalibrated = null;
      this.light = null;
      this.orientation = null;
      this.pressure = null;
      this.sensor = null;
      this.magnetic = null;
      this.magneticUncalibrated = null;
      this.source = null;
      this.gyro = null;
      this.version = null;
      this.timestamp = null;
      this.type = null;
      this.proximity = null;
      this.uncalibratedDEPRECATED = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = new SensorVec();
      }
      if (initObj.hasOwnProperty('gyroUncalibrated')) {
        this.gyroUncalibrated = initObj.gyroUncalibrated
      }
      else {
        this.gyroUncalibrated = new SensorVec();
      }
      if (initObj.hasOwnProperty('light')) {
        this.light = initObj.light
      }
      else {
        this.light = 0.0;
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = new SensorVec();
      }
      if (initObj.hasOwnProperty('pressure')) {
        this.pressure = initObj.pressure
      }
      else {
        this.pressure = new SensorVec();
      }
      if (initObj.hasOwnProperty('sensor')) {
        this.sensor = initObj.sensor
      }
      else {
        this.sensor = 0;
      }
      if (initObj.hasOwnProperty('magnetic')) {
        this.magnetic = initObj.magnetic
      }
      else {
        this.magnetic = new SensorVec();
      }
      if (initObj.hasOwnProperty('magneticUncalibrated')) {
        this.magneticUncalibrated = initObj.magneticUncalibrated
      }
      else {
        this.magneticUncalibrated = new SensorVec();
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
      if (initObj.hasOwnProperty('gyro')) {
        this.gyro = initObj.gyro
      }
      else {
        this.gyro = new SensorVec();
      }
      if (initObj.hasOwnProperty('version')) {
        this.version = initObj.version
      }
      else {
        this.version = 0;
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('proximity')) {
        this.proximity = initObj.proximity
      }
      else {
        this.proximity = 0.0;
      }
      if (initObj.hasOwnProperty('uncalibratedDEPRECATED')) {
        this.uncalibratedDEPRECATED = initObj.uncalibratedDEPRECATED
      }
      else {
        this.uncalibratedDEPRECATED = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SensorEventData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = SensorVec.serialize(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [gyroUncalibrated]
    bufferOffset = SensorVec.serialize(obj.gyroUncalibrated, buffer, bufferOffset);
    // Serialize message field [light]
    bufferOffset = _serializer.float32(obj.light, buffer, bufferOffset);
    // Serialize message field [orientation]
    bufferOffset = SensorVec.serialize(obj.orientation, buffer, bufferOffset);
    // Serialize message field [pressure]
    bufferOffset = SensorVec.serialize(obj.pressure, buffer, bufferOffset);
    // Serialize message field [sensor]
    bufferOffset = _serializer.int32(obj.sensor, buffer, bufferOffset);
    // Serialize message field [magnetic]
    bufferOffset = SensorVec.serialize(obj.magnetic, buffer, bufferOffset);
    // Serialize message field [magneticUncalibrated]
    bufferOffset = SensorVec.serialize(obj.magneticUncalibrated, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.uint32(obj.source, buffer, bufferOffset);
    // Serialize message field [gyro]
    bufferOffset = SensorVec.serialize(obj.gyro, buffer, bufferOffset);
    // Serialize message field [version]
    bufferOffset = _serializer.int32(obj.version, buffer, bufferOffset);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.int32(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [proximity]
    bufferOffset = _serializer.float32(obj.proximity, buffer, bufferOffset);
    // Serialize message field [uncalibratedDEPRECATED]
    bufferOffset = _serializer.bool(obj.uncalibratedDEPRECATED, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SensorEventData
    let len;
    let data = new SensorEventData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [gyroUncalibrated]
    data.gyroUncalibrated = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [light]
    data.light = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [orientation]
    data.orientation = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [pressure]
    data.pressure = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [sensor]
    data.sensor = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [magnetic]
    data.magnetic = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [magneticUncalibrated]
    data.magneticUncalibrated = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [gyro]
    data.gyro = SensorVec.deserialize(buffer, bufferOffset);
    // Deserialize message field [version]
    data.version = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [proximity]
    data.proximity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [uncalibratedDEPRECATED]
    data.uncalibratedDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += SensorVec.getMessageSize(object.acceleration);
    length += SensorVec.getMessageSize(object.gyroUncalibrated);
    length += SensorVec.getMessageSize(object.orientation);
    length += SensorVec.getMessageSize(object.pressure);
    length += SensorVec.getMessageSize(object.magnetic);
    length += SensorVec.getMessageSize(object.magneticUncalibrated);
    length += SensorVec.getMessageSize(object.gyro);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SensorEventData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b716bd78256e63045fe27b6249e4a04a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    SensorVec acceleration
    SensorVec gyroUncalibrated
    float32 light
    SensorVec orientation
    SensorVec pressure
    int32 sensor
    SensorVec magnetic
    SensorVec magneticUncalibrated
    uint32 source # enum const: SensorSource
    SensorVec gyro
    int32 version
    int32 timestamp
    int32 type
    float32 proximity
    bool uncalibratedDEPRECATED
    
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
    MSG: openpilot_bridge/SensorVec
    Header header
    
    int32 status
    float32[] v
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SensorEventData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = SensorVec.Resolve(msg.acceleration)
    }
    else {
      resolved.acceleration = new SensorVec()
    }

    if (msg.gyroUncalibrated !== undefined) {
      resolved.gyroUncalibrated = SensorVec.Resolve(msg.gyroUncalibrated)
    }
    else {
      resolved.gyroUncalibrated = new SensorVec()
    }

    if (msg.light !== undefined) {
      resolved.light = msg.light;
    }
    else {
      resolved.light = 0.0
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = SensorVec.Resolve(msg.orientation)
    }
    else {
      resolved.orientation = new SensorVec()
    }

    if (msg.pressure !== undefined) {
      resolved.pressure = SensorVec.Resolve(msg.pressure)
    }
    else {
      resolved.pressure = new SensorVec()
    }

    if (msg.sensor !== undefined) {
      resolved.sensor = msg.sensor;
    }
    else {
      resolved.sensor = 0
    }

    if (msg.magnetic !== undefined) {
      resolved.magnetic = SensorVec.Resolve(msg.magnetic)
    }
    else {
      resolved.magnetic = new SensorVec()
    }

    if (msg.magneticUncalibrated !== undefined) {
      resolved.magneticUncalibrated = SensorVec.Resolve(msg.magneticUncalibrated)
    }
    else {
      resolved.magneticUncalibrated = new SensorVec()
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    if (msg.gyro !== undefined) {
      resolved.gyro = SensorVec.Resolve(msg.gyro)
    }
    else {
      resolved.gyro = new SensorVec()
    }

    if (msg.version !== undefined) {
      resolved.version = msg.version;
    }
    else {
      resolved.version = 0
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.proximity !== undefined) {
      resolved.proximity = msg.proximity;
    }
    else {
      resolved.proximity = 0.0
    }

    if (msg.uncalibratedDEPRECATED !== undefined) {
      resolved.uncalibratedDEPRECATED = msg.uncalibratedDEPRECATED;
    }
    else {
      resolved.uncalibratedDEPRECATED = false
    }

    return resolved;
    }
};

module.exports = SensorEventData;
