; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EsrObjArray.msg.html

(cl:defclass <EsrObjArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objs
    :reader objs
    :initarg :objs
    :type (cl:vector itri_msgs-msg:EsrObj)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:EsrObj :initial-element (cl:make-instance 'itri_msgs-msg:EsrObj)))
   (motion
    :reader motion
    :initarg :motion
    :type (cl:vector itri_msgs-msg:EsrMotionPower)
   :initform (cl:make-array 64 :element-type 'itri_msgs-msg:EsrMotionPower :initial-element (cl:make-instance 'itri_msgs-msg:EsrMotionPower))))
)

(cl:defclass EsrObjArray (<EsrObjArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsrObjArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsrObjArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EsrObjArray> is deprecated: use itri_msgs-msg:EsrObjArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EsrObjArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objs-val :lambda-list '(m))
(cl:defmethod objs-val ((m <EsrObjArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:objs-val is deprecated.  Use itri_msgs-msg:objs instead.")
  (objs m))

(cl:ensure-generic-function 'motion-val :lambda-list '(m))
(cl:defmethod motion-val ((m <EsrObjArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:motion-val is deprecated.  Use itri_msgs-msg:motion instead.")
  (motion m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsrObjArray>) ostream)
  "Serializes a message object of type '<EsrObjArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objs))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'motion))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsrObjArray>) istream)
  "Deserializes a message object of type '<EsrObjArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:EsrObj))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:setf (cl:slot-value msg 'motion) (cl:make-array 64))
  (cl:let ((vals (cl:slot-value msg 'motion)))
    (cl:dotimes (i 64)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:EsrMotionPower))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsrObjArray>)))
  "Returns string type for a message object of type '<EsrObjArray>"
  "itri_msgs/EsrObjArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsrObjArray)))
  "Returns string type for a message object of type 'EsrObjArray"
  "itri_msgs/EsrObjArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsrObjArray>)))
  "Returns md5sum for a message object of type '<EsrObjArray>"
  "9e3f4db5a2b7e811d4b4df0dff33e220")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsrObjArray)))
  "Returns md5sum for a message object of type 'EsrObjArray"
  "9e3f4db5a2b7e811d4b4df0dff33e220")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsrObjArray>)))
  "Returns full string definition for message of type '<EsrObjArray>"
  (cl:format cl:nil "Header header~%EsrObj[] objs~%EsrMotionPower[64] motion~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/EsrObj~%uint8 trackId~%uint8 status~%uint8 medRangeMode~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool oncoming~%bool isBridge~%bool groupingChanged~%float32 width~%float32 rangeAccel~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: itri_msgs/EsrMotionPower~%bool track_moving~%bool track_movable_fast~%bool track_movable_slow~%int16 track_power~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsrObjArray)))
  "Returns full string definition for message of type 'EsrObjArray"
  (cl:format cl:nil "Header header~%EsrObj[] objs~%EsrMotionPower[64] motion~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/EsrObj~%uint8 trackId~%uint8 status~%uint8 medRangeMode~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%bool oncoming~%bool isBridge~%bool groupingChanged~%float32 width~%float32 rangeAccel~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: itri_msgs/EsrMotionPower~%bool track_moving~%bool track_movable_fast~%bool track_movable_slow~%int16 track_power~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsrObjArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'motion) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsrObjArray>))
  "Converts a ROS message object to a list"
  (cl:list 'EsrObjArray
    (cl:cons ':header (header msg))
    (cl:cons ':objs (objs msg))
    (cl:cons ':motion (motion msg))
))
