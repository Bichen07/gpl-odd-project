;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LateralPIDTuning)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LateralPIDTuning (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALPIDTUNING")
  (make-package "OPENPILOT_BRIDGE::LATERALPIDTUNING"))

(in-package "ROS")
;;//! \htmlinclude LateralPIDTuning.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LateralPIDTuning
  :super ros::object
  :slots (_header _kiBP _kf _kiV _kpV _kpBP ))

(defmethod openpilot_bridge::LateralPIDTuning
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:kiBP __kiBP) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:kf __kf) 0.0)
    ((:kiV __kiV) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:kpV __kpV) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:kpBP __kpBP) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _kiBP __kiBP)
   (setq _kf (float __kf))
   (setq _kiV __kiV)
   (setq _kpV __kpV)
   (setq _kpBP __kpBP)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:kiBP
   (&optional __kiBP)
   (if __kiBP (setq _kiBP __kiBP)) _kiBP)
  (:kf
   (&optional __kf)
   (if __kf (setq _kf __kf)) _kf)
  (:kiV
   (&optional __kiV)
   (if __kiV (setq _kiV __kiV)) _kiV)
  (:kpV
   (&optional __kpV)
   (if __kpV (setq _kpV __kpV)) _kpV)
  (:kpBP
   (&optional __kpBP)
   (if __kpBP (setq _kpBP __kpBP)) _kpBP)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _kiBP
    (* 4    (length _kiBP)) 4
    ;; float32 _kf
    4
    ;; float32[] _kiV
    (* 4    (length _kiV)) 4
    ;; float32[] _kpV
    (* 4    (length _kpV)) 4
    ;; float32[] _kpBP
    (* 4    (length _kpBP)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _kiBP
     (write-long (length _kiBP) s)
     (dotimes (i (length _kiBP))
       (sys::poke (elt _kiBP i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _kf
       (sys::poke _kf (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _kiV
     (write-long (length _kiV) s)
     (dotimes (i (length _kiV))
       (sys::poke (elt _kiV i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _kpV
     (write-long (length _kpV) s)
     (dotimes (i (length _kpV))
       (sys::poke (elt _kpV i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _kpBP
     (write-long (length _kpBP) s)
     (dotimes (i (length _kpBP))
       (sys::poke (elt _kpBP i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _kiBP
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kiBP (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _kiBP i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _kf
     (setq _kf (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _kiV
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kiV (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _kiV i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _kpV
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kpV (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _kpV i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _kpBP
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kpBP (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _kpBP i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::LateralPIDTuning :md5sum-) "14a5c3b4c8e3b3c02e1965d864d407cd")
(setf (get openpilot_bridge::LateralPIDTuning :datatype-) "openpilot_bridge/LateralPIDTuning")
(setf (get openpilot_bridge::LateralPIDTuning :definition-)
      "Header header

float32[] kiBP
float32 kf
float32[] kiV
float32[] kpV
float32[] kpBP

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



(provide :openpilot_bridge/LateralPIDTuning "14a5c3b4c8e3b3c02e1965d864d407cd")


