; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude AEB.msg.html

(cl:defclass <AEB> (roslisp-msg-protocol:ros-message)
  ((aeb_active
    :reader aeb_active
    :initarg :aeb_active
    :type cl:fixnum
    :initform 0))
)

(cl:defclass AEB (<AEB>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AEB>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AEB)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<AEB> is deprecated: use itri_msgs-msg:AEB instead.")))

(cl:ensure-generic-function 'aeb_active-val :lambda-list '(m))
(cl:defmethod aeb_active-val ((m <AEB>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:aeb_active-val is deprecated.  Use itri_msgs-msg:aeb_active instead.")
  (aeb_active m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AEB>)))
    "Constants for message type '<AEB>"
  '((:CLOSE . 0)
    (:OPEN . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AEB)))
    "Constants for message type 'AEB"
  '((:CLOSE . 0)
    (:OPEN . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AEB>) ostream)
  "Serializes a message object of type '<AEB>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aeb_active)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AEB>) istream)
  "Deserializes a message object of type '<AEB>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aeb_active)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AEB>)))
  "Returns string type for a message object of type '<AEB>"
  "itri_msgs/AEB")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AEB)))
  "Returns string type for a message object of type 'AEB"
  "itri_msgs/AEB")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AEB>)))
  "Returns md5sum for a message object of type '<AEB>"
  "4c603c1cf5fc3ab31bd6a40781aee3d6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AEB)))
  "Returns md5sum for a message object of type 'AEB"
  "4c603c1cf5fc3ab31bd6a40781aee3d6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AEB>)))
  "Returns full string definition for message of type '<AEB>"
  (cl:format cl:nil "uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 aeb_active~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AEB)))
  "Returns full string definition for message of type 'AEB"
  (cl:format cl:nil "uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 aeb_active~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AEB>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AEB>))
  "Converts a ROS message object to a list"
  (cl:list 'AEB
    (cl:cons ':aeb_active (aeb_active msg))
))
