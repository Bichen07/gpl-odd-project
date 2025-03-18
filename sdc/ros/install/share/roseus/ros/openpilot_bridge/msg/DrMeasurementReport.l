;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::DrMeasurementReport)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'DrMeasurementReport (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::DRMEASUREMENTREPORT")
  (make-package "OPENPILOT_BRIDGE::DRMEASUREMENTREPORT"))

(in-package "ROS")
;;//! \htmlinclude DrMeasurementReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::DrMeasurementReport
  :super ros::object
  :slots (_header _gpsToGlonassTimeBiasMilliseconds _gpsMilliseconds _seqMax _gpsClockTimeUncertaintyMs _glonassClockSource _glonassTimeBias _gpsClockSource _clockFrequencyBias _source _rfLoss _fCount _gpsTimeBiasMs _clockFrequencyUncertainty _systemRtcTime _seqNum _frequencySource _glonassDay _reason _glonassMilliseconds _clockResets _sv _gpsLeapSeconds _glonassClockTimeUncertainty _gpsWeek _systemRtcValid _gpsToGlonassTimeBiasMillisecondsUncertainty _glonassYear _gpsLeapSecondsUncertainty ))

(defmethod openpilot_bridge::DrMeasurementReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gpsToGlonassTimeBiasMilliseconds __gpsToGlonassTimeBiasMilliseconds) 0.0)
    ((:gpsMilliseconds __gpsMilliseconds) 0)
    ((:seqMax __seqMax) 0)
    ((:gpsClockTimeUncertaintyMs __gpsClockTimeUncertaintyMs) 0)
    ((:glonassClockSource __glonassClockSource) 0)
    ((:glonassTimeBias __glonassTimeBias) 0.0)
    ((:gpsClockSource __gpsClockSource) 0)
    ((:clockFrequencyBias __clockFrequencyBias) 0.0)
    ((:source __source) 0)
    ((:rfLoss __rfLoss) 0)
    ((:fCount __fCount) 0)
    ((:gpsTimeBiasMs __gpsTimeBiasMs) 0)
    ((:clockFrequencyUncertainty __clockFrequencyUncertainty) 0.0)
    ((:systemRtcTime __systemRtcTime) 0)
    ((:seqNum __seqNum) 0)
    ((:frequencySource __frequencySource) 0)
    ((:glonassDay __glonassDay) 0)
    ((:reason __reason) 0)
    ((:glonassMilliseconds __glonassMilliseconds) 0)
    ((:clockResets __clockResets) 0)
    ((:sv __sv) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::SV :init) r)) r))
    ((:gpsLeapSeconds __gpsLeapSeconds) 0)
    ((:glonassClockTimeUncertainty __glonassClockTimeUncertainty) 0.0)
    ((:gpsWeek __gpsWeek) 0)
    ((:systemRtcValid __systemRtcValid) nil)
    ((:gpsToGlonassTimeBiasMillisecondsUncertainty __gpsToGlonassTimeBiasMillisecondsUncertainty) 0.0)
    ((:glonassYear __glonassYear) 0)
    ((:gpsLeapSecondsUncertainty __gpsLeapSecondsUncertainty) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _gpsToGlonassTimeBiasMilliseconds (float __gpsToGlonassTimeBiasMilliseconds))
   (setq _gpsMilliseconds (round __gpsMilliseconds))
   (setq _seqMax (round __seqMax))
   (setq _gpsClockTimeUncertaintyMs (round __gpsClockTimeUncertaintyMs))
   (setq _glonassClockSource (round __glonassClockSource))
   (setq _glonassTimeBias (float __glonassTimeBias))
   (setq _gpsClockSource (round __gpsClockSource))
   (setq _clockFrequencyBias (float __clockFrequencyBias))
   (setq _source (round __source))
   (setq _rfLoss (round __rfLoss))
   (setq _fCount (round __fCount))
   (setq _gpsTimeBiasMs (round __gpsTimeBiasMs))
   (setq _clockFrequencyUncertainty (float __clockFrequencyUncertainty))
   (setq _systemRtcTime (round __systemRtcTime))
   (setq _seqNum (round __seqNum))
   (setq _frequencySource (round __frequencySource))
   (setq _glonassDay (round __glonassDay))
   (setq _reason (round __reason))
   (setq _glonassMilliseconds (round __glonassMilliseconds))
   (setq _clockResets (round __clockResets))
   (setq _sv __sv)
   (setq _gpsLeapSeconds (round __gpsLeapSeconds))
   (setq _glonassClockTimeUncertainty (float __glonassClockTimeUncertainty))
   (setq _gpsWeek (round __gpsWeek))
   (setq _systemRtcValid __systemRtcValid)
   (setq _gpsToGlonassTimeBiasMillisecondsUncertainty (float __gpsToGlonassTimeBiasMillisecondsUncertainty))
   (setq _glonassYear (round __glonassYear))
   (setq _gpsLeapSecondsUncertainty (round __gpsLeapSecondsUncertainty))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gpsToGlonassTimeBiasMilliseconds
   (&optional __gpsToGlonassTimeBiasMilliseconds)
   (if __gpsToGlonassTimeBiasMilliseconds (setq _gpsToGlonassTimeBiasMilliseconds __gpsToGlonassTimeBiasMilliseconds)) _gpsToGlonassTimeBiasMilliseconds)
  (:gpsMilliseconds
   (&optional __gpsMilliseconds)
   (if __gpsMilliseconds (setq _gpsMilliseconds __gpsMilliseconds)) _gpsMilliseconds)
  (:seqMax
   (&optional __seqMax)
   (if __seqMax (setq _seqMax __seqMax)) _seqMax)
  (:gpsClockTimeUncertaintyMs
   (&optional __gpsClockTimeUncertaintyMs)
   (if __gpsClockTimeUncertaintyMs (setq _gpsClockTimeUncertaintyMs __gpsClockTimeUncertaintyMs)) _gpsClockTimeUncertaintyMs)
  (:glonassClockSource
   (&optional __glonassClockSource)
   (if __glonassClockSource (setq _glonassClockSource __glonassClockSource)) _glonassClockSource)
  (:glonassTimeBias
   (&optional __glonassTimeBias)
   (if __glonassTimeBias (setq _glonassTimeBias __glonassTimeBias)) _glonassTimeBias)
  (:gpsClockSource
   (&optional __gpsClockSource)
   (if __gpsClockSource (setq _gpsClockSource __gpsClockSource)) _gpsClockSource)
  (:clockFrequencyBias
   (&optional __clockFrequencyBias)
   (if __clockFrequencyBias (setq _clockFrequencyBias __clockFrequencyBias)) _clockFrequencyBias)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:rfLoss
   (&optional __rfLoss)
   (if __rfLoss (setq _rfLoss __rfLoss)) _rfLoss)
  (:fCount
   (&optional __fCount)
   (if __fCount (setq _fCount __fCount)) _fCount)
  (:gpsTimeBiasMs
   (&optional __gpsTimeBiasMs)
   (if __gpsTimeBiasMs (setq _gpsTimeBiasMs __gpsTimeBiasMs)) _gpsTimeBiasMs)
  (:clockFrequencyUncertainty
   (&optional __clockFrequencyUncertainty)
   (if __clockFrequencyUncertainty (setq _clockFrequencyUncertainty __clockFrequencyUncertainty)) _clockFrequencyUncertainty)
  (:systemRtcTime
   (&optional __systemRtcTime)
   (if __systemRtcTime (setq _systemRtcTime __systemRtcTime)) _systemRtcTime)
  (:seqNum
   (&optional __seqNum)
   (if __seqNum (setq _seqNum __seqNum)) _seqNum)
  (:frequencySource
   (&optional __frequencySource)
   (if __frequencySource (setq _frequencySource __frequencySource)) _frequencySource)
  (:glonassDay
   (&optional __glonassDay)
   (if __glonassDay (setq _glonassDay __glonassDay)) _glonassDay)
  (:reason
   (&optional __reason)
   (if __reason (setq _reason __reason)) _reason)
  (:glonassMilliseconds
   (&optional __glonassMilliseconds)
   (if __glonassMilliseconds (setq _glonassMilliseconds __glonassMilliseconds)) _glonassMilliseconds)
  (:clockResets
   (&optional __clockResets)
   (if __clockResets (setq _clockResets __clockResets)) _clockResets)
  (:sv
   (&rest __sv)
   (if (keywordp (car __sv))
       (send* _sv __sv)
     (progn
       (if __sv (setq _sv (car __sv)))
       _sv)))
  (:gpsLeapSeconds
   (&optional __gpsLeapSeconds)
   (if __gpsLeapSeconds (setq _gpsLeapSeconds __gpsLeapSeconds)) _gpsLeapSeconds)
  (:glonassClockTimeUncertainty
   (&optional __glonassClockTimeUncertainty)
   (if __glonassClockTimeUncertainty (setq _glonassClockTimeUncertainty __glonassClockTimeUncertainty)) _glonassClockTimeUncertainty)
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:systemRtcValid
   (&optional __systemRtcValid)
   (if __systemRtcValid (setq _systemRtcValid __systemRtcValid)) _systemRtcValid)
  (:gpsToGlonassTimeBiasMillisecondsUncertainty
   (&optional __gpsToGlonassTimeBiasMillisecondsUncertainty)
   (if __gpsToGlonassTimeBiasMillisecondsUncertainty (setq _gpsToGlonassTimeBiasMillisecondsUncertainty __gpsToGlonassTimeBiasMillisecondsUncertainty)) _gpsToGlonassTimeBiasMillisecondsUncertainty)
  (:glonassYear
   (&optional __glonassYear)
   (if __glonassYear (setq _glonassYear __glonassYear)) _glonassYear)
  (:gpsLeapSecondsUncertainty
   (&optional __gpsLeapSecondsUncertainty)
   (if __gpsLeapSecondsUncertainty (setq _gpsLeapSecondsUncertainty __gpsLeapSecondsUncertainty)) _gpsLeapSecondsUncertainty)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _gpsToGlonassTimeBiasMilliseconds
    4
    ;; int64 _gpsMilliseconds
    8
    ;; int64 _seqMax
    8
    ;; int64 _gpsClockTimeUncertaintyMs
    8
    ;; int64 _glonassClockSource
    8
    ;; float32 _glonassTimeBias
    4
    ;; int64 _gpsClockSource
    8
    ;; float32 _clockFrequencyBias
    4
    ;; uint32 _source
    4
    ;; int64 _rfLoss
    8
    ;; int64 _fCount
    8
    ;; int64 _gpsTimeBiasMs
    8
    ;; float32 _clockFrequencyUncertainty
    4
    ;; int64 _systemRtcTime
    8
    ;; int64 _seqNum
    8
    ;; int64 _frequencySource
    8
    ;; int64 _glonassDay
    8
    ;; int64 _reason
    8
    ;; int64 _glonassMilliseconds
    8
    ;; int64 _clockResets
    8
    ;; openpilot_bridge/SV[] _sv
    (apply #'+ (send-all _sv :serialization-length)) 4
    ;; int64 _gpsLeapSeconds
    8
    ;; float32 _glonassClockTimeUncertainty
    4
    ;; int64 _gpsWeek
    8
    ;; bool _systemRtcValid
    1
    ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
    4
    ;; int64 _glonassYear
    8
    ;; int64 _gpsLeapSecondsUncertainty
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _gpsToGlonassTimeBiasMilliseconds
       (sys::poke _gpsToGlonassTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _gpsMilliseconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsMilliseconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsMilliseconds) (= (length (_gpsMilliseconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsMilliseconds . bv) 0) 0) s)
              (write-long (ash (elt (_gpsMilliseconds . bv) 1) -1) s))
             ((and (class _gpsMilliseconds) (= (length (_gpsMilliseconds . bv)) 1)) ;; big1
              (write-long (elt (_gpsMilliseconds . bv) 0) s)
              (write-long (if (>= _gpsMilliseconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsMilliseconds s)(write-long (if (>= _gpsMilliseconds 0) 0 #xffffffff) s)))
     ;; int64 _seqMax
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _seqMax (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _seqMax) (= (length (_seqMax . bv)) 2)) ;; bignum
              (write-long (ash (elt (_seqMax . bv) 0) 0) s)
              (write-long (ash (elt (_seqMax . bv) 1) -1) s))
             ((and (class _seqMax) (= (length (_seqMax . bv)) 1)) ;; big1
              (write-long (elt (_seqMax . bv) 0) s)
              (write-long (if (>= _seqMax 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _seqMax s)(write-long (if (>= _seqMax 0) 0 #xffffffff) s)))
     ;; int64 _gpsClockTimeUncertaintyMs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsClockTimeUncertaintyMs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsClockTimeUncertaintyMs) (= (length (_gpsClockTimeUncertaintyMs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsClockTimeUncertaintyMs . bv) 0) 0) s)
              (write-long (ash (elt (_gpsClockTimeUncertaintyMs . bv) 1) -1) s))
             ((and (class _gpsClockTimeUncertaintyMs) (= (length (_gpsClockTimeUncertaintyMs . bv)) 1)) ;; big1
              (write-long (elt (_gpsClockTimeUncertaintyMs . bv) 0) s)
              (write-long (if (>= _gpsClockTimeUncertaintyMs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsClockTimeUncertaintyMs s)(write-long (if (>= _gpsClockTimeUncertaintyMs 0) 0 #xffffffff) s)))
     ;; int64 _glonassClockSource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _glonassClockSource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _glonassClockSource) (= (length (_glonassClockSource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_glonassClockSource . bv) 0) 0) s)
              (write-long (ash (elt (_glonassClockSource . bv) 1) -1) s))
             ((and (class _glonassClockSource) (= (length (_glonassClockSource . bv)) 1)) ;; big1
              (write-long (elt (_glonassClockSource . bv) 0) s)
              (write-long (if (>= _glonassClockSource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _glonassClockSource s)(write-long (if (>= _glonassClockSource 0) 0 #xffffffff) s)))
     ;; float32 _glonassTimeBias
       (sys::poke _glonassTimeBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _gpsClockSource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsClockSource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsClockSource) (= (length (_gpsClockSource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsClockSource . bv) 0) 0) s)
              (write-long (ash (elt (_gpsClockSource . bv) 1) -1) s))
             ((and (class _gpsClockSource) (= (length (_gpsClockSource . bv)) 1)) ;; big1
              (write-long (elt (_gpsClockSource . bv) 0) s)
              (write-long (if (>= _gpsClockSource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsClockSource s)(write-long (if (>= _gpsClockSource 0) 0 #xffffffff) s)))
     ;; float32 _clockFrequencyBias
       (sys::poke _clockFrequencyBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _source
       (write-long _source s)
     ;; int64 _rfLoss
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _rfLoss (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _rfLoss) (= (length (_rfLoss . bv)) 2)) ;; bignum
              (write-long (ash (elt (_rfLoss . bv) 0) 0) s)
              (write-long (ash (elt (_rfLoss . bv) 1) -1) s))
             ((and (class _rfLoss) (= (length (_rfLoss . bv)) 1)) ;; big1
              (write-long (elt (_rfLoss . bv) 0) s)
              (write-long (if (>= _rfLoss 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _rfLoss s)(write-long (if (>= _rfLoss 0) 0 #xffffffff) s)))
     ;; int64 _fCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fCount) (= (length (_fCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fCount . bv) 0) 0) s)
              (write-long (ash (elt (_fCount . bv) 1) -1) s))
             ((and (class _fCount) (= (length (_fCount . bv)) 1)) ;; big1
              (write-long (elt (_fCount . bv) 0) s)
              (write-long (if (>= _fCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fCount s)(write-long (if (>= _fCount 0) 0 #xffffffff) s)))
     ;; int64 _gpsTimeBiasMs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsTimeBiasMs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsTimeBiasMs) (= (length (_gpsTimeBiasMs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsTimeBiasMs . bv) 0) 0) s)
              (write-long (ash (elt (_gpsTimeBiasMs . bv) 1) -1) s))
             ((and (class _gpsTimeBiasMs) (= (length (_gpsTimeBiasMs . bv)) 1)) ;; big1
              (write-long (elt (_gpsTimeBiasMs . bv) 0) s)
              (write-long (if (>= _gpsTimeBiasMs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsTimeBiasMs s)(write-long (if (>= _gpsTimeBiasMs 0) 0 #xffffffff) s)))
     ;; float32 _clockFrequencyUncertainty
       (sys::poke _clockFrequencyUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _systemRtcTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _systemRtcTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _systemRtcTime) (= (length (_systemRtcTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_systemRtcTime . bv) 0) 0) s)
              (write-long (ash (elt (_systemRtcTime . bv) 1) -1) s))
             ((and (class _systemRtcTime) (= (length (_systemRtcTime . bv)) 1)) ;; big1
              (write-long (elt (_systemRtcTime . bv) 0) s)
              (write-long (if (>= _systemRtcTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _systemRtcTime s)(write-long (if (>= _systemRtcTime 0) 0 #xffffffff) s)))
     ;; int64 _seqNum
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _seqNum (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _seqNum) (= (length (_seqNum . bv)) 2)) ;; bignum
              (write-long (ash (elt (_seqNum . bv) 0) 0) s)
              (write-long (ash (elt (_seqNum . bv) 1) -1) s))
             ((and (class _seqNum) (= (length (_seqNum . bv)) 1)) ;; big1
              (write-long (elt (_seqNum . bv) 0) s)
              (write-long (if (>= _seqNum 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _seqNum s)(write-long (if (>= _seqNum 0) 0 #xffffffff) s)))
     ;; int64 _frequencySource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _frequencySource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _frequencySource) (= (length (_frequencySource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_frequencySource . bv) 0) 0) s)
              (write-long (ash (elt (_frequencySource . bv) 1) -1) s))
             ((and (class _frequencySource) (= (length (_frequencySource . bv)) 1)) ;; big1
              (write-long (elt (_frequencySource . bv) 0) s)
              (write-long (if (>= _frequencySource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _frequencySource s)(write-long (if (>= _frequencySource 0) 0 #xffffffff) s)))
     ;; int64 _glonassDay
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _glonassDay (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _glonassDay) (= (length (_glonassDay . bv)) 2)) ;; bignum
              (write-long (ash (elt (_glonassDay . bv) 0) 0) s)
              (write-long (ash (elt (_glonassDay . bv) 1) -1) s))
             ((and (class _glonassDay) (= (length (_glonassDay . bv)) 1)) ;; big1
              (write-long (elt (_glonassDay . bv) 0) s)
              (write-long (if (>= _glonassDay 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _glonassDay s)(write-long (if (>= _glonassDay 0) 0 #xffffffff) s)))
     ;; int64 _reason
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _reason (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _reason) (= (length (_reason . bv)) 2)) ;; bignum
              (write-long (ash (elt (_reason . bv) 0) 0) s)
              (write-long (ash (elt (_reason . bv) 1) -1) s))
             ((and (class _reason) (= (length (_reason . bv)) 1)) ;; big1
              (write-long (elt (_reason . bv) 0) s)
              (write-long (if (>= _reason 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _reason s)(write-long (if (>= _reason 0) 0 #xffffffff) s)))
     ;; int64 _glonassMilliseconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _glonassMilliseconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _glonassMilliseconds) (= (length (_glonassMilliseconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_glonassMilliseconds . bv) 0) 0) s)
              (write-long (ash (elt (_glonassMilliseconds . bv) 1) -1) s))
             ((and (class _glonassMilliseconds) (= (length (_glonassMilliseconds . bv)) 1)) ;; big1
              (write-long (elt (_glonassMilliseconds . bv) 0) s)
              (write-long (if (>= _glonassMilliseconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _glonassMilliseconds s)(write-long (if (>= _glonassMilliseconds 0) 0 #xffffffff) s)))
     ;; int64 _clockResets
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _clockResets (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _clockResets) (= (length (_clockResets . bv)) 2)) ;; bignum
              (write-long (ash (elt (_clockResets . bv) 0) 0) s)
              (write-long (ash (elt (_clockResets . bv) 1) -1) s))
             ((and (class _clockResets) (= (length (_clockResets . bv)) 1)) ;; big1
              (write-long (elt (_clockResets . bv) 0) s)
              (write-long (if (>= _clockResets 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _clockResets s)(write-long (if (>= _clockResets 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/SV[] _sv
     (write-long (length _sv) s)
     (dolist (elem _sv)
       (send elem :serialize s)
       )
     ;; int64 _gpsLeapSeconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsLeapSeconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsLeapSeconds) (= (length (_gpsLeapSeconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsLeapSeconds . bv) 0) 0) s)
              (write-long (ash (elt (_gpsLeapSeconds . bv) 1) -1) s))
             ((and (class _gpsLeapSeconds) (= (length (_gpsLeapSeconds . bv)) 1)) ;; big1
              (write-long (elt (_gpsLeapSeconds . bv) 0) s)
              (write-long (if (>= _gpsLeapSeconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsLeapSeconds s)(write-long (if (>= _gpsLeapSeconds 0) 0 #xffffffff) s)))
     ;; float32 _glonassClockTimeUncertainty
       (sys::poke _glonassClockTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; bool _systemRtcValid
       (if _systemRtcValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
       (sys::poke _gpsToGlonassTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _glonassYear
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _glonassYear (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _glonassYear) (= (length (_glonassYear . bv)) 2)) ;; bignum
              (write-long (ash (elt (_glonassYear . bv) 0) 0) s)
              (write-long (ash (elt (_glonassYear . bv) 1) -1) s))
             ((and (class _glonassYear) (= (length (_glonassYear . bv)) 1)) ;; big1
              (write-long (elt (_glonassYear . bv) 0) s)
              (write-long (if (>= _glonassYear 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _glonassYear s)(write-long (if (>= _glonassYear 0) 0 #xffffffff) s)))
     ;; int64 _gpsLeapSecondsUncertainty
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsLeapSecondsUncertainty (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsLeapSecondsUncertainty) (= (length (_gpsLeapSecondsUncertainty . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsLeapSecondsUncertainty . bv) 0) 0) s)
              (write-long (ash (elt (_gpsLeapSecondsUncertainty . bv) 1) -1) s))
             ((and (class _gpsLeapSecondsUncertainty) (= (length (_gpsLeapSecondsUncertainty . bv)) 1)) ;; big1
              (write-long (elt (_gpsLeapSecondsUncertainty . bv) 0) s)
              (write-long (if (>= _gpsLeapSecondsUncertainty 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsLeapSecondsUncertainty s)(write-long (if (>= _gpsLeapSecondsUncertainty 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _gpsToGlonassTimeBiasMilliseconds
     (setq _gpsToGlonassTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _gpsMilliseconds
#+(or :alpha :irix6 :x86_64)
      (setf _gpsMilliseconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsMilliseconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _seqMax
#+(or :alpha :irix6 :x86_64)
      (setf _seqMax (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _seqMax (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _gpsClockTimeUncertaintyMs
#+(or :alpha :irix6 :x86_64)
      (setf _gpsClockTimeUncertaintyMs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsClockTimeUncertaintyMs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _glonassClockSource
#+(or :alpha :irix6 :x86_64)
      (setf _glonassClockSource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _glonassClockSource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _glonassTimeBias
     (setq _glonassTimeBias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _gpsClockSource
#+(or :alpha :irix6 :x86_64)
      (setf _gpsClockSource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsClockSource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _clockFrequencyBias
     (setq _clockFrequencyBias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _source
     (setq _source (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _rfLoss
#+(or :alpha :irix6 :x86_64)
      (setf _rfLoss (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _rfLoss (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _fCount
#+(or :alpha :irix6 :x86_64)
      (setf _fCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _gpsTimeBiasMs
#+(or :alpha :irix6 :x86_64)
      (setf _gpsTimeBiasMs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsTimeBiasMs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _clockFrequencyUncertainty
     (setq _clockFrequencyUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _systemRtcTime
#+(or :alpha :irix6 :x86_64)
      (setf _systemRtcTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _systemRtcTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _seqNum
#+(or :alpha :irix6 :x86_64)
      (setf _seqNum (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _seqNum (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _frequencySource
#+(or :alpha :irix6 :x86_64)
      (setf _frequencySource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _frequencySource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _glonassDay
#+(or :alpha :irix6 :x86_64)
      (setf _glonassDay (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _glonassDay (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _reason
#+(or :alpha :irix6 :x86_64)
      (setf _reason (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _reason (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _glonassMilliseconds
#+(or :alpha :irix6 :x86_64)
      (setf _glonassMilliseconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _glonassMilliseconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _clockResets
#+(or :alpha :irix6 :x86_64)
      (setf _clockResets (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _clockResets (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/SV[] _sv
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sv (let (r) (dotimes (i n) (push (instance openpilot_bridge::SV :init) r)) r))
     (dolist (elem- _sv)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int64 _gpsLeapSeconds
#+(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSeconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSeconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _glonassClockTimeUncertainty
     (setq _glonassClockTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; bool _systemRtcValid
     (setq _systemRtcValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
     (setq _gpsToGlonassTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _glonassYear
#+(or :alpha :irix6 :x86_64)
      (setf _glonassYear (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _glonassYear (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _gpsLeapSecondsUncertainty
#+(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSecondsUncertainty (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSecondsUncertainty (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::DrMeasurementReport :md5sum-) "16e006938fe71bd40015db11503053ce")
(setf (get openpilot_bridge::DrMeasurementReport :datatype-) "openpilot_bridge/DrMeasurementReport")
(setf (get openpilot_bridge::DrMeasurementReport :definition-)
      "Header header

float32 gpsToGlonassTimeBiasMilliseconds
int64 gpsMilliseconds
int64 seqMax
int64 gpsClockTimeUncertaintyMs
int64 glonassClockSource
float32 glonassTimeBias
int64 gpsClockSource
float32 clockFrequencyBias
uint32 source # enum const: MeasurementSource
int64 rfLoss
int64 fCount
int64 gpsTimeBiasMs
float32 clockFrequencyUncertainty
int64 systemRtcTime
int64 seqNum
int64 frequencySource
int64 glonassDay
int64 reason
int64 glonassMilliseconds
int64 clockResets
SV[] sv
int64 gpsLeapSeconds
float32 glonassClockTimeUncertainty
int64 gpsWeek
bool systemRtcValid
float32 gpsToGlonassTimeBiasMillisecondsUncertainty
int64 glonassYear
int64 gpsLeapSecondsUncertainty

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
MSG: openpilot_bridge/SV
Header header

float32 unfilteredTimeUncertainty
int64 cycleSlipCount
int64 unfilteredMeasurementIntegral
MeasurementStatus measurementStatus
float32 filteredSpeedUncertainty
int64 predetectInterval
float32 unfilteredMeasurementFraction
float32 filteredTimeUncertainty
int64 carrierNoise
int64 postdetections
int32 latency
int64 filterStages
int64 multipathEstimate
int64 svId
float32 filteredMeasurementFraction
int64 rfLoss
int64 observations
int64 fCount
float32 dopplerAcceleration
float32 elevation
float32 filteredSpeed
float32 fineSpeed
int64 goodObservations
uint32 observationState # enum const: SVObservationState
bool goodParity
float32 carrierPhase
int64 filteredMeasurementIntegral
int64 parityErrorCount
float32 unfilteredSpeedUncertainty
float32 fineSpeedUncertainty
float32 azimuth
float32 unfilteredSpeed
int32 glonassFrequencyIndex

================================================================================
MSG: openpilot_bridge/MeasurementStatus
Header header

bool glonassTimeMarkValid
bool lockPointValid
bool imdJammingIndicator
bool measuredVelocity
bool fineOrCoarseVelocity
bool gpsHighBandwidthNu4
bool gpsRxDiversity
bool gpsHighBandwidthUniform
bool gpsHighBandwidthNu8
bool subMillisecondIsValid
bool lastUpdateFromDifference
bool tentativeMeasurement
bool probationMode
bool directionIsValid
bool bitEdgeConfirmedFromSignal
bool gpsRoundRobinRxDiversity
bool freshMeasurementIndicator
bool lteB13TxJammingIndicator
bool lastUpdateFromVelocityDifference
bool measurementNotUsable
bool glonassMeanderBitEdgeValid
bool gpsLowBandwidthRxDiversityCombined
bool satelliteTimeIsKnown
bool strongIndicationOfCrossCorelation
bool subBitTimeIsKnown
bool lockPointPositive
bool multipathIndicator
bool sirCheckIsNeeded
bool multipathEstimateIsValid

")



(provide :openpilot_bridge/DrMeasurementReport "16e006938fe71bd40015db11503053ce")


