;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::Ignition)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'Ignition (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::IGNITION")
  (make-package "DBW_PACIFICA_MSGS::IGNITION"))

(in-package "ROS")
;;//! \htmlinclude Ignition.msg.html


(intern "*NO_REQUEST*" (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(shadow '*NO_REQUEST* (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(defconstant dbw_pacifica_msgs::Ignition::*NO_REQUEST* 0)
(intern "*FORCE_OFF*" (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(shadow '*FORCE_OFF* (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(defconstant dbw_pacifica_msgs::Ignition::*FORCE_OFF* 0)
(intern "*ACCESSORY*" (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(shadow '*ACCESSORY* (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(defconstant dbw_pacifica_msgs::Ignition::*ACCESSORY* 0)
(intern "*RUN*" (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(shadow '*RUN* (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(defconstant dbw_pacifica_msgs::Ignition::*RUN* 0)
(intern "*CRANK*" (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(shadow '*CRANK* (find-package "DBW_PACIFICA_MSGS::IGNITION"))
(defconstant dbw_pacifica_msgs::Ignition::*CRANK* 0)
(defclass dbw_pacifica_msgs::Ignition
  :super ros::object
  :slots (_status ))

(defmethod dbw_pacifica_msgs::Ignition
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

(setf (get dbw_pacifica_msgs::Ignition :md5sum-) "33e510d1388f6c82901b8ae2d40ab030")
(setf (get dbw_pacifica_msgs::Ignition :datatype-) "dbw_pacifica_msgs/Ignition")
(setf (get dbw_pacifica_msgs::Ignition :definition-)
      "uint8 status

uint8 NO_REQUEST = 0
uint8 FORCE_OFF = 0
uint8 ACCESSORY = 0
uint8 RUN = 0
uint8 CRANK = 0
")



(provide :dbw_pacifica_msgs/Ignition "33e510d1388f6c82901b8ae2d40ab030")


