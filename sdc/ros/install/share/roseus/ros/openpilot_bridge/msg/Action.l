;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Action)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Action (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ACTION")
  (make-package "OPENPILOT_BRIDGE::ACTION"))

(in-package "ROS")
;;//! \htmlinclude Action.msg.html


(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::ACTION"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::ACTION"))
(defconstant openpilot_bridge::Action::*NONE* 0)
(intern "*STOP*" (find-package "OPENPILOT_BRIDGE::ACTION"))
(shadow '*STOP* (find-package "OPENPILOT_BRIDGE::ACTION"))
(defconstant openpilot_bridge::Action::*STOP* 2)
(intern "*RESUMEREADY*" (find-package "OPENPILOT_BRIDGE::ACTION"))
(shadow '*RESUMEREADY* (find-package "OPENPILOT_BRIDGE::ACTION"))
(defconstant openpilot_bridge::Action::*RESUMEREADY* 3)
(intern "*YIELD*" (find-package "OPENPILOT_BRIDGE::ACTION"))
(shadow '*YIELD* (find-package "OPENPILOT_BRIDGE::ACTION"))
(defconstant openpilot_bridge::Action::*YIELD* 1)
(defclass openpilot_bridge::Action
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Action
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

(setf (get openpilot_bridge::Action :md5sum-) "f807133cfc56a455de4e9a8e5b57aa0a")
(setf (get openpilot_bridge::Action :datatype-) "openpilot_bridge/Action")
(setf (get openpilot_bridge::Action :definition-)
      "uint32 none=0
uint32 stop=2
uint32 resumeReady=3
uint32 yield=1

")



(provide :openpilot_bridge/Action "f807133cfc56a455de4e9a8e5b57aa0a")


