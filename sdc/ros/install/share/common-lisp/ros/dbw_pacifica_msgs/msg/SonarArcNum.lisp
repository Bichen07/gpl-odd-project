; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude SonarArcNum.msg.html

(cl:defclass <SonarArcNum> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SonarArcNum (<SonarArcNum>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SonarArcNum>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SonarArcNum)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<SonarArcNum> is deprecated: use dbw_pacifica_msgs-msg:SonarArcNum instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <SonarArcNum>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:status-val is deprecated.  Use dbw_pacifica_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SonarArcNum>)))
    "Constants for message type '<SonarArcNum>"
  '((:NO_DISTANCE . 0)
    (:ARC1 . 1)
    (:ARC2 . 2)
    (:ARC3 . 3)
    (:ARC4 . 4)
    (:ARC5 . 5)
    (:ARC6 . 6)
    (:ARC7 . 7)
    (:ARC8 . 8)
    (:NO_ARC . 15))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SonarArcNum)))
    "Constants for message type 'SonarArcNum"
  '((:NO_DISTANCE . 0)
    (:ARC1 . 1)
    (:ARC2 . 2)
    (:ARC3 . 3)
    (:ARC4 . 4)
    (:ARC5 . 5)
    (:ARC6 . 6)
    (:ARC7 . 7)
    (:ARC8 . 8)
    (:NO_ARC . 15))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SonarArcNum>) ostream)
  "Serializes a message object of type '<SonarArcNum>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SonarArcNum>) istream)
  "Deserializes a message object of type '<SonarArcNum>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SonarArcNum>)))
  "Returns string type for a message object of type '<SonarArcNum>"
  "dbw_pacifica_msgs/SonarArcNum")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SonarArcNum)))
  "Returns string type for a message object of type 'SonarArcNum"
  "dbw_pacifica_msgs/SonarArcNum")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SonarArcNum>)))
  "Returns md5sum for a message object of type '<SonarArcNum>"
  "06cc406551462e830a15f0d81395d2f4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SonarArcNum)))
  "Returns md5sum for a message object of type 'SonarArcNum"
  "06cc406551462e830a15f0d81395d2f4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SonarArcNum>)))
  "Returns full string definition for message of type '<SonarArcNum>"
  (cl:format cl:nil "uint8 status~%~%# Unitless - based on bars on display~%uint8 NO_DISTANCE = 0~%uint8 ARC1 = 1~%uint8 ARC2 = 2~%uint8 ARC3 = 3~%uint8 ARC4 = 4~%uint8 ARC5 = 5~%uint8 ARC6 = 6~%uint8 ARC7 = 7~%uint8 ARC8 = 8~%uint8 NO_ARC = 15~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SonarArcNum)))
  "Returns full string definition for message of type 'SonarArcNum"
  (cl:format cl:nil "uint8 status~%~%# Unitless - based on bars on display~%uint8 NO_DISTANCE = 0~%uint8 ARC1 = 1~%uint8 ARC2 = 2~%uint8 ARC3 = 3~%uint8 ARC4 = 4~%uint8 ARC5 = 5~%uint8 ARC6 = 6~%uint8 ARC7 = 7~%uint8 ARC8 = 8~%uint8 NO_ARC = 15~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SonarArcNum>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SonarArcNum>))
  "Converts a ROS message object to a list"
  (cl:list 'SonarArcNum
    (cl:cons ':status (status msg))
))
