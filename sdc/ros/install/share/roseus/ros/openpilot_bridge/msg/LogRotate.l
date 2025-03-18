;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LogRotate)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LogRotate (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LOGROTATE")
  (make-package "OPENPILOT_BRIDGE::LOGROTATE"))

(in-package "ROS")
;;//! \htmlinclude LogRotate.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LogRotate
  :super ros::object
  :slots (_header _path _segmentNum ))

(defmethod openpilot_bridge::LogRotate
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:path __path) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:segmentNum __segmentNum) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _path __path)
   (setq _segmentNum (round __segmentNum))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:path
   (&optional __path)
   (if __path (setq _path __path)) _path)
  (:segmentNum
   (&optional __segmentNum)
   (if __segmentNum (setq _segmentNum __segmentNum)) _segmentNum)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _path
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _path)) 4
    ;; int32 _segmentNum
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _segmentNum
       (write-long _segmentNum s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _path (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _path i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _segmentNum
     (setq _segmentNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LogRotate :md5sum-) "9611dcdfb393dfae626aa8094943fbd0")
(setf (get openpilot_bridge::LogRotate :datatype-) "openpilot_bridge/LogRotate")
(setf (get openpilot_bridge::LogRotate :definition-)
      "Header header

string[] path
int32 segmentNum

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



(provide :openpilot_bridge/LogRotate "9611dcdfb393dfae626aa8094943fbd0")


