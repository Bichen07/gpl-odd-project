;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ProgramOutput)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ProgramOutput (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PROGRAMOUTPUT")
  (make-package "ITRI_MSGS::PROGRAMOUTPUT"))

(in-package "ROS")
;;//! \htmlinclude ProgramOutput.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ProgramOutput
  :super ros::object
  :slots (_header _output ))

(defmethod itri_msgs::ProgramOutput
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:output __output) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _header __header)
   (setq _output __output)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:output
   (&optional __output)
   (if __output (setq _output __output)) _output)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; char[] _output
    (* 1    (length _output)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; char[] _output
     (write-long (length _output) s)
     (dotimes (i (length _output))
       (write-byte (elt _output i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; char[] _output
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _output (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _output i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     ))
   ;;
   self)
  )

(setf (get itri_msgs::ProgramOutput :md5sum-) "a0307b07c162469a5f8993c1679034b8")
(setf (get itri_msgs::ProgramOutput :datatype-) "itri_msgs/ProgramOutput")
(setf (get itri_msgs::ProgramOutput :definition-)
      "Header header
char[] output

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



(provide :itri_msgs/ProgramOutput "a0307b07c162469a5f8993c1679034b8")


