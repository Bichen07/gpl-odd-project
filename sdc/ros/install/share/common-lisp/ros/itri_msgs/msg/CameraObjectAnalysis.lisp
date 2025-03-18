; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude CameraObjectAnalysis.msg.html

(cl:defclass <CameraObjectAnalysis> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (center_distance
    :reader center_distance
    :initarg :center_distance
    :type cl:float
    :initform 0.0)
   (diou
    :reader diou
    :initarg :diou
    :type cl:float
    :initform 0.0))
)

(cl:defclass CameraObjectAnalysis (<CameraObjectAnalysis>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraObjectAnalysis>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraObjectAnalysis)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<CameraObjectAnalysis> is deprecated: use itri_msgs-msg:CameraObjectAnalysis instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <CameraObjectAnalysis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'center_distance-val :lambda-list '(m))
(cl:defmethod center_distance-val ((m <CameraObjectAnalysis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:center_distance-val is deprecated.  Use itri_msgs-msg:center_distance instead.")
  (center_distance m))

(cl:ensure-generic-function 'diou-val :lambda-list '(m))
(cl:defmethod diou-val ((m <CameraObjectAnalysis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:diou-val is deprecated.  Use itri_msgs-msg:diou instead.")
  (diou m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraObjectAnalysis>) ostream)
  "Serializes a message object of type '<CameraObjectAnalysis>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'center_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diou))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraObjectAnalysis>) istream)
  "Deserializes a message object of type '<CameraObjectAnalysis>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'center_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'diou) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraObjectAnalysis>)))
  "Returns string type for a message object of type '<CameraObjectAnalysis>"
  "itri_msgs/CameraObjectAnalysis")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraObjectAnalysis)))
  "Returns string type for a message object of type 'CameraObjectAnalysis"
  "itri_msgs/CameraObjectAnalysis")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraObjectAnalysis>)))
  "Returns md5sum for a message object of type '<CameraObjectAnalysis>"
  "ced6441f7a38e34baaa1c710d22e6e89")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraObjectAnalysis)))
  "Returns md5sum for a message object of type 'CameraObjectAnalysis"
  "ced6441f7a38e34baaa1c710d22e6e89")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraObjectAnalysis>)))
  "Returns full string definition for message of type '<CameraObjectAnalysis>"
  (cl:format cl:nil "uint32 id~%float32 center_distance~%float32 diou~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraObjectAnalysis)))
  "Returns full string definition for message of type 'CameraObjectAnalysis"
  (cl:format cl:nil "uint32 id~%float32 center_distance~%float32 diou~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraObjectAnalysis>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraObjectAnalysis>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraObjectAnalysis
    (cl:cons ':id (id msg))
    (cl:cons ':center_distance (center_distance msg))
    (cl:cons ':diou (diou msg))
))
