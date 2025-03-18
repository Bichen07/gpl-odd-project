; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude MissionStatus.msg.html

(cl:defclass <MissionStatus> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass MissionStatus (<MissionStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MissionStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MissionStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<MissionStatus> is deprecated: use itri_msgs-msg:MissionStatus instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <MissionStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:status-val is deprecated.  Use itri_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MissionStatus>)))
    "Constants for message type '<MissionStatus>"
  '((:NORMAL . 0)
    (:EXECUTION . 1)
    (:COMPLETED . 2)
    (:REQUEST . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MissionStatus)))
    "Constants for message type 'MissionStatus"
  '((:NORMAL . 0)
    (:EXECUTION . 1)
    (:COMPLETED . 2)
    (:REQUEST . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MissionStatus>) ostream)
  "Serializes a message object of type '<MissionStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MissionStatus>) istream)
  "Deserializes a message object of type '<MissionStatus>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MissionStatus>)))
  "Returns string type for a message object of type '<MissionStatus>"
  "itri_msgs/MissionStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MissionStatus)))
  "Returns string type for a message object of type 'MissionStatus"
  "itri_msgs/MissionStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MissionStatus>)))
  "Returns md5sum for a message object of type '<MissionStatus>"
  "5ccdbc023fd502bb7d76a7a9700fb891")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MissionStatus)))
  "Returns md5sum for a message object of type 'MissionStatus"
  "5ccdbc023fd502bb7d76a7a9700fb891")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MissionStatus>)))
  "Returns full string definition for message of type '<MissionStatus>"
  (cl:format cl:nil "# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MissionStatus)))
  "Returns full string definition for message of type 'MissionStatus"
  (cl:format cl:nil "# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MissionStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MissionStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'MissionStatus
    (cl:cons ':status (status msg))
))
