;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::MultipathIndicator)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'MultipathIndicator (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR")
  (make-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))

(in-package "ROS")
;;//! \htmlinclude MultipathIndicator.msg.html


(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(defconstant openpilot_bridge::MultipathIndicator::*UNKNOWN* 0)
(intern "*DETECTED*" (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(shadow '*DETECTED* (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(defconstant openpilot_bridge::MultipathIndicator::*DETECTED* 1)
(intern "*NOTDETECTED*" (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(shadow '*NOTDETECTED* (find-package "OPENPILOT_BRIDGE::MULTIPATHINDICATOR"))
(defconstant openpilot_bridge::MultipathIndicator::*NOTDETECTED* 2)
(defclass openpilot_bridge::MultipathIndicator
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::MultipathIndicator
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

(setf (get openpilot_bridge::MultipathIndicator :md5sum-) "33afdf2f17a81ec894bf0c7faeb6aca3")
(setf (get openpilot_bridge::MultipathIndicator :datatype-) "openpilot_bridge/MultipathIndicator")
(setf (get openpilot_bridge::MultipathIndicator :definition-)
      "uint32 unknown=0
uint32 detected=1
uint32 notDetected=2

")



(provide :openpilot_bridge/MultipathIndicator "33afdf2f17a81ec894bf0c7faeb6aca3")


