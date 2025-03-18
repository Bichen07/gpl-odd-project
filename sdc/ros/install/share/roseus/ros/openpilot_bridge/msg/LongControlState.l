;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LongControlState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LongControlState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE")
  (make-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))

(in-package "ROS")
;;//! \htmlinclude LongControlState.msg.html


(intern "*STOPPING*" (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(shadow '*STOPPING* (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(defconstant openpilot_bridge::LongControlState::*STOPPING* 2)
(intern "*PID*" (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(shadow '*PID* (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(defconstant openpilot_bridge::LongControlState::*PID* 1)
(intern "*OFF*" (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(shadow '*OFF* (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(defconstant openpilot_bridge::LongControlState::*OFF* 0)
(intern "*STARTING*" (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(shadow '*STARTING* (find-package "OPENPILOT_BRIDGE::LONGCONTROLSTATE"))
(defconstant openpilot_bridge::LongControlState::*STARTING* 3)
(defclass openpilot_bridge::LongControlState
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::LongControlState
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

(setf (get openpilot_bridge::LongControlState :md5sum-) "3b1d735b18fedde2cd52ffbcd57e63c3")
(setf (get openpilot_bridge::LongControlState :datatype-) "openpilot_bridge/LongControlState")
(setf (get openpilot_bridge::LongControlState :definition-)
      "uint32 stopping=2
uint32 pid=1
uint32 off=0
uint32 starting=3

")



(provide :openpilot_bridge/LongControlState "3b1d735b18fedde2cd52ffbcd57e63c3")


