;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CameraOdometry)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CameraOdometry (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CAMERAODOMETRY")
  (make-package "OPENPILOT_BRIDGE::CAMERAODOMETRY"))

(in-package "ROS")
;;//! \htmlinclude CameraOdometry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CameraOdometry
  :super ros::object
  :slots (_header _transStd _timestampEof _frameId _rotStd _trans _rot ))

(defmethod openpilot_bridge::CameraOdometry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:transStd __transStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:timestampEof __timestampEof) 0)
    ((:frameId __frameId) 0)
    ((:rotStd __rotStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:trans __trans) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:rot __rot) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _transStd __transStd)
   (setq _timestampEof (round __timestampEof))
   (setq _frameId (round __frameId))
   (setq _rotStd __rotStd)
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
  (:transStd
   (&optional __transStd)
   (if __transStd (setq _transStd __transStd)) _transStd)
  (:timestampEof
   (&optional __timestampEof)
   (if __timestampEof (setq _timestampEof __timestampEof)) _timestampEof)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:rotStd
   (&optional __rotStd)
   (if __rotStd (setq _rotStd __rotStd)) _rotStd)
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
    ;; float32[] _transStd
    (* 4    (length _transStd)) 4
    ;; int64 _timestampEof
    8
    ;; int64 _frameId
    8
    ;; float32[] _rotStd
    (* 4    (length _rotStd)) 4
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
     ;; float32[] _transStd
     (write-long (length _transStd) s)
     (dotimes (i (length _transStd))
       (sys::poke (elt _transStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestampEof (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestampEof) (= (length (_timestampEof . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestampEof . bv) 0) 0) s)
              (write-long (ash (elt (_timestampEof . bv) 1) -1) s))
             ((and (class _timestampEof) (= (length (_timestampEof . bv)) 1)) ;; big1
              (write-long (elt (_timestampEof . bv) 0) s)
              (write-long (if (>= _timestampEof 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestampEof s)(write-long (if (>= _timestampEof 0) 0 #xffffffff) s)))
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
     ;; float32[] _rotStd
     (write-long (length _rotStd) s)
     (dotimes (i (length _rotStd))
       (sys::poke (elt _rotStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
   ;; float32[] _transStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _transStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _transStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
      (setf _timestampEof (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestampEof (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
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
   ;; float32[] _rotStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rotStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rotStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
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

(setf (get openpilot_bridge::CameraOdometry :md5sum-) "64230caa35d768ea103ac189eaf3f493")
(setf (get openpilot_bridge::CameraOdometry :datatype-) "openpilot_bridge/CameraOdometry")
(setf (get openpilot_bridge::CameraOdometry :definition-)
      "Header header

float32[] transStd
int64 timestampEof
int64 frameId
float32[] rotStd
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



(provide :openpilot_bridge/CameraOdometry "64230caa35d768ea103ac189eaf3f493")


