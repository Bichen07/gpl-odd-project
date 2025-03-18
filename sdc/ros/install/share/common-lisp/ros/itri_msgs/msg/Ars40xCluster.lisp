; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude Ars40xCluster.msg.html

(cl:defclass <Ars40xCluster> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
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
   (radar_cross_section
    :reader radar_cross_section
    :initarg :radar_cross_section
    :type cl:float
    :initform 0.0)
   (dynamic
    :reader dynamic
    :initarg :dynamic
    :type cl:fixnum
    :initform 0)
   (ambiguity
    :reader ambiguity
    :initarg :ambiguity
    :type cl:fixnum
    :initform 0)
   (validity
    :reader validity
    :initarg :validity
    :type cl:fixnum
    :initform 0)
   (probability
    :reader probability
    :initarg :probability
    :type cl:float
    :initform 0.0)
   (is_near
    :reader is_near
    :initarg :is_near
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Ars40xCluster (<Ars40xCluster>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ars40xCluster>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ars40xCluster)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<Ars40xCluster> is deprecated: use itri_msgs-msg:Ars40xCluster instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocity-val is deprecated.  Use itri_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'radar_cross_section-val :lambda-list '(m))
(cl:defmethod radar_cross_section-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:radar_cross_section-val is deprecated.  Use itri_msgs-msg:radar_cross_section instead.")
  (radar_cross_section m))

(cl:ensure-generic-function 'dynamic-val :lambda-list '(m))
(cl:defmethod dynamic-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:dynamic-val is deprecated.  Use itri_msgs-msg:dynamic instead.")
  (dynamic m))

(cl:ensure-generic-function 'ambiguity-val :lambda-list '(m))
(cl:defmethod ambiguity-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ambiguity-val is deprecated.  Use itri_msgs-msg:ambiguity instead.")
  (ambiguity m))

(cl:ensure-generic-function 'validity-val :lambda-list '(m))
(cl:defmethod validity-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:validity-val is deprecated.  Use itri_msgs-msg:validity instead.")
  (validity m))

(cl:ensure-generic-function 'probability-val :lambda-list '(m))
(cl:defmethod probability-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:probability-val is deprecated.  Use itri_msgs-msg:probability instead.")
  (probability m))

(cl:ensure-generic-function 'is_near-val :lambda-list '(m))
(cl:defmethod is_near-val ((m <Ars40xCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:is_near-val is deprecated.  Use itri_msgs-msg:is_near instead.")
  (is_near m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Ars40xCluster>)))
    "Constants for message type '<Ars40xCluster>"
  '((:MOVING . 0)
    (:STATIONARY . 1)
    (:ONCOMING . 2)
    (:STATIONARY_CANDIDATE . 3)
    (:UNKNOWN . 4)
    (:CROSSING_STATIONARY . 5)
    (:CROSSING_MOVING . 6)
    (:STOPPED . 7)
    (:INVALID . 0)
    (:AMBIGUOUS . 1)
    (:STAGGERED_RAMP . 2)
    (:UNAMBIGUOUS . 3)
    (:STATIONARY_CANDIDATES . 4)
    (:VALID . 0)
    (:INVALID_DUE_TO_LOW_RCS . 1)
    (:INVALID_DUE_TO_NEAR_FIELD_ARTEFACT . 2)
    (:INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE . 3)
    (:VALID_WITH_LOW_RCS . 4)
    (:INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY . 6)
    (:INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW . 7)
    (:VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION . 8)
    (:VALID_WITH_HIGH_CHILD_PROB . 9)
    (:VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT . 10)
    (:VALID_BUT_NO_LOCAL_MAXIMUM . 11)
    (:VALID_WITH_HIGH_ARTEFACT_PROB . 12)
    (:INVALID_BECAUSE_IT_IS_HARMONIC . 14)
    (:VALID_ABOVE_95M_IN_NEAR_RANGE . 15)
    (:VALID_WITH_HIGH_MULTI_TARGET_PROB . 16)
    (:VALID_WITH_SUSPICIOUS_ANGLE . 17))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Ars40xCluster)))
    "Constants for message type 'Ars40xCluster"
  '((:MOVING . 0)
    (:STATIONARY . 1)
    (:ONCOMING . 2)
    (:STATIONARY_CANDIDATE . 3)
    (:UNKNOWN . 4)
    (:CROSSING_STATIONARY . 5)
    (:CROSSING_MOVING . 6)
    (:STOPPED . 7)
    (:INVALID . 0)
    (:AMBIGUOUS . 1)
    (:STAGGERED_RAMP . 2)
    (:UNAMBIGUOUS . 3)
    (:STATIONARY_CANDIDATES . 4)
    (:VALID . 0)
    (:INVALID_DUE_TO_LOW_RCS . 1)
    (:INVALID_DUE_TO_NEAR_FIELD_ARTEFACT . 2)
    (:INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE . 3)
    (:VALID_WITH_LOW_RCS . 4)
    (:INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY . 6)
    (:INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW . 7)
    (:VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION . 8)
    (:VALID_WITH_HIGH_CHILD_PROB . 9)
    (:VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT . 10)
    (:VALID_BUT_NO_LOCAL_MAXIMUM . 11)
    (:VALID_WITH_HIGH_ARTEFACT_PROB . 12)
    (:INVALID_BECAUSE_IT_IS_HARMONIC . 14)
    (:VALID_ABOVE_95M_IN_NEAR_RANGE . 15)
    (:VALID_WITH_HIGH_MULTI_TARGET_PROB . 16)
    (:VALID_WITH_SUSPICIOUS_ANGLE . 17))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ars40xCluster>) ostream)
  "Serializes a message object of type '<Ars40xCluster>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'radar_cross_section))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dynamic)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ambiguity)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'validity)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'probability))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_near) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ars40xCluster>) istream)
  "Deserializes a message object of type '<Ars40xCluster>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'radar_cross_section) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dynamic)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ambiguity)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'validity)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'probability) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'is_near) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ars40xCluster>)))
  "Returns string type for a message object of type '<Ars40xCluster>"
  "itri_msgs/Ars40xCluster")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ars40xCluster)))
  "Returns string type for a message object of type 'Ars40xCluster"
  "itri_msgs/Ars40xCluster")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ars40xCluster>)))
  "Returns md5sum for a message object of type '<Ars40xCluster>"
  "04db439c9c17d17c68474bb1a9a0c1c8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ars40xCluster)))
  "Returns md5sum for a message object of type 'Ars40xCluster"
  "04db439c9c17d17c68474bb1a9a0c1c8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ars40xCluster>)))
  "Returns full string definition for message of type '<Ars40xCluster>"
  (cl:format cl:nil "uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ars40xCluster)))
  "Returns full string definition for message of type 'Ars40xCluster"
  (cl:format cl:nil "uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ars40xCluster>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     4
     1
     1
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ars40xCluster>))
  "Converts a ROS message object to a list"
  (cl:list 'Ars40xCluster
    (cl:cons ':id (id msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':radar_cross_section (radar_cross_section msg))
    (cl:cons ':dynamic (dynamic msg))
    (cl:cons ':ambiguity (ambiguity msg))
    (cl:cons ':validity (validity msg))
    (cl:cons ':probability (probability msg))
    (cl:cons ':is_near (is_near msg))
))
