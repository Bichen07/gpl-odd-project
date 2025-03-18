; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude UiLayoutState.msg.html

(cl:defclass <UiLayoutState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (activeApp
    :reader activeApp
    :initarg :activeApp
    :type cl:integer
    :initform 0)
   (mapEnabled
    :reader mapEnabled
    :initarg :mapEnabled
    :type cl:boolean
    :initform cl:nil)
   (sidebarCollapsed
    :reader sidebarCollapsed
    :initarg :sidebarCollapsed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass UiLayoutState (<UiLayoutState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UiLayoutState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UiLayoutState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<UiLayoutState> is deprecated: use openpilot_bridge-msg:UiLayoutState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UiLayoutState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'activeApp-val :lambda-list '(m))
(cl:defmethod activeApp-val ((m <UiLayoutState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:activeApp-val is deprecated.  Use openpilot_bridge-msg:activeApp instead.")
  (activeApp m))

(cl:ensure-generic-function 'mapEnabled-val :lambda-list '(m))
(cl:defmethod mapEnabled-val ((m <UiLayoutState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mapEnabled-val is deprecated.  Use openpilot_bridge-msg:mapEnabled instead.")
  (mapEnabled m))

(cl:ensure-generic-function 'sidebarCollapsed-val :lambda-list '(m))
(cl:defmethod sidebarCollapsed-val ((m <UiLayoutState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sidebarCollapsed-val is deprecated.  Use openpilot_bridge-msg:sidebarCollapsed instead.")
  (sidebarCollapsed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UiLayoutState>) ostream)
  "Serializes a message object of type '<UiLayoutState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'activeApp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'activeApp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'activeApp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'activeApp)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mapEnabled) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'sidebarCollapsed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UiLayoutState>) istream)
  "Deserializes a message object of type '<UiLayoutState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'activeApp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'activeApp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'activeApp)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'activeApp)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'mapEnabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'sidebarCollapsed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UiLayoutState>)))
  "Returns string type for a message object of type '<UiLayoutState>"
  "openpilot_bridge/UiLayoutState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UiLayoutState)))
  "Returns string type for a message object of type 'UiLayoutState"
  "openpilot_bridge/UiLayoutState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UiLayoutState>)))
  "Returns md5sum for a message object of type '<UiLayoutState>"
  "15f553c11275eeabf5a5565d40667440")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UiLayoutState)))
  "Returns md5sum for a message object of type 'UiLayoutState"
  "15f553c11275eeabf5a5565d40667440")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UiLayoutState>)))
  "Returns full string definition for message of type '<UiLayoutState>"
  (cl:format cl:nil "Header header~%~%uint32 activeApp # enum const: App~%bool mapEnabled~%bool sidebarCollapsed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UiLayoutState)))
  "Returns full string definition for message of type 'UiLayoutState"
  (cl:format cl:nil "Header header~%~%uint32 activeApp # enum const: App~%bool mapEnabled~%bool sidebarCollapsed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UiLayoutState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UiLayoutState>))
  "Converts a ROS message object to a list"
  (cl:list 'UiLayoutState
    (cl:cons ':header (header msg))
    (cl:cons ':activeApp (activeApp msg))
    (cl:cons ':mapEnabled (mapEnabled msg))
    (cl:cons ':sidebarCollapsed (sidebarCollapsed msg))
))
