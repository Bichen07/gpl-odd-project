;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Event)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Event (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::EVENT")
  (make-package "OPENPILOT_BRIDGE::EVENT"))

(in-package "ROS")
;;//! \htmlinclude Event.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Event
  :super ros::object
  :slots (_header _lidarPts _gpsNMEA _androidLogEntry _features _liveMapData _orbFeatures _frame _sendcan _qcomGnss _frontFrame _liveUIDEPRECATED _carEvents _radarState _thermal _clocks _uiLayoutState _orbslamCorrectionDEPRECATED _cameraOdometry _gpsPlannerPoints _sensorEvents _controlsState _androidGnss _applanixRaw _ethernetData _ubloxRaw _liveLocationCorrected _boot _trafficEvents _valid _health _liveCalibration _logMonoTime _wifiScan _carState _thumbnail _navUpdate _orbKeyFrame _uiNavigationEvent _carControl _encodeIdx _driverMonitoring _initData _orbOdometry _testJoystick _liveMpc _sensorEventDEPRECATED _plan _liveLocation _cellInfo _logMessage _navStatus _gpsLocation _liveEventDEPRECATED _orbFeaturesSummary _liveLocationTiming _ubloxGnss _kalmanOdometry _liveTracks _procLog _pathPlan _carParams _location _applanixLocation _gpsLocationExternal _can _gpsPlannerPlan _liveParameters _model _liveLongitudinalMpc _liveLocationKalman _orbObservation ))

