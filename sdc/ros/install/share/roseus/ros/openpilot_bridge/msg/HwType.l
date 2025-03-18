;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::HwType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'HwType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::HWTYPE")
  (make-package "OPENPILOT_BRIDGE::HWTYPE"))

(in-package "ROS")
;;//! \htmlinclude HwType.msg.html


(intern "*GREYPANDA*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*GREYPANDA* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*GREYPANDA* 2)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*UNKNOWN* 0)
(intern "*BLACKPANDA*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*BLACKPANDA* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*BLACKPANDA* 3)
(intern "*PEDAL*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*PEDAL* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*PEDAL* 4)
(intern "*WHITEPANDA*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*WHITEPANDA* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*WHITEPANDA* 1)
(intern "*UNO*" (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(shadow '*UNO* (find-package "OPENPILOT_BRIDGE::HWTYPE"))
(defconstant openpilot_bridge::HwType::*UNO* 5)
(defclass openpilot_bridge::HwType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::HwType
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

(setf (get openpilot_bridge::HwType :md5sum-) "75860a38b6f0e635f9859e3fbce3d516")
(setf (get openpilot_bridge::HwType :datatype-) "openpilot_bridge/HwType")
(setf (get openpilot_bridge::HwType :definition-)
      "uint32 greyPanda=2
uint32 unknown=0
uint32 blackPanda=3
uint32 pedal=4
uint32 whitePanda=1
uint32 uno=5

")



(provide :openpilot_bridge/HwType "75860a38b6f0e635f9859e3fbce3d516")


