; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude RadarState.msg.html

(cl:defclass <RadarState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (warpMatrixDEPRECATED
    :reader warpMatrixDEPRECATED
    :initarg :warpMatrixDEPRECATED
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (calCycleDEPRECATED
    :reader calCycleDEPRECATED
    :initarg :calCycleDEPRECATED
    :type cl:integer
    :initform 0)
   (calStatusDEPRECATED
    :reader calStatusDEPRECATED
    :initarg :calStatusDEPRECATED
    :type cl:integer
    :initform 0)
   (mdMonoTime
    :reader mdMonoTime
    :initarg :mdMonoTime
    :type cl:integer
    :initform 0)
   (leadTwo
    :reader leadTwo
    :initarg :leadTwo
    :type openpilot_bridge-msg:LeadData
    :initform (cl:make-instance 'openpilot_bridge-msg:LeadData))
   (calPercDEPRECATED
    :reader calPercDEPRECATED
    :initarg :calPercDEPRECATED
    :type cl:integer
    :initform 0)
   (radarErrors
    :reader radarErrors
    :initarg :radarErrors
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (cumLagMs
    :reader cumLagMs
    :initarg :cumLagMs
    :type cl:float
    :initform 0.0)
   (canMonoTimes
    :reader canMonoTimes
    :initarg :canMonoTimes
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (angleOffsetDEPRECATED
    :reader angleOffsetDEPRECATED
    :initarg :angleOffsetDEPRECATED
    :type cl:float
    :initform 0.0)
   (ftMonoTimeDEPRECATED
    :reader ftMonoTimeDEPRECATED
    :initarg :ftMonoTimeDEPRECATED
    :type cl:integer
    :initform 0)
   (leadOne
    :reader leadOne
    :initarg :leadOne
    :type openpilot_bridge-msg:LeadData
    :initform (cl:make-instance 'openpilot_bridge-msg:LeadData))
   (controlsStateMonoTime
    :reader controlsStateMonoTime
    :initarg :controlsStateMonoTime
    :type cl:integer
    :initform 0)
   (radarPoints
    :reader radarPoints
    :initarg :radarPoints
    :type (cl:vector openpilot_bridge-msg:RadarPoint)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:RadarPoint :initial-element (cl:make-instance 'openpilot_bridge-msg:RadarPoint)))
   (liveTracks
    :reader liveTracks
    :initarg :liveTracks
    :type (cl:vector openpilot_bridge-msg:LiveTracks)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:LiveTracks :initial-element (cl:make-instance 'openpilot_bridge-msg:LiveTracks))))
)

(cl:defclass RadarState (<RadarState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RadarState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RadarState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<RadarState> is deprecated: use openpilot_bridge-msg:RadarState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'warpMatrixDEPRECATED-val :lambda-list '(m))
(cl:defmethod warpMatrixDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:warpMatrixDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:warpMatrixDEPRECATED instead.")
  (warpMatrixDEPRECATED m))

(cl:ensure-generic-function 'calCycleDEPRECATED-val :lambda-list '(m))
(cl:defmethod calCycleDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:calCycleDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:calCycleDEPRECATED instead.")
  (calCycleDEPRECATED m))

(cl:ensure-generic-function 'calStatusDEPRECATED-val :lambda-list '(m))
(cl:defmethod calStatusDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:calStatusDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:calStatusDEPRECATED instead.")
  (calStatusDEPRECATED m))

(cl:ensure-generic-function 'mdMonoTime-val :lambda-list '(m))
(cl:defmethod mdMonoTime-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mdMonoTime-val is deprecated.  Use openpilot_bridge-msg:mdMonoTime instead.")
  (mdMonoTime m))

(cl:ensure-generic-function 'leadTwo-val :lambda-list '(m))
(cl:defmethod leadTwo-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leadTwo-val is deprecated.  Use openpilot_bridge-msg:leadTwo instead.")
  (leadTwo m))

(cl:ensure-generic-function 'calPercDEPRECATED-val :lambda-list '(m))
(cl:defmethod calPercDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:calPercDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:calPercDEPRECATED instead.")
  (calPercDEPRECATED m))

(cl:ensure-generic-function 'radarErrors-val :lambda-list '(m))
(cl:defmethod radarErrors-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarErrors-val is deprecated.  Use openpilot_bridge-msg:radarErrors instead.")
  (radarErrors m))

(cl:ensure-generic-function 'cumLagMs-val :lambda-list '(m))
(cl:defmethod cumLagMs-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cumLagMs-val is deprecated.  Use openpilot_bridge-msg:cumLagMs instead.")
  (cumLagMs m))

(cl:ensure-generic-function 'canMonoTimes-val :lambda-list '(m))
(cl:defmethod canMonoTimes-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canMonoTimes-val is deprecated.  Use openpilot_bridge-msg:canMonoTimes instead.")
  (canMonoTimes m))

(cl:ensure-generic-function 'angleOffsetDEPRECATED-val :lambda-list '(m))
(cl:defmethod angleOffsetDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleOffsetDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:angleOffsetDEPRECATED instead.")
  (angleOffsetDEPRECATED m))

(cl:ensure-generic-function 'ftMonoTimeDEPRECATED-val :lambda-list '(m))
(cl:defmethod ftMonoTimeDEPRECATED-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ftMonoTimeDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:ftMonoTimeDEPRECATED instead.")
  (ftMonoTimeDEPRECATED m))

(cl:ensure-generic-function 'leadOne-val :lambda-list '(m))
(cl:defmethod leadOne-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leadOne-val is deprecated.  Use openpilot_bridge-msg:leadOne instead.")
  (leadOne m))

(cl:ensure-generic-function 'controlsStateMonoTime-val :lambda-list '(m))
(cl:defmethod controlsStateMonoTime-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:controlsStateMonoTime-val is deprecated.  Use openpilot_bridge-msg:controlsStateMonoTime instead.")
  (controlsStateMonoTime m))

(cl:ensure-generic-function 'radarPoints-val :lambda-list '(m))
(cl:defmethod radarPoints-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarPoints-val is deprecated.  Use openpilot_bridge-msg:radarPoints instead.")
  (radarPoints m))

(cl:ensure-generic-function 'liveTracks-val :lambda-list '(m))
(cl:defmethod liveTracks-val ((m <RadarState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:liveTracks-val is deprecated.  Use openpilot_bridge-msg:liveTracks instead.")
  (liveTracks m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RadarState>) ostream)
  "Serializes a message object of type '<RadarState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'warpMatrixDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'warpMatrixDEPRECATED))
  (cl:let* ((signed (cl:slot-value msg 'calCycleDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'calStatusDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'mdMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leadTwo) ostream)
  (cl:let* ((signed (cl:slot-value msg 'calPercDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'radarErrors))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'radarErrors))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cumLagMs))))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleOffsetDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'ftMonoTimeDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leadOne) ostream)
  (cl:let* ((signed (cl:slot-value msg 'controlsStateMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'radarPoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'radarPoints))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'liveTracks))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'liveTracks))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RadarState>) istream)
  "Deserializes a message object of type '<RadarState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'warpMatrixDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'warpMatrixDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'calCycleDEPRECATED) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'calStatusDEPRECATED) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mdMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leadTwo) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'calPercDEPRECATED) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'radarErrors) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'radarErrors)))
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
    (cl:setf (cl:slot-value msg 'cumLagMs) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleOffsetDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ftMonoTimeDEPRECATED) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leadOne) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'controlsStateMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'radarPoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'radarPoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:RadarPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RadarState>)))
  "Returns string type for a message object of type '<RadarState>"
  "openpilot_bridge/RadarState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RadarState)))
  "Returns string type for a message object of type 'RadarState"
  "openpilot_bridge/RadarState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RadarState>)))
  "Returns md5sum for a message object of type '<RadarState>"
  "6ae0f29b5053e8a1901524794cbb99a2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RadarState)))
  "Returns md5sum for a message object of type 'RadarState"
  "6ae0f29b5053e8a1901524794cbb99a2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RadarState>)))
  "Returns full string definition for message of type '<RadarState>"
  (cl:format cl:nil "Header header~%~%float32[] warpMatrixDEPRECATED~%int32 calCycleDEPRECATED~%int32 calStatusDEPRECATED~%int64 mdMonoTime~%LeadData leadTwo~%int32 calPercDEPRECATED~%uint32[] radarErrors # enum const: Error~%float32 cumLagMs~%int64[] canMonoTimes~%float32 angleOffsetDEPRECATED~%int64 ftMonoTimeDEPRECATED~%LeadData leadOne~%int64 controlsStateMonoTime~%RadarPoint[] radarPoints~%LiveTracks[] liveTracks~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/RadarPoint~%Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: openpilot_bridge/LiveTracks~%Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RadarState)))
  "Returns full string definition for message of type 'RadarState"
  (cl:format cl:nil "Header header~%~%float32[] warpMatrixDEPRECATED~%int32 calCycleDEPRECATED~%int32 calStatusDEPRECATED~%int64 mdMonoTime~%LeadData leadTwo~%int32 calPercDEPRECATED~%uint32[] radarErrors # enum const: Error~%float32 cumLagMs~%int64[] canMonoTimes~%float32 angleOffsetDEPRECATED~%int64 ftMonoTimeDEPRECATED~%LeadData leadOne~%int64 controlsStateMonoTime~%RadarPoint[] radarPoints~%LiveTracks[] liveTracks~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/RadarPoint~%Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: openpilot_bridge/LiveTracks~%Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RadarState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'warpMatrixDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leadTwo))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'radarErrors) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'canMonoTimes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leadOne))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'radarPoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'liveTracks) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RadarState>))
  "Converts a ROS message object to a list"
  (cl:list 'RadarState
    (cl:cons ':header (header msg))
    (cl:cons ':warpMatrixDEPRECATED (warpMatrixDEPRECATED msg))
    (cl:cons ':calCycleDEPRECATED (calCycleDEPRECATED msg))
    (cl:cons ':calStatusDEPRECATED (calStatusDEPRECATED msg))
    (cl:cons ':mdMonoTime (mdMonoTime msg))
    (cl:cons ':leadTwo (leadTwo msg))
    (cl:cons ':calPercDEPRECATED (calPercDEPRECATED msg))
    (cl:cons ':radarErrors (radarErrors msg))
    (cl:cons ':cumLagMs (cumLagMs msg))
    (cl:cons ':canMonoTimes (canMonoTimes msg))
    (cl:cons ':angleOffsetDEPRECATED (angleOffsetDEPRECATED msg))
    (cl:cons ':ftMonoTimeDEPRECATED (ftMonoTimeDEPRECATED msg))
    (cl:cons ':leadOne (leadOne msg))
    (cl:cons ':controlsStateMonoTime (controlsStateMonoTime msg))
    (cl:cons ':radarPoints (radarPoints msg))
    (cl:cons ':liveTracks (liveTracks msg))
))
