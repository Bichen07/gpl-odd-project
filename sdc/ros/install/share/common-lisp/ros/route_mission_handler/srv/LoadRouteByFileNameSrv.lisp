; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-srv)


;//! \htmlinclude LoadRouteByFileNameSrv-request.msg.html

(cl:defclass <LoadRouteByFileNameSrv-request> (roslisp-msg-protocol:ros-message)
  ((selectedRouteFileName
    :reader selectedRouteFileName
    :initarg :selectedRouteFileName
    :type cl:string
    :initform ""))
)

(cl:defclass LoadRouteByFileNameSrv-request (<LoadRouteByFileNameSrv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadRouteByFileNameSrv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadRouteByFileNameSrv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-srv:<LoadRouteByFileNameSrv-request> is deprecated: use route_mission_handler-srv:LoadRouteByFileNameSrv-request instead.")))

(cl:ensure-generic-function 'selectedRouteFileName-val :lambda-list '(m))
(cl:defmethod selectedRouteFileName-val ((m <LoadRouteByFileNameSrv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-srv:selectedRouteFileName-val is deprecated.  Use route_mission_handler-srv:selectedRouteFileName instead.")
  (selectedRouteFileName m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadRouteByFileNameSrv-request>) ostream)
  "Serializes a message object of type '<LoadRouteByFileNameSrv-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'selectedRouteFileName))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'selectedRouteFileName))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadRouteByFileNameSrv-request>) istream)
  "Deserializes a message object of type '<LoadRouteByFileNameSrv-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'selectedRouteFileName) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'selectedRouteFileName) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadRouteByFileNameSrv-request>)))
  "Returns string type for a service object of type '<LoadRouteByFileNameSrv-request>"
  "route_mission_handler/LoadRouteByFileNameSrvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadRouteByFileNameSrv-request)))
  "Returns string type for a service object of type 'LoadRouteByFileNameSrv-request"
  "route_mission_handler/LoadRouteByFileNameSrvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadRouteByFileNameSrv-request>)))
  "Returns md5sum for a message object of type '<LoadRouteByFileNameSrv-request>"
  "68217d558fc6fb063653bf22c8dd0a04")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadRouteByFileNameSrv-request)))
  "Returns md5sum for a message object of type 'LoadRouteByFileNameSrv-request"
  "68217d558fc6fb063653bf22c8dd0a04")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadRouteByFileNameSrv-request>)))
  "Returns full string definition for message of type '<LoadRouteByFileNameSrv-request>"
  (cl:format cl:nil "string selectedRouteFileName~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadRouteByFileNameSrv-request)))
  "Returns full string definition for message of type 'LoadRouteByFileNameSrv-request"
  (cl:format cl:nil "string selectedRouteFileName~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadRouteByFileNameSrv-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'selectedRouteFileName))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadRouteByFileNameSrv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadRouteByFileNameSrv-request
    (cl:cons ':selectedRouteFileName (selectedRouteFileName msg))
))
;//! \htmlinclude LoadRouteByFileNameSrv-response.msg.html

(cl:defclass <LoadRouteByFileNameSrv-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LoadRouteByFileNameSrv-response (<LoadRouteByFileNameSrv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadRouteByFileNameSrv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadRouteByFileNameSrv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-srv:<LoadRouteByFileNameSrv-response> is deprecated: use route_mission_handler-srv:LoadRouteByFileNameSrv-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadRouteByFileNameSrv-response>) ostream)
  "Serializes a message object of type '<LoadRouteByFileNameSrv-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadRouteByFileNameSrv-response>) istream)
  "Deserializes a message object of type '<LoadRouteByFileNameSrv-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadRouteByFileNameSrv-response>)))
  "Returns string type for a service object of type '<LoadRouteByFileNameSrv-response>"
  "route_mission_handler/LoadRouteByFileNameSrvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadRouteByFileNameSrv-response)))
  "Returns string type for a service object of type 'LoadRouteByFileNameSrv-response"
  "route_mission_handler/LoadRouteByFileNameSrvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadRouteByFileNameSrv-response>)))
  "Returns md5sum for a message object of type '<LoadRouteByFileNameSrv-response>"
  "68217d558fc6fb063653bf22c8dd0a04")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadRouteByFileNameSrv-response)))
  "Returns md5sum for a message object of type 'LoadRouteByFileNameSrv-response"
  "68217d558fc6fb063653bf22c8dd0a04")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadRouteByFileNameSrv-response>)))
  "Returns full string definition for message of type '<LoadRouteByFileNameSrv-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadRouteByFileNameSrv-response)))
  "Returns full string definition for message of type 'LoadRouteByFileNameSrv-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadRouteByFileNameSrv-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadRouteByFileNameSrv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadRouteByFileNameSrv-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'LoadRouteByFileNameSrv)))
  'LoadRouteByFileNameSrv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'LoadRouteByFileNameSrv)))
  'LoadRouteByFileNameSrv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadRouteByFileNameSrv)))
  "Returns string type for a service object of type '<LoadRouteByFileNameSrv>"
  "route_mission_handler/LoadRouteByFileNameSrv")