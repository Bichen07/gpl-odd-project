; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficLightObject.msg.html

(cl:defclass <TrafficLightObject> (roslisp-msg-protocol:ros-message)
  ((dontCare
    :reader dontCare
    :initarg :dontCare
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
   (red
    :reader red
    :initarg :red
    :type cl:boolean
    :initform cl:nil)
   (right
    :reader right
    :initarg :right
    :type cl:boolean
    :initform cl:nil)
   (straight
    :reader straight
    :initarg :straight
    :type cl:boolean
    :initform cl:nil)
   (yellow
    :reader yellow
    :initarg :yellow
    :type cl:boolean
    :initform cl:nil)
   (flashyellow
    :reader flashyellow
    :initarg :flashyellow
    :type cl:boolean
    :initform cl:nil)
   (flashred
    :reader flashred
    :initarg :flashred
    :type cl:boolean
    :initform cl:nil)
   (blocked
    :reader blocked
    :initarg :blocked
    :type cl:boolean
    :initform cl:nil)
   (traffic_light_map_points
    :reader traffic_light_map_points
    :initarg :traffic_light_map_points
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (roi
    :reader roi
    :initarg :roi
    :type sensor_msgs-msg:RegionOfInterest
    :initform (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (remain_sec
    :reader remain_sec
    :initarg :remain_sec
    :type cl:float
    :initform 0.0)
   (lights
    :reader lights
    :initarg :lights
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (lightsroi
    :reader lightsroi
    :initarg :lightsroi
    :type (cl:vector sensor_msgs-msg:RegionOfInterest)
   :initform (cl:make-array 0 :element-type 'sensor_msgs-msg:RegionOfInterest :initial-element (cl:make-instance 'sensor_msgs-msg:RegionOfInterest)))
   (source
    :reader source
    :initarg :source
    :type cl:fixnum
    :initform 0))
)

(cl:defclass TrafficLightObject (<TrafficLightObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficLightObject> is deprecated: use itri_msgs-msg:TrafficLightObject instead.")))

(cl:ensure-generic-function 'dontCare-val :lambda-list '(m))
(cl:defmethod dontCare-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:dontCare-val is deprecated.  Use itri_msgs-msg:dontCare instead.")
  (dontCare m))

(cl:ensure-generic-function 'green-val :lambda-list '(m))
(cl:defmethod green-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:green-val is deprecated.  Use itri_msgs-msg:green instead.")
  (green m))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left-val is deprecated.  Use itri_msgs-msg:left instead.")
  (left m))

(cl:ensure-generic-function 'red-val :lambda-list '(m))
(cl:defmethod red-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:red-val is deprecated.  Use itri_msgs-msg:red instead.")
  (red m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right-val is deprecated.  Use itri_msgs-msg:right instead.")
  (right m))

(cl:ensure-generic-function 'straight-val :lambda-list '(m))
(cl:defmethod straight-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:straight-val is deprecated.  Use itri_msgs-msg:straight instead.")
  (straight m))

(cl:ensure-generic-function 'yellow-val :lambda-list '(m))
(cl:defmethod yellow-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:yellow-val is deprecated.  Use itri_msgs-msg:yellow instead.")
  (yellow m))

(cl:ensure-generic-function 'flashyellow-val :lambda-list '(m))
(cl:defmethod flashyellow-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:flashyellow-val is deprecated.  Use itri_msgs-msg:flashyellow instead.")
  (flashyellow m))

(cl:ensure-generic-function 'flashred-val :lambda-list '(m))
(cl:defmethod flashred-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:flashred-val is deprecated.  Use itri_msgs-msg:flashred instead.")
  (flashred m))

(cl:ensure-generic-function 'blocked-val :lambda-list '(m))
(cl:defmethod blocked-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:blocked-val is deprecated.  Use itri_msgs-msg:blocked instead.")
  (blocked m))

(cl:ensure-generic-function 'traffic_light_map_points-val :lambda-list '(m))
(cl:defmethod traffic_light_map_points-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:traffic_light_map_points-val is deprecated.  Use itri_msgs-msg:traffic_light_map_points instead.")
  (traffic_light_map_points m))

(cl:ensure-generic-function 'roi-val :lambda-list '(m))
(cl:defmethod roi-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:roi-val is deprecated.  Use itri_msgs-msg:roi instead.")
  (roi m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:score-val is deprecated.  Use itri_msgs-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:distance-val is deprecated.  Use itri_msgs-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'remain_sec-val :lambda-list '(m))
(cl:defmethod remain_sec-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:remain_sec-val is deprecated.  Use itri_msgs-msg:remain_sec instead.")
  (remain_sec m))

(cl:ensure-generic-function 'lights-val :lambda-list '(m))
(cl:defmethod lights-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lights-val is deprecated.  Use itri_msgs-msg:lights instead.")
  (lights m))

(cl:ensure-generic-function 'lightsroi-val :lambda-list '(m))
(cl:defmethod lightsroi-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lightsroi-val is deprecated.  Use itri_msgs-msg:lightsroi instead.")
  (lightsroi m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <TrafficLightObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:source-val is deprecated.  Use itri_msgs-msg:source instead.")
  (source m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TrafficLightObject>)))
    "Constants for message type '<TrafficLightObject>"
  '((:DETECTOR . 0)
    (:RSU . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TrafficLightObject)))
    "Constants for message type 'TrafficLightObject"
  '((:DETECTOR . 0)
    (:RSU . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightObject>) ostream)
  "Serializes a message object of type '<TrafficLightObject>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'dontCare) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'green) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'left) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'red) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'right) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'straight) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'yellow) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'flashyellow) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'flashred) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'blocked) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'traffic_light_map_points) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'roi) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'remain_sec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lights))))
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
   (cl:slot-value msg 'lights))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lightsroi))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lightsroi))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightObject>) istream)
  "Deserializes a message object of type '<TrafficLightObject>"
    (cl:setf (cl:slot-value msg 'dontCare) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'green) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'left) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'red) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'right) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'straight) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'yellow) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'flashyellow) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'flashred) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'blocked) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'traffic_light_map_points) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'roi) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'remain_sec) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lights) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lights)))
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
  (cl:setf (cl:slot-value msg 'lightsroi) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lightsroi)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'sensor_msgs-msg:RegionOfInterest))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightObject>)))
  "Returns string type for a message object of type '<TrafficLightObject>"
  "itri_msgs/TrafficLightObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightObject)))
  "Returns string type for a message object of type 'TrafficLightObject"
  "itri_msgs/TrafficLightObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightObject>)))
  "Returns md5sum for a message object of type '<TrafficLightObject>"
  "f24c9677aaa490b50d0084132ed5fd5e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightObject)))
  "Returns md5sum for a message object of type 'TrafficLightObject"
  "f24c9677aaa490b50d0084132ed5fd5e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightObject>)))
  "Returns full string definition for message of type '<TrafficLightObject>"
  (cl:format cl:nil "bool dontCare~%bool green~%bool left~%bool red~%bool right~%bool straight~%bool yellow~%bool flashyellow~%bool flashred~%~%bool blocked~%geometry_msgs/Polygon traffic_light_map_points~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%float32 remain_sec~%string[] lights~%sensor_msgs/RegionOfInterest[] lightsroi~%~%uint8 DETECTOR=0~%uint8 RSU=1~%uint8 source~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightObject)))
  "Returns full string definition for message of type 'TrafficLightObject"
  (cl:format cl:nil "bool dontCare~%bool green~%bool left~%bool red~%bool right~%bool straight~%bool yellow~%bool flashyellow~%bool flashred~%~%bool blocked~%geometry_msgs/Polygon traffic_light_map_points~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%float32 remain_sec~%string[] lights~%sensor_msgs/RegionOfInterest[] lightsroi~%~%uint8 DETECTOR=0~%uint8 RSU=1~%uint8 source~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightObject>))
  (cl:+ 0
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
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'traffic_light_map_points))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'roi))
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lights) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lightsroi) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightObject>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightObject
    (cl:cons ':dontCare (dontCare msg))
    (cl:cons ':green (green msg))
    (cl:cons ':left (left msg))
    (cl:cons ':red (red msg))
    (cl:cons ':right (right msg))
    (cl:cons ':straight (straight msg))
    (cl:cons ':yellow (yellow msg))
    (cl:cons ':flashyellow (flashyellow msg))
    (cl:cons ':flashred (flashred msg))
    (cl:cons ':blocked (blocked msg))
    (cl:cons ':traffic_light_map_points (traffic_light_map_points msg))
    (cl:cons ':roi (roi msg))
    (cl:cons ':score (score msg))
    (cl:cons ':id (id msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':remain_sec (remain_sec msg))
    (cl:cons ':lights (lights msg))
    (cl:cons ':lightsroi (lightsroi msg))
    (cl:cons ':source (source msg))
))
