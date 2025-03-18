;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ChffrAndroidExtra)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ChffrAndroidExtra (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CHFFRANDROIDEXTRA")
  (make-package "OPENPILOT_BRIDGE::CHFFRANDROIDEXTRA"))

(in-package "ROS")
;;//! \htmlinclude ChffrAndroidExtra.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ChffrAndroidExtra
  :super ros::object
  :slots (_header _allCameraCharacteristics ))

(defmethod openpilot_bridge::ChffrAndroidExtra
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:allCameraCharacteristics __allCameraCharacteristics) (instance openpilot_bridge::Map :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _allCameraCharacteristics __allCameraCharacteristics)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:allCameraCharacteristics
   (&rest __allCameraCharacteristics)
   (if (keywordp (car __allCameraCharacteristics))
       (send* _allCameraCharacteristics __allCameraCharacteristics)
     (progn
       (if __allCameraCharacteristics (setq _allCameraCharacteristics (car __allCameraCharacteristics)))
       _allCameraCharacteristics)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/Map _allCameraCharacteristics
    (send _allCameraCharacteristics :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/Map _allCameraCharacteristics
       (send _allCameraCharacteristics :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/Map _allCameraCharacteristics
     (send _allCameraCharacteristics :deserialize buf ptr-) (incf ptr- (send _allCameraCharacteristics :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::ChffrAndroidExtra :md5sum-) "b43d42df107e761f273426529e592a9c")
(setf (get openpilot_bridge::ChffrAndroidExtra :datatype-) "openpilot_bridge/ChffrAndroidExtra")
(setf (get openpilot_bridge::ChffrAndroidExtra :definition-)
      "Header header

Map allCameraCharacteristics

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
MSG: openpilot_bridge/Map
Header header

Entry[] entries

================================================================================
MSG: openpilot_bridge/Entry
Header header

string value
string key

")



(provide :openpilot_bridge/ChffrAndroidExtra "b43d42df107e761f273426529e592a9c")


