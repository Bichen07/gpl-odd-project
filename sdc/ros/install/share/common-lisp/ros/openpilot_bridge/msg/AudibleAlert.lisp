; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude AudibleAlert.msg.html

(cl:defclass <AudibleAlert> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AudibleAlert (<AudibleAlert>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AudibleAlert>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AudibleAlert)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<AudibleAlert> is deprecated: use openpilot_bridge-msg:AudibleAlert instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AudibleAlert>)))
    "Constants for message type '<AudibleAlert>"
  '((:NONE . 0)
    (:CHIMEDISENGAGE . 2)
    (:CHIMEWARNING1 . 4)
    (:CHIMEWARNING2 . 5)
    (:CHIMEERROR . 3)
    (:CHIMEPROMPT . 7)
    (:CHIMEENGAGE . 1)
    (:CHIMEWARNINGREPEAT . 6))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AudibleAlert)))
    "Constants for message type 'AudibleAlert"
  '((:NONE . 0)
    (:CHIMEDISENGAGE . 2)
    (:CHIMEWARNING1 . 4)
    (:CHIMEWARNING2 . 5)
    (:CHIMEERROR . 3)
    (:CHIMEPROMPT . 7)
    (:CHIMEENGAGE . 1)
    (:CHIMEWARNINGREPEAT . 6))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AudibleAlert>) ostream)
  "Serializes a message object of type '<AudibleAlert>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AudibleAlert>) istream)
  "Deserializes a message object of type '<AudibleAlert>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AudibleAlert>)))
  "Returns string type for a message object of type '<AudibleAlert>"
  "openpilot_bridge/AudibleAlert")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AudibleAlert)))
  "Returns string type for a message object of type 'AudibleAlert"
  "openpilot_bridge/AudibleAlert")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AudibleAlert>)))
  "Returns md5sum for a message object of type '<AudibleAlert>"
  "a3a43922546d4bc971a70d5e2c552051")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AudibleAlert)))
  "Returns md5sum for a message object of type 'AudibleAlert"
  "a3a43922546d4bc971a70d5e2c552051")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AudibleAlert>)))
  "Returns full string definition for message of type '<AudibleAlert>"
  (cl:format cl:nil "uint32 none=0~%uint32 chimeDisengage=2~%uint32 chimeWarning1=4~%uint32 chimeWarning2=5~%uint32 chimeError=3~%uint32 chimePrompt=7~%uint32 chimeEngage=1~%uint32 chimeWarningRepeat=6~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AudibleAlert)))
  "Returns full string definition for message of type 'AudibleAlert"
  (cl:format cl:nil "uint32 none=0~%uint32 chimeDisengage=2~%uint32 chimeWarning1=4~%uint32 chimeWarning2=5~%uint32 chimeError=3~%uint32 chimePrompt=7~%uint32 chimeEngage=1~%uint32 chimeWarningRepeat=6~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AudibleAlert>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AudibleAlert>))
  "Converts a ROS message object to a list"
  (cl:list 'AudibleAlert
))
