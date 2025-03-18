;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::ParkingBrake)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'ParkingBrake (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE")
  (make-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))

(in-package "ROS")
;;//! \htmlinclude ParkingBrake.msg.html


(intern "*RESERVED*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(shadow '*RESERVED* (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(defconstant dbw_pacifica_msgs::ParkingBrake::*RESERVED* 0)
(intern "*OFF*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(shadow '*OFF* (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(defconstant dbw_pacifica_msgs::ParkingBrake::*OFF* 1)
(intern "*ON*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(shadow '*ON* (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(defconstant dbw_pacifica_msgs::ParkingBrake::*ON* 2)
(intern "*FAULT*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(shadow '*FAULT* (find-package "DBW_PACIFICA_MSGS::PARKINGBRAKE"))
(defconstant dbw_pacifica_msgs::ParkingBrake::*FAULT* 3)
(defclass dbw_pacifica_msgs::ParkingBrake
  :super ros::object
  :slots (_status ))

(defmethod dbw_pacifica_msgs::ParkingBrake
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

(setf (get dbw_pacifica_msgs::ParkingBrake :md5sum-) "5023f1aa5a644d8973590da79e8ea059")
(setf (get dbw_pacifica_msgs::ParkingBrake :datatype-) "dbw_pacifica_msgs/ParkingBrake")
(setf (get dbw_pacifica_msgs::ParkingBrake :definition-)
      "uint8 status

uint8 RESERVED=0
uint8 OFF=1
uint8 ON=2
uint8 FAULT=3

")



(provide :dbw_pacifica_msgs/ParkingBrake "5023f1aa5a644d8973590da79e8ea059")


