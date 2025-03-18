; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude DrSvPolyReport.msg.html

(cl:defclass <DrSvPolyReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (xyzN
    :reader xyzN
    :initarg :xyzN
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (hasSbasIono
    :reader hasSbasIono
    :initarg :hasSbasIono
    :type cl:boolean
    :initform cl:nil)
   (positionUncertainty
    :reader positionUncertainty
    :initarg :positionUncertainty
    :type cl:float
    :initform 0.0)
   (svId
    :reader svId
    :initarg :svId
    :type cl:integer
    :initform 0)
   (elevationUncertainty
    :reader elevationUncertainty
    :initarg :elevationUncertainty
    :type cl:float
    :initform 0.0)
   (polyFromXtra
    :reader polyFromXtra
    :initarg :polyFromXtra
    :type cl:boolean
    :initform cl:nil)
   (other
    :reader other
    :initarg :other
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (ionoDot
    :reader ionoDot
    :initarg :ionoDot
    :type cl:float
    :initform 0.0)
   (hasIono
    :reader hasIono
    :initarg :hasIono
    :type cl:boolean
    :initform cl:nil)
   (frequencyIndex
    :reader frequencyIndex
    :initarg :frequencyIndex
    :type cl:integer
    :initform 0)
   (velocityCoeff
    :reader velocityCoeff
    :initarg :velocityCoeff
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (elevation
    :reader elevation
    :initarg :elevation
    :type cl:float
    :initform 0.0)
   (ionoDelay
    :reader ionoDelay
    :initarg :ionoDelay
    :type cl:float
    :initform 0.0)
   (sbasIonoDelay
    :reader sbasIonoDelay
    :initarg :sbasIonoDelay
    :type cl:float
    :initform 0.0)
   (hasPosition
    :reader hasPosition
    :initarg :hasPosition
    :type cl:boolean
    :initform cl:nil)
   (hasElevation
    :reader hasElevation
    :initarg :hasElevation
    :type cl:boolean
    :initform cl:nil)
   (iode
    :reader iode
    :initarg :iode
    :type cl:integer
    :initform 0)
   (elevationDot
    :reader elevationDot
    :initarg :elevationDot
    :type cl:float
    :initform 0.0)
   (t0
    :reader t0
    :initarg :t0
    :type cl:float
    :initform 0.0)
   (xyz0
    :reader xyz0
    :initarg :xyz0
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (hasTropo
    :reader hasTropo
    :initarg :hasTropo
    :type cl:boolean
    :initform cl:nil)
   (tropoDelay
    :reader tropoDelay
    :initarg :tropoDelay
    :type cl:float
    :initform 0.0)
   (sbasIonoDot
    :reader sbasIonoDot
    :initarg :sbasIonoDot
    :type cl:float
    :initform 0.0))
)

(cl:defclass DrSvPolyReport (<DrSvPolyReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DrSvPolyReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DrSvPolyReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<DrSvPolyReport> is deprecated: use openpilot_bridge-msg:DrSvPolyReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'xyzN-val :lambda-list '(m))
(cl:defmethod xyzN-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:xyzN-val is deprecated.  Use openpilot_bridge-msg:xyzN instead.")
  (xyzN m))

(cl:ensure-generic-function 'hasSbasIono-val :lambda-list '(m))
(cl:defmethod hasSbasIono-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasSbasIono-val is deprecated.  Use openpilot_bridge-msg:hasSbasIono instead.")
  (hasSbasIono m))

(cl:ensure-generic-function 'positionUncertainty-val :lambda-list '(m))
(cl:defmethod positionUncertainty-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:positionUncertainty-val is deprecated.  Use openpilot_bridge-msg:positionUncertainty instead.")
  (positionUncertainty m))

(cl:ensure-generic-function 'svId-val :lambda-list '(m))
(cl:defmethod svId-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:svId-val is deprecated.  Use openpilot_bridge-msg:svId instead.")
  (svId m))

(cl:ensure-generic-function 'elevationUncertainty-val :lambda-list '(m))
(cl:defmethod elevationUncertainty-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:elevationUncertainty-val is deprecated.  Use openpilot_bridge-msg:elevationUncertainty instead.")
  (elevationUncertainty m))

(cl:ensure-generic-function 'polyFromXtra-val :lambda-list '(m))
(cl:defmethod polyFromXtra-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:polyFromXtra-val is deprecated.  Use openpilot_bridge-msg:polyFromXtra instead.")
  (polyFromXtra m))

(cl:ensure-generic-function 'other-val :lambda-list '(m))
(cl:defmethod other-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:other-val is deprecated.  Use openpilot_bridge-msg:other instead.")
  (other m))

(cl:ensure-generic-function 'ionoDot-val :lambda-list '(m))
(cl:defmethod ionoDot-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoDot-val is deprecated.  Use openpilot_bridge-msg:ionoDot instead.")
  (ionoDot m))

(cl:ensure-generic-function 'hasIono-val :lambda-list '(m))
(cl:defmethod hasIono-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasIono-val is deprecated.  Use openpilot_bridge-msg:hasIono instead.")
  (hasIono m))

(cl:ensure-generic-function 'frequencyIndex-val :lambda-list '(m))
(cl:defmethod frequencyIndex-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frequencyIndex-val is deprecated.  Use openpilot_bridge-msg:frequencyIndex instead.")
  (frequencyIndex m))

(cl:ensure-generic-function 'velocityCoeff-val :lambda-list '(m))
(cl:defmethod velocityCoeff-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:velocityCoeff-val is deprecated.  Use openpilot_bridge-msg:velocityCoeff instead.")
  (velocityCoeff m))

(cl:ensure-generic-function 'elevation-val :lambda-list '(m))
(cl:defmethod elevation-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:elevation-val is deprecated.  Use openpilot_bridge-msg:elevation instead.")
  (elevation m))

(cl:ensure-generic-function 'ionoDelay-val :lambda-list '(m))
(cl:defmethod ionoDelay-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoDelay-val is deprecated.  Use openpilot_bridge-msg:ionoDelay instead.")
  (ionoDelay m))

(cl:ensure-generic-function 'sbasIonoDelay-val :lambda-list '(m))
(cl:defmethod sbasIonoDelay-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sbasIonoDelay-val is deprecated.  Use openpilot_bridge-msg:sbasIonoDelay instead.")
  (sbasIonoDelay m))

(cl:ensure-generic-function 'hasPosition-val :lambda-list '(m))
(cl:defmethod hasPosition-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasPosition-val is deprecated.  Use openpilot_bridge-msg:hasPosition instead.")
  (hasPosition m))

(cl:ensure-generic-function 'hasElevation-val :lambda-list '(m))
(cl:defmethod hasElevation-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasElevation-val is deprecated.  Use openpilot_bridge-msg:hasElevation instead.")
  (hasElevation m))

(cl:ensure-generic-function 'iode-val :lambda-list '(m))
(cl:defmethod iode-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:iode-val is deprecated.  Use openpilot_bridge-msg:iode instead.")
  (iode m))

(cl:ensure-generic-function 'elevationDot-val :lambda-list '(m))
(cl:defmethod elevationDot-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:elevationDot-val is deprecated.  Use openpilot_bridge-msg:elevationDot instead.")
  (elevationDot m))

(cl:ensure-generic-function 't0-val :lambda-list '(m))
(cl:defmethod t0-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:t0-val is deprecated.  Use openpilot_bridge-msg:t0 instead.")
  (t0 m))

(cl:ensure-generic-function 'xyz0-val :lambda-list '(m))
(cl:defmethod xyz0-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:xyz0-val is deprecated.  Use openpilot_bridge-msg:xyz0 instead.")
  (xyz0 m))

(cl:ensure-generic-function 'hasTropo-val :lambda-list '(m))
(cl:defmethod hasTropo-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasTropo-val is deprecated.  Use openpilot_bridge-msg:hasTropo instead.")
  (hasTropo m))

(cl:ensure-generic-function 'tropoDelay-val :lambda-list '(m))
(cl:defmethod tropoDelay-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:tropoDelay-val is deprecated.  Use openpilot_bridge-msg:tropoDelay instead.")
  (tropoDelay m))

(cl:ensure-generic-function 'sbasIonoDot-val :lambda-list '(m))
(cl:defmethod sbasIonoDot-val ((m <DrSvPolyReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sbasIonoDot-val is deprecated.  Use openpilot_bridge-msg:sbasIonoDot instead.")
  (sbasIonoDot m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DrSvPolyReport>) ostream)
  "Serializes a message object of type '<DrSvPolyReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'xyzN))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'xyzN))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasSbasIono) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'positionUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'svId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'elevationUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'polyFromXtra) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'other))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'other))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ionoDot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasIono) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'frequencyIndex)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'velocityCoeff))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'velocityCoeff))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'elevation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ionoDelay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'sbasIonoDelay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasPosition) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasElevation) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'iode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'elevationDot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 't0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'xyz0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'xyz0))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasTropo) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tropoDelay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'sbasIonoDot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DrSvPolyReport>) istream)
  "Deserializes a message object of type '<DrSvPolyReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'xyzN) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'xyzN)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'hasSbasIono) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'positionUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'svId) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'elevationUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'polyFromXtra) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'other) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'other)))
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
    (cl:setf (cl:slot-value msg 'ionoDot) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasIono) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frequencyIndex) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'velocityCoeff) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'velocityCoeff)))
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
    (cl:setf (cl:slot-value msg 'elevation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ionoDelay) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sbasIonoDelay) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasPosition) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'hasElevation) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'iode) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'elevationDot) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 't0) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'xyz0) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'xyz0)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:slot-value msg 'hasTropo) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tropoDelay) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sbasIonoDot) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DrSvPolyReport>)))
  "Returns string type for a message object of type '<DrSvPolyReport>"
  "openpilot_bridge/DrSvPolyReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DrSvPolyReport)))
  "Returns string type for a message object of type 'DrSvPolyReport"
  "openpilot_bridge/DrSvPolyReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DrSvPolyReport>)))
  "Returns md5sum for a message object of type '<DrSvPolyReport>"
  "9cc05f066482fefea9be7e6ffcf5850f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DrSvPolyReport)))
  "Returns md5sum for a message object of type 'DrSvPolyReport"
  "9cc05f066482fefea9be7e6ffcf5850f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DrSvPolyReport>)))
  "Returns full string definition for message of type '<DrSvPolyReport>"
  (cl:format cl:nil "Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DrSvPolyReport)))
  "Returns full string definition for message of type 'DrSvPolyReport"
  (cl:format cl:nil "Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DrSvPolyReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'xyzN) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4
     8
     4
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'other) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'velocityCoeff) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     1
     1
     8
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'xyz0) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DrSvPolyReport>))
  "Converts a ROS message object to a list"
  (cl:list 'DrSvPolyReport
    (cl:cons ':header (header msg))
    (cl:cons ':xyzN (xyzN msg))
    (cl:cons ':hasSbasIono (hasSbasIono msg))
    (cl:cons ':positionUncertainty (positionUncertainty msg))
    (cl:cons ':svId (svId msg))
    (cl:cons ':elevationUncertainty (elevationUncertainty msg))
    (cl:cons ':polyFromXtra (polyFromXtra msg))
    (cl:cons ':other (other msg))
    (cl:cons ':ionoDot (ionoDot msg))
    (cl:cons ':hasIono (hasIono msg))
    (cl:cons ':frequencyIndex (frequencyIndex msg))
    (cl:cons ':velocityCoeff (velocityCoeff msg))
    (cl:cons ':elevation (elevation msg))
    (cl:cons ':ionoDelay (ionoDelay msg))
    (cl:cons ':sbasIonoDelay (sbasIonoDelay msg))
    (cl:cons ':hasPosition (hasPosition msg))
    (cl:cons ':hasElevation (hasElevation msg))
    (cl:cons ':iode (iode msg))
    (cl:cons ':elevationDot (elevationDot msg))
    (cl:cons ':t0 (t0 msg))
    (cl:cons ':xyz0 (xyz0 msg))
    (cl:cons ':hasTropo (hasTropo msg))
    (cl:cons ':tropoDelay (tropoDelay msg))
    (cl:cons ':sbasIonoDot (sbasIonoDot msg))
))
