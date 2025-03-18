;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SensorSource)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SensorSource (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SENSORSOURCE")
  (make-package "OPENPILOT_BRIDGE::SENSORSOURCE"))

(in-package "ROS")
;;//! \htmlinclude SensorSource.msg.html


(intern "*TIMING*" (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(shadow '*TIMING* (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(defconstant openpilot_bridge::SensorSource::*TIMING* 3)
(intern "*DUMMY*" (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(shadow '*DUMMY* (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(defconstant openpilot_bridge::SensorSource::*DUMMY* 4)
(intern "*ORBSLAM*" (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(shadow '*ORBSLAM* (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(defconstant openpilot_bridge::SensorSource::*ORBSLAM* 2)
(intern "*APPLANIX*" (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(shadow '*APPLANIX* (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(defconstant openpilot_bridge::SensorSource::*APPLANIX* 0)
(intern "*KALMAN*" (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(shadow '*KALMAN* (find-package "OPENPILOT_BRIDGE::SENSORSOURCE"))
(defconstant openpilot_bridge::SensorSource::*KALMAN* 1)
(defclass openpilot_bridge::SensorSource
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::SensorSource
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

(setf (get openpilot_bridge::SensorSource :md5sum-) "4e71318379cc48f045877905e946e09e")
(setf (get openpilot_bridge::SensorSource :datatype-) "openpilot_bridge/SensorSource")
(setf (get openpilot_bridge::SensorSource :definition-)
      "uint32 timing=3
uint32 dummy=4
uint32 orbslam=2
uint32 applanix=0
uint32 kalman=1

")



(provide :openpilot_bridge/SensorSource "4e71318379cc48f045877905e946e09e")


