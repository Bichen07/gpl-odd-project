;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OpenpilotState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OpenpilotState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE")
  (make-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))

(in-package "ROS")
;;//! \htmlinclude OpenpilotState.msg.html


(intern "*DISABLED*" (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(shadow '*DISABLED* (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(defconstant openpilot_bridge::OpenpilotState::*DISABLED* 0)
(intern "*ENABLED*" (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(shadow '*ENABLED* (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(defconstant openpilot_bridge::OpenpilotState::*ENABLED* 2)
(intern "*PREENABLED*" (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(shadow '*PREENABLED* (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(defconstant openpilot_bridge::OpenpilotState::*PREENABLED* 1)
(intern "*SOFTDISABLING*" (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(shadow '*SOFTDISABLING* (find-package "OPENPILOT_BRIDGE::OPENPILOTSTATE"))
(defconstant openpilot_bridge::OpenpilotState::*SOFTDISABLING* 3)
(defclass openpilot_bridge::OpenpilotState
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::OpenpilotState
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

(setf (get openpilot_bridge::OpenpilotState :md5sum-) "c8df9612be1bf110e6fde5ec97fedc61")
(setf (get openpilot_bridge::OpenpilotState :datatype-) "openpilot_bridge/OpenpilotState")
(setf (get openpilot_bridge::OpenpilotState :definition-)
      "uint32 disabled=0
uint32 enabled=2
uint32 preEnabled=1
uint32 softDisabling=3

")



(provide :openpilot_bridge/OpenpilotState "c8df9612be1bf110e6fde5ec97fedc61")


