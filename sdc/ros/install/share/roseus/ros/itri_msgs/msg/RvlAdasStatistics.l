;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::RvlAdasStatistics)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'RvlAdasStatistics (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::RVLADASSTATISTICS")
  (make-package "ITRI_MSGS::RVLADASSTATISTICS"))

(in-package "ROS")
;;//! \htmlinclude RvlAdasStatistics.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::RvlAdasStatistics
  :super ros::object
  :slots (_header _preProcessingTime _infernceTime _postProcessingTime ))

(defmethod itri_msgs::RvlAdasStatistics
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:preProcessingTime __preProcessingTime) 0.0)
    ((:infernceTime __infernceTime) 0.0)
    ((:postProcessingTime __postProcessingTime) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _preProcessingTime (float __preProcessingTime))
   (setq _infernceTime (float __infernceTime))
   (setq _postProcessingTime (float __postProcessingTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:preProcessingTime
   (&optional __preProcessingTime)
   (if __preProcessingTime (setq _preProcessingTime __preProcessingTime)) _preProcessingTime)
  (:infernceTime
   (&optional __infernceTime)
   (if __infernceTime (setq _infernceTime __infernceTime)) _infernceTime)
  (:postProcessingTime
   (&optional __postProcessingTime)
   (if __postProcessingTime (setq _postProcessingTime __postProcessingTime)) _postProcessingTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _preProcessingTime
    4
    ;; float32 _infernceTime
    4
    ;; float32 _postProcessingTime
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _preProcessingTime
       (sys::poke _preProcessingTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _infernceTime
       (sys::poke _infernceTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _postProcessingTime
       (sys::poke _postProcessingTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _preProcessingTime
     (setq _preProcessingTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _infernceTime
     (setq _infernceTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _postProcessingTime
     (setq _postProcessingTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::RvlAdasStatistics :md5sum-) "f80e671674f1651c37ef74d50d290b0c")
(setf (get itri_msgs::RvlAdasStatistics :datatype-) "itri_msgs/RvlAdasStatistics")
(setf (get itri_msgs::RvlAdasStatistics :definition-)
      "Header header
float32 preProcessingTime
float32 infernceTime
float32 postProcessingTime

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



(provide :itri_msgs/RvlAdasStatistics "f80e671674f1651c37ef74d50d290b0c")


