; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ExceptionMissions.msg.html

(cl:defclass <ExceptionMissions> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (mission
    :reader mission
    :initarg :mission
    :type (cl:vector itri_msgs-msg:ExceptionMission)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:ExceptionMission :initial-element (cl:make-instance 'itri_msgs-msg:ExceptionMission))))
)

(cl:defclass ExceptionMissions (<ExceptionMissions>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExceptionMissions>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExceptionMissions)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ExceptionMissions> is deprecated: use itri_msgs-msg:ExceptionMissions instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ExceptionMissions>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'mission-val :lambda-list '(m))
(cl:defmethod mission-val ((m <ExceptionMissions>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:mission-val is deprecated.  Use itri_msgs-msg:mission instead.")
  (mission m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExceptionMissions>) ostream)
  "Serializes a message object of type '<ExceptionMissions>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'mission))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'mission))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExceptionMissions>) istream)
  "Deserializes a message object of type '<ExceptionMissions>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'mission) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'mission)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:ExceptionMission))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExceptionMissions>)))
  "Returns string type for a message object of type '<ExceptionMissions>"
  "itri_msgs/ExceptionMissions")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionMissions)))
  "Returns string type for a message object of type 'ExceptionMissions"
  "itri_msgs/ExceptionMissions")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExceptionMissions>)))
  "Returns md5sum for a message object of type '<ExceptionMissions>"
  "0b319236f3f70b2499cfecac4de7a18f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExceptionMissions)))
  "Returns md5sum for a message object of type 'ExceptionMissions"
  "0b319236f3f70b2499cfecac4de7a18f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExceptionMissions>)))
  "Returns full string definition for message of type '<ExceptionMissions>"
  (cl:format cl:nil "Header header~%~%ExceptionMission[] mission~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/ExceptionMission~%ExceptionEvent exception_event~%RequestState request~%MissionStatus mission~%~%================================================================================~%MSG: itri_msgs/ExceptionEvent~%# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%================================================================================~%MSG: itri_msgs/RequestState~%# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%================================================================================~%MSG: itri_msgs/MissionStatus~%# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExceptionMissions)))
  "Returns full string definition for message of type 'ExceptionMissions"
  (cl:format cl:nil "Header header~%~%ExceptionMission[] mission~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/ExceptionMission~%ExceptionEvent exception_event~%RequestState request~%MissionStatus mission~%~%================================================================================~%MSG: itri_msgs/ExceptionEvent~%# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%================================================================================~%MSG: itri_msgs/RequestState~%# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%================================================================================~%MSG: itri_msgs/MissionStatus~%# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExceptionMissions>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'mission) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExceptionMissions>))
  "Converts a ROS message object to a list"
  (cl:list 'ExceptionMissions
    (cl:cons ':header (header msg))
    (cl:cons ':mission (mission msg))
))
