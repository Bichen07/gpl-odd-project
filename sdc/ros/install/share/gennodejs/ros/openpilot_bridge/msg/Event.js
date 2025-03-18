// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LidarPts = require('./LidarPts.js');
let GPSNMEAData = require('./GPSNMEAData.js');
let AndroidLogEntry = require('./AndroidLogEntry.js');
let CalibrationFeatures = require('./CalibrationFeatures.js');
let LiveMapData = require('./LiveMapData.js');
let OrbFeatures = require('./OrbFeatures.js');
let FrameData = require('./FrameData.js');
let CanData = require('./CanData.js');
let QcomGnss = require('./QcomGnss.js');
let LiveUI = require('./LiveUI.js');
let CarEvent = require('./CarEvent.js');
let RadarState = require('./RadarState.js');
let ThermalData = require('./ThermalData.js');
let Clocks = require('./Clocks.js');
let UiLayoutState = require('./UiLayoutState.js');
let OrbslamCorrection = require('./OrbslamCorrection.js');
let CameraOdometry = require('./CameraOdometry.js');
let GPSPlannerPoints = require('./GPSPlannerPoints.js');
let SensorEventData = require('./SensorEventData.js');
let ControlsState = require('./ControlsState.js');
let AndroidGnss = require('./AndroidGnss.js');
let EthernetPacket = require('./EthernetPacket.js');
let LiveLocationData = require('./LiveLocationData.js');
let Boot = require('./Boot.js');
let TrafficEvent = require('./TrafficEvent.js');
let HealthData = require('./HealthData.js');
let LiveCalibrationData = require('./LiveCalibrationData.js');
let WifiScan = require('./WifiScan.js');
let CarState = require('./CarState.js');
let Thumbnail = require('./Thumbnail.js');
let NavUpdate = require('./NavUpdate.js');
let OrbKeyFrame = require('./OrbKeyFrame.js');
let UiNavigationEvent = require('./UiNavigationEvent.js');
let CarControl = require('./CarControl.js');
let EncodeIndex = require('./EncodeIndex.js');
let DriverMonitoring = require('./DriverMonitoring.js');
let InitData = require('./InitData.js');
let OrbOdometry = require('./OrbOdometry.js');
let Joystick = require('./Joystick.js');
let LiveMpcData = require('./LiveMpcData.js');
let Plan = require('./Plan.js');
let CellInfo = require('./CellInfo.js');
let NavStatus = require('./NavStatus.js');
let GpsLocationData = require('./GpsLocationData.js');
let LiveEventData = require('./LiveEventData.js');
let OrbFeaturesSummary = require('./OrbFeaturesSummary.js');
let UbloxGnss = require('./UbloxGnss.js');
let KalmanOdometry = require('./KalmanOdometry.js');
let LiveTracks = require('./LiveTracks.js');
let ProcLog = require('./ProcLog.js');
let PathPlan = require('./PathPlan.js');
let CarParams = require('./CarParams.js');
let GPSPlannerPlan = require('./GPSPlannerPlan.js');
let LiveParametersData = require('./LiveParametersData.js');
let ModelData = require('./ModelData.js');
let LiveLongitudinalMpcData = require('./LiveLongitudinalMpcData.js');
let OrbObservation = require('./OrbObservation.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Event {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lidarPts = null;
      this.gpsNMEA = null;
      this.androidLogEntry = null;
      this.features = null;
      this.liveMapData = null;
      this.orbFeatures = null;
      this.frame = null;
      this.sendcan = null;
      this.qcomGnss = null;
      this.frontFrame = null;
      this.liveUIDEPRECATED = null;
      this.carEvents = null;
      this.radarState = null;
      this.thermal = null;
      this.clocks = null;
      this.uiLayoutState = null;
      this.orbslamCorrectionDEPRECATED = null;
      this.cameraOdometry = null;
      this.gpsPlannerPoints = null;
      this.sensorEvents = null;
      this.controlsState = null;
      this.androidGnss = null;
      this.applanixRaw = null;
      this.ethernetData = null;
      this.ubloxRaw = null;
      this.liveLocationCorrected = null;
      this.boot = null;
      this.trafficEvents = null;
      this.valid = null;
      this.health = null;
      this.liveCalibration = null;
      this.logMonoTime = null;
      this.wifiScan = null;
      this.carState = null;
      this.thumbnail = null;
      this.navUpdate = null;
      this.orbKeyFrame = null;
      this.uiNavigationEvent = null;
      this.carControl = null;
      this.encodeIdx = null;
      this.driverMonitoring = null;
      this.initData = null;
      this.orbOdometry = null;
      this.testJoystick = null;
      this.liveMpc = null;
      this.sensorEventDEPRECATED = null;
      this.plan = null;
      this.liveLocation = null;
      this.cellInfo = null;
      this.logMessage = null;
      this.navStatus = null;
      this.gpsLocation = null;
      this.liveEventDEPRECATED = null;
      this.orbFeaturesSummary = null;
      this.liveLocationTiming = null;
      this.ubloxGnss = null;
      this.kalmanOdometry = null;
      this.liveTracks = null;
      this.procLog = null;
      this.pathPlan = null;
      this.carParams = null;
      this.location = null;
      this.applanixLocation = null;
      this.gpsLocationExternal = null;
      this.can = null;
      this.gpsPlannerPlan = null;
      this.liveParameters = null;
      this.model = null;
      this.liveLongitudinalMpc = null;
      this.liveLocationKalman = null;
      this.orbObservation = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lidarPts')) {
        this.lidarPts = initObj.lidarPts
      }
      else {
        this.lidarPts = new LidarPts();
      }
      if (initObj.hasOwnProperty('gpsNMEA')) {
        this.gpsNMEA = initObj.gpsNMEA
      }
      else {
        this.gpsNMEA = new GPSNMEAData();
      }
      if (initObj.hasOwnProperty('androidLogEntry')) {
        this.androidLogEntry = initObj.androidLogEntry
      }
      else {
        this.androidLogEntry = new AndroidLogEntry();
      }
      if (initObj.hasOwnProperty('features')) {
        this.features = initObj.features
      }
      else {
        this.features = new CalibrationFeatures();
      }
      if (initObj.hasOwnProperty('liveMapData')) {
        this.liveMapData = initObj.liveMapData
      }
      else {
        this.liveMapData = new LiveMapData();
      }
      if (initObj.hasOwnProperty('orbFeatures')) {
        this.orbFeatures = initObj.orbFeatures
      }
      else {
        this.orbFeatures = new OrbFeatures();
      }
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = new FrameData();
      }
      if (initObj.hasOwnProperty('sendcan')) {
        this.sendcan = initObj.sendcan
      }
      else {
        this.sendcan = [];
      }
      if (initObj.hasOwnProperty('qcomGnss')) {
        this.qcomGnss = initObj.qcomGnss
      }
      else {
        this.qcomGnss = new QcomGnss();
      }
      if (initObj.hasOwnProperty('frontFrame')) {
        this.frontFrame = initObj.frontFrame
      }
      else {
        this.frontFrame = new FrameData();
      }
      if (initObj.hasOwnProperty('liveUIDEPRECATED')) {
        this.liveUIDEPRECATED = initObj.liveUIDEPRECATED
      }
      else {
        this.liveUIDEPRECATED = new LiveUI();
      }
      if (initObj.hasOwnProperty('carEvents')) {
        this.carEvents = initObj.carEvents
      }
      else {
        this.carEvents = [];
      }
      if (initObj.hasOwnProperty('radarState')) {
        this.radarState = initObj.radarState
      }
      else {
        this.radarState = new RadarState();
      }
      if (initObj.hasOwnProperty('thermal')) {
        this.thermal = initObj.thermal
      }
      else {
        this.thermal = new ThermalData();
      }
      if (initObj.hasOwnProperty('clocks')) {
        this.clocks = initObj.clocks
      }
      else {
        this.clocks = new Clocks();
      }
      if (initObj.hasOwnProperty('uiLayoutState')) {
        this.uiLayoutState = initObj.uiLayoutState
      }
      else {
        this.uiLayoutState = new UiLayoutState();
      }
      if (initObj.hasOwnProperty('orbslamCorrectionDEPRECATED')) {
        this.orbslamCorrectionDEPRECATED = initObj.orbslamCorrectionDEPRECATED
      }
      else {
        this.orbslamCorrectionDEPRECATED = new OrbslamCorrection();
      }
      if (initObj.hasOwnProperty('cameraOdometry')) {
        this.cameraOdometry = initObj.cameraOdometry
      }
      else {
        this.cameraOdometry = new CameraOdometry();
      }
      if (initObj.hasOwnProperty('gpsPlannerPoints')) {
        this.gpsPlannerPoints = initObj.gpsPlannerPoints
      }
      else {
        this.gpsPlannerPoints = new GPSPlannerPoints();
      }
      if (initObj.hasOwnProperty('sensorEvents')) {
        this.sensorEvents = initObj.sensorEvents
      }
      else {
        this.sensorEvents = [];
      }
      if (initObj.hasOwnProperty('controlsState')) {
        this.controlsState = initObj.controlsState
      }
      else {
        this.controlsState = new ControlsState();
      }
      if (initObj.hasOwnProperty('androidGnss')) {
        this.androidGnss = initObj.androidGnss
      }
      else {
        this.androidGnss = new AndroidGnss();
      }
      if (initObj.hasOwnProperty('applanixRaw')) {
        this.applanixRaw = initObj.applanixRaw
      }
      else {
        this.applanixRaw = [];
      }
      if (initObj.hasOwnProperty('ethernetData')) {
        this.ethernetData = initObj.ethernetData
      }
      else {
        this.ethernetData = [];
      }
      if (initObj.hasOwnProperty('ubloxRaw')) {
        this.ubloxRaw = initObj.ubloxRaw
      }
      else {
        this.ubloxRaw = [];
      }
      if (initObj.hasOwnProperty('liveLocationCorrected')) {
        this.liveLocationCorrected = initObj.liveLocationCorrected
      }
      else {
        this.liveLocationCorrected = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('boot')) {
        this.boot = initObj.boot
      }
      else {
        this.boot = new Boot();
      }
      if (initObj.hasOwnProperty('trafficEvents')) {
        this.trafficEvents = initObj.trafficEvents
      }
      else {
        this.trafficEvents = [];
      }
      if (initObj.hasOwnProperty('valid')) {
        this.valid = initObj.valid
      }
      else {
        this.valid = false;
      }
      if (initObj.hasOwnProperty('health')) {
        this.health = initObj.health
      }
      else {
        this.health = new HealthData();
      }
      if (initObj.hasOwnProperty('liveCalibration')) {
        this.liveCalibration = initObj.liveCalibration
      }
      else {
        this.liveCalibration = new LiveCalibrationData();
      }
      if (initObj.hasOwnProperty('logMonoTime')) {
        this.logMonoTime = initObj.logMonoTime
      }
      else {
        this.logMonoTime = 0;
      }
      if (initObj.hasOwnProperty('wifiScan')) {
        this.wifiScan = initObj.wifiScan
      }
      else {
        this.wifiScan = [];
      }
      if (initObj.hasOwnProperty('carState')) {
        this.carState = initObj.carState
      }
      else {
        this.carState = new CarState();
      }
      if (initObj.hasOwnProperty('thumbnail')) {
        this.thumbnail = initObj.thumbnail
      }
      else {
        this.thumbnail = new Thumbnail();
      }
      if (initObj.hasOwnProperty('navUpdate')) {
        this.navUpdate = initObj.navUpdate
      }
      else {
        this.navUpdate = new NavUpdate();
      }
      if (initObj.hasOwnProperty('orbKeyFrame')) {
        this.orbKeyFrame = initObj.orbKeyFrame
      }
      else {
        this.orbKeyFrame = new OrbKeyFrame();
      }
      if (initObj.hasOwnProperty('uiNavigationEvent')) {
        this.uiNavigationEvent = initObj.uiNavigationEvent
      }
      else {
        this.uiNavigationEvent = new UiNavigationEvent();
      }
      if (initObj.hasOwnProperty('carControl')) {
        this.carControl = initObj.carControl
      }
      else {
        this.carControl = new CarControl();
      }
      if (initObj.hasOwnProperty('encodeIdx')) {
        this.encodeIdx = initObj.encodeIdx
      }
      else {
        this.encodeIdx = new EncodeIndex();
      }
      if (initObj.hasOwnProperty('driverMonitoring')) {
        this.driverMonitoring = initObj.driverMonitoring
      }
      else {
        this.driverMonitoring = new DriverMonitoring();
      }
      if (initObj.hasOwnProperty('initData')) {
        this.initData = initObj.initData
      }
      else {
        this.initData = new InitData();
      }
      if (initObj.hasOwnProperty('orbOdometry')) {
        this.orbOdometry = initObj.orbOdometry
      }
      else {
        this.orbOdometry = new OrbOdometry();
      }
      if (initObj.hasOwnProperty('testJoystick')) {
        this.testJoystick = initObj.testJoystick
      }
      else {
        this.testJoystick = new Joystick();
      }
      if (initObj.hasOwnProperty('liveMpc')) {
        this.liveMpc = initObj.liveMpc
      }
      else {
        this.liveMpc = new LiveMpcData();
      }
      if (initObj.hasOwnProperty('sensorEventDEPRECATED')) {
        this.sensorEventDEPRECATED = initObj.sensorEventDEPRECATED
      }
      else {
        this.sensorEventDEPRECATED = new SensorEventData();
      }
      if (initObj.hasOwnProperty('plan')) {
        this.plan = initObj.plan
      }
      else {
        this.plan = new Plan();
      }
      if (initObj.hasOwnProperty('liveLocation')) {
        this.liveLocation = initObj.liveLocation
      }
      else {
        this.liveLocation = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('cellInfo')) {
        this.cellInfo = initObj.cellInfo
      }
      else {
        this.cellInfo = [];
      }
      if (initObj.hasOwnProperty('logMessage')) {
        this.logMessage = initObj.logMessage
      }
      else {
        this.logMessage = [];
      }
      if (initObj.hasOwnProperty('navStatus')) {
        this.navStatus = initObj.navStatus
      }
      else {
        this.navStatus = new NavStatus();
      }
      if (initObj.hasOwnProperty('gpsLocation')) {
        this.gpsLocation = initObj.gpsLocation
      }
      else {
        this.gpsLocation = new GpsLocationData();
      }
      if (initObj.hasOwnProperty('liveEventDEPRECATED')) {
        this.liveEventDEPRECATED = initObj.liveEventDEPRECATED
      }
      else {
        this.liveEventDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('orbFeaturesSummary')) {
        this.orbFeaturesSummary = initObj.orbFeaturesSummary
      }
      else {
        this.orbFeaturesSummary = new OrbFeaturesSummary();
      }
      if (initObj.hasOwnProperty('liveLocationTiming')) {
        this.liveLocationTiming = initObj.liveLocationTiming
      }
      else {
        this.liveLocationTiming = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('ubloxGnss')) {
        this.ubloxGnss = initObj.ubloxGnss
      }
      else {
        this.ubloxGnss = new UbloxGnss();
      }
      if (initObj.hasOwnProperty('kalmanOdometry')) {
        this.kalmanOdometry = initObj.kalmanOdometry
      }
      else {
        this.kalmanOdometry = new KalmanOdometry();
      }
      if (initObj.hasOwnProperty('liveTracks')) {
        this.liveTracks = initObj.liveTracks
      }
      else {
        this.liveTracks = [];
      }
      if (initObj.hasOwnProperty('procLog')) {
        this.procLog = initObj.procLog
      }
      else {
        this.procLog = new ProcLog();
      }
      if (initObj.hasOwnProperty('pathPlan')) {
        this.pathPlan = initObj.pathPlan
      }
      else {
        this.pathPlan = new PathPlan();
      }
      if (initObj.hasOwnProperty('carParams')) {
        this.carParams = initObj.carParams
      }
      else {
        this.carParams = new CarParams();
      }
      if (initObj.hasOwnProperty('location')) {
        this.location = initObj.location
      }
      else {
        this.location = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('applanixLocation')) {
        this.applanixLocation = initObj.applanixLocation
      }
      else {
        this.applanixLocation = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('gpsLocationExternal')) {
        this.gpsLocationExternal = initObj.gpsLocationExternal
      }
      else {
        this.gpsLocationExternal = new GpsLocationData();
      }
      if (initObj.hasOwnProperty('can')) {
        this.can = initObj.can
      }
      else {
        this.can = [];
      }
      if (initObj.hasOwnProperty('gpsPlannerPlan')) {
        this.gpsPlannerPlan = initObj.gpsPlannerPlan
      }
      else {
        this.gpsPlannerPlan = new GPSPlannerPlan();
      }
      if (initObj.hasOwnProperty('liveParameters')) {
        this.liveParameters = initObj.liveParameters
      }
      else {
        this.liveParameters = new LiveParametersData();
      }
      if (initObj.hasOwnProperty('model')) {
        this.model = initObj.model
      }
      else {
        this.model = new ModelData();
      }
      if (initObj.hasOwnProperty('liveLongitudinalMpc')) {
        this.liveLongitudinalMpc = initObj.liveLongitudinalMpc
      }
      else {
        this.liveLongitudinalMpc = new LiveLongitudinalMpcData();
      }
      if (initObj.hasOwnProperty('liveLocationKalman')) {
        this.liveLocationKalman = initObj.liveLocationKalman
      }
      else {
        this.liveLocationKalman = new LiveLocationData();
      }
      if (initObj.hasOwnProperty('orbObservation')) {
        this.orbObservation = initObj.orbObservation
      }
      else {
        this.orbObservation = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Event
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lidarPts]
    bufferOffset = LidarPts.serialize(obj.lidarPts, buffer, bufferOffset);
    // Serialize message field [gpsNMEA]
    bufferOffset = GPSNMEAData.serialize(obj.gpsNMEA, buffer, bufferOffset);
    // Serialize message field [androidLogEntry]
    bufferOffset = AndroidLogEntry.serialize(obj.androidLogEntry, buffer, bufferOffset);
    // Serialize message field [features]
    bufferOffset = CalibrationFeatures.serialize(obj.features, buffer, bufferOffset);
    // Serialize message field [liveMapData]
    bufferOffset = LiveMapData.serialize(obj.liveMapData, buffer, bufferOffset);
    // Serialize message field [orbFeatures]
    bufferOffset = OrbFeatures.serialize(obj.orbFeatures, buffer, bufferOffset);
    // Serialize message field [frame]
    bufferOffset = FrameData.serialize(obj.frame, buffer, bufferOffset);
    // Serialize message field [sendcan]
    // Serialize the length for message field [sendcan]
    bufferOffset = _serializer.uint32(obj.sendcan.length, buffer, bufferOffset);
    obj.sendcan.forEach((val) => {
      bufferOffset = CanData.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [qcomGnss]
    bufferOffset = QcomGnss.serialize(obj.qcomGnss, buffer, bufferOffset);
    // Serialize message field [frontFrame]
    bufferOffset = FrameData.serialize(obj.frontFrame, buffer, bufferOffset);
    // Serialize message field [liveUIDEPRECATED]
    bufferOffset = LiveUI.serialize(obj.liveUIDEPRECATED, buffer, bufferOffset);
    // Serialize message field [carEvents]
    // Serialize the length for message field [carEvents]
    bufferOffset = _serializer.uint32(obj.carEvents.length, buffer, bufferOffset);
    obj.carEvents.forEach((val) => {
      bufferOffset = CarEvent.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [radarState]
    bufferOffset = RadarState.serialize(obj.radarState, buffer, bufferOffset);
    // Serialize message field [thermal]
    bufferOffset = ThermalData.serialize(obj.thermal, buffer, bufferOffset);
    // Serialize message field [clocks]
    bufferOffset = Clocks.serialize(obj.clocks, buffer, bufferOffset);
    // Serialize message field [uiLayoutState]
    bufferOffset = UiLayoutState.serialize(obj.uiLayoutState, buffer, bufferOffset);
    // Serialize message field [orbslamCorrectionDEPRECATED]
    bufferOffset = OrbslamCorrection.serialize(obj.orbslamCorrectionDEPRECATED, buffer, bufferOffset);
    // Serialize message field [cameraOdometry]
    bufferOffset = CameraOdometry.serialize(obj.cameraOdometry, buffer, bufferOffset);
    // Serialize message field [gpsPlannerPoints]
    bufferOffset = GPSPlannerPoints.serialize(obj.gpsPlannerPoints, buffer, bufferOffset);
    // Serialize message field [sensorEvents]
    // Serialize the length for message field [sensorEvents]
    bufferOffset = _serializer.uint32(obj.sensorEvents.length, buffer, bufferOffset);
    obj.sensorEvents.forEach((val) => {
      bufferOffset = SensorEventData.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [controlsState]
    bufferOffset = ControlsState.serialize(obj.controlsState, buffer, bufferOffset);
    // Serialize message field [androidGnss]
    bufferOffset = AndroidGnss.serialize(obj.androidGnss, buffer, bufferOffset);
    // Serialize message field [applanixRaw]
    bufferOffset = _arraySerializer.string(obj.applanixRaw, buffer, bufferOffset, null);
    // Serialize message field [ethernetData]
    // Serialize the length for message field [ethernetData]
    bufferOffset = _serializer.uint32(obj.ethernetData.length, buffer, bufferOffset);
    obj.ethernetData.forEach((val) => {
      bufferOffset = EthernetPacket.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [ubloxRaw]
    bufferOffset = _arraySerializer.string(obj.ubloxRaw, buffer, bufferOffset, null);
    // Serialize message field [liveLocationCorrected]
    bufferOffset = LiveLocationData.serialize(obj.liveLocationCorrected, buffer, bufferOffset);
    // Serialize message field [boot]
    bufferOffset = Boot.serialize(obj.boot, buffer, bufferOffset);
    // Serialize message field [trafficEvents]
    // Serialize the length for message field [trafficEvents]
    bufferOffset = _serializer.uint32(obj.trafficEvents.length, buffer, bufferOffset);
    obj.trafficEvents.forEach((val) => {
      bufferOffset = TrafficEvent.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [valid]
    bufferOffset = _serializer.bool(obj.valid, buffer, bufferOffset);
    // Serialize message field [health]
    bufferOffset = HealthData.serialize(obj.health, buffer, bufferOffset);
    // Serialize message field [liveCalibration]
    bufferOffset = LiveCalibrationData.serialize(obj.liveCalibration, buffer, bufferOffset);
    // Serialize message field [logMonoTime]
    bufferOffset = _serializer.int64(obj.logMonoTime, buffer, bufferOffset);
    // Serialize message field [wifiScan]
    // Serialize the length for message field [wifiScan]
    bufferOffset = _serializer.uint32(obj.wifiScan.length, buffer, bufferOffset);
    obj.wifiScan.forEach((val) => {
      bufferOffset = WifiScan.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [carState]
    bufferOffset = CarState.serialize(obj.carState, buffer, bufferOffset);
    // Serialize message field [thumbnail]
    bufferOffset = Thumbnail.serialize(obj.thumbnail, buffer, bufferOffset);
    // Serialize message field [navUpdate]
    bufferOffset = NavUpdate.serialize(obj.navUpdate, buffer, bufferOffset);
    // Serialize message field [orbKeyFrame]
    bufferOffset = OrbKeyFrame.serialize(obj.orbKeyFrame, buffer, bufferOffset);
    // Serialize message field [uiNavigationEvent]
    bufferOffset = UiNavigationEvent.serialize(obj.uiNavigationEvent, buffer, bufferOffset);
    // Serialize message field [carControl]
    bufferOffset = CarControl.serialize(obj.carControl, buffer, bufferOffset);
    // Serialize message field [encodeIdx]
    bufferOffset = EncodeIndex.serialize(obj.encodeIdx, buffer, bufferOffset);
    // Serialize message field [driverMonitoring]
    bufferOffset = DriverMonitoring.serialize(obj.driverMonitoring, buffer, bufferOffset);
    // Serialize message field [initData]
    bufferOffset = InitData.serialize(obj.initData, buffer, bufferOffset);
    // Serialize message field [orbOdometry]
    bufferOffset = OrbOdometry.serialize(obj.orbOdometry, buffer, bufferOffset);
    // Serialize message field [testJoystick]
    bufferOffset = Joystick.serialize(obj.testJoystick, buffer, bufferOffset);
    // Serialize message field [liveMpc]
    bufferOffset = LiveMpcData.serialize(obj.liveMpc, buffer, bufferOffset);
    // Serialize message field [sensorEventDEPRECATED]
    bufferOffset = SensorEventData.serialize(obj.sensorEventDEPRECATED, buffer, bufferOffset);
    // Serialize message field [plan]
    bufferOffset = Plan.serialize(obj.plan, buffer, bufferOffset);
    // Serialize message field [liveLocation]
    bufferOffset = LiveLocationData.serialize(obj.liveLocation, buffer, bufferOffset);
    // Serialize message field [cellInfo]
    // Serialize the length for message field [cellInfo]
    bufferOffset = _serializer.uint32(obj.cellInfo.length, buffer, bufferOffset);
    obj.cellInfo.forEach((val) => {
      bufferOffset = CellInfo.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [logMessage]
    bufferOffset = _arraySerializer.string(obj.logMessage, buffer, bufferOffset, null);
    // Serialize message field [navStatus]
    bufferOffset = NavStatus.serialize(obj.navStatus, buffer, bufferOffset);
    // Serialize message field [gpsLocation]
    bufferOffset = GpsLocationData.serialize(obj.gpsLocation, buffer, bufferOffset);
    // Serialize message field [liveEventDEPRECATED]
    // Serialize the length for message field [liveEventDEPRECATED]
    bufferOffset = _serializer.uint32(obj.liveEventDEPRECATED.length, buffer, bufferOffset);
    obj.liveEventDEPRECATED.forEach((val) => {
      bufferOffset = LiveEventData.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [orbFeaturesSummary]
    bufferOffset = OrbFeaturesSummary.serialize(obj.orbFeaturesSummary, buffer, bufferOffset);
    // Serialize message field [liveLocationTiming]
    bufferOffset = LiveLocationData.serialize(obj.liveLocationTiming, buffer, bufferOffset);
    // Serialize message field [ubloxGnss]
    bufferOffset = UbloxGnss.serialize(obj.ubloxGnss, buffer, bufferOffset);
    // Serialize message field [kalmanOdometry]
    bufferOffset = KalmanOdometry.serialize(obj.kalmanOdometry, buffer, bufferOffset);
    // Serialize message field [liveTracks]
    // Serialize the length for message field [liveTracks]
    bufferOffset = _serializer.uint32(obj.liveTracks.length, buffer, bufferOffset);
    obj.liveTracks.forEach((val) => {
      bufferOffset = LiveTracks.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [procLog]
    bufferOffset = ProcLog.serialize(obj.procLog, buffer, bufferOffset);
    // Serialize message field [pathPlan]
    bufferOffset = PathPlan.serialize(obj.pathPlan, buffer, bufferOffset);
    // Serialize message field [carParams]
    bufferOffset = CarParams.serialize(obj.carParams, buffer, bufferOffset);
    // Serialize message field [location]
    bufferOffset = LiveLocationData.serialize(obj.location, buffer, bufferOffset);
    // Serialize message field [applanixLocation]
    bufferOffset = LiveLocationData.serialize(obj.applanixLocation, buffer, bufferOffset);
    // Serialize message field [gpsLocationExternal]
    bufferOffset = GpsLocationData.serialize(obj.gpsLocationExternal, buffer, bufferOffset);
    // Serialize message field [can]
    // Serialize the length for message field [can]
    bufferOffset = _serializer.uint32(obj.can.length, buffer, bufferOffset);
    obj.can.forEach((val) => {
      bufferOffset = CanData.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [gpsPlannerPlan]
    bufferOffset = GPSPlannerPlan.serialize(obj.gpsPlannerPlan, buffer, bufferOffset);
    // Serialize message field [liveParameters]
    bufferOffset = LiveParametersData.serialize(obj.liveParameters, buffer, bufferOffset);
    // Serialize message field [model]
    bufferOffset = ModelData.serialize(obj.model, buffer, bufferOffset);
    // Serialize message field [liveLongitudinalMpc]
    bufferOffset = LiveLongitudinalMpcData.serialize(obj.liveLongitudinalMpc, buffer, bufferOffset);
    // Serialize message field [liveLocationKalman]
    bufferOffset = LiveLocationData.serialize(obj.liveLocationKalman, buffer, bufferOffset);
    // Serialize message field [orbObservation]
    // Serialize the length for message field [orbObservation]
    bufferOffset = _serializer.uint32(obj.orbObservation.length, buffer, bufferOffset);
    obj.orbObservation.forEach((val) => {
      bufferOffset = OrbObservation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Event
    let len;
    let data = new Event(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lidarPts]
    data.lidarPts = LidarPts.deserialize(buffer, bufferOffset);
    // Deserialize message field [gpsNMEA]
    data.gpsNMEA = GPSNMEAData.deserialize(buffer, bufferOffset);
    // Deserialize message field [androidLogEntry]
    data.androidLogEntry = AndroidLogEntry.deserialize(buffer, bufferOffset);
    // Deserialize message field [features]
    data.features = CalibrationFeatures.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveMapData]
    data.liveMapData = LiveMapData.deserialize(buffer, bufferOffset);
    // Deserialize message field [orbFeatures]
    data.orbFeatures = OrbFeatures.deserialize(buffer, bufferOffset);
    // Deserialize message field [frame]
    data.frame = FrameData.deserialize(buffer, bufferOffset);
    // Deserialize message field [sendcan]
    // Deserialize array length for message field [sendcan]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.sendcan = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.sendcan[i] = CanData.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [qcomGnss]
    data.qcomGnss = QcomGnss.deserialize(buffer, bufferOffset);
    // Deserialize message field [frontFrame]
    data.frontFrame = FrameData.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveUIDEPRECATED]
    data.liveUIDEPRECATED = LiveUI.deserialize(buffer, bufferOffset);
    // Deserialize message field [carEvents]
    // Deserialize array length for message field [carEvents]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.carEvents = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.carEvents[i] = CarEvent.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [radarState]
    data.radarState = RadarState.deserialize(buffer, bufferOffset);
    // Deserialize message field [thermal]
    data.thermal = ThermalData.deserialize(buffer, bufferOffset);
    // Deserialize message field [clocks]
    data.clocks = Clocks.deserialize(buffer, bufferOffset);
    // Deserialize message field [uiLayoutState]
    data.uiLayoutState = UiLayoutState.deserialize(buffer, bufferOffset);
    // Deserialize message field [orbslamCorrectionDEPRECATED]
    data.orbslamCorrectionDEPRECATED = OrbslamCorrection.deserialize(buffer, bufferOffset);
    // Deserialize message field [cameraOdometry]
    data.cameraOdometry = CameraOdometry.deserialize(buffer, bufferOffset);
    // Deserialize message field [gpsPlannerPoints]
    data.gpsPlannerPoints = GPSPlannerPoints.deserialize(buffer, bufferOffset);
    // Deserialize message field [sensorEvents]
    // Deserialize array length for message field [sensorEvents]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.sensorEvents = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.sensorEvents[i] = SensorEventData.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [controlsState]
    data.controlsState = ControlsState.deserialize(buffer, bufferOffset);
    // Deserialize message field [androidGnss]
    data.androidGnss = AndroidGnss.deserialize(buffer, bufferOffset);
    // Deserialize message field [applanixRaw]
    data.applanixRaw = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [ethernetData]
    // Deserialize array length for message field [ethernetData]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.ethernetData = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.ethernetData[i] = EthernetPacket.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [ubloxRaw]
    data.ubloxRaw = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [liveLocationCorrected]
    data.liveLocationCorrected = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [boot]
    data.boot = Boot.deserialize(buffer, bufferOffset);
    // Deserialize message field [trafficEvents]
    // Deserialize array length for message field [trafficEvents]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.trafficEvents = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.trafficEvents[i] = TrafficEvent.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [valid]
    data.valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [health]
    data.health = HealthData.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveCalibration]
    data.liveCalibration = LiveCalibrationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [logMonoTime]
    data.logMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [wifiScan]
    // Deserialize array length for message field [wifiScan]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.wifiScan = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.wifiScan[i] = WifiScan.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [carState]
    data.carState = CarState.deserialize(buffer, bufferOffset);
    // Deserialize message field [thumbnail]
    data.thumbnail = Thumbnail.deserialize(buffer, bufferOffset);
    // Deserialize message field [navUpdate]
    data.navUpdate = NavUpdate.deserialize(buffer, bufferOffset);
    // Deserialize message field [orbKeyFrame]
    data.orbKeyFrame = OrbKeyFrame.deserialize(buffer, bufferOffset);
    // Deserialize message field [uiNavigationEvent]
    data.uiNavigationEvent = UiNavigationEvent.deserialize(buffer, bufferOffset);
    // Deserialize message field [carControl]
    data.carControl = CarControl.deserialize(buffer, bufferOffset);
    // Deserialize message field [encodeIdx]
    data.encodeIdx = EncodeIndex.deserialize(buffer, bufferOffset);
    // Deserialize message field [driverMonitoring]
    data.driverMonitoring = DriverMonitoring.deserialize(buffer, bufferOffset);
    // Deserialize message field [initData]
    data.initData = InitData.deserialize(buffer, bufferOffset);
    // Deserialize message field [orbOdometry]
    data.orbOdometry = OrbOdometry.deserialize(buffer, bufferOffset);
    // Deserialize message field [testJoystick]
    data.testJoystick = Joystick.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveMpc]
    data.liveMpc = LiveMpcData.deserialize(buffer, bufferOffset);
    // Deserialize message field [sensorEventDEPRECATED]
    data.sensorEventDEPRECATED = SensorEventData.deserialize(buffer, bufferOffset);
    // Deserialize message field [plan]
    data.plan = Plan.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveLocation]
    data.liveLocation = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [cellInfo]
    // Deserialize array length for message field [cellInfo]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.cellInfo = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.cellInfo[i] = CellInfo.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [logMessage]
    data.logMessage = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [navStatus]
    data.navStatus = NavStatus.deserialize(buffer, bufferOffset);
    // Deserialize message field [gpsLocation]
    data.gpsLocation = GpsLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveEventDEPRECATED]
    // Deserialize array length for message field [liveEventDEPRECATED]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.liveEventDEPRECATED = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.liveEventDEPRECATED[i] = LiveEventData.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [orbFeaturesSummary]
    data.orbFeaturesSummary = OrbFeaturesSummary.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveLocationTiming]
    data.liveLocationTiming = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [ubloxGnss]
    data.ubloxGnss = UbloxGnss.deserialize(buffer, bufferOffset);
    // Deserialize message field [kalmanOdometry]
    data.kalmanOdometry = KalmanOdometry.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveTracks]
    // Deserialize array length for message field [liveTracks]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.liveTracks = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.liveTracks[i] = LiveTracks.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [procLog]
    data.procLog = ProcLog.deserialize(buffer, bufferOffset);
    // Deserialize message field [pathPlan]
    data.pathPlan = PathPlan.deserialize(buffer, bufferOffset);
    // Deserialize message field [carParams]
    data.carParams = CarParams.deserialize(buffer, bufferOffset);
    // Deserialize message field [location]
    data.location = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [applanixLocation]
    data.applanixLocation = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [gpsLocationExternal]
    data.gpsLocationExternal = GpsLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [can]
    // Deserialize array length for message field [can]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.can = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.can[i] = CanData.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [gpsPlannerPlan]
    data.gpsPlannerPlan = GPSPlannerPlan.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveParameters]
    data.liveParameters = LiveParametersData.deserialize(buffer, bufferOffset);
    // Deserialize message field [model]
    data.model = ModelData.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveLongitudinalMpc]
    data.liveLongitudinalMpc = LiveLongitudinalMpcData.deserialize(buffer, bufferOffset);
    // Deserialize message field [liveLocationKalman]
    data.liveLocationKalman = LiveLocationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [orbObservation]
    // Deserialize array length for message field [orbObservation]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.orbObservation = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.orbObservation[i] = OrbObservation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += LidarPts.getMessageSize(object.lidarPts);
    length += GPSNMEAData.getMessageSize(object.gpsNMEA);
    length += AndroidLogEntry.getMessageSize(object.androidLogEntry);
    length += CalibrationFeatures.getMessageSize(object.features);
    length += LiveMapData.getMessageSize(object.liveMapData);
    length += OrbFeatures.getMessageSize(object.orbFeatures);
    length += FrameData.getMessageSize(object.frame);
    object.sendcan.forEach((val) => {
      length += CanData.getMessageSize(val);
    });
    length += QcomGnss.getMessageSize(object.qcomGnss);
    length += FrameData.getMessageSize(object.frontFrame);
    length += LiveUI.getMessageSize(object.liveUIDEPRECATED);
    object.carEvents.forEach((val) => {
      length += CarEvent.getMessageSize(val);
    });
    length += RadarState.getMessageSize(object.radarState);
    length += ThermalData.getMessageSize(object.thermal);
    length += Clocks.getMessageSize(object.clocks);
    length += UiLayoutState.getMessageSize(object.uiLayoutState);
    length += OrbslamCorrection.getMessageSize(object.orbslamCorrectionDEPRECATED);
    length += CameraOdometry.getMessageSize(object.cameraOdometry);
    length += GPSPlannerPoints.getMessageSize(object.gpsPlannerPoints);
    object.sensorEvents.forEach((val) => {
      length += SensorEventData.getMessageSize(val);
    });
    length += ControlsState.getMessageSize(object.controlsState);
    length += AndroidGnss.getMessageSize(object.androidGnss);
    object.applanixRaw.forEach((val) => {
      length += 4 + val.length;
    });
    object.ethernetData.forEach((val) => {
      length += EthernetPacket.getMessageSize(val);
    });
    object.ubloxRaw.forEach((val) => {
      length += 4 + val.length;
    });
    length += LiveLocationData.getMessageSize(object.liveLocationCorrected);
    length += Boot.getMessageSize(object.boot);
    object.trafficEvents.forEach((val) => {
      length += TrafficEvent.getMessageSize(val);
    });
    length += HealthData.getMessageSize(object.health);
    length += LiveCalibrationData.getMessageSize(object.liveCalibration);
    object.wifiScan.forEach((val) => {
      length += WifiScan.getMessageSize(val);
    });
    length += CarState.getMessageSize(object.carState);
    length += Thumbnail.getMessageSize(object.thumbnail);
    length += NavUpdate.getMessageSize(object.navUpdate);
    length += OrbKeyFrame.getMessageSize(object.orbKeyFrame);
    length += UiNavigationEvent.getMessageSize(object.uiNavigationEvent);
    length += CarControl.getMessageSize(object.carControl);
    length += EncodeIndex.getMessageSize(object.encodeIdx);
    length += DriverMonitoring.getMessageSize(object.driverMonitoring);
    length += InitData.getMessageSize(object.initData);
    length += OrbOdometry.getMessageSize(object.orbOdometry);
    length += Joystick.getMessageSize(object.testJoystick);
    length += LiveMpcData.getMessageSize(object.liveMpc);
    length += SensorEventData.getMessageSize(object.sensorEventDEPRECATED);
    length += Plan.getMessageSize(object.plan);
    length += LiveLocationData.getMessageSize(object.liveLocation);
    object.cellInfo.forEach((val) => {
      length += CellInfo.getMessageSize(val);
    });
    object.logMessage.forEach((val) => {
      length += 4 + val.length;
    });
    length += NavStatus.getMessageSize(object.navStatus);
    length += GpsLocationData.getMessageSize(object.gpsLocation);
    object.liveEventDEPRECATED.forEach((val) => {
      length += LiveEventData.getMessageSize(val);
    });
    length += OrbFeaturesSummary.getMessageSize(object.orbFeaturesSummary);
    length += LiveLocationData.getMessageSize(object.liveLocationTiming);
    length += UbloxGnss.getMessageSize(object.ubloxGnss);
    length += KalmanOdometry.getMessageSize(object.kalmanOdometry);
    object.liveTracks.forEach((val) => {
      length += LiveTracks.getMessageSize(val);
    });
    length += ProcLog.getMessageSize(object.procLog);
    length += PathPlan.getMessageSize(object.pathPlan);
    length += CarParams.getMessageSize(object.carParams);
    length += LiveLocationData.getMessageSize(object.location);
    length += LiveLocationData.getMessageSize(object.applanixLocation);
    length += GpsLocationData.getMessageSize(object.gpsLocationExternal);
    object.can.forEach((val) => {
      length += CanData.getMessageSize(val);
    });
    length += GPSPlannerPlan.getMessageSize(object.gpsPlannerPlan);
    length += LiveParametersData.getMessageSize(object.liveParameters);
    length += ModelData.getMessageSize(object.model);
    length += LiveLongitudinalMpcData.getMessageSize(object.liveLongitudinalMpc);
    length += LiveLocationData.getMessageSize(object.liveLocationKalman);
    object.orbObservation.forEach((val) => {
      length += OrbObservation.getMessageSize(val);
    });
    return length + 65;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Event';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2e5006338b7fd3709f95d9b5d9566d9c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    LidarPts lidarPts
    GPSNMEAData gpsNMEA
    AndroidLogEntry androidLogEntry
    CalibrationFeatures features
    LiveMapData liveMapData
    OrbFeatures orbFeatures
    FrameData frame
    CanData[] sendcan
    QcomGnss qcomGnss
    FrameData frontFrame
    LiveUI liveUIDEPRECATED
    CarEvent[] carEvents
    RadarState radarState
    ThermalData thermal
    Clocks clocks
    UiLayoutState uiLayoutState
    OrbslamCorrection orbslamCorrectionDEPRECATED
    CameraOdometry cameraOdometry
    GPSPlannerPoints gpsPlannerPoints
    SensorEventData[] sensorEvents
    ControlsState controlsState
    AndroidGnss androidGnss
    string[] applanixRaw
    EthernetPacket[] ethernetData
    string[] ubloxRaw
    LiveLocationData liveLocationCorrected
    Boot boot
    TrafficEvent[] trafficEvents
    bool valid
    HealthData health
    LiveCalibrationData liveCalibration
    int64 logMonoTime
    WifiScan[] wifiScan
    CarState carState
    Thumbnail thumbnail
    NavUpdate navUpdate
    OrbKeyFrame orbKeyFrame
    UiNavigationEvent uiNavigationEvent
    CarControl carControl
    EncodeIndex encodeIdx
    DriverMonitoring driverMonitoring
    InitData initData
    OrbOdometry orbOdometry
    Joystick testJoystick
    LiveMpcData liveMpc
    SensorEventData sensorEventDEPRECATED
    Plan plan
    LiveLocationData liveLocation
    CellInfo[] cellInfo
    string[] logMessage
    NavStatus navStatus
    GpsLocationData gpsLocation
    LiveEventData[] liveEventDEPRECATED
    OrbFeaturesSummary orbFeaturesSummary
    LiveLocationData liveLocationTiming
    UbloxGnss ubloxGnss
    KalmanOdometry kalmanOdometry
    LiveTracks[] liveTracks
    ProcLog procLog
    PathPlan pathPlan
    CarParams carParams
    LiveLocationData location
    LiveLocationData applanixLocation
    GpsLocationData gpsLocationExternal
    CanData[] can
    GPSPlannerPlan gpsPlannerPlan
    LiveParametersData liveParameters
    ModelData model
    LiveLongitudinalMpcData liveLongitudinalMpc
    LiveLocationData liveLocationKalman
    OrbObservation[] orbObservation
    
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
    MSG: openpilot_bridge/LidarPts
    Header header
    
    int64[] reflect
    int64[] theta
    int64[] r
    string[] pkt
    int64 idx
    
    ================================================================================
    MSG: openpilot_bridge/GPSNMEAData
    Header header
    
    int32 timestamp
    string[] nmea
    int64 localWallTime
    
    ================================================================================
    MSG: openpilot_bridge/AndroidLogEntry
    Header header
    
    int32 pid
    int64 ts
    int64 priority
    string[] tag
    int32 tid
    string[] message
    int64 id
    
    ================================================================================
    MSG: openpilot_bridge/CalibrationFeatures
    Header header
    
    int32[] status
    float32[] p0
    float32[] p1
    int64 frameId
    
    ================================================================================
    MSG: openpilot_bridge/LiveMapData
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
    
    ================================================================================
    MSG: openpilot_bridge/OrbFeatures
    Header header
    
    int32[] octaves
    int32[] matches
    string[] descriptors
    int64 timestampEof
    int64 timestampLastEof
    float32[] xs
    float32[] ys
    
    ================================================================================
    MSG: openpilot_bridge/FrameData
    Header header
    
    int32 integLines
    int32 frameLength
    int64 timestampSof
    float32 lensTruePos
    int64 timestampEof
    float32[] transform
    int64 frameId
    int64 encodeId
    AndroidCaptureResult androidCaptureResult
    float32 gainFrac
    float32 lensSag
    int32 globalGain
    float32 lensErr
    string[] image
    uint32 frameType # enum const: FrameType
    int32 lensPos
    
    ================================================================================
    MSG: openpilot_bridge/AndroidCaptureResult
    Header header
    
    int32 exposureTime
    int32 displayRotation
    float32[] colorCorrectionGains
    int32 sensitivity
    int64 rollingShutterSkew
    int32[] colorCorrectionTransform
    int32 frameDuration
    
    ================================================================================
    MSG: openpilot_bridge/CanData
    Header header
    
    string[] dat
    int64 src
    int64 busTime
    int64 address
    
    ================================================================================
    MSG: openpilot_bridge/QcomGnss
    Header header
    
    string[] rawLog
    MeasurementReport measurementReport
    int64 logTs
    DrSvPolyReport drSvPoly
    ClockReport clockReport
    DrMeasurementReport drMeasurementReport
    
    ================================================================================
    MSG: openpilot_bridge/MeasurementReport
    Header header
    
    Measurement[] measurements
    int64 gpsWeek
    int64 numMeas
    ReceiverStatus receiverStatus
    int64 leapSeconds
    float32 rcvTow
    
    ================================================================================
    MSG: openpilot_bridge/Measurement
    Header header
    
    int64 gnssId
    float32 carrierPhaseStdev
    float32 pseudorange
    float32 doppler
    int64 sigId
    int64 svId
    float32 carrierCycles
    float32 dopplerStdev
    float32 pseudorangeStdev
    int64 cno
    int64 locktime
    int64 glonassFrequencyIndex
    TrackingStatus trackingStatus
    
    ================================================================================
    MSG: openpilot_bridge/TrackingStatus
    Header header
    
    bool halfCycleSubtracted
    bool carrierPhaseValid
    bool pseudorangeValid
    bool halfCycleValid
    
    ================================================================================
    MSG: openpilot_bridge/ReceiverStatus
    Header header
    
    bool leapSecValid
    bool clkReset
    
    ================================================================================
    MSG: openpilot_bridge/DrSvPolyReport
    Header header
    
    float32[] xyzN
    bool hasSbasIono
    float32 positionUncertainty
    int64 svId
    float32 elevationUncertainty
    bool polyFromXtra
    float32[] other
    float32 ionoDot
    bool hasIono
    int32 frequencyIndex
    float32[] velocityCoeff
    float32 elevation
    float32 ionoDelay
    float32 sbasIonoDelay
    bool hasPosition
    bool hasElevation
    int64 iode
    float32 elevationDot
    float32 t0
    float32[] xyz0
    bool hasTropo
    float32 tropoDelay
    float32 sbasIonoDot
    
    ================================================================================
    MSG: openpilot_bridge/ClockReport
    Header header
    
    float32 galToBdsTimeBiasMillisecondsUncertainty
    bool hasFCount
    int64 bdsClockSource
    float32 clockFrequencyUncertainty
    int64 gpsMilliseconds
    bool hasGpsWeek
    float32 gpsToGlonassTimeBiasMilliseconds
    int64 galWeek
    int64 bdsMilliseconds
    float32 gpsToGalTimeBiasMilliseconds
    float32 glonassTimeBias
    int64 gpsClockSource
    float32 bdsClockTimeUncertainty
    float32 gpsToBdsTimeBiasMillisecondsUncertainty
    int64 glonassYear
    float32 galToGloTimeBiasMilliseconds
    int64 galMilliseconds
    float32 galToGloTimeBiasMillisecondsUncertainty
    float32 clockFrequencyBias
    int64 fCount
    int64 gpsLeapSeconds
    bool hasRtcTime
    int64 bdsWeek
    float32 glonassClockTimeUncertainty
    bool hasGlonassMilliseconds
    int64 systemRtcTime
    float32 bdsTimeBias
    int64 frequencySource
    int64 glonassDay
    bool hasGlonassDay
    float32 gpsToGalTimeBiasMillisecondsUncertainty
    float32 galTimeBias
    float32 galClockTimeUncertainty
    float32 gpsTimeBias
    int64 lpmRtcCount
    int64 glonassMilliseconds
    int64 fCountOffset
    float32 bdsToGloTimeBiasMilliseconds
    int64 clockResets
    int64 gpsLeapSecondsSource
    int64 galClockSource
    bool hasGpsMilliseconds
    float32 gpsToBdsTimeBiasMilliseconds
    int64 gpsWeek
    float32 gpsClockTimeUncertainty
    float32 bdsToGloTimeBiasMillisecondsUncertainty
    bool hasGlonassYear
    float32 gpsToGlonassTimeBiasMillisecondsUncertainty
    int64 glonassClockSource
    float32 galToBdsTimeBiasMilliseconds
    int64 gpsLeapSecondsUncertainty
    
    ================================================================================
    MSG: openpilot_bridge/DrMeasurementReport
    Header header
    
    float32 gpsToGlonassTimeBiasMilliseconds
    int64 gpsMilliseconds
    int64 seqMax
    int64 gpsClockTimeUncertaintyMs
    int64 glonassClockSource
    float32 glonassTimeBias
    int64 gpsClockSource
    float32 clockFrequencyBias
    uint32 source # enum const: MeasurementSource
    int64 rfLoss
    int64 fCount
    int64 gpsTimeBiasMs
    float32 clockFrequencyUncertainty
    int64 systemRtcTime
    int64 seqNum
    int64 frequencySource
    int64 glonassDay
    int64 reason
    int64 glonassMilliseconds
    int64 clockResets
    SV[] sv
    int64 gpsLeapSeconds
    float32 glonassClockTimeUncertainty
    int64 gpsWeek
    bool systemRtcValid
    float32 gpsToGlonassTimeBiasMillisecondsUncertainty
    int64 glonassYear
    int64 gpsLeapSecondsUncertainty
    
    ================================================================================
    MSG: openpilot_bridge/SV
    Header header
    
    float32 unfilteredTimeUncertainty
    int64 cycleSlipCount
    int64 unfilteredMeasurementIntegral
    MeasurementStatus measurementStatus
    float32 filteredSpeedUncertainty
    int64 predetectInterval
    float32 unfilteredMeasurementFraction
    float32 filteredTimeUncertainty
    int64 carrierNoise
    int64 postdetections
    int32 latency
    int64 filterStages
    int64 multipathEstimate
    int64 svId
    float32 filteredMeasurementFraction
    int64 rfLoss
    int64 observations
    int64 fCount
    float32 dopplerAcceleration
    float32 elevation
    float32 filteredSpeed
    float32 fineSpeed
    int64 goodObservations
    uint32 observationState # enum const: SVObservationState
    bool goodParity
    float32 carrierPhase
    int64 filteredMeasurementIntegral
    int64 parityErrorCount
    float32 unfilteredSpeedUncertainty
    float32 fineSpeedUncertainty
    float32 azimuth
    float32 unfilteredSpeed
    int32 glonassFrequencyIndex
    
    ================================================================================
    MSG: openpilot_bridge/MeasurementStatus
    Header header
    
    bool glonassTimeMarkValid
    bool lockPointValid
    bool imdJammingIndicator
    bool measuredVelocity
    bool fineOrCoarseVelocity
    bool gpsHighBandwidthNu4
    bool gpsRxDiversity
    bool gpsHighBandwidthUniform
    bool gpsHighBandwidthNu8
    bool subMillisecondIsValid
    bool lastUpdateFromDifference
    bool tentativeMeasurement
    bool probationMode
    bool directionIsValid
    bool bitEdgeConfirmedFromSignal
    bool gpsRoundRobinRxDiversity
    bool freshMeasurementIndicator
    bool lteB13TxJammingIndicator
    bool lastUpdateFromVelocityDifference
    bool measurementNotUsable
    bool glonassMeanderBitEdgeValid
    bool gpsLowBandwidthRxDiversityCombined
    bool satelliteTimeIsKnown
    bool strongIndicationOfCrossCorelation
    bool subBitTimeIsKnown
    bool lockPointPositive
    bool multipathIndicator
    bool sirCheckIsNeeded
    bool multipathEstimateIsValid
    
    ================================================================================
    MSG: openpilot_bridge/LiveUI
    Header header
    
    bool rearViewCam
    float32 awarenessStatus
    string[] alertText2
    string[] alertText1
    
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
    MSG: openpilot_bridge/RadarState
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
    
    ================================================================================
    MSG: openpilot_bridge/ThermalData
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
    MSG: openpilot_bridge/Clocks
    Header header
    
    int64 modemUptimeMillis
    int64 wallTimeNanos
    int64 bootTimeNanos
    int64 monotonicRawNanos
    int64 monotonicNanos
    
    ================================================================================
    MSG: openpilot_bridge/UiLayoutState
    Header header
    
    uint32 activeApp # enum const: App
    bool mapEnabled
    bool sidebarCollapsed
    
    ================================================================================
    MSG: openpilot_bridge/OrbslamCorrection
    Header header
    
    int64 correctionMonoTime
    float32[] prePositionECEF
    float32[] postPositionECEF
    float32[] postPoseQuatECEF
    int64 numInliers
    float32[] prePoseQuatECEF
    
    ================================================================================
    MSG: openpilot_bridge/CameraOdometry
    Header header
    
    float32[] transStd
    int64 timestampEof
    int64 frameId
    float32[] rotStd
    float32[] trans
    float32[] rot
    
    ================================================================================
    MSG: openpilot_bridge/GPSPlannerPoints
    Header header
    
    float32 accelTarget
    ECEFPointDEPRECATED[] pointsDEPRECATED
    string[] trackName
    ECEFPoint curPos
    bool valid
    float32 speedLimit
    ECEFPointDEPRECATED curPosDEPRECATED
    ECEFPoint[] points
    
    ================================================================================
    MSG: openpilot_bridge/ECEFPointDEPRECATED
    Header header
    
    float32 y
    float32 x
    float32 z
    
    ================================================================================
    MSG: openpilot_bridge/ECEFPoint
    Header header
    
    float32 y
    float32 x
    float32 z
    
    ================================================================================
    MSG: openpilot_bridge/SensorEventData
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
    MSG: openpilot_bridge/SensorVec
    Header header
    
    int32 status
    float32[] v
    
    ================================================================================
    MSG: openpilot_bridge/ControlsState
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
    
    ================================================================================
    MSG: openpilot_bridge/AndroidGnss
    Header header
    
    NavigationMessage navigationMessage
    Measurements measurements
    
    ================================================================================
    MSG: openpilot_bridge/NavigationMessage
    Header header
    
    uint32 status # enum const: Status
    string[] data
    int32 svId
    int32 messageId
    int32 submessageId
    int32 type
    
    ================================================================================
    MSG: openpilot_bridge/Measurements
    Header header
    
    Measurement[] measurements
    Clock clock
    
    ================================================================================
    MSG: openpilot_bridge/Clock
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
    MSG: openpilot_bridge/EthernetPacket
    Header header
    
    float32 ts
    string[] pkt
    
    ================================================================================
    MSG: openpilot_bridge/LiveLocationData
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
    
    ================================================================================
    MSG: openpilot_bridge/Boot
    Header header
    
    int64 wallTimeNanos
    string[] lastKmsg
    string[] lastPmsg
    
    ================================================================================
    MSG: openpilot_bridge/TrafficEvent
    Header header
    
    uint32 action # enum const: Action
    float32 distance
    uint32 type # enum const: Type
    bool resuming
    
    ================================================================================
    MSG: openpilot_bridge/HealthData
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
    MSG: openpilot_bridge/LiveCalibrationData
    Header header
    
    float32[] warpMatrix2
    float32[] warpMatrix
    float32[] rpyCalib
    float32[] warpMatrixBig
    int32 calCycle
    float32[] extrinsicMatrix
    int32 calPerc
    int32 calStatus
    
    ================================================================================
    MSG: openpilot_bridge/WifiScan
    Header header
    
    bool is80211mcResponder
    string[] operatorFriendlyName
    uint32 channelWidth # enum const: ChannelWidth
    int32 distanceSdCm
    string[] ssid
    string[] bssid
    int32 level
    int32 timestamp
    string[] capabilities
    int32 distanceCm
    int32 centerFreq0
    int32 centerFreq1
    int32 frequency
    bool passpoint
    string[] venueName
    
    ================================================================================
    MSG: openpilot_bridge/CarState
    Header header
    
    uint32 gearShifter # enum const: GearShifter
    bool seatbeltUnlatched
    bool clutchPressed
    float32 vEgoRaw
    uint32[] errorsDEPRECATED # enum const: EventName
    float32 brake
    float32 vEgo
    float32 steeringAngle
    bool leftBlinker
    WheelSpeeds wheelSpeeds
    bool steeringRateLimited
    bool stockFcw
    bool doorOpen
    float32 steeringRate
    CarEvent[] events
    bool steeringPressed
    bool canValid
    CruiseState cruiseState
    float32 yawRate
    float32 steeringTorqueEps
    float32 gas
    float32 steeringTorque
    bool genericToggle
    bool brakeLights
    ButtonEvent[] buttonEvents
    bool standstill
    bool gasPressed
    bool stockAeb
    bool rightBlinker
    bool brakePressed
    float32 aEgo
    int64[] canMonoTimes
    
    ================================================================================
    MSG: openpilot_bridge/WheelSpeeds
    Header header
    
    float32 rl
    float32 fr
    float32 fl
    float32 rr
    
    ================================================================================
    MSG: openpilot_bridge/CruiseState
    Header header
    
    bool available
    float32 speed
    float32 speedOffset
    bool enabled
    bool standstill
    
    ================================================================================
    MSG: openpilot_bridge/ButtonEvent
    Header header
    
    uint32 type # enum const: Type
    bool pressed
    
    ================================================================================
    MSG: openpilot_bridge/Thumbnail
    Header header
    
    int64 timestampEof
    string[] thumbnail
    int64 frameId
    
    ================================================================================
    MSG: openpilot_bridge/NavUpdate
    Header header
    
    bool isNavigating
    Segment[] segments
    int32 curSegment
    
    ================================================================================
    MSG: openpilot_bridge/Segment
    Header header
    
    int32 distance
    int32 updateTime
    LatLng from
    uint32 instruction # enum const: Instruction
    LatLng[] parts
    LatLng to
    int32 crossTime
    int32 exitNo
    
    ================================================================================
    MSG: openpilot_bridge/LatLng
    Header header
    
    float32 lat
    float32 lng
    
    ================================================================================
    MSG: openpilot_bridge/OrbKeyFrame
    Header header
    
    string[] descriptors
    int64 id
    ECEFPoint[] dpos
    ECEFPoint pos
    
    ================================================================================
    MSG: openpilot_bridge/UiNavigationEvent
    Header header
    
    uint32 status # enum const: Status
    float32 distanceTo
    uint32 type # enum const: Type
    ECEFPointDEPRECATED endRoadPointDEPRECATED
    ECEFPoint endRoadPoint
    
    ================================================================================
    MSG: openpilot_bridge/CarControl
    Header header
    
    float32 brakeDEPRECATED
    float32 gasDEPRECATED
    float32 steeringTorqueDEPRECATED
    CruiseControl cruiseControl
    Actuators actuators
    bool active
    HUDControl hudControl
    bool enabled
    
    ================================================================================
    MSG: openpilot_bridge/CruiseControl
    Header header
    
    bool cancel
    bool override
    float32 speedOverride
    float32 accelOverride
    
    ================================================================================
    MSG: openpilot_bridge/Actuators
    Header header
    
    float32 brake
    float32 gas
    float32 steerAngle
    float32 steer
    
    ================================================================================
    MSG: openpilot_bridge/HUDControl
    Header header
    
    bool leadVisible
    float32 setSpeed
    bool leftLaneDepart
    bool lanesVisible
    bool leftLaneVisible
    uint32 visualAlert # enum const: VisualAlert
    uint32 audibleAlert # enum const: AudibleAlert
    bool speedVisible
    bool rightLaneVisible
    bool rightLaneDepart
    
    ================================================================================
    MSG: openpilot_bridge/EncodeIndex
    Header header
    
    int64 segmentId
    int64 segmentIdEncode
    int64 frameId
    int64 encodeId
    uint32 type # enum const: Type
    int32 segmentNum
    
    ================================================================================
    MSG: openpilot_bridge/DriverMonitoring
    Header header
    
    float32[] faceOrientation
    float32 stdDEPRECATED
    float32 irPwrDEPRECATED
    float32[] faceOrientationStd
    float32 faceProb
    int64 frameId
    float32[] descriptorDEPRECATED
    float32 rightBlinkProb
    float32 rightEyeProb
    float32[] facePositionStd
    float32 leftBlinkProb
    float32 leftEyeProb
    float32[] facePosition
    
    ================================================================================
    MSG: openpilot_bridge/InitData
    Header header
    
    string[] kernelVersion
    ChffrAndroidExtra chffrAndroidExtra
    Map androidProperties
    AndroidSensor[] androidSensors
    PandaInfo pandaInfo
    IosBuildInfo iosBuildInfo
    string[] gitRemote
    AndroidBuildInfo androidBuildInfo
    bool passive
    Map params
    string[] version
    uint32 deviceType # enum const: DeviceType
    string[] kernelArgs
    string[] gitCommit
    string[] gitBranch
    string[] dongleId
    string[] gctx
    bool dirty
    
    ================================================================================
    MSG: openpilot_bridge/ChffrAndroidExtra
    Header header
    
    Map allCameraCharacteristics
    
    ================================================================================
    MSG: openpilot_bridge/Map
    Header header
    
    Entry[] entries
    
    ================================================================================
    MSG: openpilot_bridge/Entry
    Header header
    
    string value
    string key
    
    ================================================================================
    MSG: openpilot_bridge/AndroidSensor
    Header header
    
    float32 maxRange
    string[] stringType
    int32 maxDelay
    int32 handle
    string[] name
    float32 power
    int32 minDelay
    float32 resolution
    int64 fifoMaxEventCount
    int32 version
    int64 fifoReservedEventCount
    string[] vendor
    int32 type
    int32 id
    
    ================================================================================
    MSG: openpilot_bridge/PandaInfo
    Header header
    
    bool hasPanda
    string[] stVersion
    string[] dongleId
    string[] espVersion
    
    ================================================================================
    MSG: openpilot_bridge/IosBuildInfo
    Header header
    
    int64 appBuild
    string[] appVersion
    string[] osVersion
    string[] deviceModel
    
    ================================================================================
    MSG: openpilot_bridge/AndroidBuildInfo
    Header header
    
    string[] radioVersion
    string[] versionCodename
    string[] hardware
    string[] versionSecurityPatch
    string[] supportedAbis
    string[] id
    string[] board
    string[] type
    string[] product
    string[] tags
    string[] brand
    string[] host
    string[] user
    string[] fingerprint
    string[] device
    string[] bootloader
    string[] model
    string[] serial
    string[] manufacturer
    string[] versionRelease
    int32 time
    int32 versionSdk
    string[] display
    
    ================================================================================
    MSG: openpilot_bridge/OrbOdometry
    Header header
    
    int64 endMonoTime
    float32 err
    float32[] f
    int32[] matches
    int32 inliers
    int64 startMonoTime
    
    ================================================================================
    MSG: openpilot_bridge/Joystick
    Header header
    
    bool[] buttons
    float32[] axes
    
    ================================================================================
    MSG: openpilot_bridge/LiveMpcData
    Header header
    
    float32[] psi
    int64 qpIterations
    float32 cost
    float32[] delta
    float32[] y
    float32[] x
    int64 calculationTime
    
    ================================================================================
    MSG: openpilot_bridge/Plan
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
    MSG: openpilot_bridge/GpsTrajectory
    Header header
    
    float32[] y
    float32[] x
    
    ================================================================================
    MSG: openpilot_bridge/CellInfo
    Header header
    
    int64 timestamp
    string[] repr
    
    ================================================================================
    MSG: openpilot_bridge/NavStatus
    Header header
    
    bool isNavigating
    Address currentAddress
    
    ================================================================================
    MSG: openpilot_bridge/Address
    Header header
    
    string[] city
    string[] title
    string[] house
    string[] state
    string[] street
    string[] address
    float32 lat
    float32 lng
    string[] country
    
    ================================================================================
    MSG: openpilot_bridge/LiveEventData
    Header header
    
    string[] name
    int32 value
    
    ================================================================================
    MSG: openpilot_bridge/OrbFeaturesSummary
    Header header
    
    int64 timestampEof
    int64 featureCount
    int64 matchCount
    int64 timestampLastEof
    int64 computeNs
    
    ================================================================================
    MSG: openpilot_bridge/UbloxGnss
    Header header
    
    IonoData ionoData
    MeasurementReport measurementReport
    Ephemeris ephemeris
    
    ================================================================================
    MSG: openpilot_bridge/IonoData
    Header header
    
    bool healthValid
    float32[] ionoAlpha
    float32 tow
    float32 gpsWeek
    float32[] ionoBeta
    int64 svHealth
    bool ionoCoeffsValid
    
    ================================================================================
    MSG: openpilot_bridge/Ephemeris
    Header header
    
    float32 iodc
    float32 fitInterval
    int64 month
    float32 second
    float32 tgd
    int64 year
    float32 gpsWeek
    float32 cus
    bool ionoCoeffsValid
    int64 svId
    float32 svAcc
    float32 cuc
    float32 m0
    float32 toc
    float32 deltaN
    float32 toe
    float32 cic
    float32[] ionoBeta
    float32 ecc
    float32 iDot
    float32 i0
    float32 svHealth
    float32 codesL2
    float32 omega
    int64 day
    int64 minute
    float32 a
    float32 crs
    float32[] ionoAlpha
    int64 hour
    float32 iode
    float32 af1
    float32 cis
    float32 crc
    float32 l2
    float32 omegaDot
    float32 af0
    float32 omega0
    float32 af2
    float32 transmissionTime
    
    ================================================================================
    MSG: openpilot_bridge/KalmanOdometry
    Header header
    
    float32[] rotStd
    float32[] transStd
    float32[] trans
    float32[] rot
    
    ================================================================================
    MSG: openpilot_bridge/ProcLog
    Header header
    
    CPUTimes[] cpuTimes
    Mem mem
    Process[] procs
    
    ================================================================================
    MSG: openpilot_bridge/CPUTimes
    Header header
    
    float32 softirq
    float32 iowait
    float32 system
    int32 cpuNum
    float32 idle
    float32 user
    float32 irq
    float32 nice
    
    ================================================================================
    MSG: openpilot_bridge/Mem
    Header header
    
    int64 available
    int64 cached
    int64 free
    int64 inactive
    int64 active
    int64 shared
    int64 total
    int64 buffers
    
    ================================================================================
    MSG: openpilot_bridge/Process
    Header header
    
    string[] exe
    string[] name
    string[] cmdline
    float32 cpuUser
    int32 numThreads
    int64 memRss
    int32 pid
    int64 memVms
    int32 priority
    float32 cpuSystem
    int64 state
    float32 startTime
    int32 nice
    float32 cpuChildrenUser
    int32 ppid
    int32 processor
    float32 cpuChildrenSystem
    
    ================================================================================
    MSG: openpilot_bridge/PathPlan
    Header header
    
    float32 angleSteers
    bool commIssue
    float32[] lPoly
    uint32 laneChangeState # enum const: LaneChangeState
    bool sensorValid
    bool mpcSolutionValid
    float32 lProb
    bool modelValidDEPRECATED
    float32 rProb
    float32 cProb
    float32[] rPoly
    float32 laneWidth
    float32 angleOffset
    float32 rateSteers
    uint32 laneChangeDirection # enum const: LaneChangeDirection
    bool paramsValid
    float32[] cPoly
    bool posenetValid
    float32[] dPoly
    uint32 desire # enum const: Desire
    
    ================================================================================
    MSG: openpilot_bridge/CarParams
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
    
    ================================================================================
    MSG: openpilot_bridge/GPSPlannerPlan
    Header header
    
    float32 acceleration
    ECEFPointDEPRECATED[] pointsDEPRECATED
    string[] trackName
    float32[] poly
    float32 xLookahead
    bool valid
    float32 speed
    ECEFPoint[] points
    
    ================================================================================
    MSG: openpilot_bridge/LiveParametersData
    Header header
    
    float32 steerRatio
    bool sensorValid
    float32 stiffnessFactor
    bool posenetValid
    float32 angleOffset
    float32 yawRate
    float32 gyroBias
    bool valid
    float32 posenetSpeed
    float32 angleOffsetAverage
    
    ================================================================================
    MSG: openpilot_bridge/ModelData
    Header header
    
    LongitudinalData longitudinal
    LeadData leadFuture
    LeadData lead
    ModelSettings settings
    PathData leftLane
    int64 timestampEof
    int64 frameId
    PathData rightLane
    MetaData meta
    PathData path
    float32[] speed
    float32[] freePath
    
    ================================================================================
    MSG: openpilot_bridge/LongitudinalData
    Header header
    
    float32[] accelerations
    float32[] speeds
    
    ================================================================================
    MSG: openpilot_bridge/ModelSettings
    Header header
    
    int64 bigBoxX
    int64 bigBoxY
    float32[] inputTransform
    int64 bigBoxHeight
    int64 bigBoxWidth
    float32[] boxProjection
    float32[] yuvCorrection
    
    ================================================================================
    MSG: openpilot_bridge/PathData
    Header header
    
    float32 std
    float32[] poly
    float32[] points
    float32 prob
    float32[] stds
    
    ================================================================================
    MSG: openpilot_bridge/MetaData
    Header header
    
    float32 gasDisengageProb
    float32 brakeDisengageProb
    float32 steerOverrideProb
    float32 engagedProb
    float32[] desirePrediction
    
    ================================================================================
    MSG: openpilot_bridge/LiveLongitudinalMpcData
    Header header
    
    float32 aLeadTau
    float32[] vLead
    float32[] aLead
    float32[] xEgo
    float32[] xLead
    int64 mpcId
    float32 cost
    float32[] aEgo
    int64 calculationTime
    int64 qpIterations
    float32[] vEgo
    
    ================================================================================
    MSG: openpilot_bridge/OrbObservation
    Header header
    
    int64 matchDistance
    float32[] locationECEF
    float32[] normalizedCoordinates
    int64 observationMonoTime
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Event(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lidarPts !== undefined) {
      resolved.lidarPts = LidarPts.Resolve(msg.lidarPts)
    }
    else {
      resolved.lidarPts = new LidarPts()
    }

    if (msg.gpsNMEA !== undefined) {
      resolved.gpsNMEA = GPSNMEAData.Resolve(msg.gpsNMEA)
    }
    else {
      resolved.gpsNMEA = new GPSNMEAData()
    }

    if (msg.androidLogEntry !== undefined) {
      resolved.androidLogEntry = AndroidLogEntry.Resolve(msg.androidLogEntry)
    }
    else {
      resolved.androidLogEntry = new AndroidLogEntry()
    }

    if (msg.features !== undefined) {
      resolved.features = CalibrationFeatures.Resolve(msg.features)
    }
    else {
      resolved.features = new CalibrationFeatures()
    }

    if (msg.liveMapData !== undefined) {
      resolved.liveMapData = LiveMapData.Resolve(msg.liveMapData)
    }
    else {
      resolved.liveMapData = new LiveMapData()
    }

    if (msg.orbFeatures !== undefined) {
      resolved.orbFeatures = OrbFeatures.Resolve(msg.orbFeatures)
    }
    else {
      resolved.orbFeatures = new OrbFeatures()
    }

    if (msg.frame !== undefined) {
      resolved.frame = FrameData.Resolve(msg.frame)
    }
    else {
      resolved.frame = new FrameData()
    }

    if (msg.sendcan !== undefined) {
      resolved.sendcan = new Array(msg.sendcan.length);
      for (let i = 0; i < resolved.sendcan.length; ++i) {
        resolved.sendcan[i] = CanData.Resolve(msg.sendcan[i]);
      }
    }
    else {
      resolved.sendcan = []
    }

    if (msg.qcomGnss !== undefined) {
      resolved.qcomGnss = QcomGnss.Resolve(msg.qcomGnss)
    }
    else {
      resolved.qcomGnss = new QcomGnss()
    }

    if (msg.frontFrame !== undefined) {
      resolved.frontFrame = FrameData.Resolve(msg.frontFrame)
    }
    else {
      resolved.frontFrame = new FrameData()
    }

    if (msg.liveUIDEPRECATED !== undefined) {
      resolved.liveUIDEPRECATED = LiveUI.Resolve(msg.liveUIDEPRECATED)
    }
    else {
      resolved.liveUIDEPRECATED = new LiveUI()
    }

    if (msg.carEvents !== undefined) {
      resolved.carEvents = new Array(msg.carEvents.length);
      for (let i = 0; i < resolved.carEvents.length; ++i) {
        resolved.carEvents[i] = CarEvent.Resolve(msg.carEvents[i]);
      }
    }
    else {
      resolved.carEvents = []
    }

    if (msg.radarState !== undefined) {
      resolved.radarState = RadarState.Resolve(msg.radarState)
    }
    else {
      resolved.radarState = new RadarState()
    }

    if (msg.thermal !== undefined) {
      resolved.thermal = ThermalData.Resolve(msg.thermal)
    }
    else {
      resolved.thermal = new ThermalData()
    }

    if (msg.clocks !== undefined) {
      resolved.clocks = Clocks.Resolve(msg.clocks)
    }
    else {
      resolved.clocks = new Clocks()
    }

    if (msg.uiLayoutState !== undefined) {
      resolved.uiLayoutState = UiLayoutState.Resolve(msg.uiLayoutState)
    }
    else {
      resolved.uiLayoutState = new UiLayoutState()
    }

    if (msg.orbslamCorrectionDEPRECATED !== undefined) {
      resolved.orbslamCorrectionDEPRECATED = OrbslamCorrection.Resolve(msg.orbslamCorrectionDEPRECATED)
    }
    else {
      resolved.orbslamCorrectionDEPRECATED = new OrbslamCorrection()
    }

    if (msg.cameraOdometry !== undefined) {
      resolved.cameraOdometry = CameraOdometry.Resolve(msg.cameraOdometry)
    }
    else {
      resolved.cameraOdometry = new CameraOdometry()
    }

    if (msg.gpsPlannerPoints !== undefined) {
      resolved.gpsPlannerPoints = GPSPlannerPoints.Resolve(msg.gpsPlannerPoints)
    }
    else {
      resolved.gpsPlannerPoints = new GPSPlannerPoints()
    }

    if (msg.sensorEvents !== undefined) {
      resolved.sensorEvents = new Array(msg.sensorEvents.length);
      for (let i = 0; i < resolved.sensorEvents.length; ++i) {
        resolved.sensorEvents[i] = SensorEventData.Resolve(msg.sensorEvents[i]);
      }
    }
    else {
      resolved.sensorEvents = []
    }

    if (msg.controlsState !== undefined) {
      resolved.controlsState = ControlsState.Resolve(msg.controlsState)
    }
    else {
      resolved.controlsState = new ControlsState()
    }

    if (msg.androidGnss !== undefined) {
      resolved.androidGnss = AndroidGnss.Resolve(msg.androidGnss)
    }
    else {
      resolved.androidGnss = new AndroidGnss()
    }

    if (msg.applanixRaw !== undefined) {
      resolved.applanixRaw = msg.applanixRaw;
    }
    else {
      resolved.applanixRaw = []
    }

    if (msg.ethernetData !== undefined) {
      resolved.ethernetData = new Array(msg.ethernetData.length);
      for (let i = 0; i < resolved.ethernetData.length; ++i) {
        resolved.ethernetData[i] = EthernetPacket.Resolve(msg.ethernetData[i]);
      }
    }
    else {
      resolved.ethernetData = []
    }

    if (msg.ubloxRaw !== undefined) {
      resolved.ubloxRaw = msg.ubloxRaw;
    }
    else {
      resolved.ubloxRaw = []
    }

    if (msg.liveLocationCorrected !== undefined) {
      resolved.liveLocationCorrected = LiveLocationData.Resolve(msg.liveLocationCorrected)
    }
    else {
      resolved.liveLocationCorrected = new LiveLocationData()
    }

    if (msg.boot !== undefined) {
      resolved.boot = Boot.Resolve(msg.boot)
    }
    else {
      resolved.boot = new Boot()
    }

    if (msg.trafficEvents !== undefined) {
      resolved.trafficEvents = new Array(msg.trafficEvents.length);
      for (let i = 0; i < resolved.trafficEvents.length; ++i) {
        resolved.trafficEvents[i] = TrafficEvent.Resolve(msg.trafficEvents[i]);
      }
    }
    else {
      resolved.trafficEvents = []
    }

    if (msg.valid !== undefined) {
      resolved.valid = msg.valid;
    }
    else {
      resolved.valid = false
    }

    if (msg.health !== undefined) {
      resolved.health = HealthData.Resolve(msg.health)
    }
    else {
      resolved.health = new HealthData()
    }

    if (msg.liveCalibration !== undefined) {
      resolved.liveCalibration = LiveCalibrationData.Resolve(msg.liveCalibration)
    }
    else {
      resolved.liveCalibration = new LiveCalibrationData()
    }

    if (msg.logMonoTime !== undefined) {
      resolved.logMonoTime = msg.logMonoTime;
    }
    else {
      resolved.logMonoTime = 0
    }

    if (msg.wifiScan !== undefined) {
      resolved.wifiScan = new Array(msg.wifiScan.length);
      for (let i = 0; i < resolved.wifiScan.length; ++i) {
        resolved.wifiScan[i] = WifiScan.Resolve(msg.wifiScan[i]);
      }
    }
    else {
      resolved.wifiScan = []
    }

    if (msg.carState !== undefined) {
      resolved.carState = CarState.Resolve(msg.carState)
    }
    else {
      resolved.carState = new CarState()
    }

    if (msg.thumbnail !== undefined) {
      resolved.thumbnail = Thumbnail.Resolve(msg.thumbnail)
    }
    else {
      resolved.thumbnail = new Thumbnail()
    }

    if (msg.navUpdate !== undefined) {
      resolved.navUpdate = NavUpdate.Resolve(msg.navUpdate)
    }
    else {
      resolved.navUpdate = new NavUpdate()
    }

    if (msg.orbKeyFrame !== undefined) {
      resolved.orbKeyFrame = OrbKeyFrame.Resolve(msg.orbKeyFrame)
    }
    else {
      resolved.orbKeyFrame = new OrbKeyFrame()
    }

    if (msg.uiNavigationEvent !== undefined) {
      resolved.uiNavigationEvent = UiNavigationEvent.Resolve(msg.uiNavigationEvent)
    }
    else {
      resolved.uiNavigationEvent = new UiNavigationEvent()
    }

    if (msg.carControl !== undefined) {
      resolved.carControl = CarControl.Resolve(msg.carControl)
    }
    else {
      resolved.carControl = new CarControl()
    }

    if (msg.encodeIdx !== undefined) {
      resolved.encodeIdx = EncodeIndex.Resolve(msg.encodeIdx)
    }
    else {
      resolved.encodeIdx = new EncodeIndex()
    }

    if (msg.driverMonitoring !== undefined) {
      resolved.driverMonitoring = DriverMonitoring.Resolve(msg.driverMonitoring)
    }
    else {
      resolved.driverMonitoring = new DriverMonitoring()
    }

    if (msg.initData !== undefined) {
      resolved.initData = InitData.Resolve(msg.initData)
    }
    else {
      resolved.initData = new InitData()
    }

    if (msg.orbOdometry !== undefined) {
      resolved.orbOdometry = OrbOdometry.Resolve(msg.orbOdometry)
    }
    else {
      resolved.orbOdometry = new OrbOdometry()
    }

    if (msg.testJoystick !== undefined) {
      resolved.testJoystick = Joystick.Resolve(msg.testJoystick)
    }
    else {
      resolved.testJoystick = new Joystick()
    }

    if (msg.liveMpc !== undefined) {
      resolved.liveMpc = LiveMpcData.Resolve(msg.liveMpc)
    }
    else {
      resolved.liveMpc = new LiveMpcData()
    }

    if (msg.sensorEventDEPRECATED !== undefined) {
      resolved.sensorEventDEPRECATED = SensorEventData.Resolve(msg.sensorEventDEPRECATED)
    }
    else {
      resolved.sensorEventDEPRECATED = new SensorEventData()
    }

    if (msg.plan !== undefined) {
      resolved.plan = Plan.Resolve(msg.plan)
    }
    else {
      resolved.plan = new Plan()
    }

    if (msg.liveLocation !== undefined) {
      resolved.liveLocation = LiveLocationData.Resolve(msg.liveLocation)
    }
    else {
      resolved.liveLocation = new LiveLocationData()
    }

    if (msg.cellInfo !== undefined) {
      resolved.cellInfo = new Array(msg.cellInfo.length);
      for (let i = 0; i < resolved.cellInfo.length; ++i) {
        resolved.cellInfo[i] = CellInfo.Resolve(msg.cellInfo[i]);
      }
    }
    else {
      resolved.cellInfo = []
    }

    if (msg.logMessage !== undefined) {
      resolved.logMessage = msg.logMessage;
    }
    else {
      resolved.logMessage = []
    }

    if (msg.navStatus !== undefined) {
      resolved.navStatus = NavStatus.Resolve(msg.navStatus)
    }
    else {
      resolved.navStatus = new NavStatus()
    }

    if (msg.gpsLocation !== undefined) {
      resolved.gpsLocation = GpsLocationData.Resolve(msg.gpsLocation)
    }
    else {
      resolved.gpsLocation = new GpsLocationData()
    }

    if (msg.liveEventDEPRECATED !== undefined) {
      resolved.liveEventDEPRECATED = new Array(msg.liveEventDEPRECATED.length);
      for (let i = 0; i < resolved.liveEventDEPRECATED.length; ++i) {
        resolved.liveEventDEPRECATED[i] = LiveEventData.Resolve(msg.liveEventDEPRECATED[i]);
      }
    }
    else {
      resolved.liveEventDEPRECATED = []
    }

    if (msg.orbFeaturesSummary !== undefined) {
      resolved.orbFeaturesSummary = OrbFeaturesSummary.Resolve(msg.orbFeaturesSummary)
    }
    else {
      resolved.orbFeaturesSummary = new OrbFeaturesSummary()
    }

    if (msg.liveLocationTiming !== undefined) {
      resolved.liveLocationTiming = LiveLocationData.Resolve(msg.liveLocationTiming)
    }
    else {
      resolved.liveLocationTiming = new LiveLocationData()
    }

    if (msg.ubloxGnss !== undefined) {
      resolved.ubloxGnss = UbloxGnss.Resolve(msg.ubloxGnss)
    }
    else {
      resolved.ubloxGnss = new UbloxGnss()
    }

    if (msg.kalmanOdometry !== undefined) {
      resolved.kalmanOdometry = KalmanOdometry.Resolve(msg.kalmanOdometry)
    }
    else {
      resolved.kalmanOdometry = new KalmanOdometry()
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

    if (msg.procLog !== undefined) {
      resolved.procLog = ProcLog.Resolve(msg.procLog)
    }
    else {
      resolved.procLog = new ProcLog()
    }

    if (msg.pathPlan !== undefined) {
      resolved.pathPlan = PathPlan.Resolve(msg.pathPlan)
    }
    else {
      resolved.pathPlan = new PathPlan()
    }

    if (msg.carParams !== undefined) {
      resolved.carParams = CarParams.Resolve(msg.carParams)
    }
    else {
      resolved.carParams = new CarParams()
    }

    if (msg.location !== undefined) {
      resolved.location = LiveLocationData.Resolve(msg.location)
    }
    else {
      resolved.location = new LiveLocationData()
    }

    if (msg.applanixLocation !== undefined) {
      resolved.applanixLocation = LiveLocationData.Resolve(msg.applanixLocation)
    }
    else {
      resolved.applanixLocation = new LiveLocationData()
    }

    if (msg.gpsLocationExternal !== undefined) {
      resolved.gpsLocationExternal = GpsLocationData.Resolve(msg.gpsLocationExternal)
    }
    else {
      resolved.gpsLocationExternal = new GpsLocationData()
    }

    if (msg.can !== undefined) {
      resolved.can = new Array(msg.can.length);
      for (let i = 0; i < resolved.can.length; ++i) {
        resolved.can[i] = CanData.Resolve(msg.can[i]);
      }
    }
    else {
      resolved.can = []
    }

    if (msg.gpsPlannerPlan !== undefined) {
      resolved.gpsPlannerPlan = GPSPlannerPlan.Resolve(msg.gpsPlannerPlan)
    }
    else {
      resolved.gpsPlannerPlan = new GPSPlannerPlan()
    }

    if (msg.liveParameters !== undefined) {
      resolved.liveParameters = LiveParametersData.Resolve(msg.liveParameters)
    }
    else {
      resolved.liveParameters = new LiveParametersData()
    }

    if (msg.model !== undefined) {
      resolved.model = ModelData.Resolve(msg.model)
    }
    else {
      resolved.model = new ModelData()
    }

    if (msg.liveLongitudinalMpc !== undefined) {
      resolved.liveLongitudinalMpc = LiveLongitudinalMpcData.Resolve(msg.liveLongitudinalMpc)
    }
    else {
      resolved.liveLongitudinalMpc = new LiveLongitudinalMpcData()
    }

    if (msg.liveLocationKalman !== undefined) {
      resolved.liveLocationKalman = LiveLocationData.Resolve(msg.liveLocationKalman)
    }
    else {
      resolved.liveLocationKalman = new LiveLocationData()
    }

    if (msg.orbObservation !== undefined) {
      resolved.orbObservation = new Array(msg.orbObservation.length);
      for (let i = 0; i < resolved.orbObservation.length; ++i) {
        resolved.orbObservation[i] = OrbObservation.Resolve(msg.orbObservation[i]);
      }
    }
    else {
      resolved.orbObservation = []
    }

    return resolved;
    }
};

module.exports = Event;
