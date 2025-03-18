;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::AcceleratorPedalReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'AcceleratorPedalReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::ACCELERATORPEDALREPORT")
  (make-package "DBW_PACIFICA_MSGS::ACCELERATORPEDALREPORT"))

(in-package "ROS")
;;//! \htmlinclude AcceleratorPedalReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::AcceleratorPedalReport
  :super ros::object
  :slots (_header _pedal_input _pedal_output _enabled _ignore_driver _driver_activity _fault_accel_pedal_system _fault_ch1 _fault_ch2 _rolling_counter _torque_actual _control_type ))

(defmethod dbw_pacifica_msgs::AcceleratorPedalReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pedal_input __pedal_input) 0.0)
    ((:pedal_output __pedal_output) 0.0)
    ((:enabled __enabled) nil)
    ((:ignore_driver __ignore_driver) nil)
    ((:driver_activity __driver_activity) nil)
    ((:fault_accel_pedal_system __fault_accel_pedal_system) nil)
    ((:fault_ch1 __fault_ch1) nil)
    ((:fault_ch2 __fault_ch2) nil)
    ((:rolling_counter __rolling_counter) 0)
    ((:torque_actual __torque_actual) 0.0)
    ((:control_type __control_type) (instance dbw_pacifica_msgs::ActuatorControlMode :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _pedal_input (float __pedal_input))
   (setq _pedal_output (float __pedal_output))
   (setq _enabled __enabled)
   (setq _ignore_driver __ignore_driver)
   (setq _driver_activity __driver_activity)
   (setq _fault_accel_pedal_system __fault_accel_pedal_system)
   (setq _fault_ch1 __fault_ch1)
   (setq _fault_ch2 __fault_ch2)
   (setq _rolling_counter (round __rolling_counter))
   (setq _torque_actual (float __torque_actual))
   (setq _control_type __control_type)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:pedal_input
   (&optional __pedal_input)
   (if __pedal_input (setq _pedal_input __pedal_input)) _pedal_input)
  (:pedal_output
   (&optional __pedal_output)
   (if __pedal_output (setq _pedal_output __pedal_output)) _pedal_output)
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:ignore_driver
   (&optional __ignore_driver)
   (if __ignore_driver (setq _ignore_driver __ignore_driver)) _ignore_driver)
  (:driver_activity
   (&optional __driver_activity)
   (if __driver_activity (setq _driver_activity __driver_activity)) _driver_activity)
  (:fault_accel_pedal_system
   (&optional __fault_accel_pedal_system)
   (if __fault_accel_pedal_system (setq _fault_accel_pedal_system __fault_accel_pedal_system)) _fault_accel_pedal_system)
  (:fault_ch1
   (&optional __fault_ch1)
   (if __fault_ch1 (setq _fault_ch1 __fault_ch1)) _fault_ch1)
  (:fault_ch2
   (&optional __fault_ch2)
   (if __fault_ch2 (setq _fault_ch2 __fault_ch2)) _fault_ch2)
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:torque_actual
   (&optional __torque_actual)
   (if __torque_actual (setq _torque_actual __torque_actual)) _torque_actual)
  (:control_type
   (&rest __control_type)
   (if (keywordp (car __control_type))
       (send* _control_type __control_type)
     (progn
       (if __control_type (setq _control_type (car __control_type)))
       _control_type)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _pedal_input
    4
    ;; float32 _pedal_output
    4
    ;; bool _enabled
    1
    ;; bool _ignore_driver
    1
    ;; bool _driver_activity
    1
    ;; bool _fault_accel_pedal_system
    1
    ;; bool _fault_ch1
    1
    ;; bool _fault_ch2
    1
    ;; uint8 _rolling_counter
    1
    ;; float32 _torque_actual
    4
    ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
    (send _control_type :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _pedal_input
       (sys::poke _pedal_input (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pedal_output
       (sys::poke _pedal_output (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;; bool _ignore_driver
       (if _ignore_driver (write-byte -1 s) (write-byte 0 s))
     ;; bool _driver_activity
       (if _driver_activity (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_accel_pedal_system
       (if _fault_accel_pedal_system (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_ch1
       (if _fault_ch1 (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_ch2
       (if _fault_ch2 (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; float32 _torque_actual
       (sys::poke _torque_actual (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
       (send _control_type :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _pedal_input
     (setq _pedal_input (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pedal_output
     (setq _pedal_output (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _ignore_driver
     (setq _ignore_driver (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _driver_activity
     (setq _driver_activity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_accel_pedal_system
     (setq _fault_accel_pedal_system (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_ch1
     (setq _fault_ch1 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_ch2
     (setq _fault_ch2 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _torque_actual
     (setq _torque_actual (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
     (send _control_type :deserialize buf ptr-) (incf ptr- (send _control_type :serialization-length))
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::AcceleratorPedalReport :md5sum-) "79e5f58f94a8fa77ed7d602d29d0230c")
(setf (get dbw_pacifica_msgs::AcceleratorPedalReport :datatype-) "dbw_pacifica_msgs/AcceleratorPedalReport")
(setf (get dbw_pacifica_msgs::AcceleratorPedalReport :definition-)
      "Header header

# Accelerator pedal
# 0 to 100%
float32 pedal_input
float32 pedal_output

# Status
bool enabled
bool ignore_driver
bool driver_activity   # Driver activity

bool fault_accel_pedal_system

# Faults
bool fault_ch1
bool fault_ch2

uint8 rolling_counter

float32 torque_actual # 0 to 100%

ActuatorControlMode control_type
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
MSG: dbw_pacifica_msgs/ActuatorControlMode
uint8 value

uint8 open_loop = 0
uint8 closed_loop_actuator = 1
uint8 closed_loop_vehicle = 2
uint8 none = 255
")



(provide :dbw_pacifica_msgs/AcceleratorPedalReport "79e5f58f94a8fa77ed7d602d29d0230c")


