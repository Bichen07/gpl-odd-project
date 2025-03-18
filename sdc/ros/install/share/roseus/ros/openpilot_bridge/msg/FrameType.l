;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::FrameType)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'FrameType (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::FRAMETYPE")
  (make-package "OPENPILOT_BRIDGE::FRAMETYPE"))

(in-package "ROS")
;;//! \htmlinclude FrameType.msg.html


(intern "*FRONT*" (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(shadow '*FRONT* (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(defconstant openpilot_bridge::FrameType::*FRONT* 3)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(defconstant openpilot_bridge::FrameType::*UNKNOWN* 0)
(intern "*CHFFRANDROID*" (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(shadow '*CHFFRANDROID* (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(defconstant openpilot_bridge::FrameType::*CHFFRANDROID* 2)
(intern "*NEO*" (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(shadow '*NEO* (find-package "OPENPILOT_BRIDGE::FRAMETYPE"))
(defconstant openpilot_bridge::FrameType::*NEO* 1)
(defclass openpilot_bridge::FrameType
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::FrameType
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

(setf (get openpilot_bridge::FrameType :md5sum-) "2a992a2c8d63e13eb9c0cdee6ef2a62f")
(setf (get openpilot_bridge::FrameType :datatype-) "openpilot_bridge/FrameType")
(setf (get openpilot_bridge::FrameType :definition-)
      "uint32 front=3
uint32 unknown=0
uint32 chffrAndroid=2
uint32 neo=1

")



(provide :openpilot_bridge/FrameType "2a992a2c8d63e13eb9c0cdee6ef2a62f")


