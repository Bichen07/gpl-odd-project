;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::LaneLine)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'LaneLine (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LANELINE")
  (make-package "ITRI_MSGS::LANELINE"))

(in-package "ROS")
;;//! \htmlinclude LaneLine.msg.html


(defclass itri_msgs::LaneLine
  :super ros::object
  :slots (_left_line _right_line ))

(defmethod itri_msgs::LaneLine
  (:init
   (&key
    ((:left_line __left_line) (instance itri_msgs::LanePoly :init))
    ((:right_line __right_line) (instance itri_msgs::LanePoly :init))
    )
   (send-super :init)
   (setq _left_line __left_line)
   (setq _right_line __right_line)
   self)
  (:left_line
   (&rest __left_line)
   (if (keywordp (car __left_line))
       (send* _left_line __left_line)
     (progn
       (if __left_line (setq _left_line (car __left_line)))
       _left_line)))
  (:right_line
   (&rest __right_line)
   (if (keywordp (car __right_line))
       (send* _right_line __right_line)
     (progn
       (if __right_line (setq _right_line (car __right_line)))
       _right_line)))
  (:serialization-length
   ()
   (+
    ;; itri_msgs/LanePoly _left_line
    (send _left_line :serialization-length)
    ;; itri_msgs/LanePoly _right_line
    (send _right_line :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; itri_msgs/LanePoly _left_line
       (send _left_line :serialize s)
     ;; itri_msgs/LanePoly _right_line
       (send _right_line :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; itri_msgs/LanePoly _left_line
     (send _left_line :deserialize buf ptr-) (incf ptr- (send _left_line :serialization-length))
   ;; itri_msgs/LanePoly _right_line
     (send _right_line :deserialize buf ptr-) (incf ptr- (send _right_line :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::LaneLine :md5sum-) "df0610fafa5521c03719095763a8f984")
(setf (get itri_msgs::LaneLine :datatype-) "itri_msgs/LaneLine")
(setf (get itri_msgs::LaneLine :definition-)
      "LanePoly left_line
LanePoly right_line

================================================================================
MSG: itri_msgs/LanePoly
std_msgs/Header header
float32 c0
float32 c1
float32 c2
float32 c3

uint16 confidentScore
float32 distance
float32 width
float32 right_bound
float32 left_bound
float32 prob

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



(provide :itri_msgs/LaneLine "df0610fafa5521c03719095763a8f984")


