; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude TrackingStatus.msg.html

(cl:defclass <TrackingStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (halfCycleSubtracted
    :reader halfCycleSubtracted
    :initarg :halfCycleSubtracted
    :type cl:boolean
    :initform cl:nil)
   (carrierPhaseValid
    :reader carrierPhaseValid
    :initarg :carrierPhaseValid
    :type cl:boolean
    :initform cl:nil)
   (pseudorangeValid
    :reader pseudorangeValid
    :initarg :pseudorangeValid
    :type cl:boolean
    :initform cl:nil)
   (halfCycleValid
    :reader halfCycleValid
    :initarg :halfCycleValid
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TrackingStatus (<TrackingStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrackingStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrackingStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<TrackingStatus> is deprecated: use openpilot_bridge-msg:TrackingStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrackingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'halfCycleSubtracted-val :lambda-list '(m))
(cl:defmethod halfCycleSubtracted-val ((m <TrackingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:halfCycleSubtracted-val is deprecated.  Use openpilot_bridge-msg:halfCycleSubtracted instead.")
  (halfCycleSubtracted m))

(cl:ensure-generic-function 'carrierPhaseValid-val :lambda-list '(m))
(cl:defmethod carrierPhaseValid-val ((m <TrackingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carrierPhaseValid-val is deprecated.  Use openpilot_bridge-msg:carrierPhaseValid instead.")
  (carrierPhaseValid m))

(cl:ensure-generic-function 'pseudorangeValid-val :lambda-list '(m))
(cl:defmethod pseudorangeValid-val ((m <TrackingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pseudorangeValid-val is deprecated.  Use openpilot_bridge-msg:pseudorangeValid instead.")
  (pseudorangeValid m))

(cl:ensure-generic-function 'halfCycleValid-val :lambda-list '(m))
(cl:defmethod halfCycleValid-val ((m <TrackingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:halfCycleValid-val is deprecated.  Use openpilot_bridge-msg:halfCycleValid instead.")
  (halfCycleValid m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrackingStatus>) ostream)
  "Serializes a message object of type '<TrackingStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'halfCycleSubtracted) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'carrierPhaseValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pseudorangeValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'halfCycleValid) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrackingStatus>) istream)
  "Deserializes a message object of type '<TrackingStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'halfCycleSubtracted) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'carrierPhaseValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'pseudorangeValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'halfCycleValid) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrackingStatus>)))
  "Returns string type for a message object of type '<TrackingStatus>"
  "openpilot_bridge/TrackingStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrackingStatus)))
  "Returns string type for a message object of type 'TrackingStatus"
  "openpilot_bridge/TrackingStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrackingStatus>)))
  "Returns md5sum for a message object of type '<TrackingStatus>"
  "1e90e81b8d405c8d5cd8beba0fd09111")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrackingStatus)))
  "Returns md5sum for a message object of type 'TrackingStatus"
  "1e90e81b8d405c8d5cd8beba0fd09111")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrackingStatus>)))
  "Returns full string definition for message of type '<TrackingStatus>"
  (cl:format cl:nil "Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrackingStatus)))
  "Returns full string definition for message of type 'TrackingStatus"
  (cl:format cl:nil "Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrackingStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrackingStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'TrackingStatus
    (cl:cons ':header (header msg))
    (cl:cons ':halfCycleSubtracted (halfCycleSubtracted msg))
    (cl:cons ':carrierPhaseValid (carrierPhaseValid msg))
    (cl:cons ':pseudorangeValid (pseudorangeValid msg))
    (cl:cons ':halfCycleValid (halfCycleValid msg))
))
