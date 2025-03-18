; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficSignPipeline.msg.html

(cl:defclass <TrafficSignPipeline> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (image_topic
    :reader image_topic
    :initarg :image_topic
    :type cl:string
    :initform "")
   (full_image
    :reader full_image
    :initarg :full_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (sign
    :reader sign
    :initarg :sign
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (x_enlarge_factor
    :reader x_enlarge_factor
    :initarg :x_enlarge_factor
    :type cl:float
    :initform 0.0)
   (y_enlarge_factor
    :reader y_enlarge_factor
    :initarg :y_enlarge_factor
    :type cl:float
    :initform 0.0)
   (x_offset_factor
    :reader x_offset_factor
    :initarg :x_offset_factor
    :type cl:float
    :initform 0.0)
   (y_offset_factor
    :reader y_offset_factor
    :initarg :y_offset_factor
    :type cl:float
    :initform 0.0)
   (distance
    :reader distance
    :initarg :distance
    :type cl:integer
    :initform 0)
   (roi_image
    :reader roi_image
    :initarg :roi_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (tone_map_roi_image
    :reader tone_map_roi_image
    :initarg :tone_map_roi_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (traffic_sign_map_points
    :reader traffic_sign_map_points
    :initarg :traffic_sign_map_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (traffic_sign_points
    :reader traffic_sign_points
    :initarg :traffic_sign_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (traffic_sign_roi
    :reader traffic_sign_roi
    :initarg :traffic_sign_roi
    :type sensor_msgs-msg:RegionOfInterest
    :initform (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
   (all_traffic_sign_points
    :reader all_traffic_sign_points
    :initarg :all_traffic_sign_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (all_traffic_sign_roi
    :reader all_traffic_sign_roi
    :initarg :all_traffic_sign_roi
    :type (cl:vector sensor_msgs-msg:RegionOfInterest)
   :initform (cl:make-array 0 :element-type 'sensor_msgs-msg:RegionOfInterest :initial-element (cl:make-instance 'sensor_msgs-msg:RegionOfInterest)))
   (sign_box
    :reader sign_box
    :initarg :sign_box
    :type itri_msgs-msg:ImageObj
    :initform (cl:make-instance 'itri_msgs-msg:ImageObj))
   (has_sign
    :reader has_sign
    :initarg :has_sign
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TrafficSignPipeline (<TrafficSignPipeline>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficSignPipeline>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficSignPipeline)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficSignPipeline> is deprecated: use itri_msgs-msg:TrafficSignPipeline instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'image_topic-val :lambda-list '(m))
(cl:defmethod image_topic-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:image_topic-val is deprecated.  Use itri_msgs-msg:image_topic instead.")
  (image_topic m))

(cl:ensure-generic-function 'full_image-val :lambda-list '(m))
(cl:defmethod full_image-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:full_image-val is deprecated.  Use itri_msgs-msg:full_image instead.")
  (full_image m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'sign-val :lambda-list '(m))
(cl:defmethod sign-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:sign-val is deprecated.  Use itri_msgs-msg:sign instead.")
  (sign m))

(cl:ensure-generic-function 'x_enlarge_factor-val :lambda-list '(m))
(cl:defmethod x_enlarge_factor-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:x_enlarge_factor-val is deprecated.  Use itri_msgs-msg:x_enlarge_factor instead.")
  (x_enlarge_factor m))

(cl:ensure-generic-function 'y_enlarge_factor-val :lambda-list '(m))
(cl:defmethod y_enlarge_factor-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:y_enlarge_factor-val is deprecated.  Use itri_msgs-msg:y_enlarge_factor instead.")
  (y_enlarge_factor m))

(cl:ensure-generic-function 'x_offset_factor-val :lambda-list '(m))
(cl:defmethod x_offset_factor-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:x_offset_factor-val is deprecated.  Use itri_msgs-msg:x_offset_factor instead.")
  (x_offset_factor m))

(cl:ensure-generic-function 'y_offset_factor-val :lambda-list '(m))
(cl:defmethod y_offset_factor-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:y_offset_factor-val is deprecated.  Use itri_msgs-msg:y_offset_factor instead.")
  (y_offset_factor m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:distance-val is deprecated.  Use itri_msgs-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'roi_image-val :lambda-list '(m))
(cl:defmethod roi_image-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:roi_image-val is deprecated.  Use itri_msgs-msg:roi_image instead.")
  (roi_image m))

(cl:ensure-generic-function 'tone_map_roi_image-val :lambda-list '(m))
(cl:defmethod tone_map_roi_image-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:tone_map_roi_image-val is deprecated.  Use itri_msgs-msg:tone_map_roi_image instead.")
  (tone_map_roi_image m))

(cl:ensure-generic-function 'traffic_sign_map_points-val :lambda-list '(m))
(cl:defmethod traffic_sign_map_points-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_sign_map_points-val is deprecated.  Use itri_msgs-msg:traffic_sign_map_points instead.")
  (traffic_sign_map_points m))

(cl:ensure-generic-function 'traffic_sign_points-val :lambda-list '(m))
(cl:defmethod traffic_sign_points-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_sign_points-val is deprecated.  Use itri_msgs-msg:traffic_sign_points instead.")
  (traffic_sign_points m))

(cl:ensure-generic-function 'traffic_sign_roi-val :lambda-list '(m))
(cl:defmethod traffic_sign_roi-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_sign_roi-val is deprecated.  Use itri_msgs-msg:traffic_sign_roi instead.")
  (traffic_sign_roi m))

(cl:ensure-generic-function 'all_traffic_sign_points-val :lambda-list '(m))
(cl:defmethod all_traffic_sign_points-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:all_traffic_sign_points-val is deprecated.  Use itri_msgs-msg:all_traffic_sign_points instead.")
  (all_traffic_sign_points m))

(cl:ensure-generic-function 'all_traffic_sign_roi-val :lambda-list '(m))
(cl:defmethod all_traffic_sign_roi-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:all_traffic_sign_roi-val is deprecated.  Use itri_msgs-msg:all_traffic_sign_roi instead.")
  (all_traffic_sign_roi m))

(cl:ensure-generic-function 'sign_box-val :lambda-list '(m))
(cl:defmethod sign_box-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:sign_box-val is deprecated.  Use itri_msgs-msg:sign_box instead.")
  (sign_box m))

(cl:ensure-generic-function 'has_sign-val :lambda-list '(m))
(cl:defmethod has_sign-val ((m <TrafficSignPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:has_sign-val is deprecated.  Use itri_msgs-msg:has_sign instead.")
  (has_sign m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficSignPipeline>) ostream)
  "Serializes a message object of type '<TrafficSignPipeline>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'image_topic))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'image_topic))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'full_image) ostream)
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sign))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'sign))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_enlarge_factor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_enlarge_factor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_offset_factor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_offset_factor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'distance)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'roi_image) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tone_map_roi_image) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_sign_map_points) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_sign_points) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_sign_roi) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'all_traffic_sign_points) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'all_traffic_sign_roi))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'all_traffic_sign_roi))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'sign_box) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_sign) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficSignPipeline>) istream)
  "Deserializes a message object of type '<TrafficSignPipeline>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'image_topic) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'image_topic) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'full_image) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sign) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sign)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_enlarge_factor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_enlarge_factor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_offset_factor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_offset_factor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'distance) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'roi_image) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tone_map_roi_image) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_sign_map_points) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_sign_points) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_sign_roi) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'all_traffic_sign_points) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'all_traffic_sign_roi) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'all_traffic_sign_roi)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'sign_box) istream)
    (cl:setf (cl:slot-value msg 'has_sign) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficSignPipeline>)))
  "Returns string type for a message object of type '<TrafficSignPipeline>"
  "itri_msgs/TrafficSignPipeline")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficSignPipeline)))
  "Returns string type for a message object of type 'TrafficSignPipeline"
  "itri_msgs/TrafficSignPipeline")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficSignPipeline>)))
  "Returns md5sum for a message object of type '<TrafficSignPipeline>"
  "9d96c21a93fc96e16cde29646db6f0b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficSignPipeline)))
  "Returns md5sum for a message object of type 'TrafficSignPipeline"
  "9d96c21a93fc96e16cde29646db6f0b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficSignPipeline>)))
  "Returns full string definition for message of type '<TrafficSignPipeline>"
  (cl:format cl:nil "Header header~%~%# image info~%string image_topic~%sensor_msgs/Image full_image~%~%# semantic map info~%int32 id~%string[] sign~%~%float32 x_enlarge_factor~%float32 y_enlarge_factor~%float32 x_offset_factor~%float32 y_offset_factor~%~%# traffic_sign_projection info~%int32 distance~%sensor_msgs/Image roi_image~%sensor_msgs/Image tone_map_roi_image~%~%geometry_msgs/Polygon traffic_sign_map_points~%geometry_msgs/Polygon traffic_sign_points~%sensor_msgs/RegionOfInterest traffic_sign_roi~%~%geometry_msgs/Polygon all_traffic_sign_points~%sensor_msgs/RegionOfInterest[] all_traffic_sign_roi~%~%# traffic_sign_detection info~%itri_msgs/ImageObj sign_box~%~%# traffic_sign_status info~%bool has_sign~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%================================================================================~%MSG: itri_msgs/ImageObj~%Header header~%string type~%ImageRect[] obj~%# XXX Should this message have 'score' ?~%~%================================================================================~%MSG: itri_msgs/ImageRect~%int32 id~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%string cls~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficSignPipeline)))
  "Returns full string definition for message of type 'TrafficSignPipeline"
  (cl:format cl:nil "Header header~%~%# image info~%string image_topic~%sensor_msgs/Image full_image~%~%# semantic map info~%int32 id~%string[] sign~%~%float32 x_enlarge_factor~%float32 y_enlarge_factor~%float32 x_offset_factor~%float32 y_offset_factor~%~%# traffic_sign_projection info~%int32 distance~%sensor_msgs/Image roi_image~%sensor_msgs/Image tone_map_roi_image~%~%geometry_msgs/Polygon traffic_sign_map_points~%geometry_msgs/Polygon traffic_sign_points~%sensor_msgs/RegionOfInterest traffic_sign_roi~%~%geometry_msgs/Polygon all_traffic_sign_points~%sensor_msgs/RegionOfInterest[] all_traffic_sign_roi~%~%# traffic_sign_detection info~%itri_msgs/ImageObj sign_box~%~%# traffic_sign_status info~%bool has_sign~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%================================================================================~%MSG: itri_msgs/ImageObj~%Header header~%string type~%ImageRect[] obj~%# XXX Should this message have 'score' ?~%~%================================================================================~%MSG: itri_msgs/ImageRect~%int32 id~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%string cls~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficSignPipeline>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'image_topic))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'full_image))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sign) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'roi_image))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tone_map_roi_image))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_sign_map_points))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_sign_points))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_sign_roi))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'all_traffic_sign_points))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'all_traffic_sign_roi) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'sign_box))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficSignPipeline>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficSignPipeline
    (cl:cons ':header (header msg))
    (cl:cons ':image_topic (image_topic msg))
    (cl:cons ':full_image (full_image msg))
    (cl:cons ':id (id msg))
    (cl:cons ':sign (sign msg))
    (cl:cons ':x_enlarge_factor (x_enlarge_factor msg))
    (cl:cons ':y_enlarge_factor (y_enlarge_factor msg))
    (cl:cons ':x_offset_factor (x_offset_factor msg))
    (cl:cons ':y_offset_factor (y_offset_factor msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':roi_image (roi_image msg))
    (cl:cons ':tone_map_roi_image (tone_map_roi_image msg))
    (cl:cons ':traffic_sign_map_points (traffic_sign_map_points msg))
    (cl:cons ':traffic_sign_points (traffic_sign_points msg))
    (cl:cons ':traffic_sign_roi (traffic_sign_roi msg))
    (cl:cons ':all_traffic_sign_points (all_traffic_sign_points msg))
    (cl:cons ':all_traffic_sign_roi (all_traffic_sign_roi msg))
    (cl:cons ':sign_box (sign_box msg))
    (cl:cons ':has_sign (has_sign msg))
))
