;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::WheelSpeedReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'WheelSpeedReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDREPORT")
  (make-package "DBW_PACIFICA_MSGS::WHEELSPEEDREPORT"))

(in-package "ROS")
;;//! \htmlinclude WheelSpeedReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::WheelSpeedReport
  :super ros::object
  :slots (_header _front_left _front_right _rear_left _rear_right _wheel_speed_type ))

(defmethod dbw_pacifica_msgs::WheelSpeedReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:front_left __front_left) 0.0)
    ((:front_right __front_right) 0.0)
    ((:rear_left __rear_left) 0.0)
    ((:rear_right __rear_right) 0.0)
    ((:wheel_speed_type __wheel_speed_type) (instance dbw_pacifica_msgs::WheelSpeedType :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _front_left (float __front_left))
   (setq _front_right (float __front_right))
   (setq _rear_left (float __rear_left))
   (setq _rear_right (float __rear_right))
   (setq _wheel_speed_type __wheel_speed_type)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:front_left
   (&optional __front_left)
   (if __front_left (setq _front_left __front_left)) _front_left)
  (:front_right
   (&optional __front_right)
   (if __front_right (setq _front_right __front_right)) _front_right)
  (:rear_left
   (&optional __rear_left)
   (if __rear_left (setq _rear_left __rear_left)) _rear_left)
  (:rear_right
   (&optional __rear_right)
   (if __rear_right (setq _rear_right __rear_right)) _rear_right)
  (:wheel_speed_type
   (&rest __wheel_speed_type)
   (if (keywordp (car __wheel_speed_type))
       (send* _wheel_speed_type __wheel_speed_type)
     (progn
       (if __wheel_speed_type (setq _wheel_speed_type (car __wheel_speed_type)))
       _wheel_speed_type)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _front_left
    4
    ;; float32 _front_right
    4
    ;; float32 _rear_left
    4
    ;; float32 _rear_right
    4
    ;; dbw_pacifica_msgs/WheelSpeedType _wheel_speed_type
    (send _wheel_speed_type :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _front_left
       (sys::poke _front_left (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _front_right
       (sys::poke _front_right (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rear_left
       (sys::poke _rear_left (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rear_right
       (sys::poke _rear_right (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; dbw_pacifica_msgs/WheelSpeedType _wheel_speed_type
       (send _wheel_speed_type :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _front_left
     (setq _front_left (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _front_right
     (setq _front_right (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rear_left
     (setq _rear_left (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rear_right
     (setq _rear_right (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; dbw_pacifica_msgs/WheelSpeedType _wheel_speed_type
     (send _wheel_speed_type :deserialize buf ptr-) (incf ptr- (send _wheel_speed_type :serialization-length))
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::WheelSpeedReport :md5sum-) "7f27720c7c80e612329b2205902e5bba")
(setf (get dbw_pacifica_msgs::WheelSpeedReport :datatype-) "dbw_pacifica_msgs/WheelSpeedReport")
(setf (get dbw_pacifica_msgs::WheelSpeedReport :definition-)
      "Header header

# Wheel speeds (RPM or km/h or rad/sec)
float32 front_left
float32 front_right
float32 rear_left
float32 rear_right

WheelSpeedType wheel_speed_type

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
MSG: dbw_pacifica_msgs/WheelSpeedType
uint8 value

uint8 ANGULAR = 0
uint8 LINEAR = 1
")



(provide :dbw_pacifica_msgs/WheelSpeedReport "7f27720c7c80e612329b2205902e5bba")


