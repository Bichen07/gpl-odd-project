;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SafetyModel)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SafetyModel (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SAFETYMODEL")
  (make-package "OPENPILOT_BRIDGE::SAFETYMODEL"))

(in-package "ROS")
;;//! \htmlinclude SafetyModel.msg.html


(intern "*HONDABOSCHGIRAFFE*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*HONDABOSCHGIRAFFE* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*HONDABOSCHGIRAFFE* 5)
(intern "*HONDANIDEC*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*HONDANIDEC* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*HONDANIDEC* 1)
(intern "*TESLA*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*TESLA* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*TESLA* 10)
(intern "*SUBARU*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*SUBARU* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*SUBARU* 11)
(intern "*GM*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*GM* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*GM* 4)
(intern "*VOLKSWAGENPQ*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*VOLKSWAGENPQ* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*VOLKSWAGENPQ* 21)
(intern "*SILENT*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*SILENT* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*SILENT* 0)
(intern "*NOOUTPUT*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*NOOUTPUT* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*NOOUTPUT* 19)
(intern "*ALLOUTPUT*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*ALLOUTPUT* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*ALLOUTPUT* 17)
(intern "*ELM327*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*ELM327* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*ELM327* 3)
(intern "*GMPASSIVE*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*GMPASSIVE* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*GMPASSIVE* 12)
(intern "*CADILLAC*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*CADILLAC* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*CADILLAC* 7)
(intern "*HYUNDAI*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*HYUNDAI* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*HYUNDAI* 8)
(intern "*FORD*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*FORD* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*FORD* 6)
(intern "*MAZDA*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*MAZDA* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*MAZDA* 13)
(intern "*HONDABOSCHHARNESS*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*HONDABOSCHHARNESS* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*HONDABOSCHHARNESS* 20)
(intern "*VOLKSWAGEN*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*VOLKSWAGEN* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*VOLKSWAGEN* 15)
(intern "*TOYOTAIPAS*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*TOYOTAIPAS* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*TOYOTAIPAS* 16)
(intern "*NISSAN*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*NISSAN* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*NISSAN* 14)
(intern "*TOYOTA*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*TOYOTA* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*TOYOTA* 2)
(intern "*CHRYSLER*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*CHRYSLER* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*CHRYSLER* 9)
(intern "*GMASCM*" (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(shadow '*GMASCM* (find-package "OPENPILOT_BRIDGE::SAFETYMODEL"))
(defconstant openpilot_bridge::SafetyModel::*GMASCM* 18)
(defclass openpilot_bridge::SafetyModel
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::SafetyModel
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

(setf (get openpilot_bridge::SafetyModel :md5sum-) "535e7f80c93c8bb9ee4cf2f9bad94533")
(setf (get openpilot_bridge::SafetyModel :datatype-) "openpilot_bridge/SafetyModel")
(setf (get openpilot_bridge::SafetyModel :definition-)
      "uint32 hondaBoschGiraffe=5
uint32 hondaNidec=1
uint32 tesla=10
uint32 subaru=11
uint32 gm=4
uint32 volkswagenPq=21
uint32 silent=0
uint32 noOutput=19
uint32 allOutput=17
uint32 elm327=3
uint32 gmPassive=12
uint32 cadillac=7
uint32 hyundai=8
uint32 ford=6
uint32 mazda=13
uint32 hondaBoschHarness=20
uint32 volkswagen=15
uint32 toyotaIpas=16
uint32 nissan=14
uint32 toyota=2
uint32 chrysler=9
uint32 gmAscm=18

")



(provide :openpilot_bridge/SafetyModel "535e7f80c93c8bb9ee4cf2f9bad94533")


