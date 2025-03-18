; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude Ignition.msg.html

(cl:defclass <Ignition> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Ignition (<Ignition>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ignition>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ignition)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<Ignition> is deprecated: use dbw_pacifica_msgs-msg:Ignition instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <Ignition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:status-val is deprecated.  Use dbw_pacifica_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Ignition>)))
    "Constants for message type '<Ignition>"
  '((:NO_REQUEST . 0)
    (:FORCE_OFF . 0)
    (:ACCESSORY . 0)
    (:RUN . 0)
    (:CRANK . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Ignition)))
    "Constants for message type 'Ignition"
  '((:NO_REQUEST . 0)
    (:FORCE_OFF . 0)
    (:ACCESSORY . 0)
    (:RUN . 0)
    (:CRANK . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ignition>) ostream)
  "Serializes a message object of type '<Ignition>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ignition>) istream)
  "Deserializes a message object of type '<Ignition>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ignition>)))
  "Returns string type for a message object of type '<Ignition>"
  "dbw_pacifica_msgs/Ignition")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ignition)))
  "Returns string type for a message object of type 'Ignition"
  "dbw_pacifica_msgs/Ignition")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ignition>)))
  "Returns md5sum for a message object of type '<Ignition>"
  "33e510d1388f6c82901b8ae2d40ab030")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ignition)))
  "Returns md5sum for a message object of type 'Ignition"
  "33e510d1388f6c82901b8ae2d40ab030")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ignition>)))
  "Returns full string definition for message of type '<Ignition>"
  (cl:format cl:nil "uint8 status~%~%uint8 NO_REQUEST = 0~%uint8 FORCE_OFF = 0~%uint8 ACCESSORY = 0~%uint8 RUN = 0~%uint8 CRANK = 0~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ignition)))
  "Returns full string definition for message of type 'Ignition"
  (cl:format cl:nil "uint8 status~%~%uint8 NO_REQUEST = 0~%uint8 FORCE_OFF = 0~%uint8 ACCESSORY = 0~%uint8 RUN = 0~%uint8 CRANK = 0~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ignition>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ignition>))
  "Converts a ROS message object to a list"
  (cl:list 'Ignition
    (cl:cons ':status (status msg))
))
