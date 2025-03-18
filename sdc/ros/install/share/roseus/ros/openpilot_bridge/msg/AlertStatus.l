;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AlertStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AlertStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ALERTSTATUS")
  (make-package "OPENPILOT_BRIDGE::ALERTSTATUS"))

(in-package "ROS")
;;//! \htmlinclude AlertStatus.msg.html


(intern "*USERPROMPT*" (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(shadow '*USERPROMPT* (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(defconstant openpilot_bridge::AlertStatus::*USERPROMPT* 1)
(intern "*CRITICAL*" (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(shadow '*CRITICAL* (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(defconstant openpilot_bridge::AlertStatus::*CRITICAL* 2)
(intern "*NORMAL*" (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(shadow '*NORMAL* (find-package "OPENPILOT_BRIDGE::ALERTSTATUS"))
(defconstant openpilot_bridge::AlertStatus::*NORMAL* 0)
(defclass openpilot_bridge::AlertStatus
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::AlertStatus
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

(setf (get openpilot_bridge::AlertStatus :md5sum-) "f1701a0e87965803964a3d98d28cc804")
(setf (get openpilot_bridge::AlertStatus :datatype-) "openpilot_bridge/AlertStatus")
(setf (get openpilot_bridge::AlertStatus :definition-)
      "uint32 userPrompt=1
uint32 critical=2
uint32 normal=0

")



(provide :openpilot_bridge/AlertStatus "f1701a0e87965803964a3d98d28cc804")


