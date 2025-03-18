;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Diagnostic)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Diagnostic (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::DIAGNOSTIC")
  (make-package "ITRI_MSGS::DIAGNOSTIC"))

(in-package "ROS")
;;//! \htmlinclude Diagnostic.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::Diagnostic
  :super ros::object
  :slots (_header _error_check _error_type ))

(defmethod itri_msgs::Diagnostic
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:error_check __error_check) 0.0)
    ((:error_type __error_type) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _header __header)
   (setq _error_check (float __error_check))
   (setq _error_type __error_type)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:error_check
   (&optional __error_check)
   (if __error_check (setq _error_check __error_check)) _error_check)
  (:error_type
   (&optional __error_type)
   (if __error_type (setq _error_type __error_type)) _error_type)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _error_check
    8
    ;; uint32[] _error_type
    (* 4    (length _error_type)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _error_check
       (sys::poke _error_check (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint32[] _error_type
     (write-long (length _error_type) s)
     (dotimes (i (length _error_type))
       (write-long (elt _error_type i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _error_check
     (setq _error_check (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint32[] _error_type
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _error_type (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _error_type i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get itri_msgs::Diagnostic :md5sum-) "d6d59fac2aa89b7edcb4e4b955ef5683")
(setf (get itri_msgs::Diagnostic :datatype-) "itri_msgs/Diagnostic")
(setf (get itri_msgs::Diagnostic :definition-)
      "Header header
float64 error_check 
uint32[] error_type

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



(provide :itri_msgs/Diagnostic "d6d59fac2aa89b7edcb4e4b955ef5683")


