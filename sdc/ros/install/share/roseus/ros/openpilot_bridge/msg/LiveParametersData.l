;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveParametersData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveParametersData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVEPARAMETERSDATA")
  (make-package "OPENPILOT_BRIDGE::LIVEPARAMETERSDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveParametersData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveParametersData
  :super ros::object
  :slots (_header _steerRatio _sensorValid _stiffnessFactor _posenetValid _angleOffset _yawRate _gyroBias _valid _posenetSpeed _angleOffsetAverage ))

(defmethod openpilot_bridge::LiveParametersData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:steerRatio __steerRatio) 0.0)
    ((:sensorValid __sensorValid) nil)
    ((:stiffnessFactor __stiffnessFactor) 0.0)
    ((:posenetValid __posenetValid) nil)
    ((:angleOffset __angleOffset) 0.0)
    ((:yawRate __yawRate) 0.0)
    ((:gyroBias __gyroBias) 0.0)
    ((:valid __valid) nil)
    ((:posenetSpeed __posenetSpeed) 0.0)
    ((:angleOffsetAverage __angleOffsetAverage) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _steerRatio (float __steerRatio))
   (setq _sensorValid __sensorValid)
   (setq _stiffnessFactor (float __stiffnessFactor))
   (setq _posenetValid __posenetValid)
   (setq _angleOffset (float __angleOffset))
   (setq _yawRate (float __yawRate))
   (setq _gyroBias (float __gyroBias))
   (setq _valid __valid)
   (setq _posenetSpeed (float __posenetSpeed))
   (setq _angleOffsetAverage (float __angleOffsetAverage))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:steerRatio
   (&optional __steerRatio)
   (if __steerRatio (setq _steerRatio __steerRatio)) _steerRatio)
  (:sensorValid
   (&optional __sensorValid)
   (if __sensorValid (setq _sensorValid __sensorValid)) _sensorValid)
  (:stiffnessFactor
   (&optional __stiffnessFactor)
   (if __stiffnessFactor (setq _stiffnessFactor __stiffnessFactor)) _stiffnessFactor)
  (:posenetValid
   (&optional __posenetValid)
   (if __posenetValid (setq _posenetValid __posenetValid)) _posenetValid)
  (:angleOffset
   (&optional __angleOffset)
   (if __angleOffset (setq _angleOffset __angleOffset)) _angleOffset)
  (:yawRate
   (&optional __yawRate)
   (if __yawRate (setq _yawRate __yawRate)) _yawRate)
  (:gyroBias
   (&optional __gyroBias)
   (if __gyroBias (setq _gyroBias __gyroBias)) _gyroBias)
  (:valid
   (&optional __valid)
   (if __valid (setq _valid __valid)) _valid)
  (:posenetSpeed
   (&optional __posenetSpeed)
   (if __posenetSpeed (setq _posenetSpeed __posenetSpeed)) _posenetSpeed)
  (:angleOffsetAverage
   (&optional __angleOffsetAverage)
   (if __angleOffsetAverage (setq _angleOffsetAverage __angleOffsetAverage)) _angleOffsetAverage)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _steerRatio
    4
    ;; bool _sensorValid
    1
    ;; float32 _stiffnessFactor
    4
    ;; bool _posenetValid
    1
    ;; float32 _angleOffset
    4
    ;; float32 _yawRate
    4
    ;; float32 _gyroBias
    4
    ;; bool _valid
    1
    ;; float32 _posenetSpeed
    4
    ;; float32 _angleOffsetAverage
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _steerRatio
       (sys::poke _steerRatio (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _sensorValid
       (if _sensorValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _stiffnessFactor
       (sys::poke _stiffnessFactor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _posenetValid
       (if _posenetValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _angleOffset
       (sys::poke _angleOffset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yawRate
       (sys::poke _yawRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gyroBias
       (sys::poke _gyroBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _valid
       (if _valid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _posenetSpeed
       (sys::poke _posenetSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleOffsetAverage
       (sys::poke _angleOffsetAverage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _steerRatio
     (setq _steerRatio (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _sensorValid
     (setq _sensorValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _stiffnessFactor
     (setq _stiffnessFactor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _posenetValid
     (setq _posenetValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _angleOffset
     (setq _angleOffset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yawRate
     (setq _yawRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gyroBias
     (setq _gyroBias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _valid
     (setq _valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _posenetSpeed
     (setq _posenetSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleOffsetAverage
     (setq _angleOffsetAverage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveParametersData :md5sum-) "2c7f16316c870354eebb72d972911e81")
(setf (get openpilot_bridge::LiveParametersData :datatype-) "openpilot_bridge/LiveParametersData")
(setf (get openpilot_bridge::LiveParametersData :definition-)
      "Header header

float32 steerRatio
bool sensorValid
float32 stiffnessFactor
bool posenetValid
float32 angleOffset
float32 yawRate
float32 gyroBias
bool valid
float32 posenetSpeed
float32 angleOffsetAverage

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



(provide :openpilot_bridge/LiveParametersData "2c7f16316c870354eebb72d972911e81")


