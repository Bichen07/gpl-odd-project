;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::HUDControl)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'HUDControl (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::HUDCONTROL")
  (make-package "OPENPILOT_BRIDGE::HUDCONTROL"))

(in-package "ROS")
;;//! \htmlinclude HUDControl.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::HUDControl
  :super ros::object
  :slots (_header _leadVisible _setSpeed _leftLaneDepart _lanesVisible _leftLaneVisible _visualAlert _audibleAlert _speedVisible _rightLaneVisible _rightLaneDepart ))

(defmethod openpilot_bridge::HUDControl
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:leadVisible __leadVisible) nil)
    ((:setSpeed __setSpeed) 0.0)
    ((:leftLaneDepart __leftLaneDepart) nil)
    ((:lanesVisible __lanesVisible) nil)
    ((:leftLaneVisible __leftLaneVisible) nil)
    ((:visualAlert __visualAlert) 0)
    ((:audibleAlert __audibleAlert) 0)
    ((:speedVisible __speedVisible) nil)
    ((:rightLaneVisible __rightLaneVisible) nil)
    ((:rightLaneDepart __rightLaneDepart) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _leadVisible __leadVisible)
   (setq _setSpeed (float __setSpeed))
   (setq _leftLaneDepart __leftLaneDepart)
   (setq _lanesVisible __lanesVisible)
   (setq _leftLaneVisible __leftLaneVisible)
   (setq _visualAlert (round __visualAlert))
   (setq _audibleAlert (round __audibleAlert))
   (setq _speedVisible __speedVisible)
   (setq _rightLaneVisible __rightLaneVisible)
   (setq _rightLaneDepart __rightLaneDepart)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:leadVisible
   (&optional __leadVisible)
   (if __leadVisible (setq _leadVisible __leadVisible)) _leadVisible)
  (:setSpeed
   (&optional __setSpeed)
   (if __setSpeed (setq _setSpeed __setSpeed)) _setSpeed)
  (:leftLaneDepart
   (&optional __leftLaneDepart)
   (if __leftLaneDepart (setq _leftLaneDepart __leftLaneDepart)) _leftLaneDepart)
  (:lanesVisible
   (&optional __lanesVisible)
   (if __lanesVisible (setq _lanesVisible __lanesVisible)) _lanesVisible)
  (:leftLaneVisible
   (&optional __leftLaneVisible)
   (if __leftLaneVisible (setq _leftLaneVisible __leftLaneVisible)) _leftLaneVisible)
  (:visualAlert
   (&optional __visualAlert)
   (if __visualAlert (setq _visualAlert __visualAlert)) _visualAlert)
  (:audibleAlert
   (&optional __audibleAlert)
   (if __audibleAlert (setq _audibleAlert __audibleAlert)) _audibleAlert)
  (:speedVisible
   (&optional __speedVisible)
   (if __speedVisible (setq _speedVisible __speedVisible)) _speedVisible)
  (:rightLaneVisible
   (&optional __rightLaneVisible)
   (if __rightLaneVisible (setq _rightLaneVisible __rightLaneVisible)) _rightLaneVisible)
  (:rightLaneDepart
   (&optional __rightLaneDepart)
   (if __rightLaneDepart (setq _rightLaneDepart __rightLaneDepart)) _rightLaneDepart)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _leadVisible
    1
    ;; float32 _setSpeed
    4
    ;; bool _leftLaneDepart
    1
    ;; bool _lanesVisible
    1
    ;; bool _leftLaneVisible
    1
    ;; uint32 _visualAlert
    4
    ;; uint32 _audibleAlert
    4
    ;; bool _speedVisible
    1
    ;; bool _rightLaneVisible
    1
    ;; bool _rightLaneDepart
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _leadVisible
       (if _leadVisible (write-byte -1 s) (write-byte 0 s))
     ;; float32 _setSpeed
       (sys::poke _setSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _leftLaneDepart
       (if _leftLaneDepart (write-byte -1 s) (write-byte 0 s))
     ;; bool _lanesVisible
       (if _lanesVisible (write-byte -1 s) (write-byte 0 s))
     ;; bool _leftLaneVisible
       (if _leftLaneVisible (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _visualAlert
       (write-long _visualAlert s)
     ;; uint32 _audibleAlert
       (write-long _audibleAlert s)
     ;; bool _speedVisible
       (if _speedVisible (write-byte -1 s) (write-byte 0 s))
     ;; bool _rightLaneVisible
       (if _rightLaneVisible (write-byte -1 s) (write-byte 0 s))
     ;; bool _rightLaneDepart
       (if _rightLaneDepart (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _leadVisible
     (setq _leadVisible (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _setSpeed
     (setq _setSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _leftLaneDepart
     (setq _leftLaneDepart (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lanesVisible
     (setq _lanesVisible (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _leftLaneVisible
     (setq _leftLaneVisible (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _visualAlert
     (setq _visualAlert (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _audibleAlert
     (setq _audibleAlert (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _speedVisible
     (setq _speedVisible (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rightLaneVisible
     (setq _rightLaneVisible (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rightLaneDepart
     (setq _rightLaneDepart (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::HUDControl :md5sum-) "fae5883e88a08288a6e7673c35bc1b32")
(setf (get openpilot_bridge::HUDControl :datatype-) "openpilot_bridge/HUDControl")
(setf (get openpilot_bridge::HUDControl :definition-)
      "Header header

bool leadVisible
float32 setSpeed
bool leftLaneDepart
bool lanesVisible
bool leftLaneVisible
uint32 visualAlert # enum const: VisualAlert
uint32 audibleAlert # enum const: AudibleAlert
bool speedVisible
bool rightLaneVisible
bool rightLaneDepart

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



(provide :openpilot_bridge/HUDControl "fae5883e88a08288a6e7673c35bc1b32")


