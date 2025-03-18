;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LateralPIDState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LateralPIDState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALPIDSTATE")
  (make-package "OPENPILOT_BRIDGE::LATERALPIDSTATE"))

(in-package "ROS")
;;//! \htmlinclude LateralPIDState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LateralPIDState
  :super ros::object
  :slots (_header _saturated _p _steerRate _f _i _angleError _active _output _steerAngle ))

(defmethod openpilot_bridge::LateralPIDState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:saturated __saturated) nil)
    ((:p __p) 0.0)
    ((:steerRate __steerRate) 0.0)
    ((:f __f) 0.0)
    ((:i __i) 0.0)
    ((:angleError __angleError) 0.0)
    ((:active __active) nil)
    ((:output __output) 0.0)
    ((:steerAngle __steerAngle) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _saturated __saturated)
   (setq _p (float __p))
   (setq _steerRate (float __steerRate))
   (setq _f (float __f))
   (setq _i (float __i))
   (setq _angleError (float __angleError))
   (setq _active __active)
   (setq _output (float __output))
   (setq _steerAngle (float __steerAngle))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:saturated
   (&optional __saturated)
   (if __saturated (setq _saturated __saturated)) _saturated)
  (:p
   (&optional __p)
   (if __p (setq _p __p)) _p)
  (:steerRate
   (&optional __steerRate)
   (if __steerRate (setq _steerRate __steerRate)) _steerRate)
  (:f
   (&optional __f)
   (if __f (setq _f __f)) _f)
  (:i
   (&optional __i)
   (if __i (setq _i __i)) _i)
  (:angleError
   (&optional __angleError)
   (if __angleError (setq _angleError __angleError)) _angleError)
  (:active
   (&optional __active)
   (if __active (setq _active __active)) _active)
  (:output
   (&optional __output)
   (if __output (setq _output __output)) _output)
  (:steerAngle
   (&optional __steerAngle)
   (if __steerAngle (setq _steerAngle __steerAngle)) _steerAngle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _saturated
    1
    ;; float32 _p
    4
    ;; float32 _steerRate
    4
    ;; float32 _f
    4
    ;; float32 _i
    4
    ;; float32 _angleError
    4
    ;; bool _active
    1
    ;; float32 _output
    4
    ;; float32 _steerAngle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _saturated
       (if _saturated (write-byte -1 s) (write-byte 0 s))
     ;; float32 _p
       (sys::poke _p (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerRate
       (sys::poke _steerRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _f
       (sys::poke _f (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _i
       (sys::poke _i (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleError
       (sys::poke _angleError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _active
       (if _active (write-byte -1 s) (write-byte 0 s))
     ;; float32 _output
       (sys::poke _output (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerAngle
       (sys::poke _steerAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _saturated
     (setq _saturated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _p
     (setq _p (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerRate
     (setq _steerRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _f
     (setq _f (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _i
     (setq _i (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleError
     (setq _angleError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _active
     (setq _active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _output
     (setq _output (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerAngle
     (setq _steerAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LateralPIDState :md5sum-) "32371c4b3483701c1252fdf46b0c37d2")
(setf (get openpilot_bridge::LateralPIDState :datatype-) "openpilot_bridge/LateralPIDState")
(setf (get openpilot_bridge::LateralPIDState :definition-)
      "Header header

bool saturated
float32 p
float32 steerRate
float32 f
float32 i
float32 angleError
bool active
float32 output
float32 steerAngle

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



(provide :openpilot_bridge/LateralPIDState "32371c4b3483701c1252fdf46b0c37d2")


