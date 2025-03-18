;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficLightObjects)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficLightObjects (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECTS")
  (make-package "ITRI_MSGS::TRAFFICLIGHTOBJECTS"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightObjects.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::TrafficLightObjects
  :super ros::object
  :slots (_header _lights ))

(defmethod itri_msgs::TrafficLightObjects
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lights __lights) (let (r) (dotimes (i 0) (push (instance itri_msgs::TrafficLightObject :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _lights __lights)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lights
   (&rest __lights)
   (if (keywordp (car __lights))
       (send* _lights __lights)
     (progn
       (if __lights (setq _lights (car __lights)))
       _lights)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/TrafficLightObject[] _lights
    (apply #'+ (send-all _lights :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/TrafficLightObject[] _lights
     (write-long (length _lights) s)
     (dolist (elem _lights)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/TrafficLightObject[] _lights
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lights (let (r) (dotimes (i n) (push (instance itri_msgs::TrafficLightObject :init) r)) r))
     (dolist (elem- _lights)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::TrafficLightObjects :md5sum-) "fe2c5dabf2fe93f365342371c20e525d")
(setf (get itri_msgs::TrafficLightObjects :datatype-) "itri_msgs/TrafficLightObjects")
(setf (get itri_msgs::TrafficLightObjects :definition-)
      "Header header
TrafficLightObject[] lights

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
MSG: itri_msgs/TrafficLightObject
bool dontCare
bool green
bool left
bool red
bool right
bool straight
bool yellow
bool flashyellow
bool flashred

bool blocked
geometry_msgs/Polygon traffic_light_map_points
sensor_msgs/RegionOfInterest roi
float32 score

int32 id
float32 distance
float32 remain_sec
string[] lights
sensor_msgs/RegionOfInterest[] lightsroi

uint8 DETECTOR=0
uint8 RSU=1
uint8 source

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

")



(provide :itri_msgs/TrafficLightObjects "fe2c5dabf2fe93f365342371c20e525d")


