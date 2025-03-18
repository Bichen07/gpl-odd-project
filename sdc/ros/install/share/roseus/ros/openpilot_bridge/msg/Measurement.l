;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Measurement)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Measurement (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEASUREMENT")
  (make-package "OPENPILOT_BRIDGE::MEASUREMENT"))

(in-package "ROS")
;;//! \htmlinclude Measurement.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Measurement
  :super ros::object
  :slots (_header _gnssId _carrierPhaseStdev _pseudorange _doppler _sigId _svId _carrierCycles _dopplerStdev _pseudorangeStdev _cno _locktime _glonassFrequencyIndex _trackingStatus ))

(defmethod openpilot_bridge::Measurement
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gnssId __gnssId) 0)
    ((:carrierPhaseStdev __carrierPhaseStdev) 0.0)
    ((:pseudorange __pseudorange) 0.0)
    ((:doppler __doppler) 0.0)
    ((:sigId __sigId) 0)
    ((:svId __svId) 0)
    ((:carrierCycles __carrierCycles) 0.0)
    ((:dopplerStdev __dopplerStdev) 0.0)
    ((:pseudorangeStdev __pseudorangeStdev) 0.0)
    ((:cno __cno) 0)
    ((:locktime __locktime) 0)
    ((:glonassFrequencyIndex __glonassFrequencyIndex) 0)
    ((:trackingStatus __trackingStatus) (instance openpilot_bridge::TrackingStatus :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _gnssId (round __gnssId))
   (setq _carrierPhaseStdev (float __carrierPhaseStdev))
   (setq _pseudorange (float __pseudorange))
   (setq _doppler (float __doppler))
   (setq _sigId (round __sigId))
   (setq _svId (round __svId))
   (setq _carrierCycles (float __carrierCycles))
   (setq _dopplerStdev (float __dopplerStdev))
   (setq _pseudorangeStdev (float __pseudorangeStdev))
   (setq _cno (round __cno))
   (setq _locktime (round __locktime))
   (setq _glonassFrequencyIndex (round __glonassFrequencyIndex))
   (setq _trackingStatus __trackingStatus)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gnssId
   (&optional __gnssId)
   (if __gnssId (setq _gnssId __gnssId)) _gnssId)
  (:carrierPhaseStdev
   (&optional __carrierPhaseStdev)
   (if __carrierPhaseStdev (setq _carrierPhaseStdev __carrierPhaseStdev)) _carrierPhaseStdev)
  (:pseudorange
   (&optional __pseudorange)
   (if __pseudorange (setq _pseudorange __pseudorange)) _pseudorange)
  (:doppler
   (&optional __doppler)
   (if __doppler (setq _doppler __doppler)) _doppler)
  (:sigId
   (&optional __sigId)
   (if __sigId (setq _sigId __sigId)) _sigId)
  (:svId
   (&optional __svId)
   (if __svId (setq _svId __svId)) _svId)
  (:carrierCycles
   (&optional __carrierCycles)
   (if __carrierCycles (setq _carrierCycles __carrierCycles)) _carrierCycles)
  (:dopplerStdev
   (&optional __dopplerStdev)
   (if __dopplerStdev (setq _dopplerStdev __dopplerStdev)) _dopplerStdev)
  (:pseudorangeStdev
   (&optional __pseudorangeStdev)
   (if __pseudorangeStdev (setq _pseudorangeStdev __pseudorangeStdev)) _pseudorangeStdev)
  (:cno
   (&optional __cno)
   (if __cno (setq _cno __cno)) _cno)
  (:locktime
   (&optional __locktime)
   (if __locktime (setq _locktime __locktime)) _locktime)
  (:glonassFrequencyIndex
   (&optional __glonassFrequencyIndex)
   (if __glonassFrequencyIndex (setq _glonassFrequencyIndex __glonassFrequencyIndex)) _glonassFrequencyIndex)
  (:trackingStatus
   (&rest __trackingStatus)
   (if (keywordp (car __trackingStatus))
       (send* _trackingStatus __trackingStatus)
     (progn
       (if __trackingStatus (setq _trackingStatus (car __trackingStatus)))
       _trackingStatus)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _gnssId
    8
    ;; float32 _carrierPhaseStdev
    4
    ;; float32 _pseudorange
    4
    ;; float32 _doppler
    4
    ;; int64 _sigId
    8
    ;; int64 _svId
    8
    ;; float32 _carrierCycles
    4
    ;; float32 _dopplerStdev
    4
    ;; float32 _pseudorangeStdev
    4
    ;; int64 _cno
    8
    ;; int64 _locktime
    8
    ;; int64 _glonassFrequencyIndex
    8
    ;; openpilot_bridge/TrackingStatus _trackingStatus
    (send _trackingStatus :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _gnssId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gnssId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gnssId) (= (length (_gnssId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gnssId . bv) 0) 0) s)
              (write-long (ash (elt (_gnssId . bv) 1) -1) s))
             ((and (class _gnssId) (= (length (_gnssId . bv)) 1)) ;; big1
              (write-long (elt (_gnssId . bv) 0) s)
              (write-long (if (>= _gnssId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gnssId s)(write-long (if (>= _gnssId 0) 0 #xffffffff) s)))
     ;; float32 _carrierPhaseStdev
       (sys::poke _carrierPhaseStdev (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pseudorange
       (sys::poke _pseudorange (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _doppler
       (sys::poke _doppler (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _sigId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sigId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sigId) (= (length (_sigId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sigId . bv) 0) 0) s)
              (write-long (ash (elt (_sigId . bv) 1) -1) s))
             ((and (class _sigId) (= (length (_sigId . bv)) 1)) ;; big1
              (write-long (elt (_sigId . bv) 0) s)
              (write-long (if (>= _sigId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sigId s)(write-long (if (>= _sigId 0) 0 #xffffffff) s)))
     ;; int64 _svId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _svId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _svId) (= (length (_svId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_svId . bv) 0) 0) s)
              (write-long (ash (elt (_svId . bv) 1) -1) s))
             ((and (class _svId) (= (length (_svId . bv)) 1)) ;; big1
              (write-long (elt (_svId . bv) 0) s)
              (write-long (if (>= _svId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _svId s)(write-long (if (>= _svId 0) 0 #xffffffff) s)))
     ;; float32 _carrierCycles
       (sys::poke _carrierCycles (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dopplerStdev
       (sys::poke _dopplerStdev (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pseudorangeStdev
       (sys::poke _pseudorangeStdev (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _cno
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cno (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cno) (= (length (_cno . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cno . bv) 0) 0) s)
              (write-long (ash (elt (_cno . bv) 1) -1) s))
             ((and (class _cno) (= (length (_cno . bv)) 1)) ;; big1
              (write-long (elt (_cno . bv) 0) s)
              (write-long (if (>= _cno 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cno s)(write-long (if (>= _cno 0) 0 #xffffffff) s)))
     ;; int64 _locktime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _locktime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _locktime) (= (length (_locktime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_locktime . bv) 0) 0) s)
              (write-long (ash (elt (_locktime . bv) 1) -1) s))
             ((and (class _locktime) (= (length (_locktime . bv)) 1)) ;; big1
              (write-long (elt (_locktime . bv) 0) s)
              (write-long (if (>= _locktime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _locktime s)(write-long (if (>= _locktime 0) 0 #xffffffff) s)))
     ;; int64 _glonassFrequencyIndex
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _glonassFrequencyIndex (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _glonassFrequencyIndex) (= (length (_glonassFrequencyIndex . bv)) 2)) ;; bignum
              (write-long (ash (elt (_glonassFrequencyIndex . bv) 0) 0) s)
              (write-long (ash (elt (_glonassFrequencyIndex . bv) 1) -1) s))
             ((and (class _glonassFrequencyIndex) (= (length (_glonassFrequencyIndex . bv)) 1)) ;; big1
              (write-long (elt (_glonassFrequencyIndex . bv) 0) s)
              (write-long (if (>= _glonassFrequencyIndex 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _glonassFrequencyIndex s)(write-long (if (>= _glonassFrequencyIndex 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/TrackingStatus _trackingStatus
       (send _trackingStatus :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _gnssId
#+(or :alpha :irix6 :x86_64)
      (setf _gnssId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gnssId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _carrierPhaseStdev
     (setq _carrierPhaseStdev (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pseudorange
     (setq _pseudorange (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _doppler
     (setq _doppler (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _sigId
#+(or :alpha :irix6 :x86_64)
      (setf _sigId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sigId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _svId
#+(or :alpha :irix6 :x86_64)
      (setf _svId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _svId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _carrierCycles
     (setq _carrierCycles (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dopplerStdev
     (setq _dopplerStdev (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pseudorangeStdev
     (setq _pseudorangeStdev (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _cno
#+(or :alpha :irix6 :x86_64)
      (setf _cno (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cno (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _locktime
#+(or :alpha :irix6 :x86_64)
      (setf _locktime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _locktime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _glonassFrequencyIndex
#+(or :alpha :irix6 :x86_64)
      (setf _glonassFrequencyIndex (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _glonassFrequencyIndex (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/TrackingStatus _trackingStatus
     (send _trackingStatus :deserialize buf ptr-) (incf ptr- (send _trackingStatus :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::Measurement :md5sum-) "c6c589e6cee294e9ee81e6cc927ed065")
(setf (get openpilot_bridge::Measurement :datatype-) "openpilot_bridge/Measurement")
(setf (get openpilot_bridge::Measurement :definition-)
      "Header header

int64 gnssId
float32 carrierPhaseStdev
float32 pseudorange
float32 doppler
int64 sigId
int64 svId
float32 carrierCycles
float32 dopplerStdev
float32 pseudorangeStdev
int64 cno
int64 locktime
int64 glonassFrequencyIndex
TrackingStatus trackingStatus

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
MSG: openpilot_bridge/TrackingStatus
Header header

bool halfCycleSubtracted
bool carrierPhaseValid
bool pseudorangeValid
bool halfCycleValid

")



(provide :openpilot_bridge/Measurement "c6c589e6cee294e9ee81e6cc927ed065")


