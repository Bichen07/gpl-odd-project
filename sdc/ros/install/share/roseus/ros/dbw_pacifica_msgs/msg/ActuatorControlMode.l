;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::ActuatorControlMode)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'ActuatorControlMode (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE")
  (make-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))

(in-package "ROS")
;;//! \htmlinclude ActuatorControlMode.msg.html


(intern "*OPEN_LOOP*" (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(shadow '*OPEN_LOOP* (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(defconstant dbw_pacifica_msgs::ActuatorControlMode::*OPEN_LOOP* 0)
(intern "*CLOSED_LOOP_ACTUATOR*" (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(shadow '*CLOSED_LOOP_ACTUATOR* (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(defconstant dbw_pacifica_msgs::ActuatorControlMode::*CLOSED_LOOP_ACTUATOR* 1)
(intern "*CLOSED_LOOP_VEHICLE*" (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(shadow '*CLOSED_LOOP_VEHICLE* (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(defconstant dbw_pacifica_msgs::ActuatorControlMode::*CLOSED_LOOP_VEHICLE* 2)
(intern "*NONE*" (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(shadow '*NONE* (find-package "DBW_PACIFICA_MSGS::ACTUATORCONTROLMODE"))
(defconstant dbw_pacifica_msgs::ActuatorControlMode::*NONE* 255)
(defclass dbw_pacifica_msgs::ActuatorControlMode
  :super ros::object
  :slots (_value ))

(defmethod dbw_pacifica_msgs::ActuatorControlMode
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

(setf (get dbw_pacifica_msgs::ActuatorControlMode :md5sum-) "1994ebf1d0f443ac1da4b214c3affc7f")
(setf (get dbw_pacifica_msgs::ActuatorControlMode :datatype-) "dbw_pacifica_msgs/ActuatorControlMode")
(setf (get dbw_pacifica_msgs::ActuatorControlMode :definition-)
      "uint8 value

uint8 open_loop = 0
uint8 closed_loop_actuator = 1
uint8 closed_loop_vehicle = 2
uint8 none = 255
")



(provide :dbw_pacifica_msgs/ActuatorControlMode "1994ebf1d0f443ac1da4b214c3affc7f")


