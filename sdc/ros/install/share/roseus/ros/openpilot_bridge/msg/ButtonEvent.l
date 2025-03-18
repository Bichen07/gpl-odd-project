;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ButtonEvent)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ButtonEvent (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::BUTTONEVENT")
  (make-package "OPENPILOT_BRIDGE::BUTTONEVENT"))

(in-package "ROS")
;;//! \htmlinclude ButtonEvent.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ButtonEvent
  :super ros::object
  :slots (_header _type _pressed ))

(defmethod openpilot_bridge::ButtonEvent
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:pressed __pressed) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _pressed __pressed)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:pressed
   (&optional __pressed)
   (if __pressed (setq _pressed __pressed)) _pressed)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _type
    4
    ;; bool _pressed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _type
       (write-long _type s)
     ;; bool _pressed
       (if _pressed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _pressed
     (setq _pressed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::ButtonEvent :md5sum-) "a73eec4face11f6e7d39beb188805386")
(setf (get openpilot_bridge::ButtonEvent :datatype-) "openpilot_bridge/ButtonEvent")
(setf (get openpilot_bridge::ButtonEvent :definition-)
      "Header header

uint32 type # enum const: Type
bool pressed

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



(provide :openpilot_bridge/ButtonEvent "a73eec4face11f6e7d39beb188805386")


