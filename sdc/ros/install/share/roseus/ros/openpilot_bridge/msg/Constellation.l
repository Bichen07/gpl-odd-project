;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Constellation)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Constellation (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CONSTELLATION")
  (make-package "OPENPILOT_BRIDGE::CONSTELLATION"))

(in-package "ROS")
;;//! \htmlinclude Constellation.msg.html


(intern "*GLONASS*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*GLONASS* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*GLONASS* 3)
(intern "*SBAS*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*SBAS* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*SBAS* 2)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*UNKNOWN* 0)
(intern "*QZSS*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*QZSS* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*QZSS* 4)
(intern "*GALILEO*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*GALILEO* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*GALILEO* 6)
(intern "*BEIDOU*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*BEIDOU* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*BEIDOU* 5)
(intern "*GPS*" (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(shadow '*GPS* (find-package "OPENPILOT_BRIDGE::CONSTELLATION"))
(defconstant openpilot_bridge::Constellation::*GPS* 1)
(defclass openpilot_bridge::Constellation
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Constellation
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

(setf (get openpilot_bridge::Constellation :md5sum-) "10e258dff61ddb857e38cc71c876c0f6")
(setf (get openpilot_bridge::Constellation :datatype-) "openpilot_bridge/Constellation")
(setf (get openpilot_bridge::Constellation :definition-)
      "uint32 glonass=3
uint32 sbas=2
uint32 unknown=0
uint32 qzss=4
uint32 galileo=6
uint32 beidou=5
uint32 gps=1

")



(provide :openpilot_bridge/Constellation "10e258dff61ddb857e38cc71c876c0f6")


