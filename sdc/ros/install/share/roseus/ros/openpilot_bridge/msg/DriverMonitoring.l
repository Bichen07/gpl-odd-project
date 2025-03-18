;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::DriverMonitoring)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'DriverMonitoring (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::DRIVERMONITORING")
  (make-package "OPENPILOT_BRIDGE::DRIVERMONITORING"))

(in-package "ROS")
;;//! \htmlinclude DriverMonitoring.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::DriverMonitoring
  :super ros::object
  :slots (_header _faceOrientation _stdDEPRECATED _irPwrDEPRECATED _faceOrientationStd _faceProb _frameId _descriptorDEPRECATED _rightBlinkProb _rightEyeProb _facePositionStd _leftBlinkProb _leftEyeProb _facePosition ))

(defmethod openpilot_bridge::DriverMonitoring
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:faceOrientation __faceOrientation) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:stdDEPRECATED __stdDEPRECATED) 0.0)
    ((:irPwrDEPRECATED __irPwrDEPRECATED) 0.0)
    ((:faceOrientationStd __faceOrientationStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:faceProb __faceProb) 0.0)
    ((:frameId __frameId) 0)
    ((:descriptorDEPRECATED __descriptorDEPRECATED) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:rightBlinkProb __rightBlinkProb) 0.0)
    ((:rightEyeProb __rightEyeProb) 0.0)
    ((:facePositionStd __facePositionStd) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:leftBlinkProb __leftBlinkProb) 0.0)
    ((:leftEyeProb __leftEyeProb) 0.0)
    ((:facePosition __facePosition) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _faceOrientation __faceOrientation)
   (setq _stdDEPRECATED (float __stdDEPRECATED))
   (setq _irPwrDEPRECATED (float __irPwrDEPRECATED))
   (setq _faceOrientationStd __faceOrientationStd)
   (setq _faceProb (float __faceProb))
   (setq _frameId (round __frameId))
   (setq _descriptorDEPRECATED __descriptorDEPRECATED)
   (setq _rightBlinkProb (float __rightBlinkProb))
   (setq _rightEyeProb (float __rightEyeProb))
   (setq _facePositionStd __facePositionStd)
   (setq _leftBlinkProb (float __leftBlinkProb))
   (setq _leftEyeProb (float __leftEyeProb))
   (setq _facePosition __facePosition)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:faceOrientation
   (&optional __faceOrientation)
   (if __faceOrientation (setq _faceOrientation __faceOrientation)) _faceOrientation)
  (:stdDEPRECATED
   (&optional __stdDEPRECATED)
   (if __stdDEPRECATED (setq _stdDEPRECATED __stdDEPRECATED)) _stdDEPRECATED)
  (:irPwrDEPRECATED
   (&optional __irPwrDEPRECATED)
   (if __irPwrDEPRECATED (setq _irPwrDEPRECATED __irPwrDEPRECATED)) _irPwrDEPRECATED)
  (:faceOrientationStd
   (&optional __faceOrientationStd)
   (if __faceOrientationStd (setq _faceOrientationStd __faceOrientationStd)) _faceOrientationStd)
  (:faceProb
   (&optional __faceProb)
   (if __faceProb (setq _faceProb __faceProb)) _faceProb)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:descriptorDEPRECATED
   (&optional __descriptorDEPRECATED)
   (if __descriptorDEPRECATED (setq _descriptorDEPRECATED __descriptorDEPRECATED)) _descriptorDEPRECATED)
  (:rightBlinkProb
   (&optional __rightBlinkProb)
   (if __rightBlinkProb (setq _rightBlinkProb __rightBlinkProb)) _rightBlinkProb)
  (:rightEyeProb
   (&optional __rightEyeProb)
   (if __rightEyeProb (setq _rightEyeProb __rightEyeProb)) _rightEyeProb)
  (:facePositionStd
   (&optional __facePositionStd)
   (if __facePositionStd (setq _facePositionStd __facePositionStd)) _facePositionStd)
  (:leftBlinkProb
   (&optional __leftBlinkProb)
   (if __leftBlinkProb (setq _leftBlinkProb __leftBlinkProb)) _leftBlinkProb)
  (:leftEyeProb
   (&optional __leftEyeProb)
   (if __leftEyeProb (setq _leftEyeProb __leftEyeProb)) _leftEyeProb)
  (:facePosition
   (&optional __facePosition)
   (if __facePosition (setq _facePosition __facePosition)) _facePosition)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _faceOrientation
    (* 4    (length _faceOrientation)) 4
    ;; float32 _stdDEPRECATED
    4
    ;; float32 _irPwrDEPRECATED
    4
    ;; float32[] _faceOrientationStd
    (* 4    (length _faceOrientationStd)) 4
    ;; float32 _faceProb
    4
    ;; int64 _frameId
    8
    ;; float32[] _descriptorDEPRECATED
    (* 4    (length _descriptorDEPRECATED)) 4
    ;; float32 _rightBlinkProb
    4
    ;; float32 _rightEyeProb
    4
    ;; float32[] _facePositionStd
    (* 4    (length _facePositionStd)) 4
    ;; float32 _leftBlinkProb
    4
    ;; float32 _leftEyeProb
    4
    ;; float32[] _facePosition
    (* 4    (length _facePosition)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _faceOrientation
     (write-long (length _faceOrientation) s)
     (dotimes (i (length _faceOrientation))
       (sys::poke (elt _faceOrientation i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _stdDEPRECATED
       (sys::poke _stdDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _irPwrDEPRECATED
       (sys::poke _irPwrDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _faceOrientationStd
     (write-long (length _faceOrientationStd) s)
     (dotimes (i (length _faceOrientationStd))
       (sys::poke (elt _faceOrientationStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _faceProb
       (sys::poke _faceProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32[] _descriptorDEPRECATED
     (write-long (length _descriptorDEPRECATED) s)
     (dotimes (i (length _descriptorDEPRECATED))
       (sys::poke (elt _descriptorDEPRECATED i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _rightBlinkProb
       (sys::poke _rightBlinkProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rightEyeProb
       (sys::poke _rightEyeProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _facePositionStd
     (write-long (length _facePositionStd) s)
     (dotimes (i (length _facePositionStd))
       (sys::poke (elt _facePositionStd i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _leftBlinkProb
       (sys::poke _leftBlinkProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _leftEyeProb
       (sys::poke _leftEyeProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _facePosition
     (write-long (length _facePosition) s)
     (dotimes (i (length _facePosition))
       (sys::poke (elt _facePosition i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _faceOrientation
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faceOrientation (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _faceOrientation i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _stdDEPRECATED
     (setq _stdDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _irPwrDEPRECATED
     (setq _irPwrDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _faceOrientationStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faceOrientationStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _faceOrientationStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _faceProb
     (setq _faceProb (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32[] _descriptorDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _descriptorDEPRECATED (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _descriptorDEPRECATED i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _rightBlinkProb
     (setq _rightBlinkProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rightEyeProb
     (setq _rightEyeProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _facePositionStd
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _facePositionStd (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _facePositionStd i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _leftBlinkProb
     (setq _leftBlinkProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _leftEyeProb
     (setq _leftEyeProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _facePosition
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _facePosition (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _facePosition i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::DriverMonitoring :md5sum-) "bc7bb5c40d657dda1ef2c99f7d9a20f7")
(setf (get openpilot_bridge::DriverMonitoring :datatype-) "openpilot_bridge/DriverMonitoring")
(setf (get openpilot_bridge::DriverMonitoring :definition-)
      "Header header

float32[] faceOrientation
float32 stdDEPRECATED
float32 irPwrDEPRECATED
float32[] faceOrientationStd
float32 faceProb
int64 frameId
float32[] descriptorDEPRECATED
float32 rightBlinkProb
float32 rightEyeProb
float32[] facePositionStd
float32 leftBlinkProb
float32 leftEyeProb
float32[] facePosition

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



(provide :openpilot_bridge/DriverMonitoring "bc7bb5c40d657dda1ef2c99f7d9a20f7")


