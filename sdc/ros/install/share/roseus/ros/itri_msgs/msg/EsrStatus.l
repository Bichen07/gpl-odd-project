;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EsrStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EsrStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ESRSTATUS")
  (make-package "ITRI_MSGS::ESRSTATUS"))

(in-package "ROS")
;;//! \htmlinclude EsrStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::EsrStatus
  :super ros::object
  :slots (_header _esr_curvature _esr_yaw_rate _esr_vehicle_speed _esr_max_track_targets _esr_power_mode _esr_mr_lr_mode _esr_grouping_mode _esr_temperature _esr_scan_id _esr_raw_data_mode _esr_partial_blockage _esr_side_lobe_blockage _esr_found_target _esr_comm_error _esr_overheat_error _esr_range_perf_error _esr_internal_error _esr_xcvr_operational ))

(defmethod itri_msgs::EsrStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:esr_curvature __esr_curvature) 0)
    ((:esr_yaw_rate __esr_yaw_rate) 0.0)
    ((:esr_vehicle_speed __esr_vehicle_speed) 0.0)
    ((:esr_max_track_targets __esr_max_track_targets) 0)
    ((:esr_power_mode __esr_power_mode) 0)
    ((:esr_mr_lr_mode __esr_mr_lr_mode) 0)
    ((:esr_grouping_mode __esr_grouping_mode) 0)
    ((:esr_temperature __esr_temperature) 0)
    ((:esr_scan_id __esr_scan_id) 0)
    ((:esr_raw_data_mode __esr_raw_data_mode) nil)
    ((:esr_partial_blockage __esr_partial_blockage) nil)
    ((:esr_side_lobe_blockage __esr_side_lobe_blockage) nil)
    ((:esr_found_target __esr_found_target) nil)
    ((:esr_comm_error __esr_comm_error) nil)
    ((:esr_overheat_error __esr_overheat_error) nil)
    ((:esr_range_perf_error __esr_range_perf_error) nil)
    ((:esr_internal_error __esr_internal_error) nil)
    ((:esr_xcvr_operational __esr_xcvr_operational) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _esr_curvature (round __esr_curvature))
   (setq _esr_yaw_rate (float __esr_yaw_rate))
   (setq _esr_vehicle_speed (float __esr_vehicle_speed))
   (setq _esr_max_track_targets (round __esr_max_track_targets))
   (setq _esr_power_mode (round __esr_power_mode))
   (setq _esr_mr_lr_mode (round __esr_mr_lr_mode))
   (setq _esr_grouping_mode (round __esr_grouping_mode))
   (setq _esr_temperature (round __esr_temperature))
   (setq _esr_scan_id (round __esr_scan_id))
   (setq _esr_raw_data_mode __esr_raw_data_mode)
   (setq _esr_partial_blockage __esr_partial_blockage)
   (setq _esr_side_lobe_blockage __esr_side_lobe_blockage)
   (setq _esr_found_target __esr_found_target)
   (setq _esr_comm_error __esr_comm_error)
   (setq _esr_overheat_error __esr_overheat_error)
   (setq _esr_range_perf_error __esr_range_perf_error)
   (setq _esr_internal_error __esr_internal_error)
   (setq _esr_xcvr_operational __esr_xcvr_operational)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:esr_curvature
   (&optional __esr_curvature)
   (if __esr_curvature (setq _esr_curvature __esr_curvature)) _esr_curvature)
  (:esr_yaw_rate
   (&optional __esr_yaw_rate)
   (if __esr_yaw_rate (setq _esr_yaw_rate __esr_yaw_rate)) _esr_yaw_rate)
  (:esr_vehicle_speed
   (&optional __esr_vehicle_speed)
   (if __esr_vehicle_speed (setq _esr_vehicle_speed __esr_vehicle_speed)) _esr_vehicle_speed)
  (:esr_max_track_targets
   (&optional __esr_max_track_targets)
   (if __esr_max_track_targets (setq _esr_max_track_targets __esr_max_track_targets)) _esr_max_track_targets)
  (:esr_power_mode
   (&optional __esr_power_mode)
   (if __esr_power_mode (setq _esr_power_mode __esr_power_mode)) _esr_power_mode)
  (:esr_mr_lr_mode
   (&optional __esr_mr_lr_mode)
   (if __esr_mr_lr_mode (setq _esr_mr_lr_mode __esr_mr_lr_mode)) _esr_mr_lr_mode)
  (:esr_grouping_mode
   (&optional __esr_grouping_mode)
   (if __esr_grouping_mode (setq _esr_grouping_mode __esr_grouping_mode)) _esr_grouping_mode)
  (:esr_temperature
   (&optional __esr_temperature)
   (if __esr_temperature (setq _esr_temperature __esr_temperature)) _esr_temperature)
  (:esr_scan_id
   (&optional __esr_scan_id)
   (if __esr_scan_id (setq _esr_scan_id __esr_scan_id)) _esr_scan_id)
  (:esr_raw_data_mode
   (&optional __esr_raw_data_mode)
   (if __esr_raw_data_mode (setq _esr_raw_data_mode __esr_raw_data_mode)) _esr_raw_data_mode)
  (:esr_partial_blockage
   (&optional __esr_partial_blockage)
   (if __esr_partial_blockage (setq _esr_partial_blockage __esr_partial_blockage)) _esr_partial_blockage)
  (:esr_side_lobe_blockage
   (&optional __esr_side_lobe_blockage)
   (if __esr_side_lobe_blockage (setq _esr_side_lobe_blockage __esr_side_lobe_blockage)) _esr_side_lobe_blockage)
  (:esr_found_target
   (&optional __esr_found_target)
   (if __esr_found_target (setq _esr_found_target __esr_found_target)) _esr_found_target)
  (:esr_comm_error
   (&optional __esr_comm_error)
   (if __esr_comm_error (setq _esr_comm_error __esr_comm_error)) _esr_comm_error)
  (:esr_overheat_error
   (&optional __esr_overheat_error)
   (if __esr_overheat_error (setq _esr_overheat_error __esr_overheat_error)) _esr_overheat_error)
  (:esr_range_perf_error
   (&optional __esr_range_perf_error)
   (if __esr_range_perf_error (setq _esr_range_perf_error __esr_range_perf_error)) _esr_range_perf_error)
  (:esr_internal_error
   (&optional __esr_internal_error)
   (if __esr_internal_error (setq _esr_internal_error __esr_internal_error)) _esr_internal_error)
  (:esr_xcvr_operational
   (&optional __esr_xcvr_operational)
   (if __esr_xcvr_operational (setq _esr_xcvr_operational __esr_xcvr_operational)) _esr_xcvr_operational)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int16 _esr_curvature
    2
    ;; float32 _esr_yaw_rate
    4
    ;; float32 _esr_vehicle_speed
    4
    ;; uint8 _esr_max_track_targets
    1
    ;; uint8 _esr_power_mode
    1
    ;; uint8 _esr_mr_lr_mode
    1
    ;; uint8 _esr_grouping_mode
    1
    ;; int8 _esr_temperature
    1
    ;; uint8 _esr_scan_id
    1
    ;; bool _esr_raw_data_mode
    1
    ;; bool _esr_partial_blockage
    1
    ;; bool _esr_side_lobe_blockage
    1
    ;; bool _esr_found_target
    1
    ;; bool _esr_comm_error
    1
    ;; bool _esr_overheat_error
    1
    ;; bool _esr_range_perf_error
    1
    ;; bool _esr_internal_error
    1
    ;; bool _esr_xcvr_operational
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int16 _esr_curvature
       (write-word _esr_curvature s)
     ;; float32 _esr_yaw_rate
       (sys::poke _esr_yaw_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _esr_vehicle_speed
       (sys::poke _esr_vehicle_speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _esr_max_track_targets
       (write-byte _esr_max_track_targets s)
     ;; uint8 _esr_power_mode
       (write-byte _esr_power_mode s)
     ;; uint8 _esr_mr_lr_mode
       (write-byte _esr_mr_lr_mode s)
     ;; uint8 _esr_grouping_mode
       (write-byte _esr_grouping_mode s)
     ;; int8 _esr_temperature
       (write-byte _esr_temperature s)
     ;; uint8 _esr_scan_id
       (write-byte _esr_scan_id s)
     ;; bool _esr_raw_data_mode
       (if _esr_raw_data_mode (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_partial_blockage
       (if _esr_partial_blockage (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_side_lobe_blockage
       (if _esr_side_lobe_blockage (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_found_target
       (if _esr_found_target (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_comm_error
       (if _esr_comm_error (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_overheat_error
       (if _esr_overheat_error (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_range_perf_error
       (if _esr_range_perf_error (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_internal_error
       (if _esr_internal_error (write-byte -1 s) (write-byte 0 s))
     ;; bool _esr_xcvr_operational
       (if _esr_xcvr_operational (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int16 _esr_curvature
     (setq _esr_curvature (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _esr_yaw_rate
     (setq _esr_yaw_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _esr_vehicle_speed
     (setq _esr_vehicle_speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _esr_max_track_targets
     (setq _esr_max_track_targets (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _esr_power_mode
     (setq _esr_power_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _esr_mr_lr_mode
     (setq _esr_mr_lr_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _esr_grouping_mode
     (setq _esr_grouping_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int8 _esr_temperature
     (setq _esr_temperature (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _esr_temperature 127) (setq _esr_temperature (- _esr_temperature 256)))
   ;; uint8 _esr_scan_id
     (setq _esr_scan_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _esr_raw_data_mode
     (setq _esr_raw_data_mode (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_partial_blockage
     (setq _esr_partial_blockage (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_side_lobe_blockage
     (setq _esr_side_lobe_blockage (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_found_target
     (setq _esr_found_target (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_comm_error
     (setq _esr_comm_error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_overheat_error
     (setq _esr_overheat_error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_range_perf_error
     (setq _esr_range_perf_error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_internal_error
     (setq _esr_internal_error (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _esr_xcvr_operational
     (setq _esr_xcvr_operational (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::EsrStatus :md5sum-) "6576074bb36351e24411f4c33b02aeac")
(setf (get itri_msgs::EsrStatus :datatype-) "itri_msgs/EsrStatus")
(setf (get itri_msgs::EsrStatus :definition-)
      "Header header
int16 esr_curvature
float32 esr_yaw_rate
float32 esr_vehicle_speed
uint8 esr_max_track_targets
uint8 esr_power_mode
uint8 esr_mr_lr_mode
uint8 esr_grouping_mode
int8 esr_temperature
uint8 esr_scan_id
bool esr_raw_data_mode
bool esr_partial_blockage
bool esr_side_lobe_blockage
bool esr_found_target
bool esr_comm_error
bool esr_overheat_error
bool esr_range_perf_error
bool esr_internal_error
bool esr_xcvr_operational

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



(provide :itri_msgs/EsrStatus "6576074bb36351e24411f4c33b02aeac")


