;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::WheelSpeedType)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'WheelSpeedType (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE")
  (make-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE"))

(in-package "ROS")
;;//! \htmlinclude WheelSpeedType.msg.html


(intern "*ANGULAR*" (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE"))
(shadow '*ANGULAR* (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE"))
(defconstant dbw_pacifica_msgs::WheelSpeedType::*ANGULAR* 0)
(intern "*LINEAR*" (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE"))
(shadow '*LINEAR* (find-package "DBW_PACIFICA_MSGS::WHEELSPEEDTYPE"))
(defconstant dbw_pacifica_msgs::WheelSpeedType::*LINEAR* 1)
(defclass dbw_pacifica_msgs::WheelSpeedType
  :super ros::object
  :slots (_value ))

(defmethod dbw_pacifica_msgs::WheelSpeedType
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

(setf (get dbw_pacifica_msgs::WheelSpeedType :md5sum-) "3449744e3a452eb36b1db88cb52b05b8")
(setf (get dbw_pacifica_msgs::WheelSpeedType :datatype-) "dbw_pacifica_msgs/WheelSpeedType")
(setf (get dbw_pacifica_msgs::WheelSpeedType :definition-)
      "uint8 value

uint8 ANGULAR = 0
uint8 LINEAR = 1
")



(provide :dbw_pacifica_msgs/WheelSpeedType "3449744e3a452eb36b1db88cb52b05b8")


