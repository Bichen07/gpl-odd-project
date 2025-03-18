; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude WatchdogStatus.msg.html

(cl:defclass <WatchdogStatus> (roslisp-msg-protocol:ros-message)
  ((source
    :reader source
    :initarg :source
    :type cl:fixnum
    :initform 0))
)

(cl:defclass WatchdogStatus (<WatchdogStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WatchdogStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WatchdogStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<WatchdogStatus> is deprecated: use dbw_pacifica_msgs-msg:WatchdogStatus instead.")))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <WatchdogStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:source-val is deprecated.  Use dbw_pacifica_msgs-msg:source instead.")
  (source m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WatchdogStatus>)))
    "Constants for message type '<WatchdogStatus>"
  '((:NONE . 0)
    (:OTHER_BRAKE . 1)
    (:OTHER_ACCELERATOR_PEDAL . 2)
    (:OTHER_STEERING . 3)
    (:BRAKE_COUNTER . 4)
    (:BRAKE_DISABLED . 5)
    (:BRAKE_COMMAND . 6)
    (:BRAKE_REPORT . 7)
    (:ACCELERATOR_PEDAL_COUNTER . 8)
    (:ACCELERATOR_PEDAL_DISABLED . 9)
    (:ACCELERATOR_PEDAL_COMMAND . 10)
    (:ACCELERATOR_PEDAL_REPORT . 11)
    (:STEERING_COUNTER . 12)
    (:STEERING_DISABLED . 13)
    (:STEERING_COMMAND . 14)
    (:STEERING_REPORT . 15))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WatchdogStatus)))
    "Constants for message type 'WatchdogStatus"
  '((:NONE . 0)
    (:OTHER_BRAKE . 1)
    (:OTHER_ACCELERATOR_PEDAL . 2)
    (:OTHER_STEERING . 3)
    (:BRAKE_COUNTER . 4)
    (:BRAKE_DISABLED . 5)
    (:BRAKE_COMMAND . 6)
    (:BRAKE_REPORT . 7)
    (:ACCELERATOR_PEDAL_COUNTER . 8)
    (:ACCELERATOR_PEDAL_DISABLED . 9)
    (:ACCELERATOR_PEDAL_COMMAND . 10)
    (:ACCELERATOR_PEDAL_REPORT . 11)
    (:STEERING_COUNTER . 12)
    (:STEERING_DISABLED . 13)
    (:STEERING_COMMAND . 14)
    (:STEERING_REPORT . 15))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WatchdogStatus>) ostream)
  "Serializes a message object of type '<WatchdogStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WatchdogStatus>) istream)
  "Deserializes a message object of type '<WatchdogStatus>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WatchdogStatus>)))
  "Returns string type for a message object of type '<WatchdogStatus>"
  "dbw_pacifica_msgs/WatchdogStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WatchdogStatus)))
  "Returns string type for a message object of type 'WatchdogStatus"
  "dbw_pacifica_msgs/WatchdogStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WatchdogStatus>)))
  "Returns md5sum for a message object of type '<WatchdogStatus>"
  "3e7ee28e0afc591098518c8b9bf36b8a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WatchdogStatus)))
  "Returns md5sum for a message object of type 'WatchdogStatus"
  "3e7ee28e0afc591098518c8b9bf36b8a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WatchdogStatus>)))
  "Returns full string definition for message of type '<WatchdogStatus>"
  (cl:format cl:nil "uint8 source~%~%uint8 NONE=0                        # No source for watchdog counter fault~%uint8 OTHER_BRAKE=1                 # Fault determined by brake controller~%uint8 OTHER_ACCELERATOR_PEDAL=2     # Fault determined by accelerator pedal controller~%uint8 OTHER_STEERING=3              # Fault determined by steering controller~%uint8 BRAKE_COUNTER=4               # Brake command counter failed to increment~%uint8 BRAKE_DISABLED=5              # Brake transition to disabled while in gear or moving~%uint8 BRAKE_COMMAND=6               # Brake command timeout after 100ms~%uint8 BRAKE_REPORT=7                # Brake report timeout after 100ms~%uint8 ACCELERATOR_PEDAL_COUNTER=8   # Accelerator pedal command counter failed to increment~%uint8 ACCELERATOR_PEDAL_DISABLED=9  # Accelerator pedal transition to disabled while in gear or moving~%uint8 ACCELERATOR_PEDAL_COMMAND=10  # Accelerator pedal command timeout after 100ms~%uint8 ACCELERATOR_PEDAL_REPORT=11   # Accelerator pedal report timeout after 100ms~%uint8 STEERING_COUNTER=12           # Steering command counter failed to increment~%uint8 STEERING_DISABLED=13          # Steering transition to disabled while in gear or moving~%uint8 STEERING_COMMAND=14           # Steering command timeout after 100ms~%uint8 STEERING_REPORT=15            # Steering report timeout after 100ms~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WatchdogStatus)))
  "Returns full string definition for message of type 'WatchdogStatus"
  (cl:format cl:nil "uint8 source~%~%uint8 NONE=0                        # No source for watchdog counter fault~%uint8 OTHER_BRAKE=1                 # Fault determined by brake controller~%uint8 OTHER_ACCELERATOR_PEDAL=2     # Fault determined by accelerator pedal controller~%uint8 OTHER_STEERING=3              # Fault determined by steering controller~%uint8 BRAKE_COUNTER=4               # Brake command counter failed to increment~%uint8 BRAKE_DISABLED=5              # Brake transition to disabled while in gear or moving~%uint8 BRAKE_COMMAND=6               # Brake command timeout after 100ms~%uint8 BRAKE_REPORT=7                # Brake report timeout after 100ms~%uint8 ACCELERATOR_PEDAL_COUNTER=8   # Accelerator pedal command counter failed to increment~%uint8 ACCELERATOR_PEDAL_DISABLED=9  # Accelerator pedal transition to disabled while in gear or moving~%uint8 ACCELERATOR_PEDAL_COMMAND=10  # Accelerator pedal command timeout after 100ms~%uint8 ACCELERATOR_PEDAL_REPORT=11   # Accelerator pedal report timeout after 100ms~%uint8 STEERING_COUNTER=12           # Steering command counter failed to increment~%uint8 STEERING_DISABLED=13          # Steering transition to disabled while in gear or moving~%uint8 STEERING_COMMAND=14           # Steering command timeout after 100ms~%uint8 STEERING_REPORT=15            # Steering report timeout after 100ms~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WatchdogStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WatchdogStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'WatchdogStatus
    (cl:cons ':source (source msg))
))
