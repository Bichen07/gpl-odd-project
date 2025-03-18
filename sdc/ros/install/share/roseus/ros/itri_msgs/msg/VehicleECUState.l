;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::VehicleECUState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'VehicleECUState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::VEHICLEECUSTATE")
  (make-package "ITRI_MSGS::VEHICLEECUSTATE"))

(in-package "ROS")
;;//! \htmlinclude VehicleECUState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::VehicleECUState
  :super ros::object
  :slots (_header _accel_pedal_pos1 _accel_pedal_pos2 _engine_speed _engine_average_fuel_economy _engine_instantaneous_fuel_economy _engine_fuel_rate _remote_accel_pedal_pos _est_engine_power_kw _total_vehicle_distance _trip_distance _actual_engine_percentage_torque _act_max_available_eng_percent_torque _drivers_demand_eng_percent_torque _engine_demand_percent_torque _est_pumping_percent_torque _est_eng_prsitic_losses_percent_torque _nominal_friction_percent_torque _DPF_thermal_management_active _engine_percent_load_at_current_speed _engine_reference_torque _momntary_eng_max_power_enable_feedback _SCR_thermal_management_active _vehicle_acceleration_rate_limit_status _fuel_level1_percentage _fuel_level2_percentage ))

(defmethod itri_msgs::VehicleECUState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:accel_pedal_pos1 __accel_pedal_pos1) 0.0)
    ((:accel_pedal_pos2 __accel_pedal_pos2) 0.0)
    ((:engine_speed __engine_speed) 0.0)
    ((:engine_average_fuel_economy __engine_average_fuel_economy) 0.0)
    ((:engine_instantaneous_fuel_economy __engine_instantaneous_fuel_economy) 0.0)
    ((:engine_fuel_rate __engine_fuel_rate) 0.0)
    ((:remote_accel_pedal_pos __remote_accel_pedal_pos) 0.0)
    ((:est_engine_power_kw __est_engine_power_kw) 0.0)
    ((:total_vehicle_distance __total_vehicle_distance) 0.0)
    ((:trip_distance __trip_distance) 0.0)
    ((:actual_engine_percentage_torque __actual_engine_percentage_torque) 0)
    ((:act_max_available_eng_percent_torque __act_max_available_eng_percent_torque) 0)
    ((:drivers_demand_eng_percent_torque __drivers_demand_eng_percent_torque) 0)
    ((:engine_demand_percent_torque __engine_demand_percent_torque) 0)
    ((:est_pumping_percent_torque __est_pumping_percent_torque) 0)
    ((:est_eng_prsitic_losses_percent_torque __est_eng_prsitic_losses_percent_torque) 0)
    ((:nominal_friction_percent_torque __nominal_friction_percent_torque) 0)
    ((:DPF_thermal_management_active __DPF_thermal_management_active) 0)
    ((:engine_percent_load_at_current_speed __engine_percent_load_at_current_speed) 0)
    ((:engine_reference_torque __engine_reference_torque) 0)
    ((:momntary_eng_max_power_enable_feedback __momntary_eng_max_power_enable_feedback) 0)
    ((:SCR_thermal_management_active __SCR_thermal_management_active) 0)
    ((:vehicle_acceleration_rate_limit_status __vehicle_acceleration_rate_limit_status) 0)
    ((:fuel_level1_percentage __fuel_level1_percentage) 0)
    ((:fuel_level2_percentage __fuel_level2_percentage) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _accel_pedal_pos1 (float __accel_pedal_pos1))
   (setq _accel_pedal_pos2 (float __accel_pedal_pos2))
   (setq _engine_speed (float __engine_speed))
   (setq _engine_average_fuel_economy (float __engine_average_fuel_economy))
   (setq _engine_instantaneous_fuel_economy (float __engine_instantaneous_fuel_economy))
   (setq _engine_fuel_rate (float __engine_fuel_rate))
   (setq _remote_accel_pedal_pos (float __remote_accel_pedal_pos))
   (setq _est_engine_power_kw (float __est_engine_power_kw))
   (setq _total_vehicle_distance (float __total_vehicle_distance))
   (setq _trip_distance (float __trip_distance))
   (setq _actual_engine_percentage_torque (round __actual_engine_percentage_torque))
   (setq _act_max_available_eng_percent_torque (round __act_max_available_eng_percent_torque))
   (setq _drivers_demand_eng_percent_torque (round __drivers_demand_eng_percent_torque))
   (setq _engine_demand_percent_torque (round __engine_demand_percent_torque))
   (setq _est_pumping_percent_torque (round __est_pumping_percent_torque))
   (setq _est_eng_prsitic_losses_percent_torque (round __est_eng_prsitic_losses_percent_torque))
   (setq _nominal_friction_percent_torque (round __nominal_friction_percent_torque))
   (setq _DPF_thermal_management_active (round __DPF_thermal_management_active))
   (setq _engine_percent_load_at_current_speed (round __engine_percent_load_at_current_speed))
   (setq _engine_reference_torque (round __engine_reference_torque))
   (setq _momntary_eng_max_power_enable_feedback (round __momntary_eng_max_power_enable_feedback))
   (setq _SCR_thermal_management_active (round __SCR_thermal_management_active))
   (setq _vehicle_acceleration_rate_limit_status (round __vehicle_acceleration_rate_limit_status))
   (setq _fuel_level1_percentage (round __fuel_level1_percentage))
   (setq _fuel_level2_percentage (round __fuel_level2_percentage))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:accel_pedal_pos1
   (&optional __accel_pedal_pos1)
   (if __accel_pedal_pos1 (setq _accel_pedal_pos1 __accel_pedal_pos1)) _accel_pedal_pos1)
  (:accel_pedal_pos2
   (&optional __accel_pedal_pos2)
   (if __accel_pedal_pos2 (setq _accel_pedal_pos2 __accel_pedal_pos2)) _accel_pedal_pos2)
  (:engine_speed
   (&optional __engine_speed)
   (if __engine_speed (setq _engine_speed __engine_speed)) _engine_speed)
  (:engine_average_fuel_economy
   (&optional __engine_average_fuel_economy)
   (if __engine_average_fuel_economy (setq _engine_average_fuel_economy __engine_average_fuel_economy)) _engine_average_fuel_economy)
  (:engine_instantaneous_fuel_economy
   (&optional __engine_instantaneous_fuel_economy)
   (if __engine_instantaneous_fuel_economy (setq _engine_instantaneous_fuel_economy __engine_instantaneous_fuel_economy)) _engine_instantaneous_fuel_economy)
  (:engine_fuel_rate
   (&optional __engine_fuel_rate)
   (if __engine_fuel_rate (setq _engine_fuel_rate __engine_fuel_rate)) _engine_fuel_rate)
  (:remote_accel_pedal_pos
   (&optional __remote_accel_pedal_pos)
   (if __remote_accel_pedal_pos (setq _remote_accel_pedal_pos __remote_accel_pedal_pos)) _remote_accel_pedal_pos)
  (:est_engine_power_kw
   (&optional __est_engine_power_kw)
   (if __est_engine_power_kw (setq _est_engine_power_kw __est_engine_power_kw)) _est_engine_power_kw)
  (:total_vehicle_distance
   (&optional __total_vehicle_distance)
   (if __total_vehicle_distance (setq _total_vehicle_distance __total_vehicle_distance)) _total_vehicle_distance)
  (:trip_distance
   (&optional __trip_distance)
   (if __trip_distance (setq _trip_distance __trip_distance)) _trip_distance)
  (:actual_engine_percentage_torque
   (&optional __actual_engine_percentage_torque)
   (if __actual_engine_percentage_torque (setq _actual_engine_percentage_torque __actual_engine_percentage_torque)) _actual_engine_percentage_torque)
  (:act_max_available_eng_percent_torque
   (&optional __act_max_available_eng_percent_torque)
   (if __act_max_available_eng_percent_torque (setq _act_max_available_eng_percent_torque __act_max_available_eng_percent_torque)) _act_max_available_eng_percent_torque)
  (:drivers_demand_eng_percent_torque
   (&optional __drivers_demand_eng_percent_torque)
   (if __drivers_demand_eng_percent_torque (setq _drivers_demand_eng_percent_torque __drivers_demand_eng_percent_torque)) _drivers_demand_eng_percent_torque)
  (:engine_demand_percent_torque
   (&optional __engine_demand_percent_torque)
   (if __engine_demand_percent_torque (setq _engine_demand_percent_torque __engine_demand_percent_torque)) _engine_demand_percent_torque)
  (:est_pumping_percent_torque
   (&optional __est_pumping_percent_torque)
   (if __est_pumping_percent_torque (setq _est_pumping_percent_torque __est_pumping_percent_torque)) _est_pumping_percent_torque)
  (:est_eng_prsitic_losses_percent_torque
   (&optional __est_eng_prsitic_losses_percent_torque)
   (if __est_eng_prsitic_losses_percent_torque (setq _est_eng_prsitic_losses_percent_torque __est_eng_prsitic_losses_percent_torque)) _est_eng_prsitic_losses_percent_torque)
  (:nominal_friction_percent_torque
   (&optional __nominal_friction_percent_torque)
   (if __nominal_friction_percent_torque (setq _nominal_friction_percent_torque __nominal_friction_percent_torque)) _nominal_friction_percent_torque)
  (:DPF_thermal_management_active
   (&optional __DPF_thermal_management_active)
   (if __DPF_thermal_management_active (setq _DPF_thermal_management_active __DPF_thermal_management_active)) _DPF_thermal_management_active)
  (:engine_percent_load_at_current_speed
   (&optional __engine_percent_load_at_current_speed)
   (if __engine_percent_load_at_current_speed (setq _engine_percent_load_at_current_speed __engine_percent_load_at_current_speed)) _engine_percent_load_at_current_speed)
  (:engine_reference_torque
   (&optional __engine_reference_torque)
   (if __engine_reference_torque (setq _engine_reference_torque __engine_reference_torque)) _engine_reference_torque)
  (:momntary_eng_max_power_enable_feedback
   (&optional __momntary_eng_max_power_enable_feedback)
   (if __momntary_eng_max_power_enable_feedback (setq _momntary_eng_max_power_enable_feedback __momntary_eng_max_power_enable_feedback)) _momntary_eng_max_power_enable_feedback)
  (:SCR_thermal_management_active
   (&optional __SCR_thermal_management_active)
   (if __SCR_thermal_management_active (setq _SCR_thermal_management_active __SCR_thermal_management_active)) _SCR_thermal_management_active)
  (:vehicle_acceleration_rate_limit_status
   (&optional __vehicle_acceleration_rate_limit_status)
   (if __vehicle_acceleration_rate_limit_status (setq _vehicle_acceleration_rate_limit_status __vehicle_acceleration_rate_limit_status)) _vehicle_acceleration_rate_limit_status)
  (:fuel_level1_percentage
   (&optional __fuel_level1_percentage)
   (if __fuel_level1_percentage (setq _fuel_level1_percentage __fuel_level1_percentage)) _fuel_level1_percentage)
  (:fuel_level2_percentage
   (&optional __fuel_level2_percentage)
   (if __fuel_level2_percentage (setq _fuel_level2_percentage __fuel_level2_percentage)) _fuel_level2_percentage)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _accel_pedal_pos1
    4
    ;; float32 _accel_pedal_pos2
    4
    ;; float32 _engine_speed
    4
    ;; float32 _engine_average_fuel_economy
    4
    ;; float32 _engine_instantaneous_fuel_economy
    4
    ;; float32 _engine_fuel_rate
    4
    ;; float32 _remote_accel_pedal_pos
    4
    ;; float32 _est_engine_power_kw
    4
    ;; float32 _total_vehicle_distance
    4
    ;; float32 _trip_distance
    4
    ;; int8 _actual_engine_percentage_torque
    1
    ;; int8 _act_max_available_eng_percent_torque
    1
    ;; int8 _drivers_demand_eng_percent_torque
    1
    ;; int8 _engine_demand_percent_torque
    1
    ;; int8 _est_pumping_percent_torque
    1
    ;; int8 _est_eng_prsitic_losses_percent_torque
    1
    ;; int8 _nominal_friction_percent_torque
    1
    ;; uint8 _DPF_thermal_management_active
    1
    ;; uint8 _engine_percent_load_at_current_speed
    1
    ;; uint8 _engine_reference_torque
    1
    ;; uint8 _momntary_eng_max_power_enable_feedback
    1
    ;; uint8 _SCR_thermal_management_active
    1
    ;; uint8 _vehicle_acceleration_rate_limit_status
    1
    ;; uint8 _fuel_level1_percentage
    1
    ;; uint8 _fuel_level2_percentage
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _accel_pedal_pos1
       (sys::poke _accel_pedal_pos1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accel_pedal_pos2
       (sys::poke _accel_pedal_pos2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _engine_speed
       (sys::poke _engine_speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _engine_average_fuel_economy
       (sys::poke _engine_average_fuel_economy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _engine_instantaneous_fuel_economy
       (sys::poke _engine_instantaneous_fuel_economy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _engine_fuel_rate
       (sys::poke _engine_fuel_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _remote_accel_pedal_pos
       (sys::poke _remote_accel_pedal_pos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _est_engine_power_kw
       (sys::poke _est_engine_power_kw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _total_vehicle_distance
       (sys::poke _total_vehicle_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _trip_distance
       (sys::poke _trip_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int8 _actual_engine_percentage_torque
       (write-byte _actual_engine_percentage_torque s)
     ;; int8 _act_max_available_eng_percent_torque
       (write-byte _act_max_available_eng_percent_torque s)
     ;; int8 _drivers_demand_eng_percent_torque
       (write-byte _drivers_demand_eng_percent_torque s)
     ;; int8 _engine_demand_percent_torque
       (write-byte _engine_demand_percent_torque s)
     ;; int8 _est_pumping_percent_torque
       (write-byte _est_pumping_percent_torque s)
     ;; int8 _est_eng_prsitic_losses_percent_torque
       (write-byte _est_eng_prsitic_losses_percent_torque s)
     ;; int8 _nominal_friction_percent_torque
       (write-byte _nominal_friction_percent_torque s)
     ;; uint8 _DPF_thermal_management_active
       (write-byte _DPF_thermal_management_active s)
     ;; uint8 _engine_percent_load_at_current_speed
       (write-byte _engine_percent_load_at_current_speed s)
     ;; uint8 _engine_reference_torque
       (write-byte _engine_reference_torque s)
     ;; uint8 _momntary_eng_max_power_enable_feedback
       (write-byte _momntary_eng_max_power_enable_feedback s)
     ;; uint8 _SCR_thermal_management_active
       (write-byte _SCR_thermal_management_active s)
     ;; uint8 _vehicle_acceleration_rate_limit_status
       (write-byte _vehicle_acceleration_rate_limit_status s)
     ;; uint8 _fuel_level1_percentage
       (write-byte _fuel_level1_percentage s)
     ;; uint8 _fuel_level2_percentage
       (write-byte _fuel_level2_percentage s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _accel_pedal_pos1
     (setq _accel_pedal_pos1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accel_pedal_pos2
     (setq _accel_pedal_pos2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _engine_speed
     (setq _engine_speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _engine_average_fuel_economy
     (setq _engine_average_fuel_economy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _engine_instantaneous_fuel_economy
     (setq _engine_instantaneous_fuel_economy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _engine_fuel_rate
     (setq _engine_fuel_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _remote_accel_pedal_pos
     (setq _remote_accel_pedal_pos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _est_engine_power_kw
     (setq _est_engine_power_kw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _total_vehicle_distance
     (setq _total_vehicle_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _trip_distance
     (setq _trip_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int8 _actual_engine_percentage_torque
     (setq _actual_engine_percentage_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _actual_engine_percentage_torque 127) (setq _actual_engine_percentage_torque (- _actual_engine_percentage_torque 256)))
   ;; int8 _act_max_available_eng_percent_torque
     (setq _act_max_available_eng_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _act_max_available_eng_percent_torque 127) (setq _act_max_available_eng_percent_torque (- _act_max_available_eng_percent_torque 256)))
   ;; int8 _drivers_demand_eng_percent_torque
     (setq _drivers_demand_eng_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _drivers_demand_eng_percent_torque 127) (setq _drivers_demand_eng_percent_torque (- _drivers_demand_eng_percent_torque 256)))
   ;; int8 _engine_demand_percent_torque
     (setq _engine_demand_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _engine_demand_percent_torque 127) (setq _engine_demand_percent_torque (- _engine_demand_percent_torque 256)))
   ;; int8 _est_pumping_percent_torque
     (setq _est_pumping_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _est_pumping_percent_torque 127) (setq _est_pumping_percent_torque (- _est_pumping_percent_torque 256)))
   ;; int8 _est_eng_prsitic_losses_percent_torque
     (setq _est_eng_prsitic_losses_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _est_eng_prsitic_losses_percent_torque 127) (setq _est_eng_prsitic_losses_percent_torque (- _est_eng_prsitic_losses_percent_torque 256)))
   ;; int8 _nominal_friction_percent_torque
     (setq _nominal_friction_percent_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _nominal_friction_percent_torque 127) (setq _nominal_friction_percent_torque (- _nominal_friction_percent_torque 256)))
   ;; uint8 _DPF_thermal_management_active
     (setq _DPF_thermal_management_active (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _engine_percent_load_at_current_speed
     (setq _engine_percent_load_at_current_speed (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _engine_reference_torque
     (setq _engine_reference_torque (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _momntary_eng_max_power_enable_feedback
     (setq _momntary_eng_max_power_enable_feedback (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _SCR_thermal_management_active
     (setq _SCR_thermal_management_active (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _vehicle_acceleration_rate_limit_status
     (setq _vehicle_acceleration_rate_limit_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _fuel_level1_percentage
     (setq _fuel_level1_percentage (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _fuel_level2_percentage
     (setq _fuel_level2_percentage (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::VehicleECUState :md5sum-) "283d54a284611771e67b738b33b81ee0")
(setf (get itri_msgs::VehicleECUState :datatype-) "itri_msgs/VehicleECUState")
(setf (get itri_msgs::VehicleECUState :definition-)
      "Header header
float32 accel_pedal_pos1
float32 accel_pedal_pos2
float32 engine_speed
float32 engine_average_fuel_economy
float32 engine_instantaneous_fuel_economy
float32 engine_fuel_rate
float32 remote_accel_pedal_pos
float32 est_engine_power_kw
float32 total_vehicle_distance
float32 trip_distance
int8 actual_engine_percentage_torque
int8 act_max_available_eng_percent_torque
int8 drivers_demand_eng_percent_torque
int8 engine_demand_percent_torque
int8 est_pumping_percent_torque
int8 est_eng_prsitic_losses_percent_torque
int8 nominal_friction_percent_torque
uint8 DPF_thermal_management_active
uint8 engine_percent_load_at_current_speed
uint8 engine_reference_torque
uint8 momntary_eng_max_power_enable_feedback
uint8 SCR_thermal_management_active
uint8 vehicle_acceleration_rate_limit_status
uint8 fuel_level1_percentage
uint8 fuel_level2_percentage

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



(provide :itri_msgs/VehicleECUState "283d54a284611771e67b738b33b81ee0")


