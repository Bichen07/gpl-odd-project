;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::BrakeReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'BrakeReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::BRAKEREPORT")
  (make-package "DBW_PACIFICA_MSGS::BRAKEREPORT"))

(in-package "ROS")
;;//! \htmlinclude BrakeReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::BrakeReport
  :super ros::object
  :slots (_header _pedal_position _pedal_output _enabled _driver_activity _fault_brake_system _fault_ch1 _fault_ch2 _rolling_counter _brake_torque_actual _intervention_active _intervention_ready _parking_brake _control_type ))

(defmethod dbw_pacifica_msgs::BrakeReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pedal_position __pedal_position) 0.0)
    ((:pedal_output __pedal_output) 0.0)
    ((:enabled __enabled) nil)
    ((:driver_activity __driver_activity) nil)
    ((:fault_brake_system __fault_brake_system) nil)
    ((:fault_ch1 __fault_ch1) nil)
    ((:fault_ch2 __fault_ch2) nil)
    ((:rolling_counter __rolling_counter) 0)
    ((:brake_torque_actual __brake_torque_actual) 0.0)
    ((:intervention_active __intervention_active) nil)
    ((:intervention_ready __intervention_ready) nil)
    ((:parking_brake __parking_brake) (instance dbw_pacifica_msgs::ParkingBrake :init))
    ((:control_type __control_type) (instance dbw_pacifica_msgs::ActuatorControlMode :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _pedal_position (float __pedal_position))
   (setq _pedal_output (float __pedal_output))
   (setq _enabled __enabled)
   (setq _driver_activity __driver_activity)
   (setq _fault_brake_system __fault_brake_system)
   (setq _fault_ch1 __fault_ch1)
   (setq _fault_ch2 __fault_ch2)
   (setq _rolling_counter (round __rolling_counter))
   (setq _brake_torque_actual (float __brake_torque_actual))
   (setq _intervention_active __intervention_active)
   (setq _intervention_ready __intervention_ready)
   (setq _parking_brake __parking_brake)
   (setq _control_type __control_type)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:pedal_position
   (&optional __pedal_position)
   (if __pedal_position (setq _pedal_position __pedal_position)) _pedal_position)
  (:pedal_output
   (&optional __pedal_output)
   (if __pedal_output (setq _pedal_output __pedal_output)) _pedal_output)
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:driver_activity
   (&optional __driver_activity)
   (if __driver_activity (setq _driver_activity __driver_activity)) _driver_activity)
  (:fault_brake_system
   (&optional __fault_brake_system)
   (if __fault_brake_system (setq _fault_brake_system __fault_brake_system)) _fault_brake_system)
  (:fault_ch1
   (&optional __fault_ch1)
   (if __fault_ch1 (setq _fault_ch1 __fault_ch1)) _fault_ch1)
  (:fault_ch2
   (&optional __fault_ch2)
   (if __fault_ch2 (setq _fault_ch2 __fault_ch2)) _fault_ch2)
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:brake_torque_actual
   (&optional __brake_torque_actual)
   (if __brake_torque_actual (setq _brake_torque_actual __brake_torque_actual)) _brake_torque_actual)
  (:intervention_active
   (&optional __intervention_active)
   (if __intervention_active (setq _intervention_active __intervention_active)) _intervention_active)
  (:intervention_ready
   (&optional __intervention_ready)
   (if __intervention_ready (setq _intervention_ready __intervention_ready)) _intervention_ready)
  (:parking_brake
   (&rest __parking_brake)
   (if (keywordp (car __parking_brake))
       (send* _parking_brake __parking_brake)
     (progn
       (if __parking_brake (setq _parking_brake (car __parking_brake)))
       _parking_brake)))
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
    ;; float32 _pedal_position
    4
    ;; float32 _pedal_output
    4
    ;; bool _enabled
    1
    ;; bool _driver_activity
    1
    ;; bool _fault_brake_system
    1
    ;; bool _fault_ch1
    1
    ;; bool _fault_ch2
    1
    ;; uint8 _rolling_counter
    1
    ;; float32 _brake_torque_actual
    4
    ;; bool _intervention_active
    1
    ;; bool _intervention_ready
    1
    ;; dbw_pacifica_msgs/ParkingBrake _parking_brake
    (send _parking_brake :serialization-length)
    ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
    (send _control_type :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _pedal_position
       (sys::poke _pedal_position (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pedal_output
       (sys::poke _pedal_output (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;; bool _driver_activity
       (if _driver_activity (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_brake_system
       (if _fault_brake_system (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_ch1
       (if _fault_ch1 (write-byte -1 s) (write-byte 0 s))
     ;; bool _fault_ch2
       (if _fault_ch2 (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; float32 _brake_torque_actual
       (sys::poke _brake_torque_actual (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _intervention_active
       (if _intervention_active (write-byte -1 s) (write-byte 0 s))
     ;; bool _intervention_ready
       (if _intervention_ready (write-byte -1 s) (write-byte 0 s))
     ;; dbw_pacifica_msgs/ParkingBrake _parking_brake
       (send _parking_brake :serialize s)
     ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
       (send _control_type :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _pedal_position
     (setq _pedal_position (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pedal_output
     (setq _pedal_output (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _driver_activity
     (setq _driver_activity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_brake_system
     (setq _fault_brake_system (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_ch1
     (setq _fault_ch1 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fault_ch2
     (setq _fault_ch2 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _brake_torque_actual
     (setq _brake_torque_actual (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _intervention_active
     (setq _intervention_active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _intervention_ready
     (setq _intervention_ready (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; dbw_pacifica_msgs/ParkingBrake _parking_brake
     (send _parking_brake :deserialize buf ptr-) (incf ptr- (send _parking_brake :serialization-length))
   ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
     (send _control_type :deserialize buf ptr-) (incf ptr- (send _control_type :serialization-length))
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::BrakeReport :md5sum-) "c23e437775db686330778b5ba5b0b41b")
(setf (get dbw_pacifica_msgs::BrakeReport :datatype-) "dbw_pacifica_msgs/BrakeReport")
(setf (get dbw_pacifica_msgs::BrakeReport :definition-)
      "Header header

# Brake pedal (%)
float32 pedal_position
float32 pedal_output

# Status
bool enabled  # Enabled
bool driver_activity   # Driver activity

bool fault_brake_system

# Faults
bool fault_ch1
bool fault_ch2

uint8 rolling_counter

float32 brake_torque_actual # 0 to 100%

# Anti-lock Brakes and  Stability Control
bool intervention_active
bool intervention_ready

# Parking Brake
ParkingBrake parking_brake

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
MSG: dbw_pacifica_msgs/ParkingBrake
uint8 status

uint8 RESERVED=0
uint8 OFF=1
uint8 ON=2
uint8 FAULT=3

================================================================================
MSG: dbw_pacifica_msgs/ActuatorControlMode
uint8 value

uint8 open_loop = 0
uint8 closed_loop_actuator = 1
uint8 closed_loop_vehicle = 2
uint8 none = 255
")



(provide :dbw_pacifica_msgs/BrakeReport "c23e437775db686330778b5ba5b0b41b")


