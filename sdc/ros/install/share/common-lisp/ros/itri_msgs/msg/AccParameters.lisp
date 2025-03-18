; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude AccParameters.msg.html

(cl:defclass <AccParameters> (roslisp-msg-protocol:ros-message)
  ((Kp
    :reader Kp
    :initarg :Kp
    :type cl:float
    :initform 0.0)
   (Ki
    :reader Ki
    :initarg :Ki
    :type cl:float
    :initform 0.0)
   (Kd
    :reader Kd
    :initarg :Kd
    :type cl:float
    :initform 0.0)
   (velocitySetpoint
    :reader velocitySetpoint
    :initarg :velocitySetpoint
    :type cl:float
    :initform 0.0)
   (distanceSetpoint
    :reader distanceSetpoint
    :initarg :distanceSetpoint
    :type cl:float
    :initform 0.0))
)

(cl:defclass AccParameters (<AccParameters>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AccParameters>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AccParameters)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<AccParameters> is deprecated: use itri_msgs-msg:AccParameters instead.")))

(cl:ensure-generic-function 'Kp-val :lambda-list '(m))
(cl:defmethod Kp-val ((m <AccParameters>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:Kp-val is deprecated.  Use itri_msgs-msg:Kp instead.")
  (Kp m))

(cl:ensure-generic-function 'Ki-val :lambda-list '(m))
(cl:defmethod Ki-val ((m <AccParameters>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:Ki-val is deprecated.  Use itri_msgs-msg:Ki instead.")
  (Ki m))

(cl:ensure-generic-function 'Kd-val :lambda-list '(m))
(cl:defmethod Kd-val ((m <AccParameters>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:Kd-val is deprecated.  Use itri_msgs-msg:Kd instead.")
  (Kd m))

(cl:ensure-generic-function 'velocitySetpoint-val :lambda-list '(m))
(cl:defmethod velocitySetpoint-val ((m <AccParameters>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocitySetpoint-val is deprecated.  Use itri_msgs-msg:velocitySetpoint instead.")
  (velocitySetpoint m))

(cl:ensure-generic-function 'distanceSetpoint-val :lambda-list '(m))
(cl:defmethod distanceSetpoint-val ((m <AccParameters>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:distanceSetpoint-val is deprecated.  Use itri_msgs-msg:distanceSetpoint instead.")
  (distanceSetpoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AccParameters>) ostream)
  "Serializes a message object of type '<AccParameters>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Kp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Ki))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Kd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'velocitySetpoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distanceSetpoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AccParameters>) istream)
  "Deserializes a message object of type '<AccParameters>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Kp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Ki) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Kd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'velocitySetpoint) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distanceSetpoint) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AccParameters>)))
  "Returns string type for a message object of type '<AccParameters>"
  "itri_msgs/AccParameters")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AccParameters)))
  "Returns string type for a message object of type 'AccParameters"
  "itri_msgs/AccParameters")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AccParameters>)))
  "Returns md5sum for a message object of type '<AccParameters>"
  "5eeae744c2e67ea25e37fe82a1c8dd42")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AccParameters)))
  "Returns md5sum for a message object of type 'AccParameters"
  "5eeae744c2e67ea25e37fe82a1c8dd42")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AccParameters>)))
  "Returns full string definition for message of type '<AccParameters>"
  (cl:format cl:nil "float32 Kp~%float32 Ki~%float32 Kd~%float32 velocitySetpoint~%float32 distanceSetpoint~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AccParameters)))
  "Returns full string definition for message of type 'AccParameters"
  (cl:format cl:nil "float32 Kp~%float32 Ki~%float32 Kd~%float32 velocitySetpoint~%float32 distanceSetpoint~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AccParameters>))
  (cl:+ 0
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AccParameters>))
  "Converts a ROS message object to a list"
  (cl:list 'AccParameters
    (cl:cons ':Kp (Kp msg))
    (cl:cons ':Ki (Ki msg))
    (cl:cons ':Kd (Kd msg))
    (cl:cons ':velocitySetpoint (velocitySetpoint msg))
    (cl:cons ':distanceSetpoint (distanceSetpoint msg))
))
