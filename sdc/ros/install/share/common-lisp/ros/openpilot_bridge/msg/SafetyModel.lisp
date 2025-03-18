; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SafetyModel.msg.html

(cl:defclass <SafetyModel> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SafetyModel (<SafetyModel>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SafetyModel>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SafetyModel)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SafetyModel> is deprecated: use openpilot_bridge-msg:SafetyModel instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SafetyModel>)))
    "Constants for message type '<SafetyModel>"
  '((:HONDABOSCHGIRAFFE . 5)
    (:HONDANIDEC . 1)
    (:TESLA . 10)
    (:SUBARU . 11)
    (:GM . 4)
    (:VOLKSWAGENPQ . 21)
    (:SILENT . 0)
    (:NOOUTPUT . 19)
    (:ALLOUTPUT . 17)
    (:ELM327 . 3)
    (:GMPASSIVE . 12)
    (:CADILLAC . 7)
    (:HYUNDAI . 8)
    (:FORD . 6)
    (:MAZDA . 13)
    (:HONDABOSCHHARNESS . 20)
    (:VOLKSWAGEN . 15)
    (:TOYOTAIPAS . 16)
    (:NISSAN . 14)
    (:TOYOTA . 2)
    (:CHRYSLER . 9)
    (:GMASCM . 18))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SafetyModel)))
    "Constants for message type 'SafetyModel"
  '((:HONDABOSCHGIRAFFE . 5)
    (:HONDANIDEC . 1)
    (:TESLA . 10)
    (:SUBARU . 11)
    (:GM . 4)
    (:VOLKSWAGENPQ . 21)
    (:SILENT . 0)
    (:NOOUTPUT . 19)
    (:ALLOUTPUT . 17)
    (:ELM327 . 3)
    (:GMPASSIVE . 12)
    (:CADILLAC . 7)
    (:HYUNDAI . 8)
    (:FORD . 6)
    (:MAZDA . 13)
    (:HONDABOSCHHARNESS . 20)
    (:VOLKSWAGEN . 15)
    (:TOYOTAIPAS . 16)
    (:NISSAN . 14)
    (:TOYOTA . 2)
    (:CHRYSLER . 9)
    (:GMASCM . 18))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SafetyModel>) ostream)
  "Serializes a message object of type '<SafetyModel>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SafetyModel>) istream)
  "Deserializes a message object of type '<SafetyModel>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SafetyModel>)))
  "Returns string type for a message object of type '<SafetyModel>"
  "openpilot_bridge/SafetyModel")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SafetyModel)))
  "Returns string type for a message object of type 'SafetyModel"
  "openpilot_bridge/SafetyModel")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SafetyModel>)))
  "Returns md5sum for a message object of type '<SafetyModel>"
  "535e7f80c93c8bb9ee4cf2f9bad94533")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SafetyModel)))
  "Returns md5sum for a message object of type 'SafetyModel"
  "535e7f80c93c8bb9ee4cf2f9bad94533")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SafetyModel>)))
  "Returns full string definition for message of type '<SafetyModel>"
  (cl:format cl:nil "uint32 hondaBoschGiraffe=5~%uint32 hondaNidec=1~%uint32 tesla=10~%uint32 subaru=11~%uint32 gm=4~%uint32 volkswagenPq=21~%uint32 silent=0~%uint32 noOutput=19~%uint32 allOutput=17~%uint32 elm327=3~%uint32 gmPassive=12~%uint32 cadillac=7~%uint32 hyundai=8~%uint32 ford=6~%uint32 mazda=13~%uint32 hondaBoschHarness=20~%uint32 volkswagen=15~%uint32 toyotaIpas=16~%uint32 nissan=14~%uint32 toyota=2~%uint32 chrysler=9~%uint32 gmAscm=18~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SafetyModel)))
  "Returns full string definition for message of type 'SafetyModel"
  (cl:format cl:nil "uint32 hondaBoschGiraffe=5~%uint32 hondaNidec=1~%uint32 tesla=10~%uint32 subaru=11~%uint32 gm=4~%uint32 volkswagenPq=21~%uint32 silent=0~%uint32 noOutput=19~%uint32 allOutput=17~%uint32 elm327=3~%uint32 gmPassive=12~%uint32 cadillac=7~%uint32 hyundai=8~%uint32 ford=6~%uint32 mazda=13~%uint32 hondaBoschHarness=20~%uint32 volkswagen=15~%uint32 toyotaIpas=16~%uint32 nissan=14~%uint32 toyota=2~%uint32 chrysler=9~%uint32 gmAscm=18~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SafetyModel>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SafetyModel>))
  "Converts a ROS message object to a list"
  (cl:list 'SafetyModel
))
