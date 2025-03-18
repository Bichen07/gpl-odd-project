;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::WiperRear)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'WiperRear (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::WIPERREAR")
  (make-package "DBW_PACIFICA_MSGS::WIPERREAR"))

(in-package "ROS")
;;//! \htmlinclude WiperRear.msg.html


(intern "*OFF*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*OFF* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*OFF* 0)
(intern "*INTERVAL_1*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*INTERVAL_1* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*INTERVAL_1* 1)
(intern "*CONSTANT_LOW*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*CONSTANT_LOW* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*CONSTANT_LOW* 11)
(intern "*CONSTANT_HIGH*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*CONSTANT_HIGH* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*CONSTANT_HIGH* 12)
(intern "*WASH_BRIEF*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*WASH_BRIEF* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*WASH_BRIEF* 13)
(intern "*WASH_CONTINUOUS*" (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(shadow '*WASH_CONTINUOUS* (find-package "DBW_PACIFICA_MSGS::WIPERREAR"))
(defconstant dbw_pacifica_msgs::WiperRear::*WASH_CONTINUOUS* 14)
(defclass dbw_pacifica_msgs::WiperRear
  :super ros::object
  :slots (_status ))

(defmethod dbw_pacifica_msgs::WiperRear
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

(setf (get dbw_pacifica_msgs::WiperRear :md5sum-) "ecdeee19b7a512c7247c7a840809bea5")
(setf (get dbw_pacifica_msgs::WiperRear :datatype-) "dbw_pacifica_msgs/WiperRear")
(setf (get dbw_pacifica_msgs::WiperRear :definition-)
      "uint8 status

uint8 OFF = 0
uint8 INTERVAL_1 = 1
uint8 CONSTANT_LOW = 11
uint8 CONSTANT_HIGH = 12
uint8 WASH_BRIEF = 13
uint8 WASH_CONTINUOUS = 14

")



(provide :dbw_pacifica_msgs/WiperRear "ecdeee19b7a512c7247c7a840809bea5")


