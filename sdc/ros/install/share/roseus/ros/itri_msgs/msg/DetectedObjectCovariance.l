;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::DetectedObjectCovariance)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'DetectedObjectCovariance (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::DETECTEDOBJECTCOVARIANCE")
  (make-package "ITRI_MSGS::DETECTEDOBJECTCOVARIANCE"))

(in-package "ROS")
;;//! \htmlinclude DetectedObjectCovariance.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::DetectedObjectCovariance
  :super ros::object
  :slots (_header _id _valueX _valueY ))

(defmethod itri_msgs::DetectedObjectCovariance
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) 0)
    ((:valueX __valueX) 0.0)
    ((:valueY __valueY) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _id (round __id))
   (setq _valueX (float __valueX))
   (setq _valueY (float __valueY))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:valueX
   (&optional __valueX)
   (if __valueX (setq _valueX __valueX)) _valueX)
  (:valueY
   (&optional __valueY)
   (if __valueY (setq _valueY __valueY)) _valueY)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _id
    4
    ;; float32 _valueX
    4
    ;; float32 _valueY
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _id
       (write-long _id s)
     ;; float32 _valueX
       (sys::poke _valueX (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _valueY
       (sys::poke _valueY (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _valueX
     (setq _valueX (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _valueY
     (setq _valueY (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::DetectedObjectCovariance :md5sum-) "a28f36689e9da040bab82e53c9916f8c")
(setf (get itri_msgs::DetectedObjectCovariance :datatype-) "itri_msgs/DetectedObjectCovariance")
(setf (get itri_msgs::DetectedObjectCovariance :definition-)
      "std_msgs/Header header

uint32 id
float32 valueX
float32 valueY

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



(provide :itri_msgs/DetectedObjectCovariance "a28f36689e9da040bab82e53c9916f8c")


