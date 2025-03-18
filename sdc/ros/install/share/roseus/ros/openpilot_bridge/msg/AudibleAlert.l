;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AudibleAlert)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AudibleAlert (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT")
  (make-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))

(in-package "ROS")
;;//! \htmlinclude AudibleAlert.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*NONE* 0)
(intern "*CHIMEDISENGAGE*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEDISENGAGE* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEDISENGAGE* 2)
(intern "*CHIMEWARNING1*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEWARNING1* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEWARNING1* 4)
(intern "*CHIMEWARNING2*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEWARNING2* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEWARNING2* 5)
(intern "*CHIMEERROR*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEERROR* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEERROR* 3)
(intern "*CHIMEPROMPT*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEPROMPT* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEPROMPT* 7)
(intern "*CHIMEENGAGE*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEENGAGE* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEENGAGE* 1)
(intern "*CHIMEWARNINGREPEAT*" (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(shadow '*CHIMEWARNINGREPEAT* (find-package "OPENPILOT_BRIDGE::AUDIBLEALERT"))
(defconstant openpilot_bridge::AudibleAlert::*CHIMEWARNINGREPEAT* 6)
(defclass openpilot_bridge::AudibleAlert
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::AudibleAlert
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

(setf (get openpilot_bridge::AudibleAlert :md5sum-) "a3a43922546d4bc971a70d5e2c552051")
(setf (get openpilot_bridge::AudibleAlert :datatype-) "openpilot_bridge/AudibleAlert")
(setf (get openpilot_bridge::AudibleAlert :definition-)
      "uint32 none=0
uint32 chimeDisengage=2
uint32 chimeWarning1=4
uint32 chimeWarning2=5
uint32 chimeError=3
uint32 chimePrompt=7
uint32 chimeEngage=1
uint32 chimeWarningRepeat=6

")



(provide :openpilot_bridge/AudibleAlert "a3a43922546d4bc971a70d5e2c552051")


