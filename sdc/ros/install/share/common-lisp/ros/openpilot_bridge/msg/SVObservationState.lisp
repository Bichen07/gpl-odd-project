; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SVObservationState.msg.html

(cl:defclass <SVObservationState> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SVObservationState (<SVObservationState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SVObservationState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SVObservationState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SVObservationState> is deprecated: use openpilot_bridge-msg:SVObservationState instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SVObservationState>)))
    "Constants for message type '<SVObservationState>"
  '((:SEARCH . 1)
    (:BITEDGE . 3)
    (:TRACK . 5)
    (:GLO10MSAT . 9)
    (:IDLE . 0)
    (:TRACKVERIFY . 4)
    (:SEARCHVERIFY . 2)
    (:DPO . 7)
    (:RESTART . 6)
    (:GLO10MSBE . 8))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SVObservationState)))
    "Constants for message type 'SVObservationState"
  '((:SEARCH . 1)
    (:BITEDGE . 3)
    (:TRACK . 5)
    (:GLO10MSAT . 9)
    (:IDLE . 0)
    (:TRACKVERIFY . 4)
    (:SEARCHVERIFY . 2)
    (:DPO . 7)
    (:RESTART . 6)
    (:GLO10MSBE . 8))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SVObservationState>) ostream)
  "Serializes a message object of type '<SVObservationState>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SVObservationState>) istream)
  "Deserializes a message object of type '<SVObservationState>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SVObservationState>)))
  "Returns string type for a message object of type '<SVObservationState>"
  "openpilot_bridge/SVObservationState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SVObservationState)))
  "Returns string type for a message object of type 'SVObservationState"
  "openpilot_bridge/SVObservationState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SVObservationState>)))
  "Returns md5sum for a message object of type '<SVObservationState>"
  "ca9b9510f6b206850baa3731f543e7df")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SVObservationState)))
  "Returns md5sum for a message object of type 'SVObservationState"
  "ca9b9510f6b206850baa3731f543e7df")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SVObservationState>)))
  "Returns full string definition for message of type '<SVObservationState>"
  (cl:format cl:nil "uint32 search=1~%uint32 bitEdge=3~%uint32 track=5~%uint32 glo10msAt=9~%uint32 idle=0~%uint32 trackVerify=4~%uint32 searchVerify=2~%uint32 dpo=7~%uint32 restart=6~%uint32 glo10msBe=8~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SVObservationState)))
  "Returns full string definition for message of type 'SVObservationState"
  (cl:format cl:nil "uint32 search=1~%uint32 bitEdge=3~%uint32 track=5~%uint32 glo10msAt=9~%uint32 idle=0~%uint32 trackVerify=4~%uint32 searchVerify=2~%uint32 dpo=7~%uint32 restart=6~%uint32 glo10msBe=8~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SVObservationState>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SVObservationState>))
  "Converts a ROS message object to a list"
  (cl:list 'SVObservationState
))
