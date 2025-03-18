; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ProcLog.msg.html

(cl:defclass <ProcLog> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (cpuTimes
    :reader cpuTimes
    :initarg :cpuTimes
    :type (cl:vector openpilot_bridge-msg:CPUTimes)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:CPUTimes :initial-element (cl:make-instance 'openpilot_bridge-msg:CPUTimes)))
   (mem
    :reader mem
    :initarg :mem
    :type openpilot_bridge-msg:Mem
    :initform (cl:make-instance 'openpilot_bridge-msg:Mem))
   (procs
    :reader procs
    :initarg :procs
    :type (cl:vector openpilot_bridge-msg:Process)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:Process :initial-element (cl:make-instance 'openpilot_bridge-msg:Process))))
)

(cl:defclass ProcLog (<ProcLog>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcLog>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcLog)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ProcLog> is deprecated: use openpilot_bridge-msg:ProcLog instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ProcLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'cpuTimes-val :lambda-list '(m))
(cl:defmethod cpuTimes-val ((m <ProcLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cpuTimes-val is deprecated.  Use openpilot_bridge-msg:cpuTimes instead.")
  (cpuTimes m))

(cl:ensure-generic-function 'mem-val :lambda-list '(m))
(cl:defmethod mem-val ((m <ProcLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mem-val is deprecated.  Use openpilot_bridge-msg:mem instead.")
  (mem m))

(cl:ensure-generic-function 'procs-val :lambda-list '(m))
(cl:defmethod procs-val ((m <ProcLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:procs-val is deprecated.  Use openpilot_bridge-msg:procs instead.")
  (procs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcLog>) ostream)
  "Serializes a message object of type '<ProcLog>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cpuTimes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'cpuTimes))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mem) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'procs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'procs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcLog>) istream)
  "Deserializes a message object of type '<ProcLog>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cpuTimes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cpuTimes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:CPUTimes))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mem) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'procs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'procs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:Process))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcLog>)))
  "Returns string type for a message object of type '<ProcLog>"
  "openpilot_bridge/ProcLog")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcLog)))
  "Returns string type for a message object of type 'ProcLog"
  "openpilot_bridge/ProcLog")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcLog>)))
  "Returns md5sum for a message object of type '<ProcLog>"
  "21eae07decb56f4048af9c9c8680083d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcLog)))
  "Returns md5sum for a message object of type 'ProcLog"
  "21eae07decb56f4048af9c9c8680083d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcLog>)))
  "Returns full string definition for message of type '<ProcLog>"
  (cl:format cl:nil "Header header~%~%CPUTimes[] cpuTimes~%Mem mem~%Process[] procs~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CPUTimes~%Header header~%~%float32 softirq~%float32 iowait~%float32 system~%int32 cpuNum~%float32 idle~%float32 user~%float32 irq~%float32 nice~%~%================================================================================~%MSG: openpilot_bridge/Mem~%Header header~%~%int64 available~%int64 cached~%int64 free~%int64 inactive~%int64 active~%int64 shared~%int64 total~%int64 buffers~%~%================================================================================~%MSG: openpilot_bridge/Process~%Header header~%~%string[] exe~%string[] name~%string[] cmdline~%float32 cpuUser~%int32 numThreads~%int64 memRss~%int32 pid~%int64 memVms~%int32 priority~%float32 cpuSystem~%int64 state~%float32 startTime~%int32 nice~%float32 cpuChildrenUser~%int32 ppid~%int32 processor~%float32 cpuChildrenSystem~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcLog)))
  "Returns full string definition for message of type 'ProcLog"
  (cl:format cl:nil "Header header~%~%CPUTimes[] cpuTimes~%Mem mem~%Process[] procs~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CPUTimes~%Header header~%~%float32 softirq~%float32 iowait~%float32 system~%int32 cpuNum~%float32 idle~%float32 user~%float32 irq~%float32 nice~%~%================================================================================~%MSG: openpilot_bridge/Mem~%Header header~%~%int64 available~%int64 cached~%int64 free~%int64 inactive~%int64 active~%int64 shared~%int64 total~%int64 buffers~%~%================================================================================~%MSG: openpilot_bridge/Process~%Header header~%~%string[] exe~%string[] name~%string[] cmdline~%float32 cpuUser~%int32 numThreads~%int64 memRss~%int32 pid~%int64 memVms~%int32 priority~%float32 cpuSystem~%int64 state~%float32 startTime~%int32 nice~%float32 cpuChildrenUser~%int32 ppid~%int32 processor~%float32 cpuChildrenSystem~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcLog>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cpuTimes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mem))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'procs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcLog>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcLog
    (cl:cons ':header (header msg))
    (cl:cons ':cpuTimes (cpuTimes msg))
    (cl:cons ':mem (mem msg))
    (cl:cons ':procs (procs msg))
))
