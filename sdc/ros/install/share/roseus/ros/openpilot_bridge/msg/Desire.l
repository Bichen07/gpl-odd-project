;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Desire)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Desire (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::DESIRE")
  (make-package "OPENPILOT_BRIDGE::DESIRE"))

(in-package "ROS")
;;//! \htmlinclude Desire.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*NONE* 0)
(intern "*TURNLEFT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*TURNLEFT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*TURNLEFT* 1)
(intern "*LANECHANGERIGHT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*LANECHANGERIGHT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*LANECHANGERIGHT* 4)
(intern "*LANECHANGELEFT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*LANECHANGELEFT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*LANECHANGELEFT* 3)
(intern "*TURNRIGHT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*TURNRIGHT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*TURNRIGHT* 2)
(intern "*KEEPRIGHT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*KEEPRIGHT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*KEEPRIGHT* 6)
(intern "*KEEPLEFT*" (find-package "OPENPILOT_BRIDGE::DESIRE"))
(shadow '*KEEPLEFT* (find-package "OPENPILOT_BRIDGE::DESIRE"))
(defconstant openpilot_bridge::Desire::*KEEPLEFT* 5)
(defclass openpilot_bridge::Desire
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Desire
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

(setf (get openpilot_bridge::Desire :md5sum-) "b80700589a9a6c06d4798f291a92dd6e")
(setf (get openpilot_bridge::Desire :datatype-) "openpilot_bridge/Desire")
(setf (get openpilot_bridge::Desire :definition-)
      "uint32 none=0
uint32 turnLeft=1
uint32 laneChangeRight=4
uint32 laneChangeLeft=3
uint32 turnRight=2
uint32 keepRight=6
uint32 keepLeft=5

")



(provide :openpilot_bridge/Desire "b80700589a9a6c06d4798f291a92dd6e")


