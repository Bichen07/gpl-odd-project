// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Lateraltuning = require('./Lateraltuning.js');
let CarFw = require('./CarFw.js');
let LongitudinalPIDTuning = require('./LongitudinalPIDTuning.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class CarParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.safetyParam = null;
      this.steerRatioRear = null;
      this.enableDsu = null;
      this.lateralTuning = null;
      this.steerControlType = null;
      this.carFingerprint = null;
      this.rotationalInertia = null;
      this.safetyModelPassive = null;
      this.carFw = null;
      this.minEnableSpeed = null;
      this.enableGasInterceptor = null;
      this.radarOffCan = null;
      this.steerRatio = null;
      this.vEgoStopping = null;
      this.enableCamera = null;
      this.enableCruise = null;
      this.tireStiffnessFront = null;
      this.minSteerSpeed = null;
      this.stoppingControl = null;
      this.steerLimitTimer = null;
      this.transmissionType = null;
      this.steerMaxV = null;
      this.openpilotLongitudinalControl = null;
      this.gasMaxBP = null;
      this.enableApgs = null;
      this.radarTimeStep = null;
      this.carName = null;
      this.safetyModel = null;
      this.carVin = null;
      this.steerMaxBP = null;
      this.gasMaxV = null;
      this.steerRateCost = null;
      this.brakeMaxV = null;
      this.tireStiffnessRear = null;
      this.centerToFront = null;
      this.dashcamOnly = null;
      this.startAccel = null;
      this.wheelbase = null;
      this.brakeMaxBP = null;
      this.mass = null;
      this.steerActuatorDelay = null;
      this.longitudinalTuning = null;
      this.directAccelControl = null;
      this.communityFeature = null;
      this.isPandaBlack = null;
      this.steerLimitAlert = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('safetyParam')) {
        this.safetyParam = initObj.safetyParam
      }
      else {
        this.safetyParam = 0;
      }
      if (initObj.hasOwnProperty('steerRatioRear')) {
        this.steerRatioRear = initObj.steerRatioRear
      }
      else {
        this.steerRatioRear = 0.0;
      }
      if (initObj.hasOwnProperty('enableDsu')) {
        this.enableDsu = initObj.enableDsu
      }
      else {
        this.enableDsu = false;
      }
      if (initObj.hasOwnProperty('lateralTuning')) {
        this.lateralTuning = initObj.lateralTuning
      }
      else {
        this.lateralTuning = new Lateraltuning();
      }
      if (initObj.hasOwnProperty('steerControlType')) {
        this.steerControlType = initObj.steerControlType
      }
      else {
        this.steerControlType = 0;
      }
      if (initObj.hasOwnProperty('carFingerprint')) {
        this.carFingerprint = initObj.carFingerprint
      }
      else {
        this.carFingerprint = [];
      }
      if (initObj.hasOwnProperty('rotationalInertia')) {
        this.rotationalInertia = initObj.rotationalInertia
      }
      else {
        this.rotationalInertia = 0.0;
      }
      if (initObj.hasOwnProperty('safetyModelPassive')) {
        this.safetyModelPassive = initObj.safetyModelPassive
      }
      else {
        this.safetyModelPassive = 0;
      }
      if (initObj.hasOwnProperty('carFw')) {
        this.carFw = initObj.carFw
      }
      else {
        this.carFw = [];
      }
      if (initObj.hasOwnProperty('minEnableSpeed')) {
        this.minEnableSpeed = initObj.minEnableSpeed
      }
      else {
        this.minEnableSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('enableGasInterceptor')) {
        this.enableGasInterceptor = initObj.enableGasInterceptor
      }
      else {
        this.enableGasInterceptor = false;
      }
      if (initObj.hasOwnProperty('radarOffCan')) {
        this.radarOffCan = initObj.radarOffCan
      }
      else {
        this.radarOffCan = false;
      }
      if (initObj.hasOwnProperty('steerRatio')) {
        this.steerRatio = initObj.steerRatio
      }
      else {
        this.steerRatio = 0.0;
      }
      if (initObj.hasOwnProperty('vEgoStopping')) {
        this.vEgoStopping = initObj.vEgoStopping
      }
      else {
        this.vEgoStopping = 0.0;
      }
      if (initObj.hasOwnProperty('enableCamera')) {
        this.enableCamera = initObj.enableCamera
      }
      else {
        this.enableCamera = false;
      }
      if (initObj.hasOwnProperty('enableCruise')) {
        this.enableCruise = initObj.enableCruise
      }
      else {
        this.enableCruise = false;
      }
      if (initObj.hasOwnProperty('tireStiffnessFront')) {
        this.tireStiffnessFront = initObj.tireStiffnessFront
      }
      else {
        this.tireStiffnessFront = 0.0;
      }
      if (initObj.hasOwnProperty('minSteerSpeed')) {
        this.minSteerSpeed = initObj.minSteerSpeed
      }
      else {
        this.minSteerSpeed = 0.0;
      }
      if (initObj.hasOwnProperty('stoppingControl')) {
        this.stoppingControl = initObj.stoppingControl
      }
      else {
        this.stoppingControl = false;
      }
      if (initObj.hasOwnProperty('steerLimitTimer')) {
        this.steerLimitTimer = initObj.steerLimitTimer
      }
      else {
        this.steerLimitTimer = 0.0;
      }
      if (initObj.hasOwnProperty('transmissionType')) {
        this.transmissionType = initObj.transmissionType
      }
      else {
        this.transmissionType = 0;
      }
      if (initObj.hasOwnProperty('steerMaxV')) {
        this.steerMaxV = initObj.steerMaxV
      }
      else {
        this.steerMaxV = [];
      }
      if (initObj.hasOwnProperty('openpilotLongitudinalControl')) {
        this.openpilotLongitudinalControl = initObj.openpilotLongitudinalControl
      }
      else {
        this.openpilotLongitudinalControl = false;
      }
      if (initObj.hasOwnProperty('gasMaxBP')) {
        this.gasMaxBP = initObj.gasMaxBP
      }
      else {
        this.gasMaxBP = [];
      }
      if (initObj.hasOwnProperty('enableApgs')) {
        this.enableApgs = initObj.enableApgs
      }
      else {
        this.enableApgs = false;
      }
      if (initObj.hasOwnProperty('radarTimeStep')) {
        this.radarTimeStep = initObj.radarTimeStep
      }
      else {
        this.radarTimeStep = 0.0;
      }
      if (initObj.hasOwnProperty('carName')) {
        this.carName = initObj.carName
      }
      else {
        this.carName = [];
      }
      if (initObj.hasOwnProperty('safetyModel')) {
        this.safetyModel = initObj.safetyModel
      }
      else {
        this.safetyModel = 0;
      }
      if (initObj.hasOwnProperty('carVin')) {
        this.carVin = initObj.carVin
      }
      else {
        this.carVin = [];
      }
      if (initObj.hasOwnProperty('steerMaxBP')) {
        this.steerMaxBP = initObj.steerMaxBP
      }
      else {
        this.steerMaxBP = [];
      }
      if (initObj.hasOwnProperty('gasMaxV')) {
        this.gasMaxV = initObj.gasMaxV
      }
      else {
        this.gasMaxV = [];
      }
      if (initObj.hasOwnProperty('steerRateCost')) {
        this.steerRateCost = initObj.steerRateCost
      }
      else {
        this.steerRateCost = 0.0;
      }
      if (initObj.hasOwnProperty('brakeMaxV')) {
        this.brakeMaxV = initObj.brakeMaxV
      }
      else {
        this.brakeMaxV = [];
      }
      if (initObj.hasOwnProperty('tireStiffnessRear')) {
        this.tireStiffnessRear = initObj.tireStiffnessRear
      }
      else {
        this.tireStiffnessRear = 0.0;
      }
      if (initObj.hasOwnProperty('centerToFront')) {
        this.centerToFront = initObj.centerToFront
      }
      else {
        this.centerToFront = 0.0;
      }
      if (initObj.hasOwnProperty('dashcamOnly')) {
        this.dashcamOnly = initObj.dashcamOnly
      }
      else {
        this.dashcamOnly = false;
      }
      if (initObj.hasOwnProperty('startAccel')) {
        this.startAccel = initObj.startAccel
      }
      else {
        this.startAccel = 0.0;
      }
      if (initObj.hasOwnProperty('wheelbase')) {
        this.wheelbase = initObj.wheelbase
      }
      else {
        this.wheelbase = 0.0;
      }
      if (initObj.hasOwnProperty('brakeMaxBP')) {
        this.brakeMaxBP = initObj.brakeMaxBP
      }
      else {
        this.brakeMaxBP = [];
      }
      if (initObj.hasOwnProperty('mass')) {
        this.mass = initObj.mass
      }
      else {
        this.mass = 0.0;
      }
      if (initObj.hasOwnProperty('steerActuatorDelay')) {
        this.steerActuatorDelay = initObj.steerActuatorDelay
      }
      else {
        this.steerActuatorDelay = 0.0;
      }
      if (initObj.hasOwnProperty('longitudinalTuning')) {
        this.longitudinalTuning = initObj.longitudinalTuning
      }
      else {
        this.longitudinalTuning = new LongitudinalPIDTuning();
      }
      if (initObj.hasOwnProperty('directAccelControl')) {
        this.directAccelControl = initObj.directAccelControl
      }
      else {
        this.directAccelControl = false;
      }
      if (initObj.hasOwnProperty('communityFeature')) {
        this.communityFeature = initObj.communityFeature
      }
      else {
        this.communityFeature = false;
      }
      if (initObj.hasOwnProperty('isPandaBlack')) {
        this.isPandaBlack = initObj.isPandaBlack
      }
      else {
        this.isPandaBlack = false;
      }
      if (initObj.hasOwnProperty('steerLimitAlert')) {
        this.steerLimitAlert = initObj.steerLimitAlert
      }
      else {
        this.steerLimitAlert = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CarParams
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [safetyParam]
    bufferOffset = _serializer.int32(obj.safetyParam, buffer, bufferOffset);
    // Serialize message field [steerRatioRear]
    bufferOffset = _serializer.float32(obj.steerRatioRear, buffer, bufferOffset);
    // Serialize message field [enableDsu]
    bufferOffset = _serializer.bool(obj.enableDsu, buffer, bufferOffset);
    // Serialize message field [lateralTuning]
    bufferOffset = Lateraltuning.serialize(obj.lateralTuning, buffer, bufferOffset);
    // Serialize message field [steerControlType]
    bufferOffset = _serializer.uint32(obj.steerControlType, buffer, bufferOffset);
    // Serialize message field [carFingerprint]
    bufferOffset = _arraySerializer.string(obj.carFingerprint, buffer, bufferOffset, null);
    // Serialize message field [rotationalInertia]
    bufferOffset = _serializer.float32(obj.rotationalInertia, buffer, bufferOffset);
    // Serialize message field [safetyModelPassive]
    bufferOffset = _serializer.uint32(obj.safetyModelPassive, buffer, bufferOffset);
    // Serialize message field [carFw]
    // Serialize the length for message field [carFw]
    bufferOffset = _serializer.uint32(obj.carFw.length, buffer, bufferOffset);
    obj.carFw.forEach((val) => {
      bufferOffset = CarFw.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [minEnableSpeed]
    bufferOffset = _serializer.float32(obj.minEnableSpeed, buffer, bufferOffset);
    // Serialize message field [enableGasInterceptor]
    bufferOffset = _serializer.bool(obj.enableGasInterceptor, buffer, bufferOffset);
    // Serialize message field [radarOffCan]
    bufferOffset = _serializer.bool(obj.radarOffCan, buffer, bufferOffset);
    // Serialize message field [steerRatio]
    bufferOffset = _serializer.float32(obj.steerRatio, buffer, bufferOffset);
    // Serialize message field [vEgoStopping]
    bufferOffset = _serializer.float32(obj.vEgoStopping, buffer, bufferOffset);
    // Serialize message field [enableCamera]
    bufferOffset = _serializer.bool(obj.enableCamera, buffer, bufferOffset);
    // Serialize message field [enableCruise]
    bufferOffset = _serializer.bool(obj.enableCruise, buffer, bufferOffset);
    // Serialize message field [tireStiffnessFront]
    bufferOffset = _serializer.float32(obj.tireStiffnessFront, buffer, bufferOffset);
    // Serialize message field [minSteerSpeed]
    bufferOffset = _serializer.float32(obj.minSteerSpeed, buffer, bufferOffset);
    // Serialize message field [stoppingControl]
    bufferOffset = _serializer.bool(obj.stoppingControl, buffer, bufferOffset);
    // Serialize message field [steerLimitTimer]
    bufferOffset = _serializer.float32(obj.steerLimitTimer, buffer, bufferOffset);
    // Serialize message field [transmissionType]
    bufferOffset = _serializer.uint32(obj.transmissionType, buffer, bufferOffset);
    // Serialize message field [steerMaxV]
    bufferOffset = _arraySerializer.float32(obj.steerMaxV, buffer, bufferOffset, null);
    // Serialize message field [openpilotLongitudinalControl]
    bufferOffset = _serializer.bool(obj.openpilotLongitudinalControl, buffer, bufferOffset);
    // Serialize message field [gasMaxBP]
    bufferOffset = _arraySerializer.float32(obj.gasMaxBP, buffer, bufferOffset, null);
    // Serialize message field [enableApgs]
    bufferOffset = _serializer.bool(obj.enableApgs, buffer, bufferOffset);
    // Serialize message field [radarTimeStep]
    bufferOffset = _serializer.float32(obj.radarTimeStep, buffer, bufferOffset);
    // Serialize message field [carName]
    bufferOffset = _arraySerializer.string(obj.carName, buffer, bufferOffset, null);
    // Serialize message field [safetyModel]
    bufferOffset = _serializer.uint32(obj.safetyModel, buffer, bufferOffset);
    // Serialize message field [carVin]
    bufferOffset = _arraySerializer.string(obj.carVin, buffer, bufferOffset, null);
    // Serialize message field [steerMaxBP]
    bufferOffset = _arraySerializer.float32(obj.steerMaxBP, buffer, bufferOffset, null);
    // Serialize message field [gasMaxV]
    bufferOffset = _arraySerializer.float32(obj.gasMaxV, buffer, bufferOffset, null);
    // Serialize message field [steerRateCost]
    bufferOffset = _serializer.float32(obj.steerRateCost, buffer, bufferOffset);
    // Serialize message field [brakeMaxV]
    bufferOffset = _arraySerializer.float32(obj.brakeMaxV, buffer, bufferOffset, null);
    // Serialize message field [tireStiffnessRear]
    bufferOffset = _serializer.float32(obj.tireStiffnessRear, buffer, bufferOffset);
    // Serialize message field [centerToFront]
    bufferOffset = _serializer.float32(obj.centerToFront, buffer, bufferOffset);
    // Serialize message field [dashcamOnly]
    bufferOffset = _serializer.bool(obj.dashcamOnly, buffer, bufferOffset);
    // Serialize message field [startAccel]
    bufferOffset = _serializer.float32(obj.startAccel, buffer, bufferOffset);
    // Serialize message field [wheelbase]
    bufferOffset = _serializer.float32(obj.wheelbase, buffer, bufferOffset);
    // Serialize message field [brakeMaxBP]
    bufferOffset = _arraySerializer.float32(obj.brakeMaxBP, buffer, bufferOffset, null);
    // Serialize message field [mass]
    bufferOffset = _serializer.float32(obj.mass, buffer, bufferOffset);
    // Serialize message field [steerActuatorDelay]
    bufferOffset = _serializer.float32(obj.steerActuatorDelay, buffer, bufferOffset);
    // Serialize message field [longitudinalTuning]
    bufferOffset = LongitudinalPIDTuning.serialize(obj.longitudinalTuning, buffer, bufferOffset);
    // Serialize message field [directAccelControl]
    bufferOffset = _serializer.bool(obj.directAccelControl, buffer, bufferOffset);
    // Serialize message field [communityFeature]
    bufferOffset = _serializer.bool(obj.communityFeature, buffer, bufferOffset);
    // Serialize message field [isPandaBlack]
    bufferOffset = _serializer.bool(obj.isPandaBlack, buffer, bufferOffset);
    // Serialize message field [steerLimitAlert]
    bufferOffset = _serializer.bool(obj.steerLimitAlert, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CarParams
    let len;
    let data = new CarParams(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [safetyParam]
    data.safetyParam = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [steerRatioRear]
    data.steerRatioRear = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enableDsu]
    data.enableDsu = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lateralTuning]
    data.lateralTuning = Lateraltuning.deserialize(buffer, bufferOffset);
    // Deserialize message field [steerControlType]
    data.steerControlType = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [carFingerprint]
    data.carFingerprint = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [rotationalInertia]
    data.rotationalInertia = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [safetyModelPassive]
    data.safetyModelPassive = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [carFw]
    // Deserialize array length for message field [carFw]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.carFw = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.carFw[i] = CarFw.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [minEnableSpeed]
    data.minEnableSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enableGasInterceptor]
    data.enableGasInterceptor = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [radarOffCan]
    data.radarOffCan = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steerRatio]
    data.steerRatio = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vEgoStopping]
    data.vEgoStopping = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [enableCamera]
    data.enableCamera = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [enableCruise]
    data.enableCruise = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [tireStiffnessFront]
    data.tireStiffnessFront = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [minSteerSpeed]
    data.minSteerSpeed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stoppingControl]
    data.stoppingControl = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steerLimitTimer]
    data.steerLimitTimer = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [transmissionType]
    data.transmissionType = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [steerMaxV]
    data.steerMaxV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [openpilotLongitudinalControl]
    data.openpilotLongitudinalControl = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gasMaxBP]
    data.gasMaxBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [enableApgs]
    data.enableApgs = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [radarTimeStep]
    data.radarTimeStep = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [carName]
    data.carName = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [safetyModel]
    data.safetyModel = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [carVin]
    data.carVin = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [steerMaxBP]
    data.steerMaxBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [gasMaxV]
    data.gasMaxV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [steerRateCost]
    data.steerRateCost = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brakeMaxV]
    data.brakeMaxV = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [tireStiffnessRear]
    data.tireStiffnessRear = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [centerToFront]
    data.centerToFront = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dashcamOnly]
    data.dashcamOnly = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [startAccel]
    data.startAccel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [wheelbase]
    data.wheelbase = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brakeMaxBP]
    data.brakeMaxBP = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [mass]
    data.mass = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerActuatorDelay]
    data.steerActuatorDelay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [longitudinalTuning]
    data.longitudinalTuning = LongitudinalPIDTuning.deserialize(buffer, bufferOffset);
    // Deserialize message field [directAccelControl]
    data.directAccelControl = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [communityFeature]
    data.communityFeature = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [isPandaBlack]
    data.isPandaBlack = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steerLimitAlert]
    data.steerLimitAlert = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += Lateraltuning.getMessageSize(object.lateralTuning);
    object.carFingerprint.forEach((val) => {
      length += 4 + val.length;
    });
    object.carFw.forEach((val) => {
      length += CarFw.getMessageSize(val);
    });
    length += 4 * object.steerMaxV.length;
    length += 4 * object.gasMaxBP.length;
    object.carName.forEach((val) => {
      length += 4 + val.length;
    });
    object.carVin.forEach((val) => {
      length += 4 + val.length;
    });
    length += 4 * object.steerMaxBP.length;
    length += 4 * object.gasMaxV.length;
    length += 4 * object.brakeMaxV.length;
    length += 4 * object.brakeMaxBP.length;
    length += LongitudinalPIDTuning.getMessageSize(object.longitudinalTuning);
    return length + 137;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CarParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ef560c6163951e81bdbf13272f514bb1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 safetyParam
    float32 steerRatioRear
    bool enableDsu
    Lateraltuning lateralTuning
    uint32 steerControlType # enum const: SteerControlType
    string[] carFingerprint
    float32 rotationalInertia
    uint32 safetyModelPassive # enum const: SafetyModel
    CarFw[] carFw
    float32 minEnableSpeed
    bool enableGasInterceptor
    bool radarOffCan
    float32 steerRatio
    float32 vEgoStopping
    bool enableCamera
    bool enableCruise
    float32 tireStiffnessFront
    float32 minSteerSpeed
    bool stoppingControl
    float32 steerLimitTimer
    uint32 transmissionType # enum const: TransmissionType
    float32[] steerMaxV
    bool openpilotLongitudinalControl
    float32[] gasMaxBP
    bool enableApgs
    float32 radarTimeStep
    string[] carName
    uint32 safetyModel # enum const: SafetyModel
    string[] carVin
    float32[] steerMaxBP
    float32[] gasMaxV
    float32 steerRateCost
    float32[] brakeMaxV
    float32 tireStiffnessRear
    float32 centerToFront
    bool dashcamOnly
    float32 startAccel
    float32 wheelbase
    float32[] brakeMaxBP
    float32 mass
    float32 steerActuatorDelay
    LongitudinalPIDTuning longitudinalTuning
    bool directAccelControl
    bool communityFeature
    bool isPandaBlack
    bool steerLimitAlert
    
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
    MSG: openpilot_bridge/Lateraltuning
    Header header
    
    LateralINDITuning indi
    LateralPIDTuning pid
    LateralLQRTuning lqr
    
    ================================================================================
    MSG: openpilot_bridge/LateralINDITuning
    Header header
    
    float32 actuatorEffectiveness
    float32 outerLoopGain
    float32 innerLoopGain
    float32 timeConstant
    
    ================================================================================
    MSG: openpilot_bridge/LateralPIDTuning
    Header header
    
    float32[] kiBP
    float32 kf
    float32[] kiV
    float32[] kpV
    float32[] kpBP
    
    ================================================================================
    MSG: openpilot_bridge/LateralLQRTuning
    Header header
    
    float32[] a
    float32[] c
    float32 scale
    float32 ki
    float32[] l
    float32[] b
    float32 dcGain
    float32[] k
    
    ================================================================================
    MSG: openpilot_bridge/CarFw
    Header header
    
    uint32 ecu # enum const: Ecu
    int64 subAddress
    string[] fwVersion
    int64 address
    
    ================================================================================
    MSG: openpilot_bridge/LongitudinalPIDTuning
    Header header
    
    float32[] kpV
    float32[] kpBP
    float32[] deadzoneBP
    float32[] kiV
    float32[] deadzoneV
    float32[] kiBP
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CarParams(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.safetyParam !== undefined) {
      resolved.safetyParam = msg.safetyParam;
    }
    else {
      resolved.safetyParam = 0
    }

    if (msg.steerRatioRear !== undefined) {
      resolved.steerRatioRear = msg.steerRatioRear;
    }
    else {
      resolved.steerRatioRear = 0.0
    }

    if (msg.enableDsu !== undefined) {
      resolved.enableDsu = msg.enableDsu;
    }
    else {
      resolved.enableDsu = false
    }

    if (msg.lateralTuning !== undefined) {
      resolved.lateralTuning = Lateraltuning.Resolve(msg.lateralTuning)
    }
    else {
      resolved.lateralTuning = new Lateraltuning()
    }

    if (msg.steerControlType !== undefined) {
      resolved.steerControlType = msg.steerControlType;
    }
    else {
      resolved.steerControlType = 0
    }

    if (msg.carFingerprint !== undefined) {
      resolved.carFingerprint = msg.carFingerprint;
    }
    else {
      resolved.carFingerprint = []
    }

    if (msg.rotationalInertia !== undefined) {
      resolved.rotationalInertia = msg.rotationalInertia;
    }
    else {
      resolved.rotationalInertia = 0.0
    }

    if (msg.safetyModelPassive !== undefined) {
      resolved.safetyModelPassive = msg.safetyModelPassive;
    }
    else {
      resolved.safetyModelPassive = 0
    }

    if (msg.carFw !== undefined) {
      resolved.carFw = new Array(msg.carFw.length);
      for (let i = 0; i < resolved.carFw.length; ++i) {
        resolved.carFw[i] = CarFw.Resolve(msg.carFw[i]);
      }
    }
    else {
      resolved.carFw = []
    }

    if (msg.minEnableSpeed !== undefined) {
      resolved.minEnableSpeed = msg.minEnableSpeed;
    }
    else {
      resolved.minEnableSpeed = 0.0
    }

    if (msg.enableGasInterceptor !== undefined) {
      resolved.enableGasInterceptor = msg.enableGasInterceptor;
    }
    else {
      resolved.enableGasInterceptor = false
    }

    if (msg.radarOffCan !== undefined) {
      resolved.radarOffCan = msg.radarOffCan;
    }
    else {
      resolved.radarOffCan = false
    }

    if (msg.steerRatio !== undefined) {
      resolved.steerRatio = msg.steerRatio;
    }
    else {
      resolved.steerRatio = 0.0
    }

    if (msg.vEgoStopping !== undefined) {
      resolved.vEgoStopping = msg.vEgoStopping;
    }
    else {
      resolved.vEgoStopping = 0.0
    }

    if (msg.enableCamera !== undefined) {
      resolved.enableCamera = msg.enableCamera;
    }
    else {
      resolved.enableCamera = false
    }

    if (msg.enableCruise !== undefined) {
      resolved.enableCruise = msg.enableCruise;
    }
    else {
      resolved.enableCruise = false
    }

    if (msg.tireStiffnessFront !== undefined) {
      resolved.tireStiffnessFront = msg.tireStiffnessFront;
    }
    else {
      resolved.tireStiffnessFront = 0.0
    }

    if (msg.minSteerSpeed !== undefined) {
      resolved.minSteerSpeed = msg.minSteerSpeed;
    }
    else {
      resolved.minSteerSpeed = 0.0
    }

    if (msg.stoppingControl !== undefined) {
      resolved.stoppingControl = msg.stoppingControl;
    }
    else {
      resolved.stoppingControl = false
    }

    if (msg.steerLimitTimer !== undefined) {
      resolved.steerLimitTimer = msg.steerLimitTimer;
    }
    else {
      resolved.steerLimitTimer = 0.0
    }

    if (msg.transmissionType !== undefined) {
      resolved.transmissionType = msg.transmissionType;
    }
    else {
      resolved.transmissionType = 0
    }

    if (msg.steerMaxV !== undefined) {
      resolved.steerMaxV = msg.steerMaxV;
    }
    else {
      resolved.steerMaxV = []
    }

    if (msg.openpilotLongitudinalControl !== undefined) {
      resolved.openpilotLongitudinalControl = msg.openpilotLongitudinalControl;
    }
    else {
      resolved.openpilotLongitudinalControl = false
    }

    if (msg.gasMaxBP !== undefined) {
      resolved.gasMaxBP = msg.gasMaxBP;
    }
    else {
      resolved.gasMaxBP = []
    }

    if (msg.enableApgs !== undefined) {
      resolved.enableApgs = msg.enableApgs;
    }
    else {
      resolved.enableApgs = false
    }

    if (msg.radarTimeStep !== undefined) {
      resolved.radarTimeStep = msg.radarTimeStep;
    }
    else {
      resolved.radarTimeStep = 0.0
    }

    if (msg.carName !== undefined) {
      resolved.carName = msg.carName;
    }
    else {
      resolved.carName = []
    }

    if (msg.safetyModel !== undefined) {
      resolved.safetyModel = msg.safetyModel;
    }
    else {
      resolved.safetyModel = 0
    }

    if (msg.carVin !== undefined) {
      resolved.carVin = msg.carVin;
    }
    else {
      resolved.carVin = []
    }

    if (msg.steerMaxBP !== undefined) {
      resolved.steerMaxBP = msg.steerMaxBP;
    }
    else {
      resolved.steerMaxBP = []
    }

    if (msg.gasMaxV !== undefined) {
      resolved.gasMaxV = msg.gasMaxV;
    }
    else {
      resolved.gasMaxV = []
    }

    if (msg.steerRateCost !== undefined) {
      resolved.steerRateCost = msg.steerRateCost;
    }
    else {
      resolved.steerRateCost = 0.0
    }

    if (msg.brakeMaxV !== undefined) {
      resolved.brakeMaxV = msg.brakeMaxV;
    }
    else {
      resolved.brakeMaxV = []
    }

    if (msg.tireStiffnessRear !== undefined) {
      resolved.tireStiffnessRear = msg.tireStiffnessRear;
    }
    else {
      resolved.tireStiffnessRear = 0.0
    }

    if (msg.centerToFront !== undefined) {
      resolved.centerToFront = msg.centerToFront;
    }
    else {
      resolved.centerToFront = 0.0
    }

    if (msg.dashcamOnly !== undefined) {
      resolved.dashcamOnly = msg.dashcamOnly;
    }
    else {
      resolved.dashcamOnly = false
    }

    if (msg.startAccel !== undefined) {
      resolved.startAccel = msg.startAccel;
    }
    else {
      resolved.startAccel = 0.0
    }

    if (msg.wheelbase !== undefined) {
      resolved.wheelbase = msg.wheelbase;
    }
    else {
      resolved.wheelbase = 0.0
    }

    if (msg.brakeMaxBP !== undefined) {
      resolved.brakeMaxBP = msg.brakeMaxBP;
    }
    else {
      resolved.brakeMaxBP = []
    }

    if (msg.mass !== undefined) {
      resolved.mass = msg.mass;
    }
    else {
      resolved.mass = 0.0
    }

    if (msg.steerActuatorDelay !== undefined) {
      resolved.steerActuatorDelay = msg.steerActuatorDelay;
    }
    else {
      resolved.steerActuatorDelay = 0.0
    }

    if (msg.longitudinalTuning !== undefined) {
      resolved.longitudinalTuning = LongitudinalPIDTuning.Resolve(msg.longitudinalTuning)
    }
    else {
      resolved.longitudinalTuning = new LongitudinalPIDTuning()
    }

    if (msg.directAccelControl !== undefined) {
      resolved.directAccelControl = msg.directAccelControl;
    }
    else {
      resolved.directAccelControl = false
    }

    if (msg.communityFeature !== undefined) {
      resolved.communityFeature = msg.communityFeature;
    }
    else {
      resolved.communityFeature = false
    }

    if (msg.isPandaBlack !== undefined) {
      resolved.isPandaBlack = msg.isPandaBlack;
    }
    else {
      resolved.isPandaBlack = false
    }

    if (msg.steerLimitAlert !== undefined) {
      resolved.steerLimitAlert = msg.steerLimitAlert;
    }
    else {
      resolved.steerLimitAlert = false
    }

    return resolved;
    }
};

module.exports = CarParams;
