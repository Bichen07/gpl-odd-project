; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CarState.msg.html

(cl:defclass <CarState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gearShifter
    :reader gearShifter
    :initarg :gearShifter
    :type cl:integer
    :initform 0)
   (seatbeltUnlatched
    :reader seatbeltUnlatched
    :initarg :seatbeltUnlatched
    :type cl:boolean
    :initform cl:nil)
   (clutchPressed
    :reader clutchPressed
    :initarg :clutchPressed
    :type cl:boolean
    :initform cl:nil)
   (vEgoRaw
    :reader vEgoRaw
    :initarg :vEgoRaw
    :type cl:float
    :initform 0.0)
   (errorsDEPRECATED
    :reader errorsDEPRECATED
    :initarg :errorsDEPRECATED
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (brake
    :reader brake
    :initarg :brake
    :type cl:float
    :initform 0.0)
   (vEgo
    :reader vEgo
    :initarg :vEgo
    :type cl:float
    :initform 0.0)
   (steeringAngle
    :reader steeringAngle
    :initarg :steeringAngle
    :type cl:float
    :initform 0.0)
   (leftBlinker
    :reader leftBlinker
    :initarg :leftBlinker
    :type cl:boolean
    :initform cl:nil)
   (wheelSpeeds
    :reader wheelSpeeds
    :initarg :wheelSpeeds
    :type openpilot_bridge-msg:WheelSpeeds
    :initform (cl:make-instance 'openpilot_bridge-msg:WheelSpeeds))
   (steeringRateLimited
    :reader steeringRateLimited
    :initarg :steeringRateLimited
    :type cl:boolean
    :initform cl:nil)
   (stockFcw
    :reader stockFcw
    :initarg :stockFcw
    :type cl:boolean
    :initform cl:nil)
   (doorOpen
    :reader doorOpen
    :initarg :doorOpen
    :type cl:boolean
    :initform cl:nil)
   (steeringRate
    :reader steeringRate
    :initarg :steeringRate
    :type cl:float
    :initform 0.0)
   (events
    :reader events
    :initarg :events
    :type (cl:vector openpilot_bridge-msg:CarEvent)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CarEvent :initial-element (cl:make-instance 'openpilot_bridge-msg:CarEvent)))
   (steeringPressed
    :reader steeringPressed
    :initarg :steeringPressed
    :type cl:boolean
    :initform cl:nil)
   (canValid
    :reader canValid
    :initarg :canValid
    :type cl:boolean
    :initform cl:nil)
   (cruiseState
    :reader cruiseState
    :initarg :cruiseState
    :type openpilot_bridge-msg:CruiseState
    :initform (cl:make-instance 'openpilot_bridge-msg:CruiseState))
   (yawRate
    :reader yawRate
    :initarg :yawRate
    :type cl:float
    :initform 0.0)
   (steeringTorqueEps
    :reader steeringTorqueEps
    :initarg :steeringTorqueEps
    :type cl:float
    :initform 0.0)
   (gas
    :reader gas
    :initarg :gas
    :type cl:float
    :initform 0.0)
   (steeringTorque
    :reader steeringTorque
    :initarg :steeringTorque
    :type cl:float
    :initform 0.0)
   (genericToggle
    :reader genericToggle
    :initarg :genericToggle
    :type cl:boolean
    :initform cl:nil)
   (brakeLights
    :reader brakeLights
    :initarg :brakeLights
    :type cl:boolean
    :initform cl:nil)
   (buttonEvents
    :reader buttonEvents
    :initarg :buttonEvents
    :type (cl:vector openpilot_bridge-msg:ButtonEvent)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:ButtonEvent :initial-element (cl:make-instance 'openpilot_bridge-msg:ButtonEvent)))
   (standstill
    :reader standstill
    :initarg :standstill
    :type cl:boolean
    :initform cl:nil)
   (gasPressed
    :reader gasPressed
    :initarg :gasPressed
    :type cl:boolean
    :initform cl:nil)
   (stockAeb
    :reader stockAeb
    :initarg :stockAeb
    :type cl:boolean
    :initform cl:nil)
   (rightBlinker
    :reader rightBlinker
    :initarg :rightBlinker
    :type cl:boolean
    :initform cl:nil)
   (brakePressed
    :reader brakePressed
    :initarg :brakePressed
    :type cl:boolean
    :initform cl:nil)
   (aEgo
    :reader aEgo
    :initarg :aEgo
    :type cl:float
    :initform 0.0)
   (canMonoTimes
    :reader canMonoTimes
    :initarg :canMonoTimes
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass CarState (<CarState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CarState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CarState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CarState> is deprecated: use openpilot_bridge-msg:CarState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gearShifter-val :lambda-list '(m))
(cl:defmethod gearShifter-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gearShifter-val is deprecated.  Use openpilot_bridge-msg:gearShifter instead.")
  (gearShifter m))

(cl:ensure-generic-function 'seatbeltUnlatched-val :lambda-list '(m))
(cl:defmethod seatbeltUnlatched-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:seatbeltUnlatched-val is deprecated.  Use openpilot_bridge-msg:seatbeltUnlatched instead.")
  (seatbeltUnlatched m))

(cl:ensure-generic-function 'clutchPressed-val :lambda-list '(m))
(cl:defmethod clutchPressed-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clutchPressed-val is deprecated.  Use openpilot_bridge-msg:clutchPressed instead.")
  (clutchPressed m))

(cl:ensure-generic-function 'vEgoRaw-val :lambda-list '(m))
(cl:defmethod vEgoRaw-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vEgoRaw-val is deprecated.  Use openpilot_bridge-msg:vEgoRaw instead.")
  (vEgoRaw m))

(cl:ensure-generic-function 'errorsDEPRECATED-val :lambda-list '(m))
(cl:defmethod errorsDEPRECATED-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:errorsDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:errorsDEPRECATED instead.")
  (errorsDEPRECATED m))

(cl:ensure-generic-function 'brake-val :lambda-list '(m))
(cl:defmethod brake-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brake-val is deprecated.  Use openpilot_bridge-msg:brake instead.")
  (brake m))

(cl:ensure-generic-function 'vEgo-val :lambda-list '(m))
(cl:defmethod vEgo-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vEgo-val is deprecated.  Use openpilot_bridge-msg:vEgo instead.")
  (vEgo m))

(cl:ensure-generic-function 'steeringAngle-val :lambda-list '(m))
(cl:defmethod steeringAngle-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringAngle-val is deprecated.  Use openpilot_bridge-msg:steeringAngle instead.")
  (steeringAngle m))

(cl:ensure-generic-function 'leftBlinker-val :lambda-list '(m))
(cl:defmethod leftBlinker-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftBlinker-val is deprecated.  Use openpilot_bridge-msg:leftBlinker instead.")
  (leftBlinker m))

(cl:ensure-generic-function 'wheelSpeeds-val :lambda-list '(m))
(cl:defmethod wheelSpeeds-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:wheelSpeeds-val is deprecated.  Use openpilot_bridge-msg:wheelSpeeds instead.")
  (wheelSpeeds m))

(cl:ensure-generic-function 'steeringRateLimited-val :lambda-list '(m))
(cl:defmethod steeringRateLimited-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringRateLimited-val is deprecated.  Use openpilot_bridge-msg:steeringRateLimited instead.")
  (steeringRateLimited m))

(cl:ensure-generic-function 'stockFcw-val :lambda-list '(m))
(cl:defmethod stockFcw-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stockFcw-val is deprecated.  Use openpilot_bridge-msg:stockFcw instead.")
  (stockFcw m))

(cl:ensure-generic-function 'doorOpen-val :lambda-list '(m))
(cl:defmethod doorOpen-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:doorOpen-val is deprecated.  Use openpilot_bridge-msg:doorOpen instead.")
  (doorOpen m))

(cl:ensure-generic-function 'steeringRate-val :lambda-list '(m))
(cl:defmethod steeringRate-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringRate-val is deprecated.  Use openpilot_bridge-msg:steeringRate instead.")
  (steeringRate m))

(cl:ensure-generic-function 'events-val :lambda-list '(m))
(cl:defmethod events-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:events-val is deprecated.  Use openpilot_bridge-msg:events instead.")
  (events m))

(cl:ensure-generic-function 'steeringPressed-val :lambda-list '(m))
(cl:defmethod steeringPressed-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringPressed-val is deprecated.  Use openpilot_bridge-msg:steeringPressed instead.")
  (steeringPressed m))

(cl:ensure-generic-function 'canValid-val :lambda-list '(m))
(cl:defmethod canValid-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canValid-val is deprecated.  Use openpilot_bridge-msg:canValid instead.")
  (canValid m))

(cl:ensure-generic-function 'cruiseState-val :lambda-list '(m))
(cl:defmethod cruiseState-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cruiseState-val is deprecated.  Use openpilot_bridge-msg:cruiseState instead.")
  (cruiseState m))

(cl:ensure-generic-function 'yawRate-val :lambda-list '(m))
(cl:defmethod yawRate-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yawRate-val is deprecated.  Use openpilot_bridge-msg:yawRate instead.")
  (yawRate m))

(cl:ensure-generic-function 'steeringTorqueEps-val :lambda-list '(m))
(cl:defmethod steeringTorqueEps-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringTorqueEps-val is deprecated.  Use openpilot_bridge-msg:steeringTorqueEps instead.")
  (steeringTorqueEps m))

(cl:ensure-generic-function 'gas-val :lambda-list '(m))
(cl:defmethod gas-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gas-val is deprecated.  Use openpilot_bridge-msg:gas instead.")
  (gas m))

(cl:ensure-generic-function 'steeringTorque-val :lambda-list '(m))
(cl:defmethod steeringTorque-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringTorque-val is deprecated.  Use openpilot_bridge-msg:steeringTorque instead.")
  (steeringTorque m))

(cl:ensure-generic-function 'genericToggle-val :lambda-list '(m))
(cl:defmethod genericToggle-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:genericToggle-val is deprecated.  Use openpilot_bridge-msg:genericToggle instead.")
  (genericToggle m))

(cl:ensure-generic-function 'brakeLights-val :lambda-list '(m))
(cl:defmethod brakeLights-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakeLights-val is deprecated.  Use openpilot_bridge-msg:brakeLights instead.")
  (brakeLights m))

(cl:ensure-generic-function 'buttonEvents-val :lambda-list '(m))
(cl:defmethod buttonEvents-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:buttonEvents-val is deprecated.  Use openpilot_bridge-msg:buttonEvents instead.")
  (buttonEvents m))

(cl:ensure-generic-function 'standstill-val :lambda-list '(m))
(cl:defmethod standstill-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:standstill-val is deprecated.  Use openpilot_bridge-msg:standstill instead.")
  (standstill m))

(cl:ensure-generic-function 'gasPressed-val :lambda-list '(m))
(cl:defmethod gasPressed-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasPressed-val is deprecated.  Use openpilot_bridge-msg:gasPressed instead.")
  (gasPressed m))

(cl:ensure-generic-function 'stockAeb-val :lambda-list '(m))
(cl:defmethod stockAeb-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stockAeb-val is deprecated.  Use openpilot_bridge-msg:stockAeb instead.")
  (stockAeb m))

(cl:ensure-generic-function 'rightBlinker-val :lambda-list '(m))
(cl:defmethod rightBlinker-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightBlinker-val is deprecated.  Use openpilot_bridge-msg:rightBlinker instead.")
  (rightBlinker m))

(cl:ensure-generic-function 'brakePressed-val :lambda-list '(m))
(cl:defmethod brakePressed-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakePressed-val is deprecated.  Use openpilot_bridge-msg:brakePressed instead.")
  (brakePressed m))

(cl:ensure-generic-function 'aEgo-val :lambda-list '(m))
(cl:defmethod aEgo-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aEgo-val is deprecated.  Use openpilot_bridge-msg:aEgo instead.")
  (aEgo m))

(cl:ensure-generic-function 'canMonoTimes-val :lambda-list '(m))
(cl:defmethod canMonoTimes-val ((m <CarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canMonoTimes-val is deprecated.  Use openpilot_bridge-msg:canMonoTimes instead.")
  (canMonoTimes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CarState>) ostream)
  "Serializes a message object of type '<CarState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gearShifter)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gearShifter)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gearShifter)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gearShifter)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'seatbeltUnlatched) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'clutchPressed) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vEgoRaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'errorsDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'errorsDEPRECATED))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vEgo))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steeringAngle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'leftBlinker) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'wheelSpeeds) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'steeringRateLimited) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stockFcw) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'doorOpen) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steeringRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'events))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'events))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'steeringPressed) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'canValid) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cruiseState) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yawRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steeringTorqueEps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gas))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steeringTorque))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'genericToggle) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'brakeLights) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'buttonEvents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'buttonEvents))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'standstill) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gasPressed) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stockAeb) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rightBlinker) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'brakePressed) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aEgo))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'canMonoTimes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'canMonoTimes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CarState>) istream)
  "Deserializes a message object of type '<CarState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gearShifter)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gearShifter)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gearShifter)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gearShifter)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'seatbeltUnlatched) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'clutchPressed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vEgoRaw) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'errorsDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'errorsDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vEgo) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steeringAngle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'leftBlinker) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'wheelSpeeds) istream)
    (cl:setf (cl:slot-value msg 'steeringRateLimited) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'stockFcw) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'doorOpen) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steeringRate) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'events) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'events)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CarEvent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'steeringPressed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'canValid) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cruiseState) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yawRate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steeringTorqueEps) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gas) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steeringTorque) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'genericToggle) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'brakeLights) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'buttonEvents) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'buttonEvents)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:ButtonEvent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'standstill) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gasPressed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'stockAeb) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rightBlinker) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'brakePressed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aEgo) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'canMonoTimes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'canMonoTimes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CarState>)))
  "Returns string type for a message object of type '<CarState>"
  "openpilot_bridge/CarState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CarState)))
  "Returns string type for a message object of type 'CarState"
  "openpilot_bridge/CarState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CarState>)))
  "Returns md5sum for a message object of type '<CarState>"
  "aa82270c536e806e4bbbc48f00d9d6a7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CarState)))
  "Returns md5sum for a message object of type 'CarState"
  "aa82270c536e806e4bbbc48f00d9d6a7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CarState>)))
  "Returns full string definition for message of type '<CarState>"
  (cl:format cl:nil "Header header~%~%uint32 gearShifter # enum const: GearShifter~%bool seatbeltUnlatched~%bool clutchPressed~%float32 vEgoRaw~%uint32[] errorsDEPRECATED # enum const: EventName~%float32 brake~%float32 vEgo~%float32 steeringAngle~%bool leftBlinker~%WheelSpeeds wheelSpeeds~%bool steeringRateLimited~%bool stockFcw~%bool doorOpen~%float32 steeringRate~%CarEvent[] events~%bool steeringPressed~%bool canValid~%CruiseState cruiseState~%float32 yawRate~%float32 steeringTorqueEps~%float32 gas~%float32 steeringTorque~%bool genericToggle~%bool brakeLights~%ButtonEvent[] buttonEvents~%bool standstill~%bool gasPressed~%bool stockAeb~%bool rightBlinker~%bool brakePressed~%float32 aEgo~%int64[] canMonoTimes~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/WheelSpeeds~%Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/CruiseState~%Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: openpilot_bridge/ButtonEvent~%Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CarState)))
  "Returns full string definition for message of type 'CarState"
  (cl:format cl:nil "Header header~%~%uint32 gearShifter # enum const: GearShifter~%bool seatbeltUnlatched~%bool clutchPressed~%float32 vEgoRaw~%uint32[] errorsDEPRECATED # enum const: EventName~%float32 brake~%float32 vEgo~%float32 steeringAngle~%bool leftBlinker~%WheelSpeeds wheelSpeeds~%bool steeringRateLimited~%bool stockFcw~%bool doorOpen~%float32 steeringRate~%CarEvent[] events~%bool steeringPressed~%bool canValid~%CruiseState cruiseState~%float32 yawRate~%float32 steeringTorqueEps~%float32 gas~%float32 steeringTorque~%bool genericToggle~%bool brakeLights~%ButtonEvent[] buttonEvents~%bool standstill~%bool gasPressed~%bool stockAeb~%bool rightBlinker~%bool brakePressed~%float32 aEgo~%int64[] canMonoTimes~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/WheelSpeeds~%Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/CruiseState~%Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: openpilot_bridge/ButtonEvent~%Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CarState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'errorsDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'wheelSpeeds))
     1
     1
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'events) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cruiseState))
     4
     4
     4
     4
     1
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'buttonEvents) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     1
     1
     1
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'canMonoTimes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CarState>))
  "Converts a ROS message object to a list"
  (cl:list 'CarState
    (cl:cons ':header (header msg))
    (cl:cons ':gearShifter (gearShifter msg))
    (cl:cons ':seatbeltUnlatched (seatbeltUnlatched msg))
    (cl:cons ':clutchPressed (clutchPressed msg))
    (cl:cons ':vEgoRaw (vEgoRaw msg))
    (cl:cons ':errorsDEPRECATED (errorsDEPRECATED msg))
    (cl:cons ':brake (brake msg))
    (cl:cons ':vEgo (vEgo msg))
    (cl:cons ':steeringAngle (steeringAngle msg))
    (cl:cons ':leftBlinker (leftBlinker msg))
    (cl:cons ':wheelSpeeds (wheelSpeeds msg))
    (cl:cons ':steeringRateLimited (steeringRateLimited msg))
    (cl:cons ':stockFcw (stockFcw msg))
    (cl:cons ':doorOpen (doorOpen msg))
    (cl:cons ':steeringRate (steeringRate msg))
    (cl:cons ':events (events msg))
    (cl:cons ':steeringPressed (steeringPressed msg))
    (cl:cons ':canValid (canValid msg))
    (cl:cons ':cruiseState (cruiseState msg))
    (cl:cons ':yawRate (yawRate msg))
    (cl:cons ':steeringTorqueEps (steeringTorqueEps msg))
    (cl:cons ':gas (gas msg))
    (cl:cons ':steeringTorque (steeringTorque msg))
    (cl:cons ':genericToggle (genericToggle msg))
    (cl:cons ':brakeLights (brakeLights msg))
    (cl:cons ':buttonEvents (buttonEvents msg))
    (cl:cons ':standstill (standstill msg))
    (cl:cons ':gasPressed (gasPressed msg))
    (cl:cons ':stockAeb (stockAeb msg))
    (cl:cons ':rightBlinker (rightBlinker msg))
    (cl:cons ':brakePressed (brakePressed msg))
    (cl:cons ':aEgo (aEgo msg))
    (cl:cons ':canMonoTimes (canMonoTimes msg))
))
