;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::NdtStatistics)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'NdtStatistics (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::NDTSTATISTICS")
  (make-package "ITRI_MSGS::NDTSTATISTICS"))

(in-package "ROS")
;;//! \htmlinclude NdtStatistics.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::NdtStatistics
  :super ros::object
  :slots (_header _execution_time _fitness_score _fitness_score_valid _invalid_points_number _iteration _map_coverage _matching_score _matching_score_valid _regulate_matching_score _scan_valid_ratio _source_points_number _valid_points_number ))

(defmethod itri_msgs::NdtStatistics
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:execution_time __execution_time) 0.0)
    ((:fitness_score __fitness_score) 0.0)
    ((:fitness_score_valid __fitness_score_valid) 0.0)
    ((:invalid_points_number __invalid_points_number) 0)
    ((:iteration __iteration) 0)
    ((:map_coverage __map_coverage) 0.0)
    ((:matching_score __matching_score) 0.0)
    ((:matching_score_valid __matching_score_valid) 0.0)
    ((:regulate_matching_score __regulate_matching_score) 0.0)
    ((:scan_valid_ratio __scan_valid_ratio) 0)
    ((:source_points_number __source_points_number) 0)
    ((:valid_points_number __valid_points_number) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _execution_time (float __execution_time))
   (setq _fitness_score (float __fitness_score))
   (setq _fitness_score_valid (float __fitness_score_valid))
   (setq _invalid_points_number (round __invalid_points_number))
   (setq _iteration (round __iteration))
   (setq _map_coverage (float __map_coverage))
   (setq _matching_score (float __matching_score))
   (setq _matching_score_valid (float __matching_score_valid))
   (setq _regulate_matching_score (float __regulate_matching_score))
   (setq _scan_valid_ratio (round __scan_valid_ratio))
   (setq _source_points_number (round __source_points_number))
   (setq _valid_points_number (round __valid_points_number))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:execution_time
   (&optional __execution_time)
   (if __execution_time (setq _execution_time __execution_time)) _execution_time)
  (:fitness_score
   (&optional __fitness_score)
   (if __fitness_score (setq _fitness_score __fitness_score)) _fitness_score)
  (:fitness_score_valid
   (&optional __fitness_score_valid)
   (if __fitness_score_valid (setq _fitness_score_valid __fitness_score_valid)) _fitness_score_valid)
  (:invalid_points_number
   (&optional __invalid_points_number)
   (if __invalid_points_number (setq _invalid_points_number __invalid_points_number)) _invalid_points_number)
  (:iteration
   (&optional __iteration)
   (if __iteration (setq _iteration __iteration)) _iteration)
  (:map_coverage
   (&optional __map_coverage)
   (if __map_coverage (setq _map_coverage __map_coverage)) _map_coverage)
  (:matching_score
   (&optional __matching_score)
   (if __matching_score (setq _matching_score __matching_score)) _matching_score)
  (:matching_score_valid
   (&optional __matching_score_valid)
   (if __matching_score_valid (setq _matching_score_valid __matching_score_valid)) _matching_score_valid)
  (:regulate_matching_score
   (&optional __regulate_matching_score)
   (if __regulate_matching_score (setq _regulate_matching_score __regulate_matching_score)) _regulate_matching_score)
  (:scan_valid_ratio
   (&optional __scan_valid_ratio)
   (if __scan_valid_ratio (setq _scan_valid_ratio __scan_valid_ratio)) _scan_valid_ratio)
  (:source_points_number
   (&optional __source_points_number)
   (if __source_points_number (setq _source_points_number __source_points_number)) _source_points_number)
  (:valid_points_number
   (&optional __valid_points_number)
   (if __valid_points_number (setq _valid_points_number __valid_points_number)) _valid_points_number)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _execution_time
    4
    ;; float32 _fitness_score
    4
    ;; float32 _fitness_score_valid
    4
    ;; uint32 _invalid_points_number
    4
    ;; uint32 _iteration
    4
    ;; float32 _map_coverage
    4
    ;; float32 _matching_score
    4
    ;; float32 _matching_score_valid
    4
    ;; float32 _regulate_matching_score
    4
    ;; uint32 _scan_valid_ratio
    4
    ;; uint32 _source_points_number
    4
    ;; uint32 _valid_points_number
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _execution_time
       (sys::poke _execution_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fitness_score
       (sys::poke _fitness_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fitness_score_valid
       (sys::poke _fitness_score_valid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _invalid_points_number
       (write-long _invalid_points_number s)
     ;; uint32 _iteration
       (write-long _iteration s)
     ;; float32 _map_coverage
       (sys::poke _map_coverage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _matching_score
       (sys::poke _matching_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _matching_score_valid
       (sys::poke _matching_score_valid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _regulate_matching_score
       (sys::poke _regulate_matching_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _scan_valid_ratio
       (write-long _scan_valid_ratio s)
     ;; uint32 _source_points_number
       (write-long _source_points_number s)
     ;; uint32 _valid_points_number
       (write-long _valid_points_number s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _execution_time
     (setq _execution_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fitness_score
     (setq _fitness_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fitness_score_valid
     (setq _fitness_score_valid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _invalid_points_number
     (setq _invalid_points_number (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _iteration
     (setq _iteration (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _map_coverage
     (setq _map_coverage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _matching_score
     (setq _matching_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _matching_score_valid
     (setq _matching_score_valid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _regulate_matching_score
     (setq _regulate_matching_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _scan_valid_ratio
     (setq _scan_valid_ratio (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _source_points_number
     (setq _source_points_number (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _valid_points_number
     (setq _valid_points_number (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::NdtStatistics :md5sum-) "b21481a49aaae81584b34de5ce8cef65")
(setf (get itri_msgs::NdtStatistics :datatype-) "itri_msgs/NdtStatistics")
(setf (get itri_msgs::NdtStatistics :definition-)
      "Header header

float32 execution_time
float32 fitness_score
float32 fitness_score_valid
uint32 invalid_points_number
uint32 iteration
float32 map_coverage
float32 matching_score
float32 matching_score_valid
float32 regulate_matching_score
uint32 scan_valid_ratio
uint32 source_points_number
uint32 valid_points_number

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



(provide :itri_msgs/NdtStatistics "b21481a49aaae81584b34de5ce8cef65")


