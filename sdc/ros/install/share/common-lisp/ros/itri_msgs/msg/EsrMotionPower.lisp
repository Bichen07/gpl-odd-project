; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EsrMotionPower.msg.html

(cl:defclass <EsrMotionPower> (roslisp-msg-protocol:ros-message)
  ((track_moving
    :reader track_moving
    :initarg :track_moving
    :type cl:boolean
    :initform cl:nil)
   (track_movable_fast
    :reader track_movable_fast
    :initarg :track_movable_fast
    :type cl:boolean
    :initform cl:nil)
   (track_movable_slow
    :reader track_movable_slow
    :initarg :track_movable_slow
    :type cl:boolean
    :initform cl:nil)
   (track_power
    :reader track_power
    :initarg :track_power
    :type cl:fixnum
    :initform 0))
)

(cl:defclass EsrMotionPower (<EsrMotionPower>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsrMotionPower>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsrMotionPower)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EsrMotionPower> is deprecated: use itri_msgs-msg:EsrMotionPower instead.")))

(cl:ensure-generic-function 'track_moving-val :lambda-list '(m))
(cl:defmethod track_moving-val ((m <EsrMotionPower>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:track_moving-val is deprecated.  Use itri_msgs-msg:track_moving instead.")
  (track_moving m))

(cl:ensure-generic-function 'track_movable_fast-val :lambda-list '(m))
(cl:defmethod track_movable_fast-val ((m <EsrMotionPower>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:track_movable_fast-val is deprecated.  Use itri_msgs-msg:track_movable_fast instead.")
  (track_movable_fast m))

(cl:ensure-generic-function 'track_movable_slow-val :lambda-list '(m))
(cl:defmethod track_movable_slow-val ((m <EsrMotionPower>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:track_movable_slow-val is deprecated.  Use itri_msgs-msg:track_movable_slow instead.")
  (track_movable_slow m))

(cl:ensure-generic-function 'track_power-val :lambda-list '(m))
(cl:defmethod track_power-val ((m <EsrMotionPower>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:track_power-val is deprecated.  Use itri_msgs-msg:track_power instead.")
  (track_power m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsrMotionPower>) ostream)
  "Serializes a message object of type '<EsrMotionPower>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'track_moving) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'track_movable_fast) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'track_movable_slow) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'track_power)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsrMotionPower>) istream)
  "Deserializes a message object of type '<EsrMotionPower>"
    (cl:setf (cl:slot-value msg 'track_moving) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'track_movable_fast) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'track_movable_slow) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'track_power) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsrMotionPower>)))
  "Returns string type for a message object of type '<EsrMotionPower>"
  "itri_msgs/EsrMotionPower")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsrMotionPower)))
  "Returns string type for a message object of type 'EsrMotionPower"
  "itri_msgs/EsrMotionPower")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsrMotionPower>)))
  "Returns md5sum for a message object of type '<EsrMotionPower>"
  "adcd31c77e7090178d8bc4c127ff383f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsrMotionPower)))
  "Returns md5sum for a message object of type 'EsrMotionPower"
  "adcd31c77e7090178d8bc4c127ff383f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsrMotionPower>)))
  "Returns full string definition for message of type '<EsrMotionPower>"
  (cl:format cl:nil "bool track_moving~%bool track_movable_fast~%bool track_movable_slow~%int16 track_power~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsrMotionPower)))
  "Returns full string definition for message of type 'EsrMotionPower"
  (cl:format cl:nil "bool track_moving~%bool track_movable_fast~%bool track_movable_slow~%int16 track_power~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsrMotionPower>))
  (cl:+ 0
     1
     1
     1
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsrMotionPower>))
  "Converts a ROS message object to a list"
  (cl:list 'EsrMotionPower
    (cl:cons ':track_moving (track_moving msg))
    (cl:cons ':track_movable_fast (track_movable_fast msg))
    (cl:cons ':track_movable_slow (track_movable_slow msg))
    (cl:cons ':track_power (track_power msg))
))
