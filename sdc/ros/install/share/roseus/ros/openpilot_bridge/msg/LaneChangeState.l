;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LaneChangeState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LaneChangeState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE")
  (make-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))

(in-package "ROS")
;;//! \htmlinclude LaneChangeState.msg.html


(intern "*PRELANECHANGE*" (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(shadow '*PRELANECHANGE* (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(defconstant openpilot_bridge::LaneChangeState::*PRELANECHANGE* 1)
(intern "*LANECHANGESTARTING*" (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(shadow '*LANECHANGESTARTING* (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(defconstant openpilot_bridge::LaneChangeState::*LANECHANGESTARTING* 2)
(intern "*OFF*" (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(shadow '*OFF* (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(defconstant openpilot_bridge::LaneChangeState::*OFF* 0)
(intern "*LANECHANGEFINISHING*" (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(shadow '*LANECHANGEFINISHING* (find-package "OPENPILOT_BRIDGE::LANECHANGESTATE"))
(defconstant openpilot_bridge::LaneChangeState::*LANECHANGEFINISHING* 3)
(defclass openpilot_bridge::LaneChangeState
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::LaneChangeState
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

(setf (get openpilot_bridge::LaneChangeState :md5sum-) "39b0857fa3f626379332a3d9c60e1641")
(setf (get openpilot_bridge::LaneChangeState :datatype-) "openpilot_bridge/LaneChangeState")
(setf (get openpilot_bridge::LaneChangeState :definition-)
      "uint32 preLaneChange=1
uint32 laneChangeStarting=2
uint32 off=0
uint32 laneChangeFinishing=3

")



(provide :openpilot_bridge/LaneChangeState "39b0857fa3f626379332a3d9c60e1641")


