;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::FaultType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'FaultType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::FAULTTYPE")
  (make-package "OPENPILOT_BRIDGE::FAULTTYPE"))

(in-package "ROS")
;;//! \htmlinclude FaultType.msg.html


(intern "*RELAYMALFUNCTION*" (find-package "OPENPILOT_BRIDGE::FAULTTYPE"))
(shadow '*RELAYMALFUNCTION* (find-package "OPENPILOT_BRIDGE::FAULTTYPE"))
(defconstant openpilot_bridge::FaultType::*RELAYMALFUNCTION* 0)
(defclass openpilot_bridge::FaultType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::FaultType
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

(setf (get openpilot_bridge::FaultType :md5sum-) "197e186f39d4aadb0366bf19217c7333")
(setf (get openpilot_bridge::FaultType :datatype-) "openpilot_bridge/FaultType")
(setf (get openpilot_bridge::FaultType :definition-)
      "uint32 relayMalfunction=0

")



(provide :openpilot_bridge/FaultType "197e186f39d4aadb0366bf19217c7333")


