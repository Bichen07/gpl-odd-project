;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveEventData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveEventData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVEEVENTDATA")
  (make-package "OPENPILOT_BRIDGE::LIVEEVENTDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveEventData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveEventData
  :super ros::object
  :slots (_header _name _value ))

(defmethod openpilot_bridge::LiveEventData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:name __name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:value __value) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _name __name)
   (setq _value (round __value))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _name)) 4
    ;; int32 _value
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _name
     (write-long (length _name) s)
     (dolist (elem _name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _value
       (write-long _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _value
     (setq _value (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveEventData :md5sum-) "dd88057c889f6b249698dd907fe4ca22")
(setf (get openpilot_bridge::LiveEventData :datatype-) "openpilot_bridge/LiveEventData")
(setf (get openpilot_bridge::LiveEventData :definition-)
      "Header header

string[] name
int32 value

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



(provide :openpilot_bridge/LiveEventData "dd88057c889f6b249698dd907fe4ca22")


