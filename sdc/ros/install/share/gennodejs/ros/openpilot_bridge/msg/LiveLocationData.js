// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Accuracy = require('./Accuracy.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class LiveLocationData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.pitch = null;
      this.positionECEF = null;
      this.alt = null;
      this.speed = null;
      this.lon = null;
      this.source = null;
      this.roll = null;
      this.accuracy = null;
      this.status = null;
      this.yawCalibration = null;
      this.vNED = null;
      this.accel = null;
      this.fixMonoTime = null;
      this.lat = null;
      this.imuFrame = null;
      this.pitchCalibration = null;
      this.gyro = null;
      this.timeOfWeek = null;
      this.poseQuatECEF = null;
      this.gpsWeek = null;
      this.trackAngle = null;
      this.heading = null;
      this.wanderAngle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('pitch')) {
        this.pitch = initObj.pitch
      }
      else {
        this.pitch = 0.0;
      }
      if (initObj.hasOwnProperty('positionECEF')) {
        this.positionECEF = initObj.positionECEF
      }
      else {
        this.positionECEF = [];
      }
      if (initObj.hasOwnProperty('alt')) {
        this.alt = initObj.alt
      }
      else {
        this.alt = 0.0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('lon')) {
        this.lon = initObj.lon
      }
      else {
        this.lon = 0.0;
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
      if (initObj.hasOwnProperty('roll')) {
        this.roll = initObj.roll
      }
      else {
        this.roll = 0.0;
      }
      if (initObj.hasOwnProperty('accuracy')) {
        this.accuracy = initObj.accuracy
      }
      else {
        this.accuracy = new Accuracy();
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('yawCalibration')) {
        this.yawCalibration = initObj.yawCalibration
      }
      else {
        this.yawCalibration = 0.0;
      }
      if (initObj.hasOwnProperty('vNED')) {
        this.vNED = initObj.vNED
      }
      else {
        this.vNED = [];
      }
      if (initObj.hasOwnProperty('accel')) {
        this.accel = initObj.accel
      }
      else {
        this.accel = [];
      }
      if (initObj.hasOwnProperty('fixMonoTime')) {
        this.fixMonoTime = initObj.fixMonoTime
      }
      else {
        this.fixMonoTime = 0;
      }
      if (initObj.hasOwnProperty('lat')) {
        this.lat = initObj.lat
      }
      else {
        this.lat = 0.0;
      }
      if (initObj.hasOwnProperty('imuFrame')) {
        this.imuFrame = initObj.imuFrame
      }
      else {
        this.imuFrame = [];
      }
      if (initObj.hasOwnProperty('pitchCalibration')) {
        this.pitchCalibration = initObj.pitchCalibration
      }
      else {
        this.pitchCalibration = 0.0;
      }
      if (initObj.hasOwnProperty('gyro')) {
        this.gyro = initObj.gyro
      }
      else {
        this.gyro = [];
      }
      if (initObj.hasOwnProperty('timeOfWeek')) {
        this.timeOfWeek = initObj.timeOfWeek
      }
      else {
        this.timeOfWeek = 0.0;
      }
      if (initObj.hasOwnProperty('poseQuatECEF')) {
        this.poseQuatECEF = initObj.poseQuatECEF
      }
      else {
        this.poseQuatECEF = [];
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0;
      }
      if (initObj.hasOwnProperty('trackAngle')) {
        this.trackAngle = initObj.trackAngle
      }
      else {
        this.trackAngle = 0.0;
      }
      if (initObj.hasOwnProperty('heading')) {
        this.heading = initObj.heading
      }
      else {
        this.heading = 0.0;
      }
      if (initObj.hasOwnProperty('wanderAngle')) {
        this.wanderAngle = initObj.wanderAngle
      }
      else {
        this.wanderAngle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveLocationData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [pitch]
    bufferOffset = _serializer.float32(obj.pitch, buffer, bufferOffset);
    // Serialize message field [positionECEF]
    bufferOffset = _arraySerializer.float32(obj.positionECEF, buffer, bufferOffset, null);
    // Serialize message field [alt]
    bufferOffset = _serializer.float32(obj.alt, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [lon]
    bufferOffset = _serializer.float32(obj.lon, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.uint32(obj.source, buffer, bufferOffset);
    // Serialize message field [roll]
    bufferOffset = _serializer.float32(obj.roll, buffer, bufferOffset);
    // Serialize message field [accuracy]
    bufferOffset = Accuracy.serialize(obj.accuracy, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.int64(obj.status, buffer, bufferOffset);
    // Serialize message field [yawCalibration]
    bufferOffset = _serializer.float32(obj.yawCalibration, buffer, bufferOffset);
    // Serialize message field [vNED]
    bufferOffset = _arraySerializer.float32(obj.vNED, buffer, bufferOffset, null);
    // Serialize message field [accel]
    bufferOffset = _arraySerializer.float32(obj.accel, buffer, bufferOffset, null);
    // Serialize message field [fixMonoTime]
    bufferOffset = _serializer.int64(obj.fixMonoTime, buffer, bufferOffset);
    // Serialize message field [lat]
    bufferOffset = _serializer.float32(obj.lat, buffer, bufferOffset);
    // Serialize message field [imuFrame]
    bufferOffset = _arraySerializer.float32(obj.imuFrame, buffer, bufferOffset, null);
    // Serialize message field [pitchCalibration]
    bufferOffset = _serializer.float32(obj.pitchCalibration, buffer, bufferOffset);
    // Serialize message field [gyro]
    bufferOffset = _arraySerializer.float32(obj.gyro, buffer, bufferOffset, null);
    // Serialize message field [timeOfWeek]
    bufferOffset = _serializer.float32(obj.timeOfWeek, buffer, bufferOffset);
    // Serialize message field [poseQuatECEF]
    bufferOffset = _arraySerializer.float32(obj.poseQuatECEF, buffer, bufferOffset, null);
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.int32(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [trackAngle]
    bufferOffset = _serializer.float32(obj.trackAngle, buffer, bufferOffset);
    // Serialize message field [heading]
    bufferOffset = _serializer.float32(obj.heading, buffer, bufferOffset);
    // Serialize message field [wanderAngle]
    bufferOffset = _serializer.float32(obj.wanderAngle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveLocationData
    let len;
    let data = new LiveLocationData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [pitch]
    data.pitch = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [positionECEF]
    data.positionECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [alt]
    data.alt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lon]
    data.lon = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [roll]
    data.roll = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accuracy]
    data.accuracy = Accuracy.deserialize(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [yawCalibration]
    data.yawCalibration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vNED]
    data.vNED = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [accel]
    data.accel = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [fixMonoTime]
    data.fixMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lat]
    data.lat = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [imuFrame]
    data.imuFrame = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [pitchCalibration]
    data.pitchCalibration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gyro]
    data.gyro = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [timeOfWeek]
    data.timeOfWeek = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [poseQuatECEF]
    data.poseQuatECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [trackAngle]
    data.trackAngle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [heading]
    data.heading = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [wanderAngle]
    data.wanderAngle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.positionECEF.length;
    length += Accuracy.getMessageSize(object.accuracy);
    length += 4 * object.vNED.length;
    length += 4 * object.accel.length;
    length += 4 * object.imuFrame.length;
    length += 4 * object.gyro.length;
    length += 4 * object.poseQuatECEF.length;
    return length + 96;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveLocationData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'aa33a74620afc25f4a6862168bc66b52';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 pitch
    float32[] positionECEF
    float32 alt
    float32 speed
    float32 lon
    uint32 source # enum const: SensorSource
    float32 roll
    Accuracy accuracy
    int64 status
    float32 yawCalibration
    float32[] vNED
    float32[] accel
    int64 fixMonoTime
    float32 lat
    float32[] imuFrame
    float32 pitchCalibration
    float32[] gyro
    float32 timeOfWeek
    float32[] poseQuatECEF
    int32 gpsWeek
    float32 trackAngle
    float32 heading
    float32 wanderAngle
    
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
    MSG: openpilot_bridge/Accuracy
    Header header
    
    float32[] vNEDError
    float32 rollError
    float32 headingError
    float32 ellipsoidSemiMajorError
    float32 ellipsoidOrientationError
    float32[] pNEDError
    float32 ellipsoidSemiMinorError
    float32 pitchError
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LiveLocationData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.pitch !== undefined) {
      resolved.pitch = msg.pitch;
    }
    else {
      resolved.pitch = 0.0
    }

    if (msg.positionECEF !== undefined) {
      resolved.positionECEF = msg.positionECEF;
    }
    else {
      resolved.positionECEF = []
    }

    if (msg.alt !== undefined) {
      resolved.alt = msg.alt;
    }
    else {
      resolved.alt = 0.0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.lon !== undefined) {
      resolved.lon = msg.lon;
    }
    else {
      resolved.lon = 0.0
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    if (msg.roll !== undefined) {
      resolved.roll = msg.roll;
    }
    else {
      resolved.roll = 0.0
    }

    if (msg.accuracy !== undefined) {
      resolved.accuracy = Accuracy.Resolve(msg.accuracy)
    }
    else {
      resolved.accuracy = new Accuracy()
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.yawCalibration !== undefined) {
      resolved.yawCalibration = msg.yawCalibration;
    }
    else {
      resolved.yawCalibration = 0.0
    }

    if (msg.vNED !== undefined) {
      resolved.vNED = msg.vNED;
    }
    else {
      resolved.vNED = []
    }

    if (msg.accel !== undefined) {
      resolved.accel = msg.accel;
    }
    else {
      resolved.accel = []
    }

    if (msg.fixMonoTime !== undefined) {
      resolved.fixMonoTime = msg.fixMonoTime;
    }
    else {
      resolved.fixMonoTime = 0
    }

    if (msg.lat !== undefined) {
      resolved.lat = msg.lat;
    }
    else {
      resolved.lat = 0.0
    }

    if (msg.imuFrame !== undefined) {
      resolved.imuFrame = msg.imuFrame;
    }
    else {
      resolved.imuFrame = []
    }

    if (msg.pitchCalibration !== undefined) {
      resolved.pitchCalibration = msg.pitchCalibration;
    }
    else {
      resolved.pitchCalibration = 0.0
    }

    if (msg.gyro !== undefined) {
      resolved.gyro = msg.gyro;
    }
    else {
      resolved.gyro = []
    }

    if (msg.timeOfWeek !== undefined) {
      resolved.timeOfWeek = msg.timeOfWeek;
    }
    else {
      resolved.timeOfWeek = 0.0
    }

    if (msg.poseQuatECEF !== undefined) {
      resolved.poseQuatECEF = msg.poseQuatECEF;
    }
    else {
      resolved.poseQuatECEF = []
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0
    }

    if (msg.trackAngle !== undefined) {
      resolved.trackAngle = msg.trackAngle;
    }
    else {
      resolved.trackAngle = 0.0
    }

    if (msg.heading !== undefined) {
      resolved.heading = msg.heading;
    }
    else {
      resolved.heading = 0.0
    }

    if (msg.wanderAngle !== undefined) {
      resolved.wanderAngle = msg.wanderAngle;
    }
    else {
      resolved.wanderAngle = 0.0
    }

    return resolved;
    }
};

module.exports = LiveLocationData;
