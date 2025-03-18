; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude CameraObjectAnalysisArray.msg.html

(cl:defclass <CameraObjectAnalysisArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector itri_msgs-msg:CameraObjectAnalysis)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:CameraObjectAnalysis :initial-element (cl:make-instance 'itri_msgs-msg:CameraObjectAnalysis))))
)

(cl:defclass CameraObjectAnalysisArray (<CameraObjectAnalysisArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraObjectAnalysisArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraObjectAnalysisArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<CameraObjectAnalysisArray> is deprecated: use itri_msgs-msg:CameraObjectAnalysisArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CameraObjectAnalysisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <CameraObjectAnalysisArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:objects-val is deprecated.  Use itri_msgs-msg:objects instead.")
  (objects m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraObjectAnalysisArray>) ostream)
  "Serializes a message object of type '<CameraObjectAnalysisArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraObjectAnalysisArray>) istream)
  "Deserializes a message object of type '<CameraObjectAnalysisArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:CameraObjectAnalysis))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraObjectAnalysisArray>)))
  "Returns string type for a message object of type '<CameraObjectAnalysisArray>"
  "itri_msgs/CameraObjectAnalysisArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraObjectAnalysisArray)))
  "Returns string type for a message object of type 'CameraObjectAnalysisArray"
  "itri_msgs/CameraObjectAnalysisArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraObjectAnalysisArray>)))
  "Returns md5sum for a message object of type '<CameraObjectAnalysisArray>"
  "d882f91f0da4bdfa63df0ad6e1bad6da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraObjectAnalysisArray)))
  "Returns md5sum for a message object of type 'CameraObjectAnalysisArray"
  "d882f91f0da4bdfa63df0ad6e1bad6da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraObjectAnalysisArray>)))
  "Returns full string definition for message of type '<CameraObjectAnalysisArray>"
  (cl:format cl:nil "std_msgs/Header header~%CameraObjectAnalysis[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/CameraObjectAnalysis~%uint32 id~%float32 center_distance~%float32 diou~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraObjectAnalysisArray)))
  "Returns full string definition for message of type 'CameraObjectAnalysisArray"
  (cl:format cl:nil "std_msgs/Header header~%CameraObjectAnalysis[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/CameraObjectAnalysis~%uint32 id~%float32 center_distance~%float32 diou~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraObjectAnalysisArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraObjectAnalysisArray>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraObjectAnalysisArray
    (cl:cons ':header (header msg))
    (cl:cons ':objects (objects msg))
))
