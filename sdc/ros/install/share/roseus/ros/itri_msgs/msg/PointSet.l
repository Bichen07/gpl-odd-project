;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PointSet)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PointSet (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::POINTSET")
  (make-package "ITRI_MSGS::POINTSET"))

(in-package "ROS")
;;//! \htmlinclude PointSet.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::PointSet
  :super ros::object
  :slots (_header _left_lane _right_lane _next_left_lane _next_right_lane ))

(defmethod itri_msgs::PointSet
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:left_lane __left_lane) (instance itri_msgs::PointArray :init))
    ((:right_lane __right_lane) (instance itri_msgs::PointArray :init))
    ((:next_left_lane __next_left_lane) (instance itri_msgs::PointArray :init))
    ((:next_right_lane __next_right_lane) (instance itri_msgs::PointArray :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _left_lane __left_lane)
   (setq _right_lane __right_lane)
   (setq _next_left_lane __next_left_lane)
   (setq _next_right_lane __next_right_lane)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:left_lane
   (&rest __left_lane)
   (if (keywordp (car __left_lane))
       (send* _left_lane __left_lane)
     (progn
       (if __left_lane (setq _left_lane (car __left_lane)))
       _left_lane)))
  (:right_lane
   (&rest __right_lane)
   (if (keywordp (car __right_lane))
       (send* _right_lane __right_lane)
     (progn
       (if __right_lane (setq _right_lane (car __right_lane)))
       _right_lane)))
  (:next_left_lane
   (&rest __next_left_lane)
   (if (keywordp (car __next_left_lane))
       (send* _next_left_lane __next_left_lane)
     (progn
       (if __next_left_lane (setq _next_left_lane (car __next_left_lane)))
       _next_left_lane)))
  (:next_right_lane
   (&rest __next_right_lane)
   (if (keywordp (car __next_right_lane))
       (send* _next_right_lane __next_right_lane)
     (progn
       (if __next_right_lane (setq _next_right_lane (car __next_right_lane)))
       _next_right_lane)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/PointArray _left_lane
    (send _left_lane :serialization-length)
    ;; itri_msgs/PointArray _right_lane
    (send _right_lane :serialization-length)
    ;; itri_msgs/PointArray _next_left_lane
    (send _next_left_lane :serialization-length)
    ;; itri_msgs/PointArray _next_right_lane
    (send _next_right_lane :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/PointArray _left_lane
       (send _left_lane :serialize s)
     ;; itri_msgs/PointArray _right_lane
       (send _right_lane :serialize s)
     ;; itri_msgs/PointArray _next_left_lane
       (send _next_left_lane :serialize s)
     ;; itri_msgs/PointArray _next_right_lane
       (send _next_right_lane :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/PointArray _left_lane
     (send _left_lane :deserialize buf ptr-) (incf ptr- (send _left_lane :serialization-length))
   ;; itri_msgs/PointArray _right_lane
     (send _right_lane :deserialize buf ptr-) (incf ptr- (send _right_lane :serialization-length))
   ;; itri_msgs/PointArray _next_left_lane
     (send _next_left_lane :deserialize buf ptr-) (incf ptr- (send _next_left_lane :serialization-length))
   ;; itri_msgs/PointArray _next_right_lane
     (send _next_right_lane :deserialize buf ptr-) (incf ptr- (send _next_right_lane :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::PointSet :md5sum-) "23be87864922d3c27fd77ea6bdfa8034")
(setf (get itri_msgs::PointSet :datatype-) "itri_msgs/PointSet")
(setf (get itri_msgs::PointSet :definition-)
      "std_msgs/Header header
PointArray left_lane
PointArray right_lane
PointArray next_left_lane
PointArray next_right_lane

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
MSG: itri_msgs/PointArray
geometry_msgs/Point[] points

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :itri_msgs/PointSet "23be87864922d3c27fd77ea6bdfa8034")


