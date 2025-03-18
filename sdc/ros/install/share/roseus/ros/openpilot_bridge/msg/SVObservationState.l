;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SVObservationState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SVObservationState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE")
  (make-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))

(in-package "ROS")
;;//! \htmlinclude SVObservationState.msg.html


(intern "*SEARCH*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*SEARCH* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*SEARCH* 1)
(intern "*BITEDGE*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*BITEDGE* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*BITEDGE* 3)
(intern "*TRACK*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*TRACK* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*TRACK* 5)
(intern "*GLO10MSAT*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*GLO10MSAT* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*GLO10MSAT* 9)
(intern "*IDLE*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*IDLE* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*IDLE* 0)
(intern "*TRACKVERIFY*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*TRACKVERIFY* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*TRACKVERIFY* 4)
(intern "*SEARCHVERIFY*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*SEARCHVERIFY* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*SEARCHVERIFY* 2)
(intern "*DPO*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*DPO* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*DPO* 7)
(intern "*RESTART*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*RESTART* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*RESTART* 6)
(intern "*GLO10MSBE*" (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(shadow '*GLO10MSBE* (find-package "OPENPILOT_BRIDGE::SVOBSERVATIONSTATE"))
(defconstant openpilot_bridge::SVObservationState::*GLO10MSBE* 8)
(defclass openpilot_bridge::SVObservationState
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::SVObservationState
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

(setf (get openpilot_bridge::SVObservationState :md5sum-) "ca9b9510f6b206850baa3731f543e7df")
(setf (get openpilot_bridge::SVObservationState :datatype-) "openpilot_bridge/SVObservationState")
(setf (get openpilot_bridge::SVObservationState :definition-)
      "uint32 search=1
uint32 bitEdge=3
uint32 track=5
uint32 glo10msAt=9
uint32 idle=0
uint32 trackVerify=4
uint32 searchVerify=2
uint32 dpo=7
uint32 restart=6
uint32 glo10msBe=8

")



(provide :openpilot_bridge/SVObservationState "ca9b9510f6b206850baa3731f543e7df")


