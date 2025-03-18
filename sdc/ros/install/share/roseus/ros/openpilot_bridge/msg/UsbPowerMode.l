;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::UsbPowerMode)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'UsbPowerMode (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::USBPOWERMODE")
  (make-package "OPENPILOT_BRIDGE::USBPOWERMODE"))

(in-package "ROS")
;;//! \htmlinclude UsbPowerMode.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(defconstant openpilot_bridge::UsbPowerMode::*NONE* 0)
(intern "*CLIENT*" (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(shadow '*CLIENT* (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(defconstant openpilot_bridge::UsbPowerMode::*CLIENT* 1)
(intern "*CDP*" (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(shadow '*CDP* (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(defconstant openpilot_bridge::UsbPowerMode::*CDP* 2)
(intern "*DCP*" (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(shadow '*DCP* (find-package "OPENPILOT_BRIDGE::USBPOWERMODE"))
(defconstant openpilot_bridge::UsbPowerMode::*DCP* 3)
(defclass openpilot_bridge::UsbPowerMode
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::UsbPowerMode
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

(setf (get openpilot_bridge::UsbPowerMode :md5sum-) "0ed062df39951268215b5a9aabd60f17")
(setf (get openpilot_bridge::UsbPowerMode :datatype-) "openpilot_bridge/UsbPowerMode")
(setf (get openpilot_bridge::UsbPowerMode :definition-)
      "uint32 none=0
uint32 client=1
uint32 cdp=2
uint32 dcp=3

")



(provide :openpilot_bridge/UsbPowerMode "0ed062df39951268215b5a9aabd60f17")


