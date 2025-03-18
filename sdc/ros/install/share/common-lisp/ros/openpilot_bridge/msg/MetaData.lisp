; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude MetaData.msg.html

(cl:defclass <MetaData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gasDisengageProb
    :reader gasDisengageProb
    :initarg :gasDisengageProb
    :type cl:float
    :initform 0.0)
   (brakeDisengageProb
    :reader brakeDisengageProb
    :initarg :brakeDisengageProb
    :type cl:float
    :initform 0.0)
   (steerOverrideProb
    :reader steerOverrideProb
    :initarg :steerOverrideProb
    :type cl:float
    :initform 0.0)
   (engagedProb
    :reader engagedProb
    :initarg :engagedProb
    :type cl:float
    :initform 0.0)
   (desirePrediction
    :reader desirePrediction
    :initarg :desirePrediction
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass MetaData (<MetaData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MetaData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MetaData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<MetaData> is deprecated: use openpilot_bridge-msg:MetaData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gasDisengageProb-val :lambda-list '(m))
(cl:defmethod gasDisengageProb-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasDisengageProb-val is deprecated.  Use openpilot_bridge-msg:gasDisengageProb instead.")
  (gasDisengageProb m))

(cl:ensure-generic-function 'brakeDisengageProb-val :lambda-list '(m))
(cl:defmethod brakeDisengageProb-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakeDisengageProb-val is deprecated.  Use openpilot_bridge-msg:brakeDisengageProb instead.")
  (brakeDisengageProb m))

(cl:ensure-generic-function 'steerOverrideProb-val :lambda-list '(m))
(cl:defmethod steerOverrideProb-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerOverrideProb-val is deprecated.  Use openpilot_bridge-msg:steerOverrideProb instead.")
  (steerOverrideProb m))

(cl:ensure-generic-function 'engagedProb-val :lambda-list '(m))
(cl:defmethod engagedProb-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:engagedProb-val is deprecated.  Use openpilot_bridge-msg:engagedProb instead.")
  (engagedProb m))

(cl:ensure-generic-function 'desirePrediction-val :lambda-list '(m))
(cl:defmethod desirePrediction-val ((m <MetaData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:desirePrediction-val is deprecated.  Use openpilot_bridge-msg:desirePrediction instead.")
  (desirePrediction m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MetaData>) ostream)
  "Serializes a message object of type '<MetaData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gasDisengageProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brakeDisengageProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerOverrideProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engagedProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'desirePrediction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'desirePrediction))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MetaData>) istream)
  "Deserializes a message object of type '<MetaData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gasDisengageProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brakeDisengageProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerOverrideProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engagedProb) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'desirePrediction) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'desirePrediction)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MetaData>)))
  "Returns string type for a message object of type '<MetaData>"
  "openpilot_bridge/MetaData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MetaData)))
  "Returns string type for a message object of type 'MetaData"
  "openpilot_bridge/MetaData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MetaData>)))
  "Returns md5sum for a message object of type '<MetaData>"
  "edac01773b36419f37d774b07e331e9b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MetaData)))
  "Returns md5sum for a message object of type 'MetaData"
  "edac01773b36419f37d774b07e331e9b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MetaData>)))
  "Returns full string definition for message of type '<MetaData>"
  (cl:format cl:nil "Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MetaData)))
  "Returns full string definition for message of type 'MetaData"
  (cl:format cl:nil "Header header~%~%float32 gasDisengageProb~%float32 brakeDisengageProb~%float32 steerOverrideProb~%float32 engagedProb~%float32[] desirePrediction~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MetaData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'desirePrediction) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MetaData>))
  "Converts a ROS message object to a list"
  (cl:list 'MetaData
    (cl:cons ':header (header msg))
    (cl:cons ':gasDisengageProb (gasDisengageProb msg))
    (cl:cons ':brakeDisengageProb (brakeDisengageProb msg))
    (cl:cons ':steerOverrideProb (steerOverrideProb msg))
    (cl:cons ':engagedProb (engagedProb msg))
    (cl:cons ':desirePrediction (desirePrediction msg))
))
