;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::DetectedObjectCovarianceArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'DetectedObjectCovarianceArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::DETECTEDOBJECTCOVARIANCEARRAY")
  (make-package "ITRI_MSGS::DETECTEDOBJECTCOVARIANCEARRAY"))

(in-package "ROS")
;;//! \htmlinclude DetectedObjectCovarianceArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::DetectedObjectCovarianceArray
  :super ros::object
  :slots (_header _covariance ))

(defmethod itri_msgs::DetectedObjectCovarianceArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:covariance __covariance) (let (r) (dotimes (i 0) (push (instance itri_msgs::DetectedObjectCovariance :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _covariance __covariance)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:covariance
   (&rest __covariance)
   (if (keywordp (car __covariance))
       (send* _covariance __covariance)
     (progn
       (if __covariance (setq _covariance (car __covariance)))
       _covariance)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/DetectedObjectCovariance[] _covariance
    (apply #'+ (send-all _covariance :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/DetectedObjectCovariance[] _covariance
     (write-long (length _covariance) s)
     (dolist (elem _covariance)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/DetectedObjectCovariance[] _covariance
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _covariance (let (r) (dotimes (i n) (push (instance itri_msgs::DetectedObjectCovariance :init) r)) r))
     (dolist (elem- _covariance)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::DetectedObjectCovarianceArray :md5sum-) "84d2a2edd4fea20863397b757e83f10d")
(setf (get itri_msgs::DetectedObjectCovarianceArray :datatype-) "itri_msgs/DetectedObjectCovarianceArray")
(setf (get itri_msgs::DetectedObjectCovarianceArray :definition-)
      "std_msgs/Header header
DetectedObjectCovariance[] covariance

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
MSG: itri_msgs/DetectedObjectCovariance
std_msgs/Header header

uint32 id
float32 valueX
float32 valueY

")



(provide :itri_msgs/DetectedObjectCovarianceArray "84d2a2edd4fea20863397b757e83f10d")


