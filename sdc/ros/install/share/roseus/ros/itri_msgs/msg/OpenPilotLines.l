;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::OpenPilotLines)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'OpenPilotLines (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::OPENPILOTLINES")
  (make-package "ITRI_MSGS::OPENPILOTLINES"))

(in-package "ROS")
;;//! \htmlinclude OpenPilotLines.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::OpenPilotLines
  :super ros::object
  :slots (_header _left_line _right_line _desired_line ))

(defmethod itri_msgs::OpenPilotLines
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:left_line __left_line) (instance itri_msgs::OpenPilotLine :init))
    ((:right_line __right_line) (instance itri_msgs::OpenPilotLine :init))
    ((:desired_line __desired_line) (instance itri_msgs::OpenPilotLine :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _left_line __left_line)
   (setq _right_line __right_line)
   (setq _desired_line __desired_line)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
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
  (:desired_line
   (&rest __desired_line)
   (if (keywordp (car __desired_line))
       (send* _desired_line __desired_line)
     (progn
       (if __desired_line (setq _desired_line (car __desired_line)))
       _desired_line)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/OpenPilotLine _left_line
    (send _left_line :serialization-length)
    ;; itri_msgs/OpenPilotLine _right_line
    (send _right_line :serialization-length)
    ;; itri_msgs/OpenPilotLine _desired_line
    (send _desired_line :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/OpenPilotLine _left_line
       (send _left_line :serialize s)
     ;; itri_msgs/OpenPilotLine _right_line
       (send _right_line :serialize s)
     ;; itri_msgs/OpenPilotLine _desired_line
       (send _desired_line :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/OpenPilotLine _left_line
     (send _left_line :deserialize buf ptr-) (incf ptr- (send _left_line :serialization-length))
   ;; itri_msgs/OpenPilotLine _right_line
     (send _right_line :deserialize buf ptr-) (incf ptr- (send _right_line :serialization-length))
   ;; itri_msgs/OpenPilotLine _desired_line
     (send _desired_line :deserialize buf ptr-) (incf ptr- (send _desired_line :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::OpenPilotLines :md5sum-) "9096eb6f351b82a595c1de88685f239b")
(setf (get itri_msgs::OpenPilotLines :datatype-) "itri_msgs/OpenPilotLines")
(setf (get itri_msgs::OpenPilotLines :definition-)
      "std_msgs/Header header
OpenPilotLine left_line
OpenPilotLine right_line
OpenPilotLine desired_line

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
MSG: itri_msgs/OpenPilotLine
std_msgs/Header header

uint8 probability
float32[] coefficient

")



(provide :itri_msgs/OpenPilotLines "9096eb6f351b82a595c1de88685f239b")


