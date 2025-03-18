; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude MeasurementSource.msg.html

(cl:defclass <MeasurementSource> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass MeasurementSource (<MeasurementSource>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MeasurementSource>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MeasurementSource)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<MeasurementSource> is deprecated: use openpilot_bridge-msg:MeasurementSource instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MeasurementSource>)))
    "Constants for message type '<MeasurementSource>"
  '((:BEIDOU . 2)
    (:GLONASS . 1)
    (:GPS . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MeasurementSource)))
    "Constants for message type 'MeasurementSource"
  '((:BEIDOU . 2)
    (:GLONASS . 1)
    (:GPS . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MeasurementSource>) ostream)
  "Serializes a message object of type '<MeasurementSource>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MeasurementSource>) istream)
  "Deserializes a message object of type '<MeasurementSource>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MeasurementSource>)))
  "Returns string type for a message object of type '<MeasurementSource>"
  "openpilot_bridge/MeasurementSource")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MeasurementSource)))
  "Returns string type for a message object of type 'MeasurementSource"
  "openpilot_bridge/MeasurementSource")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MeasurementSource>)))
  "Returns md5sum for a message object of type '<MeasurementSource>"
  "9647811c69840716207e5d777760409f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MeasurementSource)))
  "Returns md5sum for a message object of type 'MeasurementSource"
  "9647811c69840716207e5d777760409f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MeasurementSource>)))
  "Returns full string definition for message of type '<MeasurementSource>"
  (cl:format cl:nil "uint32 beidou=2~%uint32 glonass=1~%uint32 gps=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MeasurementSource)))
  "Returns full string definition for message of type 'MeasurementSource"
  (cl:format cl:nil "uint32 beidou=2~%uint32 glonass=1~%uint32 gps=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MeasurementSource>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MeasurementSource>))
  "Converts a ROS message object to a list"
  (cl:list 'MeasurementSource
))
