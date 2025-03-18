; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ExceptionMission.msg.html

(cl:defclass <ExceptionMission> (roslisp-msg-protocol:ros-message)
  ((exception_event
    :reader exception_event
    :initarg :exception_event
    :type itri_msgs-msg:ExceptionEvent
    :initform (cl:make-instance 'itri_msgs-msg:ExceptionEvent))
   (request
    :reader request
    :initarg :request
    :type itri_msgs-msg:RequestState
    :initform (cl:make-instance 'itri_msgs-msg:RequestState))
   (mission
    :reader mission
    :initarg :mission
    :type itri_msgs-msg:MissionStatus
    :initform (cl:make-instance 'itri_msgs-msg:MissionStatus)))
)

(cl:defclass ExceptionMission (<ExceptionMission>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExceptionMission>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExceptionMission)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ExceptionMission> is deprecated: use itri_msgs-msg:ExceptionMission instead.")))

(cl:ensure-generic-function 'exception_event-val :lambda-list '(m))
(cl:defmethod exception_event-val ((m <ExceptionMission>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:exception_event-val is deprecated.  Use itri_msgs-msg:exception_event instead.")
  (exception_event m))

(cl:ensure-generic-function 'request-val :lambda-list '(m))
(cl:defmethod request-val ((m <ExceptionMission>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:request-val is deprecated.  Use itri_msgs-msg:request instead.")
  (request m))

(cl:ensure-generic-function 'mission-val :lambda-list '(m))
(cl:defmethod mission-val ((m <ExceptionMission>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:mission-val is deprecated.  Use itri_msgs-msg:mission instead.")
  (mission m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExceptionMission>) ostream)
  "Serializes a message object of type '<ExceptionMission>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'exception_event) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'request) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mission) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExceptionMission>) istream)
  "Deserializes a message object of type '<ExceptionMission>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'exception_event) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'request) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mission) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExceptionMission>)))
  "Returns string type for a message object of type '<ExceptionMission>"
  "itri_msgs/ExceptionMission")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionMission)))
  "Returns string type for a message object of type 'ExceptionMission"
  "itri_msgs/ExceptionMission")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExceptionMission>)))
  "Returns md5sum for a message object of type '<ExceptionMission>"
  "0471831326b1596371ad11eb9cb10158")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExceptionMission)))
  "Returns md5sum for a message object of type 'ExceptionMission"
  "0471831326b1596371ad11eb9cb10158")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExceptionMission>)))
  "Returns full string definition for message of type '<ExceptionMission>"
  (cl:format cl:nil "ExceptionEvent exception_event~%RequestState request~%MissionStatus mission~%~%================================================================================~%MSG: itri_msgs/ExceptionEvent~%# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%================================================================================~%MSG: itri_msgs/RequestState~%# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%================================================================================~%MSG: itri_msgs/MissionStatus~%# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExceptionMission)))
  "Returns full string definition for message of type 'ExceptionMission"
  (cl:format cl:nil "ExceptionEvent exception_event~%RequestState request~%MissionStatus mission~%~%================================================================================~%MSG: itri_msgs/ExceptionEvent~%# exception event~%uint8 NORMAL = 0~%uint8 HARD_BRAKE = 1~%uint8 MILD_BRAKE = 2~%uint8 DETOUR     = 3~%uint8 PULL_OVER  = 4~%uint8 TIME_OUT  = 5~%~%uint32 event~%~%================================================================================~%MSG: itri_msgs/RequestState~%# exception request_state~%uint8 NORMAL = 0~%uint8 REQUEST = 1~%uint8 RESUME = 2~%~%uint8 state~%~%================================================================================~%MSG: itri_msgs/MissionStatus~%# exception misssion status~%uint8 NORMAL = 0~%uint8 EXECUTION = 1~%uint8 COMPLETED = 2~%uint8 REQUEST = 3~%~%uint8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExceptionMission>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'exception_event))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'request))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mission))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExceptionMission>))
  "Converts a ROS message object to a list"
  (cl:list 'ExceptionMission
    (cl:cons ':exception_event (exception_event msg))
    (cl:cons ':request (request msg))
    (cl:cons ':mission (mission msg))
))
