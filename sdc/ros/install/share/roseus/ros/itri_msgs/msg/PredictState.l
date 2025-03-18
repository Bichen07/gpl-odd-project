;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PredictState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PredictState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PREDICTSTATE")
  (make-package "ITRI_MSGS::PREDICTSTATE"))

(in-package "ROS")
;;//! \htmlinclude PredictState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::PredictState
  :super ros::object
  :slots (_header _quaternion _translation _rotation _rotation_rate_bias _acceleration_bias _acceleration_scale _speed _covariance ))

(defmethod itri_msgs::PredictState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:quaternion __quaternion) (make-array 4 :initial-element 0.0 :element-type :float))
    ((:translation __translation) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:rotation __rotation) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:rotation_rate_bias __rotation_rate_bias) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:acceleration_bias __acceleration_bias) 0.0)
    ((:acceleration_scale __acceleration_scale) 0.0)
    ((:speed __speed) 0.0)
    ((:covariance __covariance) (make-array 121 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _quaternion __quaternion)
   (setq _translation __translation)
   (setq _rotation __rotation)
   (setq _rotation_rate_bias __rotation_rate_bias)
   (setq _acceleration_bias (float __acceleration_bias))
   (setq _acceleration_scale (float __acceleration_scale))
   (setq _speed (float __speed))
   (setq _covariance __covariance)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:quaternion
   (&optional __quaternion)
   (if __quaternion (setq _quaternion __quaternion)) _quaternion)
  (:translation
   (&optional __translation)
   (if __translation (setq _translation __translation)) _translation)
  (:rotation
   (&optional __rotation)
   (if __rotation (setq _rotation __rotation)) _rotation)
  (:rotation_rate_bias
   (&optional __rotation_rate_bias)
   (if __rotation_rate_bias (setq _rotation_rate_bias __rotation_rate_bias)) _rotation_rate_bias)
  (:acceleration_bias
   (&optional __acceleration_bias)
   (if __acceleration_bias (setq _acceleration_bias __acceleration_bias)) _acceleration_bias)
  (:acceleration_scale
   (&optional __acceleration_scale)
   (if __acceleration_scale (setq _acceleration_scale __acceleration_scale)) _acceleration_scale)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:covariance
   (&optional __covariance)
   (if __covariance (setq _covariance __covariance)) _covariance)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[4] _quaternion
    (* 4    4)
    ;; float32[3] _translation
    (* 4    3)
    ;; float32[3] _rotation
    (* 4    3)
    ;; float32[3] _rotation_rate_bias
    (* 4    3)
    ;; float32 _acceleration_bias
    4
    ;; float32 _acceleration_scale
    4
    ;; float32 _speed
    4
    ;; float32[121] _covariance
    (* 4    121)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[4] _quaternion
     (dotimes (i 4)
       (sys::poke (elt _quaternion i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _translation
     (dotimes (i 3)
       (sys::poke (elt _translation i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _rotation
     (dotimes (i 3)
       (sys::poke (elt _rotation i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _rotation_rate_bias
     (dotimes (i 3)
       (sys::poke (elt _rotation_rate_bias i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _acceleration_bias
       (sys::poke _acceleration_bias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _acceleration_scale
       (sys::poke _acceleration_scale (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[121] _covariance
     (dotimes (i 121)
       (sys::poke (elt _covariance i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[4] _quaternion
   (dotimes (i (length _quaternion))
     (setf (elt _quaternion i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _translation
   (dotimes (i (length _translation))
     (setf (elt _translation i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _rotation
   (dotimes (i (length _rotation))
     (setf (elt _rotation i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _rotation_rate_bias
   (dotimes (i (length _rotation_rate_bias))
     (setf (elt _rotation_rate_bias i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _acceleration_bias
     (setq _acceleration_bias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _acceleration_scale
     (setq _acceleration_scale (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[121] _covariance
   (dotimes (i (length _covariance))
     (setf (elt _covariance i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get itri_msgs::PredictState :md5sum-) "72d0803d1465f548e6ee4eb9d0ba77d3")
(setf (get itri_msgs::PredictState :datatype-) "itri_msgs/PredictState")
(setf (get itri_msgs::PredictState :definition-)
      "Header header

float32[4] quaternion
float32[3] translation
float32[3] rotation
float32[3] rotation_rate_bias
float32 acceleration_bias
float32 acceleration_scale
float32 speed

float32[121] covariance

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



(provide :itri_msgs/PredictState "72d0803d1465f548e6ee4eb9d0ba77d3")


