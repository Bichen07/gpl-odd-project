;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ObjectInRange)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ObjectInRange (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::OBJECTINRANGE")
  (make-package "ITRI_MSGS::OBJECTINRANGE"))

(in-package "ROS")
;;//! \htmlinclude ObjectInRange.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ObjectInRange
  :super ros::object
  :slots (_header _object_in_range ))

(defmethod itri_msgs::ObjectInRange
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:object_in_range __object_in_range) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _object_in_range __object_in_range)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:object_in_range
   (&optional __object_in_range)
   (if __object_in_range (setq _object_in_range __object_in_range)) _object_in_range)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _object_in_range
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _object_in_range
       (if _object_in_range (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _object_in_range
     (setq _object_in_range (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::ObjectInRange :md5sum-) "3eb2ed7d3d1e1673d0083e5d770b64d0")
(setf (get itri_msgs::ObjectInRange :datatype-) "itri_msgs/ObjectInRange")
(setf (get itri_msgs::ObjectInRange :definition-)
      "Header header
bool object_in_range

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



(provide :itri_msgs/ObjectInRange "3eb2ed7d3d1e1673d0083e5d770b64d0")


