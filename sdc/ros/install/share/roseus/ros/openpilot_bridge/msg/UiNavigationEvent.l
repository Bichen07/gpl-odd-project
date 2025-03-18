;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::UiNavigationEvent)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'UiNavigationEvent (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::UINAVIGATIONEVENT")
  (make-package "OPENPILOT_BRIDGE::UINAVIGATIONEVENT"))

(in-package "ROS")
;;//! \htmlinclude UiNavigationEvent.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::UiNavigationEvent
  :super ros::object
  :slots (_header _status _distanceTo _type _endRoadPointDEPRECATED _endRoadPoint ))

(defmethod openpilot_bridge::UiNavigationEvent
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:status __status) 0)
    ((:distanceTo __distanceTo) 0.0)
    ((:type __type) 0)
    ((:endRoadPointDEPRECATED __endRoadPointDEPRECATED) (instance openpilot_bridge::ECEFPointDEPRECATED :init))
    ((:endRoadPoint __endRoadPoint) (instance openpilot_bridge::ECEFPoint :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _status (round __status))
   (setq _distanceTo (float __distanceTo))
   (setq _type (round __type))
   (setq _endRoadPointDEPRECATED __endRoadPointDEPRECATED)
   (setq _endRoadPoint __endRoadPoint)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:distanceTo
   (&optional __distanceTo)
   (if __distanceTo (setq _distanceTo __distanceTo)) _distanceTo)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:endRoadPointDEPRECATED
   (&rest __endRoadPointDEPRECATED)
   (if (keywordp (car __endRoadPointDEPRECATED))
       (send* _endRoadPointDEPRECATED __endRoadPointDEPRECATED)
     (progn
       (if __endRoadPointDEPRECATED (setq _endRoadPointDEPRECATED (car __endRoadPointDEPRECATED)))
       _endRoadPointDEPRECATED)))
  (:endRoadPoint
   (&rest __endRoadPoint)
   (if (keywordp (car __endRoadPoint))
       (send* _endRoadPoint __endRoadPoint)
     (progn
       (if __endRoadPoint (setq _endRoadPoint (car __endRoadPoint)))
       _endRoadPoint)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _status
    4
    ;; float32 _distanceTo
    4
    ;; uint32 _type
    4
    ;; openpilot_bridge/ECEFPointDEPRECATED _endRoadPointDEPRECATED
    (send _endRoadPointDEPRECATED :serialization-length)
    ;; openpilot_bridge/ECEFPoint _endRoadPoint
    (send _endRoadPoint :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _status
       (write-long _status s)
     ;; float32 _distanceTo
       (sys::poke _distanceTo (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _type
       (write-long _type s)
     ;; openpilot_bridge/ECEFPointDEPRECATED _endRoadPointDEPRECATED
       (send _endRoadPointDEPRECATED :serialize s)
     ;; openpilot_bridge/ECEFPoint _endRoadPoint
       (send _endRoadPoint :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _distanceTo
     (setq _distanceTo (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/ECEFPointDEPRECATED _endRoadPointDEPRECATED
     (send _endRoadPointDEPRECATED :deserialize buf ptr-) (incf ptr- (send _endRoadPointDEPRECATED :serialization-length))
   ;; openpilot_bridge/ECEFPoint _endRoadPoint
     (send _endRoadPoint :deserialize buf ptr-) (incf ptr- (send _endRoadPoint :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::UiNavigationEvent :md5sum-) "6c5e4c8da028603156189c75ad9e7343")
(setf (get openpilot_bridge::UiNavigationEvent :datatype-) "openpilot_bridge/UiNavigationEvent")
(setf (get openpilot_bridge::UiNavigationEvent :definition-)
      "Header header

uint32 status # enum const: Status
float32 distanceTo
uint32 type # enum const: Type
ECEFPointDEPRECATED endRoadPointDEPRECATED
ECEFPoint endRoadPoint

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
MSG: openpilot_bridge/ECEFPointDEPRECATED
Header header

float32 y
float32 x
float32 z

================================================================================
MSG: openpilot_bridge/ECEFPoint
Header header

float32 y
float32 x
float32 z

")



(provide :openpilot_bridge/UiNavigationEvent "6c5e4c8da028603156189c75ad9e7343")


