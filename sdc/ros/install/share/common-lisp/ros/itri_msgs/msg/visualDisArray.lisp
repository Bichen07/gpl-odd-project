; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude visualDisArray.msg.html

(cl:defclass <visualDisArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (carDis
    :reader carDis
    :initarg :carDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis)))
   (busDis
    :reader busDis
    :initarg :busDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis)))
   (truckDis
    :reader truckDis
    :initarg :truckDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis)))
   (bicycleDis
    :reader bicycleDis
    :initarg :bicycleDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis)))
   (motorbikeDis
    :reader motorbikeDis
    :initarg :motorbikeDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis)))
   (personDis
    :reader personDis
    :initarg :personDis
    :type (cl:vector itri_msgs-msg:visualDis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:visualDis :initial-element (cl:make-instance 'itri_msgs-msg:visualDis))))
)

(cl:defclass visualDisArray (<visualDisArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <visualDisArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'visualDisArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<visualDisArray> is deprecated: use itri_msgs-msg:visualDisArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'carDis-val :lambda-list '(m))
(cl:defmethod carDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:carDis-val is deprecated.  Use itri_msgs-msg:carDis instead.")
  (carDis m))

(cl:ensure-generic-function 'busDis-val :lambda-list '(m))
(cl:defmethod busDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:busDis-val is deprecated.  Use itri_msgs-msg:busDis instead.")
  (busDis m))

(cl:ensure-generic-function 'truckDis-val :lambda-list '(m))
(cl:defmethod truckDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:truckDis-val is deprecated.  Use itri_msgs-msg:truckDis instead.")
  (truckDis m))

(cl:ensure-generic-function 'bicycleDis-val :lambda-list '(m))
(cl:defmethod bicycleDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:bicycleDis-val is deprecated.  Use itri_msgs-msg:bicycleDis instead.")
  (bicycleDis m))

(cl:ensure-generic-function 'motorbikeDis-val :lambda-list '(m))
(cl:defmethod motorbikeDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:motorbikeDis-val is deprecated.  Use itri_msgs-msg:motorbikeDis instead.")
  (motorbikeDis m))

(cl:ensure-generic-function 'personDis-val :lambda-list '(m))
(cl:defmethod personDis-val ((m <visualDisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:personDis-val is deprecated.  Use itri_msgs-msg:personDis instead.")
  (personDis m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <visualDisArray>) ostream)
  "Serializes a message object of type '<visualDisArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'carDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'carDis))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'busDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'busDis))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'truckDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'truckDis))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'bicycleDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'bicycleDis))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'motorbikeDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'motorbikeDis))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'personDis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'personDis))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <visualDisArray>) istream)
  "Deserializes a message object of type '<visualDisArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'carDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'carDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'busDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'busDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'truckDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'truckDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'bicycleDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'bicycleDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'motorbikeDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'motorbikeDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'personDis) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'personDis)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:visualDis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<visualDisArray>)))
  "Returns string type for a message object of type '<visualDisArray>"
  "itri_msgs/visualDisArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'visualDisArray)))
  "Returns string type for a message object of type 'visualDisArray"
  "itri_msgs/visualDisArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<visualDisArray>)))
  "Returns md5sum for a message object of type '<visualDisArray>"
  "e2e9c59e0f49a1e406fa51abca933f4d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'visualDisArray)))
  "Returns md5sum for a message object of type 'visualDisArray"
  "e2e9c59e0f49a1e406fa51abca933f4d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<visualDisArray>)))
  "Returns full string definition for message of type '<visualDisArray>"
  (cl:format cl:nil "Header header~%visualDis[] carDis~%visualDis[] busDis~%visualDis[] truckDis~%visualDis[] bicycleDis~%visualDis[] motorbikeDis~%visualDis[] personDis~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/visualDis~%int32 realDis_x~%int32 realDis_y~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'visualDisArray)))
  "Returns full string definition for message of type 'visualDisArray"
  (cl:format cl:nil "Header header~%visualDis[] carDis~%visualDis[] busDis~%visualDis[] truckDis~%visualDis[] bicycleDis~%visualDis[] motorbikeDis~%visualDis[] personDis~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/visualDis~%int32 realDis_x~%int32 realDis_y~%int32 x~%int32 y~%int32 height~%int32 width~%float32 score~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <visualDisArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'carDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'busDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'truckDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'bicycleDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'motorbikeDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'personDis) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <visualDisArray>))
  "Converts a ROS message object to a list"
  (cl:list 'visualDisArray
    (cl:cons ':header (header msg))
    (cl:cons ':carDis (carDis msg))
    (cl:cons ':busDis (busDis msg))
    (cl:cons ':truckDis (truckDis msg))
    (cl:cons ':bicycleDis (bicycleDis msg))
    (cl:cons ':motorbikeDis (motorbikeDis msg))
    (cl:cons ':personDis (personDis msg))
))
