; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude LineParm.msg.html

(cl:defclass <LineParm> (roslisp-msg-protocol:ros-message)
  ((parm0
    :reader parm0
    :initarg :parm0
    :type cl:float
    :initform 0.0)
   (parm1
    :reader parm1
    :initarg :parm1
    :type cl:float
    :initform 0.0)
   (parm2
    :reader parm2
    :initarg :parm2
    :type cl:float
    :initform 0.0)
   (confidentScore
    :reader confidentScore
    :initarg :confidentScore
    :type cl:fixnum
    :initform 0)
   (frameIdx
    :reader frameIdx
    :initarg :frameIdx
    :type cl:fixnum
    :initform 0))
)

(cl:defclass LineParm (<LineParm>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LineParm>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LineParm)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<LineParm> is deprecated: use itri_msgs-msg:LineParm instead.")))

(cl:ensure-generic-function 'parm0-val :lambda-list '(m))
(cl:defmethod parm0-val ((m <LineParm>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parm0-val is deprecated.  Use itri_msgs-msg:parm0 instead.")
  (parm0 m))

(cl:ensure-generic-function 'parm1-val :lambda-list '(m))
(cl:defmethod parm1-val ((m <LineParm>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parm1-val is deprecated.  Use itri_msgs-msg:parm1 instead.")
  (parm1 m))

(cl:ensure-generic-function 'parm2-val :lambda-list '(m))
(cl:defmethod parm2-val ((m <LineParm>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parm2-val is deprecated.  Use itri_msgs-msg:parm2 instead.")
  (parm2 m))

(cl:ensure-generic-function 'confidentScore-val :lambda-list '(m))
(cl:defmethod confidentScore-val ((m <LineParm>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:confidentScore-val is deprecated.  Use itri_msgs-msg:confidentScore instead.")
  (confidentScore m))

(cl:ensure-generic-function 'frameIdx-val :lambda-list '(m))
(cl:defmethod frameIdx-val ((m <LineParm>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:frameIdx-val is deprecated.  Use itri_msgs-msg:frameIdx instead.")
  (frameIdx m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LineParm>) ostream)
  "Serializes a message object of type '<LineParm>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'parm0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'parm1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'parm2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'confidentScore)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'confidentScore)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameIdx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameIdx)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LineParm>) istream)
  "Deserializes a message object of type '<LineParm>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'parm0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'parm1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'parm2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'confidentScore)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'confidentScore)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameIdx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameIdx)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LineParm>)))
  "Returns string type for a message object of type '<LineParm>"
  "itri_msgs/LineParm")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LineParm)))
  "Returns string type for a message object of type 'LineParm"
  "itri_msgs/LineParm")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LineParm>)))
  "Returns md5sum for a message object of type '<LineParm>"
  "4ba0e2d1442ddcc8696bcf7cb4f9b46e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LineParm)))
  "Returns md5sum for a message object of type 'LineParm"
  "4ba0e2d1442ddcc8696bcf7cb4f9b46e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LineParm>)))
  "Returns full string definition for message of type '<LineParm>"
  (cl:format cl:nil "float32 parm0~%float32 parm1~%float32 parm2~%uint16 confidentScore~%uint16 frameIdx~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LineParm)))
  "Returns full string definition for message of type 'LineParm"
  (cl:format cl:nil "float32 parm0~%float32 parm1~%float32 parm2~%uint16 confidentScore~%uint16 frameIdx~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LineParm>))
  (cl:+ 0
     4
     4
     4
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LineParm>))
  "Converts a ROS message object to a list"
  (cl:list 'LineParm
    (cl:cons ':parm0 (parm0 msg))
    (cl:cons ':parm1 (parm1 msg))
    (cl:cons ':parm2 (parm2 msg))
    (cl:cons ':confidentScore (confidentScore msg))
    (cl:cons ':frameIdx (frameIdx msg))
))
