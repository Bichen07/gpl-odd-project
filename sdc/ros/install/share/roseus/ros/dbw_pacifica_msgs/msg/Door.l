;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::Door)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'Door (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::DOOR")
  (make-package "DBW_PACIFICA_MSGS::DOOR"))

(in-package "ROS")
;;//! \htmlinclude Door.msg.html


(intern "*NO_REQUEST*" (find-package "DBW_PACIFICA_MSGS::DOOR"))
(shadow '*NO_REQUEST* (find-package "DBW_PACIFICA_MSGS::DOOR"))
(defconstant dbw_pacifica_msgs::Door::*NO_REQUEST* 0)
(intern "*CLOSE_DOOR*" (find-package "DBW_PACIFICA_MSGS::DOOR"))
(shadow '*CLOSE_DOOR* (find-package "DBW_PACIFICA_MSGS::DOOR"))
(defconstant dbw_pacifica_msgs::Door::*CLOSE_DOOR* 1)
(intern "*OPEN_DOOR*" (find-package "DBW_PACIFICA_MSGS::DOOR"))
(shadow '*OPEN_DOOR* (find-package "DBW_PACIFICA_MSGS::DOOR"))
(defconstant dbw_pacifica_msgs::Door::*OPEN_DOOR* 2)
(defclass dbw_pacifica_msgs::Door
  :super ros::object
  :slots (_value ))

(defmethod dbw_pacifica_msgs::Door
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

(setf (get dbw_pacifica_msgs::Door :md5sum-) "ef631e91af857251c9f65d6fb4ccb53d")
(setf (get dbw_pacifica_msgs::Door :datatype-) "dbw_pacifica_msgs/Door")
(setf (get dbw_pacifica_msgs::Door :definition-)
      "uint8 value

uint8 NO_REQUEST=0
uint8 CLOSE_DOOR=1
uint8 OPEN_DOOR=2

")



(provide :dbw_pacifica_msgs/Door "ef631e91af857251c9f65d6fb4ccb53d")


