; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficLightPipeline.msg.html

(cl:defclass <TrafficLightPipeline> (roslisp-msg-protocol:ros-message)
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
   (tone_map_full_image
    :reader tone_map_full_image
    :initarg :tone_map_full_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (lights_full_image
    :reader lights_full_image
    :initarg :lights_full_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (light_status
    :reader light_status
    :initarg :light_status
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (light_rules
    :reader light_rules
    :initarg :light_rules
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
   (tone_map_roi_image
    :reader tone_map_roi_image
    :initarg :tone_map_roi_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (lights_roi_image
    :reader lights_roi_image
    :initarg :lights_roi_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (traffic_light_map_points
    :reader traffic_light_map_points
    :initarg :traffic_light_map_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (traffic_light_points
    :reader traffic_light_points
    :initarg :traffic_light_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (traffic_light_roi
    :reader traffic_light_roi
    :initarg :traffic_light_roi
    :type sensor_msgs-msg:RegionOfInterest
    :initform (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
   (all_traffic_light_points
    :reader all_traffic_light_points
    :initarg :all_traffic_light_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (all_traffic_light_roi
    :reader all_traffic_light_roi
    :initarg :all_traffic_light_roi
    :type (cl:vector sensor_msgs-msg:RegionOfInterest)
   :initform (cl:make-array 0 :element-type 'sensor_msgs-msg:RegionOfInterest :initial-element (cl:make-instance 'sensor_msgs-msg:RegionOfInterest)))
   (tone_map_detect_light_box
    :reader tone_map_detect_light_box
    :initarg :tone_map_detect_light_box
    :type itri_msgs-msg:ImageObj
    :initform (cl:make-instance 'itri_msgs-msg:ImageObj))
   (tone_map_detect_light_status
    :reader tone_map_detect_light_status
    :initarg :tone_map_detect_light_status
    :type itri_msgs-msg:ImageObj
    :initform (cl:make-instance 'itri_msgs-msg:ImageObj))
   (lights_detect_light_status
    :reader lights_detect_light_status
    :initarg :lights_detect_light_status
    :type itri_msgs-msg:ImageObj
    :initform (cl:make-instance 'itri_msgs-msg:ImageObj))
   (merged_result_light_box
    :reader merged_result_light_box
    :initarg :merged_result_light_box
    :type cl:boolean
    :initform cl:nil)
   (merged_result_red
    :reader merged_result_red
    :initarg :merged_result_red
    :type cl:boolean
    :initform cl:nil)
   (merged_result_yellow
    :reader merged_result_yellow
    :initarg :merged_result_yellow
    :type cl:boolean
    :initform cl:nil)
   (merged_result_green
    :reader merged_result_green
    :initarg :merged_result_green
    :type cl:boolean
    :initform cl:nil)
   (merged_result_left
    :reader merged_result_left
    :initarg :merged_result_left
    :type cl:boolean
    :initform cl:nil)
   (merged_result_straight
    :reader merged_result_straight
    :initarg :merged_result_straight
    :type cl:boolean
    :initform cl:nil)
   (merged_result_right
    :reader merged_result_right
    :initarg :merged_result_right
    :type cl:boolean
    :initform cl:nil)
   (red
    :reader red
    :initarg :red
    :type cl:boolean
    :initform cl:nil)
   (yellow
    :reader yellow
    :initarg :yellow
    :type cl:boolean
    :initform cl:nil)
   (green
    :reader green
    :initarg :green
    :type cl:boolean
    :initform cl:nil)
   (left
    :reader left
    :initarg :left
    :type cl:boolean
    :initform cl:nil)
   (straight
    :reader straight
    :initarg :straight
    :type cl:boolean
    :initform cl:nil)
   (right
    :reader right
    :initarg :right
    :type cl:boolean
    :initform cl:nil)
   (flashred
    :reader flashred
    :initarg :flashred
    :type cl:boolean
    :initform cl:nil)
   (flashyellow
    :reader flashyellow
    :initarg :flashyellow
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TrafficLightPipeline (<TrafficLightPipeline>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightPipeline>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightPipeline)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficLightPipeline> is deprecated: use itri_msgs-msg:TrafficLightPipeline instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'image_topic-val :lambda-list '(m))
(cl:defmethod image_topic-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:image_topic-val is deprecated.  Use itri_msgs-msg:image_topic instead.")
  (image_topic m))

(cl:ensure-generic-function 'tone_map_full_image-val :lambda-list '(m))
(cl:defmethod tone_map_full_image-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:tone_map_full_image-val is deprecated.  Use itri_msgs-msg:tone_map_full_image instead.")
  (tone_map_full_image m))

(cl:ensure-generic-function 'lights_full_image-val :lambda-list '(m))
(cl:defmethod lights_full_image-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lights_full_image-val is deprecated.  Use itri_msgs-msg:lights_full_image instead.")
  (lights_full_image m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'light_status-val :lambda-list '(m))
(cl:defmethod light_status-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:light_status-val is deprecated.  Use itri_msgs-msg:light_status instead.")
  (light_status m))

(cl:ensure-generic-function 'light_rules-val :lambda-list '(m))
(cl:defmethod light_rules-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:light_rules-val is deprecated.  Use itri_msgs-msg:light_rules instead.")
  (light_rules m))

(cl:ensure-generic-function 'x_enlarge_factor-val :lambda-list '(m))
(cl:defmethod x_enlarge_factor-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:x_enlarge_factor-val is deprecated.  Use itri_msgs-msg:x_enlarge_factor instead.")
  (x_enlarge_factor m))

(cl:ensure-generic-function 'y_enlarge_factor-val :lambda-list '(m))
(cl:defmethod y_enlarge_factor-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:y_enlarge_factor-val is deprecated.  Use itri_msgs-msg:y_enlarge_factor instead.")
  (y_enlarge_factor m))

(cl:ensure-generic-function 'x_offset_factor-val :lambda-list '(m))
(cl:defmethod x_offset_factor-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:x_offset_factor-val is deprecated.  Use itri_msgs-msg:x_offset_factor instead.")
  (x_offset_factor m))

(cl:ensure-generic-function 'y_offset_factor-val :lambda-list '(m))
(cl:defmethod y_offset_factor-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:y_offset_factor-val is deprecated.  Use itri_msgs-msg:y_offset_factor instead.")
  (y_offset_factor m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:distance-val is deprecated.  Use itri_msgs-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'tone_map_roi_image-val :lambda-list '(m))
(cl:defmethod tone_map_roi_image-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:tone_map_roi_image-val is deprecated.  Use itri_msgs-msg:tone_map_roi_image instead.")
  (tone_map_roi_image m))

(cl:ensure-generic-function 'lights_roi_image-val :lambda-list '(m))
(cl:defmethod lights_roi_image-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lights_roi_image-val is deprecated.  Use itri_msgs-msg:lights_roi_image instead.")
  (lights_roi_image m))

(cl:ensure-generic-function 'traffic_light_map_points-val :lambda-list '(m))
(cl:defmethod traffic_light_map_points-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_light_map_points-val is deprecated.  Use itri_msgs-msg:traffic_light_map_points instead.")
  (traffic_light_map_points m))

(cl:ensure-generic-function 'traffic_light_points-val :lambda-list '(m))
(cl:defmethod traffic_light_points-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_light_points-val is deprecated.  Use itri_msgs-msg:traffic_light_points instead.")
  (traffic_light_points m))

(cl:ensure-generic-function 'traffic_light_roi-val :lambda-list '(m))
(cl:defmethod traffic_light_roi-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_light_roi-val is deprecated.  Use itri_msgs-msg:traffic_light_roi instead.")
  (traffic_light_roi m))

(cl:ensure-generic-function 'all_traffic_light_points-val :lambda-list '(m))
(cl:defmethod all_traffic_light_points-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:all_traffic_light_points-val is deprecated.  Use itri_msgs-msg:all_traffic_light_points instead.")
  (all_traffic_light_points m))

(cl:ensure-generic-function 'all_traffic_light_roi-val :lambda-list '(m))
(cl:defmethod all_traffic_light_roi-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:all_traffic_light_roi-val is deprecated.  Use itri_msgs-msg:all_traffic_light_roi instead.")
  (all_traffic_light_roi m))

(cl:ensure-generic-function 'tone_map_detect_light_box-val :lambda-list '(m))
(cl:defmethod tone_map_detect_light_box-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:tone_map_detect_light_box-val is deprecated.  Use itri_msgs-msg:tone_map_detect_light_box instead.")
  (tone_map_detect_light_box m))

(cl:ensure-generic-function 'tone_map_detect_light_status-val :lambda-list '(m))
(cl:defmethod tone_map_detect_light_status-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:tone_map_detect_light_status-val is deprecated.  Use itri_msgs-msg:tone_map_detect_light_status instead.")
  (tone_map_detect_light_status m))

(cl:ensure-generic-function 'lights_detect_light_status-val :lambda-list '(m))
(cl:defmethod lights_detect_light_status-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lights_detect_light_status-val is deprecated.  Use itri_msgs-msg:lights_detect_light_status instead.")
  (lights_detect_light_status m))

(cl:ensure-generic-function 'merged_result_light_box-val :lambda-list '(m))
(cl:defmethod merged_result_light_box-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_light_box-val is deprecated.  Use itri_msgs-msg:merged_result_light_box instead.")
  (merged_result_light_box m))

(cl:ensure-generic-function 'merged_result_red-val :lambda-list '(m))
(cl:defmethod merged_result_red-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_red-val is deprecated.  Use itri_msgs-msg:merged_result_red instead.")
  (merged_result_red m))

(cl:ensure-generic-function 'merged_result_yellow-val :lambda-list '(m))
(cl:defmethod merged_result_yellow-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_yellow-val is deprecated.  Use itri_msgs-msg:merged_result_yellow instead.")
  (merged_result_yellow m))

(cl:ensure-generic-function 'merged_result_green-val :lambda-list '(m))
(cl:defmethod merged_result_green-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_green-val is deprecated.  Use itri_msgs-msg:merged_result_green instead.")
  (merged_result_green m))

(cl:ensure-generic-function 'merged_result_left-val :lambda-list '(m))
(cl:defmethod merged_result_left-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_left-val is deprecated.  Use itri_msgs-msg:merged_result_left instead.")
  (merged_result_left m))

(cl:ensure-generic-function 'merged_result_straight-val :lambda-list '(m))
(cl:defmethod merged_result_straight-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_straight-val is deprecated.  Use itri_msgs-msg:merged_result_straight instead.")
  (merged_result_straight m))

(cl:ensure-generic-function 'merged_result_right-val :lambda-list '(m))
(cl:defmethod merged_result_right-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:merged_result_right-val is deprecated.  Use itri_msgs-msg:merged_result_right instead.")
  (merged_result_right m))

(cl:ensure-generic-function 'red-val :lambda-list '(m))
(cl:defmethod red-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:red-val is deprecated.  Use itri_msgs-msg:red instead.")
  (red m))

(cl:ensure-generic-function 'yellow-val :lambda-list '(m))
(cl:defmethod yellow-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:yellow-val is deprecated.  Use itri_msgs-msg:yellow instead.")
  (yellow m))

(cl:ensure-generic-function 'green-val :lambda-list '(m))
(cl:defmethod green-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:green-val is deprecated.  Use itri_msgs-msg:green instead.")
  (green m))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left-val is deprecated.  Use itri_msgs-msg:left instead.")
  (left m))

(cl:ensure-generic-function 'straight-val :lambda-list '(m))
(cl:defmethod straight-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:straight-val is deprecated.  Use itri_msgs-msg:straight instead.")
  (straight m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right-val is deprecated.  Use itri_msgs-msg:right instead.")
  (right m))

(cl:ensure-generic-function 'flashred-val :lambda-list '(m))
(cl:defmethod flashred-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:flashred-val is deprecated.  Use itri_msgs-msg:flashred instead.")
  (flashred m))

(cl:ensure-generic-function 'flashyellow-val :lambda-list '(m))
(cl:defmethod flashyellow-val ((m <TrafficLightPipeline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:flashyellow-val is deprecated.  Use itri_msgs-msg:flashyellow instead.")
  (flashyellow m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightPipeline>) ostream)
  "Serializes a message object of type '<TrafficLightPipeline>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'image_topic))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'image_topic))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tone_map_full_image) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lights_full_image) ostream)
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'light_status))))
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
   (cl:slot-value msg 'light_status))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'light_rules))))
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
   (cl:slot-value msg 'light_rules))
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
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tone_map_roi_image) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lights_roi_image) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_light_map_points) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_light_points) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_light_roi) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'all_traffic_light_points) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'all_traffic_light_roi))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'all_traffic_light_roi))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tone_map_detect_light_box) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tone_map_detect_light_status) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lights_detect_light_status) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_light_box) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_red) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_yellow) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_green) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_left) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_straight) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'merged_result_right) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'red) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'yellow) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'green) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'left) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'straight) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'right) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'flashred) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'flashyellow) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightPipeline>) istream)
  "Deserializes a message object of type '<TrafficLightPipeline>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'image_topic) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'image_topic) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tone_map_full_image) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lights_full_image) istream)
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
  (cl:setf (cl:slot-value msg 'light_status) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'light_status)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'light_rules) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'light_rules)))
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tone_map_roi_image) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lights_roi_image) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_light_map_points) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_light_points) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_light_roi) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'all_traffic_light_points) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'all_traffic_light_roi) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'all_traffic_light_roi)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tone_map_detect_light_box) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tone_map_detect_light_status) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lights_detect_light_status) istream)
    (cl:setf (cl:slot-value msg 'merged_result_light_box) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_red) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_yellow) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_green) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_left) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_straight) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'merged_result_right) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'red) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'yellow) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'green) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'left) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'straight) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'right) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'flashred) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'flashyellow) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightPipeline>)))
  "Returns string type for a message object of type '<TrafficLightPipeline>"
  "itri_msgs/TrafficLightPipeline")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightPipeline)))
  "Returns string type for a message object of type 'TrafficLightPipeline"
  "itri_msgs/TrafficLightPipeline")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightPipeline>)))
  "Returns md5sum for a message object of type '<TrafficLightPipeline>"
  "9f2248593a306be31f383e3661e2dc25")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightPipeline)))
  "Returns md5sum for a message object of type 'TrafficLightPipeline"
  "9f2248593a306be31f383e3661e2dc25")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightPipeline>)))
  "Returns full string definition for message of type '<TrafficLightPipeline>"
  (cl:format cl:nil "Header header~%~%# image info~%string image_topic~%sensor_msgs/Image tone_map_full_image~%sensor_msgs/Image lights_full_image~%~%# semantic map info~%int32 id~%string[] light_status~%string[] light_rules~%~%float32 x_enlarge_factor~%float32 y_enlarge_factor~%float32 x_offset_factor~%float32 y_offset_factor~%~%# traffic_light_projection info~%int32 distance~%sensor_msgs/Image tone_map_roi_image~%sensor_msgs/Image lights_roi_image~%geometry_msgs/Polygon traffic_light_map_points~%~%geometry_msgs/Polygon traffic_light_points~%sensor_msgs/RegionOfInterest traffic_light_roi~%geometry_msgs/Polygon all_traffic_light_points~%sensor_msgs/RegionOfInterest[] all_traffic_light_roi~%~%# traffic_light_detection info~%itri_msgs/ImageObj tone_map_detect_light_box~%itri_msgs/ImageObj tone_map_detect_light_status~%itri_msgs/ImageObj lights_detect_light_status~%~%# traffic_light_merge info~%bool merged_result_light_box~%bool merged_result_red~%bool merged_result_yellow~%bool merged_result_green~%bool merged_result_left~%bool merged_result_straight~%bool merged_result_right~%~%# traffic_light_queue info~%bool red~%bool yellow~%bool green~%bool left~%bool straight~%bool right~%bool flashred~%bool flashyellow~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%================================================================================~%MSG: itri_msgs/ImageObj~%Header header~%string type~%ImageRect[] obj~%# XXX Should this message have 'score' ?~%~%================================================================================~%MSG: itri_msgs/ImageRect~%int32 id~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%string cls~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightPipeline)))
  "Returns full string definition for message of type 'TrafficLightPipeline"
  (cl:format cl:nil "Header header~%~%# image info~%string image_topic~%sensor_msgs/Image tone_map_full_image~%sensor_msgs/Image lights_full_image~%~%# semantic map info~%int32 id~%string[] light_status~%string[] light_rules~%~%float32 x_enlarge_factor~%float32 y_enlarge_factor~%float32 x_offset_factor~%float32 y_offset_factor~%~%# traffic_light_projection info~%int32 distance~%sensor_msgs/Image tone_map_roi_image~%sensor_msgs/Image lights_roi_image~%geometry_msgs/Polygon traffic_light_map_points~%~%geometry_msgs/Polygon traffic_light_points~%sensor_msgs/RegionOfInterest traffic_light_roi~%geometry_msgs/Polygon all_traffic_light_points~%sensor_msgs/RegionOfInterest[] all_traffic_light_roi~%~%# traffic_light_detection info~%itri_msgs/ImageObj tone_map_detect_light_box~%itri_msgs/ImageObj tone_map_detect_light_status~%itri_msgs/ImageObj lights_detect_light_status~%~%# traffic_light_merge info~%bool merged_result_light_box~%bool merged_result_red~%bool merged_result_yellow~%bool merged_result_green~%bool merged_result_left~%bool merged_result_straight~%bool merged_result_right~%~%# traffic_light_queue info~%bool red~%bool yellow~%bool green~%bool left~%bool straight~%bool right~%bool flashred~%bool flashyellow~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%================================================================================~%MSG: itri_msgs/ImageObj~%Header header~%string type~%ImageRect[] obj~%# XXX Should this message have 'score' ?~%~%================================================================================~%MSG: itri_msgs/ImageRect~%int32 id~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%string cls~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightPipeline>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'image_topic))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tone_map_full_image))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lights_full_image))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'light_status) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'light_rules) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tone_map_roi_image))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lights_roi_image))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_light_map_points))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_light_points))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_light_roi))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'all_traffic_light_points))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'all_traffic_light_roi) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tone_map_detect_light_box))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tone_map_detect_light_status))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lights_detect_light_status))
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightPipeline>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightPipeline
    (cl:cons ':header (header msg))
    (cl:cons ':image_topic (image_topic msg))
    (cl:cons ':tone_map_full_image (tone_map_full_image msg))
    (cl:cons ':lights_full_image (lights_full_image msg))
    (cl:cons ':id (id msg))
    (cl:cons ':light_status (light_status msg))
    (cl:cons ':light_rules (light_rules msg))
    (cl:cons ':x_enlarge_factor (x_enlarge_factor msg))
    (cl:cons ':y_enlarge_factor (y_enlarge_factor msg))
    (cl:cons ':x_offset_factor (x_offset_factor msg))
    (cl:cons ':y_offset_factor (y_offset_factor msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':tone_map_roi_image (tone_map_roi_image msg))
    (cl:cons ':lights_roi_image (lights_roi_image msg))
    (cl:cons ':traffic_light_map_points (traffic_light_map_points msg))
    (cl:cons ':traffic_light_points (traffic_light_points msg))
    (cl:cons ':traffic_light_roi (traffic_light_roi msg))
    (cl:cons ':all_traffic_light_points (all_traffic_light_points msg))
    (cl:cons ':all_traffic_light_roi (all_traffic_light_roi msg))
    (cl:cons ':tone_map_detect_light_box (tone_map_detect_light_box msg))
    (cl:cons ':tone_map_detect_light_status (tone_map_detect_light_status msg))
    (cl:cons ':lights_detect_light_status (lights_detect_light_status msg))
    (cl:cons ':merged_result_light_box (merged_result_light_box msg))
    (cl:cons ':merged_result_red (merged_result_red msg))
    (cl:cons ':merged_result_yellow (merged_result_yellow msg))
    (cl:cons ':merged_result_green (merged_result_green msg))
    (cl:cons ':merged_result_left (merged_result_left msg))
    (cl:cons ':merged_result_straight (merged_result_straight msg))
    (cl:cons ':merged_result_right (merged_result_right msg))
    (cl:cons ':red (red msg))
    (cl:cons ':yellow (yellow msg))
    (cl:cons ':green (green msg))
    (cl:cons ':left (left msg))
    (cl:cons ':straight (straight msg))
    (cl:cons ':right (right msg))
    (cl:cons ':flashred (flashred msg))
    (cl:cons ':flashyellow (flashyellow msg))
))
