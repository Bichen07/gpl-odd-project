;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LateralLQRTuning)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LateralLQRTuning (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALLQRTUNING")
  (make-package "OPENPILOT_BRIDGE::LATERALLQRTUNING"))

(in-package "ROS")
;;//! \htmlinclude LateralLQRTuning.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LateralLQRTuning
  :super ros::object
  :slots (_header _a _c _scale _ki _l _b _dcGain _k ))

(defmethod openpilot_bridge::LateralLQRTuning
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:a __a) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:c __c) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:scale __scale) 0.0)
    ((:ki __ki) 0.0)
    ((:l __l) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:b __b) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:dcGain __dcGain) 0.0)
    ((:k __k) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _a __a)
   (setq _c __c)
   (setq _scale (float __scale))
   (setq _ki (float __ki))
   (setq _l __l)
   (setq _b __b)
   (setq _dcGain (float __dcGain))
   (setq _k __k)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:c
   (&optional __c)
   (if __c (setq _c __c)) _c)
  (:scale
   (&optional __scale)
   (if __scale (setq _scale __scale)) _scale)
  (:ki
   (&optional __ki)
   (if __ki (setq _ki __ki)) _ki)
  (:l
   (&optional __l)
   (if __l (setq _l __l)) _l)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:dcGain
   (&optional __dcGain)
   (if __dcGain (setq _dcGain __dcGain)) _dcGain)
  (:k
   (&optional __k)
   (if __k (setq _k __k)) _k)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _a
    (* 4    (length _a)) 4
    ;; float32[] _c
    (* 4    (length _c)) 4
    ;; float32 _scale
    4
    ;; float32 _ki
    4
    ;; float32[] _l
    (* 4    (length _l)) 4
    ;; float32[] _b
    (* 4    (length _b)) 4
    ;; float32 _dcGain
    4
    ;; float32[] _k
    (* 4    (length _k)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _a
     (write-long (length _a) s)
     (dotimes (i (length _a))
       (sys::poke (elt _a i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _c
     (write-long (length _c) s)
     (dotimes (i (length _c))
       (sys::poke (elt _c i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _scale
       (sys::poke _scale (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ki
       (sys::poke _ki (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _l
     (write-long (length _l) s)
     (dotimes (i (length _l))
       (sys::poke (elt _l i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _b
     (write-long (length _b) s)
     (dotimes (i (length _b))
       (sys::poke (elt _b i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _dcGain
       (sys::poke _dcGain (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _k
     (write-long (length _k) s)
     (dotimes (i (length _k))
       (sys::poke (elt _k i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _a
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _a (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _a i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _c
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _c (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _c i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _scale
     (setq _scale (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ki
     (setq _ki (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _l
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _l (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _l i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _b
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _b (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _b i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _dcGain
     (setq _dcGain (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _k
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _k (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _k i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::LateralLQRTuning :md5sum-) "1a86dbdfea134b9e6760e87aaaceabc4")
(setf (get openpilot_bridge::LateralLQRTuning :datatype-) "openpilot_bridge/LateralLQRTuning")
(setf (get openpilot_bridge::LateralLQRTuning :definition-)
      "Header header

float32[] a
float32[] c
float32 scale
float32 ki
float32[] l
float32[] b
float32 dcGain
float32[] k

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



(provide :openpilot_bridge/LateralLQRTuning "1a86dbdfea134b9e6760e87aaaceabc4")


