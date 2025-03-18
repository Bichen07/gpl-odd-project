;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::App)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'App (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::APP")
  (make-package "OPENPILOT_BRIDGE::APP"))

(in-package "ROS")
;;//! \htmlinclude App.msg.html


(intern "*HOME*" (find-package "OPENPILOT_BRIDGE::APP"))
(shadow '*HOME* (find-package "OPENPILOT_BRIDGE::APP"))
(defconstant openpilot_bridge::App::*HOME* 0)
(intern "*NAV*" (find-package "OPENPILOT_BRIDGE::APP"))
(shadow '*NAV* (find-package "OPENPILOT_BRIDGE::APP"))
(defconstant openpilot_bridge::App::*NAV* 2)
(intern "*MUSIC*" (find-package "OPENPILOT_BRIDGE::APP"))
(shadow '*MUSIC* (find-package "OPENPILOT_BRIDGE::APP"))
(defconstant openpilot_bridge::App::*MUSIC* 1)
(intern "*SETTINGS*" (find-package "OPENPILOT_BRIDGE::APP"))
(shadow '*SETTINGS* (find-package "OPENPILOT_BRIDGE::APP"))
(defconstant openpilot_bridge::App::*SETTINGS* 3)
(defclass openpilot_bridge::App
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::App
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

(setf (get openpilot_bridge::App :md5sum-) "4d8d5be50420b5f72e4c548858f9a27f")
(setf (get openpilot_bridge::App :datatype-) "openpilot_bridge/App")
(setf (get openpilot_bridge::App :definition-)
      "uint32 home=0
uint32 nav=2
uint32 music=1
uint32 settings=3

")



(provide :openpilot_bridge/App "4d8d5be50420b5f72e4c548858f9a27f")


