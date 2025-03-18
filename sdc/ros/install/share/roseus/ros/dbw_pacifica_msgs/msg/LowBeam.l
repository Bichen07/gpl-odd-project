;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::LowBeam)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'LowBeam (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::LOWBEAM")
  (make-package "DBW_PACIFICA_MSGS::LOWBEAM"))

(in-package "ROS")
;;//! \htmlinclude LowBeam.msg.html


(intern "*OFF*" (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(shadow '*OFF* (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(defconstant dbw_pacifica_msgs::LowBeam::*OFF* 0)
(intern "*ON*" (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(shadow '*ON* (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(defconstant dbw_pacifica_msgs::LowBeam::*ON* 1)
(intern "*FLASH*" (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(shadow '*FLASH* (find-package "DBW_PACIFICA_MSGS::LOWBEAM"))
(defconstant dbw_pacifica_msgs::LowBeam::*FLASH* 2)
(defclass dbw_pacifica_msgs::LowBeam
  :super ros::object
  :slots (_status ))

(defmethod dbw_pacifica_msgs::LowBeam
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

(setf (get dbw_pacifica_msgs::LowBeam :md5sum-) "a510c9c2d6325952f3e0552b03fedbc3")
(setf (get dbw_pacifica_msgs::LowBeam :datatype-) "dbw_pacifica_msgs/LowBeam")
(setf (get dbw_pacifica_msgs::LowBeam :definition-)
      "uint8 status

uint8 OFF = 0
uint8 ON = 1
uint8 FLASH = 2

")



(provide :dbw_pacifica_msgs/LowBeam "a510c9c2d6325952f3e0552b03fedbc3")


