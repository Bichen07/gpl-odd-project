;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Error)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Error (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ERROR")
  (make-package "OPENPILOT_BRIDGE::ERROR"))

(in-package "ROS")
;;//! \htmlinclude Error.msg.html


(intern "*FAULT*" (find-package "OPENPILOT_BRIDGE::ERROR"))
(shadow '*FAULT* (find-package "OPENPILOT_BRIDGE::ERROR"))
(defconstant openpilot_bridge::Error::*FAULT* 1)
(intern "*CANERROR*" (find-package "OPENPILOT_BRIDGE::ERROR"))
(shadow '*CANERROR* (find-package "OPENPILOT_BRIDGE::ERROR"))
(defconstant openpilot_bridge::Error::*CANERROR* 0)
(intern "*WRONGCONFIG*" (find-package "OPENPILOT_BRIDGE::ERROR"))
(shadow '*WRONGCONFIG* (find-package "OPENPILOT_BRIDGE::ERROR"))
(defconstant openpilot_bridge::Error::*WRONGCONFIG* 2)
(defclass openpilot_bridge::Error
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Error
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

(setf (get openpilot_bridge::Error :md5sum-) "48460582da2a88bb26d24722889db26d")
(setf (get openpilot_bridge::Error :datatype-) "openpilot_bridge/Error")
(setf (get openpilot_bridge::Error :definition-)
      "uint32 fault=1
uint32 canError=0
uint32 wrongConfig=2

")



(provide :openpilot_bridge/Error "48460582da2a88bb26d24722889db26d")


