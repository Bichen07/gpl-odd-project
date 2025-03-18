;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::ParkingBrkReq)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'ParkingBrkReq (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ")
  (make-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))

(in-package "ROS")
;;//! \htmlinclude ParkingBrkReq.msg.html


(intern "*NO_REQUEST*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(shadow '*NO_REQUEST* (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(defconstant dbw_pacifica_msgs::ParkingBrkReq::*NO_REQUEST* 0)
(intern "*OFF*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(shadow '*OFF* (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(defconstant dbw_pacifica_msgs::ParkingBrkReq::*OFF* 1)
(intern "*ON*" (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(shadow '*ON* (find-package "DBW_PACIFICA_MSGS::PARKINGBRKREQ"))
(defconstant dbw_pacifica_msgs::ParkingBrkReq::*ON* 2)
(defclass dbw_pacifica_msgs::ParkingBrkReq
  :super ros::object
  :slots (_value ))

(defmethod dbw_pacifica_msgs::ParkingBrkReq
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

(setf (get dbw_pacifica_msgs::ParkingBrkReq :md5sum-) "b1249cdc94b958f2fedb6cc0c469cda0")
(setf (get dbw_pacifica_msgs::ParkingBrkReq :datatype-) "dbw_pacifica_msgs/ParkingBrkReq")
(setf (get dbw_pacifica_msgs::ParkingBrkReq :definition-)
      "uint8 value

uint8 NO_REQUEST=0
uint8 OFF=1
uint8 ON=2

")



(provide :dbw_pacifica_msgs/ParkingBrkReq "b1249cdc94b958f2fedb6cc0c469cda0")


