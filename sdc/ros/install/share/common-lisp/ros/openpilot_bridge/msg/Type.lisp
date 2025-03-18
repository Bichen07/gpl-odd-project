; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Type.msg.html

(cl:defclass <Type> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Type (<Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Type> is deprecated: use openpilot_bridge-msg:Type instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Type>)))
    "Constants for message type '<Type>"
  '((:DECELCRUISE . 4)
    (:ACCELCRUISE . 3)
    (:LEFTBLINKER . 1)
    (:UNKNOWN . 0)
    (:SETCRUISE . 9)
    (:GAPADJUSTCRUISE . 11)
    (:RESUMECRUISE . 10)
    (:RIGHTBLINKER . 2)
    (:ALTBUTTON1 . 6)
    (:CANCEL . 5)
    (:ALTBUTTON3 . 8)
    (:ALTBUTTON2 . 7))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Type)))
    "Constants for message type 'Type"
  '((:DECELCRUISE . 4)
    (:ACCELCRUISE . 3)
    (:LEFTBLINKER . 1)
    (:UNKNOWN . 0)
    (:SETCRUISE . 9)
    (:GAPADJUSTCRUISE . 11)
    (:RESUMECRUISE . 10)
    (:RIGHTBLINKER . 2)
    (:ALTBUTTON1 . 6)
    (:CANCEL . 5)
    (:ALTBUTTON3 . 8)
    (:ALTBUTTON2 . 7))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Type>) ostream)
  "Serializes a message object of type '<Type>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Type>) istream)
  "Deserializes a message object of type '<Type>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Type>)))
  "Returns string type for a message object of type '<Type>"
  "openpilot_bridge/Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Type)))
  "Returns string type for a message object of type 'Type"
  "openpilot_bridge/Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Type>)))
  "Returns md5sum for a message object of type '<Type>"
  "15c6e84d22188be8e7284ad21b8ff2fe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Type)))
  "Returns md5sum for a message object of type 'Type"
  "15c6e84d22188be8e7284ad21b8ff2fe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Type>)))
  "Returns full string definition for message of type '<Type>"
  (cl:format cl:nil "uint32 decelCruise=4~%uint32 accelCruise=3~%uint32 leftBlinker=1~%uint32 unknown=0~%uint32 setCruise=9~%uint32 gapAdjustCruise=11~%uint32 resumeCruise=10~%uint32 rightBlinker=2~%uint32 altButton1=6~%uint32 cancel=5~%uint32 altButton3=8~%uint32 altButton2=7~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Type)))
  "Returns full string definition for message of type 'Type"
  (cl:format cl:nil "uint32 decelCruise=4~%uint32 accelCruise=3~%uint32 leftBlinker=1~%uint32 unknown=0~%uint32 setCruise=9~%uint32 gapAdjustCruise=11~%uint32 resumeCruise=10~%uint32 rightBlinker=2~%uint32 altButton1=6~%uint32 cancel=5~%uint32 altButton3=8~%uint32 altButton2=7~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Type>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Type>))
  "Converts a ROS message object to a list"
  (cl:list 'Type
))
