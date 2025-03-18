;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SteerControlType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SteerControlType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE")
  (make-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE"))

(in-package "ROS")
;;//! \htmlinclude SteerControlType.msg.html


(intern "*ANGLE*" (find-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE"))
(shadow '*ANGLE* (find-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE"))
(defconstant openpilot_bridge::SteerControlType::*ANGLE* 1)
(intern "*TORQUE*" (find-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE"))
(shadow '*TORQUE* (find-package "OPENPILOT_BRIDGE::STEERCONTROLTYPE"))
(defconstant openpilot_bridge::SteerControlType::*TORQUE* 0)
(defclass openpilot_bridge::SteerControlType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::SteerControlType
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

(setf (get openpilot_bridge::SteerControlType :md5sum-) "b226a11115e5e44a2546beb49ffa97fa")
(setf (get openpilot_bridge::SteerControlType :datatype-) "openpilot_bridge/SteerControlType")
(setf (get openpilot_bridge::SteerControlType :definition-)
      "uint32 angle=1
uint32 torque=0

")



(provide :openpilot_bridge/SteerControlType "b226a11115e5e44a2546beb49ffa97fa")


