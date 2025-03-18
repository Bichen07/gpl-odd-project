;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ReceiverStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ReceiverStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::RECEIVERSTATUS")
  (make-package "OPENPILOT_BRIDGE::RECEIVERSTATUS"))

(in-package "ROS")
;;//! \htmlinclude ReceiverStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ReceiverStatus
  :super ros::object
  :slots (_header _leapSecValid _clkReset ))

(defmethod openpilot_bridge::ReceiverStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:leapSecValid __leapSecValid) nil)
    ((:clkReset __clkReset) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _leapSecValid __leapSecValid)
   (setq _clkReset __clkReset)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:leapSecValid
   (&optional __leapSecValid)
   (if __leapSecValid (setq _leapSecValid __leapSecValid)) _leapSecValid)
  (:clkReset
   (&optional __clkReset)
   (if __clkReset (setq _clkReset __clkReset)) _clkReset)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _leapSecValid
    1
    ;; bool _clkReset
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _leapSecValid
       (if _leapSecValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _clkReset
       (if _clkReset (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _leapSecValid
     (setq _leapSecValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _clkReset
     (setq _clkReset (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::ReceiverStatus :md5sum-) "37035768a9037c3faee5bf61b59c4cd4")
(setf (get openpilot_bridge::ReceiverStatus :datatype-) "openpilot_bridge/ReceiverStatus")
(setf (get openpilot_bridge::ReceiverStatus :definition-)
      "Header header

bool leapSecValid
bool clkReset

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



(provide :openpilot_bridge/ReceiverStatus "37035768a9037c3faee5bf61b59c4cd4")


