; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Event.msg.html

(cl:defclass <Event> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lidarPts
    :reader lidarPts
    :initarg :lidarPts
    :type openpilot_bridge-msg:LidarPts
    :initform (cl:make-instance 'openpilot_bridge-msg:LidarPts))
   (gpsNMEA
    :reader gpsNMEA
    :initarg :gpsNMEA
    :type openpilot_bridge-msg:GPSNMEAData
    :initform (cl:make-instance 'openpilot_bridge-msg:GPSNMEAData))
   (androidLogEntry
    :reader androidLogEntry
    :initarg :androidLogEntry
    :type openpilot_bridge-msg:AndroidLogEntry
    :initform (cl:make-instance 'openpilot_bridge-msg:AndroidLogEntry))
   (features
    :reader features
    :initarg :features
    :type openpilot_bridge-msg:CalibrationFeatures
    :initform (cl:make-instance 'openpilot_bridge-msg:CalibrationFeatures))
   (liveMapData
    :reader liveMapData
    :initarg :liveMapData
    :type openpilot_bridge-msg:LiveMapData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveMapData))
   (orbFeatures
    :reader orbFeatures
    :initarg :orbFeatures
    :type openpilot_bridge-msg:OrbFeatures
    :initform (cl:make-instance 'openpilot_bridge-msg:OrbFeatures))
   (frame
    :reader frame
    :initarg :frame
    :type openpilot_bridge-msg:FrameData
    :initform (cl:make-instance 'openpilot_bridge-msg:FrameData))
   (sendcan
    :reader sendcan
    :initarg :sendcan
    :type (cl:vector openpilot_bridge-msg:CanData)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CanData :initial-element (cl:make-instance 'openpilot_bridge-msg:CanData)))
   (qcomGnss
    :reader qcomGnss
    :initarg :qcomGnss
    :type openpilot_bridge-msg:QcomGnss
    :initform (cl:make-instance 'openpilot_bridge-msg:QcomGnss))
   (frontFrame
    :reader frontFrame
    :initarg :frontFrame
    :type openpilot_bridge-msg:FrameData
    :initform (cl:make-instance 'openpilot_bridge-msg:FrameData))
   (liveUIDEPRECATED
    :reader liveUIDEPRECATED
    :initarg :liveUIDEPRECATED
    :type openpilot_bridge-msg:LiveUI
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveUI))
   (carEvents
    :reader carEvents
    :initarg :carEvents
    :type (cl:vector openpilot_bridge-msg:CarEvent)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CarEvent :initial-element (cl:make-instance 'openpilot_bridge-msg:CarEvent)))
   (radarState
    :reader radarState
    :initarg :radarState
    :type openpilot_bridge-msg:RadarState
    :initform (cl:make-instance 'openpilot_bridge-msg:RadarState))
   (thermal
    :reader thermal
    :initarg :thermal
    :type openpilot_bridge-msg:ThermalData
    :initform (cl:make-instance 'openpilot_bridge-msg:ThermalData))
   (clocks
    :reader clocks
    :initarg :clocks
    :type openpilot_bridge-msg:Clocks
    :initform (cl:make-instance 'openpilot_bridge-msg:Clocks))
   (uiLayoutState
    :reader uiLayoutState
    :initarg :uiLayoutState
    :type openpilot_bridge-msg:UiLayoutState
    :initform (cl:make-instance 'openpilot_bridge-msg:UiLayoutState))
   (orbslamCorrectionDEPRECATED
    :reader orbslamCorrectionDEPRECATED
    :initarg :orbslamCorrectionDEPRECATED
    :type openpilot_bridge-msg:OrbslamCorrection
    :initform (cl:make-instance 'openpilot_bridge-msg:OrbslamCorrection))
   (cameraOdometry
    :reader cameraOdometry
    :initarg :cameraOdometry
    :type openpilot_bridge-msg:CameraOdometry
    :initform (cl:make-instance 'openpilot_bridge-msg:CameraOdometry))
   (gpsPlannerPoints
    :reader gpsPlannerPoints
    :initarg :gpsPlannerPoints
    :type openpilot_bridge-msg:GPSPlannerPoints
    :initform (cl:make-instance 'openpilot_bridge-msg:GPSPlannerPoints))
   (sensorEvents
    :reader sensorEvents
    :initarg :sensorEvents
    :type (cl:vector openpilot_bridge-msg:SensorEventData)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:SensorEventData :initial-element (cl:make-instance 'openpilot_bridge-msg:SensorEventData)))
   (controlsState
    :reader controlsState
    :initarg :controlsState
    :type openpilot_bridge-msg:ControlsState
    :initform (cl:make-instance 'openpilot_bridge-msg:ControlsState))
   (androidGnss
    :reader androidGnss
    :initarg :androidGnss
    :type openpilot_bridge-msg:AndroidGnss
    :initform (cl:make-instance 'openpilot_bridge-msg:AndroidGnss))
   (applanixRaw
    :reader applanixRaw
    :initarg :applanixRaw
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (ethernetData
    :reader ethernetData
    :initarg :ethernetData
    :type (cl:vector openpilot_bridge-msg:EthernetPacket)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:EthernetPacket :initial-element (cl:make-instance 'openpilot_bridge-msg:EthernetPacket)))
   (ubloxRaw
    :reader ubloxRaw
    :initarg :ubloxRaw
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (liveLocationCorrected
    :reader liveLocationCorrected
    :initarg :liveLocationCorrected
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (boot
    :reader boot
    :initarg :boot
    :type openpilot_bridge-msg:Boot
    :initform (cl:make-instance 'openpilot_bridge-msg:Boot))
   (trafficEvents
    :reader trafficEvents
    :initarg :trafficEvents
    :type (cl:vector openpilot_bridge-msg:TrafficEvent)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:TrafficEvent :initial-element (cl:make-instance 'openpilot_bridge-msg:TrafficEvent)))
   (valid
    :reader valid
    :initarg :valid
    :type cl:boolean
    :initform cl:nil)
   (health
    :reader health
    :initarg :health
    :type openpilot_bridge-msg:HealthData
    :initform (cl:make-instance 'openpilot_bridge-msg:HealthData))
   (liveCalibration
    :reader liveCalibration
    :initarg :liveCalibration
    :type openpilot_bridge-msg:LiveCalibrationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveCalibrationData))
   (logMonoTime
    :reader logMonoTime
    :initarg :logMonoTime
    :type cl:integer
    :initform 0)
   (wifiScan
    :reader wifiScan
    :initarg :wifiScan
    :type (cl:vector openpilot_bridge-msg:WifiScan)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:WifiScan :initial-element (cl:make-instance 'openpilot_bridge-msg:WifiScan)))
   (carState
    :reader carState
    :initarg :carState
    :type openpilot_bridge-msg:CarState
    :initform (cl:make-instance 'openpilot_bridge-msg:CarState))
   (thumbnail
    :reader thumbnail
    :initarg :thumbnail
    :type openpilot_bridge-msg:Thumbnail
    :initform (cl:make-instance 'openpilot_bridge-msg:Thumbnail))
   (navUpdate
    :reader navUpdate
    :initarg :navUpdate
    :type openpilot_bridge-msg:NavUpdate
    :initform (cl:make-instance 'openpilot_bridge-msg:NavUpdate))
   (orbKeyFrame
    :reader orbKeyFrame
    :initarg :orbKeyFrame
    :type openpilot_bridge-msg:OrbKeyFrame
    :initform (cl:make-instance 'openpilot_bridge-msg:OrbKeyFrame))
   (uiNavigationEvent
    :reader uiNavigationEvent
    :initarg :uiNavigationEvent
    :type openpilot_bridge-msg:UiNavigationEvent
    :initform (cl:make-instance 'openpilot_bridge-msg:UiNavigationEvent))
   (carControl
    :reader carControl
    :initarg :carControl
    :type openpilot_bridge-msg:CarControl
    :initform (cl:make-instance 'openpilot_bridge-msg:CarControl))
   (encodeIdx
    :reader encodeIdx
    :initarg :encodeIdx
    :type openpilot_bridge-msg:EncodeIndex
    :initform (cl:make-instance 'openpilot_bridge-msg:EncodeIndex))
   (driverMonitoring
    :reader driverMonitoring
    :initarg :driverMonitoring
    :type openpilot_bridge-msg:DriverMonitoring
    :initform (cl:make-instance 'openpilot_bridge-msg:DriverMonitoring))
   (initData
    :reader initData
    :initarg :initData
    :type openpilot_bridge-msg:InitData
    :initform (cl:make-instance 'openpilot_bridge-msg:InitData))
   (orbOdometry
    :reader orbOdometry
    :initarg :orbOdometry
    :type openpilot_bridge-msg:OrbOdometry
    :initform (cl:make-instance 'openpilot_bridge-msg:OrbOdometry))
   (testJoystick
    :reader testJoystick
    :initarg :testJoystick
    :type openpilot_bridge-msg:Joystick
    :initform (cl:make-instance 'openpilot_bridge-msg:Joystick))
   (liveMpc
    :reader liveMpc
    :initarg :liveMpc
    :type openpilot_bridge-msg:LiveMpcData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveMpcData))
   (sensorEventDEPRECATED
    :reader sensorEventDEPRECATED
    :initarg :sensorEventDEPRECATED
    :type openpilot_bridge-msg:SensorEventData
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorEventData))
   (plan
    :reader plan
    :initarg :plan
    :type openpilot_bridge-msg:Plan
    :initform (cl:make-instance 'openpilot_bridge-msg:Plan))
   (liveLocation
    :reader liveLocation
    :initarg :liveLocation
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (cellInfo
    :reader cellInfo
    :initarg :cellInfo
    :type (cl:vector openpilot_bridge-msg:CellInfo)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CellInfo :initial-element (cl:make-instance 'openpilot_bridge-msg:CellInfo)))
   (logMessage
    :reader logMessage
    :initarg :logMessage
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (navStatus
    :reader navStatus
    :initarg :navStatus
    :type openpilot_bridge-msg:NavStatus
    :initform (cl:make-instance 'openpilot_bridge-msg:NavStatus))
   (gpsLocation
    :reader gpsLocation
    :initarg :gpsLocation
    :type openpilot_bridge-msg:GpsLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:GpsLocationData))
   (liveEventDEPRECATED
    :reader liveEventDEPRECATED
    :initarg :liveEventDEPRECATED
    :type (cl:vector openpilot_bridge-msg:LiveEventData)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:LiveEventData :initial-element (cl:make-instance 'openpilot_bridge-msg:LiveEventData)))
   (orbFeaturesSummary
    :reader orbFeaturesSummary
    :initarg :orbFeaturesSummary
    :type openpilot_bridge-msg:OrbFeaturesSummary
    :initform (cl:make-instance 'openpilot_bridge-msg:OrbFeaturesSummary))
   (liveLocationTiming
    :reader liveLocationTiming
    :initarg :liveLocationTiming
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (ubloxGnss
    :reader ubloxGnss
    :initarg :ubloxGnss
    :type openpilot_bridge-msg:UbloxGnss
    :initform (cl:make-instance 'openpilot_bridge-msg:UbloxGnss))
   (kalmanOdometry
    :reader kalmanOdometry
    :initarg :kalmanOdometry
    :type openpilot_bridge-msg:KalmanOdometry
    :initform (cl:make-instance 'openpilot_bridge-msg:KalmanOdometry))
   (liveTracks
    :reader liveTracks
    :initarg :liveTracks
    :type (cl:vector openpilot_bridge-msg:LiveTracks)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:LiveTracks :initial-element (cl:make-instance 'openpilot_bridge-msg:LiveTracks)))
   (procLog
    :reader procLog
    :initarg :procLog
    :type openpilot_bridge-msg:ProcLog
    :initform (cl:make-instance 'openpilot_bridge-msg:ProcLog))
   (pathPlan
    :reader pathPlan
    :initarg :pathPlan
    :type openpilot_bridge-msg:PathPlan
    :initform (cl:make-instance 'openpilot_bridge-msg:PathPlan))
   (carParams
    :reader carParams
    :initarg :carParams
    :type openpilot_bridge-msg:CarParams
    :initform (cl:make-instance 'openpilot_bridge-msg:CarParams))
   (location
    :reader location
    :initarg :location
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (applanixLocation
    :reader applanixLocation
    :initarg :applanixLocation
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (gpsLocationExternal
    :reader gpsLocationExternal
    :initarg :gpsLocationExternal
    :type openpilot_bridge-msg:GpsLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:GpsLocationData))
   (can
    :reader can
    :initarg :can
    :type (cl:vector openpilot_bridge-msg:CanData)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CanData :initial-element (cl:make-instance 'openpilot_bridge-msg:CanData)))
   (gpsPlannerPlan
    :reader gpsPlannerPlan
    :initarg :gpsPlannerPlan
    :type openpilot_bridge-msg:GPSPlannerPlan
    :initform (cl:make-instance 'openpilot_bridge-msg:GPSPlannerPlan))
   (liveParameters
    :reader liveParameters
    :initarg :liveParameters
    :type openpilot_bridge-msg:LiveParametersData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveParametersData))
   (model
    :reader model
    :initarg :model
    :type openpilot_bridge-msg:ModelData
    :initform (cl:make-instance 'openpilot_bridge-msg:ModelData))
   (liveLongitudinalMpc
    :reader liveLongitudinalMpc
    :initarg :liveLongitudinalMpc
    :type openpilot_bridge-msg:LiveLongitudinalMpcData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLongitudinalMpcData))
   (liveLocationKalman
    :reader liveLocationKalman
    :initarg :liveLocationKalman
    :type openpilot_bridge-msg:LiveLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:LiveLocationData))
   (orbObservation
    :reader orbObservation
    :initarg :orbObservation
    :type (cl:vector openpilot_bridge-msg:OrbObservation)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:OrbObservation :initial-element (cl:make-instance 'openpilot_bridge-msg:OrbObservation))))
)

(cl:defclass Event (<Event>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Event>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Event)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Event> is deprecated: use openpilot_bridge-msg:Event instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lidarPts-val :lambda-list '(m))
(cl:defmethod lidarPts-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lidarPts-val is deprecated.  Use openpilot_bridge-msg:lidarPts instead.")
  (lidarPts m))

(cl:ensure-generic-function 'gpsNMEA-val :lambda-list '(m))
(cl:defmethod gpsNMEA-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsNMEA-val is deprecated.  Use openpilot_bridge-msg:gpsNMEA instead.")
  (gpsNMEA m))

(cl:ensure-generic-function 'androidLogEntry-val :lambda-list '(m))
(cl:defmethod androidLogEntry-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:androidLogEntry-val is deprecated.  Use openpilot_bridge-msg:androidLogEntry instead.")
  (androidLogEntry m))

(cl:ensure-generic-function 'features-val :lambda-list '(m))
(cl:defmethod features-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:features-val is deprecated.  Use openpilot_bridge-msg:features instead.")
  (features m))

(cl:ensure-generic-function 'liveMapData-val :lambda-list '(m))
(cl:defmethod liveMapData-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveMapData-val is deprecated.  Use openpilot_bridge-msg:liveMapData instead.")
  (liveMapData m))

(cl:ensure-generic-function 'orbFeatures-val :lambda-list '(m))
(cl:defmethod orbFeatures-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbFeatures-val is deprecated.  Use openpilot_bridge-msg:orbFeatures instead.")
  (orbFeatures m))

(cl:ensure-generic-function 'frame-val :lambda-list '(m))
(cl:defmethod frame-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frame-val is deprecated.  Use openpilot_bridge-msg:frame instead.")
  (frame m))

(cl:ensure-generic-function 'sendcan-val :lambda-list '(m))
(cl:defmethod sendcan-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sendcan-val is deprecated.  Use openpilot_bridge-msg:sendcan instead.")
  (sendcan m))

(cl:ensure-generic-function 'qcomGnss-val :lambda-list '(m))
(cl:defmethod qcomGnss-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:qcomGnss-val is deprecated.  Use openpilot_bridge-msg:qcomGnss instead.")
  (qcomGnss m))

(cl:ensure-generic-function 'frontFrame-val :lambda-list '(m))
(cl:defmethod frontFrame-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frontFrame-val is deprecated.  Use openpilot_bridge-msg:frontFrame instead.")
  (frontFrame m))

(cl:ensure-generic-function 'liveUIDEPRECATED-val :lambda-list '(m))
(cl:defmethod liveUIDEPRECATED-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveUIDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:liveUIDEPRECATED instead.")
  (liveUIDEPRECATED m))

(cl:ensure-generic-function 'carEvents-val :lambda-list '(m))
(cl:defmethod carEvents-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carEvents-val is deprecated.  Use openpilot_bridge-msg:carEvents instead.")
  (carEvents m))

(cl:ensure-generic-function 'radarState-val :lambda-list '(m))
(cl:defmethod radarState-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarState-val is deprecated.  Use openpilot_bridge-msg:radarState instead.")
  (radarState m))

(cl:ensure-generic-function 'thermal-val :lambda-list '(m))
(cl:defmethod thermal-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:thermal-val is deprecated.  Use openpilot_bridge-msg:thermal instead.")
  (thermal m))

(cl:ensure-generic-function 'clocks-val :lambda-list '(m))
(cl:defmethod clocks-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clocks-val is deprecated.  Use openpilot_bridge-msg:clocks instead.")
  (clocks m))

(cl:ensure-generic-function 'uiLayoutState-val :lambda-list '(m))
(cl:defmethod uiLayoutState-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uiLayoutState-val is deprecated.  Use openpilot_bridge-msg:uiLayoutState instead.")
  (uiLayoutState m))

(cl:ensure-generic-function 'orbslamCorrectionDEPRECATED-val :lambda-list '(m))
(cl:defmethod orbslamCorrectionDEPRECATED-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbslamCorrectionDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:orbslamCorrectionDEPRECATED instead.")
  (orbslamCorrectionDEPRECATED m))

(cl:ensure-generic-function 'cameraOdometry-val :lambda-list '(m))
(cl:defmethod cameraOdometry-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cameraOdometry-val is deprecated.  Use openpilot_bridge-msg:cameraOdometry instead.")
  (cameraOdometry m))

(cl:ensure-generic-function 'gpsPlannerPoints-val :lambda-list '(m))
(cl:defmethod gpsPlannerPoints-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsPlannerPoints-val is deprecated.  Use openpilot_bridge-msg:gpsPlannerPoints instead.")
  (gpsPlannerPoints m))

(cl:ensure-generic-function 'sensorEvents-val :lambda-list '(m))
(cl:defmethod sensorEvents-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensorEvents-val is deprecated.  Use openpilot_bridge-msg:sensorEvents instead.")
  (sensorEvents m))

(cl:ensure-generic-function 'controlsState-val :lambda-list '(m))
(cl:defmethod controlsState-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:controlsState-val is deprecated.  Use openpilot_bridge-msg:controlsState instead.")
  (controlsState m))

(cl:ensure-generic-function 'androidGnss-val :lambda-list '(m))
(cl:defmethod androidGnss-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:androidGnss-val is deprecated.  Use openpilot_bridge-msg:androidGnss instead.")
  (androidGnss m))

(cl:ensure-generic-function 'applanixRaw-val :lambda-list '(m))
(cl:defmethod applanixRaw-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:applanixRaw-val is deprecated.  Use openpilot_bridge-msg:applanixRaw instead.")
  (applanixRaw m))

(cl:ensure-generic-function 'ethernetData-val :lambda-list '(m))
(cl:defmethod ethernetData-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ethernetData-val is deprecated.  Use openpilot_bridge-msg:ethernetData instead.")
  (ethernetData m))

(cl:ensure-generic-function 'ubloxRaw-val :lambda-list '(m))
(cl:defmethod ubloxRaw-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ubloxRaw-val is deprecated.  Use openpilot_bridge-msg:ubloxRaw instead.")
  (ubloxRaw m))

(cl:ensure-generic-function 'liveLocationCorrected-val :lambda-list '(m))
(cl:defmethod liveLocationCorrected-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveLocationCorrected-val is deprecated.  Use openpilot_bridge-msg:liveLocationCorrected instead.")
  (liveLocationCorrected m))

(cl:ensure-generic-function 'boot-val :lambda-list '(m))
(cl:defmethod boot-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:boot-val is deprecated.  Use openpilot_bridge-msg:boot instead.")
  (boot m))

(cl:ensure-generic-function 'trafficEvents-val :lambda-list '(m))
(cl:defmethod trafficEvents-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:trafficEvents-val is deprecated.  Use openpilot_bridge-msg:trafficEvents instead.")
  (trafficEvents m))

(cl:ensure-generic-function 'valid-val :lambda-list '(m))
(cl:defmethod valid-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:valid-val is deprecated.  Use openpilot_bridge-msg:valid instead.")
  (valid m))

(cl:ensure-generic-function 'health-val :lambda-list '(m))
(cl:defmethod health-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:health-val is deprecated.  Use openpilot_bridge-msg:health instead.")
  (health m))

(cl:ensure-generic-function 'liveCalibration-val :lambda-list '(m))
(cl:defmethod liveCalibration-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveCalibration-val is deprecated.  Use openpilot_bridge-msg:liveCalibration instead.")
  (liveCalibration m))

(cl:ensure-generic-function 'logMonoTime-val :lambda-list '(m))
(cl:defmethod logMonoTime-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:logMonoTime-val is deprecated.  Use openpilot_bridge-msg:logMonoTime instead.")
  (logMonoTime m))

(cl:ensure-generic-function 'wifiScan-val :lambda-list '(m))
(cl:defmethod wifiScan-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:wifiScan-val is deprecated.  Use openpilot_bridge-msg:wifiScan instead.")
  (wifiScan m))

(cl:ensure-generic-function 'carState-val :lambda-list '(m))
(cl:defmethod carState-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carState-val is deprecated.  Use openpilot_bridge-msg:carState instead.")
  (carState m))

(cl:ensure-generic-function 'thumbnail-val :lambda-list '(m))
(cl:defmethod thumbnail-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:thumbnail-val is deprecated.  Use openpilot_bridge-msg:thumbnail instead.")
  (thumbnail m))

(cl:ensure-generic-function 'navUpdate-val :lambda-list '(m))
(cl:defmethod navUpdate-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:navUpdate-val is deprecated.  Use openpilot_bridge-msg:navUpdate instead.")
  (navUpdate m))

(cl:ensure-generic-function 'orbKeyFrame-val :lambda-list '(m))
(cl:defmethod orbKeyFrame-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbKeyFrame-val is deprecated.  Use openpilot_bridge-msg:orbKeyFrame instead.")
  (orbKeyFrame m))

(cl:ensure-generic-function 'uiNavigationEvent-val :lambda-list '(m))
(cl:defmethod uiNavigationEvent-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uiNavigationEvent-val is deprecated.  Use openpilot_bridge-msg:uiNavigationEvent instead.")
  (uiNavigationEvent m))

(cl:ensure-generic-function 'carControl-val :lambda-list '(m))
(cl:defmethod carControl-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carControl-val is deprecated.  Use openpilot_bridge-msg:carControl instead.")
  (carControl m))

(cl:ensure-generic-function 'encodeIdx-val :lambda-list '(m))
(cl:defmethod encodeIdx-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:encodeIdx-val is deprecated.  Use openpilot_bridge-msg:encodeIdx instead.")
  (encodeIdx m))

(cl:ensure-generic-function 'driverMonitoring-val :lambda-list '(m))
(cl:defmethod driverMonitoring-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:driverMonitoring-val is deprecated.  Use openpilot_bridge-msg:driverMonitoring instead.")
  (driverMonitoring m))

(cl:ensure-generic-function 'initData-val :lambda-list '(m))
(cl:defmethod initData-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:initData-val is deprecated.  Use openpilot_bridge-msg:initData instead.")
  (initData m))

(cl:ensure-generic-function 'orbOdometry-val :lambda-list '(m))
(cl:defmethod orbOdometry-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbOdometry-val is deprecated.  Use openpilot_bridge-msg:orbOdometry instead.")
  (orbOdometry m))

(cl:ensure-generic-function 'testJoystick-val :lambda-list '(m))
(cl:defmethod testJoystick-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:testJoystick-val is deprecated.  Use openpilot_bridge-msg:testJoystick instead.")
  (testJoystick m))

(cl:ensure-generic-function 'liveMpc-val :lambda-list '(m))
(cl:defmethod liveMpc-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveMpc-val is deprecated.  Use openpilot_bridge-msg:liveMpc instead.")
  (liveMpc m))

(cl:ensure-generic-function 'sensorEventDEPRECATED-val :lambda-list '(m))
(cl:defmethod sensorEventDEPRECATED-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensorEventDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:sensorEventDEPRECATED instead.")
  (sensorEventDEPRECATED m))

(cl:ensure-generic-function 'plan-val :lambda-list '(m))
(cl:defmethod plan-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:plan-val is deprecated.  Use openpilot_bridge-msg:plan instead.")
  (plan m))

(cl:ensure-generic-function 'liveLocation-val :lambda-list '(m))
(cl:defmethod liveLocation-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveLocation-val is deprecated.  Use openpilot_bridge-msg:liveLocation instead.")
  (liveLocation m))

(cl:ensure-generic-function 'cellInfo-val :lambda-list '(m))
(cl:defmethod cellInfo-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cellInfo-val is deprecated.  Use openpilot_bridge-msg:cellInfo instead.")
  (cellInfo m))

(cl:ensure-generic-function 'logMessage-val :lambda-list '(m))
(cl:defmethod logMessage-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:logMessage-val is deprecated.  Use openpilot_bridge-msg:logMessage instead.")
  (logMessage m))

(cl:ensure-generic-function 'navStatus-val :lambda-list '(m))
(cl:defmethod navStatus-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:navStatus-val is deprecated.  Use openpilot_bridge-msg:navStatus instead.")
  (navStatus m))

(cl:ensure-generic-function 'gpsLocation-val :lambda-list '(m))
(cl:defmethod gpsLocation-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLocation-val is deprecated.  Use openpilot_bridge-msg:gpsLocation instead.")
  (gpsLocation m))

(cl:ensure-generic-function 'liveEventDEPRECATED-val :lambda-list '(m))
(cl:defmethod liveEventDEPRECATED-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveEventDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:liveEventDEPRECATED instead.")
  (liveEventDEPRECATED m))

(cl:ensure-generic-function 'orbFeaturesSummary-val :lambda-list '(m))
(cl:defmethod orbFeaturesSummary-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbFeaturesSummary-val is deprecated.  Use openpilot_bridge-msg:orbFeaturesSummary instead.")
  (orbFeaturesSummary m))

(cl:ensure-generic-function 'liveLocationTiming-val :lambda-list '(m))
(cl:defmethod liveLocationTiming-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveLocationTiming-val is deprecated.  Use openpilot_bridge-msg:liveLocationTiming instead.")
  (liveLocationTiming m))

(cl:ensure-generic-function 'ubloxGnss-val :lambda-list '(m))
(cl:defmethod ubloxGnss-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ubloxGnss-val is deprecated.  Use openpilot_bridge-msg:ubloxGnss instead.")
  (ubloxGnss m))

(cl:ensure-generic-function 'kalmanOdometry-val :lambda-list '(m))
(cl:defmethod kalmanOdometry-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:kalmanOdometry-val is deprecated.  Use openpilot_bridge-msg:kalmanOdometry instead.")
  (kalmanOdometry m))

(cl:ensure-generic-function 'liveTracks-val :lambda-list '(m))
(cl:defmethod liveTracks-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveTracks-val is deprecated.  Use openpilot_bridge-msg:liveTracks instead.")
  (liveTracks m))

(cl:ensure-generic-function 'procLog-val :lambda-list '(m))
(cl:defmethod procLog-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:procLog-val is deprecated.  Use openpilot_bridge-msg:procLog instead.")
  (procLog m))

(cl:ensure-generic-function 'pathPlan-val :lambda-list '(m))
(cl:defmethod pathPlan-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pathPlan-val is deprecated.  Use openpilot_bridge-msg:pathPlan instead.")
  (pathPlan m))

(cl:ensure-generic-function 'carParams-val :lambda-list '(m))
(cl:defmethod carParams-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carParams-val is deprecated.  Use openpilot_bridge-msg:carParams instead.")
  (carParams m))

(cl:ensure-generic-function 'location-val :lambda-list '(m))
(cl:defmethod location-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:location-val is deprecated.  Use openpilot_bridge-msg:location instead.")
  (location m))

(cl:ensure-generic-function 'applanixLocation-val :lambda-list '(m))
(cl:defmethod applanixLocation-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:applanixLocation-val is deprecated.  Use openpilot_bridge-msg:applanixLocation instead.")
  (applanixLocation m))

(cl:ensure-generic-function 'gpsLocationExternal-val :lambda-list '(m))
(cl:defmethod gpsLocationExternal-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLocationExternal-val is deprecated.  Use openpilot_bridge-msg:gpsLocationExternal instead.")
  (gpsLocationExternal m))

(cl:ensure-generic-function 'can-val :lambda-list '(m))
(cl:defmethod can-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:can-val is deprecated.  Use openpilot_bridge-msg:can instead.")
  (can m))

(cl:ensure-generic-function 'gpsPlannerPlan-val :lambda-list '(m))
(cl:defmethod gpsPlannerPlan-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsPlannerPlan-val is deprecated.  Use openpilot_bridge-msg:gpsPlannerPlan instead.")
  (gpsPlannerPlan m))

(cl:ensure-generic-function 'liveParameters-val :lambda-list '(m))
(cl:defmethod liveParameters-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveParameters-val is deprecated.  Use openpilot_bridge-msg:liveParameters instead.")
  (liveParameters m))

(cl:ensure-generic-function 'model-val :lambda-list '(m))
(cl:defmethod model-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:model-val is deprecated.  Use openpilot_bridge-msg:model instead.")
  (model m))

(cl:ensure-generic-function 'liveLongitudinalMpc-val :lambda-list '(m))
(cl:defmethod liveLongitudinalMpc-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveLongitudinalMpc-val is deprecated.  Use openpilot_bridge-msg:liveLongitudinalMpc instead.")
  (liveLongitudinalMpc m))

(cl:ensure-generic-function 'liveLocationKalman-val :lambda-list '(m))
(cl:defmethod liveLocationKalman-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveLocationKalman-val is deprecated.  Use openpilot_bridge-msg:liveLocationKalman instead.")
  (liveLocationKalman m))

(cl:ensure-generic-function 'orbObservation-val :lambda-list '(m))
(cl:defmethod orbObservation-val ((m <Event>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orbObservation-val is deprecated.  Use openpilot_bridge-msg:orbObservation instead.")
  (orbObservation m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Event>) ostream)
  "Serializes a message object of type '<Event>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lidarPts) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsNMEA) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'androidLogEntry) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'features) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveMapData) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orbFeatures) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frame) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sendcan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'sendcan))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'qcomGnss) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frontFrame) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveUIDEPRECATED) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carEvents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'carEvents))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'radarState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'thermal) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'clocks) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'uiLayoutState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orbslamCorrectionDEPRECATED) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cameraOdometry) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsPlannerPoints) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sensorEvents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'sensorEvents))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'controlsState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'androidGnss) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'applanixRaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'applanixRaw))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ethernetData))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ethernetData))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ubloxRaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'ubloxRaw))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveLocationCorrected) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'boot) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'trafficEvents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'trafficEvents))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'valid) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'health) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveCalibration) ostream)
  (cl:let* ((signed (cl:slot-value msg 'logMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'wifiScan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'wifiScan))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'carState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'thumbnail) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'navUpdate) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orbKeyFrame) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'uiNavigationEvent) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'carControl) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'encodeIdx) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'driverMonitoring) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'initData) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orbOdometry) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'testJoystick) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveMpc) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'sensorEventDEPRECATED) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'plan) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveLocation) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cellInfo))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'cellInfo))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'logMessage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'logMessage))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'navStatus) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsLocation) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'liveEventDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'liveEventDEPRECATED))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orbFeaturesSummary) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveLocationTiming) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ubloxGnss) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'kalmanOdometry) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'liveTracks))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'liveTracks))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'procLog) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pathPlan) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'carParams) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'location) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'applanixLocation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsLocationExternal) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'can))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'can))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsPlannerPlan) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveParameters) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'model) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveLongitudinalMpc) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liveLocationKalman) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'orbObservation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'orbObservation))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Event>) istream)
  "Deserializes a message object of type '<Event>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lidarPts) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsNMEA) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'androidLogEntry) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'features) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveMapData) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orbFeatures) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frame) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sendcan) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sendcan)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CanData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'qcomGnss) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frontFrame) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveUIDEPRECATED) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carEvents) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carEvents)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CarEvent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'radarState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'thermal) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'clocks) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'uiLayoutState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orbslamCorrectionDEPRECATED) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cameraOdometry) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsPlannerPoints) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sensorEvents) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sensorEvents)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:SensorEventData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'controlsState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'androidGnss) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'applanixRaw) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'applanixRaw)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ethernetData) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ethernetData)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:EthernetPacket))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ubloxRaw) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ubloxRaw)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveLocationCorrected) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'boot) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'trafficEvents) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'trafficEvents)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:TrafficEvent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'valid) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'health) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveCalibration) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'logMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'wifiScan) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'wifiScan)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:WifiScan))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'carState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'thumbnail) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'navUpdate) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orbKeyFrame) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'uiNavigationEvent) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'carControl) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'encodeIdx) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'driverMonitoring) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'initData) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orbOdometry) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'testJoystick) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveMpc) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'sensorEventDEPRECATED) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'plan) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveLocation) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cellInfo) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cellInfo)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CellInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'logMessage) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'logMessage)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'navStatus) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsLocation) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'liveEventDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'liveEventDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:LiveEventData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orbFeaturesSummary) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveLocationTiming) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ubloxGnss) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'kalmanOdometry) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'liveTracks) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'liveTracks)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:LiveTracks))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'procLog) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pathPlan) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'carParams) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'location) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'applanixLocation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsLocationExternal) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'can) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'can)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CanData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsPlannerPlan) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveParameters) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'model) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveLongitudinalMpc) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liveLocationKalman) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'orbObservation) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'orbObservation)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:OrbObservation))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Event>)))
  "Returns string type for a message object of type '<Event>"
  "openpilot_bridge/Event")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Event)))
  "Returns string type for a message object of type 'Event"
  "openpilot_bridge/Event")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Event>)))
  "Returns md5sum for a message object of type '<Event>"
  "2e5006338b7fd3709f95d9b5d9566d9c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Event)))
  "Returns md5sum for a message object of type 'Event"
  "2e5006338b7fd3709f95d9b5d9566d9c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Event>)))
  "Returns full string definition for message of type '<Event>"
  (cl:format cl:nil "Header header~%~%LidarPts lidarPts~%GPSNMEAData gpsNMEA~%AndroidLogEntry androidLogEntry~%CalibrationFeatures features~%LiveMapData liveMapData~%OrbFeatures orbFeatures~%FrameData frame~%CanData[] sendcan~%QcomGnss qcomGnss~%FrameData frontFrame~%LiveUI liveUIDEPRECATED~%CarEvent[] carEvents~%RadarState radarState~%ThermalData thermal~%Clocks clocks~%UiLayoutState uiLayoutState~%OrbslamCorrection orbslamCorrectionDEPRECATED~%CameraOdometry cameraOdometry~%GPSPlannerPoints gpsPlannerPoints~%SensorEventData[] sensorEvents~%ControlsState controlsState~%AndroidGnss androidGnss~%string[] applanixRaw~%EthernetPacket[] ethernetData~%string[] ubloxRaw~%LiveLocationData liveLocationCorrected~%Boot boot~%TrafficEvent[] trafficEvents~%bool valid~%HealthData health~%LiveCalibrationData liveCalibration~%int64 logMonoTime~%WifiScan[] wifiScan~%CarState carState~%Thumbnail thumbnail~%NavUpdate navUpdate~%OrbKeyFrame orbKeyFrame~%UiNavigationEvent uiNavigationEvent~%CarControl carControl~%EncodeIndex encodeIdx~%DriverMonitoring driverMonitoring~%InitData initData~%OrbOdometry orbOdometry~%Joystick testJoystick~%LiveMpcData liveMpc~%SensorEventData sensorEventDEPRECATED~%Plan plan~%LiveLocationData liveLocation~%CellInfo[] cellInfo~%string[] logMessage~%NavStatus navStatus~%GpsLocationData gpsLocation~%LiveEventData[] liveEventDEPRECATED~%OrbFeaturesSummary orbFeaturesSummary~%LiveLocationData liveLocationTiming~%UbloxGnss ubloxGnss~%KalmanOdometry kalmanOdometry~%LiveTracks[] liveTracks~%ProcLog procLog~%PathPlan pathPlan~%CarParams carParams~%LiveLocationData location~%LiveLocationData applanixLocation~%GpsLocationData gpsLocationExternal~%CanData[] can~%GPSPlannerPlan gpsPlannerPlan~%LiveParametersData liveParameters~%ModelData model~%LiveLongitudinalMpcData liveLongitudinalMpc~%LiveLocationData liveLocationKalman~%OrbObservation[] orbObservation~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LidarPts~%Header header~%~%int64[] reflect~%int64[] theta~%int64[] r~%string[] pkt~%int64 idx~%~%================================================================================~%MSG: openpilot_bridge/GPSNMEAData~%Header header~%~%int32 timestamp~%string[] nmea~%int64 localWallTime~%~%================================================================================~%MSG: openpilot_bridge/AndroidLogEntry~%Header header~%~%int32 pid~%int64 ts~%int64 priority~%string[] tag~%int32 tid~%string[] message~%int64 id~%~%================================================================================~%MSG: openpilot_bridge/CalibrationFeatures~%Header header~%~%int32[] status~%float32[] p0~%float32[] p1~%int64 frameId~%~%================================================================================~%MSG: openpilot_bridge/LiveMapData~%Header header~%~%float32[] roadCurvatureX~%int64 wayId~%bool speedLimitValid~%float32 distToTurn~%float32 curvature~%float32[] roadCurvature~%bool mapValid~%float32[] roadY~%float32[] roadX~%float32 speedLimitAheadDistance~%bool curvatureValid~%bool speedLimitAheadValid~%bool speedAdvisoryValid~%float32 speedLimit~%float32 speedAdvisory~%GpsLocationData lastGps~%float32 speedLimitAhead~%~%================================================================================~%MSG: openpilot_bridge/GpsLocationData~%Header header~%~%float32 bearing~%float32[] vNED~%int32 timestamp~%float32 altitude~%float32 longitude~%uint32 source # enum const: SensorSource~%float32 speedAccuracy~%int64 flags~%float32 latitude~%float32 bearingAccuracy~%float32 speed~%float32 verticalAccuracy~%float32 accuracy~%~%================================================================================~%MSG: openpilot_bridge/OrbFeatures~%Header header~%~%int32[] octaves~%int32[] matches~%string[] descriptors~%int64 timestampEof~%int64 timestampLastEof~%float32[] xs~%float32[] ys~%~%================================================================================~%MSG: openpilot_bridge/FrameData~%Header header~%~%int32 integLines~%int32 frameLength~%int64 timestampSof~%float32 lensTruePos~%int64 timestampEof~%float32[] transform~%int64 frameId~%int64 encodeId~%AndroidCaptureResult androidCaptureResult~%float32 gainFrac~%float32 lensSag~%int32 globalGain~%float32 lensErr~%string[] image~%uint32 frameType # enum const: FrameType~%int32 lensPos~%~%================================================================================~%MSG: openpilot_bridge/AndroidCaptureResult~%Header header~%~%int32 exposureTime~%int32 displayRotation~%float32[] colorCorrectionGains~%int32 sensitivity~%int64 rollingShutterSkew~%int32[] colorCorrectionTransform~%int32 frameDuration~%~%================================================================================~%MSG: openpilot_bridge/CanData~%Header header~%~%string[] dat~%int64 src~%int64 busTime~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/QcomGnss~%Header header~%~%string[] rawLog~%MeasurementReport measurementReport~%int64 logTs~%DrSvPolyReport drSvPoly~%ClockReport clockReport~%DrMeasurementReport drMeasurementReport~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/DrSvPolyReport~%Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: openpilot_bridge/ClockReport~%Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/DrMeasurementReport~%Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%================================================================================~%MSG: openpilot_bridge/LiveUI~%Header header~%~%bool rearViewCam~%float32 awarenessStatus~%string[] alertText2~%string[] alertText1~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/RadarState~%Header header~%~%float32[] warpMatrixDEPRECATED~%int32 calCycleDEPRECATED~%int32 calStatusDEPRECATED~%int64 mdMonoTime~%LeadData leadTwo~%int32 calPercDEPRECATED~%uint32[] radarErrors # enum const: Error~%float32 cumLagMs~%int64[] canMonoTimes~%float32 angleOffsetDEPRECATED~%int64 ftMonoTimeDEPRECATED~%LeadData leadOne~%int64 controlsStateMonoTime~%RadarPoint[] radarPoints~%LiveTracks[] liveTracks~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/RadarPoint~%Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: openpilot_bridge/LiveTracks~%Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%================================================================================~%MSG: openpilot_bridge/ThermalData~%Header header~%~%int32 batteryVoltage~%bool chargingError~%int32 cpuPerc~%bool chargingDisabled~%int64 fanSpeed~%int32 batteryCurrent~%bool started~%int64 pa0~%int32 batteryPercent~%int64 gpu~%uint32 thermalStatus # enum const: ThermalStatus~%float32 freeSpace~%bool usbOnline~%int64 mem~%int64 cpu2~%int64 cpu3~%int64 cpu0~%int64 cpu1~%int64 startedTs~%string[] batteryStatus~%int32 memUsedPercent~%int64 bat~%~%================================================================================~%MSG: openpilot_bridge/Clocks~%Header header~%~%int64 modemUptimeMillis~%int64 wallTimeNanos~%int64 bootTimeNanos~%int64 monotonicRawNanos~%int64 monotonicNanos~%~%================================================================================~%MSG: openpilot_bridge/UiLayoutState~%Header header~%~%uint32 activeApp # enum const: App~%bool mapEnabled~%bool sidebarCollapsed~%~%================================================================================~%MSG: openpilot_bridge/OrbslamCorrection~%Header header~%~%int64 correctionMonoTime~%float32[] prePositionECEF~%float32[] postPositionECEF~%float32[] postPoseQuatECEF~%int64 numInliers~%float32[] prePoseQuatECEF~%~%================================================================================~%MSG: openpilot_bridge/CameraOdometry~%Header header~%~%float32[] transStd~%int64 timestampEof~%int64 frameId~%float32[] rotStd~%float32[] trans~%float32[] rot~%~%================================================================================~%MSG: openpilot_bridge/GPSPlannerPoints~%Header header~%~%float32 accelTarget~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%ECEFPoint curPos~%bool valid~%float32 speedLimit~%ECEFPointDEPRECATED curPosDEPRECATED~%ECEFPoint[] points~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/SensorEventData~%Header header~%~%SensorVec acceleration~%SensorVec gyroUncalibrated~%float32 light~%SensorVec orientation~%SensorVec pressure~%int32 sensor~%SensorVec magnetic~%SensorVec magneticUncalibrated~%uint32 source # enum const: SensorSource~%SensorVec gyro~%int32 version~%int32 timestamp~%int32 type~%float32 proximity~%bool uncalibratedDEPRECATED~%~%================================================================================~%MSG: openpilot_bridge/SensorVec~%Header header~%~%int32 status~%float32[] v~%~%================================================================================~%MSG: openpilot_bridge/ControlsState~%Header header~%~%float32 ufSteerDEPRECATED~%float32 angleSteersDes~%bool decelForTurn~%bool steerOverride~%bool rearViewCam~%int64 canErrorCounter~%Lateralcontrolstate lateralControlState~%float32 vEgoRaw~%bool forceDecel~%uint32 alertSound # enum const: AudibleAlert~%float32 upSteerDEPRECATED~%float32 vEgo~%float32 angleSteers~%float32 jerkFactor~%string[] alertType~%float32 aTarget~%uint32 alertStatus # enum const: AlertStatus~%uint32 alertSize # enum const: AlertSize~%int64 planMonoTime~%float32 aTargetMaxDEPRECATED~%float32 uiAccelCmd~%uint32 state # enum const: OpenpilotState~%float32 alertBlinkingRate~%float32 angleModelBiasDEPRECATED~%string[] alertText2~%string[] alertText1~%float32 yDesDEPRECATED~%float32 vPid~%float32 vTargetLead~%bool decelForModel~%bool gpsPlannerActive~%int64 startMonoTime~%int64 canMonoTimeDEPRECATED~%float32 curvature~%float32 upAccelCmd~%float32 vCurvature~%int32 hudLeadDEPRECATED~%bool active~%float32 awarenessStatus~%float32 uiSteerDEPRECATED~%float32 aEgoDEPRECATED~%string[] alertSoundDEPRECATED~%float32 ufAccelCmd~%float32 vCruise~%float32 yActualDEPRECATED~%bool enabled~%float32 aTargetMinDEPRECATED~%float32 cumLagMs~%bool mapValid~%int64 pathPlanMonoTime~%bool engageable~%int64 mdMonoTimeDEPRECATED~%bool driverMonitoringOn~%int64[] canMonoTimes~%int64 radarStateMonoTimeDEPRECATED~%uint32 longControlState # enum const: LongControlState~%~%================================================================================~%MSG: openpilot_bridge/Lateralcontrolstate~%Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/AndroidGnss~%Header header~%~%NavigationMessage navigationMessage~%Measurements measurements~%~%================================================================================~%MSG: openpilot_bridge/NavigationMessage~%Header header~%~%uint32 status # enum const: Status~%string[] data~%int32 svId~%int32 messageId~%int32 submessageId~%int32 type~%~%================================================================================~%MSG: openpilot_bridge/Measurements~%Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%================================================================================~%MSG: openpilot_bridge/EthernetPacket~%Header header~%~%float32 ts~%string[] pkt~%~%================================================================================~%MSG: openpilot_bridge/LiveLocationData~%Header header~%~%float32 pitch~%float32[] positionECEF~%float32 alt~%float32 speed~%float32 lon~%uint32 source # enum const: SensorSource~%float32 roll~%Accuracy accuracy~%int64 status~%float32 yawCalibration~%float32[] vNED~%float32[] accel~%int64 fixMonoTime~%float32 lat~%float32[] imuFrame~%float32 pitchCalibration~%float32[] gyro~%float32 timeOfWeek~%float32[] poseQuatECEF~%int32 gpsWeek~%float32 trackAngle~%float32 heading~%float32 wanderAngle~%~%================================================================================~%MSG: openpilot_bridge/Accuracy~%Header header~%~%float32[] vNEDError~%float32 rollError~%float32 headingError~%float32 ellipsoidSemiMajorError~%float32 ellipsoidOrientationError~%float32[] pNEDError~%float32 ellipsoidSemiMinorError~%float32 pitchError~%~%================================================================================~%MSG: openpilot_bridge/Boot~%Header header~%~%int64 wallTimeNanos~%string[] lastKmsg~%string[] lastPmsg~%~%================================================================================~%MSG: openpilot_bridge/TrafficEvent~%Header header~%~%uint32 action # enum const: Action~%float32 distance~%uint32 type # enum const: Type~%bool resuming~%~%================================================================================~%MSG: openpilot_bridge/HealthData~%Header header~%~%bool gasInterceptorDetected~%uint32 faultStatus # enum const: FaultStatus~%bool hasGps~%int64 fanSpeedRpm~%bool startedSignalDetectedDeprecated~%int64 canRxErrs~%uint32[] faults # enum const: FaultType~%int64 canFwdErrs~%int64 uptime~%bool powerSaveEnabled~%int64 current~%uint32 hwType # enum const: HwType~%bool ignitionCan~%int64 voltage~%int64 canSendErrs~%uint32 usbPowerMode # enum const: UsbPowerMode~%int64 gmlanSendErrs~%bool ignitionLine~%uint32 safetyModel # enum const: SafetyModel~%bool controlsAllowed~%~%================================================================================~%MSG: openpilot_bridge/LiveCalibrationData~%Header header~%~%float32[] warpMatrix2~%float32[] warpMatrix~%float32[] rpyCalib~%float32[] warpMatrixBig~%int32 calCycle~%float32[] extrinsicMatrix~%int32 calPerc~%int32 calStatus~%~%================================================================================~%MSG: openpilot_bridge/WifiScan~%Header header~%~%bool is80211mcResponder~%string[] operatorFriendlyName~%uint32 channelWidth # enum const: ChannelWidth~%int32 distanceSdCm~%string[] ssid~%string[] bssid~%int32 level~%int32 timestamp~%string[] capabilities~%int32 distanceCm~%int32 centerFreq0~%int32 centerFreq1~%int32 frequency~%bool passpoint~%string[] venueName~%~%================================================================================~%MSG: openpilot_bridge/CarState~%Header header~%~%uint32 gearShifter # enum const: GearShifter~%bool seatbeltUnlatched~%bool clutchPressed~%float32 vEgoRaw~%uint32[] errorsDEPRECATED # enum const: EventName~%float32 brake~%float32 vEgo~%float32 steeringAngle~%bool leftBlinker~%WheelSpeeds wheelSpeeds~%bool steeringRateLimited~%bool stockFcw~%bool doorOpen~%float32 steeringRate~%CarEvent[] events~%bool steeringPressed~%bool canValid~%CruiseState cruiseState~%float32 yawRate~%float32 steeringTorqueEps~%float32 gas~%float32 steeringTorque~%bool genericToggle~%bool brakeLights~%ButtonEvent[] buttonEvents~%bool standstill~%bool gasPressed~%bool stockAeb~%bool rightBlinker~%bool brakePressed~%float32 aEgo~%int64[] canMonoTimes~%~%================================================================================~%MSG: openpilot_bridge/WheelSpeeds~%Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: openpilot_bridge/CruiseState~%Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: openpilot_bridge/ButtonEvent~%Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%================================================================================~%MSG: openpilot_bridge/Thumbnail~%Header header~%~%int64 timestampEof~%string[] thumbnail~%int64 frameId~%~%================================================================================~%MSG: openpilot_bridge/NavUpdate~%Header header~%~%bool isNavigating~%Segment[] segments~%int32 curSegment~%~%================================================================================~%MSG: openpilot_bridge/Segment~%Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%================================================================================~%MSG: openpilot_bridge/OrbKeyFrame~%Header header~%~%string[] descriptors~%int64 id~%ECEFPoint[] dpos~%ECEFPoint pos~%~%================================================================================~%MSG: openpilot_bridge/UiNavigationEvent~%Header header~%~%uint32 status # enum const: Status~%float32 distanceTo~%uint32 type # enum const: Type~%ECEFPointDEPRECATED endRoadPointDEPRECATED~%ECEFPoint endRoadPoint~%~%================================================================================~%MSG: openpilot_bridge/CarControl~%Header header~%~%float32 brakeDEPRECATED~%float32 gasDEPRECATED~%float32 steeringTorqueDEPRECATED~%CruiseControl cruiseControl~%Actuators actuators~%bool active~%HUDControl hudControl~%bool enabled~%~%================================================================================~%MSG: openpilot_bridge/CruiseControl~%Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: openpilot_bridge/Actuators~%Header header~%~%float32 brake~%float32 gas~%float32 steerAngle~%float32 steer~%~%================================================================================~%MSG: openpilot_bridge/HUDControl~%Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%================================================================================~%MSG: openpilot_bridge/EncodeIndex~%Header header~%~%int64 segmentId~%int64 segmentIdEncode~%int64 frameId~%int64 encodeId~%uint32 type # enum const: Type~%int32 segmentNum~%~%================================================================================~%MSG: openpilot_bridge/DriverMonitoring~%Header header~%~%float32[] faceOrientation~%float32 stdDEPRECATED~%float32 irPwrDEPRECATED~%float32[] faceOrientationStd~%float32 faceProb~%int64 frameId~%float32[] descriptorDEPRECATED~%float32 rightBlinkProb~%float32 rightEyeProb~%float32[] facePositionStd~%float32 leftBlinkProb~%float32 leftEyeProb~%float32[] facePosition~%~%================================================================================~%MSG: openpilot_bridge/InitData~%Header header~%~%string[] kernelVersion~%ChffrAndroidExtra chffrAndroidExtra~%Map androidProperties~%AndroidSensor[] androidSensors~%PandaInfo pandaInfo~%IosBuildInfo iosBuildInfo~%string[] gitRemote~%AndroidBuildInfo androidBuildInfo~%bool passive~%Map params~%string[] version~%uint32 deviceType # enum const: DeviceType~%string[] kernelArgs~%string[] gitCommit~%string[] gitBranch~%string[] dongleId~%string[] gctx~%bool dirty~%~%================================================================================~%MSG: openpilot_bridge/ChffrAndroidExtra~%Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%================================================================================~%MSG: openpilot_bridge/AndroidSensor~%Header header~%~%float32 maxRange~%string[] stringType~%int32 maxDelay~%int32 handle~%string[] name~%float32 power~%int32 minDelay~%float32 resolution~%int64 fifoMaxEventCount~%int32 version~%int64 fifoReservedEventCount~%string[] vendor~%int32 type~%int32 id~%~%================================================================================~%MSG: openpilot_bridge/PandaInfo~%Header header~%~%bool hasPanda~%string[] stVersion~%string[] dongleId~%string[] espVersion~%~%================================================================================~%MSG: openpilot_bridge/IosBuildInfo~%Header header~%~%int64 appBuild~%string[] appVersion~%string[] osVersion~%string[] deviceModel~%~%================================================================================~%MSG: openpilot_bridge/AndroidBuildInfo~%Header header~%~%string[] radioVersion~%string[] versionCodename~%string[] hardware~%string[] versionSecurityPatch~%string[] supportedAbis~%string[] id~%string[] board~%string[] type~%string[] product~%string[] tags~%string[] brand~%string[] host~%string[] user~%string[] fingerprint~%string[] device~%string[] bootloader~%string[] model~%string[] serial~%string[] manufacturer~%string[] versionRelease~%int32 time~%int32 versionSdk~%string[] display~%~%================================================================================~%MSG: openpilot_bridge/OrbOdometry~%Header header~%~%int64 endMonoTime~%float32 err~%float32[] f~%int32[] matches~%int32 inliers~%int64 startMonoTime~%~%================================================================================~%MSG: openpilot_bridge/Joystick~%Header header~%~%bool[] buttons~%float32[] axes~%~%================================================================================~%MSG: openpilot_bridge/LiveMpcData~%Header header~%~%float32[] psi~%int64 qpIterations~%float32 cost~%float32[] delta~%float32[] y~%float32[] x~%int64 calculationTime~%~%================================================================================~%MSG: openpilot_bridge/Plan~%Header header~%~%bool decelForTurn~%float32 vTarget~%bool lateralValidDEPRECATED~%uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource~%bool hasLead~%int64 radarStateMonoTime~%float32 jerkFactor~%float32 vCurvature~%float32 aTarget~%int64 mdMonoTime~%float32 aTargetMaxDEPRECATED~%float32 laneWidthDEPRECATED~%bool radarValid~%bool gpsPlannerActive~%bool fcw~%float32 processingDelay~%bool longitudinalValidDEPRECATED~%float32 aStart~%CarEvent[] eventsDEPRECATED~%bool hasRightLaneDEPRECATED~%float32 vStart~%float32 aCruise~%bool commIssue~%float32 vTargetFuture~%GpsTrajectory gpsTrajectory~%bool hasLeftLaneDEPRECATED~%float32 vCruise~%float32 aTargetMinDEPRECATED~%bool mapValid~%bool radarCanError~%float32 vMax~%float32[] dPolyDEPRECATED~%~%================================================================================~%MSG: openpilot_bridge/GpsTrajectory~%Header header~%~%float32[] y~%float32[] x~%~%================================================================================~%MSG: openpilot_bridge/CellInfo~%Header header~%~%int64 timestamp~%string[] repr~%~%================================================================================~%MSG: openpilot_bridge/NavStatus~%Header header~%~%bool isNavigating~%Address currentAddress~%~%================================================================================~%MSG: openpilot_bridge/Address~%Header header~%~%string[] city~%string[] title~%string[] house~%string[] state~%string[] street~%string[] address~%float32 lat~%float32 lng~%string[] country~%~%================================================================================~%MSG: openpilot_bridge/LiveEventData~%Header header~%~%string[] name~%int32 value~%~%================================================================================~%MSG: openpilot_bridge/OrbFeaturesSummary~%Header header~%~%int64 timestampEof~%int64 featureCount~%int64 matchCount~%int64 timestampLastEof~%int64 computeNs~%~%================================================================================~%MSG: openpilot_bridge/UbloxGnss~%Header header~%~%IonoData ionoData~%MeasurementReport measurementReport~%Ephemeris ephemeris~%~%================================================================================~%MSG: openpilot_bridge/IonoData~%Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: openpilot_bridge/Ephemeris~%Header header~%~%float32 iodc~%float32 fitInterval~%int64 month~%float32 second~%float32 tgd~%int64 year~%float32 gpsWeek~%float32 cus~%bool ionoCoeffsValid~%int64 svId~%float32 svAcc~%float32 cuc~%float32 m0~%float32 toc~%float32 deltaN~%float32 toe~%float32 cic~%float32[] ionoBeta~%float32 ecc~%float32 iDot~%float32 i0~%float32 svHealth~%float32 codesL2~%float32 omega~%int64 day~%int64 minute~%float32 a~%float32 crs~%float32[] ionoAlpha~%int64 hour~%float32 iode~%float32 af1~%float32 cis~%float32 crc~%float32 l2~%float32 omegaDot~%float32 af0~%float32 omega0~%float32 af2~%float32 transmissionTime~%~%================================================================================~%MSG: openpilot_bridge/KalmanOdometry~%Header header~%~%float32[] rotStd~%float32[] transStd~%float32[] trans~%float32[] rot~%~%================================================================================~%MSG: openpilot_bridge/ProcLog~%Header header~%~%CPUTimes[] cpuTimes~%Mem mem~%Process[] procs~%~%================================================================================~%MSG: openpilot_bridge/CPUTimes~%Header header~%~%float32 softirq~%float32 iowait~%float32 system~%int32 cpuNum~%float32 idle~%float32 user~%float32 irq~%float32 nice~%~%================================================================================~%MSG: openpilot_bridge/Mem~%Header header~%~%int64 available~%int64 cached~%int64 free~%int64 inactive~%int64 active~%int64 shared~%int64 total~%int64 buffers~%~%================================================================================~%MSG: openpilot_bridge/Process~%Header header~%~%string[] exe~%string[] name~%string[] cmdline~%float32 cpuUser~%int32 numThreads~%int64 memRss~%int32 pid~%int64 memVms~%int32 priority~%float32 cpuSystem~%int64 state~%float32 startTime~%int32 nice~%float32 cpuChildrenUser~%int32 ppid~%int32 processor~%float32 cpuChildrenSystem~%~%================================================================================~%MSG: openpilot_bridge/PathPlan~%Header header~%~%float32 angleSteers~%bool commIssue~%float32[] lPoly~%uint32 laneChangeState # enum const: LaneChangeState~%bool sensorValid~%bool mpcSolutionValid~%float32 lProb~%bool modelValidDEPRECATED~%float32 rProb~%float32 cProb~%float32[] rPoly~%float32 laneWidth~%float32 angleOffset~%float32 rateSteers~%uint32 laneChangeDirection # enum const: LaneChangeDirection~%bool paramsValid~%float32[] cPoly~%bool posenetValid~%float32[] dPoly~%uint32 desire # enum const: Desire~%~%================================================================================~%MSG: openpilot_bridge/CarParams~%Header header~%~%int32 safetyParam~%float32 steerRatioRear~%bool enableDsu~%Lateraltuning lateralTuning~%uint32 steerControlType # enum const: SteerControlType~%string[] carFingerprint~%float32 rotationalInertia~%uint32 safetyModelPassive # enum const: SafetyModel~%CarFw[] carFw~%float32 minEnableSpeed~%bool enableGasInterceptor~%bool radarOffCan~%float32 steerRatio~%float32 vEgoStopping~%bool enableCamera~%bool enableCruise~%float32 tireStiffnessFront~%float32 minSteerSpeed~%bool stoppingControl~%float32 steerLimitTimer~%uint32 transmissionType # enum const: TransmissionType~%float32[] steerMaxV~%bool openpilotLongitudinalControl~%float32[] gasMaxBP~%bool enableApgs~%float32 radarTimeStep~%string[] carName~%uint32 safetyModel # enum const: SafetyModel~%string[] carVin~%float32[] steerMaxBP~%float32[] gasMaxV~%float32 steerRateCost~%float32[] brakeMaxV~%float32 tireStiffnessRear~%float32 centerToFront~%bool dashcamOnly~%float32 startAccel~%float32 wheelbase~%float32[] brakeMaxBP~%float32 mass~%float32 steerActuatorDelay~%LongitudinalPIDTuning longitudinalTuning~%bool directAccelControl~%bool communityFeature~%bool isPandaBlack~%bool steerLimitAlert~%~%================================================================================~%MSG: openpilot_bridge/Lateraltuning~%Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%================================================================================~%MSG: openpilot_bridge/CarFw~%Header header~%~%uint32 ecu # enum const: Ecu~%int64 subAddress~%string[] fwVersion~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalPIDTuning~%Header header~%~%float32[] kpV~%float32[] kpBP~%float32[] deadzoneBP~%float32[] kiV~%float32[] deadzoneV~%float32[] kiBP~%~%================================================================================~%MSG: openpilot_bridge/GPSPlannerPlan~%Header header~%~%float32 acceleration~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%float32[] poly~%float32 xLookahead~%bool valid~%float32 speed~%ECEFPoint[] points~%~%================================================================================~%MSG: openpilot_bridge/LiveParametersData~%Header header~%~%float32 steerRatio~%bool sensorValid~%float32 stiffnessFactor~%bool posenetValid~%float32 angleOffset~%float32 yawRate~%float32 gyroBias~%bool valid~%float32 posenetSpeed~%float32 angleOffsetAverage~%~%================================================================================~%MSG: openpilot_bridge/ModelData~%Header header~%~%LongitudinalData longitudinal~%LeadData leadFuture~%LeadData lead~%ModelSettings settings~%PathData leftLane~%int64 timestampEof~%int64 frameId~%PathData rightLane~%MetaData meta~%PathData path~%float32[] speed~%float32[] freePath~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalData~%Header header~%~%float32[] accelerations~%float32[] speeds~%~%================================================================================~%MSG: openpilot_bridge/ModelSettings~%Header header~%~%int64 bigBoxX~%int64 bigBoxY~%float32[] inputTransform~%int64 bigBoxHeight~%int64 bigBoxWidth~%float32[] boxProjection~%float32[] yuvCorrection~%~%================================================================================~%MSG: openpilot_bridge/PathData~%Header header~%~%float32 std~%float32[] poly~%float32[] points~%float32 prob~%float32[] stds~%~%================================================================================~%MSG: openpilot_bridge/MetaData~%Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%================================================================================~%MSG: openpilot_bridge/LiveLongitudinalMpcData~%Header header~%~%float32 aLeadTau~%float32[] vLead~%float32[] aLead~%float32[] xEgo~%float32[] xLead~%int64 mpcId~%float32 cost~%float32[] aEgo~%int64 calculationTime~%int64 qpIterations~%float32[] vEgo~%~%================================================================================~%MSG: openpilot_bridge/OrbObservation~%Header header~%~%int64 matchDistance~%float32[] locationECEF~%float32[] normalizedCoordinates~%int64 observationMonoTime~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Event)))
  "Returns full string definition for message of type 'Event"
  (cl:format cl:nil "Header header~%~%LidarPts lidarPts~%GPSNMEAData gpsNMEA~%AndroidLogEntry androidLogEntry~%CalibrationFeatures features~%LiveMapData liveMapData~%OrbFeatures orbFeatures~%FrameData frame~%CanData[] sendcan~%QcomGnss qcomGnss~%FrameData frontFrame~%LiveUI liveUIDEPRECATED~%CarEvent[] carEvents~%RadarState radarState~%ThermalData thermal~%Clocks clocks~%UiLayoutState uiLayoutState~%OrbslamCorrection orbslamCorrectionDEPRECATED~%CameraOdometry cameraOdometry~%GPSPlannerPoints gpsPlannerPoints~%SensorEventData[] sensorEvents~%ControlsState controlsState~%AndroidGnss androidGnss~%string[] applanixRaw~%EthernetPacket[] ethernetData~%string[] ubloxRaw~%LiveLocationData liveLocationCorrected~%Boot boot~%TrafficEvent[] trafficEvents~%bool valid~%HealthData health~%LiveCalibrationData liveCalibration~%int64 logMonoTime~%WifiScan[] wifiScan~%CarState carState~%Thumbnail thumbnail~%NavUpdate navUpdate~%OrbKeyFrame orbKeyFrame~%UiNavigationEvent uiNavigationEvent~%CarControl carControl~%EncodeIndex encodeIdx~%DriverMonitoring driverMonitoring~%InitData initData~%OrbOdometry orbOdometry~%Joystick testJoystick~%LiveMpcData liveMpc~%SensorEventData sensorEventDEPRECATED~%Plan plan~%LiveLocationData liveLocation~%CellInfo[] cellInfo~%string[] logMessage~%NavStatus navStatus~%GpsLocationData gpsLocation~%LiveEventData[] liveEventDEPRECATED~%OrbFeaturesSummary orbFeaturesSummary~%LiveLocationData liveLocationTiming~%UbloxGnss ubloxGnss~%KalmanOdometry kalmanOdometry~%LiveTracks[] liveTracks~%ProcLog procLog~%PathPlan pathPlan~%CarParams carParams~%LiveLocationData location~%LiveLocationData applanixLocation~%GpsLocationData gpsLocationExternal~%CanData[] can~%GPSPlannerPlan gpsPlannerPlan~%LiveParametersData liveParameters~%ModelData model~%LiveLongitudinalMpcData liveLongitudinalMpc~%LiveLocationData liveLocationKalman~%OrbObservation[] orbObservation~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LidarPts~%Header header~%~%int64[] reflect~%int64[] theta~%int64[] r~%string[] pkt~%int64 idx~%~%================================================================================~%MSG: openpilot_bridge/GPSNMEAData~%Header header~%~%int32 timestamp~%string[] nmea~%int64 localWallTime~%~%================================================================================~%MSG: openpilot_bridge/AndroidLogEntry~%Header header~%~%int32 pid~%int64 ts~%int64 priority~%string[] tag~%int32 tid~%string[] message~%int64 id~%~%================================================================================~%MSG: openpilot_bridge/CalibrationFeatures~%Header header~%~%int32[] status~%float32[] p0~%float32[] p1~%int64 frameId~%~%================================================================================~%MSG: openpilot_bridge/LiveMapData~%Header header~%~%float32[] roadCurvatureX~%int64 wayId~%bool speedLimitValid~%float32 distToTurn~%float32 curvature~%float32[] roadCurvature~%bool mapValid~%float32[] roadY~%float32[] roadX~%float32 speedLimitAheadDistance~%bool curvatureValid~%bool speedLimitAheadValid~%bool speedAdvisoryValid~%float32 speedLimit~%float32 speedAdvisory~%GpsLocationData lastGps~%float32 speedLimitAhead~%~%================================================================================~%MSG: openpilot_bridge/GpsLocationData~%Header header~%~%float32 bearing~%float32[] vNED~%int32 timestamp~%float32 altitude~%float32 longitude~%uint32 source # enum const: SensorSource~%float32 speedAccuracy~%int64 flags~%float32 latitude~%float32 bearingAccuracy~%float32 speed~%float32 verticalAccuracy~%float32 accuracy~%~%================================================================================~%MSG: openpilot_bridge/OrbFeatures~%Header header~%~%int32[] octaves~%int32[] matches~%string[] descriptors~%int64 timestampEof~%int64 timestampLastEof~%float32[] xs~%float32[] ys~%~%================================================================================~%MSG: openpilot_bridge/FrameData~%Header header~%~%int32 integLines~%int32 frameLength~%int64 timestampSof~%float32 lensTruePos~%int64 timestampEof~%float32[] transform~%int64 frameId~%int64 encodeId~%AndroidCaptureResult androidCaptureResult~%float32 gainFrac~%float32 lensSag~%int32 globalGain~%float32 lensErr~%string[] image~%uint32 frameType # enum const: FrameType~%int32 lensPos~%~%================================================================================~%MSG: openpilot_bridge/AndroidCaptureResult~%Header header~%~%int32 exposureTime~%int32 displayRotation~%float32[] colorCorrectionGains~%int32 sensitivity~%int64 rollingShutterSkew~%int32[] colorCorrectionTransform~%int32 frameDuration~%~%================================================================================~%MSG: openpilot_bridge/CanData~%Header header~%~%string[] dat~%int64 src~%int64 busTime~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/QcomGnss~%Header header~%~%string[] rawLog~%MeasurementReport measurementReport~%int64 logTs~%DrSvPolyReport drSvPoly~%ClockReport clockReport~%DrMeasurementReport drMeasurementReport~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/DrSvPolyReport~%Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: openpilot_bridge/ClockReport~%Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/DrMeasurementReport~%Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%================================================================================~%MSG: openpilot_bridge/LiveUI~%Header header~%~%bool rearViewCam~%float32 awarenessStatus~%string[] alertText2~%string[] alertText1~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/RadarState~%Header header~%~%float32[] warpMatrixDEPRECATED~%int32 calCycleDEPRECATED~%int32 calStatusDEPRECATED~%int64 mdMonoTime~%LeadData leadTwo~%int32 calPercDEPRECATED~%uint32[] radarErrors # enum const: Error~%float32 cumLagMs~%int64[] canMonoTimes~%float32 angleOffsetDEPRECATED~%int64 ftMonoTimeDEPRECATED~%LeadData leadOne~%int64 controlsStateMonoTime~%RadarPoint[] radarPoints~%LiveTracks[] liveTracks~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/RadarPoint~%Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: openpilot_bridge/LiveTracks~%Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%================================================================================~%MSG: openpilot_bridge/ThermalData~%Header header~%~%int32 batteryVoltage~%bool chargingError~%int32 cpuPerc~%bool chargingDisabled~%int64 fanSpeed~%int32 batteryCurrent~%bool started~%int64 pa0~%int32 batteryPercent~%int64 gpu~%uint32 thermalStatus # enum const: ThermalStatus~%float32 freeSpace~%bool usbOnline~%int64 mem~%int64 cpu2~%int64 cpu3~%int64 cpu0~%int64 cpu1~%int64 startedTs~%string[] batteryStatus~%int32 memUsedPercent~%int64 bat~%~%================================================================================~%MSG: openpilot_bridge/Clocks~%Header header~%~%int64 modemUptimeMillis~%int64 wallTimeNanos~%int64 bootTimeNanos~%int64 monotonicRawNanos~%int64 monotonicNanos~%~%================================================================================~%MSG: openpilot_bridge/UiLayoutState~%Header header~%~%uint32 activeApp # enum const: App~%bool mapEnabled~%bool sidebarCollapsed~%~%================================================================================~%MSG: openpilot_bridge/OrbslamCorrection~%Header header~%~%int64 correctionMonoTime~%float32[] prePositionECEF~%float32[] postPositionECEF~%float32[] postPoseQuatECEF~%int64 numInliers~%float32[] prePoseQuatECEF~%~%================================================================================~%MSG: openpilot_bridge/CameraOdometry~%Header header~%~%float32[] transStd~%int64 timestampEof~%int64 frameId~%float32[] rotStd~%float32[] trans~%float32[] rot~%~%================================================================================~%MSG: openpilot_bridge/GPSPlannerPoints~%Header header~%~%float32 accelTarget~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%ECEFPoint curPos~%bool valid~%float32 speedLimit~%ECEFPointDEPRECATED curPosDEPRECATED~%ECEFPoint[] points~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/SensorEventData~%Header header~%~%SensorVec acceleration~%SensorVec gyroUncalibrated~%float32 light~%SensorVec orientation~%SensorVec pressure~%int32 sensor~%SensorVec magnetic~%SensorVec magneticUncalibrated~%uint32 source # enum const: SensorSource~%SensorVec gyro~%int32 version~%int32 timestamp~%int32 type~%float32 proximity~%bool uncalibratedDEPRECATED~%~%================================================================================~%MSG: openpilot_bridge/SensorVec~%Header header~%~%int32 status~%float32[] v~%~%================================================================================~%MSG: openpilot_bridge/ControlsState~%Header header~%~%float32 ufSteerDEPRECATED~%float32 angleSteersDes~%bool decelForTurn~%bool steerOverride~%bool rearViewCam~%int64 canErrorCounter~%Lateralcontrolstate lateralControlState~%float32 vEgoRaw~%bool forceDecel~%uint32 alertSound # enum const: AudibleAlert~%float32 upSteerDEPRECATED~%float32 vEgo~%float32 angleSteers~%float32 jerkFactor~%string[] alertType~%float32 aTarget~%uint32 alertStatus # enum const: AlertStatus~%uint32 alertSize # enum const: AlertSize~%int64 planMonoTime~%float32 aTargetMaxDEPRECATED~%float32 uiAccelCmd~%uint32 state # enum const: OpenpilotState~%float32 alertBlinkingRate~%float32 angleModelBiasDEPRECATED~%string[] alertText2~%string[] alertText1~%float32 yDesDEPRECATED~%float32 vPid~%float32 vTargetLead~%bool decelForModel~%bool gpsPlannerActive~%int64 startMonoTime~%int64 canMonoTimeDEPRECATED~%float32 curvature~%float32 upAccelCmd~%float32 vCurvature~%int32 hudLeadDEPRECATED~%bool active~%float32 awarenessStatus~%float32 uiSteerDEPRECATED~%float32 aEgoDEPRECATED~%string[] alertSoundDEPRECATED~%float32 ufAccelCmd~%float32 vCruise~%float32 yActualDEPRECATED~%bool enabled~%float32 aTargetMinDEPRECATED~%float32 cumLagMs~%bool mapValid~%int64 pathPlanMonoTime~%bool engageable~%int64 mdMonoTimeDEPRECATED~%bool driverMonitoringOn~%int64[] canMonoTimes~%int64 radarStateMonoTimeDEPRECATED~%uint32 longControlState # enum const: LongControlState~%~%================================================================================~%MSG: openpilot_bridge/Lateralcontrolstate~%Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/AndroidGnss~%Header header~%~%NavigationMessage navigationMessage~%Measurements measurements~%~%================================================================================~%MSG: openpilot_bridge/NavigationMessage~%Header header~%~%uint32 status # enum const: Status~%string[] data~%int32 svId~%int32 messageId~%int32 submessageId~%int32 type~%~%================================================================================~%MSG: openpilot_bridge/Measurements~%Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%================================================================================~%MSG: openpilot_bridge/EthernetPacket~%Header header~%~%float32 ts~%string[] pkt~%~%================================================================================~%MSG: openpilot_bridge/LiveLocationData~%Header header~%~%float32 pitch~%float32[] positionECEF~%float32 alt~%float32 speed~%float32 lon~%uint32 source # enum const: SensorSource~%float32 roll~%Accuracy accuracy~%int64 status~%float32 yawCalibration~%float32[] vNED~%float32[] accel~%int64 fixMonoTime~%float32 lat~%float32[] imuFrame~%float32 pitchCalibration~%float32[] gyro~%float32 timeOfWeek~%float32[] poseQuatECEF~%int32 gpsWeek~%float32 trackAngle~%float32 heading~%float32 wanderAngle~%~%================================================================================~%MSG: openpilot_bridge/Accuracy~%Header header~%~%float32[] vNEDError~%float32 rollError~%float32 headingError~%float32 ellipsoidSemiMajorError~%float32 ellipsoidOrientationError~%float32[] pNEDError~%float32 ellipsoidSemiMinorError~%float32 pitchError~%~%================================================================================~%MSG: openpilot_bridge/Boot~%Header header~%~%int64 wallTimeNanos~%string[] lastKmsg~%string[] lastPmsg~%~%================================================================================~%MSG: openpilot_bridge/TrafficEvent~%Header header~%~%uint32 action # enum const: Action~%float32 distance~%uint32 type # enum const: Type~%bool resuming~%~%================================================================================~%MSG: openpilot_bridge/HealthData~%Header header~%~%bool gasInterceptorDetected~%uint32 faultStatus # enum const: FaultStatus~%bool hasGps~%int64 fanSpeedRpm~%bool startedSignalDetectedDeprecated~%int64 canRxErrs~%uint32[] faults # enum const: FaultType~%int64 canFwdErrs~%int64 uptime~%bool powerSaveEnabled~%int64 current~%uint32 hwType # enum const: HwType~%bool ignitionCan~%int64 voltage~%int64 canSendErrs~%uint32 usbPowerMode # enum const: UsbPowerMode~%int64 gmlanSendErrs~%bool ignitionLine~%uint32 safetyModel # enum const: SafetyModel~%bool controlsAllowed~%~%================================================================================~%MSG: openpilot_bridge/LiveCalibrationData~%Header header~%~%float32[] warpMatrix2~%float32[] warpMatrix~%float32[] rpyCalib~%float32[] warpMatrixBig~%int32 calCycle~%float32[] extrinsicMatrix~%int32 calPerc~%int32 calStatus~%~%================================================================================~%MSG: openpilot_bridge/WifiScan~%Header header~%~%bool is80211mcResponder~%string[] operatorFriendlyName~%uint32 channelWidth # enum const: ChannelWidth~%int32 distanceSdCm~%string[] ssid~%string[] bssid~%int32 level~%int32 timestamp~%string[] capabilities~%int32 distanceCm~%int32 centerFreq0~%int32 centerFreq1~%int32 frequency~%bool passpoint~%string[] venueName~%~%================================================================================~%MSG: openpilot_bridge/CarState~%Header header~%~%uint32 gearShifter # enum const: GearShifter~%bool seatbeltUnlatched~%bool clutchPressed~%float32 vEgoRaw~%uint32[] errorsDEPRECATED # enum const: EventName~%float32 brake~%float32 vEgo~%float32 steeringAngle~%bool leftBlinker~%WheelSpeeds wheelSpeeds~%bool steeringRateLimited~%bool stockFcw~%bool doorOpen~%float32 steeringRate~%CarEvent[] events~%bool steeringPressed~%bool canValid~%CruiseState cruiseState~%float32 yawRate~%float32 steeringTorqueEps~%float32 gas~%float32 steeringTorque~%bool genericToggle~%bool brakeLights~%ButtonEvent[] buttonEvents~%bool standstill~%bool gasPressed~%bool stockAeb~%bool rightBlinker~%bool brakePressed~%float32 aEgo~%int64[] canMonoTimes~%~%================================================================================~%MSG: openpilot_bridge/WheelSpeeds~%Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: openpilot_bridge/CruiseState~%Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: openpilot_bridge/ButtonEvent~%Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%================================================================================~%MSG: openpilot_bridge/Thumbnail~%Header header~%~%int64 timestampEof~%string[] thumbnail~%int64 frameId~%~%================================================================================~%MSG: openpilot_bridge/NavUpdate~%Header header~%~%bool isNavigating~%Segment[] segments~%int32 curSegment~%~%================================================================================~%MSG: openpilot_bridge/Segment~%Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%================================================================================~%MSG: openpilot_bridge/OrbKeyFrame~%Header header~%~%string[] descriptors~%int64 id~%ECEFPoint[] dpos~%ECEFPoint pos~%~%================================================================================~%MSG: openpilot_bridge/UiNavigationEvent~%Header header~%~%uint32 status # enum const: Status~%float32 distanceTo~%uint32 type # enum const: Type~%ECEFPointDEPRECATED endRoadPointDEPRECATED~%ECEFPoint endRoadPoint~%~%================================================================================~%MSG: openpilot_bridge/CarControl~%Header header~%~%float32 brakeDEPRECATED~%float32 gasDEPRECATED~%float32 steeringTorqueDEPRECATED~%CruiseControl cruiseControl~%Actuators actuators~%bool active~%HUDControl hudControl~%bool enabled~%~%================================================================================~%MSG: openpilot_bridge/CruiseControl~%Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: openpilot_bridge/Actuators~%Header header~%~%float32 brake~%float32 gas~%float32 steerAngle~%float32 steer~%~%================================================================================~%MSG: openpilot_bridge/HUDControl~%Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%================================================================================~%MSG: openpilot_bridge/EncodeIndex~%Header header~%~%int64 segmentId~%int64 segmentIdEncode~%int64 frameId~%int64 encodeId~%uint32 type # enum const: Type~%int32 segmentNum~%~%================================================================================~%MSG: openpilot_bridge/DriverMonitoring~%Header header~%~%float32[] faceOrientation~%float32 stdDEPRECATED~%float32 irPwrDEPRECATED~%float32[] faceOrientationStd~%float32 faceProb~%int64 frameId~%float32[] descriptorDEPRECATED~%float32 rightBlinkProb~%float32 rightEyeProb~%float32[] facePositionStd~%float32 leftBlinkProb~%float32 leftEyeProb~%float32[] facePosition~%~%================================================================================~%MSG: openpilot_bridge/InitData~%Header header~%~%string[] kernelVersion~%ChffrAndroidExtra chffrAndroidExtra~%Map androidProperties~%AndroidSensor[] androidSensors~%PandaInfo pandaInfo~%IosBuildInfo iosBuildInfo~%string[] gitRemote~%AndroidBuildInfo androidBuildInfo~%bool passive~%Map params~%string[] version~%uint32 deviceType # enum const: DeviceType~%string[] kernelArgs~%string[] gitCommit~%string[] gitBranch~%string[] dongleId~%string[] gctx~%bool dirty~%~%================================================================================~%MSG: openpilot_bridge/ChffrAndroidExtra~%Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%================================================================================~%MSG: openpilot_bridge/AndroidSensor~%Header header~%~%float32 maxRange~%string[] stringType~%int32 maxDelay~%int32 handle~%string[] name~%float32 power~%int32 minDelay~%float32 resolution~%int64 fifoMaxEventCount~%int32 version~%int64 fifoReservedEventCount~%string[] vendor~%int32 type~%int32 id~%~%================================================================================~%MSG: openpilot_bridge/PandaInfo~%Header header~%~%bool hasPanda~%string[] stVersion~%string[] dongleId~%string[] espVersion~%~%================================================================================~%MSG: openpilot_bridge/IosBuildInfo~%Header header~%~%int64 appBuild~%string[] appVersion~%string[] osVersion~%string[] deviceModel~%~%================================================================================~%MSG: openpilot_bridge/AndroidBuildInfo~%Header header~%~%string[] radioVersion~%string[] versionCodename~%string[] hardware~%string[] versionSecurityPatch~%string[] supportedAbis~%string[] id~%string[] board~%string[] type~%string[] product~%string[] tags~%string[] brand~%string[] host~%string[] user~%string[] fingerprint~%string[] device~%string[] bootloader~%string[] model~%string[] serial~%string[] manufacturer~%string[] versionRelease~%int32 time~%int32 versionSdk~%string[] display~%~%================================================================================~%MSG: openpilot_bridge/OrbOdometry~%Header header~%~%int64 endMonoTime~%float32 err~%float32[] f~%int32[] matches~%int32 inliers~%int64 startMonoTime~%~%================================================================================~%MSG: openpilot_bridge/Joystick~%Header header~%~%bool[] buttons~%float32[] axes~%~%================================================================================~%MSG: openpilot_bridge/LiveMpcData~%Header header~%~%float32[] psi~%int64 qpIterations~%float32 cost~%float32[] delta~%float32[] y~%float32[] x~%int64 calculationTime~%~%================================================================================~%MSG: openpilot_bridge/Plan~%Header header~%~%bool decelForTurn~%float32 vTarget~%bool lateralValidDEPRECATED~%uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource~%bool hasLead~%int64 radarStateMonoTime~%float32 jerkFactor~%float32 vCurvature~%float32 aTarget~%int64 mdMonoTime~%float32 aTargetMaxDEPRECATED~%float32 laneWidthDEPRECATED~%bool radarValid~%bool gpsPlannerActive~%bool fcw~%float32 processingDelay~%bool longitudinalValidDEPRECATED~%float32 aStart~%CarEvent[] eventsDEPRECATED~%bool hasRightLaneDEPRECATED~%float32 vStart~%float32 aCruise~%bool commIssue~%float32 vTargetFuture~%GpsTrajectory gpsTrajectory~%bool hasLeftLaneDEPRECATED~%float32 vCruise~%float32 aTargetMinDEPRECATED~%bool mapValid~%bool radarCanError~%float32 vMax~%float32[] dPolyDEPRECATED~%~%================================================================================~%MSG: openpilot_bridge/GpsTrajectory~%Header header~%~%float32[] y~%float32[] x~%~%================================================================================~%MSG: openpilot_bridge/CellInfo~%Header header~%~%int64 timestamp~%string[] repr~%~%================================================================================~%MSG: openpilot_bridge/NavStatus~%Header header~%~%bool isNavigating~%Address currentAddress~%~%================================================================================~%MSG: openpilot_bridge/Address~%Header header~%~%string[] city~%string[] title~%string[] house~%string[] state~%string[] street~%string[] address~%float32 lat~%float32 lng~%string[] country~%~%================================================================================~%MSG: openpilot_bridge/LiveEventData~%Header header~%~%string[] name~%int32 value~%~%================================================================================~%MSG: openpilot_bridge/OrbFeaturesSummary~%Header header~%~%int64 timestampEof~%int64 featureCount~%int64 matchCount~%int64 timestampLastEof~%int64 computeNs~%~%================================================================================~%MSG: openpilot_bridge/UbloxGnss~%Header header~%~%IonoData ionoData~%MeasurementReport measurementReport~%Ephemeris ephemeris~%~%================================================================================~%MSG: openpilot_bridge/IonoData~%Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: openpilot_bridge/Ephemeris~%Header header~%~%float32 iodc~%float32 fitInterval~%int64 month~%float32 second~%float32 tgd~%int64 year~%float32 gpsWeek~%float32 cus~%bool ionoCoeffsValid~%int64 svId~%float32 svAcc~%float32 cuc~%float32 m0~%float32 toc~%float32 deltaN~%float32 toe~%float32 cic~%float32[] ionoBeta~%float32 ecc~%float32 iDot~%float32 i0~%float32 svHealth~%float32 codesL2~%float32 omega~%int64 day~%int64 minute~%float32 a~%float32 crs~%float32[] ionoAlpha~%int64 hour~%float32 iode~%float32 af1~%float32 cis~%float32 crc~%float32 l2~%float32 omegaDot~%float32 af0~%float32 omega0~%float32 af2~%float32 transmissionTime~%~%================================================================================~%MSG: openpilot_bridge/KalmanOdometry~%Header header~%~%float32[] rotStd~%float32[] transStd~%float32[] trans~%float32[] rot~%~%================================================================================~%MSG: openpilot_bridge/ProcLog~%Header header~%~%CPUTimes[] cpuTimes~%Mem mem~%Process[] procs~%~%================================================================================~%MSG: openpilot_bridge/CPUTimes~%Header header~%~%float32 softirq~%float32 iowait~%float32 system~%int32 cpuNum~%float32 idle~%float32 user~%float32 irq~%float32 nice~%~%================================================================================~%MSG: openpilot_bridge/Mem~%Header header~%~%int64 available~%int64 cached~%int64 free~%int64 inactive~%int64 active~%int64 shared~%int64 total~%int64 buffers~%~%================================================================================~%MSG: openpilot_bridge/Process~%Header header~%~%string[] exe~%string[] name~%string[] cmdline~%float32 cpuUser~%int32 numThreads~%int64 memRss~%int32 pid~%int64 memVms~%int32 priority~%float32 cpuSystem~%int64 state~%float32 startTime~%int32 nice~%float32 cpuChildrenUser~%int32 ppid~%int32 processor~%float32 cpuChildrenSystem~%~%================================================================================~%MSG: openpilot_bridge/PathPlan~%Header header~%~%float32 angleSteers~%bool commIssue~%float32[] lPoly~%uint32 laneChangeState # enum const: LaneChangeState~%bool sensorValid~%bool mpcSolutionValid~%float32 lProb~%bool modelValidDEPRECATED~%float32 rProb~%float32 cProb~%float32[] rPoly~%float32 laneWidth~%float32 angleOffset~%float32 rateSteers~%uint32 laneChangeDirection # enum const: LaneChangeDirection~%bool paramsValid~%float32[] cPoly~%bool posenetValid~%float32[] dPoly~%uint32 desire # enum const: Desire~%~%================================================================================~%MSG: openpilot_bridge/CarParams~%Header header~%~%int32 safetyParam~%float32 steerRatioRear~%bool enableDsu~%Lateraltuning lateralTuning~%uint32 steerControlType # enum const: SteerControlType~%string[] carFingerprint~%float32 rotationalInertia~%uint32 safetyModelPassive # enum const: SafetyModel~%CarFw[] carFw~%float32 minEnableSpeed~%bool enableGasInterceptor~%bool radarOffCan~%float32 steerRatio~%float32 vEgoStopping~%bool enableCamera~%bool enableCruise~%float32 tireStiffnessFront~%float32 minSteerSpeed~%bool stoppingControl~%float32 steerLimitTimer~%uint32 transmissionType # enum const: TransmissionType~%float32[] steerMaxV~%bool openpilotLongitudinalControl~%float32[] gasMaxBP~%bool enableApgs~%float32 radarTimeStep~%string[] carName~%uint32 safetyModel # enum const: SafetyModel~%string[] carVin~%float32[] steerMaxBP~%float32[] gasMaxV~%float32 steerRateCost~%float32[] brakeMaxV~%float32 tireStiffnessRear~%float32 centerToFront~%bool dashcamOnly~%float32 startAccel~%float32 wheelbase~%float32[] brakeMaxBP~%float32 mass~%float32 steerActuatorDelay~%LongitudinalPIDTuning longitudinalTuning~%bool directAccelControl~%bool communityFeature~%bool isPandaBlack~%bool steerLimitAlert~%~%================================================================================~%MSG: openpilot_bridge/Lateraltuning~%Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%================================================================================~%MSG: openpilot_bridge/CarFw~%Header header~%~%uint32 ecu # enum const: Ecu~%int64 subAddress~%string[] fwVersion~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalPIDTuning~%Header header~%~%float32[] kpV~%float32[] kpBP~%float32[] deadzoneBP~%float32[] kiV~%float32[] deadzoneV~%float32[] kiBP~%~%================================================================================~%MSG: openpilot_bridge/GPSPlannerPlan~%Header header~%~%float32 acceleration~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%float32[] poly~%float32 xLookahead~%bool valid~%float32 speed~%ECEFPoint[] points~%~%================================================================================~%MSG: openpilot_bridge/LiveParametersData~%Header header~%~%float32 steerRatio~%bool sensorValid~%float32 stiffnessFactor~%bool posenetValid~%float32 angleOffset~%float32 yawRate~%float32 gyroBias~%bool valid~%float32 posenetSpeed~%float32 angleOffsetAverage~%~%================================================================================~%MSG: openpilot_bridge/ModelData~%Header header~%~%LongitudinalData longitudinal~%LeadData leadFuture~%LeadData lead~%ModelSettings settings~%PathData leftLane~%int64 timestampEof~%int64 frameId~%PathData rightLane~%MetaData meta~%PathData path~%float32[] speed~%float32[] freePath~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalData~%Header header~%~%float32[] accelerations~%float32[] speeds~%~%================================================================================~%MSG: openpilot_bridge/ModelSettings~%Header header~%~%int64 bigBoxX~%int64 bigBoxY~%float32[] inputTransform~%int64 bigBoxHeight~%int64 bigBoxWidth~%float32[] boxProjection~%float32[] yuvCorrection~%~%================================================================================~%MSG: openpilot_bridge/PathData~%Header header~%~%float32 std~%float32[] poly~%float32[] points~%float32 prob~%float32[] stds~%~%================================================================================~%MSG: openpilot_bridge/MetaData~%Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%================================================================================~%MSG: openpilot_bridge/LiveLongitudinalMpcData~%Header header~%~%float32 aLeadTau~%float32[] vLead~%float32[] aLead~%float32[] xEgo~%float32[] xLead~%int64 mpcId~%float32 cost~%float32[] aEgo~%int64 calculationTime~%int64 qpIterations~%float32[] vEgo~%~%================================================================================~%MSG: openpilot_bridge/OrbObservation~%Header header~%~%int64 matchDistance~%float32[] locationECEF~%float32[] normalizedCoordinates~%int64 observationMonoTime~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Event>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lidarPts))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsNMEA))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'androidLogEntry))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'features))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveMapData))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orbFeatures))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frame))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sendcan) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'qcomGnss))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frontFrame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveUIDEPRECATED))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carEvents) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'radarState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'thermal))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'clocks))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'uiLayoutState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orbslamCorrectionDEPRECATED))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cameraOdometry))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsPlannerPoints))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sensorEvents) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'controlsState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'androidGnss))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'applanixRaw) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ethernetData) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ubloxRaw) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveLocationCorrected))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'boot))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'trafficEvents) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'health))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveCalibration))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'wifiScan) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'carState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'thumbnail))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'navUpdate))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orbKeyFrame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'uiNavigationEvent))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'carControl))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'encodeIdx))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'driverMonitoring))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'initData))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orbOdometry))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'testJoystick))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveMpc))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'sensorEventDEPRECATED))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'plan))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveLocation))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cellInfo) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'logMessage) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'navStatus))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsLocation))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'liveEventDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orbFeaturesSummary))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveLocationTiming))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ubloxGnss))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'kalmanOdometry))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'liveTracks) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'procLog))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pathPlan))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'carParams))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'location))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'applanixLocation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsLocationExternal))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'can) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsPlannerPlan))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveParameters))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'model))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveLongitudinalMpc))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liveLocationKalman))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'orbObservation) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Event>))
  "Converts a ROS message object to a list"
  (cl:list 'Event
    (cl:cons ':header (header msg))
    (cl:cons ':lidarPts (lidarPts msg))
    (cl:cons ':gpsNMEA (gpsNMEA msg))
    (cl:cons ':androidLogEntry (androidLogEntry msg))
    (cl:cons ':features (features msg))
    (cl:cons ':liveMapData (liveMapData msg))
    (cl:cons ':orbFeatures (orbFeatures msg))
    (cl:cons ':frame (frame msg))
    (cl:cons ':sendcan (sendcan msg))
    (cl:cons ':qcomGnss (qcomGnss msg))
    (cl:cons ':frontFrame (frontFrame msg))
    (cl:cons ':liveUIDEPRECATED (liveUIDEPRECATED msg))
    (cl:cons ':carEvents (carEvents msg))
    (cl:cons ':radarState (radarState msg))
    (cl:cons ':thermal (thermal msg))
    (cl:cons ':clocks (clocks msg))
    (cl:cons ':uiLayoutState (uiLayoutState msg))
    (cl:cons ':orbslamCorrectionDEPRECATED (orbslamCorrectionDEPRECATED msg))
    (cl:cons ':cameraOdometry (cameraOdometry msg))
    (cl:cons ':gpsPlannerPoints (gpsPlannerPoints msg))
    (cl:cons ':sensorEvents (sensorEvents msg))
    (cl:cons ':controlsState (controlsState msg))
    (cl:cons ':androidGnss (androidGnss msg))
    (cl:cons ':applanixRaw (applanixRaw msg))
    (cl:cons ':ethernetData (ethernetData msg))
    (cl:cons ':ubloxRaw (ubloxRaw msg))
    (cl:cons ':liveLocationCorrected (liveLocationCorrected msg))
    (cl:cons ':boot (boot msg))
    (cl:cons ':trafficEvents (trafficEvents msg))
    (cl:cons ':valid (valid msg))
    (cl:cons ':health (health msg))
    (cl:cons ':liveCalibration (liveCalibration msg))
    (cl:cons ':logMonoTime (logMonoTime msg))
    (cl:cons ':wifiScan (wifiScan msg))
    (cl:cons ':carState (carState msg))
    (cl:cons ':thumbnail (thumbnail msg))
    (cl:cons ':navUpdate (navUpdate msg))
    (cl:cons ':orbKeyFrame (orbKeyFrame msg))
    (cl:cons ':uiNavigationEvent (uiNavigationEvent msg))
    (cl:cons ':carControl (carControl msg))
    (cl:cons ':encodeIdx (encodeIdx msg))
    (cl:cons ':driverMonitoring (driverMonitoring msg))
    (cl:cons ':initData (initData msg))
    (cl:cons ':orbOdometry (orbOdometry msg))
    (cl:cons ':testJoystick (testJoystick msg))
    (cl:cons ':liveMpc (liveMpc msg))
    (cl:cons ':sensorEventDEPRECATED (sensorEventDEPRECATED msg))
    (cl:cons ':plan (plan msg))
    (cl:cons ':liveLocation (liveLocation msg))
    (cl:cons ':cellInfo (cellInfo msg))
    (cl:cons ':logMessage (logMessage msg))
    (cl:cons ':navStatus (navStatus msg))
    (cl:cons ':gpsLocation (gpsLocation msg))
    (cl:cons ':liveEventDEPRECATED (liveEventDEPRECATED msg))
    (cl:cons ':orbFeaturesSummary (orbFeaturesSummary msg))
    (cl:cons ':liveLocationTiming (liveLocationTiming msg))
    (cl:cons ':ubloxGnss (ubloxGnss msg))
    (cl:cons ':kalmanOdometry (kalmanOdometry msg))
    (cl:cons ':liveTracks (liveTracks msg))
    (cl:cons ':procLog (procLog msg))
    (cl:cons ':pathPlan (pathPlan msg))
    (cl:cons ':carParams (carParams msg))
    (cl:cons ':location (location msg))
    (cl:cons ':applanixLocation (applanixLocation msg))
    (cl:cons ':gpsLocationExternal (gpsLocationExternal msg))
    (cl:cons ':can (can msg))
    (cl:cons ':gpsPlannerPlan (gpsPlannerPlan msg))
    (cl:cons ':liveParameters (liveParameters msg))
    (cl:cons ':model (model msg))
    (cl:cons ':liveLongitudinalMpc (liveLongitudinalMpc msg))
    (cl:cons ':liveLocationKalman (liveLocationKalman msg))
    (cl:cons ':orbObservation (orbObservation msg))
))
