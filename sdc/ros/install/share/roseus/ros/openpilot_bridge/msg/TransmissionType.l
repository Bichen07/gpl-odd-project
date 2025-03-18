;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::TransmissionType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'TransmissionType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE")
  (make-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))

(in-package "ROS")
;;//! \htmlinclude TransmissionType.msg.html


(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(defconstant openpilot_bridge::TransmissionType::*UNKNOWN* 0)
(intern "*AUTOMATIC*" (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(shadow '*AUTOMATIC* (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(defconstant openpilot_bridge::TransmissionType::*AUTOMATIC* 1)
(intern "*MANUAL*" (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(shadow '*MANUAL* (find-package "OPENPILOT_BRIDGE::TRANSMISSIONTYPE"))
(defconstant openpilot_bridge::TransmissionType::*MANUAL* 2)
(defclass openpilot_bridge::TransmissionType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::TransmissionType
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

(setf (get openpilot_bridge::TransmissionType :md5sum-) "6a285d0e2a6ddfeacb68fed4d3099191")
(setf (get openpilot_bridge::TransmissionType :datatype-) "openpilot_bridge/TransmissionType")
(setf (get openpilot_bridge::TransmissionType :definition-)
      "uint32 unknown=0
uint32 automatic=1
uint32 manual=2

")



(provide :openpilot_bridge/TransmissionType "6a285d0e2a6ddfeacb68fed4d3099191")


