;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::OpenDoorCmd)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'OpenDoorCmd (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::OPENDOORCMD")
  (make-package "ITRI_MSGS::OPENDOORCMD"))

(in-package "ROS")
;;//! \htmlinclude OpenDoorCmd.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*CLOSE*" (find-package "ITRI_MSGS::OPENDOORCMD"))
(shadow '*CLOSE* (find-package "ITRI_MSGS::OPENDOORCMD"))
(defconstant itri_msgs::OpenDoorCmd::*CLOSE* 0)
(intern "*OPEN*" (find-package "ITRI_MSGS::OPENDOORCMD"))
(shadow '*OPEN* (find-package "ITRI_MSGS::OPENDOORCMD"))
(defconstant itri_msgs::OpenDoorCmd::*OPEN* 1)
(defclass itri_msgs::OpenDoorCmd
  :super ros::object
  :slots (_header _left_door _right_door _lift_gate ))

(defmethod itri_msgs::OpenDoorCmd
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:left_door __left_door) 0)
    ((:right_door __right_door) 0)
    ((:lift_gate __lift_gate) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _left_door (round __left_door))
   (setq _right_door (round __right_door))
   (setq _lift_gate (round __lift_gate))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:left_door
   (&optional __left_door)
   (if __left_door (setq _left_door __left_door)) _left_door)
  (:right_door
   (&optional __right_door)
   (if __right_door (setq _right_door __right_door)) _right_door)
  (:lift_gate
   (&optional __lift_gate)
   (if __lift_gate (setq _lift_gate __lift_gate)) _lift_gate)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _left_door
    1
    ;; uint8 _right_door
    1
    ;; uint8 _lift_gate
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _left_door
       (write-byte _left_door s)
     ;; uint8 _right_door
       (write-byte _right_door s)
     ;; uint8 _lift_gate
       (write-byte _lift_gate s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _left_door
     (setq _left_door (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _right_door
     (setq _right_door (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _lift_gate
     (setq _lift_gate (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::OpenDoorCmd :md5sum-) "332bf344cd0038f6923ce7682ee1fd53")
(setf (get itri_msgs::OpenDoorCmd :datatype-) "itri_msgs/OpenDoorCmd")
(setf (get itri_msgs::OpenDoorCmd :definition-)
      "Header header

uint8 CLOSE = 0
uint8 OPEN = 1

uint8 left_door
uint8 right_door
uint8 lift_gate

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



(provide :itri_msgs/OpenDoorCmd "332bf344cd0038f6923ce7682ee1fd53")


