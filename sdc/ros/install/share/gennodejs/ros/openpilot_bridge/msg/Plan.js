// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let CarEvent = require('./CarEvent.js');
let GpsTrajectory = require('./GpsTrajectory.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Plan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.decelForTurn = null;
      this.vTarget = null;
      this.lateralValidDEPRECATED = null;
      this.longitudinalPlanSource = null;
      this.hasLead = null;
      this.radarStateMonoTime = null;
      this.jerkFactor = null;
      this.vCurvature = null;
      this.aTarget = null;
      this.mdMonoTime = null;
      this.aTargetMaxDEPRECATED = null;
      this.laneWidthDEPRECATED = null;
      this.radarValid = null;
      this.gpsPlannerActive = null;
      this.fcw = null;
      this.processingDelay = null;
      this.longitudinalValidDEPRECATED = null;
      this.aStart = null;
      this.eventsDEPRECATED = null;
      this.hasRightLaneDEPRECATED = null;
      this.vStart = null;
      this.aCruise = null;
      this.commIssue = null;
      this.vTargetFuture = null;
      this.gpsTrajectory = null;
      this.hasLeftLaneDEPRECATED = null;
      this.vCruise = null;
      this.aTargetMinDEPRECATED = null;
      this.mapValid = null;
      this.radarCanError = null;
      this.vMax = null;
      this.dPolyDEPRECATED = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('decelForTurn')) {
        this.decelForTurn = initObj.decelForTurn
      }
      else {
        this.decelForTurn = false;
      }
      if (initObj.hasOwnProperty('vTarget')) {
        this.vTarget = initObj.vTarget
      }
      else {
        this.vTarget = 0.0;
      }
      if (initObj.hasOwnProperty('lateralValidDEPRECATED')) {
        this.lateralValidDEPRECATED = initObj.lateralValidDEPRECATED
      }
      else {
        this.lateralValidDEPRECATED = false;
      }
      if (initObj.hasOwnProperty('longitudinalPlanSource')) {
        this.longitudinalPlanSource = initObj.longitudinalPlanSource
      }
      else {
        this.longitudinalPlanSource = 0;
      }
      if (initObj.hasOwnProperty('hasLead')) {
        this.hasLead = initObj.hasLead
      }
      else {
        this.hasLead = false;
      }
      if (initObj.hasOwnProperty('radarStateMonoTime')) {
        this.radarStateMonoTime = initObj.radarStateMonoTime
      }
      else {
        this.radarStateMonoTime = 0;
      }
      if (initObj.hasOwnProperty('jerkFactor')) {
        this.jerkFactor = initObj.jerkFactor
      }
      else {
        this.jerkFactor = 0.0;
      }
      if (initObj.hasOwnProperty('vCurvature')) {
        this.vCurvature = initObj.vCurvature
      }
      else {
        this.vCurvature = 0.0;
      }
      if (initObj.hasOwnProperty('aTarget')) {
        this.aTarget = initObj.aTarget
      }
      else {
        this.aTarget = 0.0;
      }
      if (initObj.hasOwnProperty('mdMonoTime')) {
        this.mdMonoTime = initObj.mdMonoTime
      }
      else {
        this.mdMonoTime = 0;
      }
      if (initObj.hasOwnProperty('aTargetMaxDEPRECATED')) {
        this.aTargetMaxDEPRECATED = initObj.aTargetMaxDEPRECATED
      }
      else {
        this.aTargetMaxDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('laneWidthDEPRECATED')) {
        this.laneWidthDEPRECATED = initObj.laneWidthDEPRECATED
      }
      else {
        this.laneWidthDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('radarValid')) {
        this.radarValid = initObj.radarValid
      }
      else {
        this.radarValid = false;
      }
      if (initObj.hasOwnProperty('gpsPlannerActive')) {
        this.gpsPlannerActive = initObj.gpsPlannerActive
      }
      else {
        this.gpsPlannerActive = false;
      }
      if (initObj.hasOwnProperty('fcw')) {
        this.fcw = initObj.fcw
      }
      else {
        this.fcw = false;
      }
      if (initObj.hasOwnProperty('processingDelay')) {
        this.processingDelay = initObj.processingDelay
      }
      else {
        this.processingDelay = 0.0;
      }
      if (initObj.hasOwnProperty('longitudinalValidDEPRECATED')) {
        this.longitudinalValidDEPRECATED = initObj.longitudinalValidDEPRECATED
      }
      else {
        this.longitudinalValidDEPRECATED = false;
      }
      if (initObj.hasOwnProperty('aStart')) {
        this.aStart = initObj.aStart
      }
      else {
        this.aStart = 0.0;
      }
      if (initObj.hasOwnProperty('eventsDEPRECATED')) {
        this.eventsDEPRECATED = initObj.eventsDEPRECATED
      }
      else {
        this.eventsDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('hasRightLaneDEPRECATED')) {
        this.hasRightLaneDEPRECATED = initObj.hasRightLaneDEPRECATED
      }
      else {
        this.hasRightLaneDEPRECATED = false;
      }
      if (initObj.hasOwnProperty('vStart')) {
        this.vStart = initObj.vStart
      }
      else {
        this.vStart = 0.0;
      }
      if (initObj.hasOwnProperty('aCruise')) {
        this.aCruise = initObj.aCruise
      }
      else {
        this.aCruise = 0.0;
      }
      if (initObj.hasOwnProperty('commIssue')) {
        this.commIssue = initObj.commIssue
      }
      else {
        this.commIssue = false;
      }
      if (initObj.hasOwnProperty('vTargetFuture')) {
        this.vTargetFuture = initObj.vTargetFuture
      }
      else {
        this.vTargetFuture = 0.0;
      }
      if (initObj.hasOwnProperty('gpsTrajectory')) {
        this.gpsTrajectory = initObj.gpsTrajectory
      }
      else {
        this.gpsTrajectory = new GpsTrajectory();
      }
      if (initObj.hasOwnProperty('hasLeftLaneDEPRECATED')) {
        this.hasLeftLaneDEPRECATED = initObj.hasLeftLaneDEPRECATED
      }
      else {
        this.hasLeftLaneDEPRECATED = false;
      }
      if (initObj.hasOwnProperty('vCruise')) {
        this.vCruise = initObj.vCruise
      }
      else {
        this.vCruise = 0.0;
      }
      if (initObj.hasOwnProperty('aTargetMinDEPRECATED')) {
        this.aTargetMinDEPRECATED = initObj.aTargetMinDEPRECATED
      }
      else {
        this.aTargetMinDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('mapValid')) {
        this.mapValid = initObj.mapValid
      }
      else {
        this.mapValid = false;
      }
      if (initObj.hasOwnProperty('radarCanError')) {
        this.radarCanError = initObj.radarCanError
      }
      else {
        this.radarCanError = false;
      }
      if (initObj.hasOwnProperty('vMax')) {
        this.vMax = initObj.vMax
      }
      else {
        this.vMax = 0.0;
      }
      if (initObj.hasOwnProperty('dPolyDEPRECATED')) {
        this.dPolyDEPRECATED = initObj.dPolyDEPRECATED
      }
      else {
        this.dPolyDEPRECATED = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Plan
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [decelForTurn]
    bufferOffset = _serializer.bool(obj.decelForTurn, buffer, bufferOffset);
    // Serialize message field [vTarget]
    bufferOffset = _serializer.float32(obj.vTarget, buffer, bufferOffset);
    // Serialize message field [lateralValidDEPRECATED]
    bufferOffset = _serializer.bool(obj.lateralValidDEPRECATED, buffer, bufferOffset);
    // Serialize message field [longitudinalPlanSource]
    bufferOffset = _serializer.uint32(obj.longitudinalPlanSource, buffer, bufferOffset);
    // Serialize message field [hasLead]
    bufferOffset = _serializer.bool(obj.hasLead, buffer, bufferOffset);
    // Serialize message field [radarStateMonoTime]
    bufferOffset = _serializer.int64(obj.radarStateMonoTime, buffer, bufferOffset);
    // Serialize message field [jerkFactor]
    bufferOffset = _serializer.float32(obj.jerkFactor, buffer, bufferOffset);
    // Serialize message field [vCurvature]
    bufferOffset = _serializer.float32(obj.vCurvature, buffer, bufferOffset);
    // Serialize message field [aTarget]
    bufferOffset = _serializer.float32(obj.aTarget, buffer, bufferOffset);
    // Serialize message field [mdMonoTime]
    bufferOffset = _serializer.int64(obj.mdMonoTime, buffer, bufferOffset);
    // Serialize message field [aTargetMaxDEPRECATED]
    bufferOffset = _serializer.float32(obj.aTargetMaxDEPRECATED, buffer, bufferOffset);
    // Serialize message field [laneWidthDEPRECATED]
    bufferOffset = _serializer.float32(obj.laneWidthDEPRECATED, buffer, bufferOffset);
    // Serialize message field [radarValid]
    bufferOffset = _serializer.bool(obj.radarValid, buffer, bufferOffset);
    // Serialize message field [gpsPlannerActive]
    bufferOffset = _serializer.bool(obj.gpsPlannerActive, buffer, bufferOffset);
    // Serialize message field [fcw]
    bufferOffset = _serializer.bool(obj.fcw, buffer, bufferOffset);
    // Serialize message field [processingDelay]
    bufferOffset = _serializer.float32(obj.processingDelay, buffer, bufferOffset);
    // Serialize message field [longitudinalValidDEPRECATED]
    bufferOffset = _serializer.bool(obj.longitudinalValidDEPRECATED, buffer, bufferOffset);
    // Serialize message field [aStart]
    bufferOffset = _serializer.float32(obj.aStart, buffer, bufferOffset);
    // Serialize message field [eventsDEPRECATED]
    // Serialize the length for message field [eventsDEPRECATED]
    bufferOffset = _serializer.uint32(obj.eventsDEPRECATED.length, buffer, bufferOffset);
    obj.eventsDEPRECATED.forEach((val) => {
      bufferOffset = CarEvent.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [hasRightLaneDEPRECATED]
    bufferOffset = _serializer.bool(obj.hasRightLaneDEPRECATED, buffer, bufferOffset);
    // Serialize message field [vStart]
    bufferOffset = _serializer.float32(obj.vStart, buffer, bufferOffset);
    // Serialize message field [aCruise]
    bufferOffset = _serializer.float32(obj.aCruise, buffer, bufferOffset);
    // Serialize message field [commIssue]
    bufferOffset = _serializer.bool(obj.commIssue, buffer, bufferOffset);
    // Serialize message field [vTargetFuture]
    bufferOffset = _serializer.float32(obj.vTargetFuture, buffer, bufferOffset);
    // Serialize message field [gpsTrajectory]
    bufferOffset = GpsTrajectory.serialize(obj.gpsTrajectory, buffer, bufferOffset);
    // Serialize message field [hasLeftLaneDEPRECATED]
    bufferOffset = _serializer.bool(obj.hasLeftLaneDEPRECATED, buffer, bufferOffset);
    // Serialize message field [vCruise]
    bufferOffset = _serializer.float32(obj.vCruise, buffer, bufferOffset);
    // Serialize message field [aTargetMinDEPRECATED]
    bufferOffset = _serializer.float32(obj.aTargetMinDEPRECATED, buffer, bufferOffset);
    // Serialize message field [mapValid]
    bufferOffset = _serializer.bool(obj.mapValid, buffer, bufferOffset);
    // Serialize message field [radarCanError]
    bufferOffset = _serializer.bool(obj.radarCanError, buffer, bufferOffset);
    // Serialize message field [vMax]
    bufferOffset = _serializer.float32(obj.vMax, buffer, bufferOffset);
    // Serialize message field [dPolyDEPRECATED]
    bufferOffset = _arraySerializer.float32(obj.dPolyDEPRECATED, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Plan
    let len;
    let data = new Plan(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [decelForTurn]
    data.decelForTurn = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vTarget]
    data.vTarget = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lateralValidDEPRECATED]
    data.lateralValidDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [longitudinalPlanSource]
    data.longitudinalPlanSource = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [hasLead]
    data.hasLead = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [radarStateMonoTime]
    data.radarStateMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [jerkFactor]
    data.jerkFactor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vCurvature]
    data.vCurvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aTarget]
    data.aTarget = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [mdMonoTime]
    data.mdMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [aTargetMaxDEPRECATED]
    data.aTargetMaxDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [laneWidthDEPRECATED]
    data.laneWidthDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [radarValid]
    data.radarValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsPlannerActive]
    data.gpsPlannerActive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [fcw]
    data.fcw = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [processingDelay]
    data.processingDelay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [longitudinalValidDEPRECATED]
    data.longitudinalValidDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [aStart]
    data.aStart = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [eventsDEPRECATED]
    // Deserialize array length for message field [eventsDEPRECATED]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.eventsDEPRECATED = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.eventsDEPRECATED[i] = CarEvent.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [hasRightLaneDEPRECATED]
    data.hasRightLaneDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vStart]
    data.vStart = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aCruise]
    data.aCruise = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [commIssue]
    data.commIssue = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vTargetFuture]
    data.vTargetFuture = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsTrajectory]
    data.gpsTrajectory = GpsTrajectory.deserialize(buffer, bufferOffset);
    // Deserialize message field [hasLeftLaneDEPRECATED]
    data.hasLeftLaneDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vCruise]
    data.vCruise = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aTargetMinDEPRECATED]
    data.aTargetMinDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [mapValid]
    data.mapValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [radarCanError]
    data.radarCanError = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vMax]
    data.vMax = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dPolyDEPRECATED]
    data.dPolyDEPRECATED = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.eventsDEPRECATED.forEach((val) => {
      length += CarEvent.getMessageSize(val);
    });
    length += GpsTrajectory.getMessageSize(object.gpsTrajectory);
    length += 4 * object.dPolyDEPRECATED.length;
    return length + 96;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Plan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5122b757463340c2ae5f629a57ec2ba5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool decelForTurn
    float32 vTarget
    bool lateralValidDEPRECATED
    uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource
    bool hasLead
    int64 radarStateMonoTime
    float32 jerkFactor
    float32 vCurvature
    float32 aTarget
    int64 mdMonoTime
    float32 aTargetMaxDEPRECATED
    float32 laneWidthDEPRECATED
    bool radarValid
    bool gpsPlannerActive
    bool fcw
    float32 processingDelay
    bool longitudinalValidDEPRECATED
    float32 aStart
    CarEvent[] eventsDEPRECATED
    bool hasRightLaneDEPRECATED
    float32 vStart
    float32 aCruise
    bool commIssue
    float32 vTargetFuture
    GpsTrajectory gpsTrajectory
    bool hasLeftLaneDEPRECATED
    float32 vCruise
    float32 aTargetMinDEPRECATED
    bool mapValid
    bool radarCanError
    float32 vMax
    float32[] dPolyDEPRECATED
    
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
    MSG: openpilot_bridge/CarEvent
    Header header
    
    bool enable
    bool noEntry
    uint32 name # enum const: EventName
    bool immediateDisable
    bool warning
    bool permanent
    bool softDisable
    bool userDisable
    bool preEnable
    
    ================================================================================
    MSG: openpilot_bridge/GpsTrajectory
    Header header
    
    float32[] y
    float32[] x
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Plan(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.decelForTurn !== undefined) {
      resolved.decelForTurn = msg.decelForTurn;
    }
    else {
      resolved.decelForTurn = false
    }

    if (msg.vTarget !== undefined) {
      resolved.vTarget = msg.vTarget;
    }
    else {
      resolved.vTarget = 0.0
    }

    if (msg.lateralValidDEPRECATED !== undefined) {
      resolved.lateralValidDEPRECATED = msg.lateralValidDEPRECATED;
    }
    else {
      resolved.lateralValidDEPRECATED = false
    }

    if (msg.longitudinalPlanSource !== undefined) {
      resolved.longitudinalPlanSource = msg.longitudinalPlanSource;
    }
    else {
      resolved.longitudinalPlanSource = 0
    }

    if (msg.hasLead !== undefined) {
      resolved.hasLead = msg.hasLead;
    }
    else {
      resolved.hasLead = false
    }

    if (msg.radarStateMonoTime !== undefined) {
      resolved.radarStateMonoTime = msg.radarStateMonoTime;
    }
    else {
      resolved.radarStateMonoTime = 0
    }

    if (msg.jerkFactor !== undefined) {
      resolved.jerkFactor = msg.jerkFactor;
    }
    else {
      resolved.jerkFactor = 0.0
    }

    if (msg.vCurvature !== undefined) {
      resolved.vCurvature = msg.vCurvature;
    }
    else {
      resolved.vCurvature = 0.0
    }

    if (msg.aTarget !== undefined) {
      resolved.aTarget = msg.aTarget;
    }
    else {
      resolved.aTarget = 0.0
    }

    if (msg.mdMonoTime !== undefined) {
      resolved.mdMonoTime = msg.mdMonoTime;
    }
    else {
      resolved.mdMonoTime = 0
    }

    if (msg.aTargetMaxDEPRECATED !== undefined) {
      resolved.aTargetMaxDEPRECATED = msg.aTargetMaxDEPRECATED;
    }
    else {
      resolved.aTargetMaxDEPRECATED = 0.0
    }

    if (msg.laneWidthDEPRECATED !== undefined) {
      resolved.laneWidthDEPRECATED = msg.laneWidthDEPRECATED;
    }
    else {
      resolved.laneWidthDEPRECATED = 0.0
    }

    if (msg.radarValid !== undefined) {
      resolved.radarValid = msg.radarValid;
    }
    else {
      resolved.radarValid = false
    }

    if (msg.gpsPlannerActive !== undefined) {
      resolved.gpsPlannerActive = msg.gpsPlannerActive;
    }
    else {
      resolved.gpsPlannerActive = false
    }

    if (msg.fcw !== undefined) {
      resolved.fcw = msg.fcw;
    }
    else {
      resolved.fcw = false
    }

    if (msg.processingDelay !== undefined) {
      resolved.processingDelay = msg.processingDelay;
    }
    else {
      resolved.processingDelay = 0.0
    }

    if (msg.longitudinalValidDEPRECATED !== undefined) {
      resolved.longitudinalValidDEPRECATED = msg.longitudinalValidDEPRECATED;
    }
    else {
      resolved.longitudinalValidDEPRECATED = false
    }

    if (msg.aStart !== undefined) {
      resolved.aStart = msg.aStart;
    }
    else {
      resolved.aStart = 0.0
    }

    if (msg.eventsDEPRECATED !== undefined) {
      resolved.eventsDEPRECATED = new Array(msg.eventsDEPRECATED.length);
      for (let i = 0; i < resolved.eventsDEPRECATED.length; ++i) {
        resolved.eventsDEPRECATED[i] = CarEvent.Resolve(msg.eventsDEPRECATED[i]);
      }
    }
    else {
      resolved.eventsDEPRECATED = []
    }

    if (msg.hasRightLaneDEPRECATED !== undefined) {
      resolved.hasRightLaneDEPRECATED = msg.hasRightLaneDEPRECATED;
    }
    else {
      resolved.hasRightLaneDEPRECATED = false
    }

    if (msg.vStart !== undefined) {
      resolved.vStart = msg.vStart;
    }
    else {
      resolved.vStart = 0.0
    }

    if (msg.aCruise !== undefined) {
      resolved.aCruise = msg.aCruise;
    }
    else {
      resolved.aCruise = 0.0
    }

    if (msg.commIssue !== undefined) {
      resolved.commIssue = msg.commIssue;
    }
    else {
      resolved.commIssue = false
    }

    if (msg.vTargetFuture !== undefined) {
      resolved.vTargetFuture = msg.vTargetFuture;
    }
    else {
      resolved.vTargetFuture = 0.0
    }

    if (msg.gpsTrajectory !== undefined) {
      resolved.gpsTrajectory = GpsTrajectory.Resolve(msg.gpsTrajectory)
    }
    else {
      resolved.gpsTrajectory = new GpsTrajectory()
    }

    if (msg.hasLeftLaneDEPRECATED !== undefined) {
      resolved.hasLeftLaneDEPRECATED = msg.hasLeftLaneDEPRECATED;
    }
    else {
      resolved.hasLeftLaneDEPRECATED = false
    }

    if (msg.vCruise !== undefined) {
      resolved.vCruise = msg.vCruise;
    }
    else {
      resolved.vCruise = 0.0
    }

    if (msg.aTargetMinDEPRECATED !== undefined) {
      resolved.aTargetMinDEPRECATED = msg.aTargetMinDEPRECATED;
    }
    else {
      resolved.aTargetMinDEPRECATED = 0.0
    }

    if (msg.mapValid !== undefined) {
      resolved.mapValid = msg.mapValid;
    }
    else {
      resolved.mapValid = false
    }

    if (msg.radarCanError !== undefined) {
      resolved.radarCanError = msg.radarCanError;
    }
    else {
      resolved.radarCanError = false
    }

    if (msg.vMax !== undefined) {
      resolved.vMax = msg.vMax;
    }
    else {
      resolved.vMax = 0.0
    }

    if (msg.dPolyDEPRECATED !== undefined) {
      resolved.dPolyDEPRECATED = msg.dPolyDEPRECATED;
    }
    else {
      resolved.dPolyDEPRECATED = []
    }

    return resolved;
    }
};

module.exports = Plan;
