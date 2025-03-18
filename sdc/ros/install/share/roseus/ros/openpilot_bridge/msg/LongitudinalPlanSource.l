;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LongitudinalPlanSource)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LongitudinalPlanSource (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE")
  (make-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))

(in-package "ROS")
;;//! \htmlinclude LongitudinalPlanSource.msg.html


(intern "*MODEL*" (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(shadow '*MODEL* (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(defconstant openpilot_bridge::LongitudinalPlanSource::*MODEL* 4)
(intern "*MPC1*" (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(shadow '*MPC1* (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(defconstant openpilot_bridge::LongitudinalPlanSource::*MPC1* 1)
(intern "*MPC2*" (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(shadow '*MPC2* (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(defconstant openpilot_bridge::LongitudinalPlanSource::*MPC2* 2)
(intern "*MPC3*" (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(shadow '*MPC3* (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(defconstant openpilot_bridge::LongitudinalPlanSource::*MPC3* 3)
(intern "*CRUISE*" (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(shadow '*CRUISE* (find-package "OPENPILOT_BRIDGE::LONGITUDINALPLANSOURCE"))
(defconstant openpilot_bridge::LongitudinalPlanSource::*CRUISE* 0)
(defclass openpilot_bridge::LongitudinalPlanSource
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::LongitudinalPlanSource
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

(setf (get openpilot_bridge::LongitudinalPlanSource :md5sum-) "6dc6b7eb09997044411ec119a9eedd80")
(setf (get openpilot_bridge::LongitudinalPlanSource :datatype-) "openpilot_bridge/LongitudinalPlanSource")
(setf (get openpilot_bridge::LongitudinalPlanSource :definition-)
      "uint32 model=4
uint32 mpc1=1
uint32 mpc2=2
uint32 mpc3=3
uint32 cruise=0

")



(provide :openpilot_bridge/LongitudinalPlanSource "6dc6b7eb09997044411ec119a9eedd80")


