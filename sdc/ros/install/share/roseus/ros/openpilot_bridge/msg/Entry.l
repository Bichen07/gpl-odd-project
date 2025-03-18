;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Entry)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Entry (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ENTRY")
  (make-package "OPENPILOT_BRIDGE::ENTRY"))

(in-package "ROS")
;;//! \htmlinclude Entry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Entry
  :super ros::object
  :slots (_header _value _key ))

(defmethod openpilot_bridge::Entry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:value __value) "")
    ((:key __key) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _value (string __value))
   (setq _key (string __key))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:key
   (&optional __key)
   (if __key (setq _key __key)) _key)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _value
    4 (length _value)
    ;; string _key
    4 (length _key)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;; string _key
       (write-long (length _key) s) (princ _key s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _key
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _key (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get openpilot_bridge::Entry :md5sum-) "c96b3d5eb32e99f751779f00e5ab98f6")
(setf (get openpilot_bridge::Entry :datatype-) "openpilot_bridge/Entry")
(setf (get openpilot_bridge::Entry :definition-)
      "Header header

string value
string key

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



(provide :openpilot_bridge/Entry "c96b3d5eb32e99f751779f00e5ab98f6")


