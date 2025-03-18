; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LiveMapData.msg.html

(cl:defclass <LiveMapData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (roadCurvatureX
    :reader roadCurvatureX
    :initarg :roadCurvatureX
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (wayId
    :reader wayId
    :initarg :wayId
    :type cl:integer
    :initform 0)
   (speedLimitValid
    :reader speedLimitValid
    :initarg :speedLimitValid
    :type cl:boolean
    :initform cl:nil)
   (distToTurn
    :reader distToTurn
    :initarg :distToTurn
    :type cl:float
    :initform 0.0)
   (curvature
    :reader curvature
    :initarg :curvature
    :type cl:float
    :initform 0.0)
   (roadCurvature
    :reader roadCurvature
    :initarg :roadCurvature
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (mapValid
    :reader mapValid
    :initarg :mapValid
    :type cl:boolean
    :initform cl:nil)
   (roadY
    :reader roadY
    :initarg :roadY
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (roadX
    :reader roadX
    :initarg :roadX
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (speedLimitAheadDistance
    :reader speedLimitAheadDistance
    :initarg :speedLimitAheadDistance
    :type cl:float
    :initform 0.0)
   (curvatureValid
    :reader curvatureValid
    :initarg :curvatureValid
    :type cl:boolean
    :initform cl:nil)
   (speedLimitAheadValid
    :reader speedLimitAheadValid
    :initarg :speedLimitAheadValid
    :type cl:boolean
    :initform cl:nil)
   (speedAdvisoryValid
    :reader speedAdvisoryValid
    :initarg :speedAdvisoryValid
    :type cl:boolean
    :initform cl:nil)
   (speedLimit
    :reader speedLimit
    :initarg :speedLimit
    :type cl:float
    :initform 0.0)
   (speedAdvisory
    :reader speedAdvisory
    :initarg :speedAdvisory
    :type cl:float
    :initform 0.0)
   (lastGps
    :reader lastGps
    :initarg :lastGps
    :type openpilot_bridge-msg:GpsLocationData
    :initform (cl:make-instance 'openpilot_bridge-msg:GpsLocationData))
   (speedLimitAhead
    :reader speedLimitAhead
    :initarg :speedLimitAhead
    :type cl:float
    :initform 0.0))
)

(cl:defclass LiveMapData (<LiveMapData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LiveMapData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LiveMapData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LiveMapData> is deprecated: use openpilot_bridge-msg:LiveMapData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'roadCurvatureX-val :lambda-list '(m))
(cl:defmethod roadCurvatureX-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:roadCurvatureX-val is deprecated.  Use openpilot_bridge-msg:roadCurvatureX instead.")
  (roadCurvatureX m))

(cl:ensure-generic-function 'wayId-val :lambda-list '(m))
(cl:defmethod wayId-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:wayId-val is deprecated.  Use openpilot_bridge-msg:wayId instead.")
  (wayId m))

(cl:ensure-generic-function 'speedLimitValid-val :lambda-list '(m))
(cl:defmethod speedLimitValid-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimitValid-val is deprecated.  Use openpilot_bridge-msg:speedLimitValid instead.")
  (speedLimitValid m))

(cl:ensure-generic-function 'distToTurn-val :lambda-list '(m))
(cl:defmethod distToTurn-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:distToTurn-val is deprecated.  Use openpilot_bridge-msg:distToTurn instead.")
  (distToTurn m))

(cl:ensure-generic-function 'curvature-val :lambda-list '(m))
(cl:defmethod curvature-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curvature-val is deprecated.  Use openpilot_bridge-msg:curvature instead.")
  (curvature m))

(cl:ensure-generic-function 'roadCurvature-val :lambda-list '(m))
(cl:defmethod roadCurvature-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:roadCurvature-val is deprecated.  Use openpilot_bridge-msg:roadCurvature instead.")
  (roadCurvature m))

(cl:ensure-generic-function 'mapValid-val :lambda-list '(m))
(cl:defmethod mapValid-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mapValid-val is deprecated.  Use openpilot_bridge-msg:mapValid instead.")
  (mapValid m))

(cl:ensure-generic-function 'roadY-val :lambda-list '(m))
(cl:defmethod roadY-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:roadY-val is deprecated.  Use openpilot_bridge-msg:roadY instead.")
  (roadY m))

(cl:ensure-generic-function 'roadX-val :lambda-list '(m))
(cl:defmethod roadX-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:roadX-val is deprecated.  Use openpilot_bridge-msg:roadX instead.")
  (roadX m))

(cl:ensure-generic-function 'speedLimitAheadDistance-val :lambda-list '(m))
(cl:defmethod speedLimitAheadDistance-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimitAheadDistance-val is deprecated.  Use openpilot_bridge-msg:speedLimitAheadDistance instead.")
  (speedLimitAheadDistance m))

(cl:ensure-generic-function 'curvatureValid-val :lambda-list '(m))
(cl:defmethod curvatureValid-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curvatureValid-val is deprecated.  Use openpilot_bridge-msg:curvatureValid instead.")
  (curvatureValid m))

(cl:ensure-generic-function 'speedLimitAheadValid-val :lambda-list '(m))
(cl:defmethod speedLimitAheadValid-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimitAheadValid-val is deprecated.  Use openpilot_bridge-msg:speedLimitAheadValid instead.")
  (speedLimitAheadValid m))

(cl:ensure-generic-function 'speedAdvisoryValid-val :lambda-list '(m))
(cl:defmethod speedAdvisoryValid-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedAdvisoryValid-val is deprecated.  Use openpilot_bridge-msg:speedAdvisoryValid instead.")
  (speedAdvisoryValid m))

(cl:ensure-generic-function 'speedLimit-val :lambda-list '(m))
(cl:defmethod speedLimit-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimit-val is deprecated.  Use openpilot_bridge-msg:speedLimit instead.")
  (speedLimit m))

(cl:ensure-generic-function 'speedAdvisory-val :lambda-list '(m))
(cl:defmethod speedAdvisory-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedAdvisory-val is deprecated.  Use openpilot_bridge-msg:speedAdvisory instead.")
  (speedAdvisory m))

(cl:ensure-generic-function 'lastGps-val :lambda-list '(m))
(cl:defmethod lastGps-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lastGps-val is deprecated.  Use openpilot_bridge-msg:lastGps instead.")
  (lastGps m))

(cl:ensure-generic-function 'speedLimitAhead-val :lambda-list '(m))
(cl:defmethod speedLimitAhead-val ((m <LiveMapData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimitAhead-val is deprecated.  Use openpilot_bridge-msg:speedLimitAhead instead.")
  (speedLimitAhead m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LiveMapData>) ostream)
  "Serializes a message object of type '<LiveMapData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'roadCurvatureX))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'roadCurvatureX))
  (cl:let* ((signed (cl:slot-value msg 'wayId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'speedLimitValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distToTurn))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'curvature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'roadCurvature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'roadCurvature))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mapValid) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'roadY))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'roadY))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'roadX))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'roadX))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedLimitAheadDistance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'curvatureValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'speedLimitAheadValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'speedAdvisoryValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedLimit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedAdvisory))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lastGps) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedLimitAhead))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LiveMapData>) istream)
  "Deserializes a message object of type '<LiveMapData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'roadCurvatureX) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'roadCurvatureX)))
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
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'wayId) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'speedLimitValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distToTurn) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'curvature) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'roadCurvature) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'roadCurvature)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'mapValid) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'roadY) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'roadY)))
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
  (cl:setf (cl:slot-value msg 'roadX) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'roadX)))
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
    (cl:setf (cl:slot-value msg 'speedLimitAheadDistance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'curvatureValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'speedLimitAheadValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'speedAdvisoryValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedLimit) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedAdvisory) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lastGps) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedLimitAhead) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LiveMapData>)))
  "Returns string type for a message object of type '<LiveMapData>"
  "openpilot_bridge/LiveMapData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LiveMapData)))
  "Returns string type for a message object of type 'LiveMapData"
  "openpilot_bridge/LiveMapData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LiveMapData>)))
  "Returns md5sum for a message object of type '<LiveMapData>"
  "8e75e0f0b1c9d773cf5d7c8618aae41e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LiveMapData)))
  "Returns md5sum for a message object of type 'LiveMapData"
  "8e75e0f0b1c9d773cf5d7c8618aae41e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LiveMapData>)))
  "Returns full string definition for message of type '<LiveMapData>"
  (cl:format cl:nil "Header header~%~%float32[] roadCurvatureX~%int64 wayId~%bool speedLimitValid~%float32 distToTurn~%float32 curvature~%float32[] roadCurvature~%bool mapValid~%float32[] roadY~%float32[] roadX~%float32 speedLimitAheadDistance~%bool curvatureValid~%bool speedLimitAheadValid~%bool speedAdvisoryValid~%float32 speedLimit~%float32 speedAdvisory~%GpsLocationData lastGps~%float32 speedLimitAhead~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/GpsLocationData~%Header header~%~%float32 bearing~%float32[] vNED~%int32 timestamp~%float32 altitude~%float32 longitude~%uint32 source # enum const: SensorSource~%float32 speedAccuracy~%int64 flags~%float32 latitude~%float32 bearingAccuracy~%float32 speed~%float32 verticalAccuracy~%float32 accuracy~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LiveMapData)))
  "Returns full string definition for message of type 'LiveMapData"
  (cl:format cl:nil "Header header~%~%float32[] roadCurvatureX~%int64 wayId~%bool speedLimitValid~%float32 distToTurn~%float32 curvature~%float32[] roadCurvature~%bool mapValid~%float32[] roadY~%float32[] roadX~%float32 speedLimitAheadDistance~%bool curvatureValid~%bool speedLimitAheadValid~%bool speedAdvisoryValid~%float32 speedLimit~%float32 speedAdvisory~%GpsLocationData lastGps~%float32 speedLimitAhead~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/GpsLocationData~%Header header~%~%float32 bearing~%float32[] vNED~%int32 timestamp~%float32 altitude~%float32 longitude~%uint32 source # enum const: SensorSource~%float32 speedAccuracy~%int64 flags~%float32 latitude~%float32 bearingAccuracy~%float32 speed~%float32 verticalAccuracy~%float32 accuracy~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LiveMapData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'roadCurvatureX) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     8
     1
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'roadCurvature) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'roadY) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'roadX) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     1
     1
     1
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lastGps))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LiveMapData>))
  "Converts a ROS message object to a list"
  (cl:list 'LiveMapData
    (cl:cons ':header (header msg))
    (cl:cons ':roadCurvatureX (roadCurvatureX msg))
    (cl:cons ':wayId (wayId msg))
    (cl:cons ':speedLimitValid (speedLimitValid msg))
    (cl:cons ':distToTurn (distToTurn msg))
    (cl:cons ':curvature (curvature msg))
    (cl:cons ':roadCurvature (roadCurvature msg))
    (cl:cons ':mapValid (mapValid msg))
    (cl:cons ':roadY (roadY msg))
    (cl:cons ':roadX (roadX msg))
    (cl:cons ':speedLimitAheadDistance (speedLimitAheadDistance msg))
    (cl:cons ':curvatureValid (curvatureValid msg))
    (cl:cons ':speedLimitAheadValid (speedLimitAheadValid msg))
    (cl:cons ':speedAdvisoryValid (speedAdvisoryValid msg))
    (cl:cons ':speedLimit (speedLimit msg))
    (cl:cons ':speedAdvisory (speedAdvisory msg))
    (cl:cons ':lastGps (lastGps msg))
    (cl:cons ':speedLimitAhead (speedLimitAhead msg))
))
