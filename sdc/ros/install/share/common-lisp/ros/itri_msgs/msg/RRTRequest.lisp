; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude RRTRequest.msg.html

(cl:defclass <RRTRequest> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (wait_time
    :reader wait_time
    :initarg :wait_time
    :type cl:float
    :initform 0.0)
   (start
    :reader start
    :initarg :start
    :type itri_msgs-msg:CarState
    :initform (cl:make-instance 'itri_msgs-msg:CarState))
   (end
    :reader end
    :initarg :end
    :type itri_msgs-msg:CarState
    :initform (cl:make-instance 'itri_msgs-msg:CarState))
   (parking_space
    :reader parking_space
    :initarg :parking_space
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (set_radius
    :reader set_radius
    :initarg :set_radius
    :type cl:boolean
    :initform cl:nil)
   (radius
    :reader radius
    :initarg :radius
    :type cl:float
    :initform 0.0)
   (directional
    :reader directional
    :initarg :directional
    :type cl:fixnum
    :initform 0))
)

(cl:defclass RRTRequest (<RRTRequest>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RRTRequest>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RRTRequest)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<RRTRequest> is deprecated: use itri_msgs-msg:RRTRequest instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'wait_time-val :lambda-list '(m))
(cl:defmethod wait_time-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:wait_time-val is deprecated.  Use itri_msgs-msg:wait_time instead.")
  (wait_time m))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:start-val is deprecated.  Use itri_msgs-msg:start instead.")
  (start m))

(cl:ensure-generic-function 'end-val :lambda-list '(m))
(cl:defmethod end-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:end-val is deprecated.  Use itri_msgs-msg:end instead.")
  (end m))

(cl:ensure-generic-function 'parking_space-val :lambda-list '(m))
(cl:defmethod parking_space-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parking_space-val is deprecated.  Use itri_msgs-msg:parking_space instead.")
  (parking_space m))

(cl:ensure-generic-function 'set_radius-val :lambda-list '(m))
(cl:defmethod set_radius-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:set_radius-val is deprecated.  Use itri_msgs-msg:set_radius instead.")
  (set_radius m))

(cl:ensure-generic-function 'radius-val :lambda-list '(m))
(cl:defmethod radius-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:radius-val is deprecated.  Use itri_msgs-msg:radius instead.")
  (radius m))

(cl:ensure-generic-function 'directional-val :lambda-list '(m))
(cl:defmethod directional-val ((m <RRTRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:directional-val is deprecated.  Use itri_msgs-msg:directional instead.")
  (directional m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<RRTRequest>)))
    "Constants for message type '<RRTRequest>"
  '((:ENTER . 0)
    (:LEAVE . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'RRTRequest)))
    "Constants for message type 'RRTRequest"
  '((:ENTER . 0)
    (:LEAVE . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RRTRequest>) ostream)
  "Serializes a message object of type '<RRTRequest>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'wait_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'start) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'end) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parking_space))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'parking_space))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'set_radius) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'radius))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'directional)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RRTRequest>) istream)
  "Deserializes a message object of type '<RRTRequest>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'wait_time) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'start) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'end) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parking_space) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parking_space)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'set_radius) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'radius) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'directional)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RRTRequest>)))
  "Returns string type for a message object of type '<RRTRequest>"
  "itri_msgs/RRTRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RRTRequest)))
  "Returns string type for a message object of type 'RRTRequest"
  "itri_msgs/RRTRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RRTRequest>)))
  "Returns md5sum for a message object of type '<RRTRequest>"
  "45ab4e6a1f02be793e6ab32ee1973a5e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RRTRequest)))
  "Returns md5sum for a message object of type 'RRTRequest"
  "45ab4e6a1f02be793e6ab32ee1973a5e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RRTRequest>)))
  "Returns full string definition for message of type '<RRTRequest>"
  (cl:format cl:nil "Header header~%float32 wait_time~%CarState start~%CarState end~%geometry_msgs/Point[] parking_space~%bool set_radius~%float32 radius~%~%uint8 ENTER = 0~%uint8 LEAVE = 1~%uint8 directional~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/CarState~%Header header~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool is_stable~%~%uint8 RANDOM = 0~%uint8 DIRECTIONAL = 1~%uint8 REVERSE_DIRECTIONAL = 2~%uint8 sampler_type~%~%float32 acceleration~%float32 jerk~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RRTRequest)))
  "Returns full string definition for message of type 'RRTRequest"
  (cl:format cl:nil "Header header~%float32 wait_time~%CarState start~%CarState end~%geometry_msgs/Point[] parking_space~%bool set_radius~%float32 radius~%~%uint8 ENTER = 0~%uint8 LEAVE = 1~%uint8 directional~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/CarState~%Header header~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool is_stable~%~%uint8 RANDOM = 0~%uint8 DIRECTIONAL = 1~%uint8 REVERSE_DIRECTIONAL = 2~%uint8 sampler_type~%~%float32 acceleration~%float32 jerk~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RRTRequest>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'start))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'end))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parking_space) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RRTRequest>))
  "Converts a ROS message object to a list"
  (cl:list 'RRTRequest
    (cl:cons ':header (header msg))
    (cl:cons ':wait_time (wait_time msg))
    (cl:cons ':start (start msg))
    (cl:cons ':end (end msg))
    (cl:cons ':parking_space (parking_space msg))
    (cl:cons ':set_radius (set_radius msg))
    (cl:cons ':radius (radius msg))
    (cl:cons ':directional (directional msg))
))
