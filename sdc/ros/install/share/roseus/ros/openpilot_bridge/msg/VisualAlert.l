;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::VisualAlert)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'VisualAlert (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::VISUALALERT")
  (make-package "OPENPILOT_BRIDGE::VISUALALERT"))

(in-package "ROS")
;;//! \htmlinclude VisualAlert.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*NONE* 0)
(intern "*WRONGGEAR*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*WRONGGEAR* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*WRONGGEAR* 4)
(intern "*FCW*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*FCW* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*FCW* 1)
(intern "*STEERREQUIRED*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*STEERREQUIRED* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*STEERREQUIRED* 2)
(intern "*SPEEDTOOHIGH*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*SPEEDTOOHIGH* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*SPEEDTOOHIGH* 6)
(intern "*SEATBELTUNBUCKLED*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*SEATBELTUNBUCKLED* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*SEATBELTUNBUCKLED* 5)
(intern "*LDW*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*LDW* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*LDW* 7)
(intern "*BRAKEPRESSED*" (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(shadow '*BRAKEPRESSED* (find-package "OPENPILOT_BRIDGE::VISUALALERT"))
(defconstant openpilot_bridge::VisualAlert::*BRAKEPRESSED* 3)
(defclass openpilot_bridge::VisualAlert
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::VisualAlert
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

(setf (get openpilot_bridge::VisualAlert :md5sum-) "051a9c2f807a04756a4e6edeb17dd056")
(setf (get openpilot_bridge::VisualAlert :datatype-) "openpilot_bridge/VisualAlert")
(setf (get openpilot_bridge::VisualAlert :definition-)
      "uint32 none=0
uint32 wrongGear=4
uint32 fcw=1
uint32 steerRequired=2
uint32 speedTooHigh=6
uint32 seatbeltUnbuckled=5
uint32 ldw=7
uint32 brakePressed=3

")



(provide :openpilot_bridge/VisualAlert "051a9c2f807a04756a4e6edeb17dd056")


