;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Status)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Status (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::STATUS")
  (make-package "OPENPILOT_BRIDGE::STATUS"))

(in-package "ROS")
;;//! \htmlinclude Status.msg.html


(intern "*PASSIVE*" (find-package "OPENPILOT_BRIDGE::STATUS"))
(shadow '*PASSIVE* (find-package "OPENPILOT_BRIDGE::STATUS"))
(defconstant openpilot_bridge::Status::*PASSIVE* 1)
(intern "*ACTIVE*" (find-package "OPENPILOT_BRIDGE::STATUS"))
(shadow '*ACTIVE* (find-package "OPENPILOT_BRIDGE::STATUS"))
(defconstant openpilot_bridge::Status::*ACTIVE* 3)
(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::STATUS"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::STATUS"))
(defconstant openpilot_bridge::Status::*NONE* 0)
(intern "*APPROACHING*" (find-package "OPENPILOT_BRIDGE::STATUS"))
(shadow '*APPROACHING* (find-package "OPENPILOT_BRIDGE::STATUS"))
(defconstant openpilot_bridge::Status::*APPROACHING* 2)
(defclass openpilot_bridge::Status
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Status
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

(setf (get openpilot_bridge::Status :md5sum-) "10b5b01494ec6ca3607a495b014d618e")
(setf (get openpilot_bridge::Status :datatype-) "openpilot_bridge/Status")
(setf (get openpilot_bridge::Status :definition-)
      "uint32 passive=1
uint32 active=3
uint32 none=0
uint32 approaching=2

")



(provide :openpilot_bridge/Status "10b5b01494ec6ca3607a495b014d618e")


