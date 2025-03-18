; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude UsbPowerMode.msg.html

(cl:defclass <UsbPowerMode> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass UsbPowerMode (<UsbPowerMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UsbPowerMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UsbPowerMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<UsbPowerMode> is deprecated: use openpilot_bridge-msg:UsbPowerMode instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UsbPowerMode>)))
    "Constants for message type '<UsbPowerMode>"
  '((:NONE . 0)
    (:CLIENT . 1)
    (:CDP . 2)
    (:DCP . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UsbPowerMode)))
    "Constants for message type 'UsbPowerMode"
  '((:NONE . 0)
    (:CLIENT . 1)
    (:CDP . 2)
    (:DCP . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UsbPowerMode>) ostream)
  "Serializes a message object of type '<UsbPowerMode>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UsbPowerMode>) istream)
  "Deserializes a message object of type '<UsbPowerMode>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UsbPowerMode>)))
  "Returns string type for a message object of type '<UsbPowerMode>"
  "openpilot_bridge/UsbPowerMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UsbPowerMode)))
  "Returns string type for a message object of type 'UsbPowerMode"
  "openpilot_bridge/UsbPowerMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UsbPowerMode>)))
  "Returns md5sum for a message object of type '<UsbPowerMode>"
  "0ed062df39951268215b5a9aabd60f17")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UsbPowerMode)))
  "Returns md5sum for a message object of type 'UsbPowerMode"
  "0ed062df39951268215b5a9aabd60f17")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UsbPowerMode>)))
  "Returns full string definition for message of type '<UsbPowerMode>"
  (cl:format cl:nil "uint32 none=0~%uint32 client=1~%uint32 cdp=2~%uint32 dcp=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UsbPowerMode)))
  "Returns full string definition for message of type 'UsbPowerMode"
  (cl:format cl:nil "uint32 none=0~%uint32 client=1~%uint32 cdp=2~%uint32 dcp=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UsbPowerMode>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UsbPowerMode>))
  "Converts a ROS message object to a list"
  (cl:list 'UsbPowerMode
))
