;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::NavUpdate)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'NavUpdate (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::NAVUPDATE")
  (make-package "OPENPILOT_BRIDGE::NAVUPDATE"))

(in-package "ROS")
;;//! \htmlinclude NavUpdate.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::NavUpdate
  :super ros::object
  :slots (_header _isNavigating _segments _curSegment ))

(defmethod openpilot_bridge::NavUpdate
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:isNavigating __isNavigating) nil)
    ((:segments __segments) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::Segment :init) r)) r))
    ((:curSegment __curSegment) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _isNavigating __isNavigating)
   (setq _segments __segments)
   (setq _curSegment (round __curSegment))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:isNavigating
   (&optional __isNavigating)
   (if __isNavigating (setq _isNavigating __isNavigating)) _isNavigating)
  (:segments
   (&rest __segments)
   (if (keywordp (car __segments))
       (send* _segments __segments)
     (progn
       (if __segments (setq _segments (car __segments)))
       _segments)))
  (:curSegment
   (&optional __curSegment)
   (if __curSegment (setq _curSegment __curSegment)) _curSegment)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _isNavigating
    1
    ;; openpilot_bridge/Segment[] _segments
    (apply #'+ (send-all _segments :serialization-length)) 4
    ;; int32 _curSegment
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _isNavigating
       (if _isNavigating (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/Segment[] _segments
     (write-long (length _segments) s)
     (dolist (elem _segments)
       (send elem :serialize s)
       )
     ;; int32 _curSegment
       (write-long _curSegment s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _isNavigating
     (setq _isNavigating (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/Segment[] _segments
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _segments (let (r) (dotimes (i n) (push (instance openpilot_bridge::Segment :init) r)) r))
     (dolist (elem- _segments)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _curSegment
     (setq _curSegment (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::NavUpdate :md5sum-) "4056f0b47c0dc06ca95711174632cd20")
(setf (get openpilot_bridge::NavUpdate :datatype-) "openpilot_bridge/NavUpdate")
(setf (get openpilot_bridge::NavUpdate :definition-)
      "Header header

bool isNavigating
Segment[] segments
int32 curSegment

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
MSG: openpilot_bridge/Segment
Header header

int32 distance
int32 updateTime
LatLng from
uint32 instruction # enum const: Instruction
LatLng[] parts
LatLng to
int32 crossTime
int32 exitNo

================================================================================
MSG: openpilot_bridge/LatLng
Header header

float32 lat
float32 lng

")



(provide :openpilot_bridge/NavUpdate "4056f0b47c0dc06ca95711174632cd20")


