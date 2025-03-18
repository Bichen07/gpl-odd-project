;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::FaultActionsReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'FaultActionsReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::FAULTACTIONSREPORT")
  (make-package "DBW_PACIFICA_MSGS::FAULTACTIONSREPORT"))

(in-package "ROS")
;;//! \htmlinclude FaultActionsReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::FaultActionsReport
  :super ros::object
  :slots (_header _auto_disable_no_brakes _auto_disable_apply_brakes _dbw_can_gateway_disable _inverter_cnt_control_disable _prevent_enter_auto_mode _warn_driver_only _chime_fcw_beeps ))

(defmethod dbw_pacifica_msgs::FaultActionsReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:auto_disable_no_brakes __auto_disable_no_brakes) nil)
    ((:auto_disable_apply_brakes __auto_disable_apply_brakes) nil)
    ((:dbw_can_gateway_disable __dbw_can_gateway_disable) nil)
    ((:inverter_cnt_control_disable __inverter_cnt_control_disable) nil)
    ((:prevent_enter_auto_mode __prevent_enter_auto_mode) nil)
    ((:warn_driver_only __warn_driver_only) nil)
    ((:chime_fcw_beeps __chime_fcw_beeps) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _auto_disable_no_brakes __auto_disable_no_brakes)
   (setq _auto_disable_apply_brakes __auto_disable_apply_brakes)
   (setq _dbw_can_gateway_disable __dbw_can_gateway_disable)
   (setq _inverter_cnt_control_disable __inverter_cnt_control_disable)
   (setq _prevent_enter_auto_mode __prevent_enter_auto_mode)
   (setq _warn_driver_only __warn_driver_only)
   (setq _chime_fcw_beeps __chime_fcw_beeps)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:auto_disable_no_brakes
   (&optional __auto_disable_no_brakes)
   (if __auto_disable_no_brakes (setq _auto_disable_no_brakes __auto_disable_no_brakes)) _auto_disable_no_brakes)
  (:auto_disable_apply_brakes
   (&optional __auto_disable_apply_brakes)
   (if __auto_disable_apply_brakes (setq _auto_disable_apply_brakes __auto_disable_apply_brakes)) _auto_disable_apply_brakes)
  (:dbw_can_gateway_disable
   (&optional __dbw_can_gateway_disable)
   (if __dbw_can_gateway_disable (setq _dbw_can_gateway_disable __dbw_can_gateway_disable)) _dbw_can_gateway_disable)
  (:inverter_cnt_control_disable
   (&optional __inverter_cnt_control_disable)
   (if __inverter_cnt_control_disable (setq _inverter_cnt_control_disable __inverter_cnt_control_disable)) _inverter_cnt_control_disable)
  (:prevent_enter_auto_mode
   (&optional __prevent_enter_auto_mode)
   (if __prevent_enter_auto_mode (setq _prevent_enter_auto_mode __prevent_enter_auto_mode)) _prevent_enter_auto_mode)
  (:warn_driver_only
   (&optional __warn_driver_only)
   (if __warn_driver_only (setq _warn_driver_only __warn_driver_only)) _warn_driver_only)
  (:chime_fcw_beeps
   (&optional __chime_fcw_beeps)
   (if __chime_fcw_beeps (setq _chime_fcw_beeps __chime_fcw_beeps)) _chime_fcw_beeps)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _auto_disable_no_brakes
    1
    ;; bool _auto_disable_apply_brakes
    1
    ;; bool _dbw_can_gateway_disable
    1
    ;; bool _inverter_cnt_control_disable
    1
    ;; bool _prevent_enter_auto_mode
    1
    ;; bool _warn_driver_only
    1
    ;; bool _chime_fcw_beeps
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _auto_disable_no_brakes
       (if _auto_disable_no_brakes (write-byte -1 s) (write-byte 0 s))
     ;; bool _auto_disable_apply_brakes
       (if _auto_disable_apply_brakes (write-byte -1 s) (write-byte 0 s))
     ;; bool _dbw_can_gateway_disable
       (if _dbw_can_gateway_disable (write-byte -1 s) (write-byte 0 s))
     ;; bool _inverter_cnt_control_disable
       (if _inverter_cnt_control_disable (write-byte -1 s) (write-byte 0 s))
     ;; bool _prevent_enter_auto_mode
       (if _prevent_enter_auto_mode (write-byte -1 s) (write-byte 0 s))
     ;; bool _warn_driver_only
       (if _warn_driver_only (write-byte -1 s) (write-byte 0 s))
     ;; bool _chime_fcw_beeps
       (if _chime_fcw_beeps (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _auto_disable_no_brakes
     (setq _auto_disable_no_brakes (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _auto_disable_apply_brakes
     (setq _auto_disable_apply_brakes (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _dbw_can_gateway_disable
     (setq _dbw_can_gateway_disable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _inverter_cnt_control_disable
     (setq _inverter_cnt_control_disable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _prevent_enter_auto_mode
     (setq _prevent_enter_auto_mode (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _warn_driver_only
     (setq _warn_driver_only (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _chime_fcw_beeps
     (setq _chime_fcw_beeps (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::FaultActionsReport :md5sum-) "c21ae693be0418da6826534ee549449c")
(setf (get dbw_pacifica_msgs::FaultActionsReport :datatype-) "dbw_pacifica_msgs/FaultActionsReport")
(setf (get dbw_pacifica_msgs::FaultActionsReport :definition-)
      "Header header

bool auto_disable_no_brakes
bool auto_disable_apply_brakes
bool dbw_can_gateway_disable
bool inverter_cnt_control_disable
bool prevent_enter_auto_mode
bool warn_driver_only
bool chime_fcw_beeps

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



(provide :dbw_pacifica_msgs/FaultActionsReport "c21ae693be0418da6826534ee549449c")


