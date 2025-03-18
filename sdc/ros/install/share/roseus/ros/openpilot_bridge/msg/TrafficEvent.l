;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::TrafficEvent)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'TrafficEvent (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::TRAFFICEVENT")
  (make-package "OPENPILOT_BRIDGE::TRAFFICEVENT"))

(in-package "ROS")
;;//! \htmlinclude TrafficEvent.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::TrafficEvent
  :super ros::object
  :slots (_header _action _distance _type _resuming ))

(defmethod openpilot_bridge::TrafficEvent
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:action __action) 0)
    ((:distance __distance) 0.0)
    ((:type __type) 0)
    ((:resuming __resuming) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _action (round __action))
   (setq _distance (float __distance))
   (setq _type (round __type))
   (setq _resuming __resuming)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:resuming
   (&optional __resuming)
   (if __resuming (setq _resuming __resuming)) _resuming)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _action
    4
    ;; float32 _distance
    4
    ;; uint32 _type
    4
    ;; bool _resuming
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _action
       (write-long _action s)
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _type
       (write-long _type s)
     ;; bool _resuming
       (if _resuming (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _action
     (setq _action (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _resuming
     (setq _resuming (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::TrafficEvent :md5sum-) "df9e6938ac7ed3b8cc96f41615535461")
(setf (get openpilot_bridge::TrafficEvent :datatype-) "openpilot_bridge/TrafficEvent")
(setf (get openpilot_bridge::TrafficEvent :definition-)
      "Header header

uint32 action # enum const: Action
float32 distance
uint32 type # enum const: Type
bool resuming

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

")



(provide :openpilot_bridge/TrafficEvent "df9e6938ac7ed3b8cc96f41615535461")


