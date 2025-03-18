; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ModelData.msg.html

(cl:defclass <ModelData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (longitudinal
    :reader longitudinal
    :initarg :longitudinal
    :type openpilot_bridge-msg:LongitudinalData
    :initform (cl:make-instance 'openpilot_bridge-msg:LongitudinalData))
   (leadFuture
    :reader leadFuture
    :initarg :leadFuture
    :type openpilot_bridge-msg:LeadData
    :initform (cl:make-instance 'openpilot_bridge-msg:LeadData))
   (lead
    :reader lead
    :initarg :lead
    :type openpilot_bridge-msg:LeadData
    :initform (cl:make-instance 'openpilot_bridge-msg:LeadData))
   (settings
    :reader settings
    :initarg :settings
    :type openpilot_bridge-msg:ModelSettings
    :initform (cl:make-instance 'openpilot_bridge-msg:ModelSettings))
   (leftLane
    :reader leftLane
    :initarg :leftLane
    :type openpilot_bridge-msg:PathData
    :initform (cl:make-instance 'openpilot_bridge-msg:PathData))
   (timestampEof
    :reader timestampEof
    :initarg :timestampEof
    :type cl:integer
    :initform 0)
   (frameId
    :reader frameId
    :initarg :frameId
    :type cl:integer
    :initform 0)
   (rightLane
    :reader rightLane
    :initarg :rightLane
    :type openpilot_bridge-msg:PathData
    :initform (cl:make-instance 'openpilot_bridge-msg:PathData))
   (meta
    :reader meta
    :initarg :meta
    :type openpilot_bridge-msg:MetaData
    :initform (cl:make-instance 'openpilot_bridge-msg:MetaData))
   (path
    :reader path
    :initarg :path
    :type openpilot_bridge-msg:PathData
    :initform (cl:make-instance 'openpilot_bridge-msg:PathData))
   (speed
    :reader speed
    :initarg :speed
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (freePath
    :reader freePath
    :initarg :freePath
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ModelData (<ModelData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ModelData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ModelData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ModelData> is deprecated: use openpilot_bridge-msg:ModelData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'longitudinal-val :lambda-list '(m))
(cl:defmethod longitudinal-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:longitudinal-val is deprecated.  Use openpilot_bridge-msg:longitudinal instead.")
  (longitudinal m))

(cl:ensure-generic-function 'leadFuture-val :lambda-list '(m))
(cl:defmethod leadFuture-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leadFuture-val is deprecated.  Use openpilot_bridge-msg:leadFuture instead.")
  (leadFuture m))

(cl:ensure-generic-function 'lead-val :lambda-list '(m))
(cl:defmethod lead-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lead-val is deprecated.  Use openpilot_bridge-msg:lead instead.")
  (lead m))

(cl:ensure-generic-function 'settings-val :lambda-list '(m))
(cl:defmethod settings-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:settings-val is deprecated.  Use openpilot_bridge-msg:settings instead.")
  (settings m))

(cl:ensure-generic-function 'leftLane-val :lambda-list '(m))
(cl:defmethod leftLane-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftLane-val is deprecated.  Use openpilot_bridge-msg:leftLane instead.")
  (leftLane m))

(cl:ensure-generic-function 'timestampEof-val :lambda-list '(m))
(cl:defmethod timestampEof-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timestampEof-val is deprecated.  Use openpilot_bridge-msg:timestampEof instead.")
  (timestampEof m))

(cl:ensure-generic-function 'frameId-val :lambda-list '(m))
(cl:defmethod frameId-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frameId-val is deprecated.  Use openpilot_bridge-msg:frameId instead.")
  (frameId m))

(cl:ensure-generic-function 'rightLane-val :lambda-list '(m))
(cl:defmethod rightLane-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightLane-val is deprecated.  Use openpilot_bridge-msg:rightLane instead.")
  (rightLane m))

(cl:ensure-generic-function 'meta-val :lambda-list '(m))
(cl:defmethod meta-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:meta-val is deprecated.  Use openpilot_bridge-msg:meta instead.")
  (meta m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:path-val is deprecated.  Use openpilot_bridge-msg:path instead.")
  (path m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speed-val is deprecated.  Use openpilot_bridge-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'freePath-val :lambda-list '(m))
(cl:defmethod freePath-val ((m <ModelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:freePath-val is deprecated.  Use openpilot_bridge-msg:freePath instead.")
  (freePath m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ModelData>) ostream)
  "Serializes a message object of type '<ModelData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'longitudinal) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leadFuture) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lead) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'settings) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leftLane) ostream)
  (cl:let* ((signed (cl:slot-value msg 'timestampEof)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
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
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rightLane) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'meta) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'path) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'speed))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'freePath))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'freePath))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ModelData>) istream)
  "Deserializes a message object of type '<ModelData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'longitudinal) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leadFuture) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lead) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'settings) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leftLane) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestampEof) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rightLane) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'meta) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'path) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'speed) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'speed)))
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
  (cl:setf (cl:slot-value msg 'freePath) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'freePath)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ModelData>)))
  "Returns string type for a message object of type '<ModelData>"
  "openpilot_bridge/ModelData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ModelData)))
  "Returns string type for a message object of type 'ModelData"
  "openpilot_bridge/ModelData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ModelData>)))
  "Returns md5sum for a message object of type '<ModelData>"
  "9f8b0d877672d1e2fbed816c428d4d5c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ModelData)))
  "Returns md5sum for a message object of type 'ModelData"
  "9f8b0d877672d1e2fbed816c428d4d5c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ModelData>)))
  "Returns full string definition for message of type '<ModelData>"
  (cl:format cl:nil "Header header~%~%LongitudinalData longitudinal~%LeadData leadFuture~%LeadData lead~%ModelSettings settings~%PathData leftLane~%int64 timestampEof~%int64 frameId~%PathData rightLane~%MetaData meta~%PathData path~%float32[] speed~%float32[] freePath~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalData~%Header header~%~%float32[] accelerations~%float32[] speeds~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/ModelSettings~%Header header~%~%int64 bigBoxX~%int64 bigBoxY~%float32[] inputTransform~%int64 bigBoxHeight~%int64 bigBoxWidth~%float32[] boxProjection~%float32[] yuvCorrection~%~%================================================================================~%MSG: openpilot_bridge/PathData~%Header header~%~%float32 std~%float32[] poly~%float32[] points~%float32 prob~%float32[] stds~%~%================================================================================~%MSG: openpilot_bridge/MetaData~%Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ModelData)))
  "Returns full string definition for message of type 'ModelData"
  (cl:format cl:nil "Header header~%~%LongitudinalData longitudinal~%LeadData leadFuture~%LeadData lead~%ModelSettings settings~%PathData leftLane~%int64 timestampEof~%int64 frameId~%PathData rightLane~%MetaData meta~%PathData path~%float32[] speed~%float32[] freePath~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LongitudinalData~%Header header~%~%float32[] accelerations~%float32[] speeds~%~%================================================================================~%MSG: openpilot_bridge/LeadData~%Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: openpilot_bridge/ModelSettings~%Header header~%~%int64 bigBoxX~%int64 bigBoxY~%float32[] inputTransform~%int64 bigBoxHeight~%int64 bigBoxWidth~%float32[] boxProjection~%float32[] yuvCorrection~%~%================================================================================~%MSG: openpilot_bridge/PathData~%Header header~%~%float32 std~%float32[] poly~%float32[] points~%float32 prob~%float32[] stds~%~%================================================================================~%MSG: openpilot_bridge/MetaData~%Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ModelData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'longitudinal))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leadFuture))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lead))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'settings))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leftLane))
     8
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rightLane))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'meta))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'path))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'speed) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'freePath) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ModelData>))
  "Converts a ROS message object to a list"
  (cl:list 'ModelData
    (cl:cons ':header (header msg))
    (cl:cons ':longitudinal (longitudinal msg))
    (cl:cons ':leadFuture (leadFuture msg))
    (cl:cons ':lead (lead msg))
    (cl:cons ':settings (settings msg))
    (cl:cons ':leftLane (leftLane msg))
    (cl:cons ':timestampEof (timestampEof msg))
    (cl:cons ':frameId (frameId msg))
    (cl:cons ':rightLane (rightLane msg))
    (cl:cons ':meta (meta msg))
    (cl:cons ':path (path msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':freePath (freePath msg))
))
