;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AlertSize)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AlertSize (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ALERTSIZE")
  (make-package "OPENPILOT_BRIDGE::ALERTSIZE"))

(in-package "ROS")
;;//! \htmlinclude AlertSize.msg.html


(intern "*SMALL*" (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(shadow '*SMALL* (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(defconstant openpilot_bridge::AlertSize::*SMALL* 1)
(intern "*NONE*" (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(shadow '*NONE* (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(defconstant openpilot_bridge::AlertSize::*NONE* 0)
(intern "*FULL*" (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(shadow '*FULL* (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(defconstant openpilot_bridge::AlertSize::*FULL* 3)
(intern "*MID*" (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(shadow '*MID* (find-package "OPENPILOT_BRIDGE::ALERTSIZE"))
(defconstant openpilot_bridge::AlertSize::*MID* 2)
(defclass openpilot_bridge::AlertSize
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::AlertSize
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

(setf (get openpilot_bridge::AlertSize :md5sum-) "0ea349938bab8f497baa9a2b7b4823c9")
(setf (get openpilot_bridge::AlertSize :datatype-) "openpilot_bridge/AlertSize")
(setf (get openpilot_bridge::AlertSize :definition-)
      "uint32 small=1
uint32 none=0
uint32 full=3
uint32 mid=2

")



(provide :openpilot_bridge/AlertSize "0ea349938bab8f497baa9a2b7b4823c9")


