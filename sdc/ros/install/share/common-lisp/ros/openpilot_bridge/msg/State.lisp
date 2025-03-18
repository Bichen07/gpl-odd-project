; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude State.msg.html

(cl:defclass <State> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass State (<State>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <State>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'State)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<State> is deprecated: use openpilot_bridge-msg:State instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<State>)))
    "Constants for message type '<State>"
  '((:BDSD2BITSYNC . 9)
    (:TOWDECODED . 4)
    (:GALE1BCCODELOCK . 11)
    (:SBASSYNC . 14)
    (:SYMBOLSYNC . 6)
    (:UNKNOWN . 0)
    (:BDSD2SUBFRAMESYNC . 10)
    (:CODELOCK . 1)
    (:SUBFRAMESYNC . 3)
    (:GALE1BPAGESYNC . 13)
    (:BITSYNC . 2)
    (:GALE1C2NDCODELOCK . 12)
    (:GLOSTRINGSYNC . 7)
    (:GLOTODDECODED . 8)
    (:MSECAMBIGUOUS . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'State)))
    "Constants for message type 'State"
  '((:BDSD2BITSYNC . 9)
    (:TOWDECODED . 4)
    (:GALE1BCCODELOCK . 11)
    (:SBASSYNC . 14)
    (:SYMBOLSYNC . 6)
    (:UNKNOWN . 0)
    (:BDSD2SUBFRAMESYNC . 10)
    (:CODELOCK . 1)
    (:SUBFRAMESYNC . 3)
    (:GALE1BPAGESYNC . 13)
    (:BITSYNC . 2)
    (:GALE1C2NDCODELOCK . 12)
    (:GLOSTRINGSYNC . 7)
    (:GLOTODDECODED . 8)
    (:MSECAMBIGUOUS . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <State>) ostream)
  "Serializes a message object of type '<State>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <State>) istream)
  "Deserializes a message object of type '<State>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<State>)))
  "Returns string type for a message object of type '<State>"
  "openpilot_bridge/State")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'State)))
  "Returns string type for a message object of type 'State"
  "openpilot_bridge/State")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<State>)))
  "Returns md5sum for a message object of type '<State>"
  "e9a71513332f5cfbf861cb985b6c816e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'State)))
  "Returns md5sum for a message object of type 'State"
  "e9a71513332f5cfbf861cb985b6c816e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<State>)))
  "Returns full string definition for message of type '<State>"
  (cl:format cl:nil "uint32 bdsD2BitSync=9~%uint32 towDecoded=4~%uint32 galE1bcCodeLock=11~%uint32 sbasSync=14~%uint32 symbolSync=6~%uint32 unknown=0~%uint32 bdsD2SubframeSync=10~%uint32 codeLock=1~%uint32 subframeSync=3~%uint32 galE1bPageSync=13~%uint32 bitSync=2~%uint32 galE1c2ndCodeLock=12~%uint32 gloStringSync=7~%uint32 gloTodDecoded=8~%uint32 msecAmbiguous=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'State)))
  "Returns full string definition for message of type 'State"
  (cl:format cl:nil "uint32 bdsD2BitSync=9~%uint32 towDecoded=4~%uint32 galE1bcCodeLock=11~%uint32 sbasSync=14~%uint32 symbolSync=6~%uint32 unknown=0~%uint32 bdsD2SubframeSync=10~%uint32 codeLock=1~%uint32 subframeSync=3~%uint32 galE1bPageSync=13~%uint32 bitSync=2~%uint32 galE1c2ndCodeLock=12~%uint32 gloStringSync=7~%uint32 gloTodDecoded=8~%uint32 msecAmbiguous=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <State>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <State>))
  "Converts a ROS message object to a list"
  (cl:list 'State
))
