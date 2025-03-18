;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ExceptionMissions)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ExceptionMissions (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::EXCEPTIONMISSIONS")
  (make-package "ITRI_MSGS::EXCEPTIONMISSIONS"))

(in-package "ROS")
;;//! \htmlinclude ExceptionMissions.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ExceptionMissions
  :super ros::object
  :slots (_header _mission ))

(defmethod itri_msgs::ExceptionMissions
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:mission __mission) (let (r) (dotimes (i 0) (push (instance itri_msgs::ExceptionMission :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _mission __mission)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:mission
   (&rest __mission)
   (if (keywordp (car __mission))
       (send* _mission __mission)
     (progn
       (if __mission (setq _mission (car __mission)))
       _mission)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/ExceptionMission[] _mission
    (apply #'+ (send-all _mission :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/ExceptionMission[] _mission
     (write-long (length _mission) s)
     (dolist (elem _mission)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/ExceptionMission[] _mission
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _mission (let (r) (dotimes (i n) (push (instance itri_msgs::ExceptionMission :init) r)) r))
     (dolist (elem- _mission)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::ExceptionMissions :md5sum-) "0b319236f3f70b2499cfecac4de7a18f")
(setf (get itri_msgs::ExceptionMissions :datatype-) "itri_msgs/ExceptionMissions")
(setf (get itri_msgs::ExceptionMissions :definition-)
      "Header header

ExceptionMission[] mission

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: itri_msgs/ExceptionMission
ExceptionEvent exception_event
RequestState request
MissionStatus mission

================================================================================
MSG: itri_msgs/ExceptionEvent
# exception event
uint8 NORMAL = 0
uint8 HARD_BRAKE = 1
uint8 MILD_BRAKE = 2
uint8 DETOUR     = 3
uint8 PULL_OVER  = 4
uint8 TIME_OUT  = 5

uint32 event

================================================================================
MSG: itri_msgs/RequestState
# exception request_state
uint8 NORMAL = 0
uint8 REQUEST = 1
uint8 RESUME = 2

uint8 state

================================================================================
MSG: itri_msgs/MissionStatus
# exception misssion status
uint8 NORMAL = 0
uint8 EXECUTION = 1
uint8 COMPLETED = 2
uint8 REQUEST = 3

uint8 status

")



(provide :itri_msgs/ExceptionMissions "0b319236f3f70b2499cfecac4de7a18f")


