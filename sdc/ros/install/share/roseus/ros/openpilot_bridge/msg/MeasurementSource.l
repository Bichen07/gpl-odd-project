;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::MeasurementSource)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'MeasurementSource (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE")
  (make-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))

(in-package "ROS")
;;//! \htmlinclude MeasurementSource.msg.html


(intern "*BEIDOU*" (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(shadow '*BEIDOU* (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(defconstant openpilot_bridge::MeasurementSource::*BEIDOU* 2)
(intern "*GLONASS*" (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(shadow '*GLONASS* (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(defconstant openpilot_bridge::MeasurementSource::*GLONASS* 1)
(intern "*GPS*" (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(shadow '*GPS* (find-package "OPENPILOT_BRIDGE::MEASUREMENTSOURCE"))
(defconstant openpilot_bridge::MeasurementSource::*GPS* 0)
(defclass openpilot_bridge::MeasurementSource
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::MeasurementSource
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

(setf (get openpilot_bridge::MeasurementSource :md5sum-) "9647811c69840716207e5d777760409f")
(setf (get openpilot_bridge::MeasurementSource :datatype-) "openpilot_bridge/MeasurementSource")
(setf (get openpilot_bridge::MeasurementSource :definition-)
      "uint32 beidou=2
uint32 glonass=1
uint32 gps=0

")



(provide :openpilot_bridge/MeasurementSource "9647811c69840716207e5d777760409f")


