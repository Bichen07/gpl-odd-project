;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::MeasurementReport)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'MeasurementReport (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEASUREMENTREPORT")
  (make-package "OPENPILOT_BRIDGE::MEASUREMENTREPORT"))

(in-package "ROS")
;;//! \htmlinclude MeasurementReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::MeasurementReport
  :super ros::object
  :slots (_header _measurements _gpsWeek _numMeas _receiverStatus _leapSeconds _rcvTow ))

(defmethod openpilot_bridge::MeasurementReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:measurements __measurements) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::Measurement :init) r)) r))
    ((:gpsWeek __gpsWeek) 0)
    ((:numMeas __numMeas) 0)
    ((:receiverStatus __receiverStatus) (instance openpilot_bridge::ReceiverStatus :init))
    ((:leapSeconds __leapSeconds) 0)
    ((:rcvTow __rcvTow) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _measurements __measurements)
   (setq _gpsWeek (round __gpsWeek))
   (setq _numMeas (round __numMeas))
   (setq _receiverStatus __receiverStatus)
   (setq _leapSeconds (round __leapSeconds))
   (setq _rcvTow (float __rcvTow))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:measurements
   (&rest __measurements)
   (if (keywordp (car __measurements))
       (send* _measurements __measurements)
     (progn
       (if __measurements (setq _measurements (car __measurements)))
       _measurements)))
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:numMeas
   (&optional __numMeas)
   (if __numMeas (setq _numMeas __numMeas)) _numMeas)
  (:receiverStatus
   (&rest __receiverStatus)
   (if (keywordp (car __receiverStatus))
       (send* _receiverStatus __receiverStatus)
     (progn
       (if __receiverStatus (setq _receiverStatus (car __receiverStatus)))
       _receiverStatus)))
  (:leapSeconds
   (&optional __leapSeconds)
   (if __leapSeconds (setq _leapSeconds __leapSeconds)) _leapSeconds)
  (:rcvTow
   (&optional __rcvTow)
   (if __rcvTow (setq _rcvTow __rcvTow)) _rcvTow)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/Measurement[] _measurements
    (apply #'+ (send-all _measurements :serialization-length)) 4
    ;; int64 _gpsWeek
    8
    ;; int64 _numMeas
    8
    ;; openpilot_bridge/ReceiverStatus _receiverStatus
    (send _receiverStatus :serialization-length)
    ;; int64 _leapSeconds
    8
    ;; float32 _rcvTow
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/Measurement[] _measurements
     (write-long (length _measurements) s)
     (dolist (elem _measurements)
       (send elem :serialize s)
       )
     ;; int64 _gpsWeek
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsWeek (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsWeek) (= (length (_gpsWeek . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsWeek . bv) 0) 0) s)
              (write-long (ash (elt (_gpsWeek . bv) 1) -1) s))
             ((and (class _gpsWeek) (= (length (_gpsWeek . bv)) 1)) ;; big1
              (write-long (elt (_gpsWeek . bv) 0) s)
              (write-long (if (>= _gpsWeek 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsWeek s)(write-long (if (>= _gpsWeek 0) 0 #xffffffff) s)))
     ;; int64 _numMeas
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _numMeas (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _numMeas) (= (length (_numMeas . bv)) 2)) ;; bignum
              (write-long (ash (elt (_numMeas . bv) 0) 0) s)
              (write-long (ash (elt (_numMeas . bv) 1) -1) s))
             ((and (class _numMeas) (= (length (_numMeas . bv)) 1)) ;; big1
              (write-long (elt (_numMeas . bv) 0) s)
              (write-long (if (>= _numMeas 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _numMeas s)(write-long (if (>= _numMeas 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/ReceiverStatus _receiverStatus
       (send _receiverStatus :serialize s)
     ;; int64 _leapSeconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _leapSeconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _leapSeconds) (= (length (_leapSeconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_leapSeconds . bv) 0) 0) s)
              (write-long (ash (elt (_leapSeconds . bv) 1) -1) s))
             ((and (class _leapSeconds) (= (length (_leapSeconds . bv)) 1)) ;; big1
              (write-long (elt (_leapSeconds . bv) 0) s)
              (write-long (if (>= _leapSeconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _leapSeconds s)(write-long (if (>= _leapSeconds 0) 0 #xffffffff) s)))
     ;; float32 _rcvTow
       (sys::poke _rcvTow (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/Measurement[] _measurements
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _measurements (let (r) (dotimes (i n) (push (instance openpilot_bridge::Measurement :init) r)) r))
     (dolist (elem- _measurements)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int64 _gpsWeek
#+(or :alpha :irix6 :x86_64)
      (setf _gpsWeek (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsWeek (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _numMeas
#+(or :alpha :irix6 :x86_64)
      (setf _numMeas (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _numMeas (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/ReceiverStatus _receiverStatus
     (send _receiverStatus :deserialize buf ptr-) (incf ptr- (send _receiverStatus :serialization-length))
   ;; int64 _leapSeconds
#+(or :alpha :irix6 :x86_64)
      (setf _leapSeconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _leapSeconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _rcvTow
     (setq _rcvTow (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::MeasurementReport :md5sum-) "72031e9f3d08f0e106b815c0c5630a15")
(setf (get openpilot_bridge::MeasurementReport :datatype-) "openpilot_bridge/MeasurementReport")
(setf (get openpilot_bridge::MeasurementReport :definition-)
      "Header header

Measurement[] measurements
int64 gpsWeek
int64 numMeas
ReceiverStatus receiverStatus
int64 leapSeconds
float32 rcvTow

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
MSG: openpilot_bridge/Measurement
Header header

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
MSG: openpilot_bridge/TrackingStatus
Header header

bool halfCycleSubtracted
bool carrierPhaseValid
bool pseudorangeValid
bool halfCycleValid

================================================================================
MSG: openpilot_bridge/ReceiverStatus
Header header

bool leapSecValid
bool clkReset

")



(provide :openpilot_bridge/MeasurementReport "72031e9f3d08f0e106b815c0c5630a15")


