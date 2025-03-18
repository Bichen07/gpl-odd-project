; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude DriverMonitoring.msg.html

(cl:defclass <DriverMonitoring> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (faceOrientation
    :reader faceOrientation
    :initarg :faceOrientation
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (stdDEPRECATED
    :reader stdDEPRECATED
    :initarg :stdDEPRECATED
    :type cl:float
    :initform 0.0)
   (irPwrDEPRECATED
    :reader irPwrDEPRECATED
    :initarg :irPwrDEPRECATED
    :type cl:float
    :initform 0.0)
   (faceOrientationStd
    :reader faceOrientationStd
    :initarg :faceOrientationStd
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (faceProb
    :reader faceProb
    :initarg :faceProb
    :type cl:float
    :initform 0.0)
   (frameId
    :reader frameId
    :initarg :frameId
    :type cl:integer
    :initform 0)
   (descriptorDEPRECATED
    :reader descriptorDEPRECATED
    :initarg :descriptorDEPRECATED
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (rightBlinkProb
    :reader rightBlinkProb
    :initarg :rightBlinkProb
    :type cl:float
    :initform 0.0)
   (rightEyeProb
    :reader rightEyeProb
    :initarg :rightEyeProb
    :type cl:float
    :initform 0.0)
   (facePositionStd
    :reader facePositionStd
    :initarg :facePositionStd
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (leftBlinkProb
    :reader leftBlinkProb
    :initarg :leftBlinkProb
    :type cl:float
    :initform 0.0)
   (leftEyeProb
    :reader leftEyeProb
    :initarg :leftEyeProb
    :type cl:float
    :initform 0.0)
   (facePosition
    :reader facePosition
    :initarg :facePosition
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass DriverMonitoring (<DriverMonitoring>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DriverMonitoring>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DriverMonitoring)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<DriverMonitoring> is deprecated: use openpilot_bridge-msg:DriverMonitoring instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'faceOrientation-val :lambda-list '(m))
(cl:defmethod faceOrientation-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:faceOrientation-val is deprecated.  Use openpilot_bridge-msg:faceOrientation instead.")
  (faceOrientation m))

(cl:ensure-generic-function 'stdDEPRECATED-val :lambda-list '(m))
(cl:defmethod stdDEPRECATED-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stdDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:stdDEPRECATED instead.")
  (stdDEPRECATED m))

(cl:ensure-generic-function 'irPwrDEPRECATED-val :lambda-list '(m))
(cl:defmethod irPwrDEPRECATED-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:irPwrDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:irPwrDEPRECATED instead.")
  (irPwrDEPRECATED m))

(cl:ensure-generic-function 'faceOrientationStd-val :lambda-list '(m))
(cl:defmethod faceOrientationStd-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:faceOrientationStd-val is deprecated.  Use openpilot_bridge-msg:faceOrientationStd instead.")
  (faceOrientationStd m))

(cl:ensure-generic-function 'faceProb-val :lambda-list '(m))
(cl:defmethod faceProb-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:faceProb-val is deprecated.  Use openpilot_bridge-msg:faceProb instead.")
  (faceProb m))

(cl:ensure-generic-function 'frameId-val :lambda-list '(m))
(cl:defmethod frameId-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frameId-val is deprecated.  Use openpilot_bridge-msg:frameId instead.")
  (frameId m))

(cl:ensure-generic-function 'descriptorDEPRECATED-val :lambda-list '(m))
(cl:defmethod descriptorDEPRECATED-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:descriptorDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:descriptorDEPRECATED instead.")
  (descriptorDEPRECATED m))

(cl:ensure-generic-function 'rightBlinkProb-val :lambda-list '(m))
(cl:defmethod rightBlinkProb-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightBlinkProb-val is deprecated.  Use openpilot_bridge-msg:rightBlinkProb instead.")
  (rightBlinkProb m))

(cl:ensure-generic-function 'rightEyeProb-val :lambda-list '(m))
(cl:defmethod rightEyeProb-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightEyeProb-val is deprecated.  Use openpilot_bridge-msg:rightEyeProb instead.")
  (rightEyeProb m))

(cl:ensure-generic-function 'facePositionStd-val :lambda-list '(m))
(cl:defmethod facePositionStd-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:facePositionStd-val is deprecated.  Use openpilot_bridge-msg:facePositionStd instead.")
  (facePositionStd m))

(cl:ensure-generic-function 'leftBlinkProb-val :lambda-list '(m))
(cl:defmethod leftBlinkProb-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftBlinkProb-val is deprecated.  Use openpilot_bridge-msg:leftBlinkProb instead.")
  (leftBlinkProb m))

(cl:ensure-generic-function 'leftEyeProb-val :lambda-list '(m))
(cl:defmethod leftEyeProb-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftEyeProb-val is deprecated.  Use openpilot_bridge-msg:leftEyeProb instead.")
  (leftEyeProb m))

(cl:ensure-generic-function 'facePosition-val :lambda-list '(m))
(cl:defmethod facePosition-val ((m <DriverMonitoring>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:facePosition-val is deprecated.  Use openpilot_bridge-msg:facePosition instead.")
  (facePosition m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DriverMonitoring>) ostream)
  "Serializes a message object of type '<DriverMonitoring>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faceOrientation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'faceOrientation))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'stdDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'irPwrDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faceOrientationStd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'faceOrientationStd))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'faceProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'frameId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'descriptorDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'descriptorDEPRECATED))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rightBlinkProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rightEyeProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'facePositionStd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'facePositionStd))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leftBlinkProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leftEyeProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'facePosition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'facePosition))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DriverMonitoring>) istream)
  "Deserializes a message object of type '<DriverMonitoring>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faceOrientation) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faceOrientation)))
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
    (cl:setf (cl:slot-value msg 'stdDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'irPwrDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faceOrientationStd) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faceOrientationStd)))
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
    (cl:setf (cl:slot-value msg 'faceProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frameId) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'descriptorDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'descriptorDEPRECATED)))
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
    (cl:setf (cl:slot-value msg 'rightBlinkProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rightEyeProb) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'facePositionStd) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'facePositionStd)))
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
    (cl:setf (cl:slot-value msg 'leftBlinkProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leftEyeProb) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'facePosition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'facePosition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DriverMonitoring>)))
  "Returns string type for a message object of type '<DriverMonitoring>"
  "openpilot_bridge/DriverMonitoring")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DriverMonitoring)))
  "Returns string type for a message object of type 'DriverMonitoring"
  "openpilot_bridge/DriverMonitoring")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DriverMonitoring>)))
  "Returns md5sum for a message object of type '<DriverMonitoring>"
  "bc7bb5c40d657dda1ef2c99f7d9a20f7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DriverMonitoring)))
  "Returns md5sum for a message object of type 'DriverMonitoring"
  "bc7bb5c40d657dda1ef2c99f7d9a20f7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DriverMonitoring>)))
  "Returns full string definition for message of type '<DriverMonitoring>"
  (cl:format cl:nil "Header header~%~%float32[] faceOrientation~%float32 stdDEPRECATED~%float32 irPwrDEPRECATED~%float32[] faceOrientationStd~%float32 faceProb~%int64 frameId~%float32[] descriptorDEPRECATED~%float32 rightBlinkProb~%float32 rightEyeProb~%float32[] facePositionStd~%float32 leftBlinkProb~%float32 leftEyeProb~%float32[] facePosition~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DriverMonitoring)))
  "Returns full string definition for message of type 'DriverMonitoring"
  (cl:format cl:nil "Header header~%~%float32[] faceOrientation~%float32 stdDEPRECATED~%float32 irPwrDEPRECATED~%float32[] faceOrientationStd~%float32 faceProb~%int64 frameId~%float32[] descriptorDEPRECATED~%float32 rightBlinkProb~%float32 rightEyeProb~%float32[] facePositionStd~%float32 leftBlinkProb~%float32 leftEyeProb~%float32[] facePosition~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DriverMonitoring>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faceOrientation) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faceOrientationStd) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'descriptorDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'facePositionStd) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'facePosition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DriverMonitoring>))
  "Converts a ROS message object to a list"
  (cl:list 'DriverMonitoring
    (cl:cons ':header (header msg))
    (cl:cons ':faceOrientation (faceOrientation msg))
    (cl:cons ':stdDEPRECATED (stdDEPRECATED msg))
    (cl:cons ':irPwrDEPRECATED (irPwrDEPRECATED msg))
    (cl:cons ':faceOrientationStd (faceOrientationStd msg))
    (cl:cons ':faceProb (faceProb msg))
    (cl:cons ':frameId (frameId msg))
    (cl:cons ':descriptorDEPRECATED (descriptorDEPRECATED msg))
    (cl:cons ':rightBlinkProb (rightBlinkProb msg))
    (cl:cons ':rightEyeProb (rightEyeProb msg))
    (cl:cons ':facePositionStd (facePositionStd msg))
    (cl:cons ':leftBlinkProb (leftBlinkProb msg))
    (cl:cons ':leftEyeProb (leftEyeProb msg))
    (cl:cons ':facePosition (facePosition msg))
))
