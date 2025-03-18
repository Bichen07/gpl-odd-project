;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::UserInputReport)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'UserInputReport (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::USERINPUTREPORT")
  (make-package "ITRI_MSGS::USERINPUTREPORT"))

(in-package "ROS")
;;//! \htmlinclude UserInputReport.msg.html
(if (not (find-package "DBW_PACIFICA_MSGS"))
  (ros::roseus-add-msgs "dbw_pacifica_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::UserInputReport
  :super ros::object
  :slots (_header _cruise_engage_button _cruise_resume_button _doorCmd _gearCmd _hornReq _turnSignalCmd ))

(defmethod itri_msgs::UserInputReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:cruise_engage_button __cruise_engage_button) nil)
    ((:cruise_resume_button __cruise_resume_button) nil)
    ((:doorCmd __doorCmd) (instance itri_msgs::OpenDoorCmd :init))
    ((:gearCmd __gearCmd) (instance dbw_pacifica_msgs::Gear :init))
    ((:hornReq __hornReq) nil)
    ((:turnSignalCmd __turnSignalCmd) (instance itri_msgs::turn_signal_cmd :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _cruise_engage_button __cruise_engage_button)
   (setq _cruise_resume_button __cruise_resume_button)
   (setq _doorCmd __doorCmd)
   (setq _gearCmd __gearCmd)
   (setq _hornReq __hornReq)
   (setq _turnSignalCmd __turnSignalCmd)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:cruise_engage_button
   (&optional __cruise_engage_button)
   (if __cruise_engage_button (setq _cruise_engage_button __cruise_engage_button)) _cruise_engage_button)
  (:cruise_resume_button
   (&optional __cruise_resume_button)
   (if __cruise_resume_button (setq _cruise_resume_button __cruise_resume_button)) _cruise_resume_button)
  (:doorCmd
   (&rest __doorCmd)
   (if (keywordp (car __doorCmd))
       (send* _doorCmd __doorCmd)
     (progn
       (if __doorCmd (setq _doorCmd (car __doorCmd)))
       _doorCmd)))
  (:gearCmd
   (&rest __gearCmd)
   (if (keywordp (car __gearCmd))
       (send* _gearCmd __gearCmd)
     (progn
       (if __gearCmd (setq _gearCmd (car __gearCmd)))
       _gearCmd)))
  (:hornReq
   (&optional __hornReq)
   (if __hornReq (setq _hornReq __hornReq)) _hornReq)
  (:turnSignalCmd
   (&rest __turnSignalCmd)
   (if (keywordp (car __turnSignalCmd))
       (send* _turnSignalCmd __turnSignalCmd)
     (progn
       (if __turnSignalCmd (setq _turnSignalCmd (car __turnSignalCmd)))
       _turnSignalCmd)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _cruise_engage_button
    1
    ;; bool _cruise_resume_button
    1
    ;; itri_msgs/OpenDoorCmd _doorCmd
    (send _doorCmd :serialization-length)
    ;; dbw_pacifica_msgs/Gear _gearCmd
    (send _gearCmd :serialization-length)
    ;; bool _hornReq
    1
    ;; itri_msgs/turn_signal_cmd _turnSignalCmd
    (send _turnSignalCmd :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _cruise_engage_button
       (if _cruise_engage_button (write-byte -1 s) (write-byte 0 s))
     ;; bool _cruise_resume_button
       (if _cruise_resume_button (write-byte -1 s) (write-byte 0 s))
     ;; itri_msgs/OpenDoorCmd _doorCmd
       (send _doorCmd :serialize s)
     ;; dbw_pacifica_msgs/Gear _gearCmd
       (send _gearCmd :serialize s)
     ;; bool _hornReq
       (if _hornReq (write-byte -1 s) (write-byte 0 s))
     ;; itri_msgs/turn_signal_cmd _turnSignalCmd
       (send _turnSignalCmd :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _cruise_engage_button
     (setq _cruise_engage_button (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _cruise_resume_button
     (setq _cruise_resume_button (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; itri_msgs/OpenDoorCmd _doorCmd
     (send _doorCmd :deserialize buf ptr-) (incf ptr- (send _doorCmd :serialization-length))
   ;; dbw_pacifica_msgs/Gear _gearCmd
     (send _gearCmd :deserialize buf ptr-) (incf ptr- (send _gearCmd :serialization-length))
   ;; bool _hornReq
     (setq _hornReq (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; itri_msgs/turn_signal_cmd _turnSignalCmd
     (send _turnSignalCmd :deserialize buf ptr-) (incf ptr- (send _turnSignalCmd :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::UserInputReport :md5sum-) "a2e7897758032adfc464805e43cb89c4")
(setf (get itri_msgs::UserInputReport :datatype-) "itri_msgs/UserInputReport")
(setf (get itri_msgs::UserInputReport :definition-)
      "Header header

# Engage DBW
bool cruise_engage_button

# Start Self Driving when the DBW system engage
bool cruise_resume_button

# Door control
OpenDoorCmd doorCmd

# Gear control
dbw_pacifica_msgs/Gear gearCmd

# Horn control
bool hornReq

# Blinker
turn_signal_cmd turnSignalCmd

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
MSG: itri_msgs/OpenDoorCmd
Header header

uint8 CLOSE = 0
uint8 OPEN = 1

uint8 left_door
uint8 right_door
uint8 lift_gate

================================================================================
MSG: dbw_pacifica_msgs/Gear
uint8 gear

uint8 NONE=0
uint8 PARK=1
uint8 REVERSE=2
uint8 NEUTRAL=3
uint8 DRIVE=4
uint8 LOW=5

================================================================================
MSG: itri_msgs/turn_signal_cmd
Header header

uint8 NONE = 0
uint8 LEFT = 1
uint8 RIGHT = 2

uint8 turn_signal
string source

")



(provide :itri_msgs/UserInputReport "a2e7897758032adfc464805e43cb89c4")


