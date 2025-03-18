;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::MissionStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'MissionStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::MISSIONSTATUS")
  (make-package "ITRI_MSGS::MISSIONSTATUS"))

(in-package "ROS")
;;//! \htmlinclude MissionStatus.msg.html


(intern "*NORMAL*" (find-package "ITRI_MSGS::MISSIONSTATUS"))
(shadow '*NORMAL* (find-package "ITRI_MSGS::MISSIONSTATUS"))
(defconstant itri_msgs::MissionStatus::*NORMAL* 0)
(intern "*EXECUTION*" (find-package "ITRI_MSGS::MISSIONSTATUS"))
(shadow '*EXECUTION* (find-package "ITRI_MSGS::MISSIONSTATUS"))
(defconstant itri_msgs::MissionStatus::*EXECUTION* 1)
(intern "*COMPLETED*" (find-package "ITRI_MSGS::MISSIONSTATUS"))
(shadow '*COMPLETED* (find-package "ITRI_MSGS::MISSIONSTATUS"))
(defconstant itri_msgs::MissionStatus::*COMPLETED* 2)
(intern "*REQUEST*" (find-package "ITRI_MSGS::MISSIONSTATUS"))
(shadow '*REQUEST* (find-package "ITRI_MSGS::MISSIONSTATUS"))
(defconstant itri_msgs::MissionStatus::*REQUEST* 3)
(defclass itri_msgs::MissionStatus
  :super ros::object
  :slots (_status ))

(defmethod itri_msgs::MissionStatus
  (:init
   (&key
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _status (round __status))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; uint8 _status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _status
       (write-byte _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::MissionStatus :md5sum-) "5ccdbc023fd502bb7d76a7a9700fb891")
(setf (get itri_msgs::MissionStatus :datatype-) "itri_msgs/MissionStatus")
(setf (get itri_msgs::MissionStatus :definition-)
      "# exception misssion status
uint8 NORMAL = 0
uint8 EXECUTION = 1
uint8 COMPLETED = 2
uint8 REQUEST = 3

uint8 status

")



(provide :itri_msgs/MissionStatus "5ccdbc023fd502bb7d76a7a9700fb891")


