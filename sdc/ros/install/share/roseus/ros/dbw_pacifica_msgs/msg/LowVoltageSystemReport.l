;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::LowVoltageSystemReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'LowVoltageSystemReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::LOWVOLTAGESYSTEMREPORT")
  (make-package "DBW_PACIFICA_MSGS::LOWVOLTAGESYSTEMREPORT"))

(in-package "ROS")
;;//! \htmlinclude LowVoltageSystemReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::LowVoltageSystemReport
  :super ros::object
  :slots (_header _dbw_battery_volts _vehicle_battery_volts _vehicle_battery_current _vehicle_alternator_current _dcdc_current _alternator_current _aux_battery_contactor _aux_inverter_contactor ))

(defmethod dbw_pacifica_msgs::LowVoltageSystemReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:dbw_battery_volts __dbw_battery_volts) 0.0)
    ((:vehicle_battery_volts __vehicle_battery_volts) 0.0)
    ((:vehicle_battery_current __vehicle_battery_current) 0.0)
    ((:vehicle_alternator_current __vehicle_alternator_current) 0.0)
    ((:dcdc_current __dcdc_current) 0.0)
    ((:alternator_current __alternator_current) 0.0)
    ((:aux_battery_contactor __aux_battery_contactor) nil)
    ((:aux_inverter_contactor __aux_inverter_contactor) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _dbw_battery_volts (float __dbw_battery_volts))
   (setq _vehicle_battery_volts (float __vehicle_battery_volts))
   (setq _vehicle_battery_current (float __vehicle_battery_current))
   (setq _vehicle_alternator_current (float __vehicle_alternator_current))
   (setq _dcdc_current (float __dcdc_current))
   (setq _alternator_current (float __alternator_current))
   (setq _aux_battery_contactor __aux_battery_contactor)
   (setq _aux_inverter_contactor __aux_inverter_contactor)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:dbw_battery_volts
   (&optional __dbw_battery_volts)
   (if __dbw_battery_volts (setq _dbw_battery_volts __dbw_battery_volts)) _dbw_battery_volts)
  (:vehicle_battery_volts
   (&optional __vehicle_battery_volts)
   (if __vehicle_battery_volts (setq _vehicle_battery_volts __vehicle_battery_volts)) _vehicle_battery_volts)
  (:vehicle_battery_current
   (&optional __vehicle_battery_current)
   (if __vehicle_battery_current (setq _vehicle_battery_current __vehicle_battery_current)) _vehicle_battery_current)
  (:vehicle_alternator_current
   (&optional __vehicle_alternator_current)
   (if __vehicle_alternator_current (setq _vehicle_alternator_current __vehicle_alternator_current)) _vehicle_alternator_current)
  (:dcdc_current
   (&optional __dcdc_current)
   (if __dcdc_current (setq _dcdc_current __dcdc_current)) _dcdc_current)
  (:alternator_current
   (&optional __alternator_current)
   (if __alternator_current (setq _alternator_current __alternator_current)) _alternator_current)
  (:aux_battery_contactor
   (&optional __aux_battery_contactor)
   (if __aux_battery_contactor (setq _aux_battery_contactor __aux_battery_contactor)) _aux_battery_contactor)
  (:aux_inverter_contactor
   (&optional __aux_inverter_contactor)
   (if __aux_inverter_contactor (setq _aux_inverter_contactor __aux_inverter_contactor)) _aux_inverter_contactor)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _dbw_battery_volts
    4
    ;; float32 _vehicle_battery_volts
    4
    ;; float32 _vehicle_battery_current
    4
    ;; float32 _vehicle_alternator_current
    4
    ;; float32 _dcdc_current
    4
    ;; float32 _alternator_current
    4
    ;; bool _aux_battery_contactor
    1
    ;; bool _aux_inverter_contactor
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _dbw_battery_volts
       (sys::poke _dbw_battery_volts (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vehicle_battery_volts
       (sys::poke _vehicle_battery_volts (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vehicle_battery_current
       (sys::poke _vehicle_battery_current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vehicle_alternator_current
       (sys::poke _vehicle_alternator_current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dcdc_current
       (sys::poke _dcdc_current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _alternator_current
       (sys::poke _alternator_current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _aux_battery_contactor
       (if _aux_battery_contactor (write-byte -1 s) (write-byte 0 s))
     ;; bool _aux_inverter_contactor
       (if _aux_inverter_contactor (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _dbw_battery_volts
     (setq _dbw_battery_volts (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vehicle_battery_volts
     (setq _vehicle_battery_volts (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vehicle_battery_current
     (setq _vehicle_battery_current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vehicle_alternator_current
     (setq _vehicle_alternator_current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dcdc_current
     (setq _dcdc_current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _alternator_current
     (setq _alternator_current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _aux_battery_contactor
     (setq _aux_battery_contactor (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _aux_inverter_contactor
     (setq _aux_inverter_contactor (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::LowVoltageSystemReport :md5sum-) "c352ea40227e6ba399244c0eeed0064c")
(setf (get dbw_pacifica_msgs::LowVoltageSystemReport :datatype-) "dbw_pacifica_msgs/LowVoltageSystemReport")
(setf (get dbw_pacifica_msgs::LowVoltageSystemReport :definition-)
      "Header header

float32 dbw_battery_volts # Volts
float32 vehicle_battery_volts # Volts 
float32 vehicle_battery_current # Amps
float32 vehicle_alternator_current #Amps

float32 dcdc_current # Amps
float32 alternator_current # Amps

bool aux_battery_contactor # On/Off
bool aux_inverter_contactor # On/Off
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



(provide :dbw_pacifica_msgs/LowVoltageSystemReport "c352ea40227e6ba399244c0eeed0064c")


