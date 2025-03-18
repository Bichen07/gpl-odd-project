; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude TrafficSignObjects.msg.html

(cl:defclass <TrafficSignObjects> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (signs
    :reader signs
    :initarg :signs
    :type (cl:vector itri_msgs-msg:TrafficSignObject)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:TrafficSignObject :initial-element (cl:make-instance 'itri_msgs-msg:TrafficSignObject))))
)

(cl:defclass TrafficSignObjects (<TrafficSignObjects>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficSignObjects>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficSignObjects)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<TrafficSignObjects> is deprecated: use itri_msgs-msg:TrafficSignObjects instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficSignObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'signs-val :lambda-list '(m))
(cl:defmethod signs-val ((m <TrafficSignObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:signs-val is deprecated.  Use itri_msgs-msg:signs instead.")
  (signs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficSignObjects>) ostream)
  "Serializes a message object of type '<TrafficSignObjects>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'signs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'signs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficSignObjects>) istream)
  "Deserializes a message object of type '<TrafficSignObjects>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'signs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'signs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:TrafficSignObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficSignObjects>)))
  "Returns string type for a message object of type '<TrafficSignObjects>"
  "itri_msgs/TrafficSignObjects")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficSignObjects)))
  "Returns string type for a message object of type 'TrafficSignObjects"
  "itri_msgs/TrafficSignObjects")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficSignObjects>)))
  "Returns md5sum for a message object of type '<TrafficSignObjects>"
  "87034deff55157e68a423890ed562f90")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficSignObjects)))
  "Returns md5sum for a message object of type 'TrafficSignObjects"
  "87034deff55157e68a423890ed562f90")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficSignObjects>)))
  "Returns full string definition for message of type '<TrafficSignObjects>"
  (cl:format cl:nil "Header header~%TrafficSignObject[] signs~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/TrafficSignObject~%bool stop~%~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%string[] sign~%~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficSignObjects)))
  "Returns full string definition for message of type 'TrafficSignObjects"
  (cl:format cl:nil "Header header~%TrafficSignObject[] signs~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/TrafficSignObject~%bool stop~%~%sensor_msgs/RegionOfInterest roi~%float32 score~%~%int32 id~%float32 distance~%string[] sign~%~%================================================================================~%MSG: sensor_msgs/RegionOfInterest~%# This message is used to specify a region of interest within an image.~%#~%# When used to specify the ROI setting of the camera when the image was~%# taken, the height and width fields should either match the height and~%# width fields for the associated image; or height = width = 0~%# indicates that the full resolution image was captured.~%~%uint32 x_offset  # Leftmost pixel of the ROI~%                 # (0 if the ROI includes the left edge of the image)~%uint32 y_offset  # Topmost pixel of the ROI~%                 # (0 if the ROI includes the top edge of the image)~%uint32 height    # Height of ROI~%uint32 width     # Width of ROI~%~%# True if a distinct rectified ROI should be calculated from the \"raw\"~%# ROI in this message. Typically this should be False if the full image~%# is captured (ROI not used), and True if a subwindow is captured (ROI~%# used).~%bool do_rectify~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficSignObjects>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'signs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficSignObjects>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficSignObjects
    (cl:cons ':header (header msg))
    (cl:cons ':signs (signs msg))
))
