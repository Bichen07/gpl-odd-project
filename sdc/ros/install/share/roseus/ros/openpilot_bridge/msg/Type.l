;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Type)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Type (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::TYPE")
  (make-package "OPENPILOT_BRIDGE::TYPE"))

(in-package "ROS")
;;//! \htmlinclude Type.msg.html


(intern "*DECELCRUISE*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*DECELCRUISE* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*DECELCRUISE* 4)
(intern "*ACCELCRUISE*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*ACCELCRUISE* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*ACCELCRUISE* 3)
(intern "*LEFTBLINKER*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*LEFTBLINKER* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*LEFTBLINKER* 1)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*UNKNOWN* 0)
(intern "*SETCRUISE*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*SETCRUISE* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*SETCRUISE* 9)
(intern "*GAPADJUSTCRUISE*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*GAPADJUSTCRUISE* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*GAPADJUSTCRUISE* 11)
(intern "*RESUMECRUISE*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*RESUMECRUISE* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*RESUMECRUISE* 10)
(intern "*RIGHTBLINKER*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*RIGHTBLINKER* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*RIGHTBLINKER* 2)
(intern "*ALTBUTTON1*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*ALTBUTTON1* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*ALTBUTTON1* 6)
(intern "*CANCEL*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*CANCEL* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*CANCEL* 5)
(intern "*ALTBUTTON3*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*ALTBUTTON3* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*ALTBUTTON3* 8)
(intern "*ALTBUTTON2*" (find-package "OPENPILOT_BRIDGE::TYPE"))
(shadow '*ALTBUTTON2* (find-package "OPENPILOT_BRIDGE::TYPE"))
(defconstant openpilot_bridge::Type::*ALTBUTTON2* 7)
(defclass openpilot_bridge::Type
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Type
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

(setf (get openpilot_bridge::Type :md5sum-) "15c6e84d22188be8e7284ad21b8ff2fe")
(setf (get openpilot_bridge::Type :datatype-) "openpilot_bridge/Type")
(setf (get openpilot_bridge::Type :definition-)
      "uint32 decelCruise=4
uint32 accelCruise=3
uint32 leftBlinker=1
uint32 unknown=0
uint32 setCruise=9
uint32 gapAdjustCruise=11
uint32 resumeCruise=10
uint32 rightBlinker=2
uint32 altButton1=6
uint32 cancel=5
uint32 altButton3=8
uint32 altButton2=7

")



(provide :openpilot_bridge/Type "15c6e84d22188be8e7284ad21b8ff2fe")


