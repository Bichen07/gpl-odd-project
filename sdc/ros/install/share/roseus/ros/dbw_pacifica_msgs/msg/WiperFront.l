;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::WiperFront)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'WiperFront (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::WIPERFRONT")
  (make-package "DBW_PACIFICA_MSGS::WIPERFRONT"))

(in-package "ROS")
;;//! \htmlinclude WiperFront.msg.html


(intern "*OFF*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*OFF* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*OFF* 0)
(intern "*INTERVAL_1*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_1* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_1* 1)
(intern "*INTERVAL_2*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_2* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_2* 2)
(intern "*INTERVAL_3*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_3* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_3* 3)
(intern "*INTERVAL_4*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_4* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_4* 4)
(intern "*INTERVAL_5*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_5* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_5* 5)
(intern "*INTERVAL_6*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*INTERVAL_6* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*INTERVAL_6* 6)
(intern "*CONSTANT_LOW*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*CONSTANT_LOW* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*CONSTANT_LOW* 11)
(intern "*CONSTANT_HIGH*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*CONSTANT_HIGH* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*CONSTANT_HIGH* 12)
(intern "*WASH_BRIEF*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*WASH_BRIEF* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*WASH_BRIEF* 13)
(intern "*WASH_CONTINUOUS*" (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(shadow '*WASH_CONTINUOUS* (find-package "DBW_PACIFICA_MSGS::WIPERFRONT"))
(defconstant dbw_pacifica_msgs::WiperFront::*WASH_CONTINUOUS* 14)
(defclass dbw_pacifica_msgs::WiperFront
  :super ros::object
  :slots (_status ))

(defmethod dbw_pacifica_msgs::WiperFront
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

(setf (get dbw_pacifica_msgs::WiperFront :md5sum-) "b1eedfdc97dc13843541e1f8f3eb65f3")
(setf (get dbw_pacifica_msgs::WiperFront :datatype-) "dbw_pacifica_msgs/WiperFront")
(setf (get dbw_pacifica_msgs::WiperFront :definition-)
      "uint8 status

uint8 OFF = 0
uint8 INTERVAL_1 = 1
uint8 INTERVAL_2 = 2
uint8 INTERVAL_3 = 3
uint8 INTERVAL_4 = 4
uint8 INTERVAL_5 = 5
uint8 INTERVAL_6 = 6
uint8 CONSTANT_LOW = 11
uint8 CONSTANT_HIGH = 12
uint8 WASH_BRIEF = 13
uint8 WASH_CONTINUOUS = 14

")



(provide :dbw_pacifica_msgs/WiperFront "b1eedfdc97dc13843541e1f8f3eb65f3")


