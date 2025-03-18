;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficSignPipeline)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficSignPipeline (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICSIGNPIPELINE")
  (make-package "ITRI_MSGS::TRAFFICSIGNPIPELINE"))

(in-package "ROS")
;;//! \htmlinclude TrafficSignPipeline.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::TrafficSignPipeline
  :super ros::object
  :slots (_header _image_topic _full_image _id _sign _x_enlarge_factor _y_enlarge_factor _x_offset_factor _y_offset_factor _distance _roi_image _tone_map_roi_image _traffic_sign_map_points _traffic_sign_points _traffic_sign_roi _all_traffic_sign_points _all_traffic_sign_roi _sign_box _has_sign ))

(defmethod itri_msgs::TrafficSignPipeline
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:image_topic __image_topic) "")
    ((:full_image __full_image) (instance sensor_msgs::Image :init))
    ((:id __id) 0)
    ((:sign __sign) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:x_enlarge_factor __x_enlarge_factor) 0.0)
    ((:y_enlarge_factor __y_enlarge_factor) 0.0)
    ((:x_offset_factor __x_offset_factor) 0.0)
    ((:y_offset_factor __y_offset_factor) 0.0)
    ((:distance __distance) 0)
    ((:roi_image __roi_image) (instance sensor_msgs::Image :init))
    ((:tone_map_roi_image __tone_map_roi_image) (instance sensor_msgs::Image :init))
    ((:traffic_sign_map_points __traffic_sign_map_points) (instance geometry_msgs::Polygon :init))
    ((:traffic_sign_points __traffic_sign_points) (instance geometry_msgs::Polygon :init))
    ((:traffic_sign_roi __traffic_sign_roi) (instance sensor_msgs::RegionOfInterest :init))
    ((:all_traffic_sign_points __all_traffic_sign_points) (instance geometry_msgs::Polygon :init))
    ((:all_traffic_sign_roi __all_traffic_sign_roi) (let (r) (dotimes (i 0) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
    ((:sign_box __sign_box) (instance itri_msgs::ImageObj :init))
    ((:has_sign __has_sign) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _image_topic (string __image_topic))
   (setq _full_image __full_image)
   (setq _id (round __id))
   (setq _sign __sign)
   (setq _x_enlarge_factor (float __x_enlarge_factor))
   (setq _y_enlarge_factor (float __y_enlarge_factor))
   (setq _x_offset_factor (float __x_offset_factor))
   (setq _y_offset_factor (float __y_offset_factor))
   (setq _distance (round __distance))
   (setq _roi_image __roi_image)
   (setq _tone_map_roi_image __tone_map_roi_image)
   (setq _traffic_sign_map_points __traffic_sign_map_points)
   (setq _traffic_sign_points __traffic_sign_points)
   (setq _traffic_sign_roi __traffic_sign_roi)
   (setq _all_traffic_sign_points __all_traffic_sign_points)
   (setq _all_traffic_sign_roi __all_traffic_sign_roi)
   (setq _sign_box __sign_box)
   (setq _has_sign __has_sign)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:image_topic
   (&optional __image_topic)
   (if __image_topic (setq _image_topic __image_topic)) _image_topic)
  (:full_image
   (&rest __full_image)
   (if (keywordp (car __full_image))
       (send* _full_image __full_image)
     (progn
       (if __full_image (setq _full_image (car __full_image)))
       _full_image)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:sign
   (&optional __sign)
   (if __sign (setq _sign __sign)) _sign)
  (:x_enlarge_factor
   (&optional __x_enlarge_factor)
   (if __x_enlarge_factor (setq _x_enlarge_factor __x_enlarge_factor)) _x_enlarge_factor)
  (:y_enlarge_factor
   (&optional __y_enlarge_factor)
   (if __y_enlarge_factor (setq _y_enlarge_factor __y_enlarge_factor)) _y_enlarge_factor)
  (:x_offset_factor
   (&optional __x_offset_factor)
   (if __x_offset_factor (setq _x_offset_factor __x_offset_factor)) _x_offset_factor)
  (:y_offset_factor
   (&optional __y_offset_factor)
   (if __y_offset_factor (setq _y_offset_factor __y_offset_factor)) _y_offset_factor)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:roi_image
   (&rest __roi_image)
   (if (keywordp (car __roi_image))
       (send* _roi_image __roi_image)
     (progn
       (if __roi_image (setq _roi_image (car __roi_image)))
       _roi_image)))
  (:tone_map_roi_image
   (&rest __tone_map_roi_image)
   (if (keywordp (car __tone_map_roi_image))
       (send* _tone_map_roi_image __tone_map_roi_image)
     (progn
       (if __tone_map_roi_image (setq _tone_map_roi_image (car __tone_map_roi_image)))
       _tone_map_roi_image)))
  (:traffic_sign_map_points
   (&rest __traffic_sign_map_points)
   (if (keywordp (car __traffic_sign_map_points))
       (send* _traffic_sign_map_points __traffic_sign_map_points)
     (progn
       (if __traffic_sign_map_points (setq _traffic_sign_map_points (car __traffic_sign_map_points)))
       _traffic_sign_map_points)))
  (:traffic_sign_points
   (&rest __traffic_sign_points)
   (if (keywordp (car __traffic_sign_points))
       (send* _traffic_sign_points __traffic_sign_points)
     (progn
       (if __traffic_sign_points (setq _traffic_sign_points (car __traffic_sign_points)))
       _traffic_sign_points)))
  (:traffic_sign_roi
   (&rest __traffic_sign_roi)
   (if (keywordp (car __traffic_sign_roi))
       (send* _traffic_sign_roi __traffic_sign_roi)
     (progn
       (if __traffic_sign_roi (setq _traffic_sign_roi (car __traffic_sign_roi)))
       _traffic_sign_roi)))
  (:all_traffic_sign_points
   (&rest __all_traffic_sign_points)
   (if (keywordp (car __all_traffic_sign_points))
       (send* _all_traffic_sign_points __all_traffic_sign_points)
     (progn
       (if __all_traffic_sign_points (setq _all_traffic_sign_points (car __all_traffic_sign_points)))
       _all_traffic_sign_points)))
  (:all_traffic_sign_roi
   (&rest __all_traffic_sign_roi)
   (if (keywordp (car __all_traffic_sign_roi))
       (send* _all_traffic_sign_roi __all_traffic_sign_roi)
     (progn
       (if __all_traffic_sign_roi (setq _all_traffic_sign_roi (car __all_traffic_sign_roi)))
       _all_traffic_sign_roi)))
  (:sign_box
   (&rest __sign_box)
   (if (keywordp (car __sign_box))
       (send* _sign_box __sign_box)
     (progn
       (if __sign_box (setq _sign_box (car __sign_box)))
       _sign_box)))
  (:has_sign
   (&optional __has_sign)
   (if __has_sign (setq _has_sign __has_sign)) _has_sign)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _image_topic
    4 (length _image_topic)
    ;; sensor_msgs/Image _full_image
    (send _full_image :serialization-length)
    ;; int32 _id
    4
    ;; string[] _sign
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _sign)) 4
    ;; float32 _x_enlarge_factor
    4
    ;; float32 _y_enlarge_factor
    4
    ;; float32 _x_offset_factor
    4
    ;; float32 _y_offset_factor
    4
    ;; int32 _distance
    4
    ;; sensor_msgs/Image _roi_image
    (send _roi_image :serialization-length)
    ;; sensor_msgs/Image _tone_map_roi_image
    (send _tone_map_roi_image :serialization-length)
    ;; geometry_msgs/Polygon _traffic_sign_map_points
    (send _traffic_sign_map_points :serialization-length)
    ;; geometry_msgs/Polygon _traffic_sign_points
    (send _traffic_sign_points :serialization-length)
    ;; sensor_msgs/RegionOfInterest _traffic_sign_roi
    (send _traffic_sign_roi :serialization-length)
    ;; geometry_msgs/Polygon _all_traffic_sign_points
    (send _all_traffic_sign_points :serialization-length)
    ;; sensor_msgs/RegionOfInterest[] _all_traffic_sign_roi
    (apply #'+ (send-all _all_traffic_sign_roi :serialization-length)) 4
    ;; itri_msgs/ImageObj _sign_box
    (send _sign_box :serialization-length)
    ;; bool _has_sign
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _image_topic
       (write-long (length _image_topic) s) (princ _image_topic s)
     ;; sensor_msgs/Image _full_image
       (send _full_image :serialize s)
     ;; int32 _id
       (write-long _id s)
     ;; string[] _sign
     (write-long (length _sign) s)
     (dolist (elem _sign)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _x_enlarge_factor
       (sys::poke _x_enlarge_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_enlarge_factor
       (sys::poke _y_enlarge_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_offset_factor
       (sys::poke _x_offset_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_offset_factor
       (sys::poke _y_offset_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _distance
       (write-long _distance s)
     ;; sensor_msgs/Image _roi_image
       (send _roi_image :serialize s)
     ;; sensor_msgs/Image _tone_map_roi_image
       (send _tone_map_roi_image :serialize s)
     ;; geometry_msgs/Polygon _traffic_sign_map_points
       (send _traffic_sign_map_points :serialize s)
     ;; geometry_msgs/Polygon _traffic_sign_points
       (send _traffic_sign_points :serialize s)
     ;; sensor_msgs/RegionOfInterest _traffic_sign_roi
       (send _traffic_sign_roi :serialize s)
     ;; geometry_msgs/Polygon _all_traffic_sign_points
       (send _all_traffic_sign_points :serialize s)
     ;; sensor_msgs/RegionOfInterest[] _all_traffic_sign_roi
     (write-long (length _all_traffic_sign_roi) s)
     (dolist (elem _all_traffic_sign_roi)
       (send elem :serialize s)
       )
     ;; itri_msgs/ImageObj _sign_box
       (send _sign_box :serialize s)
     ;; bool _has_sign
       (if _has_sign (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _image_topic
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _image_topic (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; sensor_msgs/Image _full_image
     (send _full_image :deserialize buf ptr-) (incf ptr- (send _full_image :serialization-length))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _sign
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sign (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _sign i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _x_enlarge_factor
     (setq _x_enlarge_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_enlarge_factor
     (setq _y_enlarge_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_offset_factor
     (setq _x_offset_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_offset_factor
     (setq _y_offset_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _distance
     (setq _distance (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; sensor_msgs/Image _roi_image
     (send _roi_image :deserialize buf ptr-) (incf ptr- (send _roi_image :serialization-length))
   ;; sensor_msgs/Image _tone_map_roi_image
     (send _tone_map_roi_image :deserialize buf ptr-) (incf ptr- (send _tone_map_roi_image :serialization-length))
   ;; geometry_msgs/Polygon _traffic_sign_map_points
     (send _traffic_sign_map_points :deserialize buf ptr-) (incf ptr- (send _traffic_sign_map_points :serialization-length))
   ;; geometry_msgs/Polygon _traffic_sign_points
     (send _traffic_sign_points :deserialize buf ptr-) (incf ptr- (send _traffic_sign_points :serialization-length))
   ;; sensor_msgs/RegionOfInterest _traffic_sign_roi
     (send _traffic_sign_roi :deserialize buf ptr-) (incf ptr- (send _traffic_sign_roi :serialization-length))
   ;; geometry_msgs/Polygon _all_traffic_sign_points
     (send _all_traffic_sign_points :deserialize buf ptr-) (incf ptr- (send _all_traffic_sign_points :serialization-length))
   ;; sensor_msgs/RegionOfInterest[] _all_traffic_sign_roi
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _all_traffic_sign_roi (let (r) (dotimes (i n) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
     (dolist (elem- _all_traffic_sign_roi)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/ImageObj _sign_box
     (send _sign_box :deserialize buf ptr-) (incf ptr- (send _sign_box :serialization-length))
   ;; bool _has_sign
     (setq _has_sign (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::TrafficSignPipeline :md5sum-) "9d96c21a93fc96e16cde29646db6f0b8")
(setf (get itri_msgs::TrafficSignPipeline :datatype-) "itri_msgs/TrafficSignPipeline")
(setf (get itri_msgs::TrafficSignPipeline :definition-)
      "Header header

# image info
string image_topic
sensor_msgs/Image full_image

# semantic map info
int32 id
string[] sign

float32 x_enlarge_factor
float32 y_enlarge_factor
float32 x_offset_factor
float32 y_offset_factor

# traffic_sign_projection info
int32 distance
sensor_msgs/Image roi_image
sensor_msgs/Image tone_map_roi_image

geometry_msgs/Polygon traffic_sign_map_points
geometry_msgs/Polygon traffic_sign_points
sensor_msgs/RegionOfInterest traffic_sign_roi

geometry_msgs/Polygon all_traffic_sign_points
sensor_msgs/RegionOfInterest[] all_traffic_sign_roi

# traffic_sign_detection info
itri_msgs/ImageObj sign_box

# traffic_sign_status info
bool has_sign

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
================================================================================
MSG: sensor_msgs/RegionOfInterest
# This message is used to specify a region of interest within an image.
#
# When used to specify the ROI setting of the camera when the image was
# taken, the height and width fields should either match the height and
# width fields for the associated image; or height = width = 0
# indicates that the full resolution image was captured.

uint32 x_offset  # Leftmost pixel of the ROI
                 # (0 if the ROI includes the left edge of the image)
uint32 y_offset  # Topmost pixel of the ROI
                 # (0 if the ROI includes the top edge of the image)
uint32 height    # Height of ROI
uint32 width     # Width of ROI

# True if a distinct rectified ROI should be calculated from the \"raw\"
# ROI in this message. Typically this should be False if the full image
# is captured (ROI not used), and True if a subwindow is captured (ROI
# used).
bool do_rectify

================================================================================
MSG: itri_msgs/ImageObj
Header header
string type
ImageRect[] obj
# XXX Should this message have 'score' ?

================================================================================
MSG: itri_msgs/ImageRect
int32 id
int32 x
int32 y
int32 height
int32 width
float32 score
string cls

")



(provide :itri_msgs/TrafficSignPipeline "9d96c21a93fc96e16cde29646db6f0b8")


