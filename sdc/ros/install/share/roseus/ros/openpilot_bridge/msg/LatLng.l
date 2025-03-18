;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LatLng)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LatLng (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATLNG")
  (make-package "OPENPILOT_BRIDGE::LATLNG"))

(in-package "ROS")
;;//! \htmlinclude LatLng.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LatLng
  :super ros::object
  :slots (_header _lat _lng ))

(defmethod openpilot_bridge::LatLng
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lat __lat) 0.0)
    ((:lng __lng) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _lat (float __lat))
   (setq _lng (float __lng))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lat
   (&optional __lat)
   (if __lat (setq _lat __lat)) _lat)
  (:lng
   (&optional __lng)
   (if __lng (setq _lng __lng)) _lng)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _lat
    4
    ;; float32 _lng
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _lat
       (sys::poke _lat (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _lng
       (sys::poke _lng (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _lat
     (setq _lat (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _lng
     (setq _lng (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LatLng :md5sum-) "f7d1aaaa4fcd34d84f82ef94e7c9fe9d")
(setf (get openpilot_bridge::LatLng :datatype-) "openpilot_bridge/LatLng")
(setf (get openpilot_bridge::LatLng :definition-)
      "Header header

float32 lat
float32 lng

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

")



(provide :openpilot_bridge/LatLng "f7d1aaaa4fcd34d84f82ef94e7c9fe9d")


