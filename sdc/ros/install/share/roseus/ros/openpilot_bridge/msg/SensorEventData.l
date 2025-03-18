;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SensorEventData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SensorEventData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SENSOREVENTDATA")
  (make-package "OPENPILOT_BRIDGE::SENSOREVENTDATA"))

(in-package "ROS")
;;//! \htmlinclude SensorEventData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::SensorEventData
  :super ros::object
  :slots (_header _acceleration _gyroUncalibrated _light _orientation _pressure _sensor _magnetic _magneticUncalibrated _source _gyro _version _timestamp _type _proximity _uncalibratedDEPRECATED ))

(defmethod openpilot_bridge::SensorEventData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:acceleration __acceleration) (instance openpilot_bridge::SensorVec :init))
    ((:gyroUncalibrated __gyroUncalibrated) (instance openpilot_bridge::SensorVec :init))
    ((:light __light) 0.0)
    ((:orientation __orientation) (instance openpilot_bridge::SensorVec :init))
    ((:pressure __pressure) (instance openpilot_bridge::SensorVec :init))
    ((:sensor __sensor) 0)
    ((:magnetic __magnetic) (instance openpilot_bridge::SensorVec :init))
    ((:magneticUncalibrated __magneticUncalibrated) (instance openpilot_bridge::SensorVec :init))
    ((:source __source) 0)
    ((:gyro __gyro) (instance openpilot_bridge::SensorVec :init))
    ((:version __version) 0)
    ((:timestamp __timestamp) 0)
    ((:type __type) 0)
    ((:proximity __proximity) 0.0)
    ((:uncalibratedDEPRECATED __uncalibratedDEPRECATED) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _acceleration __acceleration)
   (setq _gyroUncalibrated __gyroUncalibrated)
   (setq _light (float __light))
   (setq _orientation __orientation)
   (setq _pressure __pressure)
   (setq _sensor (round __sensor))
   (setq _magnetic __magnetic)
   (setq _magneticUncalibrated __magneticUncalibrated)
   (setq _source (round __source))
   (setq _gyro __gyro)
   (setq _version (round __version))
   (setq _timestamp (round __timestamp))
   (setq _type (round __type))
   (setq _proximity (float __proximity))
   (setq _uncalibratedDEPRECATED __uncalibratedDEPRECATED)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:acceleration
   (&rest __acceleration)
   (if (keywordp (car __acceleration))
       (send* _acceleration __acceleration)
     (progn
       (if __acceleration (setq _acceleration (car __acceleration)))
       _acceleration)))
  (:gyroUncalibrated
   (&rest __gyroUncalibrated)
   (if (keywordp (car __gyroUncalibrated))
       (send* _gyroUncalibrated __gyroUncalibrated)
     (progn
       (if __gyroUncalibrated (setq _gyroUncalibrated (car __gyroUncalibrated)))
       _gyroUncalibrated)))
  (:light
   (&optional __light)
   (if __light (setq _light __light)) _light)
  (:orientation
   (&rest __orientation)
   (if (keywordp (car __orientation))
       (send* _orientation __orientation)
     (progn
       (if __orientation (setq _orientation (car __orientation)))
       _orientation)))
  (:pressure
   (&rest __pressure)
   (if (keywordp (car __pressure))
       (send* _pressure __pressure)
     (progn
       (if __pressure (setq _pressure (car __pressure)))
       _pressure)))
  (:sensor
   (&optional __sensor)
   (if __sensor (setq _sensor __sensor)) _sensor)
  (:magnetic
   (&rest __magnetic)
   (if (keywordp (car __magnetic))
       (send* _magnetic __magnetic)
     (progn
       (if __magnetic (setq _magnetic (car __magnetic)))
       _magnetic)))
  (:magneticUncalibrated
   (&rest __magneticUncalibrated)
   (if (keywordp (car __magneticUncalibrated))
       (send* _magneticUncalibrated __magneticUncalibrated)
     (progn
       (if __magneticUncalibrated (setq _magneticUncalibrated (car __magneticUncalibrated)))
       _magneticUncalibrated)))
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:gyro
   (&rest __gyro)
   (if (keywordp (car __gyro))
       (send* _gyro __gyro)
     (progn
       (if __gyro (setq _gyro (car __gyro)))
       _gyro)))
  (:version
   (&optional __version)
   (if __version (setq _version __version)) _version)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:proximity
   (&optional __proximity)
   (if __proximity (setq _proximity __proximity)) _proximity)
  (:uncalibratedDEPRECATED
   (&optional __uncalibratedDEPRECATED)
   (if __uncalibratedDEPRECATED (setq _uncalibratedDEPRECATED __uncalibratedDEPRECATED)) _uncalibratedDEPRECATED)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/SensorVec _acceleration
    (send _acceleration :serialization-length)
    ;; openpilot_bridge/SensorVec _gyroUncalibrated
    (send _gyroUncalibrated :serialization-length)
    ;; float32 _light
    4
    ;; openpilot_bridge/SensorVec _orientation
    (send _orientation :serialization-length)
    ;; openpilot_bridge/SensorVec _pressure
    (send _pressure :serialization-length)
    ;; int32 _sensor
    4
    ;; openpilot_bridge/SensorVec _magnetic
    (send _magnetic :serialization-length)
    ;; openpilot_bridge/SensorVec _magneticUncalibrated
    (send _magneticUncalibrated :serialization-length)
    ;; uint32 _source
    4
    ;; openpilot_bridge/SensorVec _gyro
    (send _gyro :serialization-length)
    ;; int32 _version
    4
    ;; int32 _timestamp
    4
    ;; int32 _type
    4
    ;; float32 _proximity
    4
    ;; bool _uncalibratedDEPRECATED
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/SensorVec _acceleration
       (send _acceleration :serialize s)
     ;; openpilot_bridge/SensorVec _gyroUncalibrated
       (send _gyroUncalibrated :serialize s)
     ;; float32 _light
       (sys::poke _light (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/SensorVec _orientation
       (send _orientation :serialize s)
     ;; openpilot_bridge/SensorVec _pressure
       (send _pressure :serialize s)
     ;; int32 _sensor
       (write-long _sensor s)
     ;; openpilot_bridge/SensorVec _magnetic
       (send _magnetic :serialize s)
     ;; openpilot_bridge/SensorVec _magneticUncalibrated
       (send _magneticUncalibrated :serialize s)
     ;; uint32 _source
       (write-long _source s)
     ;; openpilot_bridge/SensorVec _gyro
       (send _gyro :serialize s)
     ;; int32 _version
       (write-long _version s)
     ;; int32 _timestamp
       (write-long _timestamp s)
     ;; int32 _type
       (write-long _type s)
     ;; float32 _proximity
       (sys::poke _proximity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _uncalibratedDEPRECATED
       (if _uncalibratedDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/SensorVec _acceleration
     (send _acceleration :deserialize buf ptr-) (incf ptr- (send _acceleration :serialization-length))
   ;; openpilot_bridge/SensorVec _gyroUncalibrated
     (send _gyroUncalibrated :deserialize buf ptr-) (incf ptr- (send _gyroUncalibrated :serialization-length))
   ;; float32 _light
     (setq _light (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/SensorVec _orientation
     (send _orientation :deserialize buf ptr-) (incf ptr- (send _orientation :serialization-length))
   ;; openpilot_bridge/SensorVec _pressure
     (send _pressure :deserialize buf ptr-) (incf ptr- (send _pressure :serialization-length))
   ;; int32 _sensor
     (setq _sensor (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/SensorVec _magnetic
     (send _magnetic :deserialize buf ptr-) (incf ptr- (send _magnetic :serialization-length))
   ;; openpilot_bridge/SensorVec _magneticUncalibrated
     (send _magneticUncalibrated :deserialize buf ptr-) (incf ptr- (send _magneticUncalibrated :serialization-length))
   ;; uint32 _source
     (setq _source (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/SensorVec _gyro
     (send _gyro :deserialize buf ptr-) (incf ptr- (send _gyro :serialization-length))
   ;; int32 _version
     (setq _version (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _timestamp
     (setq _timestamp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _proximity
     (setq _proximity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _uncalibratedDEPRECATED
     (setq _uncalibratedDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::SensorEventData :md5sum-) "b716bd78256e63045fe27b6249e4a04a")
(setf (get openpilot_bridge::SensorEventData :datatype-) "openpilot_bridge/SensorEventData")
(setf (get openpilot_bridge::SensorEventData :definition-)
      "Header header

SensorVec acceleration
SensorVec gyroUncalibrated
float32 light
SensorVec orientation
SensorVec pressure
int32 sensor
SensorVec magnetic
SensorVec magneticUncalibrated
uint32 source # enum const: SensorSource
SensorVec gyro
int32 version
int32 timestamp
int32 type
float32 proximity
bool uncalibratedDEPRECATED

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
MSG: openpilot_bridge/SensorVec
Header header

int32 status
float32[] v

")



(provide :openpilot_bridge/SensorEventData "b716bd78256e63045fe27b6249e4a04a")


