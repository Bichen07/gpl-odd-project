;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::VoxelGridFilterInfo)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'VoxelGridFilterInfo (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::VOXELGRIDFILTERINFO")
  (make-package "ITRI_MSGS::VOXELGRIDFILTERINFO"))

(in-package "ROS")
;;//! \htmlinclude VoxelGridFilterInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::VoxelGridFilterInfo
  :super ros::object
  :slots (_header _filter_name _measurement_range _original_points_size _filtered_points_size _execution_time ))

(defmethod itri_msgs::VoxelGridFilterInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:filter_name __filter_name) "")
    ((:measurement_range __measurement_range) 0.0)
    ((:original_points_size __original_points_size) 0)
    ((:filtered_points_size __filtered_points_size) 0)
    ((:execution_time __execution_time) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _filter_name (string __filter_name))
   (setq _measurement_range (float __measurement_range))
   (setq _original_points_size (round __original_points_size))
   (setq _filtered_points_size (round __filtered_points_size))
   (setq _execution_time (float __execution_time))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:filter_name
   (&optional __filter_name)
   (if __filter_name (setq _filter_name __filter_name)) _filter_name)
  (:measurement_range
   (&optional __measurement_range)
   (if __measurement_range (setq _measurement_range __measurement_range)) _measurement_range)
  (:original_points_size
   (&optional __original_points_size)
   (if __original_points_size (setq _original_points_size __original_points_size)) _original_points_size)
  (:filtered_points_size
   (&optional __filtered_points_size)
   (if __filtered_points_size (setq _filtered_points_size __filtered_points_size)) _filtered_points_size)
  (:execution_time
   (&optional __execution_time)
   (if __execution_time (setq _execution_time __execution_time)) _execution_time)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _filter_name
    4 (length _filter_name)
    ;; float32 _measurement_range
    4
    ;; int32 _original_points_size
    4
    ;; int32 _filtered_points_size
    4
    ;; float32 _execution_time
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _filter_name
       (write-long (length _filter_name) s) (princ _filter_name s)
     ;; float32 _measurement_range
       (sys::poke _measurement_range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _original_points_size
       (write-long _original_points_size s)
     ;; int32 _filtered_points_size
       (write-long _filtered_points_size s)
     ;; float32 _execution_time
       (sys::poke _execution_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _filter_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _filter_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _measurement_range
     (setq _measurement_range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _original_points_size
     (setq _original_points_size (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _filtered_points_size
     (setq _filtered_points_size (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _execution_time
     (setq _execution_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::VoxelGridFilterInfo :md5sum-) "a1652d8ba147b439694fc6c6bce138b7")
(setf (get itri_msgs::VoxelGridFilterInfo :datatype-) "itri_msgs/VoxelGridFilterInfo")
(setf (get itri_msgs::VoxelGridFilterInfo :definition-)
      "Header header
string filter_name
float32 measurement_range
int32 original_points_size
int32 filtered_points_size
float32 execution_time

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



(provide :itri_msgs/VoxelGridFilterInfo "a1652d8ba147b439694fc6c6bce138b7")


