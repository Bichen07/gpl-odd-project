;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::BrakeCmd)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'BrakeCmd (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::BRAKECMD")
  (make-package "DBW_PACIFICA_MSGS::BRAKECMD"))

(in-package "ROS")
;;//! \htmlinclude BrakeCmd.msg.html


(defclass dbw_pacifica_msgs::BrakeCmd
  :super ros::object
  :slots (_pedal_cmd _enable _rolling_counter _torque_cmd _accel_limit _decel_limit _control_type _brake_cmd_checksum _parking_brake_req ))

(defmethod dbw_pacifica_msgs::BrakeCmd
  (:init
   (&key
    ((:pedal_cmd __pedal_cmd) 0.0)
    ((:enable __enable) nil)
    ((:rolling_counter __rolling_counter) 0)
    ((:torque_cmd __torque_cmd) 0.0)
    ((:accel_limit __accel_limit) 0.0)
    ((:decel_limit __decel_limit) 0.0)
    ((:control_type __control_type) (instance dbw_pacifica_msgs::ActuatorControlMode :init))
    ((:brake_cmd_checksum __brake_cmd_checksum) 0.0)
    ((:parking_brake_req __parking_brake_req) (instance dbw_pacifica_msgs::ParkingBrkReq :init))
    )
   (send-super :init)
   (setq _pedal_cmd (float __pedal_cmd))
   (setq _enable __enable)
   (setq _rolling_counter (round __rolling_counter))
   (setq _torque_cmd (float __torque_cmd))
   (setq _accel_limit (float __accel_limit))
   (setq _decel_limit (float __decel_limit))
   (setq _control_type __control_type)
   (setq _brake_cmd_checksum (float __brake_cmd_checksum))
   (setq _parking_brake_req __parking_brake_req)
   self)
  (:pedal_cmd
   (&optional __pedal_cmd)
   (if __pedal_cmd (setq _pedal_cmd __pedal_cmd)) _pedal_cmd)
  (:enable
   (&optional __enable)
   (if __enable (setq _enable __enable)) _enable)
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:torque_cmd
   (&optional __torque_cmd)
   (if __torque_cmd (setq _torque_cmd __torque_cmd)) _torque_cmd)
  (:accel_limit
   (&optional __accel_limit)
   (if __accel_limit (setq _accel_limit __accel_limit)) _accel_limit)
  (:decel_limit
   (&optional __decel_limit)
   (if __decel_limit (setq _decel_limit __decel_limit)) _decel_limit)
  (:control_type
   (&rest __control_type)
   (if (keywordp (car __control_type))
       (send* _control_type __control_type)
     (progn
       (if __control_type (setq _control_type (car __control_type)))
       _control_type)))
  (:brake_cmd_checksum
   (&optional __brake_cmd_checksum)
   (if __brake_cmd_checksum (setq _brake_cmd_checksum __brake_cmd_checksum)) _brake_cmd_checksum)
  (:parking_brake_req
   (&rest __parking_brake_req)
   (if (keywordp (car __parking_brake_req))
       (send* _parking_brake_req __parking_brake_req)
     (progn
       (if __parking_brake_req (setq _parking_brake_req (car __parking_brake_req)))
       _parking_brake_req)))
  (:serialization-length
   ()
   (+
    ;; float32 _pedal_cmd
    4
    ;; bool _enable
    1
    ;; uint8 _rolling_counter
    1
    ;; float32 _torque_cmd
    4
    ;; float32 _accel_limit
    4
    ;; float32 _decel_limit
    4
    ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
    (send _control_type :serialization-length)
    ;; float32 _brake_cmd_checksum
    4
    ;; dbw_pacifica_msgs/ParkingBrkReq _parking_brake_req
    (send _parking_brake_req :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _pedal_cmd
       (sys::poke _pedal_cmd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enable
       (if _enable (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; float32 _torque_cmd
       (sys::poke _torque_cmd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accel_limit
       (sys::poke _accel_limit (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _decel_limit
       (sys::poke _decel_limit (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
       (send _control_type :serialize s)
     ;; float32 _brake_cmd_checksum
       (sys::poke _brake_cmd_checksum (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; dbw_pacifica_msgs/ParkingBrkReq _parking_brake_req
       (send _parking_brake_req :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _pedal_cmd
     (setq _pedal_cmd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enable
     (setq _enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _torque_cmd
     (setq _torque_cmd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accel_limit
     (setq _accel_limit (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _decel_limit
     (setq _decel_limit (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; dbw_pacifica_msgs/ActuatorControlMode _control_type
     (send _control_type :deserialize buf ptr-) (incf ptr- (send _control_type :serialization-length))
   ;; float32 _brake_cmd_checksum
     (setq _brake_cmd_checksum (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; dbw_pacifica_msgs/ParkingBrkReq _parking_brake_req
     (send _parking_brake_req :deserialize buf ptr-) (incf ptr- (send _parking_brake_req :serialization-length))
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::BrakeCmd :md5sum-) "df5046f02deb0972bd5ea27261595bc6")
(setf (get dbw_pacifica_msgs::BrakeCmd :datatype-) "dbw_pacifica_msgs/BrakeCmd")
(setf (get dbw_pacifica_msgs::BrakeCmd :definition-)
      "# Brake pedal (%)
float32 pedal_cmd

# Enable
bool enable

# Watchdog counter (optional)
uint8 rolling_counter

float32 torque_cmd # %-torque
float32 accel_limit # m/s^2
float32 decel_limit # m/s^2

ActuatorControlMode control_type

float32 brake_cmd_checksum

ParkingBrkReq parking_brake_req

================================================================================
MSG: dbw_pacifica_msgs/ActuatorControlMode
uint8 value

uint8 open_loop = 0
uint8 closed_loop_actuator = 1
uint8 closed_loop_vehicle = 2
uint8 none = 255
================================================================================
MSG: dbw_pacifica_msgs/ParkingBrkReq
uint8 value

uint8 NO_REQUEST=0
uint8 OFF=1
uint8 ON=2

")



(provide :dbw_pacifica_msgs/BrakeCmd "df5046f02deb0972bd5ea27261595bc6")


