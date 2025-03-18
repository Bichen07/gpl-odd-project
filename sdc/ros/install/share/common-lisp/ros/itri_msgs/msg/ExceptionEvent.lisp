; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ExceptionEvent.msg.html

(cl:defclass <ExceptionEvent> (roslisp-msg-protocol:ros-message)
  ((event
    :reader event
    :initarg :event
    :type cl:integer
    :initform 0))
)

(cl:defclass ExceptionEvent (<ExceptionEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExceptionEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExceptionEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ExceptionEvent> is deprecated: use itri_msgs-msg:ExceptionEvent instead.")))

(cl:ensure-generic-function 'event-val :lambda-list '(m))
(cl:defmethod event-val ((m <ExceptionEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:event-val is deprecated.  Use itri_msgs-msg:event instead.")
  (event m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ExceptionEvent>)))
    "Constants for message type '<ExceptionEvent>"
  '((:NORMAL . 0)
    (:HARD_BRAKE . 1)
    (:MILD_BRAKE . 2)
    (:DETOUR . 3)
    (:PULL_OVER . 4)
    (:TIME_OUT . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ExceptionEvent)))
    "Constants for message type 'ExceptionEvent"
  '((:NORMAL . 0)
    (:HARD_BRAKE . 1)
    (:MILD_BRAKE . 2)
    (:DETOUR . 3)
    (:PULL_OVER . 4)
    (:TIME_OUT . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExceptionEvent>) ostream)
  "Serializes a message object of type '<ExceptionEvent>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'event)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'event)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'event)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'event)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExceptionEvent>) istream)
  "Deserializes a message object of type '<ExceptionEvent>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'event)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'event)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'event)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'event)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExceptionEvent>)))
  "Returns string type for a message object of type '<ExceptionEvent>"
  "itri_msgs/ExceptionEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionEvent)))
  "Returns string type for a message object of type 'ExceptionEvent"
  "itri_msgs/ExceptionEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExceptionEvent>)))
  "Returns md5sum for a message object of type '<ExceptionEvent>"
  "8fe25700fd3ceb690ea90fb4ee026e1d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExceptionEvent)))
  "Returns md5sum for a message object of type 'ExceptionEvent"
  "8fe25700fd3ceb690ea90fb4ee026e1d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExceptionEvent>)))
  "Returns full string definition for message of type '<ExceptionEvent>"
  (cl:format cl:nil "# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExceptionEvent)))
  "Returns full string definition for message of type 'ExceptionEvent"
  (cl:format cl:nil "# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExceptionEvent>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExceptionEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'ExceptionEvent
    (cl:cons ':event (event msg))
))
