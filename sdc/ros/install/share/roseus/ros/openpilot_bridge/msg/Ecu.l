;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Ecu)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Ecu (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ECU")
  (make-package "OPENPILOT_BRIDGE::ECU"))

(in-package "ROS")
;;//! \htmlinclude Ecu.msg.html


(intern "*ENGINE*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*ENGINE* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*ENGINE* 4)
(intern "*ESP*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*ESP* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*ESP* 1)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*UNKNOWN* 5)
(intern "*DSU*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*DSU* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*DSU* 6)
(intern "*EPS*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*EPS* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*EPS* 0)
(intern "*APGS*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*APGS* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*APGS* 7)
(intern "*FWDRADAR*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*FWDRADAR* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*FWDRADAR* 2)
(intern "*FWDCAMERA*" (find-package "OPENPILOT_BRIDGE::ECU"))
(shadow '*FWDCAMERA* (find-package "OPENPILOT_BRIDGE::ECU"))
(defconstant openpilot_bridge::Ecu::*FWDCAMERA* 3)
(defclass openpilot_bridge::Ecu
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Ecu
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

(setf (get openpilot_bridge::Ecu :md5sum-) "b4567db0d123c6b76edb282c1d1130de")
(setf (get openpilot_bridge::Ecu :datatype-) "openpilot_bridge/Ecu")
(setf (get openpilot_bridge::Ecu :definition-)
      "uint32 engine=4
uint32 esp=1
uint32 unknown=5
uint32 dsu=6
uint32 eps=0
uint32 apgs=7
uint32 fwdRadar=2
uint32 fwdCamera=3

")



(provide :openpilot_bridge/Ecu "b4567db0d123c6b76edb282c1d1130de")


