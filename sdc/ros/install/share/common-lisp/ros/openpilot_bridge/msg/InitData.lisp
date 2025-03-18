; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude InitData.msg.html

(cl:defclass <InitData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (kernelVersion
    :reader kernelVersion
    :initarg :kernelVersion
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (chffrAndroidExtra
    :reader chffrAndroidExtra
    :initarg :chffrAndroidExtra
    :type openpilot_bridge-msg:ChffrAndroidExtra
    :initform (cl:make-instance 'openpilot_bridge-msg:ChffrAndroidExtra))
   (androidProperties
    :reader androidProperties
    :initarg :androidProperties
    :type openpilot_bridge-msg:Map
    :initform (cl:make-instance 'openpilot_bridge-msg:Map))
   (androidSensors
    :reader androidSensors
    :initarg :androidSensors
    :type (cl:vector openpilot_bridge-msg:AndroidSensor)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:AndroidSensor :initial-element (cl:make-instance 'openpilot_bridge-msg:AndroidSensor)))
   (pandaInfo
    :reader pandaInfo
    :initarg :pandaInfo
    :type openpilot_bridge-msg:PandaInfo
    :initform (cl:make-instance 'openpilot_bridge-msg:PandaInfo))
   (iosBuildInfo
    :reader iosBuildInfo
    :initarg :iosBuildInfo
    :type openpilot_bridge-msg:IosBuildInfo
    :initform (cl:make-instance 'openpilot_bridge-msg:IosBuildInfo))
   (gitRemote
    :reader gitRemote
    :initarg :gitRemote
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (androidBuildInfo
    :reader androidBuildInfo
    :initarg :androidBuildInfo
    :type openpilot_bridge-msg:AndroidBuildInfo
    :initform (cl:make-instance 'openpilot_bridge-msg:AndroidBuildInfo))
   (passive
    :reader passive
    :initarg :passive
    :type cl:boolean
    :initform cl:nil)
   (params
    :reader params
    :initarg :params
    :type openpilot_bridge-msg:Map
    :initform (cl:make-instance 'openpilot_bridge-msg:Map))
   (version
    :reader version
    :initarg :version
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (deviceType
    :reader deviceType
    :initarg :deviceType
    :type cl:integer
    :initform 0)
   (kernelArgs
    :reader kernelArgs
    :initarg :kernelArgs
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (gitCommit
    :reader gitCommit
    :initarg :gitCommit
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (gitBranch
    :reader gitBranch
    :initarg :gitBranch
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (dongleId
    :reader dongleId
    :initarg :dongleId
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (gctx
    :reader gctx
    :initarg :gctx
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (dirty
    :reader dirty
    :initarg :dirty
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass InitData (<InitData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InitData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InitData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<InitData> is deprecated: use openpilot_bridge-msg:InitData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'kernelVersion-val :lambda-list '(m))
(cl:defmethod kernelVersion-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:kernelVersion-val is deprecated.  Use openpilot_bridge-msg:kernelVersion instead.")
  (kernelVersion m))

(cl:ensure-generic-function 'chffrAndroidExtra-val :lambda-list '(m))
(cl:defmethod chffrAndroidExtra-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:chffrAndroidExtra-val is deprecated.  Use openpilot_bridge-msg:chffrAndroidExtra instead.")
  (chffrAndroidExtra m))

(cl:ensure-generic-function 'androidProperties-val :lambda-list '(m))
(cl:defmethod androidProperties-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:androidProperties-val is deprecated.  Use openpilot_bridge-msg:androidProperties instead.")
  (androidProperties m))

(cl:ensure-generic-function 'androidSensors-val :lambda-list '(m))
(cl:defmethod androidSensors-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:androidSensors-val is deprecated.  Use openpilot_bridge-msg:androidSensors instead.")
  (androidSensors m))

(cl:ensure-generic-function 'pandaInfo-val :lambda-list '(m))
(cl:defmethod pandaInfo-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pandaInfo-val is deprecated.  Use openpilot_bridge-msg:pandaInfo instead.")
  (pandaInfo m))

(cl:ensure-generic-function 'iosBuildInfo-val :lambda-list '(m))
(cl:defmethod iosBuildInfo-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:iosBuildInfo-val is deprecated.  Use openpilot_bridge-msg:iosBuildInfo instead.")
  (iosBuildInfo m))

(cl:ensure-generic-function 'gitRemote-val :lambda-list '(m))
(cl:defmethod gitRemote-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gitRemote-val is deprecated.  Use openpilot_bridge-msg:gitRemote instead.")
  (gitRemote m))

(cl:ensure-generic-function 'androidBuildInfo-val :lambda-list '(m))
(cl:defmethod androidBuildInfo-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:androidBuildInfo-val is deprecated.  Use openpilot_bridge-msg:androidBuildInfo instead.")
  (androidBuildInfo m))

(cl:ensure-generic-function 'passive-val :lambda-list '(m))
(cl:defmethod passive-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:passive-val is deprecated.  Use openpilot_bridge-msg:passive instead.")
  (passive m))

(cl:ensure-generic-function 'params-val :lambda-list '(m))
(cl:defmethod params-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:params-val is deprecated.  Use openpilot_bridge-msg:params instead.")
  (params m))

(cl:ensure-generic-function 'version-val :lambda-list '(m))
(cl:defmethod version-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:version-val is deprecated.  Use openpilot_bridge-msg:version instead.")
  (version m))

(cl:ensure-generic-function 'deviceType-val :lambda-list '(m))
(cl:defmethod deviceType-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:deviceType-val is deprecated.  Use openpilot_bridge-msg:deviceType instead.")
  (deviceType m))

(cl:ensure-generic-function 'kernelArgs-val :lambda-list '(m))
(cl:defmethod kernelArgs-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:kernelArgs-val is deprecated.  Use openpilot_bridge-msg:kernelArgs instead.")
  (kernelArgs m))

(cl:ensure-generic-function 'gitCommit-val :lambda-list '(m))
(cl:defmethod gitCommit-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gitCommit-val is deprecated.  Use openpilot_bridge-msg:gitCommit instead.")
  (gitCommit m))

(cl:ensure-generic-function 'gitBranch-val :lambda-list '(m))
(cl:defmethod gitBranch-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gitBranch-val is deprecated.  Use openpilot_bridge-msg:gitBranch instead.")
  (gitBranch m))

(cl:ensure-generic-function 'dongleId-val :lambda-list '(m))
(cl:defmethod dongleId-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dongleId-val is deprecated.  Use openpilot_bridge-msg:dongleId instead.")
  (dongleId m))

(cl:ensure-generic-function 'gctx-val :lambda-list '(m))
(cl:defmethod gctx-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gctx-val is deprecated.  Use openpilot_bridge-msg:gctx instead.")
  (gctx m))

(cl:ensure-generic-function 'dirty-val :lambda-list '(m))
(cl:defmethod dirty-val ((m <InitData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dirty-val is deprecated.  Use openpilot_bridge-msg:dirty instead.")
  (dirty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InitData>) ostream)
  "Serializes a message object of type '<InitData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'kernelVersion))))
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
   (cl:slot-value msg 'kernelVersion))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'chffrAndroidExtra) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'androidProperties) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'androidSensors))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'androidSensors))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pandaInfo) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'iosBuildInfo) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gitRemote))))
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
   (cl:slot-value msg 'gitRemote))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'androidBuildInfo) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'passive) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'params) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'version))))
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
   (cl:slot-value msg 'version))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'deviceType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'deviceType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'deviceType)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'deviceType)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'kernelArgs))))
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
   (cl:slot-value msg 'kernelArgs))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gitCommit))))
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
   (cl:slot-value msg 'gitCommit))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gitBranch))))
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
   (cl:slot-value msg 'gitBranch))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'dongleId))))
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
   (cl:slot-value msg 'dongleId))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gctx))))
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
   (cl:slot-value msg 'gctx))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'dirty) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InitData>) istream)
  "Deserializes a message object of type '<InitData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'kernelVersion) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'kernelVersion)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'chffrAndroidExtra) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'androidProperties) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'androidSensors) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'androidSensors)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:AndroidSensor))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pandaInfo) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'iosBuildInfo) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'gitRemote) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gitRemote)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'androidBuildInfo) istream)
    (cl:setf (cl:slot-value msg 'passive) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'params) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'version) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'version)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'deviceType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'deviceType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'deviceType)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'deviceType)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'kernelArgs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'kernelArgs)))
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
  (cl:setf (cl:slot-value msg 'gitCommit) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gitCommit)))
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
  (cl:setf (cl:slot-value msg 'gitBranch) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gitBranch)))
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
  (cl:setf (cl:slot-value msg 'dongleId) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'dongleId)))
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
  (cl:setf (cl:slot-value msg 'gctx) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gctx)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:setf (cl:slot-value msg 'dirty) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InitData>)))
  "Returns string type for a message object of type '<InitData>"
  "openpilot_bridge/InitData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitData)))
  "Returns string type for a message object of type 'InitData"
  "openpilot_bridge/InitData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InitData>)))
  "Returns md5sum for a message object of type '<InitData>"
  "76faf0d786e446ea0c4375f81f315e00")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InitData)))
  "Returns md5sum for a message object of type 'InitData"
  "76faf0d786e446ea0c4375f81f315e00")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InitData>)))
  "Returns full string definition for message of type '<InitData>"
  (cl:format cl:nil "Header header~%~%string[] kernelVersion~%ChffrAndroidExtra chffrAndroidExtra~%Map androidProperties~%AndroidSensor[] androidSensors~%PandaInfo pandaInfo~%IosBuildInfo iosBuildInfo~%string[] gitRemote~%AndroidBuildInfo androidBuildInfo~%bool passive~%Map params~%string[] version~%uint32 deviceType # enum const: DeviceType~%string[] kernelArgs~%string[] gitCommit~%string[] gitBranch~%string[] dongleId~%string[] gctx~%bool dirty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ChffrAndroidExtra~%Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%================================================================================~%MSG: openpilot_bridge/AndroidSensor~%Header header~%~%float32 maxRange~%string[] stringType~%int32 maxDelay~%int32 handle~%string[] name~%float32 power~%int32 minDelay~%float32 resolution~%int64 fifoMaxEventCount~%int32 version~%int64 fifoReservedEventCount~%string[] vendor~%int32 type~%int32 id~%~%================================================================================~%MSG: openpilot_bridge/PandaInfo~%Header header~%~%bool hasPanda~%string[] stVersion~%string[] dongleId~%string[] espVersion~%~%================================================================================~%MSG: openpilot_bridge/IosBuildInfo~%Header header~%~%int64 appBuild~%string[] appVersion~%string[] osVersion~%string[] deviceModel~%~%================================================================================~%MSG: openpilot_bridge/AndroidBuildInfo~%Header header~%~%string[] radioVersion~%string[] versionCodename~%string[] hardware~%string[] versionSecurityPatch~%string[] supportedAbis~%string[] id~%string[] board~%string[] type~%string[] product~%string[] tags~%string[] brand~%string[] host~%string[] user~%string[] fingerprint~%string[] device~%string[] bootloader~%string[] model~%string[] serial~%string[] manufacturer~%string[] versionRelease~%int32 time~%int32 versionSdk~%string[] display~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InitData)))
  "Returns full string definition for message of type 'InitData"
  (cl:format cl:nil "Header header~%~%string[] kernelVersion~%ChffrAndroidExtra chffrAndroidExtra~%Map androidProperties~%AndroidSensor[] androidSensors~%PandaInfo pandaInfo~%IosBuildInfo iosBuildInfo~%string[] gitRemote~%AndroidBuildInfo androidBuildInfo~%bool passive~%Map params~%string[] version~%uint32 deviceType # enum const: DeviceType~%string[] kernelArgs~%string[] gitCommit~%string[] gitBranch~%string[] dongleId~%string[] gctx~%bool dirty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ChffrAndroidExtra~%Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%================================================================================~%MSG: openpilot_bridge/AndroidSensor~%Header header~%~%float32 maxRange~%string[] stringType~%int32 maxDelay~%int32 handle~%string[] name~%float32 power~%int32 minDelay~%float32 resolution~%int64 fifoMaxEventCount~%int32 version~%int64 fifoReservedEventCount~%string[] vendor~%int32 type~%int32 id~%~%================================================================================~%MSG: openpilot_bridge/PandaInfo~%Header header~%~%bool hasPanda~%string[] stVersion~%string[] dongleId~%string[] espVersion~%~%================================================================================~%MSG: openpilot_bridge/IosBuildInfo~%Header header~%~%int64 appBuild~%string[] appVersion~%string[] osVersion~%string[] deviceModel~%~%================================================================================~%MSG: openpilot_bridge/AndroidBuildInfo~%Header header~%~%string[] radioVersion~%string[] versionCodename~%string[] hardware~%string[] versionSecurityPatch~%string[] supportedAbis~%string[] id~%string[] board~%string[] type~%string[] product~%string[] tags~%string[] brand~%string[] host~%string[] user~%string[] fingerprint~%string[] device~%string[] bootloader~%string[] model~%string[] serial~%string[] manufacturer~%string[] versionRelease~%int32 time~%int32 versionSdk~%string[] display~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InitData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'kernelVersion) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'chffrAndroidExtra))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'androidProperties))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'androidSensors) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pandaInfo))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'iosBuildInfo))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gitRemote) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'androidBuildInfo))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'params))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'version) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'kernelArgs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gitCommit) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gitBranch) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'dongleId) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gctx) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InitData>))
  "Converts a ROS message object to a list"
  (cl:list 'InitData
    (cl:cons ':header (header msg))
    (cl:cons ':kernelVersion (kernelVersion msg))
    (cl:cons ':chffrAndroidExtra (chffrAndroidExtra msg))
    (cl:cons ':androidProperties (androidProperties msg))
    (cl:cons ':androidSensors (androidSensors msg))
    (cl:cons ':pandaInfo (pandaInfo msg))
    (cl:cons ':iosBuildInfo (iosBuildInfo msg))
    (cl:cons ':gitRemote (gitRemote msg))
    (cl:cons ':androidBuildInfo (androidBuildInfo msg))
    (cl:cons ':passive (passive msg))
    (cl:cons ':params (params msg))
    (cl:cons ':version (version msg))
    (cl:cons ':deviceType (deviceType msg))
    (cl:cons ':kernelArgs (kernelArgs msg))
    (cl:cons ':gitCommit (gitCommit msg))
    (cl:cons ':gitBranch (gitBranch msg))
    (cl:cons ':dongleId (dongleId msg))
    (cl:cons ':gctx (gctx msg))
    (cl:cons ':dirty (dirty msg))
))
