; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficLightStatus.msg.html

(cl:defclass <TrafficLightStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header)))
)

(cl:defclass TrafficLightStatus (<TrafficLightStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficLightStatus> is deprecated: use itri_msgs-msg:TrafficLightStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficLightStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TrafficLightStatus>)))
    "Constants for message type '<TrafficLightStatus>"
  '((:RED . 1)
    (:GREEN . 2)
    (:YELLOW . 3)
    (:STRAIGHT . 4)
    (:RED_LEFT . 5)
    (:RED_RIGHT . 6)
    (:RED_LEFT_RIGHT . 7)
    (:STRAIGHT_LEFT . 8)
    (:STRAIGHT_RIGHT . 9)
    (:STRAIGHT_LEFT_RIGHT . 10)
    (:LEFT . 11)
    (:RIGHT . 12)
    (:LEFT_RIGHT . 13)
    (:FLASH_RED . 14)
    (:FLASH_YELLOW . 15))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TrafficLightStatus)))
    "Constants for message type 'TrafficLightStatus"
  '((:RED . 1)
    (:GREEN . 2)
    (:YELLOW . 3)
    (:STRAIGHT . 4)
    (:RED_LEFT . 5)
    (:RED_RIGHT . 6)
    (:RED_LEFT_RIGHT . 7)
    (:STRAIGHT_LEFT . 8)
    (:STRAIGHT_RIGHT . 9)
    (:STRAIGHT_LEFT_RIGHT . 10)
    (:LEFT . 11)
    (:RIGHT . 12)
    (:LEFT_RIGHT . 13)
    (:FLASH_RED . 14)
    (:FLASH_YELLOW . 15))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightStatus>) ostream)
  "Serializes a message object of type '<TrafficLightStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightStatus>) istream)
  "Deserializes a message object of type '<TrafficLightStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightStatus>)))
  "Returns string type for a message object of type '<TrafficLightStatus>"
  "itri_msgs/TrafficLightStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightStatus)))
  "Returns string type for a message object of type 'TrafficLightStatus"
  "itri_msgs/TrafficLightStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightStatus>)))
  "Returns md5sum for a message object of type '<TrafficLightStatus>"
  "e50a875585f97d23b2d45a1f01d9e6d9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightStatus)))
  "Returns md5sum for a message object of type 'TrafficLightStatus"
  "e50a875585f97d23b2d45a1f01d9e6d9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightStatus>)))
  "Returns full string definition for message of type '<TrafficLightStatus>"
  (cl:format cl:nil "Header header~%~%uint8 RED = 1~%uint8 GREEN = 2~%uint8 YELLOW = 3~%uint8 STRAIGHT = 4~%uint8 RED_LEFT = 5~%uint8 RED_RIGHT = 6~%uint8 RED_LEFT_RIGHT = 7~%uint8 STRAIGHT_LEFT = 8~%uint8 STRAIGHT_RIGHT = 9~%uint8 STRAIGHT_LEFT_RIGHT = 10~%uint8 LEFT = 11~%uint8 RIGHT = 12~%uint8 LEFT_RIGHT = 13~%uint8 FLASH_RED = 14~%uint8 FLASH_YELLOW = 15~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightStatus)))
  "Returns full string definition for message of type 'TrafficLightStatus"
  (cl:format cl:nil "Header header~%~%uint8 RED = 1~%uint8 GREEN = 2~%uint8 YELLOW = 3~%uint8 STRAIGHT = 4~%uint8 RED_LEFT = 5~%uint8 RED_RIGHT = 6~%uint8 RED_LEFT_RIGHT = 7~%uint8 STRAIGHT_LEFT = 8~%uint8 STRAIGHT_RIGHT = 9~%uint8 STRAIGHT_LEFT_RIGHT = 10~%uint8 LEFT = 11~%uint8 RIGHT = 12~%uint8 LEFT_RIGHT = 13~%uint8 FLASH_RED = 14~%uint8 FLASH_YELLOW = 15~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightStatus
    (cl:cons ':header (header msg))
))
