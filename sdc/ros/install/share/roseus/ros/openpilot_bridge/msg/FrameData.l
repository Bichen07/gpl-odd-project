;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::FrameData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'FrameData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::FRAMEDATA")
  (make-package "OPENPILOT_BRIDGE::FRAMEDATA"))

(in-package "ROS")
;;//! \htmlinclude FrameData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::FrameData
  :super ros::object
  :slots (_header _integLines _frameLength _timestampSof _lensTruePos _timestampEof _transform _frameId _encodeId _androidCaptureResult _gainFrac _lensSag _globalGain _lensErr _image _frameType _lensPos ))

(defmethod openpilot_bridge::FrameData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:integLines __integLines) 0)
    ((:frameLength __frameLength) 0)
    ((:timestampSof __timestampSof) 0)
    ((:lensTruePos __lensTruePos) 0.0)
    ((:timestampEof __timestampEof) 0)
    ((:transform __transform) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:frameId __frameId) 0)
    ((:encodeId __encodeId) 0)
    ((:androidCaptureResult __androidCaptureResult) (instance openpilot_bridge::AndroidCaptureResult :init))
    ((:gainFrac __gainFrac) 0.0)
    ((:lensSag __lensSag) 0.0)
    ((:globalGain __globalGain) 0)
    ((:lensErr __lensErr) 0.0)
    ((:image __image) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:frameType __frameType) 0)
    ((:lensPos __lensPos) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _integLines (round __integLines))
   (setq _frameLength (round __frameLength))
   (setq _timestampSof (round __timestampSof))
   (setq _lensTruePos (float __lensTruePos))
   (setq _timestampEof (round __timestampEof))
   (setq _transform __transform)
   (setq _frameId (round __frameId))
   (setq _encodeId (round __encodeId))
   (setq _androidCaptureResult __androidCaptureResult)
   (setq _gainFrac (float __gainFrac))
   (setq _lensSag (float __lensSag))
   (setq _globalGain (round __globalGain))
   (setq _lensErr (float __lensErr))
   (setq _image __image)
   (setq _frameType (round __frameType))
   (setq _lensPos (round __lensPos))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:integLines
   (&optional __integLines)
   (if __integLines (setq _integLines __integLines)) _integLines)
  (:frameLength
   (&optional __frameLength)
   (if __frameLength (setq _frameLength __frameLength)) _frameLength)
  (:timestampSof
   (&optional __timestampSof)
   (if __timestampSof (setq _timestampSof __timestampSof)) _timestampSof)
  (:lensTruePos
   (&optional __lensTruePos)
   (if __lensTruePos (setq _lensTruePos __lensTruePos)) _lensTruePos)
  (:timestampEof
   (&optional __timestampEof)
   (if __timestampEof (setq _timestampEof __timestampEof)) _timestampEof)
  (:transform
   (&optional __transform)
   (if __transform (setq _transform __transform)) _transform)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:encodeId
   (&optional __encodeId)
   (if __encodeId (setq _encodeId __encodeId)) _encodeId)
  (:androidCaptureResult
   (&rest __androidCaptureResult)
   (if (keywordp (car __androidCaptureResult))
       (send* _androidCaptureResult __androidCaptureResult)
     (progn
       (if __androidCaptureResult (setq _androidCaptureResult (car __androidCaptureResult)))
       _androidCaptureResult)))
  (:gainFrac
   (&optional __gainFrac)
   (if __gainFrac (setq _gainFrac __gainFrac)) _gainFrac)
  (:lensSag
   (&optional __lensSag)
   (if __lensSag (setq _lensSag __lensSag)) _lensSag)
  (:globalGain
   (&optional __globalGain)
   (if __globalGain (setq _globalGain __globalGain)) _globalGain)
  (:lensErr
   (&optional __lensErr)
   (if __lensErr (setq _lensErr __lensErr)) _lensErr)
  (:image
   (&optional __image)
   (if __image (setq _image __image)) _image)
  (:frameType
   (&optional __frameType)
   (if __frameType (setq _frameType __frameType)) _frameType)
  (:lensPos
   (&optional __lensPos)
   (if __lensPos (setq _lensPos __lensPos)) _lensPos)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _integLines
    4
    ;; int32 _frameLength
    4
    ;; int64 _timestampSof
    8
    ;; float32 _lensTruePos
    4
    ;; int64 _timestampEof
    8
    ;; float32[] _transform
    (* 4    (length _transform)) 4
    ;; int64 _frameId
    8
    ;; int64 _encodeId
    8
    ;; openpilot_bridge/AndroidCaptureResult _androidCaptureResult
    (send _androidCaptureResult :serialization-length)
    ;; float32 _gainFrac
    4
    ;; float32 _lensSag
    4
    ;; int32 _globalGain
    4
    ;; float32 _lensErr
    4
    ;; string[] _image
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _image)) 4
    ;; uint32 _frameType
    4
    ;; int32 _lensPos
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _integLines
       (write-long _integLines s)
     ;; int32 _frameLength
       (write-long _frameLength s)
     ;; int64 _timestampSof
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestampSof (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestampSof) (= (length (_timestampSof . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestampSof . bv) 0) 0) s)
              (write-long (ash (elt (_timestampSof . bv) 1) -1) s))
             ((and (class _timestampSof) (= (length (_timestampSof . bv)) 1)) ;; big1
              (write-long (elt (_timestampSof . bv) 0) s)
              (write-long (if (>= _timestampSof 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestampSof s)(write-long (if (>= _timestampSof 0) 0 #xffffffff) s)))
     ;; float32 _lensTruePos
       (sys::poke _lensTruePos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32[] _transform
     (write-long (length _transform) s)
     (dotimes (i (length _transform))
       (sys::poke (elt _transform i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; int64 _encodeId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _encodeId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _encodeId) (= (length (_encodeId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_encodeId . bv) 0) 0) s)
              (write-long (ash (elt (_encodeId . bv) 1) -1) s))
             ((and (class _encodeId) (= (length (_encodeId . bv)) 1)) ;; big1
              (write-long (elt (_encodeId . bv) 0) s)
              (write-long (if (>= _encodeId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _encodeId s)(write-long (if (>= _encodeId 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/AndroidCaptureResult _androidCaptureResult
       (send _androidCaptureResult :serialize s)
     ;; float32 _gainFrac
       (sys::poke _gainFrac (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _lensSag
       (sys::poke _lensSag (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _globalGain
       (write-long _globalGain s)
     ;; float32 _lensErr
       (sys::poke _lensErr (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _image
     (write-long (length _image) s)
     (dolist (elem _image)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint32 _frameType
       (write-long _frameType s)
     ;; int32 _lensPos
       (write-long _lensPos s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _integLines
     (setq _integLines (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _frameLength
     (setq _frameLength (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _timestampSof
#+(or :alpha :irix6 :x86_64)
      (setf _timestampSof (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestampSof (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _lensTruePos
     (setq _lensTruePos (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32[] _transform
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _transform (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _transform i) (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; int64 _encodeId
#+(or :alpha :irix6 :x86_64)
      (setf _encodeId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _encodeId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/AndroidCaptureResult _androidCaptureResult
     (send _androidCaptureResult :deserialize buf ptr-) (incf ptr- (send _androidCaptureResult :serialization-length))
   ;; float32 _gainFrac
     (setq _gainFrac (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _lensSag
     (setq _lensSag (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _globalGain
     (setq _globalGain (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _lensErr
     (setq _lensErr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _image
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _image (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _image i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint32 _frameType
     (setq _frameType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lensPos
     (setq _lensPos (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::FrameData :md5sum-) "7e0f94da917645797426b704505952d4")
(setf (get openpilot_bridge::FrameData :datatype-) "openpilot_bridge/FrameData")
(setf (get openpilot_bridge::FrameData :definition-)
      "Header header

int32 integLines
int32 frameLength
int64 timestampSof
float32 lensTruePos
int64 timestampEof
float32[] transform
int64 frameId
int64 encodeId
AndroidCaptureResult androidCaptureResult
float32 gainFrac
float32 lensSag
int32 globalGain
float32 lensErr
string[] image
uint32 frameType # enum const: FrameType
int32 lensPos

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

================================================================================
MSG: openpilot_bridge/AndroidCaptureResult
Header header

int32 exposureTime
int32 displayRotation
float32[] colorCorrectionGains
int32 sensitivity
int64 rollingShutterSkew
int32[] colorCorrectionTransform
int32 frameDuration

")



(provide :openpilot_bridge/FrameData "7e0f94da917645797426b704505952d4")


