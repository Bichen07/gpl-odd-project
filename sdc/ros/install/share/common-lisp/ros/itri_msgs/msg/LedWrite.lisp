; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude LedWrite.msg.html

(cl:defclass <LedWrite> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (mode
    :reader mode
    :initarg :mode
    :type cl:fixnum
    :initform 0)
   (length
    :reader length
    :initarg :length
    :type cl:fixnum
    :initform 0)
   (action
    :reader action
    :initarg :action
    :type cl:fixnum
    :initform 0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:fixnum
    :initform 0)
   (stop_time
    :reader stop_time
    :initarg :stop_time
    :type cl:fixnum
    :initform 0)
   (frame
    :reader frame
    :initarg :frame
    :type cl:fixnum
    :initform 0)
   (numViews
    :reader numViews
    :initarg :numViews
    :type cl:fixnum
    :initform 0))
)

(cl:defclass LedWrite (<LedWrite>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LedWrite>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LedWrite)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<LedWrite> is deprecated: use itri_msgs-msg:LedWrite instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:data-val is deprecated.  Use itri_msgs-msg:data instead.")
  (data m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:mode-val is deprecated.  Use itri_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:length-val is deprecated.  Use itri_msgs-msg:length instead.")
  (length m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:action-val is deprecated.  Use itri_msgs-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:speed-val is deprecated.  Use itri_msgs-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'stop_time-val :lambda-list '(m))
(cl:defmethod stop_time-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:stop_time-val is deprecated.  Use itri_msgs-msg:stop_time instead.")
  (stop_time m))

(cl:ensure-generic-function 'frame-val :lambda-list '(m))
(cl:defmethod frame-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:frame-val is deprecated.  Use itri_msgs-msg:frame instead.")
  (frame m))

(cl:ensure-generic-function 'numViews-val :lambda-list '(m))
(cl:defmethod numViews-val ((m <LedWrite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:numViews-val is deprecated.  Use itri_msgs-msg:numViews instead.")
  (numViews m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LedWrite>) ostream)
  "Serializes a message object of type '<LedWrite>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'length)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'speed)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'stop_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frame)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'numViews)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LedWrite>) istream)
  "Deserializes a message object of type '<LedWrite>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'length)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'speed)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'stop_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frame)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'numViews)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LedWrite>)))
  "Returns string type for a message object of type '<LedWrite>"
  "itri_msgs/LedWrite")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LedWrite)))
  "Returns string type for a message object of type 'LedWrite"
  "itri_msgs/LedWrite")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LedWrite>)))
  "Returns md5sum for a message object of type '<LedWrite>"
  "0d492c2637a3aced37a6325f8359af16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LedWrite)))
  "Returns md5sum for a message object of type 'LedWrite"
  "0d492c2637a3aced37a6325f8359af16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LedWrite>)))
  "Returns full string definition for message of type '<LedWrite>"
  (cl:format cl:nil "char[] data~%uint8 mode~%uint8 length~%uint8 action~%uint8 speed~%uint8 stop_time~%uint8 frame~%uint8 numViews~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LedWrite)))
  "Returns full string definition for message of type 'LedWrite"
  (cl:format cl:nil "char[] data~%uint8 mode~%uint8 length~%uint8 action~%uint8 speed~%uint8 stop_time~%uint8 frame~%uint8 numViews~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LedWrite>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LedWrite>))
  "Converts a ROS message object to a list"
  (cl:list 'LedWrite
    (cl:cons ':data (data msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':length (length msg))
    (cl:cons ':action (action msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':stop_time (stop_time msg))
    (cl:cons ':frame (frame msg))
    (cl:cons ':numViews (numViews msg))
))
