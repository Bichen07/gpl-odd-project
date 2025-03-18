// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Lateralcontrolstate = require('./Lateralcontrolstate.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ControlsState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.ufSteerDEPRECATED = null;
      this.angleSteersDes = null;
      this.decelForTurn = null;
      this.steerOverride = null;
      this.rearViewCam = null;
      this.canErrorCounter = null;
      this.lateralControlState = null;
      this.vEgoRaw = null;
      this.forceDecel = null;
      this.alertSound = null;
      this.upSteerDEPRECATED = null;
      this.vEgo = null;
      this.angleSteers = null;
      this.jerkFactor = null;
      this.alertType = null;
      this.aTarget = null;
      this.alertStatus = null;
      this.alertSize = null;
      this.planMonoTime = null;
      this.aTargetMaxDEPRECATED = null;
      this.uiAccelCmd = null;
      this.state = null;
      this.alertBlinkingRate = null;
      this.angleModelBiasDEPRECATED = null;
      this.alertText2 = null;
      this.alertText1 = null;
      this.yDesDEPRECATED = null;
      this.vPid = null;
      this.vTargetLead = null;
      this.decelForModel = null;
      this.gpsPlannerActive = null;
      this.startMonoTime = null;
      this.canMonoTimeDEPRECATED = null;
      this.curvature = null;
      this.upAccelCmd = null;
      this.vCurvature = null;
      this.hudLeadDEPRECATED = null;
      this.active = null;
      this.awarenessStatus = null;
      this.uiSteerDEPRECATED = null;
      this.aEgoDEPRECATED = null;
      this.alertSoundDEPRECATED = null;
      this.ufAccelCmd = null;
      this.vCruise = null;
      this.yActualDEPRECATED = null;
      this.enabled = null;
      this.aTargetMinDEPRECATED = null;
      this.cumLagMs = null;
      this.mapValid = null;
      this.pathPlanMonoTime = null;
      this.engageable = null;
      this.mdMonoTimeDEPRECATED = null;
      this.driverMonitoringOn = null;
      this.canMonoTimes = null;
      this.radarStateMonoTimeDEPRECATED = null;
      this.longControlState = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('ufSteerDEPRECATED')) {
        this.ufSteerDEPRECATED = initObj.ufSteerDEPRECATED
      }
      else {
        this.ufSteerDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('angleSteersDes')) {
        this.angleSteersDes = initObj.angleSteersDes
      }
      else {
        this.angleSteersDes = 0.0;
      }
      if (initObj.hasOwnProperty('decelForTurn')) {
        this.decelForTurn = initObj.decelForTurn
      }
      else {
        this.decelForTurn = false;
      }
      if (initObj.hasOwnProperty('steerOverride')) {
        this.steerOverride = initObj.steerOverride
      }
      else {
        this.steerOverride = false;
      }
      if (initObj.hasOwnProperty('rearViewCam')) {
        this.rearViewCam = initObj.rearViewCam
      }
      else {
        this.rearViewCam = false;
      }
      if (initObj.hasOwnProperty('canErrorCounter')) {
        this.canErrorCounter = initObj.canErrorCounter
      }
      else {
        this.canErrorCounter = 0;
      }
      if (initObj.hasOwnProperty('lateralControlState')) {
        this.lateralControlState = initObj.lateralControlState
      }
      else {
        this.lateralControlState = new Lateralcontrolstate();
      }
      if (initObj.hasOwnProperty('vEgoRaw')) {
        this.vEgoRaw = initObj.vEgoRaw
      }
      else {
        this.vEgoRaw = 0.0;
      }
      if (initObj.hasOwnProperty('forceDecel')) {
        this.forceDecel = initObj.forceDecel
      }
      else {
        this.forceDecel = false;
      }
      if (initObj.hasOwnProperty('alertSound')) {
        this.alertSound = initObj.alertSound
      }
      else {
        this.alertSound = 0;
      }
      if (initObj.hasOwnProperty('upSteerDEPRECATED')) {
        this.upSteerDEPRECATED = initObj.upSteerDEPRECATED
      }
      else {
        this.upSteerDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('vEgo')) {
        this.vEgo = initObj.vEgo
      }
      else {
        this.vEgo = 0.0;
      }
      if (initObj.hasOwnProperty('angleSteers')) {
        this.angleSteers = initObj.angleSteers
      }
      else {
        this.angleSteers = 0.0;
      }
      if (initObj.hasOwnProperty('jerkFactor')) {
        this.jerkFactor = initObj.jerkFactor
      }
      else {
        this.jerkFactor = 0.0;
      }
      if (initObj.hasOwnProperty('alertType')) {
        this.alertType = initObj.alertType
      }
      else {
        this.alertType = [];
      }
      if (initObj.hasOwnProperty('aTarget')) {
        this.aTarget = initObj.aTarget
      }
      else {
        this.aTarget = 0.0;
      }
      if (initObj.hasOwnProperty('alertStatus')) {
        this.alertStatus = initObj.alertStatus
      }
      else {
        this.alertStatus = 0;
      }
      if (initObj.hasOwnProperty('alertSize')) {
        this.alertSize = initObj.alertSize
      }
      else {
        this.alertSize = 0;
      }
      if (initObj.hasOwnProperty('planMonoTime')) {
        this.planMonoTime = initObj.planMonoTime
      }
      else {
        this.planMonoTime = 0;
      }
      if (initObj.hasOwnProperty('aTargetMaxDEPRECATED')) {
        this.aTargetMaxDEPRECATED = initObj.aTargetMaxDEPRECATED
      }
      else {
        this.aTargetMaxDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('uiAccelCmd')) {
        this.uiAccelCmd = initObj.uiAccelCmd
      }
      else {
        this.uiAccelCmd = 0.0;
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = 0;
      }
      if (initObj.hasOwnProperty('alertBlinkingRate')) {
        this.alertBlinkingRate = initObj.alertBlinkingRate
      }
      else {
        this.alertBlinkingRate = 0.0;
      }
      if (initObj.hasOwnProperty('angleModelBiasDEPRECATED')) {
        this.angleModelBiasDEPRECATED = initObj.angleModelBiasDEPRECATED
      }
      else {
        this.angleModelBiasDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('alertText2')) {
        this.alertText2 = initObj.alertText2
      }
      else {
        this.alertText2 = [];
      }
      if (initObj.hasOwnProperty('alertText1')) {
        this.alertText1 = initObj.alertText1
      }
      else {
        this.alertText1 = [];
      }
      if (initObj.hasOwnProperty('yDesDEPRECATED')) {
        this.yDesDEPRECATED = initObj.yDesDEPRECATED
      }
      else {
        this.yDesDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('vPid')) {
        this.vPid = initObj.vPid
      }
      else {
        this.vPid = 0.0;
      }
      if (initObj.hasOwnProperty('vTargetLead')) {
        this.vTargetLead = initObj.vTargetLead
      }
      else {
        this.vTargetLead = 0.0;
      }
      if (initObj.hasOwnProperty('decelForModel')) {
        this.decelForModel = initObj.decelForModel
      }
      else {
        this.decelForModel = false;
      }
      if (initObj.hasOwnProperty('gpsPlannerActive')) {
        this.gpsPlannerActive = initObj.gpsPlannerActive
      }
      else {
        this.gpsPlannerActive = false;
      }
      if (initObj.hasOwnProperty('startMonoTime')) {
        this.startMonoTime = initObj.startMonoTime
      }
      else {
        this.startMonoTime = 0;
      }
      if (initObj.hasOwnProperty('canMonoTimeDEPRECATED')) {
        this.canMonoTimeDEPRECATED = initObj.canMonoTimeDEPRECATED
      }
      else {
        this.canMonoTimeDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('curvature')) {
        this.curvature = initObj.curvature
      }
      else {
        this.curvature = 0.0;
      }
      if (initObj.hasOwnProperty('upAccelCmd')) {
        this.upAccelCmd = initObj.upAccelCmd
      }
      else {
        this.upAccelCmd = 0.0;
      }
      if (initObj.hasOwnProperty('vCurvature')) {
        this.vCurvature = initObj.vCurvature
      }
      else {
        this.vCurvature = 0.0;
      }
      if (initObj.hasOwnProperty('hudLeadDEPRECATED')) {
        this.hudLeadDEPRECATED = initObj.hudLeadDEPRECATED
      }
      else {
        this.hudLeadDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('active')) {
        this.active = initObj.active
      }
      else {
        this.active = false;
      }
      if (initObj.hasOwnProperty('awarenessStatus')) {
        this.awarenessStatus = initObj.awarenessStatus
      }
      else {
        this.awarenessStatus = 0.0;
      }
      if (initObj.hasOwnProperty('uiSteerDEPRECATED')) {
        this.uiSteerDEPRECATED = initObj.uiSteerDEPRECATED
      }
      else {
        this.uiSteerDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('aEgoDEPRECATED')) {
        this.aEgoDEPRECATED = initObj.aEgoDEPRECATED
      }
      else {
        this.aEgoDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('alertSoundDEPRECATED')) {
        this.alertSoundDEPRECATED = initObj.alertSoundDEPRECATED
      }
      else {
        this.alertSoundDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('ufAccelCmd')) {
        this.ufAccelCmd = initObj.ufAccelCmd
      }
      else {
        this.ufAccelCmd = 0.0;
      }
      if (initObj.hasOwnProperty('vCruise')) {
        this.vCruise = initObj.vCruise
      }
      else {
        this.vCruise = 0.0;
      }
      if (initObj.hasOwnProperty('yActualDEPRECATED')) {
        this.yActualDEPRECATED = initObj.yActualDEPRECATED
      }
      else {
        this.yActualDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('enabled')) {
        this.enabled = initObj.enabled
      }
      else {
        this.enabled = false;
      }
      if (initObj.hasOwnProperty('aTargetMinDEPRECATED')) {
        this.aTargetMinDEPRECATED = initObj.aTargetMinDEPRECATED
      }
      else {
        this.aTargetMinDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('cumLagMs')) {
        this.cumLagMs = initObj.cumLagMs
      }
      else {
        this.cumLagMs = 0.0;
      }
      if (initObj.hasOwnProperty('mapValid')) {
        this.mapValid = initObj.mapValid
      }
      else {
        this.mapValid = false;
      }
      if (initObj.hasOwnProperty('pathPlanMonoTime')) {
        this.pathPlanMonoTime = initObj.pathPlanMonoTime
      }
      else {
        this.pathPlanMonoTime = 0;
      }
      if (initObj.hasOwnProperty('engageable')) {
        this.engageable = initObj.engageable
      }
      else {
        this.engageable = false;
      }
      if (initObj.hasOwnProperty('mdMonoTimeDEPRECATED')) {
        this.mdMonoTimeDEPRECATED = initObj.mdMonoTimeDEPRECATED
      }
      else {
        this.mdMonoTimeDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('driverMonitoringOn')) {
        this.driverMonitoringOn = initObj.driverMonitoringOn
      }
      else {
        this.driverMonitoringOn = false;
      }
      if (initObj.hasOwnProperty('canMonoTimes')) {
        this.canMonoTimes = initObj.canMonoTimes
      }
      else {
        this.canMonoTimes = [];
      }
      if (initObj.hasOwnProperty('radarStateMonoTimeDEPRECATED')) {
        this.radarStateMonoTimeDEPRECATED = initObj.radarStateMonoTimeDEPRECATED
      }
      else {
        this.radarStateMonoTimeDEPRECATED = 0;
      }
      if (initObj.hasOwnProperty('longControlState')) {
        this.longControlState = initObj.longControlState
      }
      else {
        this.longControlState = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ControlsState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [ufSteerDEPRECATED]
    bufferOffset = _serializer.float32(obj.ufSteerDEPRECATED, buffer, bufferOffset);
    // Serialize message field [angleSteersDes]
    bufferOffset = _serializer.float32(obj.angleSteersDes, buffer, bufferOffset);
    // Serialize message field [decelForTurn]
    bufferOffset = _serializer.bool(obj.decelForTurn, buffer, bufferOffset);
    // Serialize message field [steerOverride]
    bufferOffset = _serializer.bool(obj.steerOverride, buffer, bufferOffset);
    // Serialize message field [rearViewCam]
    bufferOffset = _serializer.bool(obj.rearViewCam, buffer, bufferOffset);
    // Serialize message field [canErrorCounter]
    bufferOffset = _serializer.int64(obj.canErrorCounter, buffer, bufferOffset);
    // Serialize message field [lateralControlState]
    bufferOffset = Lateralcontrolstate.serialize(obj.lateralControlState, buffer, bufferOffset);
    // Serialize message field [vEgoRaw]
    bufferOffset = _serializer.float32(obj.vEgoRaw, buffer, bufferOffset);
    // Serialize message field [forceDecel]
    bufferOffset = _serializer.bool(obj.forceDecel, buffer, bufferOffset);
    // Serialize message field [alertSound]
    bufferOffset = _serializer.uint32(obj.alertSound, buffer, bufferOffset);
    // Serialize message field [upSteerDEPRECATED]
    bufferOffset = _serializer.float32(obj.upSteerDEPRECATED, buffer, bufferOffset);
    // Serialize message field [vEgo]
    bufferOffset = _serializer.float32(obj.vEgo, buffer, bufferOffset);
    // Serialize message field [angleSteers]
    bufferOffset = _serializer.float32(obj.angleSteers, buffer, bufferOffset);
    // Serialize message field [jerkFactor]
    bufferOffset = _serializer.float32(obj.jerkFactor, buffer, bufferOffset);
    // Serialize message field [alertType]
    bufferOffset = _arraySerializer.string(obj.alertType, buffer, bufferOffset, null);
    // Serialize message field [aTarget]
    bufferOffset = _serializer.float32(obj.aTarget, buffer, bufferOffset);
    // Serialize message field [alertStatus]
    bufferOffset = _serializer.uint32(obj.alertStatus, buffer, bufferOffset);
    // Serialize message field [alertSize]
    bufferOffset = _serializer.uint32(obj.alertSize, buffer, bufferOffset);
    // Serialize message field [planMonoTime]
    bufferOffset = _serializer.int64(obj.planMonoTime, buffer, bufferOffset);
    // Serialize message field [aTargetMaxDEPRECATED]
    bufferOffset = _serializer.float32(obj.aTargetMaxDEPRECATED, buffer, bufferOffset);
    // Serialize message field [uiAccelCmd]
    bufferOffset = _serializer.float32(obj.uiAccelCmd, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.uint32(obj.state, buffer, bufferOffset);
    // Serialize message field [alertBlinkingRate]
    bufferOffset = _serializer.float32(obj.alertBlinkingRate, buffer, bufferOffset);
    // Serialize message field [angleModelBiasDEPRECATED]
    bufferOffset = _serializer.float32(obj.angleModelBiasDEPRECATED, buffer, bufferOffset);
    // Serialize message field [alertText2]
    bufferOffset = _arraySerializer.string(obj.alertText2, buffer, bufferOffset, null);
    // Serialize message field [alertText1]
    bufferOffset = _arraySerializer.string(obj.alertText1, buffer, bufferOffset, null);
    // Serialize message field [yDesDEPRECATED]
    bufferOffset = _serializer.float32(obj.yDesDEPRECATED, buffer, bufferOffset);
    // Serialize message field [vPid]
    bufferOffset = _serializer.float32(obj.vPid, buffer, bufferOffset);
    // Serialize message field [vTargetLead]
    bufferOffset = _serializer.float32(obj.vTargetLead, buffer, bufferOffset);
    // Serialize message field [decelForModel]
    bufferOffset = _serializer.bool(obj.decelForModel, buffer, bufferOffset);
    // Serialize message field [gpsPlannerActive]
    bufferOffset = _serializer.bool(obj.gpsPlannerActive, buffer, bufferOffset);
    // Serialize message field [startMonoTime]
    bufferOffset = _serializer.int64(obj.startMonoTime, buffer, bufferOffset);
    // Serialize message field [canMonoTimeDEPRECATED]
    bufferOffset = _serializer.int64(obj.canMonoTimeDEPRECATED, buffer, bufferOffset);
    // Serialize message field [curvature]
    bufferOffset = _serializer.float32(obj.curvature, buffer, bufferOffset);
    // Serialize message field [upAccelCmd]
    bufferOffset = _serializer.float32(obj.upAccelCmd, buffer, bufferOffset);
    // Serialize message field [vCurvature]
    bufferOffset = _serializer.float32(obj.vCurvature, buffer, bufferOffset);
    // Serialize message field [hudLeadDEPRECATED]
    bufferOffset = _serializer.int32(obj.hudLeadDEPRECATED, buffer, bufferOffset);
    // Serialize message field [active]
    bufferOffset = _serializer.bool(obj.active, buffer, bufferOffset);
    // Serialize message field [awarenessStatus]
    bufferOffset = _serializer.float32(obj.awarenessStatus, buffer, bufferOffset);
    // Serialize message field [uiSteerDEPRECATED]
    bufferOffset = _serializer.float32(obj.uiSteerDEPRECATED, buffer, bufferOffset);
    // Serialize message field [aEgoDEPRECATED]
    bufferOffset = _serializer.float32(obj.aEgoDEPRECATED, buffer, bufferOffset);
    // Serialize message field [alertSoundDEPRECATED]
    bufferOffset = _arraySerializer.string(obj.alertSoundDEPRECATED, buffer, bufferOffset, null);
    // Serialize message field [ufAccelCmd]
    bufferOffset = _serializer.float32(obj.ufAccelCmd, buffer, bufferOffset);
    // Serialize message field [vCruise]
    bufferOffset = _serializer.float32(obj.vCruise, buffer, bufferOffset);
    // Serialize message field [yActualDEPRECATED]
    bufferOffset = _serializer.float32(obj.yActualDEPRECATED, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    // Serialize message field [aTargetMinDEPRECATED]
    bufferOffset = _serializer.float32(obj.aTargetMinDEPRECATED, buffer, bufferOffset);
    // Serialize message field [cumLagMs]
    bufferOffset = _serializer.float32(obj.cumLagMs, buffer, bufferOffset);
    // Serialize message field [mapValid]
    bufferOffset = _serializer.bool(obj.mapValid, buffer, bufferOffset);
    // Serialize message field [pathPlanMonoTime]
    bufferOffset = _serializer.int64(obj.pathPlanMonoTime, buffer, bufferOffset);
    // Serialize message field [engageable]
    bufferOffset = _serializer.bool(obj.engageable, buffer, bufferOffset);
    // Serialize message field [mdMonoTimeDEPRECATED]
    bufferOffset = _serializer.int64(obj.mdMonoTimeDEPRECATED, buffer, bufferOffset);
    // Serialize message field [driverMonitoringOn]
    bufferOffset = _serializer.bool(obj.driverMonitoringOn, buffer, bufferOffset);
    // Serialize message field [canMonoTimes]
    bufferOffset = _arraySerializer.int64(obj.canMonoTimes, buffer, bufferOffset, null);
    // Serialize message field [radarStateMonoTimeDEPRECATED]
    bufferOffset = _serializer.int64(obj.radarStateMonoTimeDEPRECATED, buffer, bufferOffset);
    // Serialize message field [longControlState]
    bufferOffset = _serializer.uint32(obj.longControlState, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ControlsState
    let len;
    let data = new ControlsState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [ufSteerDEPRECATED]
    data.ufSteerDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angleSteersDes]
    data.angleSteersDes = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [decelForTurn]
    data.decelForTurn = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steerOverride]
    data.steerOverride = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rearViewCam]
    data.rearViewCam = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [canErrorCounter]
    data.canErrorCounter = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lateralControlState]
    data.lateralControlState = Lateralcontrolstate.deserialize(buffer, bufferOffset);
    // Deserialize message field [vEgoRaw]
    data.vEgoRaw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [forceDecel]
    data.forceDecel = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [alertSound]
    data.alertSound = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [upSteerDEPRECATED]
    data.upSteerDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vEgo]
    data.vEgo = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angleSteers]
    data.angleSteers = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [jerkFactor]
    data.jerkFactor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alertType]
    data.alertType = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [aTarget]
    data.aTarget = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alertStatus]
    data.alertStatus = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [alertSize]
    data.alertSize = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [planMonoTime]
    data.planMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [aTargetMaxDEPRECATED]
    data.aTargetMaxDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [uiAccelCmd]
    data.uiAccelCmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [alertBlinkingRate]
    data.alertBlinkingRate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angleModelBiasDEPRECATED]
    data.angleModelBiasDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alertText2]
    data.alertText2 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [alertText1]
    data.alertText1 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [yDesDEPRECATED]
    data.yDesDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vPid]
    data.vPid = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vTargetLead]
    data.vTargetLead = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [decelForModel]
    data.decelForModel = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gpsPlannerActive]
    data.gpsPlannerActive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [startMonoTime]
    data.startMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [canMonoTimeDEPRECATED]
    data.canMonoTimeDEPRECATED = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [curvature]
    data.curvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [upAccelCmd]
    data.upAccelCmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vCurvature]
    data.vCurvature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hudLeadDEPRECATED]
    data.hudLeadDEPRECATED = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [active]
    data.active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [awarenessStatus]
    data.awarenessStatus = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [uiSteerDEPRECATED]
    data.uiSteerDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aEgoDEPRECATED]
    data.aEgoDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alertSoundDEPRECATED]
    data.alertSoundDEPRECATED = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [ufAccelCmd]
    data.ufAccelCmd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vCruise]
    data.vCruise = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yActualDEPRECATED]
    data.yActualDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [aTargetMinDEPRECATED]
    data.aTargetMinDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cumLagMs]
    data.cumLagMs = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [mapValid]
    data.mapValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [pathPlanMonoTime]
    data.pathPlanMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [engageable]
    data.engageable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mdMonoTimeDEPRECATED]
    data.mdMonoTimeDEPRECATED = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [driverMonitoringOn]
    data.driverMonitoringOn = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [canMonoTimes]
    data.canMonoTimes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [radarStateMonoTimeDEPRECATED]
    data.radarStateMonoTimeDEPRECATED = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [longControlState]
    data.longControlState = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += Lateralcontrolstate.getMessageSize(object.lateralControlState);
    object.alertType.forEach((val) => {
      length += 4 + val.length;
    });
    object.alertText2.forEach((val) => {
      length += 4 + val.length;
    });
    object.alertText1.forEach((val) => {
      length += 4 + val.length;
    });
    object.alertSoundDEPRECATED.forEach((val) => {
      length += 4 + val.length;
    });
    length += 8 * object.canMonoTimes.length;
    return length + 215;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ControlsState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0a15b01853a70f5b28cd348ddb6112ec';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 ufSteerDEPRECATED
    float32 angleSteersDes
    bool decelForTurn
    bool steerOverride
    bool rearViewCam
    int64 canErrorCounter
    Lateralcontrolstate lateralControlState
    float32 vEgoRaw
    bool forceDecel
    uint32 alertSound # enum const: AudibleAlert
    float32 upSteerDEPRECATED
    float32 vEgo
    float32 angleSteers
    float32 jerkFactor
    string[] alertType
    float32 aTarget
    uint32 alertStatus # enum const: AlertStatus
    uint32 alertSize # enum const: AlertSize
    int64 planMonoTime
    float32 aTargetMaxDEPRECATED
    float32 uiAccelCmd
    uint32 state # enum const: OpenpilotState
    float32 alertBlinkingRate
    float32 angleModelBiasDEPRECATED
    string[] alertText2
    string[] alertText1
    float32 yDesDEPRECATED
    float32 vPid
    float32 vTargetLead
    bool decelForModel
    bool gpsPlannerActive
    int64 startMonoTime
    int64 canMonoTimeDEPRECATED
    float32 curvature
    float32 upAccelCmd
    float32 vCurvature
    int32 hudLeadDEPRECATED
    bool active
    float32 awarenessStatus
    float32 uiSteerDEPRECATED
    float32 aEgoDEPRECATED
    string[] alertSoundDEPRECATED
    float32 ufAccelCmd
    float32 vCruise
    float32 yActualDEPRECATED
    bool enabled
    float32 aTargetMinDEPRECATED
    float32 cumLagMs
    bool mapValid
    int64 pathPlanMonoTime
    bool engageable
    int64 mdMonoTimeDEPRECATED
    bool driverMonitoringOn
    int64[] canMonoTimes
    int64 radarStateMonoTimeDEPRECATED
    uint32 longControlState # enum const: LongControlState
    
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
    MSG: openpilot_bridge/Lateralcontrolstate
    Header header
    
    LateralLQRState lqrState
    LateralPIDState pidState
    LateralINDIState indiState
    
    ================================================================================
    MSG: openpilot_bridge/LateralLQRState
    Header header
    
    bool saturated
    float32 i
    float32 lqrOutput
    bool active
    float32 output
    float32 steerAngle
    
    ================================================================================
    MSG: openpilot_bridge/LateralPIDState
    Header header
    
    bool saturated
    float32 p
    float32 steerRate
    float32 f
    float32 i
    float32 angleError
    bool active
    float32 output
    float32 steerAngle
    
    ================================================================================
    MSG: openpilot_bridge/LateralINDIState
    Header header
    
    float32 rateSetPoint
    float32 delayedOutput
    bool saturated
    float32 steerAccel
    float32 steerRate
    float32 delta
    float32 accelError
    float32 accelSetPoint
    bool active
    float32 output
    float32 steerAngle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ControlsState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.ufSteerDEPRECATED !== undefined) {
      resolved.ufSteerDEPRECATED = msg.ufSteerDEPRECATED;
    }
    else {
      resolved.ufSteerDEPRECATED = 0.0
    }

    if (msg.angleSteersDes !== undefined) {
      resolved.angleSteersDes = msg.angleSteersDes;
    }
    else {
      resolved.angleSteersDes = 0.0
    }

    if (msg.decelForTurn !== undefined) {
      resolved.decelForTurn = msg.decelForTurn;
    }
    else {
      resolved.decelForTurn = false
    }

    if (msg.steerOverride !== undefined) {
      resolved.steerOverride = msg.steerOverride;
    }
    else {
      resolved.steerOverride = false
    }

    if (msg.rearViewCam !== undefined) {
      resolved.rearViewCam = msg.rearViewCam;
    }
    else {
      resolved.rearViewCam = false
    }

    if (msg.canErrorCounter !== undefined) {
      resolved.canErrorCounter = msg.canErrorCounter;
    }
    else {
      resolved.canErrorCounter = 0
    }

    if (msg.lateralControlState !== undefined) {
      resolved.lateralControlState = Lateralcontrolstate.Resolve(msg.lateralControlState)
    }
    else {
      resolved.lateralControlState = new Lateralcontrolstate()
    }

    if (msg.vEgoRaw !== undefined) {
      resolved.vEgoRaw = msg.vEgoRaw;
    }
    else {
      resolved.vEgoRaw = 0.0
    }

    if (msg.forceDecel !== undefined) {
      resolved.forceDecel = msg.forceDecel;
    }
    else {
      resolved.forceDecel = false
    }

    if (msg.alertSound !== undefined) {
      resolved.alertSound = msg.alertSound;
    }
    else {
      resolved.alertSound = 0
    }

    if (msg.upSteerDEPRECATED !== undefined) {
      resolved.upSteerDEPRECATED = msg.upSteerDEPRECATED;
    }
    else {
      resolved.upSteerDEPRECATED = 0.0
    }

    if (msg.vEgo !== undefined) {
      resolved.vEgo = msg.vEgo;
    }
    else {
      resolved.vEgo = 0.0
    }

    if (msg.angleSteers !== undefined) {
      resolved.angleSteers = msg.angleSteers;
    }
    else {
      resolved.angleSteers = 0.0
    }

    if (msg.jerkFactor !== undefined) {
      resolved.jerkFactor = msg.jerkFactor;
    }
    else {
      resolved.jerkFactor = 0.0
    }

    if (msg.alertType !== undefined) {
      resolved.alertType = msg.alertType;
    }
    else {
      resolved.alertType = []
    }

    if (msg.aTarget !== undefined) {
      resolved.aTarget = msg.aTarget;
    }
    else {
      resolved.aTarget = 0.0
    }

    if (msg.alertStatus !== undefined) {
      resolved.alertStatus = msg.alertStatus;
    }
    else {
      resolved.alertStatus = 0
    }

    if (msg.alertSize !== undefined) {
      resolved.alertSize = msg.alertSize;
    }
    else {
      resolved.alertSize = 0
    }

    if (msg.planMonoTime !== undefined) {
      resolved.planMonoTime = msg.planMonoTime;
    }
    else {
      resolved.planMonoTime = 0
    }

    if (msg.aTargetMaxDEPRECATED !== undefined) {
      resolved.aTargetMaxDEPRECATED = msg.aTargetMaxDEPRECATED;
    }
    else {
      resolved.aTargetMaxDEPRECATED = 0.0
    }

    if (msg.uiAccelCmd !== undefined) {
      resolved.uiAccelCmd = msg.uiAccelCmd;
    }
    else {
      resolved.uiAccelCmd = 0.0
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = 0
    }

    if (msg.alertBlinkingRate !== undefined) {
      resolved.alertBlinkingRate = msg.alertBlinkingRate;
    }
    else {
      resolved.alertBlinkingRate = 0.0
    }

    if (msg.angleModelBiasDEPRECATED !== undefined) {
      resolved.angleModelBiasDEPRECATED = msg.angleModelBiasDEPRECATED;
    }
    else {
      resolved.angleModelBiasDEPRECATED = 0.0
    }

    if (msg.alertText2 !== undefined) {
      resolved.alertText2 = msg.alertText2;
    }
    else {
      resolved.alertText2 = []
    }

    if (msg.alertText1 !== undefined) {
      resolved.alertText1 = msg.alertText1;
    }
    else {
      resolved.alertText1 = []
    }

    if (msg.yDesDEPRECATED !== undefined) {
      resolved.yDesDEPRECATED = msg.yDesDEPRECATED;
    }
    else {
      resolved.yDesDEPRECATED = 0.0
    }

    if (msg.vPid !== undefined) {
      resolved.vPid = msg.vPid;
    }
    else {
      resolved.vPid = 0.0
    }

    if (msg.vTargetLead !== undefined) {
      resolved.vTargetLead = msg.vTargetLead;
    }
    else {
      resolved.vTargetLead = 0.0
    }

    if (msg.decelForModel !== undefined) {
      resolved.decelForModel = msg.decelForModel;
    }
    else {
      resolved.decelForModel = false
    }

    if (msg.gpsPlannerActive !== undefined) {
      resolved.gpsPlannerActive = msg.gpsPlannerActive;
    }
    else {
      resolved.gpsPlannerActive = false
    }

    if (msg.startMonoTime !== undefined) {
      resolved.startMonoTime = msg.startMonoTime;
    }
    else {
      resolved.startMonoTime = 0
    }

    if (msg.canMonoTimeDEPRECATED !== undefined) {
      resolved.canMonoTimeDEPRECATED = msg.canMonoTimeDEPRECATED;
    }
    else {
      resolved.canMonoTimeDEPRECATED = 0
    }

    if (msg.curvature !== undefined) {
      resolved.curvature = msg.curvature;
    }
    else {
      resolved.curvature = 0.0
    }

    if (msg.upAccelCmd !== undefined) {
      resolved.upAccelCmd = msg.upAccelCmd;
    }
    else {
      resolved.upAccelCmd = 0.0
    }

    if (msg.vCurvature !== undefined) {
      resolved.vCurvature = msg.vCurvature;
    }
    else {
      resolved.vCurvature = 0.0
    }

    if (msg.hudLeadDEPRECATED !== undefined) {
      resolved.hudLeadDEPRECATED = msg.hudLeadDEPRECATED;
    }
    else {
      resolved.hudLeadDEPRECATED = 0
    }

    if (msg.active !== undefined) {
      resolved.active = msg.active;
    }
    else {
      resolved.active = false
    }

    if (msg.awarenessStatus !== undefined) {
      resolved.awarenessStatus = msg.awarenessStatus;
    }
    else {
      resolved.awarenessStatus = 0.0
    }

    if (msg.uiSteerDEPRECATED !== undefined) {
      resolved.uiSteerDEPRECATED = msg.uiSteerDEPRECATED;
    }
    else {
      resolved.uiSteerDEPRECATED = 0.0
    }

    if (msg.aEgoDEPRECATED !== undefined) {
      resolved.aEgoDEPRECATED = msg.aEgoDEPRECATED;
    }
    else {
      resolved.aEgoDEPRECATED = 0.0
    }

    if (msg.alertSoundDEPRECATED !== undefined) {
      resolved.alertSoundDEPRECATED = msg.alertSoundDEPRECATED;
    }
    else {
      resolved.alertSoundDEPRECATED = []
    }

    if (msg.ufAccelCmd !== undefined) {
      resolved.ufAccelCmd = msg.ufAccelCmd;
    }
    else {
      resolved.ufAccelCmd = 0.0
    }

    if (msg.vCruise !== undefined) {
      resolved.vCruise = msg.vCruise;
    }
    else {
      resolved.vCruise = 0.0
    }

    if (msg.yActualDEPRECATED !== undefined) {
      resolved.yActualDEPRECATED = msg.yActualDEPRECATED;
    }
    else {
      resolved.yActualDEPRECATED = 0.0
    }

    if (msg.enabled !== undefined) {
      resolved.enabled = msg.enabled;
    }
    else {
      resolved.enabled = false
    }

    if (msg.aTargetMinDEPRECATED !== undefined) {
      resolved.aTargetMinDEPRECATED = msg.aTargetMinDEPRECATED;
    }
    else {
      resolved.aTargetMinDEPRECATED = 0.0
    }

    if (msg.cumLagMs !== undefined) {
      resolved.cumLagMs = msg.cumLagMs;
    }
    else {
      resolved.cumLagMs = 0.0
    }

    if (msg.mapValid !== undefined) {
      resolved.mapValid = msg.mapValid;
    }
    else {
      resolved.mapValid = false
    }

    if (msg.pathPlanMonoTime !== undefined) {
      resolved.pathPlanMonoTime = msg.pathPlanMonoTime;
    }
    else {
      resolved.pathPlanMonoTime = 0
    }

    if (msg.engageable !== undefined) {
      resolved.engageable = msg.engageable;
    }
    else {
      resolved.engageable = false
    }

    if (msg.mdMonoTimeDEPRECATED !== undefined) {
      resolved.mdMonoTimeDEPRECATED = msg.mdMonoTimeDEPRECATED;
    }
    else {
      resolved.mdMonoTimeDEPRECATED = 0
    }

    if (msg.driverMonitoringOn !== undefined) {
      resolved.driverMonitoringOn = msg.driverMonitoringOn;
    }
    else {
      resolved.driverMonitoringOn = false
    }

    if (msg.canMonoTimes !== undefined) {
      resolved.canMonoTimes = msg.canMonoTimes;
    }
    else {
      resolved.canMonoTimes = []
    }

    if (msg.radarStateMonoTimeDEPRECATED !== undefined) {
      resolved.radarStateMonoTimeDEPRECATED = msg.radarStateMonoTimeDEPRECATED;
    }
    else {
      resolved.radarStateMonoTimeDEPRECATED = 0
    }

    if (msg.longControlState !== undefined) {
      resolved.longControlState = msg.longControlState;
    }
    else {
      resolved.longControlState = 0
    }

    return resolved;
    }
};

module.exports = ControlsState;
