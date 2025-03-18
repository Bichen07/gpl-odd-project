// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let GpsLocationData = require('./GpsLocationData.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class LiveMapData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.roadCurvatureX = null;
      this.wayId = null;
      this.speedLimitValid = null;
      this.distToTurn = null;
      this.curvature = null;
      this.roadCurvature = null;
      this.mapValid = null;
      this.roadY = null;
      this.roadX = null;
      this.speedLimitAheadDistance = null;
      this.curvatureValid = null;
      this.speedLimitAheadValid = null;
      this.speedAdvisoryValid = null;
      this.speedLimit = null;
      this.speedAdvisory = null;
      this.lastGps = null;
      this.speedLimitAhead = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('roadCurvatureX')) {
        this.roadCurvatureX = initObj.roadCurvatureX
      }
      else {
        this.roadCurvatureX = [];
      }
      if (initObj.hasOwnProperty('wayId')) {
        this.wayId = initObj.wayId
      }
      else {
        this.wayId = 0;
      }
      if (initObj.hasOwnProperty('speedLimitValid')) {
        this.speedLimitValid = initObj.speedLimitValid
      }
      else {
        this.speedLimitValid = false;
      }
      if (initObj.hasOwnProperty('distToTurn')) {
        this.distToTurn = initObj.distToTurn
      }
      else {
        this.distToTurn = 0.0;
      }
      if (initObj.hasOwnProperty('curvature')) {
        this.curvature = initObj.curvature
      }
      else {
        this.curvature = 0.0;
      }
      if (initObj.hasOwnProperty('roadCurvature')) {
        this.roadCurvature = initObj.roadCurvature
      }
      else {
        this.roadCurvature = [];
      }
      if (initObj.hasOwnProperty('mapValid')) {
        this.mapValid = initObj.mapValid
      }
      else {
        this.mapValid = false;
      }
      if (initObj.hasOwnProperty('roadY')) {
        this.roadY = initObj.roadY
      }
      else {
        this.roadY = [];
      }
      if (initObj.hasOwnProperty('roadX')) {
        this.roadX = initObj.roadX
      }
      else {
        this.roadX = [];
      }
      if (initObj.hasOwnProperty('speedLimitAheadDistance')) {
        this.speedLimitAheadDistance = initObj.speedLimitAheadDistance
      }
      else {
        this.speedLimitAheadDistance = 0.0;
      }
      if (initObj.hasOwnProperty('curvatureValid')) {
        this.curvatureValid = initObj.curvatureValid
      }
      else {
        this.curvatureValid = false;
      }
      if (initObj.hasOwnProperty('speedLimitAheadValid')) {
        this.speedLimitAheadValid = initObj.speedLimitAheadValid
      }
      else {
        this.speedLimitAheadValid = false;
      }
      if (initObj.hasOwnProperty('speedAdvisoryValid')) {
        this.speedAdvisoryValid = initObj.speedAdvisoryValid
      }
      else {
        this.speedAdvisoryValid = false;
      }
      if (initObj.hasOwnProperty('speedLimit')) {
        this.speedLimit = initObj.speedLimit
      }
      else {
        this.speedLimit = 0.0;
      }
      if (initObj.hasOwnProperty('speedAdvisory')) {
        this.speedAdvisory = initObj.speedAdvisory
      }
      else {
        this.speedAdvisory = 0.0;
      }
      if (initObj.hasOwnProperty('lastGps')) {
        this.lastGps = initObj.lastGps
      }
      else {
        this.lastGps = new GpsLocationData();
      }
      if (initObj.hasOwnProperty('speedLimitAhead')) {
        this.speedLimitAhead = initObj.speedLimitAhead
      }
      else {
        this.speedLimitAhead = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveMapData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [roadCurvatureX]
    bufferOffset = _arraySerializer.float32(obj.roadCurvatureX, buffer, bufferOffset, null);
    // Serialize message field [wayId]
    bufferOffset = _serializer.int64(obj.wayId, buffer, bufferOffset);
    // Serialize message field [speedLimitValid]
    bufferOffset = _serializer.bool(obj.speedLimitValid, buffer, bufferOffset);
    // Serialize message field [distToTurn]
    bufferOffset = _serializer.float32(obj.distToTurn, buffer, bufferOffset);
    // Serialize message field [curvature]
    bufferOffset = _serializer.float32(obj.curvature, buffer, bufferOffset);
    // Serialize message field [roadCurvature]
    bufferOffset = _arraySerializer.float32(obj.roadCurvature, buffer, bufferOffset, null);
    // Serialize message field [mapValid]
    bufferOffset = _serializer.bool(obj.mapValid, buffer, bufferOffset);
    // Serialize message field [roadY]
    bufferOffset = _arraySerializer.float32(obj.roadY, buffer, bufferOffset, null);
    // Serialize message field [roadX]
    bufferOffset = _arraySerializer.float32(obj.roadX, buffer, bufferOffset, null);
    // Serialize message field [speedLimitAheadDistance]
    bufferOffset = _serializer.float32(obj.speedLimitAheadDistance, buffer, bufferOffset);
    // Serialize message field [curvatureValid]
    bufferOffset = _serializer.bool(obj.curvatureValid, buffer, bufferOffset);
    // Serialize message field [speedLimitAheadValid]
    bufferOffset = _serializer.bool(obj.speedLimitAheadValid, buffer, bufferOffset);
    // Serialize message field [speedAdvisoryValid]
    bufferOffset = _serializer.bool(obj.speedAdvisoryValid, buffer, bufferOffset);
    // Serialize message field [speedLimit]
    bufferOffset = _serializer.float32(obj.speedLimit, buffer, bufferOffset);
    // Serialize message field [speedAdvisory]
    bufferOffset = _serializer.float32(obj.speedAdvisory, buffer, bufferOffset);
    // Serialize message field [lastGps]
    bufferOffset = GpsLocationData.serialize(obj.lastGps, buffer, bufferOffset);
    // Serialize message field [speedLimitAhead]
    bufferOffset = _serializer.float32(obj.speedLimitAhead, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveMapData
    let len;
    let data = new LiveMapData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [roadCurvatureX]
    data.roadCurvatureX = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [wayId]
    data.wayId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [speedLimitValid]
    data.speedLimitValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [distToTurn]
    data.distToTurn = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [curvature]
    data.curvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [roadCurvature]
    data.roadCurvature = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [mapValid]
    data.mapValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [roadY]
    data.roadY = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [roadX]
    data.roadX = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [speedLimitAheadDistance]
    data.speedLimitAheadDistance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [curvatureValid]
    data.curvatureValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speedLimitAheadValid]
    data.speedLimitAheadValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speedAdvisoryValid]
    data.speedAdvisoryValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speedLimit]
    data.speedLimit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speedAdvisory]
    data.speedAdvisory = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lastGps]
    data.lastGps = GpsLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [speedLimitAhead]
    data.speedLimitAhead = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.roadCurvatureX.length;
    length += 4 * object.roadCurvature.length;
    length += 4 * object.roadY.length;
    length += 4 * object.roadX.length;
    length += GpsLocationData.getMessageSize(object.lastGps);
    return length + 53;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveMapData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8e75e0f0b1c9d773cf5d7c8618aae41e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] roadCurvatureX
    int64 wayId
    bool speedLimitValid
    float32 distToTurn
    float32 curvature
    float32[] roadCurvature
    bool mapValid
    float32[] roadY
    float32[] roadX
    float32 speedLimitAheadDistance
    bool curvatureValid
    bool speedLimitAheadValid
    bool speedAdvisoryValid
    float32 speedLimit
    float32 speedAdvisory
    GpsLocationData lastGps
    float32 speedLimitAhead
    
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
    MSG: openpilot_bridge/GpsLocationData
    Header header
    
    float32 bearing
    float32[] vNED
    int32 timestamp
    float32 altitude
    float32 longitude
    uint32 source # enum const: SensorSource
    float32 speedAccuracy
    int64 flags
    float32 latitude
    float32 bearingAccuracy
    float32 speed
    float32 verticalAccuracy
    float32 accuracy
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LiveMapData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.roadCurvatureX !== undefined) {
      resolved.roadCurvatureX = msg.roadCurvatureX;
    }
    else {
      resolved.roadCurvatureX = []
    }

    if (msg.wayId !== undefined) {
      resolved.wayId = msg.wayId;
    }
    else {
      resolved.wayId = 0
    }

    if (msg.speedLimitValid !== undefined) {
      resolved.speedLimitValid = msg.speedLimitValid;
    }
    else {
      resolved.speedLimitValid = false
    }

    if (msg.distToTurn !== undefined) {
      resolved.distToTurn = msg.distToTurn;
    }
    else {
      resolved.distToTurn = 0.0
    }

    if (msg.curvature !== undefined) {
      resolved.curvature = msg.curvature;
    }
    else {
      resolved.curvature = 0.0
    }

    if (msg.roadCurvature !== undefined) {
      resolved.roadCurvature = msg.roadCurvature;
    }
    else {
      resolved.roadCurvature = []
    }

    if (msg.mapValid !== undefined) {
      resolved.mapValid = msg.mapValid;
    }
    else {
      resolved.mapValid = false
    }

    if (msg.roadY !== undefined) {
      resolved.roadY = msg.roadY;
    }
    else {
      resolved.roadY = []
    }

    if (msg.roadX !== undefined) {
      resolved.roadX = msg.roadX;
    }
    else {
      resolved.roadX = []
    }

    if (msg.speedLimitAheadDistance !== undefined) {
      resolved.speedLimitAheadDistance = msg.speedLimitAheadDistance;
    }
    else {
      resolved.speedLimitAheadDistance = 0.0
    }

    if (msg.curvatureValid !== undefined) {
      resolved.curvatureValid = msg.curvatureValid;
    }
    else {
      resolved.curvatureValid = false
    }

    if (msg.speedLimitAheadValid !== undefined) {
      resolved.speedLimitAheadValid = msg.speedLimitAheadValid;
    }
    else {
      resolved.speedLimitAheadValid = false
    }

    if (msg.speedAdvisoryValid !== undefined) {
      resolved.speedAdvisoryValid = msg.speedAdvisoryValid;
    }
    else {
      resolved.speedAdvisoryValid = false
    }

    if (msg.speedLimit !== undefined) {
      resolved.speedLimit = msg.speedLimit;
    }
    else {
      resolved.speedLimit = 0.0
    }

    if (msg.speedAdvisory !== undefined) {
      resolved.speedAdvisory = msg.speedAdvisory;
    }
    else {
      resolved.speedAdvisory = 0.0
    }

    if (msg.lastGps !== undefined) {
      resolved.lastGps = GpsLocationData.Resolve(msg.lastGps)
    }
    else {
      resolved.lastGps = new GpsLocationData()
    }

    if (msg.speedLimitAhead !== undefined) {
      resolved.speedLimitAhead = msg.speedLimitAhead;
    }
    else {
      resolved.speedLimitAhead = 0.0
    }

    return resolved;
    }
};

module.exports = LiveMapData;
