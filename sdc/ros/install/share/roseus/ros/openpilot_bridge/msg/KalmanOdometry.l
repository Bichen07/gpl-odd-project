;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::KalmanOdometry)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'KalmanOdometry (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::KALMANODOMETRY")
  (make-package "OPENPILOT_BRIDGE::KALMANODOMETRY"))

(in-package "ROS")
;;//! \htmlinclude KalmanOdometry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::KalmanOdometry
  :super ros::object
  :slots (_header _rotStd _transStd _trans _rot ))

(defmethod openpilot_bridge::KalmanOdometry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rotStd __rotStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:transStd __transStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:trans __trans) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:rot __rot) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _rotStd __rotStd)
   (setq _transStd __transStd)
   (setq _trans __trans)
   (setq _rot __rot)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rotStd
   (&optional __rotStd)
   (if __rotStd (setq _rotStd __rotStd)) _rotStd)
  (:transStd
   (&optional __transStd)
   (if __transStd (setq _transStd __transStd)) _transStd)
  (:trans
   (&optional __trans)
   (if __trans (setq _trans __trans)) _trans)
  (:rot
   (&optional __rot)
   (if __rot (setq _rot __rot)) _rot)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _rotStd
    (* 4    (length _rotStd)) 4
    ;; float32[] _transStd
    (* 4    (length _transStd)) 4
    ;; float32[] _trans
    (* 4    (length _trans)) 4
    ;; float32[] _rot
    (* 4    (length _rot)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _rotStd
     (write-long (length _rotStd) s)
     (dotimes (i (length _rotStd))
       (sys::poke (elt _rotStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _transStd
     (write-long (length _transStd) s)
     (dotimes (i (length _transStd))
       (sys::poke (elt _transStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _trans
     (write-long (length _trans) s)
     (dotimes (i (length _trans))
       (sys::poke (elt _trans i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _rot
     (write-long (length _rot) s)
     (dotimes (i (length _rot))
       (sys::poke (elt _rot i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _rotStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rotStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rotStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _transStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _transStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _transStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _trans
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _trans (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _trans i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _rot
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rot (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rot i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::KalmanOdometry :md5sum-) "de61c6c9f1d1fd741a634f5a0e68519d")
(setf (get openpilot_bridge::KalmanOdometry :datatype-) "openpilot_bridge/KalmanOdometry")
(setf (get openpilot_bridge::KalmanOdometry :definition-)
      "Header header

float32[] rotStd
float32[] transStd
float32[] trans
float32[] rot

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



(provide :openpilot_bridge/KalmanOdometry "de61c6c9f1d1fd741a634f5a0e68519d")


