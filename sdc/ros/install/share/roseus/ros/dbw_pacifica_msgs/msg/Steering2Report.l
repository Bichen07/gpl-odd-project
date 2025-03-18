;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::Steering2Report)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'Steering2Report (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::STEERING2REPORT")
  (make-package "DBW_PACIFICA_MSGS::STEERING2REPORT"))

(in-package "ROS")
;;//! \htmlinclude Steering2Report.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::Steering2Report
  :super ros::object
  :slots (_header _vehicle_curvature_actual _steer_torque_driver _steer_torque_motor ))

(defmethod dbw_pacifica_msgs::Steering2Report
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vehicle_curvature_actual __vehicle_curvature_actual) 0.0)
    ((:steer_torque_driver __steer_torque_driver) 0.0)
    ((:steer_torque_motor __steer_torque_motor) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _vehicle_curvature_actual (float __vehicle_curvature_actual))
   (setq _steer_torque_driver (float __steer_torque_driver))
   (setq _steer_torque_motor (float __steer_torque_motor))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vehicle_curvature_actual
   (&optional __vehicle_curvature_actual)
   (if __vehicle_curvature_actual (setq _vehicle_curvature_actual __vehicle_curvature_actual)) _vehicle_curvature_actual)
  (:steer_torque_driver
   (&optional __steer_torque_driver)
   (if __steer_torque_driver (setq _steer_torque_driver __steer_torque_driver)) _steer_torque_driver)
  (:steer_torque_motor
   (&optional __steer_torque_motor)
   (if __steer_torque_motor (setq _steer_torque_motor __steer_torque_motor)) _steer_torque_motor)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _vehicle_curvature_actual
    4
    ;; float32 _steer_torque_driver
    4
    ;; float32 _steer_torque_motor
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _vehicle_curvature_actual
       (sys::poke _vehicle_curvature_actual (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steer_torque_driver
       (sys::poke _steer_torque_driver (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steer_torque_motor
       (sys::poke _steer_torque_motor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _vehicle_curvature_actual
     (setq _vehicle_curvature_actual (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steer_torque_driver
     (setq _steer_torque_driver (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steer_torque_motor
     (setq _steer_torque_motor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::Steering2Report :md5sum-) "009145df632b20263fd61a2cbd47cc87")
(setf (get dbw_pacifica_msgs::Steering2Report :datatype-) "dbw_pacifica_msgs/Steering2Report")
(setf (get dbw_pacifica_msgs::Steering2Report :definition-)
      "Header header

float32 vehicle_curvature_actual # units are 1/m
float32 steer_torque_driver
float32 steer_torque_motor

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



(provide :dbw_pacifica_msgs/Steering2Report "009145df632b20263fd61a2cbd47cc87")


