;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Route_info)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Route_info (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ROUTE_INFO")
  (make-package "ITRI_MSGS::ROUTE_INFO"))

(in-package "ROS")
;;//! \htmlinclude Route_info.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::Route_info
  :super ros::object
  :slots (_header _road_w _road_r ))

(defmethod itri_msgs::Route_info
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:road_w __road_w) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:road_r __road_r) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _road_w __road_w)
   (setq _road_r __road_r)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:road_w
   (&optional __road_w)
   (if __road_w (setq _road_w __road_w)) _road_w)
  (:road_r
   (&optional __road_r)
   (if __road_r (setq _road_r __road_r)) _road_r)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64[] _road_w
    (* 8    (length _road_w)) 4
    ;; float64[] _road_r
    (* 8    (length _road_r)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64[] _road_w
     (write-long (length _road_w) s)
     (dotimes (i (length _road_w))
       (sys::poke (elt _road_w i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _road_r
     (write-long (length _road_r) s)
     (dotimes (i (length _road_r))
       (sys::poke (elt _road_r i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64[] _road_w
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _road_w (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _road_w i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _road_r
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _road_r (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _road_r i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(setf (get itri_msgs::Route_info :md5sum-) "f3f43d9100d2d837ee1ce84b99daa0aa")
(setf (get itri_msgs::Route_info :datatype-) "itri_msgs/Route_info")
(setf (get itri_msgs::Route_info :definition-)
      "Header header
float64[] road_w
float64[] road_r

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



(provide :itri_msgs/Route_info "f3f43d9100d2d837ee1ce84b99daa0aa")


