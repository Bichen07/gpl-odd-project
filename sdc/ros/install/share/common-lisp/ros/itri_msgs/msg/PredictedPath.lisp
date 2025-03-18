; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude PredictedPath.msg.html

(cl:defclass <PredictedPath> (roslisp-msg-protocol:ros-message)
  ((probability
    :reader probability
    :initarg :probability
    :type cl:float
    :initform 0.0)
   (predicted_path
    :reader predicted_path
    :initarg :predicted_path
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (predicted_velocity
    :reader predicted_velocity
    :initarg :predicted_velocity
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass PredictedPath (<PredictedPath>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PredictedPath>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PredictedPath)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<PredictedPath> is deprecated: use itri_msgs-msg:PredictedPath instead.")))

(cl:ensure-generic-function 'probability-val :lambda-list '(m))
(cl:defmethod probability-val ((m <PredictedPath>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:probability-val is deprecated.  Use itri_msgs-msg:probability instead.")
  (probability m))

(cl:ensure-generic-function 'predicted_path-val :lambda-list '(m))
(cl:defmethod predicted_path-val ((m <PredictedPath>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_path-val is deprecated.  Use itri_msgs-msg:predicted_path instead.")
  (predicted_path m))

(cl:ensure-generic-function 'predicted_velocity-val :lambda-list '(m))
(cl:defmethod predicted_velocity-val ((m <PredictedPath>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_velocity-val is deprecated.  Use itri_msgs-msg:predicted_velocity instead.")
  (predicted_velocity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PredictedPath>) ostream)
  "Serializes a message object of type '<PredictedPath>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'probability))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_path))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_velocity))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PredictedPath>) istream)
  "Deserializes a message object of type '<PredictedPath>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'probability) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'predicted_path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'predicted_path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'predicted_velocity) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'predicted_velocity)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PredictedPath>)))
  "Returns string type for a message object of type '<PredictedPath>"
  "itri_msgs/PredictedPath")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PredictedPath)))
  "Returns string type for a message object of type 'PredictedPath"
  "itri_msgs/PredictedPath")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PredictedPath>)))
  "Returns md5sum for a message object of type '<PredictedPath>"
  "46863c23a206bf9673e0a4bf16fae636")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PredictedPath)))
  "Returns md5sum for a message object of type 'PredictedPath"
  "46863c23a206bf9673e0a4bf16fae636")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PredictedPath>)))
  "Returns full string definition for message of type '<PredictedPath>"
  (cl:format cl:nil "float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PredictedPath)))
  "Returns full string definition for message of type 'PredictedPath"
  (cl:format cl:nil "float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PredictedPath>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_velocity) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PredictedPath>))
  "Converts a ROS message object to a list"
  (cl:list 'PredictedPath
    (cl:cons ':probability (probability msg))
    (cl:cons ':predicted_path (predicted_path msg))
    (cl:cons ':predicted_velocity (predicted_velocity msg))
))
