; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude PathPlan.msg.html

(cl:defclass <PathPlan> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (angleSteers
    :reader angleSteers
    :initarg :angleSteers
    :type cl:float
    :initform 0.0)
   (commIssue
    :reader commIssue
    :initarg :commIssue
    :type cl:boolean
    :initform cl:nil)
   (lPoly
    :reader lPoly
    :initarg :lPoly
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (laneChangeState
    :reader laneChangeState
    :initarg :laneChangeState
    :type cl:integer
    :initform 0)
   (sensorValid
    :reader sensorValid
    :initarg :sensorValid
    :type cl:boolean
    :initform cl:nil)
   (mpcSolutionValid
    :reader mpcSolutionValid
    :initarg :mpcSolutionValid
    :type cl:boolean
    :initform cl:nil)
   (lProb
    :reader lProb
    :initarg :lProb
    :type cl:float
    :initform 0.0)
   (modelValidDEPRECATED
    :reader modelValidDEPRECATED
    :initarg :modelValidDEPRECATED
    :type cl:boolean
    :initform cl:nil)
   (rProb
    :reader rProb
    :initarg :rProb
    :type cl:float
    :initform 0.0)
   (cProb
    :reader cProb
    :initarg :cProb
    :type cl:float
    :initform 0.0)
   (rPoly
    :reader rPoly
    :initarg :rPoly
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (laneWidth
    :reader laneWidth
    :initarg :laneWidth
    :type cl:float
    :initform 0.0)
   (angleOffset
    :reader angleOffset
    :initarg :angleOffset
    :type cl:float
    :initform 0.0)
   (rateSteers
    :reader rateSteers
    :initarg :rateSteers
    :type cl:float
    :initform 0.0)
   (laneChangeDirection
    :reader laneChangeDirection
    :initarg :laneChangeDirection
    :type cl:integer
    :initform 0)
   (paramsValid
    :reader paramsValid
    :initarg :paramsValid
    :type cl:boolean
    :initform cl:nil)
   (cPoly
    :reader cPoly
    :initarg :cPoly
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (posenetValid
    :reader posenetValid
    :initarg :posenetValid
    :type cl:boolean
    :initform cl:nil)
   (dPoly
    :reader dPoly
    :initarg :dPoly
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (desire
    :reader desire
    :initarg :desire
    :type cl:integer
    :initform 0))
)

(cl:defclass PathPlan (<PathPlan>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PathPlan>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PathPlan)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<PathPlan> is deprecated: use openpilot_bridge-msg:PathPlan instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'angleSteers-val :lambda-list '(m))
(cl:defmethod angleSteers-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleSteers-val is deprecated.  Use openpilot_bridge-msg:angleSteers instead.")
  (angleSteers m))

(cl:ensure-generic-function 'commIssue-val :lambda-list '(m))
(cl:defmethod commIssue-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:commIssue-val is deprecated.  Use openpilot_bridge-msg:commIssue instead.")
  (commIssue m))

(cl:ensure-generic-function 'lPoly-val :lambda-list '(m))
(cl:defmethod lPoly-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lPoly-val is deprecated.  Use openpilot_bridge-msg:lPoly instead.")
  (lPoly m))

(cl:ensure-generic-function 'laneChangeState-val :lambda-list '(m))
(cl:defmethod laneChangeState-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:laneChangeState-val is deprecated.  Use openpilot_bridge-msg:laneChangeState instead.")
  (laneChangeState m))

(cl:ensure-generic-function 'sensorValid-val :lambda-list '(m))
(cl:defmethod sensorValid-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensorValid-val is deprecated.  Use openpilot_bridge-msg:sensorValid instead.")
  (sensorValid m))

(cl:ensure-generic-function 'mpcSolutionValid-val :lambda-list '(m))
(cl:defmethod mpcSolutionValid-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mpcSolutionValid-val is deprecated.  Use openpilot_bridge-msg:mpcSolutionValid instead.")
  (mpcSolutionValid m))

(cl:ensure-generic-function 'lProb-val :lambda-list '(m))
(cl:defmethod lProb-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lProb-val is deprecated.  Use openpilot_bridge-msg:lProb instead.")
  (lProb m))

(cl:ensure-generic-function 'modelValidDEPRECATED-val :lambda-list '(m))
(cl:defmethod modelValidDEPRECATED-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:modelValidDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:modelValidDEPRECATED instead.")
  (modelValidDEPRECATED m))

(cl:ensure-generic-function 'rProb-val :lambda-list '(m))
(cl:defmethod rProb-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rProb-val is deprecated.  Use openpilot_bridge-msg:rProb instead.")
  (rProb m))

(cl:ensure-generic-function 'cProb-val :lambda-list '(m))
(cl:defmethod cProb-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cProb-val is deprecated.  Use openpilot_bridge-msg:cProb instead.")
  (cProb m))

(cl:ensure-generic-function 'rPoly-val :lambda-list '(m))
(cl:defmethod rPoly-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rPoly-val is deprecated.  Use openpilot_bridge-msg:rPoly instead.")
  (rPoly m))

(cl:ensure-generic-function 'laneWidth-val :lambda-list '(m))
(cl:defmethod laneWidth-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:laneWidth-val is deprecated.  Use openpilot_bridge-msg:laneWidth instead.")
  (laneWidth m))

(cl:ensure-generic-function 'angleOffset-val :lambda-list '(m))
(cl:defmethod angleOffset-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleOffset-val is deprecated.  Use openpilot_bridge-msg:angleOffset instead.")
  (angleOffset m))

(cl:ensure-generic-function 'rateSteers-val :lambda-list '(m))
(cl:defmethod rateSteers-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rateSteers-val is deprecated.  Use openpilot_bridge-msg:rateSteers instead.")
  (rateSteers m))

(cl:ensure-generic-function 'laneChangeDirection-val :lambda-list '(m))
(cl:defmethod laneChangeDirection-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:laneChangeDirection-val is deprecated.  Use openpilot_bridge-msg:laneChangeDirection instead.")
  (laneChangeDirection m))

(cl:ensure-generic-function 'paramsValid-val :lambda-list '(m))
(cl:defmethod paramsValid-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:paramsValid-val is deprecated.  Use openpilot_bridge-msg:paramsValid instead.")
  (paramsValid m))

(cl:ensure-generic-function 'cPoly-val :lambda-list '(m))
(cl:defmethod cPoly-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cPoly-val is deprecated.  Use openpilot_bridge-msg:cPoly instead.")
  (cPoly m))

(cl:ensure-generic-function 'posenetValid-val :lambda-list '(m))
(cl:defmethod posenetValid-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:posenetValid-val is deprecated.  Use openpilot_bridge-msg:posenetValid instead.")
  (posenetValid m))

(cl:ensure-generic-function 'dPoly-val :lambda-list '(m))
(cl:defmethod dPoly-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dPoly-val is deprecated.  Use openpilot_bridge-msg:dPoly instead.")
  (dPoly m))

(cl:ensure-generic-function 'desire-val :lambda-list '(m))
(cl:defmethod desire-val ((m <PathPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:desire-val is deprecated.  Use openpilot_bridge-msg:desire instead.")
  (desire m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PathPlan>) ostream)
  "Serializes a message object of type '<PathPlan>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleSteers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'commIssue) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lPoly))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'lPoly))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'laneChangeState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'laneChangeState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'laneChangeState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'laneChangeState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'sensorValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mpcSolutionValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'lProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'modelValidDEPRECATED) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rPoly))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'rPoly))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'laneWidth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleOffset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rateSteers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'laneChangeDirection)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'laneChangeDirection)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'laneChangeDirection)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'laneChangeDirection)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'paramsValid) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cPoly))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'cPoly))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'posenetValid) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'dPoly))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'dPoly))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'desire)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'desire)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'desire)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'desire)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PathPlan>) istream)
  "Deserializes a message object of type '<PathPlan>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleSteers) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'commIssue) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lPoly) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lPoly)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'laneChangeState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'laneChangeState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'laneChangeState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'laneChangeState)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sensorValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'mpcSolutionValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'modelValidDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cProb) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rPoly) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rPoly)))
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
    (cl:setf (cl:slot-value msg 'laneWidth) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleOffset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rateSteers) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'laneChangeDirection)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'laneChangeDirection)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'laneChangeDirection)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'laneChangeDirection)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'paramsValid) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cPoly) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cPoly)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'posenetValid) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'dPoly) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'dPoly)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'desire)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'desire)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'desire)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'desire)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PathPlan>)))
  "Returns string type for a message object of type '<PathPlan>"
  "openpilot_bridge/PathPlan")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathPlan)))
  "Returns string type for a message object of type 'PathPlan"
  "openpilot_bridge/PathPlan")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PathPlan>)))
  "Returns md5sum for a message object of type '<PathPlan>"
  "39d44bb8d0ae27698feefef0dbe76a71")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PathPlan)))
  "Returns md5sum for a message object of type 'PathPlan"
  "39d44bb8d0ae27698feefef0dbe76a71")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PathPlan>)))
  "Returns full string definition for message of type '<PathPlan>"
  (cl:format cl:nil "Header header~%~%float32 angleSteers~%bool commIssue~%float32[] lPoly~%uint32 laneChangeState # enum const: LaneChangeState~%bool sensorValid~%bool mpcSolutionValid~%float32 lProb~%bool modelValidDEPRECATED~%float32 rProb~%float32 cProb~%float32[] rPoly~%float32 laneWidth~%float32 angleOffset~%float32 rateSteers~%uint32 laneChangeDirection # enum const: LaneChangeDirection~%bool paramsValid~%float32[] cPoly~%bool posenetValid~%float32[] dPoly~%uint32 desire # enum const: Desire~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PathPlan)))
  "Returns full string definition for message of type 'PathPlan"
  (cl:format cl:nil "Header header~%~%float32 angleSteers~%bool commIssue~%float32[] lPoly~%uint32 laneChangeState # enum const: LaneChangeState~%bool sensorValid~%bool mpcSolutionValid~%float32 lProb~%bool modelValidDEPRECATED~%float32 rProb~%float32 cProb~%float32[] rPoly~%float32 laneWidth~%float32 angleOffset~%float32 rateSteers~%uint32 laneChangeDirection # enum const: LaneChangeDirection~%bool paramsValid~%float32[] cPoly~%bool posenetValid~%float32[] dPoly~%uint32 desire # enum const: Desire~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PathPlan>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lPoly) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     1
     1
     4
     1
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rPoly) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     4
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cPoly) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'dPoly) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PathPlan>))
  "Converts a ROS message object to a list"
  (cl:list 'PathPlan
    (cl:cons ':header (header msg))
    (cl:cons ':angleSteers (angleSteers msg))
    (cl:cons ':commIssue (commIssue msg))
    (cl:cons ':lPoly (lPoly msg))
    (cl:cons ':laneChangeState (laneChangeState msg))
    (cl:cons ':sensorValid (sensorValid msg))
    (cl:cons ':mpcSolutionValid (mpcSolutionValid msg))
    (cl:cons ':lProb (lProb msg))
    (cl:cons ':modelValidDEPRECATED (modelValidDEPRECATED msg))
    (cl:cons ':rProb (rProb msg))
    (cl:cons ':cProb (cProb msg))
    (cl:cons ':rPoly (rPoly msg))
    (cl:cons ':laneWidth (laneWidth msg))
    (cl:cons ':angleOffset (angleOffset msg))
    (cl:cons ':rateSteers (rateSteers msg))
    (cl:cons ':laneChangeDirection (laneChangeDirection msg))
    (cl:cons ':paramsValid (paramsValid msg))
    (cl:cons ':cPoly (cPoly msg))
    (cl:cons ':posenetValid (posenetValid msg))
    (cl:cons ':dPoly (dPoly msg))
    (cl:cons ':desire (desire msg))
))
