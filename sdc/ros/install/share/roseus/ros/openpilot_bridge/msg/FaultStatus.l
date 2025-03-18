;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::FaultStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'FaultStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::FAULTSTATUS")
  (make-package "OPENPILOT_BRIDGE::FAULTSTATUS"))

(in-package "ROS")
;;//! \htmlinclude FaultStatus.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(defconstant openpilot_bridge::FaultStatus::*NONE* 0)
(intern "*FAULTPERM*" (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(shadow '*FAULTPERM* (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(defconstant openpilot_bridge::FaultStatus::*FAULTPERM* 2)
(intern "*FAULTTEMP*" (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(shadow '*FAULTTEMP* (find-package "OPENPILOT_BRIDGE::FAULTSTATUS"))
(defconstant openpilot_bridge::FaultStatus::*FAULTTEMP* 1)
(defclass openpilot_bridge::FaultStatus
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::FaultStatus
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

(setf (get openpilot_bridge::FaultStatus :md5sum-) "f810ab59824d94736267917644323f17")
(setf (get openpilot_bridge::FaultStatus :datatype-) "openpilot_bridge/FaultStatus")
(setf (get openpilot_bridge::FaultStatus :definition-)
      "uint32 none=0
uint32 faultPerm=2
uint32 faultTemp=1

")



(provide :openpilot_bridge/FaultStatus "f810ab59824d94736267917644323f17")


