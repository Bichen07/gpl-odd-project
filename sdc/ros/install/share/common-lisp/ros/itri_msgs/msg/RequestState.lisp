; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude RequestState.msg.html

(cl:defclass <RequestState> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:fixnum
    :initform 0))
)

(cl:defclass RequestState (<RequestState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RequestState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RequestState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<RequestState> is deprecated: use itri_msgs-msg:RequestState instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <RequestState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:state-val is deprecated.  Use itri_msgs-msg:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<RequestState>)))
    "Constants for message type '<RequestState>"
  '((:NORMAL . 0)
    (:REQUEST . 1)
    (:RESUME . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'RequestState)))
    "Constants for message type 'RequestState"
  '((:NORMAL . 0)
    (:REQUEST . 1)
    (:RESUME . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RequestState>) ostream)
  "Serializes a message object of type '<RequestState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RequestState>) istream)
  "Deserializes a message object of type '<RequestState>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RequestState>)))
  "Returns string type for a message object of type '<RequestState>"
  "itri_msgs/RequestState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RequestState)))
  "Returns string type for a message object of type 'RequestState"
  "itri_msgs/RequestState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RequestState>)))
  "Returns md5sum for a message object of type '<RequestState>"
  "9ef62ea4045988e9b9bb57b5f100a0ce")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RequestState)))
  "Returns md5sum for a message object of type 'RequestState"
  "9ef62ea4045988e9b9bb57b5f100a0ce")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RequestState>)))
  "Returns full string definition for message of type '<RequestState>"
  (cl:format cl:nil "# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RequestState)))
  "Returns full string definition for message of type 'RequestState"
  (cl:format cl:nil "# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RequestState>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RequestState>))
  "Converts a ROS message object to a list"
  (cl:list 'RequestState
    (cl:cons ':state (state msg))
))
