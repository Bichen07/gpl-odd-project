;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::DoorLock)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'DoorLock (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::DOORLOCK")
  (make-package "DBW_PACIFICA_MSGS::DOORLOCK"))

(in-package "ROS")
;;//! \htmlinclude DoorLock.msg.html


(intern "*NOREQUEST*" (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(shadow '*NOREQUEST* (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(defconstant dbw_pacifica_msgs::DoorLock::*NOREQUEST* 0)
(intern "*UNLOCK*" (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(shadow '*UNLOCK* (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(defconstant dbw_pacifica_msgs::DoorLock::*UNLOCK* 1)
(intern "*LOCK*" (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(shadow '*LOCK* (find-package "DBW_PACIFICA_MSGS::DOORLOCK"))
(defconstant dbw_pacifica_msgs::DoorLock::*LOCK* 2)
(defclass dbw_pacifica_msgs::DoorLock
  :super ros::object
  :slots (_value ))

(defmethod dbw_pacifica_msgs::DoorLock
  (:init
   (&key
    ((:value __value) 0)
    )
   (send-super :init)
   (setq _value (round __value))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; uint8 _value
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _value
       (write-byte _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _value
     (setq _value (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::DoorLock :md5sum-) "eb6b773be48793fa970a0f8044cb491f")
(setf (get dbw_pacifica_msgs::DoorLock :datatype-) "dbw_pacifica_msgs/DoorLock")
(setf (get dbw_pacifica_msgs::DoorLock :definition-)
      "uint8 value

uint8 NOREQUEST=0
uint8 UNLOCK=1
uint8 LOCK=2

")



(provide :dbw_pacifica_msgs/DoorLock "eb6b773be48793fa970a0f8044cb491f")


