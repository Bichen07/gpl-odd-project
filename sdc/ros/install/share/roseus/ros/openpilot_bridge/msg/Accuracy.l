;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Accuracy)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Accuracy (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ACCURACY")
  (make-package "OPENPILOT_BRIDGE::ACCURACY"))

(in-package "ROS")
;;//! \htmlinclude Accuracy.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Accuracy
  :super ros::object
  :slots (_header _vNEDError _rollError _headingError _ellipsoidSemiMajorError _ellipsoidOrientationError _pNEDError _ellipsoidSemiMinorError _pitchError ))

(defmethod openpilot_bridge::Accuracy
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vNEDError __vNEDError) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:rollError __rollError) 0.0)
    ((:headingError __headingError) 0.0)
    ((:ellipsoidSemiMajorError __ellipsoidSemiMajorError) 0.0)
    ((:ellipsoidOrientationError __ellipsoidOrientationError) 0.0)
    ((:pNEDError __pNEDError) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:ellipsoidSemiMinorError __ellipsoidSemiMinorError) 0.0)
    ((:pitchError __pitchError) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _vNEDError __vNEDError)
   (setq _rollError (float __rollError))
   (setq _headingError (float __headingError))
   (setq _ellipsoidSemiMajorError (float __ellipsoidSemiMajorError))
   (setq _ellipsoidOrientationError (float __ellipsoidOrientationError))
   (setq _pNEDError __pNEDError)
   (setq _ellipsoidSemiMinorError (float __ellipsoidSemiMinorError))
   (setq _pitchError (float __pitchError))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vNEDError
   (&optional __vNEDError)
   (if __vNEDError (setq _vNEDError __vNEDError)) _vNEDError)
  (:rollError
   (&optional __rollError)
   (if __rollError (setq _rollError __rollError)) _rollError)
  (:headingError
   (&optional __headingError)
   (if __headingError (setq _headingError __headingError)) _headingError)
  (:ellipsoidSemiMajorError
   (&optional __ellipsoidSemiMajorError)
   (if __ellipsoidSemiMajorError (setq _ellipsoidSemiMajorError __ellipsoidSemiMajorError)) _ellipsoidSemiMajorError)
  (:ellipsoidOrientationError
   (&optional __ellipsoidOrientationError)
   (if __ellipsoidOrientationError (setq _ellipsoidOrientationError __ellipsoidOrientationError)) _ellipsoidOrientationError)
  (:pNEDError
   (&optional __pNEDError)
   (if __pNEDError (setq _pNEDError __pNEDError)) _pNEDError)
  (:ellipsoidSemiMinorError
   (&optional __ellipsoidSemiMinorError)
   (if __ellipsoidSemiMinorError (setq _ellipsoidSemiMinorError __ellipsoidSemiMinorError)) _ellipsoidSemiMinorError)
  (:pitchError
   (&optional __pitchError)
   (if __pitchError (setq _pitchError __pitchError)) _pitchError)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _vNEDError
    (* 4    (length _vNEDError)) 4
    ;; float32 _rollError
    4
    ;; float32 _headingError
    4
    ;; float32 _ellipsoidSemiMajorError
    4
    ;; float32 _ellipsoidOrientationError
    4
    ;; float32[] _pNEDError
    (* 4    (length _pNEDError)) 4
    ;; float32 _ellipsoidSemiMinorError
    4
    ;; float32 _pitchError
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _vNEDError
     (write-long (length _vNEDError) s)
     (dotimes (i (length _vNEDError))
       (sys::poke (elt _vNEDError i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _rollError
       (sys::poke _rollError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _headingError
       (sys::poke _headingError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ellipsoidSemiMajorError
       (sys::poke _ellipsoidSemiMajorError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ellipsoidOrientationError
       (sys::poke _ellipsoidOrientationError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _pNEDError
     (write-long (length _pNEDError) s)
     (dotimes (i (length _pNEDError))
       (sys::poke (elt _pNEDError i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _ellipsoidSemiMinorError
       (sys::poke _ellipsoidSemiMinorError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pitchError
       (sys::poke _pitchError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _vNEDError
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vNEDError (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _vNEDError i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _rollError
     (setq _rollError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _headingError
     (setq _headingError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ellipsoidSemiMajorError
     (setq _ellipsoidSemiMajorError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ellipsoidOrientationError
     (setq _ellipsoidOrientationError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _pNEDError
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pNEDError (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _pNEDError i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _ellipsoidSemiMinorError
     (setq _ellipsoidSemiMinorError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pitchError
     (setq _pitchError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::Accuracy :md5sum-) "edfdee1e677d557df6dcfc54fda17a60")
(setf (get openpilot_bridge::Accuracy :datatype-) "openpilot_bridge/Accuracy")
(setf (get openpilot_bridge::Accuracy :definition-)
      "Header header

float32[] vNEDError
float32 rollError
float32 headingError
float32 ellipsoidSemiMajorError
float32 ellipsoidOrientationError
float32[] pNEDError
float32 ellipsoidSemiMinorError
float32 pitchError

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



(provide :openpilot_bridge/Accuracy "edfdee1e677d557df6dcfc54fda17a60")


