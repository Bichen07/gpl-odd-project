;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficLightStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficLightStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS")
  (make-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*RED*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*RED* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*RED* 1)
(intern "*GREEN*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*GREEN* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*GREEN* 2)
(intern "*YELLOW*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*YELLOW* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*YELLOW* 3)
(intern "*STRAIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*STRAIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*STRAIGHT* 4)
(intern "*RED_LEFT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*RED_LEFT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*RED_LEFT* 5)
(intern "*RED_RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*RED_RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*RED_RIGHT* 6)
(intern "*RED_LEFT_RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*RED_LEFT_RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*RED_LEFT_RIGHT* 7)
(intern "*STRAIGHT_LEFT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*STRAIGHT_LEFT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*STRAIGHT_LEFT* 8)
(intern "*STRAIGHT_RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*STRAIGHT_RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*STRAIGHT_RIGHT* 9)
(intern "*STRAIGHT_LEFT_RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*STRAIGHT_LEFT_RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*STRAIGHT_LEFT_RIGHT* 10)
(intern "*LEFT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*LEFT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*LEFT* 11)
(intern "*RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*RIGHT* 12)
(intern "*LEFT_RIGHT*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*LEFT_RIGHT* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*LEFT_RIGHT* 13)
(intern "*FLASH_RED*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*FLASH_RED* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*FLASH_RED* 14)
(intern "*FLASH_YELLOW*" (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(shadow '*FLASH_YELLOW* (find-package "ITRI_MSGS::TRAFFICLIGHTSTATUS"))
(defconstant itri_msgs::TrafficLightStatus::*FLASH_YELLOW* 15)
(defclass itri_msgs::TrafficLightStatus
  :super ros::object
  :slots (_header ))

(defmethod itri_msgs::TrafficLightStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    )
   (send-super :init)
   (setq _header __header)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::TrafficLightStatus :md5sum-) "e50a875585f97d23b2d45a1f01d9e6d9")
(setf (get itri_msgs::TrafficLightStatus :datatype-) "itri_msgs/TrafficLightStatus")
(setf (get itri_msgs::TrafficLightStatus :definition-)
      "Header header

uint8 RED = 1
uint8 GREEN = 2
uint8 YELLOW = 3
uint8 STRAIGHT = 4
uint8 RED_LEFT = 5
uint8 RED_RIGHT = 6
uint8 RED_LEFT_RIGHT = 7
uint8 STRAIGHT_LEFT = 8
uint8 STRAIGHT_RIGHT = 9
uint8 STRAIGHT_LEFT_RIGHT = 10
uint8 LEFT = 11
uint8 RIGHT = 12
uint8 LEFT_RIGHT = 13
uint8 FLASH_RED = 14
uint8 FLASH_YELLOW = 15

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



(provide :itri_msgs/TrafficLightStatus "e50a875585f97d23b2d45a1f01d9e6d9")


