; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CarParams.msg.html

(cl:defclass <CarParams> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (safetyParam
    :reader safetyParam
    :initarg :safetyParam
    :type cl:integer
    :initform 0)
   (steerRatioRear
    :reader steerRatioRear
    :initarg :steerRatioRear
    :type cl:float
    :initform 0.0)
   (enableDsu
    :reader enableDsu
    :initarg :enableDsu
    :type cl:boolean
    :initform cl:nil)
   (lateralTuning
    :reader lateralTuning
    :initarg :lateralTuning
    :type openpilot_bridge-msg:Lateraltuning
    :initform (cl:make-instance 'openpilot_bridge-msg:Lateraltuning))
   (steerControlType
    :reader steerControlType
    :initarg :steerControlType
    :type cl:integer
    :initform 0)
   (carFingerprint
    :reader carFingerprint
    :initarg :carFingerprint
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (rotationalInertia
    :reader rotationalInertia
    :initarg :rotationalInertia
    :type cl:float
    :initform 0.0)
   (safetyModelPassive
    :reader safetyModelPassive
    :initarg :safetyModelPassive
    :type cl:integer
    :initform 0)
   (carFw
    :reader carFw
    :initarg :carFw
    :type (cl:vector openpilot_bridge-msg:CarFw)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CarFw :initial-element (cl:make-instance 'openpilot_bridge-msg:CarFw)))
   (minEnableSpeed
    :reader minEnableSpeed
    :initarg :minEnableSpeed
    :type cl:float
    :initform 0.0)
   (enableGasInterceptor
    :reader enableGasInterceptor
    :initarg :enableGasInterceptor
    :type cl:boolean
    :initform cl:nil)
   (radarOffCan
    :reader radarOffCan
    :initarg :radarOffCan
    :type cl:boolean
    :initform cl:nil)
   (steerRatio
    :reader steerRatio
    :initarg :steerRatio
    :type cl:float
    :initform 0.0)
   (vEgoStopping
    :reader vEgoStopping
    :initarg :vEgoStopping
    :type cl:float
    :initform 0.0)
   (enableCamera
    :reader enableCamera
    :initarg :enableCamera
    :type cl:boolean
    :initform cl:nil)
   (enableCruise
    :reader enableCruise
    :initarg :enableCruise
    :type cl:boolean
    :initform cl:nil)
   (tireStiffnessFront
    :reader tireStiffnessFront
    :initarg :tireStiffnessFront
    :type cl:float
    :initform 0.0)
   (minSteerSpeed
    :reader minSteerSpeed
    :initarg :minSteerSpeed
    :type cl:float
    :initform 0.0)
   (stoppingControl
    :reader stoppingControl
    :initarg :stoppingControl
    :type cl:boolean
    :initform cl:nil)
   (steerLimitTimer
    :reader steerLimitTimer
    :initarg :steerLimitTimer
    :type cl:float
    :initform 0.0)
   (transmissionType
    :reader transmissionType
    :initarg :transmissionType
    :type cl:integer
    :initform 0)
   (steerMaxV
    :reader steerMaxV
    :initarg :steerMaxV
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (openpilotLongitudinalControl
    :reader openpilotLongitudinalControl
    :initarg :openpilotLongitudinalControl
    :type cl:boolean
    :initform cl:nil)
   (gasMaxBP
    :reader gasMaxBP
    :initarg :gasMaxBP
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (enableApgs
    :reader enableApgs
    :initarg :enableApgs
    :type cl:boolean
    :initform cl:nil)
   (radarTimeStep
    :reader radarTimeStep
    :initarg :radarTimeStep
    :type cl:float
    :initform 0.0)
   (carName
    :reader carName
    :initarg :carName
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (safetyModel
    :reader safetyModel
    :initarg :safetyModel
    :type cl:integer
    :initform 0)
   (carVin
    :reader carVin
    :initarg :carVin
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (steerMaxBP
    :reader steerMaxBP
    :initarg :steerMaxBP
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (gasMaxV
    :reader gasMaxV
    :initarg :gasMaxV
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (steerRateCost
    :reader steerRateCost
    :initarg :steerRateCost
    :type cl:float
    :initform 0.0)
   (brakeMaxV
    :reader brakeMaxV
    :initarg :brakeMaxV
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (tireStiffnessRear
    :reader tireStiffnessRear
    :initarg :tireStiffnessRear
    :type cl:float
    :initform 0.0)
   (centerToFront
    :reader centerToFront
    :initarg :centerToFront
    :type cl:float
    :initform 0.0)
   (dashcamOnly
    :reader dashcamOnly
    :initarg :dashcamOnly
    :type cl:boolean
    :initform cl:nil)
   (startAccel
    :reader startAccel
    :initarg :startAccel
    :type cl:float
    :initform 0.0)
   (wheelbase
    :reader wheelbase
    :initarg :wheelbase
    :type cl:float
    :initform 0.0)
   (brakeMaxBP
    :reader brakeMaxBP
    :initarg :brakeMaxBP
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (mass
    :reader mass
    :initarg :mass
    :type cl:float
    :initform 0.0)
   (steerActuatorDelay
    :reader steerActuatorDelay
    :initarg :steerActuatorDelay
    :type cl:float
    :initform 0.0)
   (longitudinalTuning
    :reader longitudinalTuning
    :initarg :longitudinalTuning
    :type openpilot_bridge-msg:LongitudinalPIDTuning
    :initform (cl:make-instance 'openpilot_bridge-msg:LongitudinalPIDTuning))
   (directAccelControl
    :reader directAccelControl
    :initarg :directAccelControl
    :type cl:boolean
    :initform cl:nil)
   (communityFeature
    :reader communityFeature
    :initarg :communityFeature
    :type cl:boolean
    :initform cl:nil)
   (isPandaBlack
    :reader isPandaBlack
    :initarg :isPandaBlack
    :type cl:boolean
    :initform cl:nil)
   (steerLimitAlert
    :reader steerLimitAlert
    :initarg :steerLimitAlert
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CarParams (<CarParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CarParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CarParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CarParams> is deprecated: use openpilot_bridge-msg:CarParams instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'safetyParam-val :lambda-list '(m))
(cl:defmethod safetyParam-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:safetyParam-val is deprecated.  Use openpilot_bridge-msg:safetyParam instead.")
  (safetyParam m))

(cl:ensure-generic-function 'steerRatioRear-val :lambda-list '(m))
(cl:defmethod steerRatioRear-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerRatioRear-val is deprecated.  Use openpilot_bridge-msg:steerRatioRear instead.")
  (steerRatioRear m))

(cl:ensure-generic-function 'enableDsu-val :lambda-list '(m))
(cl:defmethod enableDsu-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enableDsu-val is deprecated.  Use openpilot_bridge-msg:enableDsu instead.")
  (enableDsu m))

(cl:ensure-generic-function 'lateralTuning-val :lambda-list '(m))
(cl:defmethod lateralTuning-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lateralTuning-val is deprecated.  Use openpilot_bridge-msg:lateralTuning instead.")
  (lateralTuning m))

(cl:ensure-generic-function 'steerControlType-val :lambda-list '(m))
(cl:defmethod steerControlType-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerControlType-val is deprecated.  Use openpilot_bridge-msg:steerControlType instead.")
  (steerControlType m))

(cl:ensure-generic-function 'carFingerprint-val :lambda-list '(m))
(cl:defmethod carFingerprint-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carFingerprint-val is deprecated.  Use openpilot_bridge-msg:carFingerprint instead.")
  (carFingerprint m))

(cl:ensure-generic-function 'rotationalInertia-val :lambda-list '(m))
(cl:defmethod rotationalInertia-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rotationalInertia-val is deprecated.  Use openpilot_bridge-msg:rotationalInertia instead.")
  (rotationalInertia m))

(cl:ensure-generic-function 'safetyModelPassive-val :lambda-list '(m))
(cl:defmethod safetyModelPassive-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:safetyModelPassive-val is deprecated.  Use openpilot_bridge-msg:safetyModelPassive instead.")
  (safetyModelPassive m))

(cl:ensure-generic-function 'carFw-val :lambda-list '(m))
(cl:defmethod carFw-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carFw-val is deprecated.  Use openpilot_bridge-msg:carFw instead.")
  (carFw m))

(cl:ensure-generic-function 'minEnableSpeed-val :lambda-list '(m))
(cl:defmethod minEnableSpeed-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:minEnableSpeed-val is deprecated.  Use openpilot_bridge-msg:minEnableSpeed instead.")
  (minEnableSpeed m))

(cl:ensure-generic-function 'enableGasInterceptor-val :lambda-list '(m))
(cl:defmethod enableGasInterceptor-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enableGasInterceptor-val is deprecated.  Use openpilot_bridge-msg:enableGasInterceptor instead.")
  (enableGasInterceptor m))

(cl:ensure-generic-function 'radarOffCan-val :lambda-list '(m))
(cl:defmethod radarOffCan-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarOffCan-val is deprecated.  Use openpilot_bridge-msg:radarOffCan instead.")
  (radarOffCan m))

(cl:ensure-generic-function 'steerRatio-val :lambda-list '(m))
(cl:defmethod steerRatio-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerRatio-val is deprecated.  Use openpilot_bridge-msg:steerRatio instead.")
  (steerRatio m))

(cl:ensure-generic-function 'vEgoStopping-val :lambda-list '(m))
(cl:defmethod vEgoStopping-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vEgoStopping-val is deprecated.  Use openpilot_bridge-msg:vEgoStopping instead.")
  (vEgoStopping m))

(cl:ensure-generic-function 'enableCamera-val :lambda-list '(m))
(cl:defmethod enableCamera-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enableCamera-val is deprecated.  Use openpilot_bridge-msg:enableCamera instead.")
  (enableCamera m))

(cl:ensure-generic-function 'enableCruise-val :lambda-list '(m))
(cl:defmethod enableCruise-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enableCruise-val is deprecated.  Use openpilot_bridge-msg:enableCruise instead.")
  (enableCruise m))

(cl:ensure-generic-function 'tireStiffnessFront-val :lambda-list '(m))
(cl:defmethod tireStiffnessFront-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:tireStiffnessFront-val is deprecated.  Use openpilot_bridge-msg:tireStiffnessFront instead.")
  (tireStiffnessFront m))

(cl:ensure-generic-function 'minSteerSpeed-val :lambda-list '(m))
(cl:defmethod minSteerSpeed-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:minSteerSpeed-val is deprecated.  Use openpilot_bridge-msg:minSteerSpeed instead.")
  (minSteerSpeed m))

(cl:ensure-generic-function 'stoppingControl-val :lambda-list '(m))
(cl:defmethod stoppingControl-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stoppingControl-val is deprecated.  Use openpilot_bridge-msg:stoppingControl instead.")
  (stoppingControl m))

(cl:ensure-generic-function 'steerLimitTimer-val :lambda-list '(m))
(cl:defmethod steerLimitTimer-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerLimitTimer-val is deprecated.  Use openpilot_bridge-msg:steerLimitTimer instead.")
  (steerLimitTimer m))

(cl:ensure-generic-function 'transmissionType-val :lambda-list '(m))
(cl:defmethod transmissionType-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:transmissionType-val is deprecated.  Use openpilot_bridge-msg:transmissionType instead.")
  (transmissionType m))

(cl:ensure-generic-function 'steerMaxV-val :lambda-list '(m))
(cl:defmethod steerMaxV-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerMaxV-val is deprecated.  Use openpilot_bridge-msg:steerMaxV instead.")
  (steerMaxV m))

(cl:ensure-generic-function 'openpilotLongitudinalControl-val :lambda-list '(m))
(cl:defmethod openpilotLongitudinalControl-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:openpilotLongitudinalControl-val is deprecated.  Use openpilot_bridge-msg:openpilotLongitudinalControl instead.")
  (openpilotLongitudinalControl m))

(cl:ensure-generic-function 'gasMaxBP-val :lambda-list '(m))
(cl:defmethod gasMaxBP-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasMaxBP-val is deprecated.  Use openpilot_bridge-msg:gasMaxBP instead.")
  (gasMaxBP m))

(cl:ensure-generic-function 'enableApgs-val :lambda-list '(m))
(cl:defmethod enableApgs-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enableApgs-val is deprecated.  Use openpilot_bridge-msg:enableApgs instead.")
  (enableApgs m))

(cl:ensure-generic-function 'radarTimeStep-val :lambda-list '(m))
(cl:defmethod radarTimeStep-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarTimeStep-val is deprecated.  Use openpilot_bridge-msg:radarTimeStep instead.")
  (radarTimeStep m))

(cl:ensure-generic-function 'carName-val :lambda-list '(m))
(cl:defmethod carName-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carName-val is deprecated.  Use openpilot_bridge-msg:carName instead.")
  (carName m))

(cl:ensure-generic-function 'safetyModel-val :lambda-list '(m))
(cl:defmethod safetyModel-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:safetyModel-val is deprecated.  Use openpilot_bridge-msg:safetyModel instead.")
  (safetyModel m))

(cl:ensure-generic-function 'carVin-val :lambda-list '(m))
(cl:defmethod carVin-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carVin-val is deprecated.  Use openpilot_bridge-msg:carVin instead.")
  (carVin m))

(cl:ensure-generic-function 'steerMaxBP-val :lambda-list '(m))
(cl:defmethod steerMaxBP-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerMaxBP-val is deprecated.  Use openpilot_bridge-msg:steerMaxBP instead.")
  (steerMaxBP m))

(cl:ensure-generic-function 'gasMaxV-val :lambda-list '(m))
(cl:defmethod gasMaxV-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasMaxV-val is deprecated.  Use openpilot_bridge-msg:gasMaxV instead.")
  (gasMaxV m))

(cl:ensure-generic-function 'steerRateCost-val :lambda-list '(m))
(cl:defmethod steerRateCost-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerRateCost-val is deprecated.  Use openpilot_bridge-msg:steerRateCost instead.")
  (steerRateCost m))

(cl:ensure-generic-function 'brakeMaxV-val :lambda-list '(m))
(cl:defmethod brakeMaxV-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakeMaxV-val is deprecated.  Use openpilot_bridge-msg:brakeMaxV instead.")
  (brakeMaxV m))

(cl:ensure-generic-function 'tireStiffnessRear-val :lambda-list '(m))
(cl:defmethod tireStiffnessRear-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:tireStiffnessRear-val is deprecated.  Use openpilot_bridge-msg:tireStiffnessRear instead.")
  (tireStiffnessRear m))

(cl:ensure-generic-function 'centerToFront-val :lambda-list '(m))
(cl:defmethod centerToFront-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:centerToFront-val is deprecated.  Use openpilot_bridge-msg:centerToFront instead.")
  (centerToFront m))

(cl:ensure-generic-function 'dashcamOnly-val :lambda-list '(m))
(cl:defmethod dashcamOnly-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dashcamOnly-val is deprecated.  Use openpilot_bridge-msg:dashcamOnly instead.")
  (dashcamOnly m))

(cl:ensure-generic-function 'startAccel-val :lambda-list '(m))
(cl:defmethod startAccel-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:startAccel-val is deprecated.  Use openpilot_bridge-msg:startAccel instead.")
  (startAccel m))

(cl:ensure-generic-function 'wheelbase-val :lambda-list '(m))
(cl:defmethod wheelbase-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:wheelbase-val is deprecated.  Use openpilot_bridge-msg:wheelbase instead.")
  (wheelbase m))

(cl:ensure-generic-function 'brakeMaxBP-val :lambda-list '(m))
(cl:defmethod brakeMaxBP-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakeMaxBP-val is deprecated.  Use openpilot_bridge-msg:brakeMaxBP instead.")
  (brakeMaxBP m))

(cl:ensure-generic-function 'mass-val :lambda-list '(m))
(cl:defmethod mass-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mass-val is deprecated.  Use openpilot_bridge-msg:mass instead.")
  (mass m))

(cl:ensure-generic-function 'steerActuatorDelay-val :lambda-list '(m))
(cl:defmethod steerActuatorDelay-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerActuatorDelay-val is deprecated.  Use openpilot_bridge-msg:steerActuatorDelay instead.")
  (steerActuatorDelay m))

(cl:ensure-generic-function 'longitudinalTuning-val :lambda-list '(m))
(cl:defmethod longitudinalTuning-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:longitudinalTuning-val is deprecated.  Use openpilot_bridge-msg:longitudinalTuning instead.")
  (longitudinalTuning m))

(cl:ensure-generic-function 'directAccelControl-val :lambda-list '(m))
(cl:defmethod directAccelControl-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:directAccelControl-val is deprecated.  Use openpilot_bridge-msg:directAccelControl instead.")
  (directAccelControl m))

(cl:ensure-generic-function 'communityFeature-val :lambda-list '(m))
(cl:defmethod communityFeature-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:communityFeature-val is deprecated.  Use openpilot_bridge-msg:communityFeature instead.")
  (communityFeature m))

(cl:ensure-generic-function 'isPandaBlack-val :lambda-list '(m))
(cl:defmethod isPandaBlack-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:isPandaBlack-val is deprecated.  Use openpilot_bridge-msg:isPandaBlack instead.")
  (isPandaBlack m))

(cl:ensure-generic-function 'steerLimitAlert-val :lambda-list '(m))
(cl:defmethod steerLimitAlert-val ((m <CarParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerLimitAlert-val is deprecated.  Use openpilot_bridge-msg:steerLimitAlert instead.")
  (steerLimitAlert m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CarParams>) ostream)
  "Serializes a message object of type '<CarParams>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'safetyParam)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerRatioRear))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enableDsu) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lateralTuning) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steerControlType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'steerControlType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'steerControlType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'steerControlType)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carFingerprint))))
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
   (cl:slot-value msg 'carFingerprint))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rotationalInertia))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModelPassive)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModelPassive)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModelPassive)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModelPassive)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carFw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'carFw))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'minEnableSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enableGasInterceptor) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'radarOffCan) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerRatio))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vEgoStopping))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enableCamera) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enableCruise) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tireStiffnessFront))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'minSteerSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stoppingControl) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerLimitTimer))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'transmissionType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'transmissionType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'transmissionType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'transmissionType)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'steerMaxV))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'steerMaxV))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'openpilotLongitudinalControl) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gasMaxBP))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'gasMaxBP))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enableApgs) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'radarTimeStep))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carName))))
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
   (cl:slot-value msg 'carName))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carVin))))
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
   (cl:slot-value msg 'carVin))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'steerMaxBP))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'steerMaxBP))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gasMaxV))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'gasMaxV))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerRateCost))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'brakeMaxV))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'brakeMaxV))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tireStiffnessRear))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'centerToFront))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'dashcamOnly) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'startAccel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'wheelbase))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'brakeMaxBP))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'brakeMaxBP))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'mass))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerActuatorDelay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'longitudinalTuning) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'directAccelControl) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'communityFeature) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isPandaBlack) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'steerLimitAlert) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CarParams>) istream)
  "Deserializes a message object of type '<CarParams>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'safetyParam) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerRatioRear) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enableDsu) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lateralTuning) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steerControlType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'steerControlType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'steerControlType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'steerControlType)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carFingerprint) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carFingerprint)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rotationalInertia) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModelPassive)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModelPassive)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModelPassive)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModelPassive)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carFw) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carFw)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CarFw))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'minEnableSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enableGasInterceptor) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'radarOffCan) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerRatio) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vEgoStopping) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enableCamera) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'enableCruise) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tireStiffnessFront) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'minSteerSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'stoppingControl) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerLimitTimer) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'transmissionType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'transmissionType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'transmissionType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'transmissionType)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'steerMaxV) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'steerMaxV)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'openpilotLongitudinalControl) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'gasMaxBP) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gasMaxBP)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'enableApgs) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'radarTimeStep) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carName) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carName)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carVin) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carVin)))
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
  (cl:setf (cl:slot-value msg 'steerMaxBP) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'steerMaxBP)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'gasMaxV) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gasMaxV)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerRateCost) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'brakeMaxV) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'brakeMaxV)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tireStiffnessRear) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'centerToFront) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'dashcamOnly) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'startAccel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'wheelbase) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'brakeMaxBP) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'brakeMaxBP)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'mass) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerActuatorDelay) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'longitudinalTuning) istream)
    (cl:setf (cl:slot-value msg 'directAccelControl) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'communityFeature) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'isPandaBlack) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'steerLimitAlert) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CarParams>)))
  "Returns string type for a message object of type '<CarParams>"
  "openpilot_bridge/CarParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CarParams)))
  "Returns string type for a message object of type 'CarParams"
  "openpilot_bridge/CarParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CarParams>)))
  "Returns md5sum for a message object of type '<CarParams>"
  "ef560c6163951e81bdbf13272f514bb1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CarParams)))
  "Returns md5sum for a message object of type 'CarParams"
  "ef560c6163951e81bdbf13272f514bb1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CarParams>)))
  "Returns full string definition for message of type '<CarParams>"
  (cl:format cl:nil "Header header~%~%int32 safetyParam~%float32 steerRatioRear~%bool enableDsu~%Lateraltuning lateralTuning~%uint32 steerControlType # enum const: SteerControlType~%string[] carFingerprint~%float32 rotationalInertia~%uint32 safetyModelPassive # enum const: SafetyModel~%CarFw[] carFw~%float32 minEnableSpeed~%bool enableGasInterceptor~%bool radarOffCan~%float32 steerRatio~%float32 vEgoStopping~%bool enableCamera~%bool enableCruise~%float32 tireStiffnessFront~%float32 minSteerSpeed~%bool stoppingControl~%float32 steerLimitTimer~%uint32 transmissionType # enum const: TransmissionType~%float32[] steerMaxV~%bool openpilotLongitudinalControl~%float32[] gasMaxBP~%bool enableApgs~%float32 radarTimeStep~%string[] carName~%uint32 safetyModel # enum const: SafetyModel~%string[] carVin~%float32[] steerMaxBP~%float32[] gasMaxV~%float32 steerRateCost~%float32[] brakeMaxV~%float32 tireStiffnessRear~%float32 centerToFront~%bool dashcamOnly~%float32 startAccel~%float32 wheelbase~%float32[] brakeMaxBP~%float32 mass~%float32 steerActuatorDelay~%LongitudinalPIDTuning longitudinalTuning~%bool directAccelControl~%bool communityFeature~%bool isPandaBlack~%bool steerLimitAlert~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Lateraltuning~%Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%================================================================================~%MSG: openpilot_bridge/CarFw~%Header header~%~%uint32 ecu # enum const: Ecu~%int64 subAddress~%string[] fwVersion~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalPIDTuning~%Header header~%~%float32[] kpV~%float32[] kpBP~%float32[] deadzoneBP~%float32[] kiV~%float32[] deadzoneV~%float32[] kiBP~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CarParams)))
  "Returns full string definition for message of type 'CarParams"
  (cl:format cl:nil "Header header~%~%int32 safetyParam~%float32 steerRatioRear~%bool enableDsu~%Lateraltuning lateralTuning~%uint32 steerControlType # enum const: SteerControlType~%string[] carFingerprint~%float32 rotationalInertia~%uint32 safetyModelPassive # enum const: SafetyModel~%CarFw[] carFw~%float32 minEnableSpeed~%bool enableGasInterceptor~%bool radarOffCan~%float32 steerRatio~%float32 vEgoStopping~%bool enableCamera~%bool enableCruise~%float32 tireStiffnessFront~%float32 minSteerSpeed~%bool stoppingControl~%float32 steerLimitTimer~%uint32 transmissionType # enum const: TransmissionType~%float32[] steerMaxV~%bool openpilotLongitudinalControl~%float32[] gasMaxBP~%bool enableApgs~%float32 radarTimeStep~%string[] carName~%uint32 safetyModel # enum const: SafetyModel~%string[] carVin~%float32[] steerMaxBP~%float32[] gasMaxV~%float32 steerRateCost~%float32[] brakeMaxV~%float32 tireStiffnessRear~%float32 centerToFront~%bool dashcamOnly~%float32 startAccel~%float32 wheelbase~%float32[] brakeMaxBP~%float32 mass~%float32 steerActuatorDelay~%LongitudinalPIDTuning longitudinalTuning~%bool directAccelControl~%bool communityFeature~%bool isPandaBlack~%bool steerLimitAlert~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Lateraltuning~%Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%================================================================================~%MSG: openpilot_bridge/CarFw~%Header header~%~%uint32 ecu # enum const: Ecu~%int64 subAddress~%string[] fwVersion~%int64 address~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalPIDTuning~%Header header~%~%float32[] kpV~%float32[] kpBP~%float32[] deadzoneBP~%float32[] kiV~%float32[] deadzoneV~%float32[] kiBP~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CarParams>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lateralTuning))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carFingerprint) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carFw) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     1
     1
     4
     4
     1
     1
     4
     4
     1
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'steerMaxV) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gasMaxBP) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carName) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carVin) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'steerMaxBP) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gasMaxV) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'brakeMaxV) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     1
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'brakeMaxBP) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'longitudinalTuning))
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CarParams>))
  "Converts a ROS message object to a list"
  (cl:list 'CarParams
    (cl:cons ':header (header msg))
    (cl:cons ':safetyParam (safetyParam msg))
    (cl:cons ':steerRatioRear (steerRatioRear msg))
    (cl:cons ':enableDsu (enableDsu msg))
    (cl:cons ':lateralTuning (lateralTuning msg))
    (cl:cons ':steerControlType (steerControlType msg))
    (cl:cons ':carFingerprint (carFingerprint msg))
    (cl:cons ':rotationalInertia (rotationalInertia msg))
    (cl:cons ':safetyModelPassive (safetyModelPassive msg))
    (cl:cons ':carFw (carFw msg))
    (cl:cons ':minEnableSpeed (minEnableSpeed msg))
    (cl:cons ':enableGasInterceptor (enableGasInterceptor msg))
    (cl:cons ':radarOffCan (radarOffCan msg))
    (cl:cons ':steerRatio (steerRatio msg))
    (cl:cons ':vEgoStopping (vEgoStopping msg))
    (cl:cons ':enableCamera (enableCamera msg))
    (cl:cons ':enableCruise (enableCruise msg))
    (cl:cons ':tireStiffnessFront (tireStiffnessFront msg))
    (cl:cons ':minSteerSpeed (minSteerSpeed msg))
    (cl:cons ':stoppingControl (stoppingControl msg))
    (cl:cons ':steerLimitTimer (steerLimitTimer msg))
    (cl:cons ':transmissionType (transmissionType msg))
    (cl:cons ':steerMaxV (steerMaxV msg))
    (cl:cons ':openpilotLongitudinalControl (openpilotLongitudinalControl msg))
    (cl:cons ':gasMaxBP (gasMaxBP msg))
    (cl:cons ':enableApgs (enableApgs msg))
    (cl:cons ':radarTimeStep (radarTimeStep msg))
    (cl:cons ':carName (carName msg))
    (cl:cons ':safetyModel (safetyModel msg))
    (cl:cons ':carVin (carVin msg))
    (cl:cons ':steerMaxBP (steerMaxBP msg))
    (cl:cons ':gasMaxV (gasMaxV msg))
    (cl:cons ':steerRateCost (steerRateCost msg))
    (cl:cons ':brakeMaxV (brakeMaxV msg))
    (cl:cons ':tireStiffnessRear (tireStiffnessRear msg))
    (cl:cons ':centerToFront (centerToFront msg))
    (cl:cons ':dashcamOnly (dashcamOnly msg))
    (cl:cons ':startAccel (startAccel msg))
    (cl:cons ':wheelbase (wheelbase msg))
    (cl:cons ':brakeMaxBP (brakeMaxBP msg))
    (cl:cons ':mass (mass msg))
    (cl:cons ':steerActuatorDelay (steerActuatorDelay msg))
    (cl:cons ':longitudinalTuning (longitudinalTuning msg))
    (cl:cons ':directAccelControl (directAccelControl msg))
    (cl:cons ':communityFeature (communityFeature msg))
    (cl:cons ':isPandaBlack (isPandaBlack msg))
    (cl:cons ':steerLimitAlert (steerLimitAlert msg))
))
