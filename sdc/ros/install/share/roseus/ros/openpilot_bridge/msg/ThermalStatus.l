;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ThermalStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ThermalStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::THERMALSTATUS")
  (make-package "OPENPILOT_BRIDGE::THERMALSTATUS"))

(in-package "ROS")
;;//! \htmlinclude ThermalStatus.msg.html


(intern "*GREEN*" (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(shadow '*GREEN* (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(defconstant openpilot_bridge::ThermalStatus::*GREEN* 0)
(intern "*RED*" (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(shadow '*RED* (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(defconstant openpilot_bridge::ThermalStatus::*RED* 2)
(intern "*YELLOW*" (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(shadow '*YELLOW* (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(defconstant openpilot_bridge::ThermalStatus::*YELLOW* 1)
(intern "*DANGER*" (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(shadow '*DANGER* (find-package "OPENPILOT_BRIDGE::THERMALSTATUS"))
(defconstant openpilot_bridge::ThermalStatus::*DANGER* 3)
(defclass openpilot_bridge::ThermalStatus
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::ThermalStatus
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(setf (get openpilot_bridge::ThermalStatus :md5sum-) "8ca17fd4cb32043ad3a4b48c68d9d536")
(setf (get openpilot_bridge::ThermalStatus :datatype-) "openpilot_bridge/ThermalStatus")
(setf (get openpilot_bridge::ThermalStatus :definition-)
      "uint32 green=0
uint32 red=2
uint32 yellow=1
uint32 danger=3

")



(provide :openpilot_bridge/ThermalStatus "8ca17fd4cb32043ad3a4b48c68d9d536")


