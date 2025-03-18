; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Plan.msg.html

(cl:defclass <Plan> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (decelForTurn
    :reader decelForTurn
    :initarg :decelForTurn
    :type cl:boolean
    :initform cl:nil)
   (vTarget
    :reader vTarget
    :initarg :vTarget
    :type cl:float
    :initform 0.0)
   (lateralValidDEPRECATED
    :reader lateralValidDEPRECATED
    :initarg :lateralValidDEPRECATED
    :type cl:boolean
    :initform cl:nil)
   (longitudinalPlanSource
    :reader longitudinalPlanSource
    :initarg :longitudinalPlanSource
    :type cl:integer
    :initform 0)
   (hasLead
    :reader hasLead
    :initarg :hasLead
    :type cl:boolean
    :initform cl:nil)
   (radarStateMonoTime
    :reader radarStateMonoTime
    :initarg :radarStateMonoTime
    :type cl:integer
    :initform 0)
   (jerkFactor
    :reader jerkFactor
    :initarg :jerkFactor
    :type cl:float
    :initform 0.0)
   (vCurvature
    :reader vCurvature
    :initarg :vCurvature
    :type cl:float
    :initform 0.0)
   (aTarget
    :reader aTarget
    :initarg :aTarget
    :type cl:float
    :initform 0.0)
   (mdMonoTime
    :reader mdMonoTime
    :initarg :mdMonoTime
    :type cl:integer
    :initform 0)
   (aTargetMaxDEPRECATED
    :reader aTargetMaxDEPRECATED
    :initarg :aTargetMaxDEPRECATED
    :type cl:float
    :initform 0.0)
   (laneWidthDEPRECATED
    :reader laneWidthDEPRECATED
    :initarg :laneWidthDEPRECATED
    :type cl:float
    :initform 0.0)
   (radarValid
    :reader radarValid
    :initarg :radarValid
    :type cl:boolean
    :initform cl:nil)
   (gpsPlannerActive
    :reader gpsPlannerActive
    :initarg :gpsPlannerActive
    :type cl:boolean
    :initform cl:nil)
   (fcw
    :reader fcw
    :initarg :fcw
    :type cl:boolean
    :initform cl:nil)
   (processingDelay
    :reader processingDelay
    :initarg :processingDelay
    :type cl:float
    :initform 0.0)
   (longitudinalValidDEPRECATED
    :reader longitudinalValidDEPRECATED
    :initarg :longitudinalValidDEPRECATED
    :type cl:boolean
    :initform cl:nil)
   (aStart
    :reader aStart
    :initarg :aStart
    :type cl:float
    :initform 0.0)
   (eventsDEPRECATED
    :reader eventsDEPRECATED
    :initarg :eventsDEPRECATED
    :type (cl:vector openpilot_bridge-msg:CarEvent)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CarEvent :initial-element (cl:make-instance 'openpilot_bridge-msg:CarEvent)))
   (hasRightLaneDEPRECATED
    :reader hasRightLaneDEPRECATED
    :initarg :hasRightLaneDEPRECATED
    :type cl:boolean
    :initform cl:nil)
   (vStart
    :reader vStart
    :initarg :vStart
    :type cl:float
    :initform 0.0)
   (aCruise
    :reader aCruise
    :initarg :aCruise
    :type cl:float
    :initform 0.0)
   (commIssue
    :reader commIssue
    :initarg :commIssue
    :type cl:boolean
    :initform cl:nil)
   (vTargetFuture
    :reader vTargetFuture
    :initarg :vTargetFuture
    :type cl:float
    :initform 0.0)
   (gpsTrajectory
    :reader gpsTrajectory
    :initarg :gpsTrajectory
    :type openpilot_bridge-msg:GpsTrajectory
    :initform (cl:make-instance 'openpilot_bridge-msg:GpsTrajectory))
   (hasLeftLaneDEPRECATED
    :reader hasLeftLaneDEPRECATED
    :initarg :hasLeftLaneDEPRECATED
    :type cl:boolean
    :initform cl:nil)
   (vCruise
    :reader vCruise
    :initarg :vCruise
    :type cl:float
    :initform 0.0)
   (aTargetMinDEPRECATED
    :reader aTargetMinDEPRECATED
    :initarg :aTargetMinDEPRECATED
    :type cl:float
    :initform 0.0)
   (mapValid
    :reader mapValid
    :initarg :mapValid
    :type cl:boolean
    :initform cl:nil)
   (radarCanError
    :reader radarCanError
    :initarg :radarCanError
    :type cl:boolean
    :initform cl:nil)
   (vMax
    :reader vMax
    :initarg :vMax
    :type cl:float
    :initform 0.0)
   (dPolyDEPRECATED
    :reader dPolyDEPRECATED
    :initarg :dPolyDEPRECATED
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass Plan (<Plan>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Plan>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Plan)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Plan> is deprecated: use openpilot_bridge-msg:Plan instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'decelForTurn-val :lambda-list '(m))
(cl:defmethod decelForTurn-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:decelForTurn-val is deprecated.  Use openpilot_bridge-msg:decelForTurn instead.")
  (decelForTurn m))

(cl:ensure-generic-function 'vTarget-val :lambda-list '(m))
(cl:defmethod vTarget-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vTarget-val is deprecated.  Use openpilot_bridge-msg:vTarget instead.")
  (vTarget m))

(cl:ensure-generic-function 'lateralValidDEPRECATED-val :lambda-list '(m))
(cl:defmethod lateralValidDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lateralValidDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:lateralValidDEPRECATED instead.")
  (lateralValidDEPRECATED m))

(cl:ensure-generic-function 'longitudinalPlanSource-val :lambda-list '(m))
(cl:defmethod longitudinalPlanSource-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:longitudinalPlanSource-val is deprecated.  Use openpilot_bridge-msg:longitudinalPlanSource instead.")
  (longitudinalPlanSource m))

(cl:ensure-generic-function 'hasLead-val :lambda-list '(m))
(cl:defmethod hasLead-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasLead-val is deprecated.  Use openpilot_bridge-msg:hasLead instead.")
  (hasLead m))

(cl:ensure-generic-function 'radarStateMonoTime-val :lambda-list '(m))
(cl:defmethod radarStateMonoTime-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarStateMonoTime-val is deprecated.  Use openpilot_bridge-msg:radarStateMonoTime instead.")
  (radarStateMonoTime m))

(cl:ensure-generic-function 'jerkFactor-val :lambda-list '(m))
(cl:defmethod jerkFactor-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:jerkFactor-val is deprecated.  Use openpilot_bridge-msg:jerkFactor instead.")
  (jerkFactor m))

(cl:ensure-generic-function 'vCurvature-val :lambda-list '(m))
(cl:defmethod vCurvature-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vCurvature-val is deprecated.  Use openpilot_bridge-msg:vCurvature instead.")
  (vCurvature m))

(cl:ensure-generic-function 'aTarget-val :lambda-list '(m))
(cl:defmethod aTarget-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTarget-val is deprecated.  Use openpilot_bridge-msg:aTarget instead.")
  (aTarget m))

(cl:ensure-generic-function 'mdMonoTime-val :lambda-list '(m))
(cl:defmethod mdMonoTime-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mdMonoTime-val is deprecated.  Use openpilot_bridge-msg:mdMonoTime instead.")
  (mdMonoTime m))

(cl:ensure-generic-function 'aTargetMaxDEPRECATED-val :lambda-list '(m))
(cl:defmethod aTargetMaxDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTargetMaxDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aTargetMaxDEPRECATED instead.")
  (aTargetMaxDEPRECATED m))

(cl:ensure-generic-function 'laneWidthDEPRECATED-val :lambda-list '(m))
(cl:defmethod laneWidthDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:laneWidthDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:laneWidthDEPRECATED instead.")
  (laneWidthDEPRECATED m))

(cl:ensure-generic-function 'radarValid-val :lambda-list '(m))
(cl:defmethod radarValid-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarValid-val is deprecated.  Use openpilot_bridge-msg:radarValid instead.")
  (radarValid m))

(cl:ensure-generic-function 'gpsPlannerActive-val :lambda-list '(m))
(cl:defmethod gpsPlannerActive-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsPlannerActive-val is deprecated.  Use openpilot_bridge-msg:gpsPlannerActive instead.")
  (gpsPlannerActive m))

(cl:ensure-generic-function 'fcw-val :lambda-list '(m))
(cl:defmethod fcw-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fcw-val is deprecated.  Use openpilot_bridge-msg:fcw instead.")
  (fcw m))

(cl:ensure-generic-function 'processingDelay-val :lambda-list '(m))
(cl:defmethod processingDelay-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:processingDelay-val is deprecated.  Use openpilot_bridge-msg:processingDelay instead.")
  (processingDelay m))

(cl:ensure-generic-function 'longitudinalValidDEPRECATED-val :lambda-list '(m))
(cl:defmethod longitudinalValidDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:longitudinalValidDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:longitudinalValidDEPRECATED instead.")
  (longitudinalValidDEPRECATED m))

(cl:ensure-generic-function 'aStart-val :lambda-list '(m))
(cl:defmethod aStart-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aStart-val is deprecated.  Use openpilot_bridge-msg:aStart instead.")
  (aStart m))

(cl:ensure-generic-function 'eventsDEPRECATED-val :lambda-list '(m))
(cl:defmethod eventsDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:eventsDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:eventsDEPRECATED instead.")
  (eventsDEPRECATED m))

(cl:ensure-generic-function 'hasRightLaneDEPRECATED-val :lambda-list '(m))
(cl:defmethod hasRightLaneDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasRightLaneDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:hasRightLaneDEPRECATED instead.")
  (hasRightLaneDEPRECATED m))

(cl:ensure-generic-function 'vStart-val :lambda-list '(m))
(cl:defmethod vStart-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vStart-val is deprecated.  Use openpilot_bridge-msg:vStart instead.")
  (vStart m))

(cl:ensure-generic-function 'aCruise-val :lambda-list '(m))
(cl:defmethod aCruise-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aCruise-val is deprecated.  Use openpilot_bridge-msg:aCruise instead.")
  (aCruise m))

(cl:ensure-generic-function 'commIssue-val :lambda-list '(m))
(cl:defmethod commIssue-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:commIssue-val is deprecated.  Use openpilot_bridge-msg:commIssue instead.")
  (commIssue m))

(cl:ensure-generic-function 'vTargetFuture-val :lambda-list '(m))
(cl:defmethod vTargetFuture-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vTargetFuture-val is deprecated.  Use openpilot_bridge-msg:vTargetFuture instead.")
  (vTargetFuture m))

(cl:ensure-generic-function 'gpsTrajectory-val :lambda-list '(m))
(cl:defmethod gpsTrajectory-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsTrajectory-val is deprecated.  Use openpilot_bridge-msg:gpsTrajectory instead.")
  (gpsTrajectory m))

(cl:ensure-generic-function 'hasLeftLaneDEPRECATED-val :lambda-list '(m))
(cl:defmethod hasLeftLaneDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasLeftLaneDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:hasLeftLaneDEPRECATED instead.")
  (hasLeftLaneDEPRECATED m))

(cl:ensure-generic-function 'vCruise-val :lambda-list '(m))
(cl:defmethod vCruise-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vCruise-val is deprecated.  Use openpilot_bridge-msg:vCruise instead.")
  (vCruise m))

(cl:ensure-generic-function 'aTargetMinDEPRECATED-val :lambda-list '(m))
(cl:defmethod aTargetMinDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTargetMinDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aTargetMinDEPRECATED instead.")
  (aTargetMinDEPRECATED m))

(cl:ensure-generic-function 'mapValid-val :lambda-list '(m))
(cl:defmethod mapValid-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mapValid-val is deprecated.  Use openpilot_bridge-msg:mapValid instead.")
  (mapValid m))

(cl:ensure-generic-function 'radarCanError-val :lambda-list '(m))
(cl:defmethod radarCanError-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarCanError-val is deprecated.  Use openpilot_bridge-msg:radarCanError instead.")
  (radarCanError m))

(cl:ensure-generic-function 'vMax-val :lambda-list '(m))
(cl:defmethod vMax-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vMax-val is deprecated.  Use openpilot_bridge-msg:vMax instead.")
  (vMax m))

(cl:ensure-generic-function 'dPolyDEPRECATED-val :lambda-list '(m))
(cl:defmethod dPolyDEPRECATED-val ((m <Plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dPolyDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:dPolyDEPRECATED instead.")
  (dPolyDEPRECATED m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Plan>) ostream)
  "Serializes a message object of type '<Plan>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'decelForTurn) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vTarget))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lateralValidDEPRECATED) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'longitudinalPlanSource)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'longitudinalPlanSource)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'longitudinalPlanSource)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'longitudinalPlanSource)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasLead) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'radarStateMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'jerkFactor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vCurvature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTarget))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTargetMaxDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'laneWidthDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'radarValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsPlannerActive) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fcw) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'processingDelay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'longitudinalValidDEPRECATED) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aStart))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'eventsDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'eventsDEPRECATED))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasRightLaneDEPRECATED) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vStart))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aCruise))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'commIssue) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vTargetFuture))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gpsTrajectory) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasLeftLaneDEPRECATED) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vCruise))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTargetMinDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mapValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'radarCanError) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vMax))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'dPolyDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'dPolyDEPRECATED))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Plan>) istream)
  "Deserializes a message object of type '<Plan>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'decelForTurn) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vTarget) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'lateralValidDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'longitudinalPlanSource)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'longitudinalPlanSource)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'longitudinalPlanSource)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'longitudinalPlanSource)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'hasLead) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'radarStateMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'jerkFactor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vCurvature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTarget) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTargetMaxDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'laneWidthDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'radarValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsPlannerActive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fcw) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'processingDelay) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'longitudinalValidDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aStart) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'eventsDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'eventsDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CarEvent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'hasRightLaneDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vStart) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aCruise) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'commIssue) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vTargetFuture) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gpsTrajectory) istream)
    (cl:setf (cl:slot-value msg 'hasLeftLaneDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vCruise) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTargetMinDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'mapValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'radarCanError) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vMax) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'dPolyDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'dPolyDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Plan>)))
  "Returns string type for a message object of type '<Plan>"
  "openpilot_bridge/Plan")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Plan)))
  "Returns string type for a message object of type 'Plan"
  "openpilot_bridge/Plan")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Plan>)))
  "Returns md5sum for a message object of type '<Plan>"
  "5122b757463340c2ae5f629a57ec2ba5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Plan)))
  "Returns md5sum for a message object of type 'Plan"
  "5122b757463340c2ae5f629a57ec2ba5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Plan>)))
  "Returns full string definition for message of type '<Plan>"
  (cl:format cl:nil "Header header~%~%bool decelForTurn~%float32 vTarget~%bool lateralValidDEPRECATED~%uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource~%bool hasLead~%int64 radarStateMonoTime~%float32 jerkFactor~%float32 vCurvature~%float32 aTarget~%int64 mdMonoTime~%float32 aTargetMaxDEPRECATED~%float32 laneWidthDEPRECATED~%bool radarValid~%bool gpsPlannerActive~%bool fcw~%float32 processingDelay~%bool longitudinalValidDEPRECATED~%float32 aStart~%CarEvent[] eventsDEPRECATED~%bool hasRightLaneDEPRECATED~%float32 vStart~%float32 aCruise~%bool commIssue~%float32 vTargetFuture~%GpsTrajectory gpsTrajectory~%bool hasLeftLaneDEPRECATED~%float32 vCruise~%float32 aTargetMinDEPRECATED~%bool mapValid~%bool radarCanError~%float32 vMax~%float32[] dPolyDEPRECATED~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/GpsTrajectory~%Header header~%~%float32[] y~%float32[] x~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Plan)))
  "Returns full string definition for message of type 'Plan"
  (cl:format cl:nil "Header header~%~%bool decelForTurn~%float32 vTarget~%bool lateralValidDEPRECATED~%uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource~%bool hasLead~%int64 radarStateMonoTime~%float32 jerkFactor~%float32 vCurvature~%float32 aTarget~%int64 mdMonoTime~%float32 aTargetMaxDEPRECATED~%float32 laneWidthDEPRECATED~%bool radarValid~%bool gpsPlannerActive~%bool fcw~%float32 processingDelay~%bool longitudinalValidDEPRECATED~%float32 aStart~%CarEvent[] eventsDEPRECATED~%bool hasRightLaneDEPRECATED~%float32 vStart~%float32 aCruise~%bool commIssue~%float32 vTargetFuture~%GpsTrajectory gpsTrajectory~%bool hasLeftLaneDEPRECATED~%float32 vCruise~%float32 aTargetMinDEPRECATED~%bool mapValid~%bool radarCanError~%float32 vMax~%float32[] dPolyDEPRECATED~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CarEvent~%Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: openpilot_bridge/GpsTrajectory~%Header header~%~%float32[] y~%float32[] x~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Plan>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     1
     4
     1
     8
     4
     4
     4
     8
     4
     4
     1
     1
     1
     4
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'eventsDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     4
     4
     1
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gpsTrajectory))
     1
     4
     4
     1
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'dPolyDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Plan>))
  "Converts a ROS message object to a list"
  (cl:list 'Plan
    (cl:cons ':header (header msg))
    (cl:cons ':decelForTurn (decelForTurn msg))
    (cl:cons ':vTarget (vTarget msg))
    (cl:cons ':lateralValidDEPRECATED (lateralValidDEPRECATED msg))
    (cl:cons ':longitudinalPlanSource (longitudinalPlanSource msg))
    (cl:cons ':hasLead (hasLead msg))
    (cl:cons ':radarStateMonoTime (radarStateMonoTime msg))
    (cl:cons ':jerkFactor (jerkFactor msg))
    (cl:cons ':vCurvature (vCurvature msg))
    (cl:cons ':aTarget (aTarget msg))
    (cl:cons ':mdMonoTime (mdMonoTime msg))
    (cl:cons ':aTargetMaxDEPRECATED (aTargetMaxDEPRECATED msg))
    (cl:cons ':laneWidthDEPRECATED (laneWidthDEPRECATED msg))
    (cl:cons ':radarValid (radarValid msg))
    (cl:cons ':gpsPlannerActive (gpsPlannerActive msg))
    (cl:cons ':fcw (fcw msg))
    (cl:cons ':processingDelay (processingDelay msg))
    (cl:cons ':longitudinalValidDEPRECATED (longitudinalValidDEPRECATED msg))
    (cl:cons ':aStart (aStart msg))
    (cl:cons ':eventsDEPRECATED (eventsDEPRECATED msg))
    (cl:cons ':hasRightLaneDEPRECATED (hasRightLaneDEPRECATED msg))
    (cl:cons ':vStart (vStart msg))
    (cl:cons ':aCruise (aCruise msg))
    (cl:cons ':commIssue (commIssue msg))
    (cl:cons ':vTargetFuture (vTargetFuture msg))
    (cl:cons ':gpsTrajectory (gpsTrajectory msg))
    (cl:cons ':hasLeftLaneDEPRECATED (hasLeftLaneDEPRECATED msg))
    (cl:cons ':vCruise (vCruise msg))
    (cl:cons ':aTargetMinDEPRECATED (aTargetMinDEPRECATED msg))
    (cl:cons ':mapValid (mapValid msg))
    (cl:cons ':radarCanError (radarCanError msg))
    (cl:cons ':vMax (vMax msg))
    (cl:cons ':dPolyDEPRECATED (dPolyDEPRECATED msg))
))
