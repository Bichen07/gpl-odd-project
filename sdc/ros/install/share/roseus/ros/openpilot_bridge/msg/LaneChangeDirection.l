;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LaneChangeDirection)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LaneChangeDirection (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION")
  (make-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))

(in-package "ROS")
;;//! \htmlinclude LaneChangeDirection.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(defconstant openpilot_bridge::LaneChangeDirection::*NONE* 0)
(intern "*RIGHT*" (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(shadow '*RIGHT* (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(defconstant openpilot_bridge::LaneChangeDirection::*RIGHT* 2)
(intern "*LEFT*" (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(shadow '*LEFT* (find-package "OPENPILOT_BRIDGE::LANECHANGEDIRECTION"))
(defconstant openpilot_bridge::LaneChangeDirection::*LEFT* 1)
(defclass openpilot_bridge::LaneChangeDirection
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::LaneChangeDirection
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

(setf (get openpilot_bridge::LaneChangeDirection :md5sum-) "c3f618df475623ce28a1741078c37b19")
(setf (get openpilot_bridge::LaneChangeDirection :datatype-) "openpilot_bridge/LaneChangeDirection")
(setf (get openpilot_bridge::LaneChangeDirection :definition-)
      "uint32 none=0
uint32 right=2
uint32 left=1

")



(provide :openpilot_bridge/LaneChangeDirection "c3f618df475623ce28a1741078c37b19")


