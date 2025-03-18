; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EsrObj.msg.html

(cl:defclass <EsrObj> (roslisp-msg-protocol:ros-message)
  ((trackId
    :reader trackId
    :initarg :trackId
    :type cl:fixnum
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (medRangeMode
    :reader medRangeMode
    :initarg :medRangeMode
    :type cl:fixnum
    :initform 0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped))
   (twist
    :reader twist
    :initarg :twist
    :type geometry_msgs-msg:TwistStamped
    :initform (cl:make-instance 'geometry_msgs-msg:TwistStamped))
   (oncoming
    :reader oncoming
    :initarg :oncoming
    :type cl:boolean
    :initform cl:nil)
   (isBridge
    :reader isBridge
    :initarg :isBridge
    :type cl:boolean
    :initform cl:nil)
   (groupingChanged
    :reader groupingChanged
    :initarg :groupingChanged
    :type cl:boolean
    :initform cl:nil)
   (width
    :reader width
    :initarg :width
    :type cl:float
    :initform 0.0)
   (rangeAccel
    :reader rangeAccel
    :initarg :rangeAccel
    :type cl:float
    :initform 0.0))
)

(cl:defclass EsrObj (<EsrObj>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsrObj>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsrObj)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EsrObj> is deprecated: use itri_msgs-msg:EsrObj instead.")))

(cl:ensure-generic-function 'trackId-val :lambda-list '(m))
(cl:defmethod trackId-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:trackId-val is deprecated.  Use itri_msgs-msg:trackId instead.")
  (trackId m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:status-val is deprecated.  Use itri_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'medRangeMode-val :lambda-list '(m))
(cl:defmethod medRangeMode-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:medRangeMode-val is deprecated.  Use itri_msgs-msg:medRangeMode instead.")
  (medRangeMode m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'twist-val :lambda-list '(m))
(cl:defmethod twist-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:twist-val is deprecated.  Use itri_msgs-msg:twist instead.")
  (twist m))

(cl:ensure-generic-function 'oncoming-val :lambda-list '(m))
(cl:defmethod oncoming-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:oncoming-val is deprecated.  Use itri_msgs-msg:oncoming instead.")
  (oncoming m))

(cl:ensure-generic-function 'isBridge-val :lambda-list '(m))
(cl:defmethod isBridge-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:isBridge-val is deprecated.  Use itri_msgs-msg:isBridge instead.")
  (isBridge m))

(cl:ensure-generic-function 'groupingChanged-val :lambda-list '(m))
(cl:defmethod groupingChanged-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:groupingChanged-val is deprecated.  Use itri_msgs-msg:groupingChanged instead.")
  (groupingChanged m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:width-val is deprecated.  Use itri_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'rangeAccel-val :lambda-list '(m))
(cl:defmethod rangeAccel-val ((m <EsrObj>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:rangeAccel-val is deprecated.  Use itri_msgs-msg:rangeAccel instead.")
  (rangeAccel m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsrObj>) ostream)
  "Serializes a message object of type '<EsrObj>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trackId)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'medRangeMode)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'twist) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'oncoming) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isBridge) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'groupingChanged) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rangeAccel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsrObj>) istream)
  "Deserializes a message object of type '<EsrObj>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trackId)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'medRangeMode)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'twist) istream)
    (cl:setf (cl:slot-value msg 'oncoming) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'isBridge) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'groupingChanged) (cl:not (cl:zerop (cl:read-byte istream))))
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
    (cl:setf (cl:slot-value msg 'rangeAccel) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsrObj>)))
  "Returns string type for a message object of type '<EsrObj>"
  "itri_msgs/EsrObj")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsrObj)))
  "Returns string type for a message object of type 'EsrObj"
  "itri_msgs/EsrObj")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsrObj>)))
  "Returns md5sum for a message object of type '<EsrObj>"
  "42716c128968ac8bfa26684b875a1ee1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsrObj)))
  "Returns md5sum for a message object of type 'EsrObj"
  "42716c128968ac8bfa26684b875a1ee1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsrObj>)))
  "Returns full string definition for message of type '<EsrObj>"
  (cl:format cl:nil "uint8 trackId~%uint8 status~%uint8 medRangeMode~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool oncoming~%bool isBridge~%bool groupingChanged~%float32 width~%float32 rangeAccel~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsrObj)))
  "Returns full string definition for message of type 'EsrObj"
  (cl:format cl:nil "uint8 trackId~%uint8 status~%uint8 medRangeMode~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool oncoming~%bool isBridge~%bool groupingChanged~%float32 width~%float32 rangeAccel~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsrObj>))
  (cl:+ 0
     1
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'twist))
     1
     1
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsrObj>))
  "Converts a ROS message object to a list"
  (cl:list 'EsrObj
    (cl:cons ':trackId (trackId msg))
    (cl:cons ':status (status msg))
    (cl:cons ':medRangeMode (medRangeMode msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':twist (twist msg))
    (cl:cons ':oncoming (oncoming msg))
    (cl:cons ':isBridge (isBridge msg))
    (cl:cons ':groupingChanged (groupingChanged msg))
    (cl:cons ':width (width msg))
    (cl:cons ':rangeAccel (rangeAccel msg))
))
