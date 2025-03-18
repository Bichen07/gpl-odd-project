; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ReceiverStatus.msg.html

(cl:defclass <ReceiverStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (leapSecValid
    :reader leapSecValid
    :initarg :leapSecValid
    :type cl:boolean
    :initform cl:nil)
   (clkReset
    :reader clkReset
    :initarg :clkReset
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ReceiverStatus (<ReceiverStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ReceiverStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ReceiverStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ReceiverStatus> is deprecated: use openpilot_bridge-msg:ReceiverStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ReceiverStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'leapSecValid-val :lambda-list '(m))
(cl:defmethod leapSecValid-val ((m <ReceiverStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leapSecValid-val is deprecated.  Use openpilot_bridge-msg:leapSecValid instead.")
  (leapSecValid m))

(cl:ensure-generic-function 'clkReset-val :lambda-list '(m))
(cl:defmethod clkReset-val ((m <ReceiverStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clkReset-val is deprecated.  Use openpilot_bridge-msg:clkReset instead.")
  (clkReset m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ReceiverStatus>) ostream)
  "Serializes a message object of type '<ReceiverStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'leapSecValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'clkReset) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ReceiverStatus>) istream)
  "Deserializes a message object of type '<ReceiverStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'leapSecValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'clkReset) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ReceiverStatus>)))
  "Returns string type for a message object of type '<ReceiverStatus>"
  "openpilot_bridge/ReceiverStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ReceiverStatus)))
  "Returns string type for a message object of type 'ReceiverStatus"
  "openpilot_bridge/ReceiverStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ReceiverStatus>)))
  "Returns md5sum for a message object of type '<ReceiverStatus>"
  "37035768a9037c3faee5bf61b59c4cd4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ReceiverStatus)))
  "Returns md5sum for a message object of type 'ReceiverStatus"
  "37035768a9037c3faee5bf61b59c4cd4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ReceiverStatus>)))
  "Returns full string definition for message of type '<ReceiverStatus>"
  (cl:format cl:nil "Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ReceiverStatus)))
  "Returns full string definition for message of type 'ReceiverStatus"
  (cl:format cl:nil "Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ReceiverStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ReceiverStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'ReceiverStatus
    (cl:cons ':header (header msg))
    (cl:cons ':leapSecValid (leapSecValid msg))
    (cl:cons ':clkReset (clkReset msg))
))
