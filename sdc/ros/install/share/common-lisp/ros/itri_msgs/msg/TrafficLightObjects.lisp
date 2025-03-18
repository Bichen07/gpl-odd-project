; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficLightObjects.msg.html

(cl:defclass <TrafficLightObjects> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lights
    :reader lights
    :initarg :lights
    :type (cl:vector itri_msgs-msg:TrafficLightObject)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:TrafficLightObject :initial-element (cl:make-instance 'itri_msgs-msg:TrafficLightObject))))
)

(cl:defclass TrafficLightObjects (<TrafficLightObjects>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightObjects>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightObjects)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficLightObjects> is deprecated: use itri_msgs-msg:TrafficLightObjects instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficLightObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lights-val :lambda-list '(m))
(cl:defmethod lights-val ((m <TrafficLightObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lights-val is deprecated.  Use itri_msgs-msg:lights instead.")
  (lights m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightObjects>) ostream)
  "Serializes a message object of type '<TrafficLightObjects>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lights))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lights))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightObjects>) istream)
  "Deserializes a message object of type '<TrafficLightObjects>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lights) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lights)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:TrafficLightObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightObjects>)))
  "Returns string type for a message object of type '<TrafficLightObjects>"
  "itri_msgs/TrafficLightObjects")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightObjects)))
  "Returns string type for a message object of type 'TrafficLightObjects"
  "itri_msgs/TrafficLightObjects")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightObjects>)))
  "Returns md5sum for a message object of type '<TrafficLightObjects>"
  "fe2c5dabf2fe93f365342371c20e525d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightObjects)))
  "Returns md5sum for a message object of type 'TrafficLightObjects"
  "fe2c5dabf2fe93f365342371c20e525d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightObjects>)))
  "Returns full string definition for message of type '<TrafficLightObjects>"
  (cl:format cl:nil "Header header~%TrafficLightObject[] lights~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/TrafficLightObject~%bool dontCare~%bool green~%bool left~%bool red~%bool right~%bool straight~%bool yellow~%bool flashyellow~%bool flashred~%~%bool blocked~%geometry_msgs/Polygon traffic_light_map_points~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%float32 remain_sec~%string[] lights~%sensor_msgs/RegionOfInterest[] lightsroi~%~%uint8 DETECTOR=0~%uint8 RSU=1~%uint8 source~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightObjects)))
  "Returns full string definition for message of type 'TrafficLightObjects"
  (cl:format cl:nil "Header header~%TrafficLightObject[] lights~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/TrafficLightObject~%bool dontCare~%bool green~%bool left~%bool red~%bool right~%bool straight~%bool yellow~%bool flashyellow~%bool flashred~%~%bool blocked~%geometry_msgs/Polygon traffic_light_map_points~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%float32 remain_sec~%string[] lights~%sensor_msgs/RegionOfInterest[] lightsroi~%~%uint8 DETECTOR=0~%uint8 RSU=1~%uint8 source~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightObjects>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lights) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightObjects>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightObjects
    (cl:cons ':header (header msg))
    (cl:cons ':lights (lights msg))
))