(defmethod openpilot_bridge::Event
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lidarPts __lidarPts) (instance openpilot_bridge::LidarPts :init))
    ((:gpsNMEA __gpsNMEA) (instance openpilot_bridge::GPSNMEAData :init))
    ((:androidLogEntry __androidLogEntry) (instance openpilot_bridge::AndroidLogEntry :init))
    ((:features __features) (instance openpilot_bridge::CalibrationFeatures :init))
    ((:liveMapData __liveMapData) (instance openpilot_bridge::LiveMapData :init))
    ((:orbFeatures __orbFeatures) (instance openpilot_bridge::OrbFeatures :init))
    ((:frame __frame) (instance openpilot_bridge::FrameData :init))
    ((:sendcan __sendcan) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CanData :init) r)) r))
    ((:qcomGnss __qcomGnss) (instance openpilot_bridge::QcomGnss :init))
    ((:frontFrame __frontFrame) (instance openpilot_bridge::FrameData :init))
    ((:liveUIDEPRECATED __liveUIDEPRECATED) (instance openpilot_bridge::LiveUI :init))
    ((:carEvents __carEvents) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CarEvent :init) r)) r))
    ((:radarState __radarState) (instance openpilot_bridge::RadarState :init))
    ((:thermal __thermal) (instance openpilot_bridge::ThermalData :init))
    ((:clocks __clocks) (instance openpilot_bridge::Clocks :init))
    ((:uiLayoutState __uiLayoutState) (instance openpilot_bridge::UiLayoutState :init))
    ((:orbslamCorrectionDEPRECATED __orbslamCorrectionDEPRECATED) (instance openpilot_bridge::OrbslamCorrection :init))
    ((:cameraOdometry __cameraOdometry) (instance openpilot_bridge::CameraOdometry :init))
    ((:gpsPlannerPoints __gpsPlannerPoints) (instance openpilot_bridge::GPSPlannerPoints :init))
    ((:sensorEvents __sensorEvents) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::SensorEventData :init) r)) r))
    ((:controlsState __controlsState) (instance openpilot_bridge::ControlsState :init))
    ((:androidGnss __androidGnss) (instance openpilot_bridge::AndroidGnss :init))
    ((:applanixRaw __applanixRaw) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:ethernetData __ethernetData) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::EthernetPacket :init) r)) r))
    ((:ubloxRaw __ubloxRaw) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:liveLocationCorrected __liveLocationCorrected) (instance openpilot_bridge::LiveLocationData :init))
    ((:boot __boot) (instance openpilot_bridge::Boot :init))
    ((:trafficEvents __trafficEvents) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::TrafficEvent :init) r)) r))
    ((:valid __valid) nil)
    ((:health __health) (instance openpilot_bridge::HealthData :init))
    ((:liveCalibration __liveCalibration) (instance openpilot_bridge::LiveCalibrationData :init))
    ((:logMonoTime __logMonoTime) 0)
    ((:wifiScan __wifiScan) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::WifiScan :init) r)) r))
    ((:carState __carState) (instance openpilot_bridge::CarState :init))
    ((:thumbnail __thumbnail) (instance openpilot_bridge::Thumbnail :init))
    ((:navUpdate __navUpdate) (instance openpilot_bridge::NavUpdate :init))
    ((:orbKeyFrame __orbKeyFrame) (instance openpilot_bridge::OrbKeyFrame :init))
    ((:uiNavigationEvent __uiNavigationEvent) (instance openpilot_bridge::UiNavigationEvent :init))
    ((:carControl __carControl) (instance openpilot_bridge::CarControl :init))
    ((:encodeIdx __encodeIdx) (instance openpilot_bridge::EncodeIndex :init))
    ((:driverMonitoring __driverMonitoring) (instance openpilot_bridge::DriverMonitoring :init))
    ((:initData __initData) (instance openpilot_bridge::InitData :init))
    ((:orbOdometry __orbOdometry) (instance openpilot_bridge::OrbOdometry :init))
    ((:testJoystick __testJoystick) (instance openpilot_bridge::Joystick :init))
    ((:liveMpc __liveMpc) (instance openpilot_bridge::LiveMpcData :init))
    ((:sensorEventDEPRECATED __sensorEventDEPRECATED) (instance openpilot_bridge::SensorEventData :init))
    ((:plan __plan) (instance openpilot_bridge::Plan :init))
    ((:liveLocation __liveLocation) (instance openpilot_bridge::LiveLocationData :init))
    ((:cellInfo __cellInfo) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CellInfo :init) r)) r))
    ((:logMessage __logMessage) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:navStatus __navStatus) (instance openpilot_bridge::NavStatus :init))
    ((:gpsLocation __gpsLocation) (instance openpilot_bridge::GpsLocationData :init))
    ((:liveEventDEPRECATED __liveEventDEPRECATED) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::LiveEventData :init) r)) r))
    ((:orbFeaturesSummary __orbFeaturesSummary) (instance openpilot_bridge::OrbFeaturesSummary :init))
    ((:liveLocationTiming __liveLocationTiming) (instance openpilot_bridge::LiveLocationData :init))
    ((:ubloxGnss __ubloxGnss) (instance openpilot_bridge::UbloxGnss :init))
    ((:kalmanOdometry __kalmanOdometry) (instance openpilot_bridge::KalmanOdometry :init))
    ((:liveTracks __liveTracks) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::LiveTracks :init) r)) r))
    ((:procLog __procLog) (instance openpilot_bridge::ProcLog :init))
    ((:pathPlan __pathPlan) (instance openpilot_bridge::PathPlan :init))
    ((:carParams __carParams) (instance openpilot_bridge::CarParams :init))
    ((:location __location) (instance openpilot_bridge::LiveLocationData :init))
    ((:applanixLocation __applanixLocation) (instance openpilot_bridge::LiveLocationData :init))
    ((:gpsLocationExternal __gpsLocationExternal) (instance openpilot_bridge::GpsLocationData :init))
    ((:can __can) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CanData :init) r)) r))
    ((:gpsPlannerPlan __gpsPlannerPlan) (instance openpilot_bridge::GPSPlannerPlan :init))
    ((:liveParameters __liveParameters) (instance openpilot_bridge::LiveParametersData :init))
    ((:model __model) (instance openpilot_bridge::ModelData :init))
    ((:liveLongitudinalMpc __liveLongitudinalMpc) (instance openpilot_bridge::LiveLongitudinalMpcData :init))
    ((:liveLocationKalman __liveLocationKalman) (instance openpilot_bridge::LiveLocationData :init))
    ((:orbObservation __orbObservation) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::OrbObservation :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _lidarPts __lidarPts)
   (setq _gpsNMEA __gpsNMEA)
   (setq _androidLogEntry __androidLogEntry)
   (setq _features __features)
   (setq _liveMapData __liveMapData)
   (setq _orbFeatures __orbFeatures)
   (setq _frame __frame)
   (setq _sendcan __sendcan)
   (setq _qcomGnss __qcomGnss)
   (setq _frontFrame __frontFrame)
   (setq _liveUIDEPRECATED __liveUIDEPRECATED)
   (setq _carEvents __carEvents)
   (setq _radarState __radarState)
   (setq _thermal __thermal)
   (setq _clocks __clocks)
   (setq _uiLayoutState __uiLayoutState)
   (setq _orbslamCorrectionDEPRECATED __orbslamCorrectionDEPRECATED)
   (setq _cameraOdometry __cameraOdometry)
   (setq _gpsPlannerPoints __gpsPlannerPoints)
   (setq _sensorEvents __sensorEvents)
   (setq _controlsState __controlsState)
   (setq _androidGnss __androidGnss)
   (setq _applanixRaw __applanixRaw)
   (setq _ethernetData __ethernetData)
   (setq _ubloxRaw __ubloxRaw)
   (setq _liveLocationCorrected __liveLocationCorrected)
   (setq _boot __boot)
   (setq _trafficEvents __trafficEvents)
   (setq _valid __valid)
   (setq _health __health)
   (setq _liveCalibration __liveCalibration)
   (setq _logMonoTime (round __logMonoTime))
   (setq _wifiScan __wifiScan)
   (setq _carState __carState)
   (setq _thumbnail __thumbnail)
   (setq _navUpdate __navUpdate)
   (setq _orbKeyFrame __orbKeyFrame)
   (setq _uiNavigationEvent __uiNavigationEvent)
   (setq _carControl __carControl)
   (setq _encodeIdx __encodeIdx)
   (setq _driverMonitoring __driverMonitoring)
   (setq _initData __initData)
   (setq _orbOdometry __orbOdometry)
   (setq _testJoystick __testJoystick)
   (setq _liveMpc __liveMpc)
   (setq _sensorEventDEPRECATED __sensorEventDEPRECATED)
   (setq _plan __plan)
   (setq _liveLocation __liveLocation)
   (setq _cellInfo __cellInfo)
   (setq _logMessage __logMessage)
   (setq _navStatus __navStatus)
   (setq _gpsLocation __gpsLocation)
   (setq _liveEventDEPRECATED __liveEventDEPRECATED)
   (setq _orbFeaturesSummary __orbFeaturesSummary)
   (setq _liveLocationTiming __liveLocationTiming)
   (setq _ubloxGnss __ubloxGnss)
   (setq _kalmanOdometry __kalmanOdometry)
   (setq _liveTracks __liveTracks)
   (setq _procLog __procLog)
   (setq _pathPlan __pathPlan)
   (setq _carParams __carParams)
   (setq _location __location)
   (setq _applanixLocation __applanixLocation)
   (setq _gpsLocationExternal __gpsLocationExternal)
   (setq _can __can)
   (setq _gpsPlannerPlan __gpsPlannerPlan)
   (setq _liveParameters __liveParameters)
   (setq _model __model)
   (setq _liveLongitudinalMpc __liveLongitudinalMpc)
   (setq _liveLocationKalman __liveLocationKalman)
   (setq _orbObservation __orbObservation)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lidarPts
   (&rest __lidarPts)
   (if (keywordp (car __lidarPts))
       (send* _lidarPts __lidarPts)
     (progn
       (if __lidarPts (setq _lidarPts (car __lidarPts)))
       _lidarPts)))
  (:gpsNMEA
   (&rest __gpsNMEA)
   (if (keywordp (car __gpsNMEA))
       (send* _gpsNMEA __gpsNMEA)
     (progn
       (if __gpsNMEA (setq _gpsNMEA (car __gpsNMEA)))
       _gpsNMEA)))
  (:androidLogEntry
   (&rest __androidLogEntry)
   (if (keywordp (car __androidLogEntry))
       (send* _androidLogEntry __androidLogEntry)
     (progn
       (if __androidLogEntry (setq _androidLogEntry (car __androidLogEntry)))
       _androidLogEntry)))
  (:features
   (&rest __features)
   (if (keywordp (car __features))
       (send* _features __features)
     (progn
       (if __features (setq _features (car __features)))
       _features)))
  (:liveMapData
   (&rest __liveMapData)
   (if (keywordp (car __liveMapData))
       (send* _liveMapData __liveMapData)
     (progn
       (if __liveMapData (setq _liveMapData (car __liveMapData)))
       _liveMapData)))
  (:orbFeatures
   (&rest __orbFeatures)
   (if (keywordp (car __orbFeatures))
       (send* _orbFeatures __orbFeatures)
     (progn
       (if __orbFeatures (setq _orbFeatures (car __orbFeatures)))
       _orbFeatures)))
  (:frame
   (&rest __frame)
   (if (keywordp (car __frame))
       (send* _frame __frame)
     (progn
       (if __frame (setq _frame (car __frame)))
       _frame)))
  (:sendcan
   (&rest __sendcan)
   (if (keywordp (car __sendcan))
       (send* _sendcan __sendcan)
     (progn
       (if __sendcan (setq _sendcan (car __sendcan)))
       _sendcan)))
  (:qcomGnss
   (&rest __qcomGnss)
   (if (keywordp (car __qcomGnss))
       (send* _qcomGnss __qcomGnss)
     (progn
       (if __qcomGnss (setq _qcomGnss (car __qcomGnss)))
       _qcomGnss)))
  (:frontFrame
   (&rest __frontFrame)
   (if (keywordp (car __frontFrame))
       (send* _frontFrame __frontFrame)
     (progn
       (if __frontFrame (setq _frontFrame (car __frontFrame)))
       _frontFrame)))
  (:liveUIDEPRECATED
   (&rest __liveUIDEPRECATED)
   (if (keywordp (car __liveUIDEPRECATED))
       (send* _liveUIDEPRECATED __liveUIDEPRECATED)
     (progn
       (if __liveUIDEPRECATED (setq _liveUIDEPRECATED (car __liveUIDEPRECATED)))
       _liveUIDEPRECATED)))
  (:carEvents
   (&rest __carEvents)
   (if (keywordp (car __carEvents))
       (send* _carEvents __carEvents)
     (progn
       (if __carEvents (setq _carEvents (car __carEvents)))
       _carEvents)))
  (:radarState
   (&rest __radarState)
   (if (keywordp (car __radarState))
       (send* _radarState __radarState)
     (progn
       (if __radarState (setq _radarState (car __radarState)))
       _radarState)))
  (:thermal
   (&rest __thermal)
   (if (keywordp (car __thermal))
       (send* _thermal __thermal)
     (progn
       (if __thermal (setq _thermal (car __thermal)))
       _thermal)))
  (:clocks
   (&rest __clocks)
   (if (keywordp (car __clocks))
       (send* _clocks __clocks)
     (progn
       (if __clocks (setq _clocks (car __clocks)))
       _clocks)))
  (:uiLayoutState
   (&rest __uiLayoutState)
   (if (keywordp (car __uiLayoutState))
       (send* _uiLayoutState __uiLayoutState)
     (progn
       (if __uiLayoutState (setq _uiLayoutState (car __uiLayoutState)))
       _uiLayoutState)))
  (:orbslamCorrectionDEPRECATED
   (&rest __orbslamCorrectionDEPRECATED)
   (if (keywordp (car __orbslamCorrectionDEPRECATED))
       (send* _orbslamCorrectionDEPRECATED __orbslamCorrectionDEPRECATED)
     (progn
       (if __orbslamCorrectionDEPRECATED (setq _orbslamCorrectionDEPRECATED (car __orbslamCorrectionDEPRECATED)))
       _orbslamCorrectionDEPRECATED)))
  (:cameraOdometry
   (&rest __cameraOdometry)
   (if (keywordp (car __cameraOdometry))
       (send* _cameraOdometry __cameraOdometry)
     (progn
       (if __cameraOdometry (setq _cameraOdometry (car __cameraOdometry)))
       _cameraOdometry)))
  (:gpsPlannerPoints
   (&rest __gpsPlannerPoints)
   (if (keywordp (car __gpsPlannerPoints))
       (send* _gpsPlannerPoints __gpsPlannerPoints)
     (progn
       (if __gpsPlannerPoints (setq _gpsPlannerPoints (car __gpsPlannerPoints)))
       _gpsPlannerPoints)))
  (:sensorEvents
   (&rest __sensorEvents)
   (if (keywordp (car __sensorEvents))
       (send* _sensorEvents __sensorEvents)
     (progn
       (if __sensorEvents (setq _sensorEvents (car __sensorEvents)))
       _sensorEvents)))
  (:controlsState
   (&rest __controlsState)
   (if (keywordp (car __controlsState))
       (send* _controlsState __controlsState)
     (progn
       (if __controlsState (setq _controlsState (car __controlsState)))
       _controlsState)))
  (:androidGnss
   (&rest __androidGnss)
   (if (keywordp (car __androidGnss))
       (send* _androidGnss __androidGnss)
     (progn
       (if __androidGnss (setq _androidGnss (car __androidGnss)))
       _androidGnss)))
  (:applanixRaw
   (&optional __applanixRaw)
   (if __applanixRaw (setq _applanixRaw __applanixRaw)) _applanixRaw)
  (:ethernetData
   (&rest __ethernetData)
   (if (keywordp (car __ethernetData))
       (send* _ethernetData __ethernetData)
     (progn
       (if __ethernetData (setq _ethernetData (car __ethernetData)))
       _ethernetData)))
  (:ubloxRaw
   (&optional __ubloxRaw)
   (if __ubloxRaw (setq _ubloxRaw __ubloxRaw)) _ubloxRaw)
  (:liveLocationCorrected
   (&rest __liveLocationCorrected)
   (if (keywordp (car __liveLocationCorrected))
       (send* _liveLocationCorrected __liveLocationCorrected)
     (progn
       (if __liveLocationCorrected (setq _liveLocationCorrected (car __liveLocationCorrected)))
       _liveLocationCorrected)))
  (:boot
   (&rest __boot)
   (if (keywordp (car __boot))
       (send* _boot __boot)
     (progn
       (if __boot (setq _boot (car __boot)))
       _boot)))
  (:trafficEvents
   (&rest __trafficEvents)
   (if (keywordp (car __trafficEvents))
       (send* _trafficEvents __trafficEvents)
     (progn
       (if __trafficEvents (setq _trafficEvents (car __trafficEvents)))
       _trafficEvents)))
  (:valid
   (&optional __valid)
   (if __valid (setq _valid __valid)) _valid)
  (:health
   (&rest __health)
   (if (keywordp (car __health))
       (send* _health __health)
     (progn
       (if __health (setq _health (car __health)))
       _health)))
  (:liveCalibration
   (&rest __liveCalibration)
   (if (keywordp (car __liveCalibration))
       (send* _liveCalibration __liveCalibration)
     (progn
       (if __liveCalibration (setq _liveCalibration (car __liveCalibration)))
       _liveCalibration)))
  (:logMonoTime
   (&optional __logMonoTime)
   (if __logMonoTime (setq _logMonoTime __logMonoTime)) _logMonoTime)
  (:wifiScan
   (&rest __wifiScan)
   (if (keywordp (car __wifiScan))
       (send* _wifiScan __wifiScan)
     (progn
       (if __wifiScan (setq _wifiScan (car __wifiScan)))
       _wifiScan)))
  (:carState
   (&rest __carState)
   (if (keywordp (car __carState))
       (send* _carState __carState)
     (progn
       (if __carState (setq _carState (car __carState)))
       _carState)))
  (:thumbnail
   (&rest __thumbnail)
   (if (keywordp (car __thumbnail))
       (send* _thumbnail __thumbnail)
     (progn
       (if __thumbnail (setq _thumbnail (car __thumbnail)))
       _thumbnail)))
  (:navUpdate
   (&rest __navUpdate)
   (if (keywordp (car __navUpdate))
       (send* _navUpdate __navUpdate)
     (progn
       (if __navUpdate (setq _navUpdate (car __navUpdate)))
       _navUpdate)))
  (:orbKeyFrame
   (&rest __orbKeyFrame)
   (if (keywordp (car __orbKeyFrame))
       (send* _orbKeyFrame __orbKeyFrame)
     (progn
       (if __orbKeyFrame (setq _orbKeyFrame (car __orbKeyFrame)))
       _orbKeyFrame)))
  (:uiNavigationEvent
   (&rest __uiNavigationEvent)
   (if (keywordp (car __uiNavigationEvent))
       (send* _uiNavigationEvent __uiNavigationEvent)
     (progn
       (if __uiNavigationEvent (setq _uiNavigationEvent (car __uiNavigationEvent)))
       _uiNavigationEvent)))
  (:carControl
   (&rest __carControl)
   (if (keywordp (car __carControl))
       (send* _carControl __carControl)
     (progn
       (if __carControl (setq _carControl (car __carControl)))
       _carControl)))
  (:encodeIdx
   (&rest __encodeIdx)
   (if (keywordp (car __encodeIdx))
       (send* _encodeIdx __encodeIdx)
     (progn
       (if __encodeIdx (setq _encodeIdx (car __encodeIdx)))
       _encodeIdx)))
  (:driverMonitoring
   (&rest __driverMonitoring)
   (if (keywordp (car __driverMonitoring))
       (send* _driverMonitoring __driverMonitoring)
     (progn
       (if __driverMonitoring (setq _driverMonitoring (car __driverMonitoring)))
       _driverMonitoring)))
  (:initData
   (&rest __initData)
   (if (keywordp (car __initData))
       (send* _initData __initData)
     (progn
       (if __initData (setq _initData (car __initData)))
       _initData)))
  (:orbOdometry
   (&rest __orbOdometry)
   (if (keywordp (car __orbOdometry))
       (send* _orbOdometry __orbOdometry)
     (progn
       (if __orbOdometry (setq _orbOdometry (car __orbOdometry)))
       _orbOdometry)))
  (:testJoystick
   (&rest __testJoystick)
   (if (keywordp (car __testJoystick))
       (send* _testJoystick __testJoystick)
     (progn
       (if __testJoystick (setq _testJoystick (car __testJoystick)))
       _testJoystick)))
  (:liveMpc
   (&rest __liveMpc)
   (if (keywordp (car __liveMpc))
       (send* _liveMpc __liveMpc)
     (progn
       (if __liveMpc (setq _liveMpc (car __liveMpc)))
       _liveMpc)))
  (:sensorEventDEPRECATED
   (&rest __sensorEventDEPRECATED)
   (if (keywordp (car __sensorEventDEPRECATED))
       (send* _sensorEventDEPRECATED __sensorEventDEPRECATED)
     (progn
       (if __sensorEventDEPRECATED (setq _sensorEventDEPRECATED (car __sensorEventDEPRECATED)))
       _sensorEventDEPRECATED)))
  (:plan
   (&rest __plan)
   (if (keywordp (car __plan))
       (send* _plan __plan)
     (progn
       (if __plan (setq _plan (car __plan)))
       _plan)))
  (:liveLocation
   (&rest __liveLocation)
   (if (keywordp (car __liveLocation))
       (send* _liveLocation __liveLocation)
     (progn
       (if __liveLocation (setq _liveLocation (car __liveLocation)))
       _liveLocation)))
  (:cellInfo
   (&rest __cellInfo)
   (if (keywordp (car __cellInfo))
       (send* _cellInfo __cellInfo)
     (progn
       (if __cellInfo (setq _cellInfo (car __cellInfo)))
       _cellInfo)))
  (:logMessage
   (&optional __logMessage)
   (if __logMessage (setq _logMessage __logMessage)) _logMessage)
  (:navStatus
   (&rest __navStatus)
   (if (keywordp (car __navStatus))
       (send* _navStatus __navStatus)
     (progn
       (if __navStatus (setq _navStatus (car __navStatus)))
       _navStatus)))
  (:gpsLocation
   (&rest __gpsLocation)
   (if (keywordp (car __gpsLocation))
       (send* _gpsLocation __gpsLocation)
     (progn
       (if __gpsLocation (setq _gpsLocation (car __gpsLocation)))
       _gpsLocation)))
  (:liveEventDEPRECATED
   (&rest __liveEventDEPRECATED)
   (if (keywordp (car __liveEventDEPRECATED))
       (send* _liveEventDEPRECATED __liveEventDEPRECATED)
     (progn
       (if __liveEventDEPRECATED (setq _liveEventDEPRECATED (car __liveEventDEPRECATED)))
       _liveEventDEPRECATED)))
  (:orbFeaturesSummary
   (&rest __orbFeaturesSummary)
   (if (keywordp (car __orbFeaturesSummary))
       (send* _orbFeaturesSummary __orbFeaturesSummary)
     (progn
       (if __orbFeaturesSummary (setq _orbFeaturesSummary (car __orbFeaturesSummary)))
       _orbFeaturesSummary)))
  (:liveLocationTiming
   (&rest __liveLocationTiming)
   (if (keywordp (car __liveLocationTiming))
       (send* _liveLocationTiming __liveLocationTiming)
     (progn
       (if __liveLocationTiming (setq _liveLocationTiming (car __liveLocationTiming)))
       _liveLocationTiming)))
  (:ubloxGnss
   (&rest __ubloxGnss)
   (if (keywordp (car __ubloxGnss))
       (send* _ubloxGnss __ubloxGnss)
     (progn
       (if __ubloxGnss (setq _ubloxGnss (car __ubloxGnss)))
       _ubloxGnss)))
  (:kalmanOdometry
   (&rest __kalmanOdometry)
   (if (keywordp (car __kalmanOdometry))
       (send* _kalmanOdometry __kalmanOdometry)
     (progn
       (if __kalmanOdometry (setq _kalmanOdometry (car __kalmanOdometry)))
       _kalmanOdometry)))
  (:liveTracks
   (&rest __liveTracks)
   (if (keywordp (car __liveTracks))
       (send* _liveTracks __liveTracks)
     (progn
       (if __liveTracks (setq _liveTracks (car __liveTracks)))
       _liveTracks)))
  (:procLog
   (&rest __procLog)
   (if (keywordp (car __procLog))
       (send* _procLog __procLog)
     (progn
       (if __procLog (setq _procLog (car __procLog)))
       _procLog)))
  (:pathPlan
   (&rest __pathPlan)
   (if (keywordp (car __pathPlan))
       (send* _pathPlan __pathPlan)
     (progn
       (if __pathPlan (setq _pathPlan (car __pathPlan)))
       _pathPlan)))
  (:carParams
   (&rest __carParams)
   (if (keywordp (car __carParams))
       (send* _carParams __carParams)
     (progn
       (if __carParams (setq _carParams (car __carParams)))
       _carParams)))
  (:location
   (&rest __location)
   (if (keywordp (car __location))
       (send* _location __location)
     (progn
       (if __location (setq _location (car __location)))
       _location)))
  (:applanixLocation
   (&rest __applanixLocation)
   (if (keywordp (car __applanixLocation))
       (send* _applanixLocation __applanixLocation)
     (progn
       (if __applanixLocation (setq _applanixLocation (car __applanixLocation)))
       _applanixLocation)))
  (:gpsLocationExternal
   (&rest __gpsLocationExternal)
   (if (keywordp (car __gpsLocationExternal))
       (send* _gpsLocationExternal __gpsLocationExternal)
     (progn
       (if __gpsLocationExternal (setq _gpsLocationExternal (car __gpsLocationExternal)))
       _gpsLocationExternal)))
  (:can
   (&rest __can)
   (if (keywordp (car __can))
       (send* _can __can)
     (progn
       (if __can (setq _can (car __can)))
       _can)))
  (:gpsPlannerPlan
   (&rest __gpsPlannerPlan)
   (if (keywordp (car __gpsPlannerPlan))
       (send* _gpsPlannerPlan __gpsPlannerPlan)
     (progn
       (if __gpsPlannerPlan (setq _gpsPlannerPlan (car __gpsPlannerPlan)))
       _gpsPlannerPlan)))
  (:liveParameters
   (&rest __liveParameters)
   (if (keywordp (car __liveParameters))
       (send* _liveParameters __liveParameters)
     (progn
       (if __liveParameters (setq _liveParameters (car __liveParameters)))
       _liveParameters)))
  (:model
   (&rest __model)
   (if (keywordp (car __model))
       (send* _model __model)
     (progn
       (if __model (setq _model (car __model)))
       _model)))
  (:liveLongitudinalMpc
   (&rest __liveLongitudinalMpc)
   (if (keywordp (car __liveLongitudinalMpc))
       (send* _liveLongitudinalMpc __liveLongitudinalMpc)
     (progn
       (if __liveLongitudinalMpc (setq _liveLongitudinalMpc (car __liveLongitudinalMpc)))
       _liveLongitudinalMpc)))
  (:liveLocationKalman
   (&rest __liveLocationKalman)
   (if (keywordp (car __liveLocationKalman))
       (send* _liveLocationKalman __liveLocationKalman)
     (progn
       (if __liveLocationKalman (setq _liveLocationKalman (car __liveLocationKalman)))
       _liveLocationKalman)))
  (:orbObservation
   (&rest __orbObservation)
   (if (keywordp (car __orbObservation))
       (send* _orbObservation __orbObservation)
     (progn
       (if __orbObservation (setq _orbObservation (car __orbObservation)))
       _orbObservation)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/LidarPts _lidarPts
    (send _lidarPts :serialization-length)
    ;; openpilot_bridge/GPSNMEAData _gpsNMEA
    (send _gpsNMEA :serialization-length)
    ;; openpilot_bridge/AndroidLogEntry _androidLogEntry
    (send _androidLogEntry :serialization-length)
    ;; openpilot_bridge/CalibrationFeatures _features
    (send _features :serialization-length)
    ;; openpilot_bridge/LiveMapData _liveMapData
    (send _liveMapData :serialization-length)
    ;; openpilot_bridge/OrbFeatures _orbFeatures
    (send _orbFeatures :serialization-length)
    ;; openpilot_bridge/FrameData _frame
    (send _frame :serialization-length)
    ;; openpilot_bridge/CanData[] _sendcan
    (apply #'+ (send-all _sendcan :serialization-length)) 4
    ;; openpilot_bridge/QcomGnss _qcomGnss
    (send _qcomGnss :serialization-length)
    ;; openpilot_bridge/FrameData _frontFrame
    (send _frontFrame :serialization-length)
    ;; openpilot_bridge/LiveUI _liveUIDEPRECATED
    (send _liveUIDEPRECATED :serialization-length)
    ;; openpilot_bridge/CarEvent[] _carEvents
    (apply #'+ (send-all _carEvents :serialization-length)) 4
    ;; openpilot_bridge/RadarState _radarState
    (send _radarState :serialization-length)
    ;; openpilot_bridge/ThermalData _thermal
    (send _thermal :serialization-length)
    ;; openpilot_bridge/Clocks _clocks
    (send _clocks :serialization-length)
    ;; openpilot_bridge/UiLayoutState _uiLayoutState
    (send _uiLayoutState :serialization-length)
    ;; openpilot_bridge/OrbslamCorrection _orbslamCorrectionDEPRECATED
    (send _orbslamCorrectionDEPRECATED :serialization-length)
    ;; openpilot_bridge/CameraOdometry _cameraOdometry
    (send _cameraOdometry :serialization-length)
    ;; openpilot_bridge/GPSPlannerPoints _gpsPlannerPoints
    (send _gpsPlannerPoints :serialization-length)
    ;; openpilot_bridge/SensorEventData[] _sensorEvents
    (apply #'+ (send-all _sensorEvents :serialization-length)) 4
    ;; openpilot_bridge/ControlsState _controlsState
    (send _controlsState :serialization-length)
    ;; openpilot_bridge/AndroidGnss _androidGnss
    (send _androidGnss :serialization-length)
    ;; string[] _applanixRaw
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _applanixRaw)) 4
    ;; openpilot_bridge/EthernetPacket[] _ethernetData
    (apply #'+ (send-all _ethernetData :serialization-length)) 4
    ;; string[] _ubloxRaw
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _ubloxRaw)) 4
    ;; openpilot_bridge/LiveLocationData _liveLocationCorrected
    (send _liveLocationCorrected :serialization-length)
    ;; openpilot_bridge/Boot _boot
    (send _boot :serialization-length)
    ;; openpilot_bridge/TrafficEvent[] _trafficEvents
    (apply #'+ (send-all _trafficEvents :serialization-length)) 4
    ;; bool _valid
    1
    ;; openpilot_bridge/HealthData _health
    (send _health :serialization-length)
    ;; openpilot_bridge/LiveCalibrationData _liveCalibration
    (send _liveCalibration :serialization-length)
    ;; int64 _logMonoTime
    8
    ;; openpilot_bridge/WifiScan[] _wifiScan
    (apply #'+ (send-all _wifiScan :serialization-length)) 4
    ;; openpilot_bridge/CarState _carState
    (send _carState :serialization-length)
    ;; openpilot_bridge/Thumbnail _thumbnail
    (send _thumbnail :serialization-length)
    ;; openpilot_bridge/NavUpdate _navUpdate
    (send _navUpdate :serialization-length)
    ;; openpilot_bridge/OrbKeyFrame _orbKeyFrame
    (send _orbKeyFrame :serialization-length)
    ;; openpilot_bridge/UiNavigationEvent _uiNavigationEvent
    (send _uiNavigationEvent :serialization-length)
    ;; openpilot_bridge/CarControl _carControl
    (send _carControl :serialization-length)
    ;; openpilot_bridge/EncodeIndex _encodeIdx
    (send _encodeIdx :serialization-length)
    ;; openpilot_bridge/DriverMonitoring _driverMonitoring
    (send _driverMonitoring :serialization-length)
    ;; openpilot_bridge/InitData _initData
    (send _initData :serialization-length)
    ;; openpilot_bridge/OrbOdometry _orbOdometry
    (send _orbOdometry :serialization-length)
    ;; openpilot_bridge/Joystick _testJoystick
    (send _testJoystick :serialization-length)
    ;; openpilot_bridge/LiveMpcData _liveMpc
    (send _liveMpc :serialization-length)
    ;; openpilot_bridge/SensorEventData _sensorEventDEPRECATED
    (send _sensorEventDEPRECATED :serialization-length)
    ;; openpilot_bridge/Plan _plan
    (send _plan :serialization-length)
    ;; openpilot_bridge/LiveLocationData _liveLocation
    (send _liveLocation :serialization-length)
    ;; openpilot_bridge/CellInfo[] _cellInfo
    (apply #'+ (send-all _cellInfo :serialization-length)) 4
    ;; string[] _logMessage
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _logMessage)) 4
    ;; openpilot_bridge/NavStatus _navStatus
    (send _navStatus :serialization-length)
    ;; openpilot_bridge/GpsLocationData _gpsLocation
    (send _gpsLocation :serialization-length)
    ;; openpilot_bridge/LiveEventData[] _liveEventDEPRECATED
    (apply #'+ (send-all _liveEventDEPRECATED :serialization-length)) 4
    ;; openpilot_bridge/OrbFeaturesSummary _orbFeaturesSummary
    (send _orbFeaturesSummary :serialization-length)
    ;; openpilot_bridge/LiveLocationData _liveLocationTiming
    (send _liveLocationTiming :serialization-length)
    ;; openpilot_bridge/UbloxGnss _ubloxGnss
    (send _ubloxGnss :serialization-length)
    ;; openpilot_bridge/KalmanOdometry _kalmanOdometry
    (send _kalmanOdometry :serialization-length)
    ;; openpilot_bridge/LiveTracks[] _liveTracks
    (apply #'+ (send-all _liveTracks :serialization-length)) 4
    ;; openpilot_bridge/ProcLog _procLog
    (send _procLog :serialization-length)
    ;; openpilot_bridge/PathPlan _pathPlan
    (send _pathPlan :serialization-length)
    ;; openpilot_bridge/CarParams _carParams
    (send _carParams :serialization-length)
    ;; openpilot_bridge/LiveLocationData _location
    (send _location :serialization-length)
    ;; openpilot_bridge/LiveLocationData _applanixLocation
    (send _applanixLocation :serialization-length)
    ;; openpilot_bridge/GpsLocationData _gpsLocationExternal
    (send _gpsLocationExternal :serialization-length)
    ;; openpilot_bridge/CanData[] _can
    (apply #'+ (send-all _can :serialization-length)) 4
    ;; openpilot_bridge/GPSPlannerPlan _gpsPlannerPlan
    (send _gpsPlannerPlan :serialization-length)
    ;; openpilot_bridge/LiveParametersData _liveParameters
    (send _liveParameters :serialization-length)
    ;; openpilot_bridge/ModelData _model
    (send _model :serialization-length)
    ;; openpilot_bridge/LiveLongitudinalMpcData _liveLongitudinalMpc
    (send _liveLongitudinalMpc :serialization-length)
    ;; openpilot_bridge/LiveLocationData _liveLocationKalman
    (send _liveLocationKalman :serialization-length)
    ;; openpilot_bridge/OrbObservation[] _orbObservation
    (apply #'+ (send-all _orbObservation :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/LidarPts _lidarPts
       (send _lidarPts :serialize s)
     ;; openpilot_bridge/GPSNMEAData _gpsNMEA
       (send _gpsNMEA :serialize s)
     ;; openpilot_bridge/AndroidLogEntry _androidLogEntry
       (send _androidLogEntry :serialize s)
     ;; openpilot_bridge/CalibrationFeatures _features
       (send _features :serialize s)
     ;; openpilot_bridge/LiveMapData _liveMapData
       (send _liveMapData :serialize s)
     ;; openpilot_bridge/OrbFeatures _orbFeatures
       (send _orbFeatures :serialize s)
     ;; openpilot_bridge/FrameData _frame
       (send _frame :serialize s)
     ;; openpilot_bridge/CanData[] _sendcan
     (write-long (length _sendcan) s)
     (dolist (elem _sendcan)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/QcomGnss _qcomGnss
       (send _qcomGnss :serialize s)
     ;; openpilot_bridge/FrameData _frontFrame
       (send _frontFrame :serialize s)
     ;; openpilot_bridge/LiveUI _liveUIDEPRECATED
       (send _liveUIDEPRECATED :serialize s)
     ;; openpilot_bridge/CarEvent[] _carEvents
     (write-long (length _carEvents) s)
     (dolist (elem _carEvents)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/RadarState _radarState
       (send _radarState :serialize s)
     ;; openpilot_bridge/ThermalData _thermal
       (send _thermal :serialize s)
     ;; openpilot_bridge/Clocks _clocks
       (send _clocks :serialize s)
     ;; openpilot_bridge/UiLayoutState _uiLayoutState
       (send _uiLayoutState :serialize s)
     ;; openpilot_bridge/OrbslamCorrection _orbslamCorrectionDEPRECATED
       (send _orbslamCorrectionDEPRECATED :serialize s)
     ;; openpilot_bridge/CameraOdometry _cameraOdometry
       (send _cameraOdometry :serialize s)
     ;; openpilot_bridge/GPSPlannerPoints _gpsPlannerPoints
       (send _gpsPlannerPoints :serialize s)
     ;; openpilot_bridge/SensorEventData[] _sensorEvents
     (write-long (length _sensorEvents) s)
     (dolist (elem _sensorEvents)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/ControlsState _controlsState
       (send _controlsState :serialize s)
     ;; openpilot_bridge/AndroidGnss _androidGnss
       (send _androidGnss :serialize s)
     ;; string[] _applanixRaw
     (write-long (length _applanixRaw) s)
     (dolist (elem _applanixRaw)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/EthernetPacket[] _ethernetData
     (write-long (length _ethernetData) s)
     (dolist (elem _ethernetData)
       (send elem :serialize s)
       )
     ;; string[] _ubloxRaw
     (write-long (length _ubloxRaw) s)
     (dolist (elem _ubloxRaw)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/LiveLocationData _liveLocationCorrected
       (send _liveLocationCorrected :serialize s)
     ;; openpilot_bridge/Boot _boot
       (send _boot :serialize s)
     ;; openpilot_bridge/TrafficEvent[] _trafficEvents
     (write-long (length _trafficEvents) s)
     (dolist (elem _trafficEvents)
       (send elem :serialize s)
       )
     ;; bool _valid
       (if _valid (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/HealthData _health
       (send _health :serialize s)
     ;; openpilot_bridge/LiveCalibrationData _liveCalibration
       (send _liveCalibration :serialize s)
     ;; int64 _logMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _logMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _logMonoTime) (= (length (_logMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_logMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_logMonoTime . bv) 1) -1) s))
             ((and (class _logMonoTime) (= (length (_logMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_logMonoTime . bv) 0) s)
              (write-long (if (>= _logMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _logMonoTime s)(write-long (if (>= _logMonoTime 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/WifiScan[] _wifiScan
     (write-long (length _wifiScan) s)
     (dolist (elem _wifiScan)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/CarState _carState
       (send _carState :serialize s)
     ;; openpilot_bridge/Thumbnail _thumbnail
       (send _thumbnail :serialize s)
     ;; openpilot_bridge/NavUpdate _navUpdate
       (send _navUpdate :serialize s)
     ;; openpilot_bridge/OrbKeyFrame _orbKeyFrame
       (send _orbKeyFrame :serialize s)
     ;; openpilot_bridge/UiNavigationEvent _uiNavigationEvent
       (send _uiNavigationEvent :serialize s)
     ;; openpilot_bridge/CarControl _carControl
       (send _carControl :serialize s)
     ;; openpilot_bridge/EncodeIndex _encodeIdx
       (send _encodeIdx :serialize s)
     ;; openpilot_bridge/DriverMonitoring _driverMonitoring
       (send _driverMonitoring :serialize s)
     ;; openpilot_bridge/InitData _initData
       (send _initData :serialize s)
     ;; openpilot_bridge/OrbOdometry _orbOdometry
       (send _orbOdometry :serialize s)
     ;; openpilot_bridge/Joystick _testJoystick
       (send _testJoystick :serialize s)
     ;; openpilot_bridge/LiveMpcData _liveMpc
       (send _liveMpc :serialize s)
     ;; openpilot_bridge/SensorEventData _sensorEventDEPRECATED
       (send _sensorEventDEPRECATED :serialize s)
     ;; openpilot_bridge/Plan _plan
       (send _plan :serialize s)
     ;; openpilot_bridge/LiveLocationData _liveLocation
       (send _liveLocation :serialize s)
     ;; openpilot_bridge/CellInfo[] _cellInfo
     (write-long (length _cellInfo) s)
     (dolist (elem _cellInfo)
       (send elem :serialize s)
       )
     ;; string[] _logMessage
     (write-long (length _logMessage) s)
     (dolist (elem _logMessage)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/NavStatus _navStatus
       (send _navStatus :serialize s)
     ;; openpilot_bridge/GpsLocationData _gpsLocation
       (send _gpsLocation :serialize s)
     ;; openpilot_bridge/LiveEventData[] _liveEventDEPRECATED
     (write-long (length _liveEventDEPRECATED) s)
     (dolist (elem _liveEventDEPRECATED)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/OrbFeaturesSummary _orbFeaturesSummary
       (send _orbFeaturesSummary :serialize s)
     ;; openpilot_bridge/LiveLocationData _liveLocationTiming
       (send _liveLocationTiming :serialize s)
     ;; openpilot_bridge/UbloxGnss _ubloxGnss
       (send _ubloxGnss :serialize s)
     ;; openpilot_bridge/KalmanOdometry _kalmanOdometry
       (send _kalmanOdometry :serialize s)
     ;; openpilot_bridge/LiveTracks[] _liveTracks
     (write-long (length _liveTracks) s)
     (dolist (elem _liveTracks)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/ProcLog _procLog
       (send _procLog :serialize s)
     ;; openpilot_bridge/PathPlan _pathPlan
       (send _pathPlan :serialize s)
     ;; openpilot_bridge/CarParams _carParams
       (send _carParams :serialize s)
     ;; openpilot_bridge/LiveLocationData _location
       (send _location :serialize s)
     ;; openpilot_bridge/LiveLocationData _applanixLocation
       (send _applanixLocation :serialize s)
     ;; openpilot_bridge/GpsLocationData _gpsLocationExternal
       (send _gpsLocationExternal :serialize s)
     ;; openpilot_bridge/CanData[] _can
     (write-long (length _can) s)
     (dolist (elem _can)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/GPSPlannerPlan _gpsPlannerPlan
       (send _gpsPlannerPlan :serialize s)
     ;; openpilot_bridge/LiveParametersData _liveParameters
       (send _liveParameters :serialize s)
     ;; openpilot_bridge/ModelData _model
       (send _model :serialize s)
     ;; openpilot_bridge/LiveLongitudinalMpcData _liveLongitudinalMpc
       (send _liveLongitudinalMpc :serialize s)
     ;; openpilot_bridge/LiveLocationData _liveLocationKalman
       (send _liveLocationKalman :serialize s)
     ;; openpilot_bridge/OrbObservation[] _orbObservation
     (write-long (length _orbObservation) s)
     (dolist (elem _orbObservation)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/LidarPts _lidarPts
     (send _lidarPts :deserialize buf ptr-) (incf ptr- (send _lidarPts :serialization-length))
   ;; openpilot_bridge/GPSNMEAData _gpsNMEA
     (send _gpsNMEA :deserialize buf ptr-) (incf ptr- (send _gpsNMEA :serialization-length))
   ;; openpilot_bridge/AndroidLogEntry _androidLogEntry
     (send _androidLogEntry :deserialize buf ptr-) (incf ptr- (send _androidLogEntry :serialization-length))
   ;; openpilot_bridge/CalibrationFeatures _features
     (send _features :deserialize buf ptr-) (incf ptr- (send _features :serialization-length))
   ;; openpilot_bridge/LiveMapData _liveMapData
     (send _liveMapData :deserialize buf ptr-) (incf ptr- (send _liveMapData :serialization-length))
   ;; openpilot_bridge/OrbFeatures _orbFeatures
     (send _orbFeatures :deserialize buf ptr-) (incf ptr- (send _orbFeatures :serialization-length))
   ;; openpilot_bridge/FrameData _frame
     (send _frame :deserialize buf ptr-) (incf ptr- (send _frame :serialization-length))
   ;; openpilot_bridge/CanData[] _sendcan
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sendcan (let (r) (dotimes (i n) (push (instance openpilot_bridge::CanData :init) r)) r))
     (dolist (elem- _sendcan)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/QcomGnss _qcomGnss
     (send _qcomGnss :deserialize buf ptr-) (incf ptr- (send _qcomGnss :serialization-length))
   ;; openpilot_bridge/FrameData _frontFrame
     (send _frontFrame :deserialize buf ptr-) (incf ptr- (send _frontFrame :serialization-length))
   ;; openpilot_bridge/LiveUI _liveUIDEPRECATED
     (send _liveUIDEPRECATED :deserialize buf ptr-) (incf ptr- (send _liveUIDEPRECATED :serialization-length))
   ;; openpilot_bridge/CarEvent[] _carEvents
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carEvents (let (r) (dotimes (i n) (push (instance openpilot_bridge::CarEvent :init) r)) r))
     (dolist (elem- _carEvents)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/RadarState _radarState
     (send _radarState :deserialize buf ptr-) (incf ptr- (send _radarState :serialization-length))
   ;; openpilot_bridge/ThermalData _thermal
     (send _thermal :deserialize buf ptr-) (incf ptr- (send _thermal :serialization-length))
   ;; openpilot_bridge/Clocks _clocks
     (send _clocks :deserialize buf ptr-) (incf ptr- (send _clocks :serialization-length))
   ;; openpilot_bridge/UiLayoutState _uiLayoutState
     (send _uiLayoutState :deserialize buf ptr-) (incf ptr- (send _uiLayoutState :serialization-length))
   ;; openpilot_bridge/OrbslamCorrection _orbslamCorrectionDEPRECATED
     (send _orbslamCorrectionDEPRECATED :deserialize buf ptr-) (incf ptr- (send _orbslamCorrectionDEPRECATED :serialization-length))
   ;; openpilot_bridge/CameraOdometry _cameraOdometry
     (send _cameraOdometry :deserialize buf ptr-) (incf ptr- (send _cameraOdometry :serialization-length))
   ;; openpilot_bridge/GPSPlannerPoints _gpsPlannerPoints
     (send _gpsPlannerPoints :deserialize buf ptr-) (incf ptr- (send _gpsPlannerPoints :serialization-length))
   ;; openpilot_bridge/SensorEventData[] _sensorEvents
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sensorEvents (let (r) (dotimes (i n) (push (instance openpilot_bridge::SensorEventData :init) r)) r))
     (dolist (elem- _sensorEvents)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/ControlsState _controlsState
     (send _controlsState :deserialize buf ptr-) (incf ptr- (send _controlsState :serialization-length))
   ;; openpilot_bridge/AndroidGnss _androidGnss
     (send _androidGnss :deserialize buf ptr-) (incf ptr- (send _androidGnss :serialization-length))
   ;; string[] _applanixRaw
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _applanixRaw (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _applanixRaw i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/EthernetPacket[] _ethernetData
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ethernetData (let (r) (dotimes (i n) (push (instance openpilot_bridge::EthernetPacket :init) r)) r))
     (dolist (elem- _ethernetData)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _ubloxRaw
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ubloxRaw (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _ubloxRaw i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/LiveLocationData _liveLocationCorrected
     (send _liveLocationCorrected :deserialize buf ptr-) (incf ptr- (send _liveLocationCorrected :serialization-length))
   ;; openpilot_bridge/Boot _boot
     (send _boot :deserialize buf ptr-) (incf ptr- (send _boot :serialization-length))
   ;; openpilot_bridge/TrafficEvent[] _trafficEvents
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _trafficEvents (let (r) (dotimes (i n) (push (instance openpilot_bridge::TrafficEvent :init) r)) r))
     (dolist (elem- _trafficEvents)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _valid
     (setq _valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/HealthData _health
     (send _health :deserialize buf ptr-) (incf ptr- (send _health :serialization-length))
   ;; openpilot_bridge/LiveCalibrationData _liveCalibration
     (send _liveCalibration :deserialize buf ptr-) (incf ptr- (send _liveCalibration :serialization-length))
   ;; int64 _logMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _logMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _logMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/WifiScan[] _wifiScan
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _wifiScan (let (r) (dotimes (i n) (push (instance openpilot_bridge::WifiScan :init) r)) r))
     (dolist (elem- _wifiScan)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/CarState _carState
     (send _carState :deserialize buf ptr-) (incf ptr- (send _carState :serialization-length))
   ;; openpilot_bridge/Thumbnail _thumbnail
     (send _thumbnail :deserialize buf ptr-) (incf ptr- (send _thumbnail :serialization-length))
   ;; openpilot_bridge/NavUpdate _navUpdate
     (send _navUpdate :deserialize buf ptr-) (incf ptr- (send _navUpdate :serialization-length))
   ;; openpilot_bridge/OrbKeyFrame _orbKeyFrame
     (send _orbKeyFrame :deserialize buf ptr-) (incf ptr- (send _orbKeyFrame :serialization-length))
   ;; openpilot_bridge/UiNavigationEvent _uiNavigationEvent
     (send _uiNavigationEvent :deserialize buf ptr-) (incf ptr- (send _uiNavigationEvent :serialization-length))
   ;; openpilot_bridge/CarControl _carControl
     (send _carControl :deserialize buf ptr-) (incf ptr- (send _carControl :serialization-length))
   ;; openpilot_bridge/EncodeIndex _encodeIdx
     (send _encodeIdx :deserialize buf ptr-) (incf ptr- (send _encodeIdx :serialization-length))
   ;; openpilot_bridge/DriverMonitoring _driverMonitoring
     (send _driverMonitoring :deserialize buf ptr-) (incf ptr- (send _driverMonitoring :serialization-length))
   ;; openpilot_bridge/InitData _initData
     (send _initData :deserialize buf ptr-) (incf ptr- (send _initData :serialization-length))
   ;; openpilot_bridge/OrbOdometry _orbOdometry
     (send _orbOdometry :deserialize buf ptr-) (incf ptr- (send _orbOdometry :serialization-length))
   ;; openpilot_bridge/Joystick _testJoystick
     (send _testJoystick :deserialize buf ptr-) (incf ptr- (send _testJoystick :serialization-length))
   ;; openpilot_bridge/LiveMpcData _liveMpc
     (send _liveMpc :deserialize buf ptr-) (incf ptr- (send _liveMpc :serialization-length))
   ;; openpilot_bridge/SensorEventData _sensorEventDEPRECATED
     (send _sensorEventDEPRECATED :deserialize buf ptr-) (incf ptr- (send _sensorEventDEPRECATED :serialization-length))
   ;; openpilot_bridge/Plan _plan
     (send _plan :deserialize buf ptr-) (incf ptr- (send _plan :serialization-length))
   ;; openpilot_bridge/LiveLocationData _liveLocation
     (send _liveLocation :deserialize buf ptr-) (incf ptr- (send _liveLocation :serialization-length))
   ;; openpilot_bridge/CellInfo[] _cellInfo
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cellInfo (let (r) (dotimes (i n) (push (instance openpilot_bridge::CellInfo :init) r)) r))
     (dolist (elem- _cellInfo)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _logMessage
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _logMessage (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _logMessage i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/NavStatus _navStatus
     (send _navStatus :deserialize buf ptr-) (incf ptr- (send _navStatus :serialization-length))
   ;; openpilot_bridge/GpsLocationData _gpsLocation
     (send _gpsLocation :deserialize buf ptr-) (incf ptr- (send _gpsLocation :serialization-length))
   ;; openpilot_bridge/LiveEventData[] _liveEventDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _liveEventDEPRECATED (let (r) (dotimes (i n) (push (instance openpilot_bridge::LiveEventData :init) r)) r))
     (dolist (elem- _liveEventDEPRECATED)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/OrbFeaturesSummary _orbFeaturesSummary
     (send _orbFeaturesSummary :deserialize buf ptr-) (incf ptr- (send _orbFeaturesSummary :serialization-length))
   ;; openpilot_bridge/LiveLocationData _liveLocationTiming
     (send _liveLocationTiming :deserialize buf ptr-) (incf ptr- (send _liveLocationTiming :serialization-length))
   ;; openpilot_bridge/UbloxGnss _ubloxGnss
     (send _ubloxGnss :deserialize buf ptr-) (incf ptr- (send _ubloxGnss :serialization-length))
   ;; openpilot_bridge/KalmanOdometry _kalmanOdometry
     (send _kalmanOdometry :deserialize buf ptr-) (incf ptr- (send _kalmanOdometry :serialization-length))
   ;; openpilot_bridge/LiveTracks[] _liveTracks
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _liveTracks (let (r) (dotimes (i n) (push (instance openpilot_bridge::LiveTracks :init) r)) r))
     (dolist (elem- _liveTracks)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/ProcLog _procLog
     (send _procLog :deserialize buf ptr-) (incf ptr- (send _procLog :serialization-length))
   ;; openpilot_bridge/PathPlan _pathPlan
     (send _pathPlan :deserialize buf ptr-) (incf ptr- (send _pathPlan :serialization-length))
   ;; openpilot_bridge/CarParams _carParams
     (send _carParams :deserialize buf ptr-) (incf ptr- (send _carParams :serialization-length))
   ;; openpilot_bridge/LiveLocationData _location
     (send _location :deserialize buf ptr-) (incf ptr- (send _location :serialization-length))
   ;; openpilot_bridge/LiveLocationData _applanixLocation
     (send _applanixLocation :deserialize buf ptr-) (incf ptr- (send _applanixLocation :serialization-length))
   ;; openpilot_bridge/GpsLocationData _gpsLocationExternal
     (send _gpsLocationExternal :deserialize buf ptr-) (incf ptr- (send _gpsLocationExternal :serialization-length))
   ;; openpilot_bridge/CanData[] _can
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _can (let (r) (dotimes (i n) (push (instance openpilot_bridge::CanData :init) r)) r))
     (dolist (elem- _can)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/GPSPlannerPlan _gpsPlannerPlan
     (send _gpsPlannerPlan :deserialize buf ptr-) (incf ptr- (send _gpsPlannerPlan :serialization-length))
   ;; openpilot_bridge/LiveParametersData _liveParameters
     (send _liveParameters :deserialize buf ptr-) (incf ptr- (send _liveParameters :serialization-length))
   ;; openpilot_bridge/ModelData _model
     (send _model :deserialize buf ptr-) (incf ptr- (send _model :serialization-length))
   ;; openpilot_bridge/LiveLongitudinalMpcData _liveLongitudinalMpc
     (send _liveLongitudinalMpc :deserialize buf ptr-) (incf ptr- (send _liveLongitudinalMpc :serialization-length))
   ;; openpilot_bridge/LiveLocationData _liveLocationKalman
     (send _liveLocationKalman :deserialize buf ptr-) (incf ptr- (send _liveLocationKalman :serialization-length))
   ;; openpilot_bridge/OrbObservation[] _orbObservation
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _orbObservation (let (r) (dotimes (i n) (push (instance openpilot_bridge::OrbObservation :init) r)) r))
     (dolist (elem- _orbObservation)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::Event :md5sum-) "2e5006338b7fd3709f95d9b5d9566d9c")
(setf (get openpilot_bridge::Event :datatype-) "openpilot_bridge/Event")
(setf (get openpilot_bridge::Event :definition-)
      "Header header

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

")



(provide :openpilot_bridge/Event "2e5006338b7fd3709f95d9b5d9566d9c")


