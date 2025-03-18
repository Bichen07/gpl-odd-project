;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CalibrationFeatures)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CalibrationFeatures (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CALIBRATIONFEATURES")
  (make-package "OPENPILOT_BRIDGE::CALIBRATIONFEATURES"))

(in-package "ROS")
;;//! \htmlinclude CalibrationFeatures.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CalibrationFeatures
  :super ros::object
  :slots (_header _status _p0 _p1 _frameId ))

(defmethod openpilot_bridge::CalibrationFeatures
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:status __status) (make-array 0 :initial-element 0 :element-type :integer))
    ((:p0 __p0) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:p1 __p1) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:frameId __frameId) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _status __status)
   (setq _p0 __p0)
   (setq _p1 __p1)
   (setq _frameId (round __frameId))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:p0
   (&optional __p0)
   (if __p0 (setq _p0 __p0)) _p0)
  (:p1
   (&optional __p1)
   (if __p1 (setq _p1 __p1)) _p1)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32[] _status
    (* 4    (length _status)) 4
    ;; float32[] _p0
    (* 4    (length _p0)) 4
    ;; float32[] _p1
    (* 4    (length _p1)) 4
    ;; int64 _frameId
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32[] _status
     (write-long (length _status) s)
     (dotimes (i (length _status))
       (write-long (elt _status i) s)
       )
     ;; float32[] _p0
     (write-long (length _p0) s)
     (dotimes (i (length _p0))
       (sys::poke (elt _p0 i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _p1
     (write-long (length _p1) s)
     (dotimes (i (length _p1))
       (sys::poke (elt _p1 i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _frameId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _frameId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _frameId) (= (length (_frameId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_frameId . bv) 0) 0) s)
              (write-long (ash (elt (_frameId . bv) 1) -1) s))
             ((and (class _frameId) (= (length (_frameId . bv)) 1)) ;; big1
              (write-long (elt (_frameId . bv) 0) s)
              (write-long (if (>= _frameId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _frameId s)(write-long (if (>= _frameId 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32[] _status
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _status (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _status i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float32[] _p0
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _p0 (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _p0 i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _p1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _p1 (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _p1 i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _frameId
#+(or :alpha :irix6 :x86_64)
      (setf _frameId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _frameId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get openpilot_bridge::CalibrationFeatures :md5sum-) "cfa74460f4a8fc86e73061d046065618")
(setf (get openpilot_bridge::CalibrationFeatures :datatype-) "openpilot_bridge/CalibrationFeatures")
(setf (get openpilot_bridge::CalibrationFeatures :definition-)
      "Header header

int32[] status
float32[] p0
float32[] p1
int64 frameId

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



(provide :openpilot_bridge/CalibrationFeatures "cfa74460f4a8fc86e73061d046065618")


