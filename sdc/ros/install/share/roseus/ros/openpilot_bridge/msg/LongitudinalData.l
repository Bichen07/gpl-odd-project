;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LongitudinalData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LongitudinalData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LONGITUDINALDATA")
  (make-package "OPENPILOT_BRIDGE::LONGITUDINALDATA"))

(in-package "ROS")
;;//! \htmlinclude LongitudinalData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LongitudinalData
  :super ros::object
  :slots (_header _accelerations _speeds ))

(defmethod openpilot_bridge::LongitudinalData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:accelerations __accelerations) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:speeds __speeds) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _accelerations __accelerations)
   (setq _speeds __speeds)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:accelerations
   (&optional __accelerations)
   (if __accelerations (setq _accelerations __accelerations)) _accelerations)
  (:speeds
   (&optional __speeds)
   (if __speeds (setq _speeds __speeds)) _speeds)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _accelerations
    (* 4    (length _accelerations)) 4
    ;; float32[] _speeds
    (* 4    (length _speeds)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _accelerations
     (write-long (length _accelerations) s)
     (dotimes (i (length _accelerations))
       (sys::poke (elt _accelerations i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _speeds
     (write-long (length _speeds) s)
     (dotimes (i (length _speeds))
       (sys::poke (elt _speeds i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _accelerations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _accelerations (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _accelerations i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _speeds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _speeds (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _speeds i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::LongitudinalData :md5sum-) "ec9fd42d927e2b42fdfea3cf5afe68a1")
(setf (get openpilot_bridge::LongitudinalData :datatype-) "openpilot_bridge/LongitudinalData")
(setf (get openpilot_bridge::LongitudinalData :definition-)
      "Header header

float32[] accelerations
float32[] speeds

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



(provide :openpilot_bridge/LongitudinalData "ec9fd42d927e2b42fdfea3cf5afe68a1")


