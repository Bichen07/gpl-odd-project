; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude HealthData.msg.html

(cl:defclass <HealthData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gasInterceptorDetected
    :reader gasInterceptorDetected
    :initarg :gasInterceptorDetected
    :type cl:boolean
    :initform cl:nil)
   (faultStatus
    :reader faultStatus
    :initarg :faultStatus
    :type cl:integer
    :initform 0)
   (hasGps
    :reader hasGps
    :initarg :hasGps
    :type cl:boolean
    :initform cl:nil)
   (fanSpeedRpm
    :reader fanSpeedRpm
    :initarg :fanSpeedRpm
    :type cl:integer
    :initform 0)
   (startedSignalDetectedDeprecated
    :reader startedSignalDetectedDeprecated
    :initarg :startedSignalDetectedDeprecated
    :type cl:boolean
    :initform cl:nil)
   (canRxErrs
    :reader canRxErrs
    :initarg :canRxErrs
    :type cl:integer
    :initform 0)
   (faults
    :reader faults
    :initarg :faults
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (canFwdErrs
    :reader canFwdErrs
    :initarg :canFwdErrs
    :type cl:integer
    :initform 0)
   (uptime
    :reader uptime
    :initarg :uptime
    :type cl:integer
    :initform 0)
   (powerSaveEnabled
    :reader powerSaveEnabled
    :initarg :powerSaveEnabled
    :type cl:boolean
    :initform cl:nil)
   (current
    :reader current
    :initarg :current
    :type cl:integer
    :initform 0)
   (hwType
    :reader hwType
    :initarg :hwType
    :type cl:integer
    :initform 0)
   (ignitionCan
    :reader ignitionCan
    :initarg :ignitionCan
    :type cl:boolean
    :initform cl:nil)
   (voltage
    :reader voltage
    :initarg :voltage
    :type cl:integer
    :initform 0)
   (canSendErrs
    :reader canSendErrs
    :initarg :canSendErrs
    :type cl:integer
    :initform 0)
   (usbPowerMode
    :reader usbPowerMode
    :initarg :usbPowerMode
    :type cl:integer
    :initform 0)
   (gmlanSendErrs
    :reader gmlanSendErrs
    :initarg :gmlanSendErrs
    :type cl:integer
    :initform 0)
   (ignitionLine
    :reader ignitionLine
    :initarg :ignitionLine
    :type cl:boolean
    :initform cl:nil)
   (safetyModel
    :reader safetyModel
    :initarg :safetyModel
    :type cl:integer
    :initform 0)
   (controlsAllowed
    :reader controlsAllowed
    :initarg :controlsAllowed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HealthData (<HealthData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HealthData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HealthData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<HealthData> is deprecated: use openpilot_bridge-msg:HealthData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gasInterceptorDetected-val :lambda-list '(m))
(cl:defmethod gasInterceptorDetected-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasInterceptorDetected-val is deprecated.  Use openpilot_bridge-msg:gasInterceptorDetected instead.")
  (gasInterceptorDetected m))

(cl:ensure-generic-function 'faultStatus-val :lambda-list '(m))
(cl:defmethod faultStatus-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:faultStatus-val is deprecated.  Use openpilot_bridge-msg:faultStatus instead.")
  (faultStatus m))

(cl:ensure-generic-function 'hasGps-val :lambda-list '(m))
(cl:defmethod hasGps-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGps-val is deprecated.  Use openpilot_bridge-msg:hasGps instead.")
  (hasGps m))

(cl:ensure-generic-function 'fanSpeedRpm-val :lambda-list '(m))
(cl:defmethod fanSpeedRpm-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fanSpeedRpm-val is deprecated.  Use openpilot_bridge-msg:fanSpeedRpm instead.")
  (fanSpeedRpm m))

(cl:ensure-generic-function 'startedSignalDetectedDeprecated-val :lambda-list '(m))
(cl:defmethod startedSignalDetectedDeprecated-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:startedSignalDetectedDeprecated-val is deprecated.  Use openpilot_bridge-msg:startedSignalDetectedDeprecated instead.")
  (startedSignalDetectedDeprecated m))

(cl:ensure-generic-function 'canRxErrs-val :lambda-list '(m))
(cl:defmethod canRxErrs-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canRxErrs-val is deprecated.  Use openpilot_bridge-msg:canRxErrs instead.")
  (canRxErrs m))

(cl:ensure-generic-function 'faults-val :lambda-list '(m))
(cl:defmethod faults-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:faults-val is deprecated.  Use openpilot_bridge-msg:faults instead.")
  (faults m))

(cl:ensure-generic-function 'canFwdErrs-val :lambda-list '(m))
(cl:defmethod canFwdErrs-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canFwdErrs-val is deprecated.  Use openpilot_bridge-msg:canFwdErrs instead.")
  (canFwdErrs m))

(cl:ensure-generic-function 'uptime-val :lambda-list '(m))
(cl:defmethod uptime-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uptime-val is deprecated.  Use openpilot_bridge-msg:uptime instead.")
  (uptime m))

(cl:ensure-generic-function 'powerSaveEnabled-val :lambda-list '(m))
(cl:defmethod powerSaveEnabled-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:powerSaveEnabled-val is deprecated.  Use openpilot_bridge-msg:powerSaveEnabled instead.")
  (powerSaveEnabled m))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:current-val is deprecated.  Use openpilot_bridge-msg:current instead.")
  (current m))

(cl:ensure-generic-function 'hwType-val :lambda-list '(m))
(cl:defmethod hwType-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hwType-val is deprecated.  Use openpilot_bridge-msg:hwType instead.")
  (hwType m))

(cl:ensure-generic-function 'ignitionCan-val :lambda-list '(m))
(cl:defmethod ignitionCan-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ignitionCan-val is deprecated.  Use openpilot_bridge-msg:ignitionCan instead.")
  (ignitionCan m))

(cl:ensure-generic-function 'voltage-val :lambda-list '(m))
(cl:defmethod voltage-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:voltage-val is deprecated.  Use openpilot_bridge-msg:voltage instead.")
  (voltage m))

(cl:ensure-generic-function 'canSendErrs-val :lambda-list '(m))
(cl:defmethod canSendErrs-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canSendErrs-val is deprecated.  Use openpilot_bridge-msg:canSendErrs instead.")
  (canSendErrs m))

(cl:ensure-generic-function 'usbPowerMode-val :lambda-list '(m))
(cl:defmethod usbPowerMode-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:usbPowerMode-val is deprecated.  Use openpilot_bridge-msg:usbPowerMode instead.")
  (usbPowerMode m))

(cl:ensure-generic-function 'gmlanSendErrs-val :lambda-list '(m))
(cl:defmethod gmlanSendErrs-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gmlanSendErrs-val is deprecated.  Use openpilot_bridge-msg:gmlanSendErrs instead.")
  (gmlanSendErrs m))

(cl:ensure-generic-function 'ignitionLine-val :lambda-list '(m))
(cl:defmethod ignitionLine-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ignitionLine-val is deprecated.  Use openpilot_bridge-msg:ignitionLine instead.")
  (ignitionLine m))

(cl:ensure-generic-function 'safetyModel-val :lambda-list '(m))
(cl:defmethod safetyModel-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:safetyModel-val is deprecated.  Use openpilot_bridge-msg:safetyModel instead.")
  (safetyModel m))

(cl:ensure-generic-function 'controlsAllowed-val :lambda-list '(m))
(cl:defmethod controlsAllowed-val ((m <HealthData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:controlsAllowed-val is deprecated.  Use openpilot_bridge-msg:controlsAllowed instead.")
  (controlsAllowed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HealthData>) ostream)
  "Serializes a message object of type '<HealthData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gasInterceptorDetected) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'faultStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'faultStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'faultStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'faultStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGps) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'fanSpeedRpm)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'startedSignalDetectedDeprecated) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'canRxErrs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faults))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'faults))
  (cl:let* ((signed (cl:slot-value msg 'canFwdErrs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'uptime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'powerSaveEnabled) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'current)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hwType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'hwType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'hwType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'hwType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignitionCan) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'voltage)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'canSendErrs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'usbPowerMode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'usbPowerMode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'usbPowerMode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'usbPowerMode)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'gmlanSendErrs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignitionLine) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModel)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'controlsAllowed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HealthData>) istream)
  "Deserializes a message object of type '<HealthData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'gasInterceptorDetected) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'faultStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'faultStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'faultStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'faultStatus)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'hasGps) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'fanSpeedRpm) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'startedSignalDetectedDeprecated) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'canRxErrs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faults) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faults)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'canFwdErrs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'uptime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'powerSaveEnabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'current) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hwType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'hwType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'hwType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'hwType)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ignitionCan) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'voltage) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'canSendErrs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'usbPowerMode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'usbPowerMode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'usbPowerMode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'usbPowerMode)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gmlanSendErrs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'ignitionLine) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'safetyModel)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'controlsAllowed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HealthData>)))
  "Returns string type for a message object of type '<HealthData>"
  "openpilot_bridge/HealthData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HealthData)))
  "Returns string type for a message object of type 'HealthData"
  "openpilot_bridge/HealthData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HealthData>)))
  "Returns md5sum for a message object of type '<HealthData>"
  "383ae8386ab9b895fcd32fe297b6db75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HealthData)))
  "Returns md5sum for a message object of type 'HealthData"
  "383ae8386ab9b895fcd32fe297b6db75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HealthData>)))
  "Returns full string definition for message of type '<HealthData>"
  (cl:format cl:nil "Header header~%~%bool gasInterceptorDetected~%uint32 faultStatus # enum const: FaultStatus~%bool hasGps~%int64 fanSpeedRpm~%bool startedSignalDetectedDeprecated~%int64 canRxErrs~%uint32[] faults # enum const: FaultType~%int64 canFwdErrs~%int64 uptime~%bool powerSaveEnabled~%int64 current~%uint32 hwType # enum const: HwType~%bool ignitionCan~%int64 voltage~%int64 canSendErrs~%uint32 usbPowerMode # enum const: UsbPowerMode~%int64 gmlanSendErrs~%bool ignitionLine~%uint32 safetyModel # enum const: SafetyModel~%bool controlsAllowed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HealthData)))
  "Returns full string definition for message of type 'HealthData"
  (cl:format cl:nil "Header header~%~%bool gasInterceptorDetected~%uint32 faultStatus # enum const: FaultStatus~%bool hasGps~%int64 fanSpeedRpm~%bool startedSignalDetectedDeprecated~%int64 canRxErrs~%uint32[] faults # enum const: FaultType~%int64 canFwdErrs~%int64 uptime~%bool powerSaveEnabled~%int64 current~%uint32 hwType # enum const: HwType~%bool ignitionCan~%int64 voltage~%int64 canSendErrs~%uint32 usbPowerMode # enum const: UsbPowerMode~%int64 gmlanSendErrs~%bool ignitionLine~%uint32 safetyModel # enum const: SafetyModel~%bool controlsAllowed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HealthData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     1
     8
     1
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faults) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     8
     8
     1
     8
     4
     1
     8
     8
     4
     8
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HealthData>))
  "Converts a ROS message object to a list"
  (cl:list 'HealthData
    (cl:cons ':header (header msg))
    (cl:cons ':gasInterceptorDetected (gasInterceptorDetected msg))
    (cl:cons ':faultStatus (faultStatus msg))
    (cl:cons ':hasGps (hasGps msg))
    (cl:cons ':fanSpeedRpm (fanSpeedRpm msg))
    (cl:cons ':startedSignalDetectedDeprecated (startedSignalDetectedDeprecated msg))
    (cl:cons ':canRxErrs (canRxErrs msg))
    (cl:cons ':faults (faults msg))
    (cl:cons ':canFwdErrs (canFwdErrs msg))
    (cl:cons ':uptime (uptime msg))
    (cl:cons ':powerSaveEnabled (powerSaveEnabled msg))
    (cl:cons ':current (current msg))
    (cl:cons ':hwType (hwType msg))
    (cl:cons ':ignitionCan (ignitionCan msg))
    (cl:cons ':voltage (voltage msg))
    (cl:cons ':canSendErrs (canSendErrs msg))
    (cl:cons ':usbPowerMode (usbPowerMode msg))
    (cl:cons ':gmlanSendErrs (gmlanSendErrs msg))
    (cl:cons ':ignitionLine (ignitionLine msg))
    (cl:cons ':safetyModel (safetyModel msg))
    (cl:cons ':controlsAllowed (controlsAllowed msg))
))
