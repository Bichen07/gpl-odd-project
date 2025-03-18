; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LongitudinalPlanSource.msg.html

(cl:defclass <LongitudinalPlanSource> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LongitudinalPlanSource (<LongitudinalPlanSource>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LongitudinalPlanSource>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LongitudinalPlanSource)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LongitudinalPlanSource> is deprecated: use openpilot_bridge-msg:LongitudinalPlanSource instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<LongitudinalPlanSource>)))
    "Constants for message type '<LongitudinalPlanSource>"
  '((:MODEL . 4)
    (:MPC1 . 1)
    (:MPC2 . 2)
    (:MPC3 . 3)
    (:CRUISE . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'LongitudinalPlanSource)))
    "Constants for message type 'LongitudinalPlanSource"
  '((:MODEL . 4)
    (:MPC1 . 1)
    (:MPC2 . 2)
    (:MPC3 . 3)
    (:CRUISE . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LongitudinalPlanSource>) ostream)
  "Serializes a message object of type '<LongitudinalPlanSource>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LongitudinalPlanSource>) istream)
  "Deserializes a message object of type '<LongitudinalPlanSource>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LongitudinalPlanSource>)))
  "Returns string type for a message object of type '<LongitudinalPlanSource>"
  "openpilot_bridge/LongitudinalPlanSource")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LongitudinalPlanSource)))
  "Returns string type for a message object of type 'LongitudinalPlanSource"
  "openpilot_bridge/LongitudinalPlanSource")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LongitudinalPlanSource>)))
  "Returns md5sum for a message object of type '<LongitudinalPlanSource>"
  "6dc6b7eb09997044411ec119a9eedd80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LongitudinalPlanSource)))
  "Returns md5sum for a message object of type 'LongitudinalPlanSource"
  "6dc6b7eb09997044411ec119a9eedd80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LongitudinalPlanSource>)))
  "Returns full string definition for message of type '<LongitudinalPlanSource>"
  (cl:format cl:nil "uint32 model=4~%uint32 mpc1=1~%uint32 mpc2=2~%uint32 mpc3=3~%uint32 cruise=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LongitudinalPlanSource)))
  "Returns full string definition for message of type 'LongitudinalPlanSource"
  (cl:format cl:nil "uint32 model=4~%uint32 mpc1=1~%uint32 mpc2=2~%uint32 mpc3=3~%uint32 cruise=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LongitudinalPlanSource>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LongitudinalPlanSource>))
  "Converts a ROS message object to a list"
  (cl:list 'LongitudinalPlanSource
))
