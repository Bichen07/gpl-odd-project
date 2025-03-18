; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude SurroundReport.msg.html

(cl:defclass <SurroundReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (front_radar_object_distance
    :reader front_radar_object_distance
    :initarg :front_radar_object_distance
    :type cl:float
    :initform 0.0)
   (rear_radar_object_distance
    :reader rear_radar_object_distance
    :initarg :rear_radar_object_distance
    :type cl:float
    :initform 0.0)
   (rear_right
    :reader rear_right
    :initarg :rear_right
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (rear_left
    :reader rear_left
    :initarg :rear_left
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (rear_center
    :reader rear_center
    :initarg :rear_center
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (front_right
    :reader front_right
    :initarg :front_right
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (front_left
    :reader front_left
    :initarg :front_left
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (front_center
    :reader front_center
    :initarg :front_center
    :type dbw_pacifica_msgs-msg:SonarArcNum
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:SonarArcNum))
   (front_radar_distance_valid
    :reader front_radar_distance_valid
    :initarg :front_radar_distance_valid
    :type cl:boolean
    :initform cl:nil)
   (parking_sonar_data_valid
    :reader parking_sonar_data_valid
    :initarg :parking_sonar_data_valid
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SurroundReport (<SurroundReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SurroundReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SurroundReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<SurroundReport> is deprecated: use dbw_pacifica_msgs-msg:SurroundReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'front_radar_object_distance-val :lambda-list '(m))
(cl:defmethod front_radar_object_distance-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_radar_object_distance-val is deprecated.  Use dbw_pacifica_msgs-msg:front_radar_object_distance instead.")
  (front_radar_object_distance m))

(cl:ensure-generic-function 'rear_radar_object_distance-val :lambda-list '(m))
(cl:defmethod rear_radar_object_distance-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_radar_object_distance-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_radar_object_distance instead.")
  (rear_radar_object_distance m))

(cl:ensure-generic-function 'rear_right-val :lambda-list '(m))
(cl:defmethod rear_right-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_right-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_right instead.")
  (rear_right m))

(cl:ensure-generic-function 'rear_left-val :lambda-list '(m))
(cl:defmethod rear_left-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_left-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_left instead.")
  (rear_left m))

(cl:ensure-generic-function 'rear_center-val :lambda-list '(m))
(cl:defmethod rear_center-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_center-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_center instead.")
  (rear_center m))

(cl:ensure-generic-function 'front_right-val :lambda-list '(m))
(cl:defmethod front_right-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_right-val is deprecated.  Use dbw_pacifica_msgs-msg:front_right instead.")
  (front_right m))

(cl:ensure-generic-function 'front_left-val :lambda-list '(m))
(cl:defmethod front_left-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_left-val is deprecated.  Use dbw_pacifica_msgs-msg:front_left instead.")
  (front_left m))

(cl:ensure-generic-function 'front_center-val :lambda-list '(m))
(cl:defmethod front_center-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_center-val is deprecated.  Use dbw_pacifica_msgs-msg:front_center instead.")
  (front_center m))

(cl:ensure-generic-function 'front_radar_distance_valid-val :lambda-list '(m))
(cl:defmethod front_radar_distance_valid-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_radar_distance_valid-val is deprecated.  Use dbw_pacifica_msgs-msg:front_radar_distance_valid instead.")
  (front_radar_distance_valid m))

(cl:ensure-generic-function 'parking_sonar_data_valid-val :lambda-list '(m))
(cl:defmethod parking_sonar_data_valid-val ((m <SurroundReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:parking_sonar_data_valid-val is deprecated.  Use dbw_pacifica_msgs-msg:parking_sonar_data_valid instead.")
  (parking_sonar_data_valid m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SurroundReport>) ostream)
  "Serializes a message object of type '<SurroundReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'front_radar_object_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rear_radar_object_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_right) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_left) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_center) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front_right) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front_left) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front_center) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'front_radar_distance_valid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'parking_sonar_data_valid) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SurroundReport>) istream)
  "Deserializes a message object of type '<SurroundReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'front_radar_object_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rear_radar_object_distance) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_right) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_left) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_center) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front_right) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front_left) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front_center) istream)
    (cl:setf (cl:slot-value msg 'front_radar_distance_valid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'parking_sonar_data_valid) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SurroundReport>)))
  "Returns string type for a message object of type '<SurroundReport>"
  "dbw_pacifica_msgs/SurroundReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SurroundReport)))
  "Returns string type for a message object of type 'SurroundReport"
  "dbw_pacifica_msgs/SurroundReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SurroundReport>)))
  "Returns md5sum for a message object of type '<SurroundReport>"
  "7fb6baa192c10e400b9071053bd9c683")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SurroundReport)))
  "Returns md5sum for a message object of type 'SurroundReport"
  "7fb6baa192c10e400b9071053bd9c683")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SurroundReport>)))
  "Returns full string definition for message of type '<SurroundReport>"
  (cl:format cl:nil "Header header~%~%float32 front_radar_object_distance # meters~%float32 rear_radar_object_distance # meters~%~%SonarArcNum rear_right~%SonarArcNum rear_left~%SonarArcNum rear_center~%SonarArcNum front_right~%SonarArcNum front_left~%SonarArcNum front_center~%~%bool front_radar_distance_valid~%bool parking_sonar_data_valid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/SonarArcNum~%uint8 status~%~%# Unitless - based on bars on display~%uint8 NO_DISTANCE = 0~%uint8 ARC1 = 1~%uint8 ARC2 = 2~%uint8 ARC3 = 3~%uint8 ARC4 = 4~%uint8 ARC5 = 5~%uint8 ARC6 = 6~%uint8 ARC7 = 7~%uint8 ARC8 = 8~%uint8 NO_ARC = 15~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SurroundReport)))
  "Returns full string definition for message of type 'SurroundReport"
  (cl:format cl:nil "Header header~%~%float32 front_radar_object_distance # meters~%float32 rear_radar_object_distance # meters~%~%SonarArcNum rear_right~%SonarArcNum rear_left~%SonarArcNum rear_center~%SonarArcNum front_right~%SonarArcNum front_left~%SonarArcNum front_center~%~%bool front_radar_distance_valid~%bool parking_sonar_data_valid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/SonarArcNum~%uint8 status~%~%# Unitless - based on bars on display~%uint8 NO_DISTANCE = 0~%uint8 ARC1 = 1~%uint8 ARC2 = 2~%uint8 ARC3 = 3~%uint8 ARC4 = 4~%uint8 ARC5 = 5~%uint8 ARC6 = 6~%uint8 ARC7 = 7~%uint8 ARC8 = 8~%uint8 NO_ARC = 15~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SurroundReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_right))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_left))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_center))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front_right))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front_left))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front_center))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SurroundReport>))
  "Converts a ROS message object to a list"
  (cl:list 'SurroundReport
    (cl:cons ':header (header msg))
    (cl:cons ':front_radar_object_distance (front_radar_object_distance msg))
    (cl:cons ':rear_radar_object_distance (rear_radar_object_distance msg))
    (cl:cons ':rear_right (rear_right msg))
    (cl:cons ':rear_left (rear_left msg))
    (cl:cons ':rear_center (rear_center msg))
    (cl:cons ':front_right (front_right msg))
    (cl:cons ':front_left (front_left msg))
    (cl:cons ':front_center (front_center msg))
    (cl:cons ':front_radar_distance_valid (front_radar_distance_valid msg))
    (cl:cons ':parking_sonar_data_valid (parking_sonar_data_valid msg))
))
