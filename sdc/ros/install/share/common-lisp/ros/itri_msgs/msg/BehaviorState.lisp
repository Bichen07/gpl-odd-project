; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude BehaviorState.msg.html

(cl:defclass <BehaviorState> (roslisp-msg-protocol:ros-message)
  ((behavior_state
    :reader behavior_state
    :initarg :behavior_state
    :type cl:integer
    :initform 0)
   (behavior_stete_string
    :reader behavior_stete_string
    :initarg :behavior_stete_string
    :type cl:string
    :initform "")
   (obj_id
    :reader obj_id
    :initarg :obj_id
    :type cl:integer
    :initform 0)
   (obstacles
    :reader obstacles
    :initarg :obstacles
    :type cl:boolean
    :initform cl:nil)
   (avoidance
    :reader avoidance
    :initarg :avoidance
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass BehaviorState (<BehaviorState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BehaviorState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BehaviorState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<BehaviorState> is deprecated: use itri_msgs-msg:BehaviorState instead.")))

(cl:ensure-generic-function 'behavior_state-val :lambda-list '(m))
(cl:defmethod behavior_state-val ((m <BehaviorState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:behavior_state-val is deprecated.  Use itri_msgs-msg:behavior_state instead.")
  (behavior_state m))

(cl:ensure-generic-function 'behavior_stete_string-val :lambda-list '(m))
(cl:defmethod behavior_stete_string-val ((m <BehaviorState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:behavior_stete_string-val is deprecated.  Use itri_msgs-msg:behavior_stete_string instead.")
  (behavior_stete_string m))

(cl:ensure-generic-function 'obj_id-val :lambda-list '(m))
(cl:defmethod obj_id-val ((m <BehaviorState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:obj_id-val is deprecated.  Use itri_msgs-msg:obj_id instead.")
  (obj_id m))

(cl:ensure-generic-function 'obstacles-val :lambda-list '(m))
(cl:defmethod obstacles-val ((m <BehaviorState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:obstacles-val is deprecated.  Use itri_msgs-msg:obstacles instead.")
  (obstacles m))

(cl:ensure-generic-function 'avoidance-val :lambda-list '(m))
(cl:defmethod avoidance-val ((m <BehaviorState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:avoidance-val is deprecated.  Use itri_msgs-msg:avoidance instead.")
  (avoidance m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<BehaviorState>)))
    "Constants for message type '<BehaviorState>"
  '((:INITIAL . 0)
    (:AEB . 1)
    (:LANE_FOLLOW . 2)
    (:LANE_CHANGE . 3)
    (:AVOIDANCE . 4)
    (:STOP . 5)
    (:PARKING . 6)
    (:EMERGENCY . 7)
    (:FINISH . 8)
    (:ACC . 9)
    (:BUMP . 10)
    (:INTERSECTION . 11)
    (:TRAFFIC_LIGHT_RED . 12)
    (:TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT . 13)
    (:TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT . 14)
    (:CURVE . 15)
    (:SPEEDUP . 16)
    (:DESTINATIONWAYPOINTS . 17)
    (:DESTINATIONGLOBALPATH . 18))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'BehaviorState)))
    "Constants for message type 'BehaviorState"
  '((:INITIAL . 0)
    (:AEB . 1)
    (:LANE_FOLLOW . 2)
    (:LANE_CHANGE . 3)
    (:AVOIDANCE . 4)
    (:STOP . 5)
    (:PARKING . 6)
    (:EMERGENCY . 7)
    (:FINISH . 8)
    (:ACC . 9)
    (:BUMP . 10)
    (:INTERSECTION . 11)
    (:TRAFFIC_LIGHT_RED . 12)
    (:TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT . 13)
    (:TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT . 14)
    (:CURVE . 15)
    (:SPEEDUP . 16)
    (:DESTINATIONWAYPOINTS . 17)
    (:DESTINATIONGLOBALPATH . 18))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BehaviorState>) ostream)
  "Serializes a message object of type '<BehaviorState>"
  (cl:let* ((signed (cl:slot-value msg 'behavior_state)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'behavior_stete_string))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'behavior_stete_string))
  (cl:let* ((signed (cl:slot-value msg 'obj_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'obstacles) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'avoidance) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BehaviorState>) istream)
  "Deserializes a message object of type '<BehaviorState>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'behavior_state) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'behavior_stete_string) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'behavior_stete_string) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'obj_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'obstacles) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BehaviorState>)))
  "Returns string type for a message object of type '<BehaviorState>"
  "itri_msgs/BehaviorState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BehaviorState)))
  "Returns string type for a message object of type 'BehaviorState"
  "itri_msgs/BehaviorState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BehaviorState>)))
  "Returns md5sum for a message object of type '<BehaviorState>"
  "b7ef9dd36a2ceb7fe32edd273643bca2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BehaviorState)))
  "Returns md5sum for a message object of type 'BehaviorState"
  "b7ef9dd36a2ceb7fe32edd273643bca2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BehaviorState>)))
  "Returns full string definition for message of type '<BehaviorState>"
  (cl:format cl:nil "int32 behavior_state~%string behavior_stete_string~%~%uint8 INITIAL = 0~%uint8 AEB = 1~%uint8 LANE_FOLLOW = 2~%uint8 LANE_CHANGE = 3~%uint8 AVOIDANCE = 4~%uint8 STOP = 5~%uint8 PARKING = 6~%uint8 EMERGENCY = 7~%uint8 FINISH = 8~%uint8 ACC = 9~%uint8 BUMP = 10~%uint8 INTERSECTION = 11~%uint8 TRAFFIC_LIGHT_RED = 12~%uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT = 13~%uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT = 14~%uint8 CURVE = 15~%uint8 SPEEDUP = 16~%uint8 DestinationWaypoints = 17~%uint8 DestinationGlobalPath = 18~%~%~%int32 obj_id~%bool obstacles~%bool avoidance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BehaviorState)))
  "Returns full string definition for message of type 'BehaviorState"
  (cl:format cl:nil "int32 behavior_state~%string behavior_stete_string~%~%uint8 INITIAL = 0~%uint8 AEB = 1~%uint8 LANE_FOLLOW = 2~%uint8 LANE_CHANGE = 3~%uint8 AVOIDANCE = 4~%uint8 STOP = 5~%uint8 PARKING = 6~%uint8 EMERGENCY = 7~%uint8 FINISH = 8~%uint8 ACC = 9~%uint8 BUMP = 10~%uint8 INTERSECTION = 11~%uint8 TRAFFIC_LIGHT_RED = 12~%uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT = 13~%uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT = 14~%uint8 CURVE = 15~%uint8 SPEEDUP = 16~%uint8 DestinationWaypoints = 17~%uint8 DestinationGlobalPath = 18~%~%~%int32 obj_id~%bool obstacles~%bool avoidance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BehaviorState>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'behavior_stete_string))
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BehaviorState>))
  "Converts a ROS message object to a list"
  (cl:list 'BehaviorState
    (cl:cons ':behavior_state (behavior_state msg))
    (cl:cons ':behavior_stete_string (behavior_stete_string msg))
    (cl:cons ':obj_id (obj_id msg))
    (cl:cons ':obstacles (obstacles msg))
    (cl:cons ':avoidance (avoidance msg))
))
