; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SensorEventData.msg.html

(cl:defclass <SensorEventData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (gyroUncalibrated
    :reader gyroUncalibrated
    :initarg :gyroUncalibrated
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (light
    :reader light
    :initarg :light
    :type cl:float
    :initform 0.0)
   (orientation
    :reader orientation
    :initarg :orientation
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (pressure
    :reader pressure
    :initarg :pressure
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (sensor
    :reader sensor
    :initarg :sensor
    :type cl:integer
    :initform 0)
   (magnetic
    :reader magnetic
    :initarg :magnetic
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (magneticUncalibrated
    :reader magneticUncalibrated
    :initarg :magneticUncalibrated
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (source
    :reader source
    :initarg :source
    :type cl:integer
    :initform 0)
   (gyro
    :reader gyro
    :initarg :gyro
    :type openpilot_bridge-msg:SensorVec
    :initform (cl:make-instance 'openpilot_bridge-msg:SensorVec))
   (version
    :reader version
    :initarg :version
    :type cl:integer
    :initform 0)
   (timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:integer
    :initform 0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (proximity
    :reader proximity
    :initarg :proximity
    :type cl:float
    :initform 0.0)
   (uncalibratedDEPRECATED
    :reader uncalibratedDEPRECATED
    :initarg :uncalibratedDEPRECATED
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SensorEventData (<SensorEventData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SensorEventData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SensorEventData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SensorEventData> is deprecated: use openpilot_bridge-msg:SensorEventData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:acceleration-val is deprecated.  Use openpilot_bridge-msg:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'gyroUncalibrated-val :lambda-list '(m))
(cl:defmethod gyroUncalibrated-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gyroUncalibrated-val is deprecated.  Use openpilot_bridge-msg:gyroUncalibrated instead.")
  (gyroUncalibrated m))

(cl:ensure-generic-function 'light-val :lambda-list '(m))
(cl:defmethod light-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:light-val is deprecated.  Use openpilot_bridge-msg:light instead.")
  (light m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:orientation-val is deprecated.  Use openpilot_bridge-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'pressure-val :lambda-list '(m))
(cl:defmethod pressure-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pressure-val is deprecated.  Use openpilot_bridge-msg:pressure instead.")
  (pressure m))

(cl:ensure-generic-function 'sensor-val :lambda-list '(m))
(cl:defmethod sensor-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensor-val is deprecated.  Use openpilot_bridge-msg:sensor instead.")
  (sensor m))

(cl:ensure-generic-function 'magnetic-val :lambda-list '(m))
(cl:defmethod magnetic-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:magnetic-val is deprecated.  Use openpilot_bridge-msg:magnetic instead.")
  (magnetic m))

(cl:ensure-generic-function 'magneticUncalibrated-val :lambda-list '(m))
(cl:defmethod magneticUncalibrated-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:magneticUncalibrated-val is deprecated.  Use openpilot_bridge-msg:magneticUncalibrated instead.")
  (magneticUncalibrated m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:source-val is deprecated.  Use openpilot_bridge-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'gyro-val :lambda-list '(m))
(cl:defmethod gyro-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gyro-val is deprecated.  Use openpilot_bridge-msg:gyro instead.")
  (gyro m))

(cl:ensure-generic-function 'version-val :lambda-list '(m))
(cl:defmethod version-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:version-val is deprecated.  Use openpilot_bridge-msg:version instead.")
  (version m))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timestamp-val is deprecated.  Use openpilot_bridge-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:type-val is deprecated.  Use openpilot_bridge-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'proximity-val :lambda-list '(m))
(cl:defmethod proximity-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:proximity-val is deprecated.  Use openpilot_bridge-msg:proximity instead.")
  (proximity m))

(cl:ensure-generic-function 'uncalibratedDEPRECATED-val :lambda-list '(m))
(cl:defmethod uncalibratedDEPRECATED-val ((m <SensorEventData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uncalibratedDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:uncalibratedDEPRECATED instead.")
  (uncalibratedDEPRECATED m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SensorEventData>) ostream)
  "Serializes a message object of type '<SensorEventData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'acceleration) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gyroUncalibrated) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'light))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pressure) ostream)
  (cl:let* ((signed (cl:slot-value msg 'sensor)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'magnetic) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'magneticUncalibrated) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gyro) ostream)
  (cl:let* ((signed (cl:slot-value msg 'version)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'timestamp)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'proximity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'uncalibratedDEPRECATED) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SensorEventData>) istream)
  "Deserializes a message object of type '<SensorEventData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'acceleration) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gyroUncalibrated) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'light) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pressure) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sensor) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'magnetic) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'magneticUncalibrated) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gyro) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'version) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestamp) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'proximity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'uncalibratedDEPRECATED) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SensorEventData>)))
  "Returns string type for a message object of type '<SensorEventData>"
  "openpilot_bridge/SensorEventData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SensorEventData)))
  "Returns string type for a message object of type 'SensorEventData"
  "openpilot_bridge/SensorEventData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SensorEventData>)))
  "Returns md5sum for a message object of type '<SensorEventData>"
  "b716bd78256e63045fe27b6249e4a04a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SensorEventData)))
  "Returns md5sum for a message object of type 'SensorEventData"
  "b716bd78256e63045fe27b6249e4a04a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SensorEventData>)))
  "Returns full string definition for message of type '<SensorEventData>"
  (cl:format cl:nil "Header header~%~%SensorVec acceleration~%SensorVec gyroUncalibrated~%float32 light~%SensorVec orientation~%SensorVec pressure~%int32 sensor~%SensorVec magnetic~%SensorVec magneticUncalibrated~%uint32 source # enum const: SensorSource~%SensorVec gyro~%int32 version~%int32 timestamp~%int32 type~%float32 proximity~%bool uncalibratedDEPRECATED~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/SensorVec~%Header header~%~%int32 status~%float32[] v~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SensorEventData)))
  "Returns full string definition for message of type 'SensorEventData"
  (cl:format cl:nil "Header header~%~%SensorVec acceleration~%SensorVec gyroUncalibrated~%float32 light~%SensorVec orientation~%SensorVec pressure~%int32 sensor~%SensorVec magnetic~%SensorVec magneticUncalibrated~%uint32 source # enum const: SensorSource~%SensorVec gyro~%int32 version~%int32 timestamp~%int32 type~%float32 proximity~%bool uncalibratedDEPRECATED~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/SensorVec~%Header header~%~%int32 status~%float32[] v~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SensorEventData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'acceleration))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gyroUncalibrated))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pressure))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'magnetic))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'magneticUncalibrated))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gyro))
     4
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SensorEventData>))
  "Converts a ROS message object to a list"
  (cl:list 'SensorEventData
    (cl:cons ':header (header msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':gyroUncalibrated (gyroUncalibrated msg))
    (cl:cons ':light (light msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':pressure (pressure msg))
    (cl:cons ':sensor (sensor msg))
    (cl:cons ':magnetic (magnetic msg))
    (cl:cons ':magneticUncalibrated (magneticUncalibrated msg))
    (cl:cons ':source (source msg))
    (cl:cons ':gyro (gyro msg))
    (cl:cons ':version (version msg))
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':type (type msg))
    (cl:cons ':proximity (proximity msg))
    (cl:cons ':uncalibratedDEPRECATED (uncalibratedDEPRECATED msg))
))
