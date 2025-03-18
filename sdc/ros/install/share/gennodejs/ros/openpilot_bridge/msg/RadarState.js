// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LeadData = require('./LeadData.js');
let RadarPoint = require('./RadarPoint.js');
let LiveTracks = require('./LiveTracks.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class RadarState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.warpMatrixDEPRECATED = null;
      this.calCycleDEPRECATED = null;
      this.calStatusDEPRECATED = null;
      this.mdMonoTime = null;
      this.leadTwo = null;
      this.calPercDEPRECATED = null;
      this.radarErrors = null;
      this.cumLagMs = null;
      this.canMonoTimes = null;
      this.angleOffsetDEPRECATED = null;
      this.ftMonoTimeDEPRECATED = null;
      this.leadOne = null;
      this.controlsStateMonoTime = null;
      this.radarPoints = null;
      this.liveTracks = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('warpMatrixDEPRECATED')) {
        this.warpMatrixDEPRECATED = initObj.warpMatrixDEPRECATED
      }
      else {
        this.warpMatrixDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('calCycleDEPRECATED')) {
        this.calCycleDEPRECATED = initObj.calCycleDEPRECATED
      }
      else {
        this.calCycleDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('calStatusDEPRECATED')) {
        this.calStatusDEPRECATED = initObj.calStatusDEPRECATED
      }
      else {
        this.calStatusDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('mdMonoTime')) {
        this.mdMonoTime = initObj.mdMonoTime
      }
      else {
        this.mdMonoTime = 0;
      }
      if (initObj.hasOwnProperty('leadTwo')) {
        this.leadTwo = initObj.leadTwo
      }
      else {
        this.leadTwo = new LeadData();
      }
      if (initObj.hasOwnProperty('calPercDEPRECATED')) {
        this.calPercDEPRECATED = initObj.calPercDEPRECATED
      }
      else {
        this.calPercDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('radarErrors')) {
        this.radarErrors = initObj.radarErrors
      }
      else {
        this.radarErrors = [];
      }
      if (initObj.hasOwnProperty('cumLagMs')) {
        this.cumLagMs = initObj.cumLagMs
      }
      else {
        this.cumLagMs = 0.0;
      }
      if (initObj.hasOwnProperty('canMonoTimes')) {
        this.canMonoTimes = initObj.canMonoTimes
      }
      else {
        this.canMonoTimes = [];
      }
      if (initObj.hasOwnProperty('angleOffsetDEPRECATED')) {
        this.angleOffsetDEPRECATED = initObj.angleOffsetDEPRECATED
      }
      else {
        this.angleOffsetDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('ftMonoTimeDEPRECATED')) {
        this.ftMonoTimeDEPRECATED = initObj.ftMonoTimeDEPRECATED
      }
      else {
        this.ftMonoTimeDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('leadOne')) {
        this.leadOne = initObj.leadOne
      }
      else {
        this.leadOne = new LeadData();
      }
      if (initObj.hasOwnProperty('controlsStateMonoTime')) {
        this.controlsStateMonoTime = initObj.controlsStateMonoTime
      }
      else {
        this.controlsStateMonoTime = 0;
      }
      if (initObj.hasOwnProperty('radarPoints')) {
        this.radarPoints = initObj.radarPoints
      }
      else {
        this.radarPoints = [];
      }
      if (initObj.hasOwnProperty('liveTracks')) {
        this.liveTracks = initObj.liveTracks
      }
      else {
        this.liveTracks = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RadarState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [warpMatrixDEPRECATED]
    bufferOffset = _arraySerializer.float32(obj.warpMatrixDEPRECATED, buffer, bufferOffset, null);
    // Serialize message field [calCycleDEPRECATED]
    bufferOffset = _serializer.int32(obj.calCycleDEPRECATED, buffer, bufferOffset);
    // Serialize message field [calStatusDEPRECATED]
    bufferOffset = _serializer.int32(obj.calStatusDEPRECATED, buffer, bufferOffset);
    // Serialize message field [mdMonoTime]
    bufferOffset = _serializer.int64(obj.mdMonoTime, buffer, bufferOffset);
    // Serialize message field [leadTwo]
    bufferOffset = LeadData.serialize(obj.leadTwo, buffer, bufferOffset);
    // Serialize message field [calPercDEPRECATED]
    bufferOffset = _serializer.int32(obj.calPercDEPRECATED, buffer, bufferOffset);
    // Serialize message field [radarErrors]
    bufferOffset = _arraySerializer.uint32(obj.radarErrors, buffer, bufferOffset, null);
    // Serialize message field [cumLagMs]
    bufferOffset = _serializer.float32(obj.cumLagMs, buffer, bufferOffset);
    // Serialize message field [canMonoTimes]
    bufferOffset = _arraySerializer.int64(obj.canMonoTimes, buffer, bufferOffset, null);
    // Serialize message field [angleOffsetDEPRECATED]
    bufferOffset = _serializer.float32(obj.angleOffsetDEPRECATED, buffer, bufferOffset);
    // Serialize message field [ftMonoTimeDEPRECATED]
    bufferOffset = _serializer.int64(obj.ftMonoTimeDEPRECATED, buffer, bufferOffset);
    // Serialize message field [leadOne]
    bufferOffset = LeadData.serialize(obj.leadOne, buffer, bufferOffset);
    // Serialize message field [controlsStateMonoTime]
    bufferOffset = _serializer.int64(obj.controlsStateMonoTime, buffer, bufferOffset);
    // Serialize message field [radarPoints]
    // Serialize the length for message field [radarPoints]
    bufferOffset = _serializer.uint32(obj.radarPoints.length, buffer, bufferOffset);
    obj.radarPoints.forEach((val) => {
      bufferOffset = RadarPoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [liveTracks]
    // Serialize the length for message field [liveTracks]
    bufferOffset = _serializer.uint32(obj.liveTracks.length, buffer, bufferOffset);
    obj.liveTracks.forEach((val) => {
      bufferOffset = LiveTracks.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RadarState
    let len;
    let data = new RadarState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [warpMatrixDEPRECATED]
    data.warpMatrixDEPRECATED = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [calCycleDEPRECATED]
    data.calCycleDEPRECATED = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [calStatusDEPRECATED]
    data.calStatusDEPRECATED = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [mdMonoTime]
    data.mdMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [leadTwo]
    data.leadTwo = LeadData.deserialize(buffer, bufferOffset);
    // Deserialize message field [calPercDEPRECATED]
    data.calPercDEPRECATED = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [radarErrors]
    data.radarErrors = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [cumLagMs]
    data.cumLagMs = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [canMonoTimes]
    data.canMonoTimes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [angleOffsetDEPRECATED]
    data.angleOffsetDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ftMonoTimeDEPRECATED]
    data.ftMonoTimeDEPRECATED = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [leadOne]
    data.leadOne = LeadData.deserialize(buffer, bufferOffset);
    // Deserialize message field [controlsStateMonoTime]
    data.controlsStateMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [radarPoints]
    // Deserialize array length for message field [radarPoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.radarPoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.radarPoints[i] = RadarPoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [liveTracks]
    // Deserialize array length for message field [liveTracks]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.liveTracks = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.liveTracks[i] = LiveTracks.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.warpMatrixDEPRECATED.length;
    length += LeadData.getMessageSize(object.leadTwo);
    length += 4 * object.radarErrors.length;
    length += 8 * object.canMonoTimes.length;
    length += LeadData.getMessageSize(object.leadOne);
    object.radarPoints.forEach((val) => {
      length += RadarPoint.getMessageSize(val);
    });
    object.liveTracks.forEach((val) => {
      length += LiveTracks.getMessageSize(val);
    });
    return length + 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/RadarState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6ae0f29b5053e8a1901524794cbb99a2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] warpMatrixDEPRECATED
    int32 calCycleDEPRECATED
    int32 calStatusDEPRECATED
    int64 mdMonoTime
    LeadData leadTwo
    int32 calPercDEPRECATED
    uint32[] radarErrors # enum const: Error
    float32 cumLagMs
    int64[] canMonoTimes
    float32 angleOffsetDEPRECATED
    int64 ftMonoTimeDEPRECATED
    LeadData leadOne
    int64 controlsStateMonoTime
    RadarPoint[] radarPoints
    LiveTracks[] liveTracks
    
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
    MSG: openpilot_bridge/LeadData
    Header header
    
    float32 dRel
    float32 yRel
    float32 vRel
    float32 aRel
    float32 vLead
    float32 aLeadDEPRECATED
    float32 dPath
    float32 vLat
    float32 vLeadK
    float32 aLeadK
    bool fcw
    bool status
    float32 aLeadTau
    float32 modelProb
    bool radar
    
    ================================================================================
    MSG: openpilot_bridge/RadarPoint
    Header header
    
    float32 yRel
    int64 trackId
    float32 aRel
    float32 vRel
    float32 dRel
    float32 yvRel
    bool measured
    
    ================================================================================
    MSG: openpilot_bridge/LiveTracks
    Header header
    
    float32 status
    float32 yRel
    float32 currentTime
    int32 trackId
    float32 aRel
    float32 vRel
    float32 dRel
    float32 timeStamp
    bool stationary
    bool oncoming
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RadarState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.warpMatrixDEPRECATED !== undefined) {
      resolved.warpMatrixDEPRECATED = msg.warpMatrixDEPRECATED;
    }
    else {
      resolved.warpMatrixDEPRECATED = []
    }

    if (msg.calCycleDEPRECATED !== undefined) {
      resolved.calCycleDEPRECATED = msg.calCycleDEPRECATED;
    }
    else {
      resolved.calCycleDEPRECATED = 0
    }

    if (msg.calStatusDEPRECATED !== undefined) {
      resolved.calStatusDEPRECATED = msg.calStatusDEPRECATED;
    }
    else {
      resolved.calStatusDEPRECATED = 0
    }

    if (msg.mdMonoTime !== undefined) {
      resolved.mdMonoTime = msg.mdMonoTime;
    }
    else {
      resolved.mdMonoTime = 0
    }

    if (msg.leadTwo !== undefined) {
      resolved.leadTwo = LeadData.Resolve(msg.leadTwo)
    }
    else {
      resolved.leadTwo = new LeadData()
    }

    if (msg.calPercDEPRECATED !== undefined) {
      resolved.calPercDEPRECATED = msg.calPercDEPRECATED;
    }
    else {
      resolved.calPercDEPRECATED = 0
    }

    if (msg.radarErrors !== undefined) {
      resolved.radarErrors = msg.radarErrors;
    }
    else {
      resolved.radarErrors = []
    }

    if (msg.cumLagMs !== undefined) {
      resolved.cumLagMs = msg.cumLagMs;
    }
    else {
      resolved.cumLagMs = 0.0
    }

    if (msg.canMonoTimes !== undefined) {
      resolved.canMonoTimes = msg.canMonoTimes;
    }
    else {
      resolved.canMonoTimes = []
    }

    if (msg.angleOffsetDEPRECATED !== undefined) {
      resolved.angleOffsetDEPRECATED = msg.angleOffsetDEPRECATED;
    }
    else {
      resolved.angleOffsetDEPRECATED = 0.0
    }

    if (msg.ftMonoTimeDEPRECATED !== undefined) {
      resolved.ftMonoTimeDEPRECATED = msg.ftMonoTimeDEPRECATED;
    }
    else {
      resolved.ftMonoTimeDEPRECATED = 0
    }

    if (msg.leadOne !== undefined) {
      resolved.leadOne = LeadData.Resolve(msg.leadOne)
    }
    else {
      resolved.leadOne = new LeadData()
    }

    if (msg.controlsStateMonoTime !== undefined) {
      resolved.controlsStateMonoTime = msg.controlsStateMonoTime;
    }
    else {
      resolved.controlsStateMonoTime = 0
    }

    if (msg.radarPoints !== undefined) {
      resolved.radarPoints = new Array(msg.radarPoints.length);
      for (let i = 0; i < resolved.radarPoints.length; ++i) {
        resolved.radarPoints[i] = RadarPoint.Resolve(msg.radarPoints[i]);
      }
    }
    else {
      resolved.radarPoints = []
    }

    if (msg.liveTracks !== undefined) {
      resolved.liveTracks = new Array(msg.liveTracks.length);
      for (let i = 0; i < resolved.liveTracks.length; ++i) {
        resolved.liveTracks[i] = LiveTracks.Resolve(msg.liveTracks[i]);
      }
    }
    else {
      resolved.liveTracks = []
    }

    return resolved;
    }
};

module.exports = RadarState;
