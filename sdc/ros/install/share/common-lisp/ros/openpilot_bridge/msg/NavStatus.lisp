; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude NavStatus.msg.html

(cl:defclass <NavStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (isNavigating
    :reader isNavigating
    :initarg :isNavigating
    :type cl:boolean
    :initform cl:nil)
   (currentAddress
    :reader currentAddress
    :initarg :currentAddress
    :type openpilot_bridge-msg:Address
    :initform (cl:make-instance 'openpilot_bridge-msg:Address)))
)

(cl:defclass NavStatus (<NavStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<NavStatus> is deprecated: use openpilot_bridge-msg:NavStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'isNavigating-val :lambda-list '(m))
(cl:defmethod isNavigating-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:isNavigating-val is deprecated.  Use openpilot_bridge-msg:isNavigating instead.")
  (isNavigating m))

(cl:ensure-generic-function 'currentAddress-val :lambda-list '(m))
(cl:defmethod currentAddress-val ((m <NavStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:currentAddress-val is deprecated.  Use openpilot_bridge-msg:currentAddress instead.")
  (currentAddress m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavStatus>) ostream)
  "Serializes a message object of type '<NavStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isNavigating) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'currentAddress) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavStatus>) istream)
  "Deserializes a message object of type '<NavStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'isNavigating) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'currentAddress) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavStatus>)))
  "Returns string type for a message object of type '<NavStatus>"
  "openpilot_bridge/NavStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavStatus)))
  "Returns string type for a message object of type 'NavStatus"
  "openpilot_bridge/NavStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavStatus>)))
  "Returns md5sum for a message object of type '<NavStatus>"
  "fd019d3ff14a21235dbb5ba7e40cd211")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavStatus)))
  "Returns md5sum for a message object of type 'NavStatus"
  "fd019d3ff14a21235dbb5ba7e40cd211")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavStatus>)))
  "Returns full string definition for message of type '<NavStatus>"
  (cl:format cl:nil "Header header~%~%bool isNavigating~%Address currentAddress~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Address~%Header header~%~%string[] city~%string[] title~%string[] house~%string[] state~%string[] street~%string[] address~%float32 lat~%float32 lng~%string[] country~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavStatus)))
  "Returns full string definition for message of type 'NavStatus"
  (cl:format cl:nil "Header header~%~%bool isNavigating~%Address currentAddress~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Address~%Header header~%~%string[] city~%string[] title~%string[] house~%string[] state~%string[] street~%string[] address~%float32 lat~%float32 lng~%string[] country~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'currentAddress))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'NavStatus
    (cl:cons ':header (header msg))
    (cl:cons ':isNavigating (isNavigating msg))
    (cl:cons ':currentAddress (currentAddress msg))
))
