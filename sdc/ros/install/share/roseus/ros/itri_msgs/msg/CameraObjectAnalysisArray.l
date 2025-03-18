;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::CameraObjectAnalysisArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'CameraObjectAnalysisArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::CAMERAOBJECTANALYSISARRAY")
  (make-package "ITRI_MSGS::CAMERAOBJECTANALYSISARRAY"))

(in-package "ROS")
;;//! \htmlinclude CameraObjectAnalysisArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::CameraObjectAnalysisArray
  :super ros::object
  :slots (_header _objects ))

(defmethod itri_msgs::CameraObjectAnalysisArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:objects __objects) (let (r) (dotimes (i 0) (push (instance itri_msgs::CameraObjectAnalysis :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _objects __objects)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/CameraObjectAnalysis[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/CameraObjectAnalysis[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/CameraObjectAnalysis[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance itri_msgs::CameraObjectAnalysis :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::CameraObjectAnalysisArray :md5sum-) "d882f91f0da4bdfa63df0ad6e1bad6da")
(setf (get itri_msgs::CameraObjectAnalysisArray :datatype-) "itri_msgs/CameraObjectAnalysisArray")
(setf (get itri_msgs::CameraObjectAnalysisArray :definition-)
      "std_msgs/Header header
CameraObjectAnalysis[] objects

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
MSG: itri_msgs/CameraObjectAnalysis
uint32 id
float32 center_distance
float32 diou

")



(provide :itri_msgs/CameraObjectAnalysisArray "d882f91f0da4bdfa63df0ad6e1bad6da")


