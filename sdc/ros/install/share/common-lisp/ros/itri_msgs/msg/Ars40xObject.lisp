; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude Ars40xObject.msg.html

(cl:defclass <Ars40xObject> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:float
    :initform 0.0)
   (length
    :reader length
    :initarg :length
    :type cl:float
    :initform 0.0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (velocity
    :reader velocity
    :initarg :velocity
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type geometry_msgs-msg:Accel
    :initform (cl:make-instance 'geometry_msgs-msg:Accel))
   (radar_cross_section
    :reader radar_cross_section
    :initarg :radar_cross_section
    :type cl:float
    :initform 0.0)
   (Class
    :reader Class
    :initarg :Class
    :type cl:fixnum
    :initform 0)
   (dynamic
    :reader dynamic
    :initarg :dynamic
    :type cl:fixnum
    :initform 0)
   (measurment
    :reader measurment
    :initarg :measurment
    :type cl:fixnum
    :initform 0)
   (probability
    :reader probability
    :initarg :probability
    :type cl:float
    :initform 0.0))
)

(cl:defclass Ars40xObject (<Ars40xObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ars40xObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ars40xObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<Ars40xObject> is deprecated: use itri_msgs-msg:Ars40xObject instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:width-val is deprecated.  Use itri_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:length-val is deprecated.  Use itri_msgs-msg:length instead.")
  (length m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocity-val is deprecated.  Use itri_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:acceleration-val is deprecated.  Use itri_msgs-msg:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'radar_cross_section-val :lambda-list '(m))
(cl:defmethod radar_cross_section-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:radar_cross_section-val is deprecated.  Use itri_msgs-msg:radar_cross_section instead.")
  (radar_cross_section m))

(cl:ensure-generic-function 'Class-val :lambda-list '(m))
(cl:defmethod Class-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:Class-val is deprecated.  Use itri_msgs-msg:Class instead.")
  (Class m))

(cl:ensure-generic-function 'dynamic-val :lambda-list '(m))
(cl:defmethod dynamic-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:dynamic-val is deprecated.  Use itri_msgs-msg:dynamic instead.")
  (dynamic m))

(cl:ensure-generic-function 'measurment-val :lambda-list '(m))
(cl:defmethod measurment-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:measurment-val is deprecated.  Use itri_msgs-msg:measurment instead.")
  (measurment m))

(cl:ensure-generic-function 'probability-val :lambda-list '(m))
(cl:defmethod probability-val ((m <Ars40xObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:probability-val is deprecated.  Use itri_msgs-msg:probability instead.")
  (probability m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Ars40xObject>)))
    "Constants for message type '<Ars40xObject>"
  '((:POINT . 0)
    (:CAR . 1)
    (:TRUCK . 2)
    (:MOTORCYCLE . 4)
    (:BICYCLE . 5)
    (:WIDE . 6)
    (:MOVING . 0)
    (:STATIONARY . 1)
    (:ONCOMING . 2)
    (:STATIONARY_CANDIDATE . 3)
    (:UNKNOWN . 4)
    (:CROSSING_STATIONARY . 5)
    (:CROSSING_MOVING . 6)
    (:STOPPED . 7)
    (:DELETED . 0)
    (:NEW_CREATED . 1)
    (:MEASURED . 2)
    (:PREDICTED . 3)
    (:DELETED_FOR_MERGE . 4)
    (:NEW_FROM_MERGE . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Ars40xObject)))
    "Constants for message type 'Ars40xObject"
  '((:POINT . 0)
    (:CAR . 1)
    (:TRUCK . 2)
    (:MOTORCYCLE . 4)
    (:BICYCLE . 5)
    (:WIDE . 6)
    (:MOVING . 0)
    (:STATIONARY . 1)
    (:ONCOMING . 2)
    (:STATIONARY_CANDIDATE . 3)
    (:UNKNOWN . 4)
    (:CROSSING_STATIONARY . 5)
    (:CROSSING_MOVING . 6)
    (:STOPPED . 7)
    (:DELETED . 0)
    (:NEW_CREATED . 1)
    (:MEASURED . 2)
    (:PREDICTED . 3)
    (:DELETED_FOR_MERGE . 4)
    (:NEW_FROM_MERGE . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ars40xObject>) ostream)
  "Serializes a message object of type '<Ars40xObject>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'acceleration) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'radar_cross_section))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Class)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dynamic)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'measurment)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'probability))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ars40xObject>) istream)
  "Deserializes a message object of type '<Ars40xObject>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'width) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'length) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'acceleration) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'radar_cross_section) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Class)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dynamic)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'measurment)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'probability) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ars40xObject>)))
  "Returns string type for a message object of type '<Ars40xObject>"
  "itri_msgs/Ars40xObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ars40xObject)))
  "Returns string type for a message object of type 'Ars40xObject"
  "itri_msgs/Ars40xObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ars40xObject>)))
  "Returns md5sum for a message object of type '<Ars40xObject>"
  "0f77a1c96789bbc33d08f7bf24542202")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ars40xObject)))
  "Returns md5sum for a message object of type 'Ars40xObject"
  "0f77a1c96789bbc33d08f7bf24542202")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ars40xObject>)))
  "Returns full string definition for message of type '<Ars40xObject>"
  (cl:format cl:nil "# while persists in consecutive messages - it is the same object, if disappears and appears again - new one~%uint8 id~%~%float32 width~%float32 length~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%geometry_msgs/Accel acceleration~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 POINT = 0~%uint8 CAR = 1~%uint8 TRUCK = 2~%uint8 MOTORCYCLE = 4~%uint8 BICYCLE = 5~%uint8 WIDE = 6~%uint8 Class~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 DELETED = 0~%uint8 NEW_CREATED = 1~%uint8 MEASURED = 2~%uint8 PREDICTED = 3~%uint8 DELETED_FOR_MERGE = 4~%uint8 NEW_FROM_MERGE = 5~%uint8 measurment~%~%# probability of existence, percentage~%float32 probability~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Accel~%# This expresses acceleration in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ars40xObject)))
  "Returns full string definition for message of type 'Ars40xObject"
  (cl:format cl:nil "# while persists in consecutive messages - it is the same object, if disappears and appears again - new one~%uint8 id~%~%float32 width~%float32 length~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%geometry_msgs/Accel acceleration~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 POINT = 0~%uint8 CAR = 1~%uint8 TRUCK = 2~%uint8 MOTORCYCLE = 4~%uint8 BICYCLE = 5~%uint8 WIDE = 6~%uint8 Class~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 DELETED = 0~%uint8 NEW_CREATED = 1~%uint8 MEASURED = 2~%uint8 PREDICTED = 3~%uint8 DELETED_FOR_MERGE = 4~%uint8 NEW_FROM_MERGE = 5~%uint8 measurment~%~%# probability of existence, percentage~%float32 probability~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Accel~%# This expresses acceleration in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ars40xObject>))
  (cl:+ 0
     1
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'acceleration))
     4
     1
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ars40xObject>))
  "Converts a ROS message object to a list"
  (cl:list 'Ars40xObject
    (cl:cons ':id (id msg))
    (cl:cons ':width (width msg))
    (cl:cons ':length (length msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':radar_cross_section (radar_cross_section msg))
    (cl:cons ':Class (Class msg))
    (cl:cons ':dynamic (dynamic msg))
    (cl:cons ':measurment (measurment msg))
    (cl:cons ':probability (probability msg))
))
