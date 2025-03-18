;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::GearShifter)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'GearShifter (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::GEARSHIFTER")
  (make-package "OPENPILOT_BRIDGE::GEARSHIFTER"))

(in-package "ROS")
;;//! \htmlinclude GearShifter.msg.html


(intern "*REVERSE*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*REVERSE* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*REVERSE* 4)
(intern "*ECO*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*ECO* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*ECO* 8)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*UNKNOWN* 0)
(intern "*PARK*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*PARK* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*PARK* 1)
(intern "*DRIVE*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*DRIVE* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*DRIVE* 2)
(intern "*MANUMATIC*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*MANUMATIC* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*MANUMATIC* 9)
(intern "*NEUTRAL*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*NEUTRAL* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*NEUTRAL* 3)
(intern "*BRAKE*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*BRAKE* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*BRAKE* 7)
(intern "*LOW*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*LOW* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*LOW* 6)
(intern "*SPORT*" (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(shadow '*SPORT* (find-package "OPENPILOT_BRIDGE::GEARSHIFTER"))
(defconstant openpilot_bridge::GearShifter::*SPORT* 5)
(defclass openpilot_bridge::GearShifter
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::GearShifter
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

(setf (get openpilot_bridge::GearShifter :md5sum-) "273b4e52e60e160fcc38ba4e49c7ae28")
(setf (get openpilot_bridge::GearShifter :datatype-) "openpilot_bridge/GearShifter")
(setf (get openpilot_bridge::GearShifter :definition-)
      "uint32 reverse=4
uint32 eco=8
uint32 unknown=0
uint32 park=1
uint32 drive=2
uint32 manumatic=9
uint32 neutral=3
uint32 brake=7
uint32 low=6
uint32 sport=5

")



(provide :openpilot_bridge/GearShifter "273b4e52e60e160fcc38ba4e49c7ae28")


