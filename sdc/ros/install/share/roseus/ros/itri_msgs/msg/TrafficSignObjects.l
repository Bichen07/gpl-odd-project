;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficSignObjects)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficSignObjects (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICSIGNOBJECTS")
  (make-package "ITRI_MSGS::TRAFFICSIGNOBJECTS"))

(in-package "ROS")
;;//! \htmlinclude TrafficSignObjects.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::TrafficSignObjects
  :super ros::object
  :slots (_header _signs ))

(defmethod itri_msgs::TrafficSignObjects
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:signs __signs) (let (r) (dotimes (i 0) (push (instance itri_msgs::TrafficSignObject :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _signs __signs)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:signs
   (&rest __signs)
   (if (keywordp (car __signs))
       (send* _signs __signs)
     (progn
       (if __signs (setq _signs (car __signs)))
       _signs)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/TrafficSignObject[] _signs
    (apply #'+ (send-all _signs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/TrafficSignObject[] _signs
     (write-long (length _signs) s)
     (dolist (elem _signs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/TrafficSignObject[] _signs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _signs (let (r) (dotimes (i n) (push (instance itri_msgs::TrafficSignObject :init) r)) r))
     (dolist (elem- _signs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::TrafficSignObjects :md5sum-) "87034deff55157e68a423890ed562f90")
(setf (get itri_msgs::TrafficSignObjects :datatype-) "itri_msgs/TrafficSignObjects")
(setf (get itri_msgs::TrafficSignObjects :definition-)
      "Header header
TrafficSignObject[] signs

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
MSG: itri_msgs/TrafficSignObject
bool stop

sensor_msgs/RegionOfInterest roi
float32 score

int32 id
float32 distance
string[] sign

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



(provide :itri_msgs/TrafficSignObjects "87034deff55157e68a423890ed562f90")


