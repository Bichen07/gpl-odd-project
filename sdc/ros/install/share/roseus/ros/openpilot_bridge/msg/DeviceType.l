;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::DeviceType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'DeviceType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::DEVICETYPE")
  (make-package "OPENPILOT_BRIDGE::DEVICETYPE"))

(in-package "ROS")
;;//! \htmlinclude DeviceType.msg.html


(intern "*CHFFRIOS*" (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(shadow '*CHFFRIOS* (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(defconstant openpilot_bridge::DeviceType::*CHFFRIOS* 3)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(defconstant openpilot_bridge::DeviceType::*UNKNOWN* 0)
(intern "*CHFFRANDROID*" (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(shadow '*CHFFRANDROID* (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(defconstant openpilot_bridge::DeviceType::*CHFFRANDROID* 2)
(intern "*NEO*" (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(shadow '*NEO* (find-package "OPENPILOT_BRIDGE::DEVICETYPE"))
(defconstant openpilot_bridge::DeviceType::*NEO* 1)
(defclass openpilot_bridge::DeviceType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::DeviceType
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

(setf (get openpilot_bridge::DeviceType :md5sum-) "82413ac418dda4ec5bf96c9c7090008f")
(setf (get openpilot_bridge::DeviceType :datatype-) "openpilot_bridge/DeviceType")
(setf (get openpilot_bridge::DeviceType :definition-)
      "uint32 chffrIos=3
uint32 unknown=0
uint32 chffrAndroid=2
uint32 neo=1

")



(provide :openpilot_bridge/DeviceType "82413ac418dda4ec5bf96c9c7090008f")


