;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::RadarState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'RadarState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::RADARSTATE")
  (make-package "OPENPILOT_BRIDGE::RADARSTATE"))

(in-package "ROS")
;;//! \htmlinclude RadarState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::RadarState
  :super ros::object
  :slots (_header _warpMatrixDEPRECATED _calCycleDEPRECATED _calStatusDEPRECATED _mdMonoTime _leadTwo _calPercDEPRECATED _radarErrors _cumLagMs _canMonoTimes _angleOffsetDEPRECATED _ftMonoTimeDEPRECATED _leadOne _controlsStateMonoTime _radarPoints _liveTracks ))

(defmethod openpilot_bridge::RadarState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:warpMatrixDEPRECATED __warpMatrixDEPRECATED) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:calCycleDEPRECATED __calCycleDEPRECATED) 0)
    ((:calStatusDEPRECATED __calStatusDEPRECATED) 0)
    ((:mdMonoTime __mdMonoTime) 0)
    ((:leadTwo __leadTwo) (instance openpilot_bridge::LeadData :init))
    ((:calPercDEPRECATED __calPercDEPRECATED) 0)
    ((:radarErrors __radarErrors) (make-array 0 :initial-element 0 :element-type :integer))
    ((:cumLagMs __cumLagMs) 0.0)
    ((:canMonoTimes __canMonoTimes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:angleOffsetDEPRECATED __angleOffsetDEPRECATED) 0.0)
    ((:ftMonoTimeDEPRECATED __ftMonoTimeDEPRECATED) 0)
    ((:leadOne __leadOne) (instance openpilot_bridge::LeadData :init))
    ((:controlsStateMonoTime __controlsStateMonoTime) 0)
    ((:radarPoints __radarPoints) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::RadarPoint :init) r)) r))
    ((:liveTracks __liveTracks) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::LiveTracks :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _warpMatrixDEPRECATED __warpMatrixDEPRECATED)
   (setq _calCycleDEPRECATED (round __calCycleDEPRECATED))
   (setq _calStatusDEPRECATED (round __calStatusDEPRECATED))
   (setq _mdMonoTime (round __mdMonoTime))
   (setq _leadTwo __leadTwo)
   (setq _calPercDEPRECATED (round __calPercDEPRECATED))
   (setq _radarErrors __radarErrors)
   (setq _cumLagMs (float __cumLagMs))
   (setq _canMonoTimes __canMonoTimes)
   (setq _angleOffsetDEPRECATED (float __angleOffsetDEPRECATED))
   (setq _ftMonoTimeDEPRECATED (round __ftMonoTimeDEPRECATED))
   (setq _leadOne __leadOne)
   (setq _controlsStateMonoTime (round __controlsStateMonoTime))
   (setq _radarPoints __radarPoints)
   (setq _liveTracks __liveTracks)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:warpMatrixDEPRECATED
   (&optional __warpMatrixDEPRECATED)
   (if __warpMatrixDEPRECATED (setq _warpMatrixDEPRECATED __warpMatrixDEPRECATED)) _warpMatrixDEPRECATED)
  (:calCycleDEPRECATED
   (&optional __calCycleDEPRECATED)
   (if __calCycleDEPRECATED (setq _calCycleDEPRECATED __calCycleDEPRECATED)) _calCycleDEPRECATED)
  (:calStatusDEPRECATED
   (&optional __calStatusDEPRECATED)
   (if __calStatusDEPRECATED (setq _calStatusDEPRECATED __calStatusDEPRECATED)) _calStatusDEPRECATED)
  (:mdMonoTime
   (&optional __mdMonoTime)
   (if __mdMonoTime (setq _mdMonoTime __mdMonoTime)) _mdMonoTime)
  (:leadTwo
   (&rest __leadTwo)
   (if (keywordp (car __leadTwo))
       (send* _leadTwo __leadTwo)
     (progn
       (if __leadTwo (setq _leadTwo (car __leadTwo)))
       _leadTwo)))
  (:calPercDEPRECATED
   (&optional __calPercDEPRECATED)
   (if __calPercDEPRECATED (setq _calPercDEPRECATED __calPercDEPRECATED)) _calPercDEPRECATED)
  (:radarErrors
   (&optional __radarErrors)
   (if __radarErrors (setq _radarErrors __radarErrors)) _radarErrors)
  (:cumLagMs
   (&optional __cumLagMs)
   (if __cumLagMs (setq _cumLagMs __cumLagMs)) _cumLagMs)
  (:canMonoTimes
   (&optional __canMonoTimes)
   (if __canMonoTimes (setq _canMonoTimes __canMonoTimes)) _canMonoTimes)
  (:angleOffsetDEPRECATED
   (&optional __angleOffsetDEPRECATED)
   (if __angleOffsetDEPRECATED (setq _angleOffsetDEPRECATED __angleOffsetDEPRECATED)) _angleOffsetDEPRECATED)
  (:ftMonoTimeDEPRECATED
   (&optional __ftMonoTimeDEPRECATED)
   (if __ftMonoTimeDEPRECATED (setq _ftMonoTimeDEPRECATED __ftMonoTimeDEPRECATED)) _ftMonoTimeDEPRECATED)
  (:leadOne
   (&rest __leadOne)
   (if (keywordp (car __leadOne))
       (send* _leadOne __leadOne)
     (progn
       (if __leadOne (setq _leadOne (car __leadOne)))
       _leadOne)))
  (:controlsStateMonoTime
   (&optional __controlsStateMonoTime)
   (if __controlsStateMonoTime (setq _controlsStateMonoTime __controlsStateMonoTime)) _controlsStateMonoTime)
  (:radarPoints
   (&rest __radarPoints)
   (if (keywordp (car __radarPoints))
       (send* _radarPoints __radarPoints)
     (progn
       (if __radarPoints (setq _radarPoints (car __radarPoints)))
       _radarPoints)))
  (:liveTracks
   (&rest __liveTracks)
   (if (keywordp (car __liveTracks))
       (send* _liveTracks __liveTracks)
     (progn
       (if __liveTracks (setq _liveTracks (car __liveTracks)))
       _liveTracks)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _warpMatrixDEPRECATED
    (* 4    (length _warpMatrixDEPRECATED)) 4
    ;; int32 _calCycleDEPRECATED
    4
    ;; int32 _calStatusDEPRECATED
    4
    ;; int64 _mdMonoTime
    8
    ;; openpilot_bridge/LeadData _leadTwo
    (send _leadTwo :serialization-length)
    ;; int32 _calPercDEPRECATED
    4
    ;; uint32[] _radarErrors
    (* 4    (length _radarErrors)) 4
    ;; float32 _cumLagMs
    4
    ;; int64[] _canMonoTimes
    (* 8    (length _canMonoTimes)) 4
    ;; float32 _angleOffsetDEPRECATED
    4
    ;; int64 _ftMonoTimeDEPRECATED
    8
    ;; openpilot_bridge/LeadData _leadOne
    (send _leadOne :serialization-length)
    ;; int64 _controlsStateMonoTime
    8
    ;; openpilot_bridge/RadarPoint[] _radarPoints
    (apply #'+ (send-all _radarPoints :serialization-length)) 4
    ;; openpilot_bridge/LiveTracks[] _liveTracks
    (apply #'+ (send-all _liveTracks :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _warpMatrixDEPRECATED
     (write-long (length _warpMatrixDEPRECATED) s)
     (dotimes (i (length _warpMatrixDEPRECATED))
       (sys::poke (elt _warpMatrixDEPRECATED i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _calCycleDEPRECATED
       (write-long _calCycleDEPRECATED s)
     ;; int32 _calStatusDEPRECATED
       (write-long _calStatusDEPRECATED s)
     ;; int64 _mdMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mdMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mdMonoTime) (= (length (_mdMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mdMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_mdMonoTime . bv) 1) -1) s))
             ((and (class _mdMonoTime) (= (length (_mdMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_mdMonoTime . bv) 0) s)
              (write-long (if (>= _mdMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mdMonoTime s)(write-long (if (>= _mdMonoTime 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/LeadData _leadTwo
       (send _leadTwo :serialize s)
     ;; int32 _calPercDEPRECATED
       (write-long _calPercDEPRECATED s)
     ;; uint32[] _radarErrors
     (write-long (length _radarErrors) s)
     (dotimes (i (length _radarErrors))
       (write-long (elt _radarErrors i) s)
       )
     ;; float32 _cumLagMs
       (sys::poke _cumLagMs (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64[] _canMonoTimes
     (write-long (length _canMonoTimes) s)
     (dotimes (i (length _canMonoTimes))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _canMonoTimes i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _canMonoTimes i)) (= (length ((elt _canMonoTimes i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _canMonoTimes i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _canMonoTimes i) . bv) 1) -1) s))
             ((and (class (elt _canMonoTimes i)) (= (length ((elt _canMonoTimes i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _canMonoTimes i) . bv) 0) s)
              (write-long (if (>= (elt _canMonoTimes i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _canMonoTimes i) s)(write-long (if (>= (elt _canMonoTimes i) 0) 0 #xffffffff) s)))
       )
     ;; float32 _angleOffsetDEPRECATED
       (sys::poke _angleOffsetDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _ftMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ftMonoTimeDEPRECATED (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ftMonoTimeDEPRECATED) (= (length (_ftMonoTimeDEPRECATED . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ftMonoTimeDEPRECATED . bv) 0) 0) s)
              (write-long (ash (elt (_ftMonoTimeDEPRECATED . bv) 1) -1) s))
             ((and (class _ftMonoTimeDEPRECATED) (= (length (_ftMonoTimeDEPRECATED . bv)) 1)) ;; big1
              (write-long (elt (_ftMonoTimeDEPRECATED . bv) 0) s)
              (write-long (if (>= _ftMonoTimeDEPRECATED 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ftMonoTimeDEPRECATED s)(write-long (if (>= _ftMonoTimeDEPRECATED 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/LeadData _leadOne
       (send _leadOne :serialize s)
     ;; int64 _controlsStateMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _controlsStateMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _controlsStateMonoTime) (= (length (_controlsStateMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_controlsStateMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_controlsStateMonoTime . bv) 1) -1) s))
             ((and (class _controlsStateMonoTime) (= (length (_controlsStateMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_controlsStateMonoTime . bv) 0) s)
              (write-long (if (>= _controlsStateMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _controlsStateMonoTime s)(write-long (if (>= _controlsStateMonoTime 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/RadarPoint[] _radarPoints
     (write-long (length _radarPoints) s)
     (dolist (elem _radarPoints)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/LiveTracks[] _liveTracks
     (write-long (length _liveTracks) s)
     (dolist (elem _liveTracks)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _warpMatrixDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _warpMatrixDEPRECATED (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _warpMatrixDEPRECATED i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _calCycleDEPRECATED
     (setq _calCycleDEPRECATED (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _calStatusDEPRECATED
     (setq _calStatusDEPRECATED (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _mdMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _mdMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mdMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/LeadData _leadTwo
     (send _leadTwo :deserialize buf ptr-) (incf ptr- (send _leadTwo :serialization-length))
   ;; int32 _calPercDEPRECATED
     (setq _calPercDEPRECATED (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32[] _radarErrors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _radarErrors (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _radarErrors i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float32 _cumLagMs
     (setq _cumLagMs (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64[] _canMonoTimes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _canMonoTimes (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _canMonoTimes i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _canMonoTimes i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; float32 _angleOffsetDEPRECATED
     (setq _angleOffsetDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _ftMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
      (setf _ftMonoTimeDEPRECATED (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ftMonoTimeDEPRECATED (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/LeadData _leadOne
     (send _leadOne :deserialize buf ptr-) (incf ptr- (send _leadOne :serialization-length))
   ;; int64 _controlsStateMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _controlsStateMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _controlsStateMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/RadarPoint[] _radarPoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _radarPoints (let (r) (dotimes (i n) (push (instance openpilot_bridge::RadarPoint :init) r)) r))
     (dolist (elem- _radarPoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/LiveTracks[] _liveTracks
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _liveTracks (let (r) (dotimes (i n) (push (instance openpilot_bridge::LiveTracks :init) r)) r))
     (dolist (elem- _liveTracks)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::RadarState :md5sum-) "6ae0f29b5053e8a1901524794cbb99a2")
(setf (get openpilot_bridge::RadarState :datatype-) "openpilot_bridge/RadarState")
(setf (get openpilot_bridge::RadarState :definition-)
      "Header header

float32[] warpMatrixDEPRECATED
int32 calCycleDEPRECATED
int32 calStatusDEPRECATED
int64 mdMonoTime
LeadData leadTwo
int32 calPercDEPRECATED
uint32[] radarErrors # enum const: Error
float32 cumLagMs
int64[] canMonoTimes
float32 angleOffsetDEPRECATED
int64 ftMonoTimeDEPRECATED
LeadData leadOne
int64 controlsStateMonoTime
RadarPoint[] radarPoints
LiveTracks[] liveTracks

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
MSG: openpilot_bridge/LeadData
Header header

float32 dRel
float32 yRel
float32 vRel
float32 aRel
float32 vLead
float32 aLeadDEPRECATED
float32 dPath
float32 vLat
float32 vLeadK
float32 aLeadK
bool fcw
bool status
float32 aLeadTau
float32 modelProb
bool radar

================================================================================
MSG: openpilot_bridge/RadarPoint
Header header

float32 yRel
int64 trackId
float32 aRel
float32 vRel
float32 dRel
float32 yvRel
bool measured

================================================================================
MSG: openpilot_bridge/LiveTracks
Header header

float32 status
float32 yRel
float32 currentTime
int32 trackId
float32 aRel
float32 vRel
float32 dRel
float32 timeStamp
bool stationary
bool oncoming

")



(provide :openpilot_bridge/RadarState "6ae0f29b5053e8a1901524794cbb99a2")


