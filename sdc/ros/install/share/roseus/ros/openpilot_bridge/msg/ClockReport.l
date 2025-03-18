;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ClockReport)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ClockReport (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CLOCKREPORT")
  (make-package "OPENPILOT_BRIDGE::CLOCKREPORT"))

(in-package "ROS")
;;//! \htmlinclude ClockReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ClockReport
  :super ros::object
  :slots (_header _galToBdsTimeBiasMillisecondsUncertainty _hasFCount _bdsClockSource _clockFrequencyUncertainty _gpsMilliseconds _hasGpsWeek _gpsToGlonassTimeBiasMilliseconds _galWeek _bdsMilliseconds _gpsToGalTimeBiasMilliseconds _glonassTimeBias _gpsClockSource _bdsClockTimeUncertainty _gpsToBdsTimeBiasMillisecondsUncertainty _glonassYear _galToGloTimeBiasMilliseconds _galMilliseconds _galToGloTimeBiasMillisecondsUncertainty _clockFrequencyBias _fCount _gpsLeapSeconds _hasRtcTime _bdsWeek _glonassClockTimeUncertainty _hasGlonassMilliseconds _systemRtcTime _bdsTimeBias _frequencySource _glonassDay _hasGlonassDay _gpsToGalTimeBiasMillisecondsUncertainty _galTimeBias _galClockTimeUncertainty _gpsTimeBias _lpmRtcCount _glonassMilliseconds _fCountOffset _bdsToGloTimeBiasMilliseconds _clockResets _gpsLeapSecondsSource _galClockSource _hasGpsMilliseconds _gpsToBdsTimeBiasMilliseconds _gpsWeek _gpsClockTimeUncertainty _bdsToGloTimeBiasMillisecondsUncertainty _hasGlonassYear _gpsToGlonassTimeBiasMillisecondsUncertainty _glonassClockSource _galToBdsTimeBiasMilliseconds _gpsLeapSecondsUncertainty ))

(defmethod openpilot_bridge::ClockReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:galToBdsTimeBiasMillisecondsUncertainty __galToBdsTimeBiasMillisecondsUncertainty) 0.0)
    ((:hasFCount __hasFCount) nil)
    ((:bdsClockSource __bdsClockSource) 0)
    ((:clockFrequencyUncertainty __clockFrequencyUncertainty) 0.0)
    ((:gpsMilliseconds __gpsMilliseconds) 0)
    ((:hasGpsWeek __hasGpsWeek) nil)
    ((:gpsToGlonassTimeBiasMilliseconds __gpsToGlonassTimeBiasMilliseconds) 0.0)
    ((:galWeek __galWeek) 0)
    ((:bdsMilliseconds __bdsMilliseconds) 0)
    ((:gpsToGalTimeBiasMilliseconds __gpsToGalTimeBiasMilliseconds) 0.0)
    ((:glonassTimeBias __glonassTimeBias) 0.0)
    ((:gpsClockSource __gpsClockSource) 0)
    ((:bdsClockTimeUncertainty __bdsClockTimeUncertainty) 0.0)
    ((:gpsToBdsTimeBiasMillisecondsUncertainty __gpsToBdsTimeBiasMillisecondsUncertainty) 0.0)
    ((:glonassYear __glonassYear) 0)
    ((:galToGloTimeBiasMilliseconds __galToGloTimeBiasMilliseconds) 0.0)
    ((:galMilliseconds __galMilliseconds) 0)
    ((:galToGloTimeBiasMillisecondsUncertainty __galToGloTimeBiasMillisecondsUncertainty) 0.0)
    ((:clockFrequencyBias __clockFrequencyBias) 0.0)
    ((:fCount __fCount) 0)
    ((:gpsLeapSeconds __gpsLeapSeconds) 0)
    ((:hasRtcTime __hasRtcTime) nil)
    ((:bdsWeek __bdsWeek) 0)
    ((:glonassClockTimeUncertainty __glonassClockTimeUncertainty) 0.0)
    ((:hasGlonassMilliseconds __hasGlonassMilliseconds) nil)
    ((:systemRtcTime __systemRtcTime) 0)
    ((:bdsTimeBias __bdsTimeBias) 0.0)
    ((:frequencySource __frequencySource) 0)
    ((:glonassDay __glonassDay) 0)
    ((:hasGlonassDay __hasGlonassDay) nil)
    ((:gpsToGalTimeBiasMillisecondsUncertainty __gpsToGalTimeBiasMillisecondsUncertainty) 0.0)
    ((:galTimeBias __galTimeBias) 0.0)
    ((:galClockTimeUncertainty __galClockTimeUncertainty) 0.0)
    ((:gpsTimeBias __gpsTimeBias) 0.0)
    ((:lpmRtcCount __lpmRtcCount) 0)
    ((:glonassMilliseconds __glonassMilliseconds) 0)
    ((:fCountOffset __fCountOffset) 0)
    ((:bdsToGloTimeBiasMilliseconds __bdsToGloTimeBiasMilliseconds) 0.0)
    ((:clockResets __clockResets) 0)
    ((:gpsLeapSecondsSource __gpsLeapSecondsSource) 0)
    ((:galClockSource __galClockSource) 0)
    ((:hasGpsMilliseconds __hasGpsMilliseconds) nil)
    ((:gpsToBdsTimeBiasMilliseconds __gpsToBdsTimeBiasMilliseconds) 0.0)
    ((:gpsWeek __gpsWeek) 0)
    ((:gpsClockTimeUncertainty __gpsClockTimeUncertainty) 0.0)
    ((:bdsToGloTimeBiasMillisecondsUncertainty __bdsToGloTimeBiasMillisecondsUncertainty) 0.0)
    ((:hasGlonassYear __hasGlonassYear) nil)
    ((:gpsToGlonassTimeBiasMillisecondsUncertainty __gpsToGlonassTimeBiasMillisecondsUncertainty) 0.0)
    ((:glonassClockSource __glonassClockSource) 0)
    ((:galToBdsTimeBiasMilliseconds __galToBdsTimeBiasMilliseconds) 0.0)
    ((:gpsLeapSecondsUncertainty __gpsLeapSecondsUncertainty) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _galToBdsTimeBiasMillisecondsUncertainty (float __galToBdsTimeBiasMillisecondsUncertainty))
   (setq _hasFCount __hasFCount)
   (setq _bdsClockSource (round __bdsClockSource))
   (setq _clockFrequencyUncertainty (float __clockFrequencyUncertainty))
   (setq _gpsMilliseconds (round __gpsMilliseconds))
   (setq _hasGpsWeek __hasGpsWeek)
   (setq _gpsToGlonassTimeBiasMilliseconds (float __gpsToGlonassTimeBiasMilliseconds))
   (setq _galWeek (round __galWeek))
   (setq _bdsMilliseconds (round __bdsMilliseconds))
   (setq _gpsToGalTimeBiasMilliseconds (float __gpsToGalTimeBiasMilliseconds))
   (setq _glonassTimeBias (float __glonassTimeBias))
   (setq _gpsClockSource (round __gpsClockSource))
   (setq _bdsClockTimeUncertainty (float __bdsClockTimeUncertainty))
   (setq _gpsToBdsTimeBiasMillisecondsUncertainty (float __gpsToBdsTimeBiasMillisecondsUncertainty))
   (setq _glonassYear (round __glonassYear))
   (setq _galToGloTimeBiasMilliseconds (float __galToGloTimeBiasMilliseconds))
   (setq _galMilliseconds (round __galMilliseconds))
   (setq _galToGloTimeBiasMillisecondsUncertainty (float __galToGloTimeBiasMillisecondsUncertainty))
   (setq _clockFrequencyBias (float __clockFrequencyBias))
   (setq _fCount (round __fCount))
   (setq _gpsLeapSeconds (round __gpsLeapSeconds))
   (setq _hasRtcTime __hasRtcTime)
   (setq _bdsWeek (round __bdsWeek))
   (setq _glonassClockTimeUncertainty (float __glonassClockTimeUncertainty))
   (setq _hasGlonassMilliseconds __hasGlonassMilliseconds)
   (setq _systemRtcTime (round __systemRtcTime))
   (setq _bdsTimeBias (float __bdsTimeBias))
   (setq _frequencySource (round __frequencySource))
   (setq _glonassDay (round __glonassDay))
   (setq _hasGlonassDay __hasGlonassDay)
   (setq _gpsToGalTimeBiasMillisecondsUncertainty (float __gpsToGalTimeBiasMillisecondsUncertainty))
   (setq _galTimeBias (float __galTimeBias))
   (setq _galClockTimeUncertainty (float __galClockTimeUncertainty))
   (setq _gpsTimeBias (float __gpsTimeBias))
   (setq _lpmRtcCount (round __lpmRtcCount))
   (setq _glonassMilliseconds (round __glonassMilliseconds))
   (setq _fCountOffset (round __fCountOffset))
   (setq _bdsToGloTimeBiasMilliseconds (float __bdsToGloTimeBiasMilliseconds))
   (setq _clockResets (round __clockResets))
   (setq _gpsLeapSecondsSource (round __gpsLeapSecondsSource))
   (setq _galClockSource (round __galClockSource))
   (setq _hasGpsMilliseconds __hasGpsMilliseconds)
   (setq _gpsToBdsTimeBiasMilliseconds (float __gpsToBdsTimeBiasMilliseconds))
   (setq _gpsWeek (round __gpsWeek))
   (setq _gpsClockTimeUncertainty (float __gpsClockTimeUncertainty))
   (setq _bdsToGloTimeBiasMillisecondsUncertainty (float __bdsToGloTimeBiasMillisecondsUncertainty))
   (setq _hasGlonassYear __hasGlonassYear)
   (setq _gpsToGlonassTimeBiasMillisecondsUncertainty (float __gpsToGlonassTimeBiasMillisecondsUncertainty))
   (setq _glonassClockSource (round __glonassClockSource))
   (setq _galToBdsTimeBiasMilliseconds (float __galToBdsTimeBiasMilliseconds))
   (setq _gpsLeapSecondsUncertainty (round __gpsLeapSecondsUncertainty))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:galToBdsTimeBiasMillisecondsUncertainty
   (&optional __galToBdsTimeBiasMillisecondsUncertainty)
   (if __galToBdsTimeBiasMillisecondsUncertainty (setq _galToBdsTimeBiasMillisecondsUncertainty __galToBdsTimeBiasMillisecondsUncertainty)) _galToBdsTimeBiasMillisecondsUncertainty)
  (:hasFCount
   (&optional __hasFCount)
   (if __hasFCount (setq _hasFCount __hasFCount)) _hasFCount)
  (:bdsClockSource
   (&optional __bdsClockSource)
   (if __bdsClockSource (setq _bdsClockSource __bdsClockSource)) _bdsClockSource)
  (:clockFrequencyUncertainty
   (&optional __clockFrequencyUncertainty)
   (if __clockFrequencyUncertainty (setq _clockFrequencyUncertainty __clockFrequencyUncertainty)) _clockFrequencyUncertainty)
  (:gpsMilliseconds
   (&optional __gpsMilliseconds)
   (if __gpsMilliseconds (setq _gpsMilliseconds __gpsMilliseconds)) _gpsMilliseconds)
  (:hasGpsWeek
   (&optional __hasGpsWeek)
   (if __hasGpsWeek (setq _hasGpsWeek __hasGpsWeek)) _hasGpsWeek)
  (:gpsToGlonassTimeBiasMilliseconds
   (&optional __gpsToGlonassTimeBiasMilliseconds)
   (if __gpsToGlonassTimeBiasMilliseconds (setq _gpsToGlonassTimeBiasMilliseconds __gpsToGlonassTimeBiasMilliseconds)) _gpsToGlonassTimeBiasMilliseconds)
  (:galWeek
   (&optional __galWeek)
   (if __galWeek (setq _galWeek __galWeek)) _galWeek)
  (:bdsMilliseconds
   (&optional __bdsMilliseconds)
   (if __bdsMilliseconds (setq _bdsMilliseconds __bdsMilliseconds)) _bdsMilliseconds)
  (:gpsToGalTimeBiasMilliseconds
   (&optional __gpsToGalTimeBiasMilliseconds)
   (if __gpsToGalTimeBiasMilliseconds (setq _gpsToGalTimeBiasMilliseconds __gpsToGalTimeBiasMilliseconds)) _gpsToGalTimeBiasMilliseconds)
  (:glonassTimeBias
   (&optional __glonassTimeBias)
   (if __glonassTimeBias (setq _glonassTimeBias __glonassTimeBias)) _glonassTimeBias)
  (:gpsClockSource
   (&optional __gpsClockSource)
   (if __gpsClockSource (setq _gpsClockSource __gpsClockSource)) _gpsClockSource)
  (:bdsClockTimeUncertainty
   (&optional __bdsClockTimeUncertainty)
   (if __bdsClockTimeUncertainty (setq _bdsClockTimeUncertainty __bdsClockTimeUncertainty)) _bdsClockTimeUncertainty)
  (:gpsToBdsTimeBiasMillisecondsUncertainty
   (&optional __gpsToBdsTimeBiasMillisecondsUncertainty)
   (if __gpsToBdsTimeBiasMillisecondsUncertainty (setq _gpsToBdsTimeBiasMillisecondsUncertainty __gpsToBdsTimeBiasMillisecondsUncertainty)) _gpsToBdsTimeBiasMillisecondsUncertainty)
  (:glonassYear
   (&optional __glonassYear)
   (if __glonassYear (setq _glonassYear __glonassYear)) _glonassYear)
  (:galToGloTimeBiasMilliseconds
   (&optional __galToGloTimeBiasMilliseconds)
   (if __galToGloTimeBiasMilliseconds (setq _galToGloTimeBiasMilliseconds __galToGloTimeBiasMilliseconds)) _galToGloTimeBiasMilliseconds)
  (:galMilliseconds
   (&optional __galMilliseconds)
   (if __galMilliseconds (setq _galMilliseconds __galMilliseconds)) _galMilliseconds)
  (:galToGloTimeBiasMillisecondsUncertainty
   (&optional __galToGloTimeBiasMillisecondsUncertainty)
   (if __galToGloTimeBiasMillisecondsUncertainty (setq _galToGloTimeBiasMillisecondsUncertainty __galToGloTimeBiasMillisecondsUncertainty)) _galToGloTimeBiasMillisecondsUncertainty)
  (:clockFrequencyBias
   (&optional __clockFrequencyBias)
   (if __clockFrequencyBias (setq _clockFrequencyBias __clockFrequencyBias)) _clockFrequencyBias)
  (:fCount
   (&optional __fCount)
   (if __fCount (setq _fCount __fCount)) _fCount)
  (:gpsLeapSeconds
   (&optional __gpsLeapSeconds)
   (if __gpsLeapSeconds (setq _gpsLeapSeconds __gpsLeapSeconds)) _gpsLeapSeconds)
  (:hasRtcTime
   (&optional __hasRtcTime)
   (if __hasRtcTime (setq _hasRtcTime __hasRtcTime)) _hasRtcTime)
  (:bdsWeek
   (&optional __bdsWeek)
   (if __bdsWeek (setq _bdsWeek __bdsWeek)) _bdsWeek)
  (:glonassClockTimeUncertainty
   (&optional __glonassClockTimeUncertainty)
   (if __glonassClockTimeUncertainty (setq _glonassClockTimeUncertainty __glonassClockTimeUncertainty)) _glonassClockTimeUncertainty)
  (:hasGlonassMilliseconds
   (&optional __hasGlonassMilliseconds)
   (if __hasGlonassMilliseconds (setq _hasGlonassMilliseconds __hasGlonassMilliseconds)) _hasGlonassMilliseconds)
  (:systemRtcTime
   (&optional __systemRtcTime)
   (if __systemRtcTime (setq _systemRtcTime __systemRtcTime)) _systemRtcTime)
  (:bdsTimeBias
   (&optional __bdsTimeBias)
   (if __bdsTimeBias (setq _bdsTimeBias __bdsTimeBias)) _bdsTimeBias)
  (:frequencySource
   (&optional __frequencySource)
   (if __frequencySource (setq _frequencySource __frequencySource)) _frequencySource)
  (:glonassDay
   (&optional __glonassDay)
   (if __glonassDay (setq _glonassDay __glonassDay)) _glonassDay)
  (:hasGlonassDay
   (&optional __hasGlonassDay)
   (if __hasGlonassDay (setq _hasGlonassDay __hasGlonassDay)) _hasGlonassDay)
  (:gpsToGalTimeBiasMillisecondsUncertainty
   (&optional __gpsToGalTimeBiasMillisecondsUncertainty)
   (if __gpsToGalTimeBiasMillisecondsUncertainty (setq _gpsToGalTimeBiasMillisecondsUncertainty __gpsToGalTimeBiasMillisecondsUncertainty)) _gpsToGalTimeBiasMillisecondsUncertainty)
  (:galTimeBias
   (&optional __galTimeBias)
   (if __galTimeBias (setq _galTimeBias __galTimeBias)) _galTimeBias)
  (:galClockTimeUncertainty
   (&optional __galClockTimeUncertainty)
   (if __galClockTimeUncertainty (setq _galClockTimeUncertainty __galClockTimeUncertainty)) _galClockTimeUncertainty)
  (:gpsTimeBias
   (&optional __gpsTimeBias)
   (if __gpsTimeBias (setq _gpsTimeBias __gpsTimeBias)) _gpsTimeBias)
  (:lpmRtcCount
   (&optional __lpmRtcCount)
   (if __lpmRtcCount (setq _lpmRtcCount __lpmRtcCount)) _lpmRtcCount)
  (:glonassMilliseconds
   (&optional __glonassMilliseconds)
   (if __glonassMilliseconds (setq _glonassMilliseconds __glonassMilliseconds)) _glonassMilliseconds)
  (:fCountOffset
   (&optional __fCountOffset)
   (if __fCountOffset (setq _fCountOffset __fCountOffset)) _fCountOffset)
  (:bdsToGloTimeBiasMilliseconds
   (&optional __bdsToGloTimeBiasMilliseconds)
   (if __bdsToGloTimeBiasMilliseconds (setq _bdsToGloTimeBiasMilliseconds __bdsToGloTimeBiasMilliseconds)) _bdsToGloTimeBiasMilliseconds)
  (:clockResets
   (&optional __clockResets)
   (if __clockResets (setq _clockResets __clockResets)) _clockResets)
  (:gpsLeapSecondsSource
   (&optional __gpsLeapSecondsSource)
   (if __gpsLeapSecondsSource (setq _gpsLeapSecondsSource __gpsLeapSecondsSource)) _gpsLeapSecondsSource)
  (:galClockSource
   (&optional __galClockSource)
   (if __galClockSource (setq _galClockSource __galClockSource)) _galClockSource)
  (:hasGpsMilliseconds
   (&optional __hasGpsMilliseconds)
   (if __hasGpsMilliseconds (setq _hasGpsMilliseconds __hasGpsMilliseconds)) _hasGpsMilliseconds)
  (:gpsToBdsTimeBiasMilliseconds
   (&optional __gpsToBdsTimeBiasMilliseconds)
   (if __gpsToBdsTimeBiasMilliseconds (setq _gpsToBdsTimeBiasMilliseconds __gpsToBdsTimeBiasMilliseconds)) _gpsToBdsTimeBiasMilliseconds)
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:gpsClockTimeUncertainty
   (&optional __gpsClockTimeUncertainty)
   (if __gpsClockTimeUncertainty (setq _gpsClockTimeUncertainty __gpsClockTimeUncertainty)) _gpsClockTimeUncertainty)
  (:bdsToGloTimeBiasMillisecondsUncertainty
   (&optional __bdsToGloTimeBiasMillisecondsUncertainty)
   (if __bdsToGloTimeBiasMillisecondsUncertainty (setq _bdsToGloTimeBiasMillisecondsUncertainty __bdsToGloTimeBiasMillisecondsUncertainty)) _bdsToGloTimeBiasMillisecondsUncertainty)
  (:hasGlonassYear
   (&optional __hasGlonassYear)
   (if __hasGlonassYear (setq _hasGlonassYear __hasGlonassYear)) _hasGlonassYear)
  (:gpsToGlonassTimeBiasMillisecondsUncertainty
   (&optional __gpsToGlonassTimeBiasMillisecondsUncertainty)
   (if __gpsToGlonassTimeBiasMillisecondsUncertainty (setq _gpsToGlonassTimeBiasMillisecondsUncertainty __gpsToGlonassTimeBiasMillisecondsUncertainty)) _gpsToGlonassTimeBiasMillisecondsUncertainty)
  (:glonassClockSource
   (&optional __glonassClockSource)
   (if __glonassClockSource (setq _glonassClockSource __glonassClockSource)) _glonassClockSource)
  (:galToBdsTimeBiasMilliseconds
   (&optional __galToBdsTimeBiasMilliseconds)
   (if __galToBdsTimeBiasMilliseconds (setq _galToBdsTimeBiasMilliseconds __galToBdsTimeBiasMilliseconds)) _galToBdsTimeBiasMilliseconds)
  (:gpsLeapSecondsUncertainty
   (&optional __gpsLeapSecondsUncertainty)
   (if __gpsLeapSecondsUncertainty (setq _gpsLeapSecondsUncertainty __gpsLeapSecondsUncertainty)) _gpsLeapSecondsUncertainty)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _galToBdsTimeBiasMillisecondsUncertainty
    4
    ;; bool _hasFCount
    1
    ;; int64 _bdsClockSource
    8
    ;; float32 _clockFrequencyUncertainty
    4
    ;; int64 _gpsMilliseconds
    8
    ;; bool _hasGpsWeek
    1
    ;; float32 _gpsToGlonassTimeBiasMilliseconds
    4
    ;; int64 _galWeek
    8
    ;; int64 _bdsMilliseconds
    8
    ;; float32 _gpsToGalTimeBiasMilliseconds
    4
    ;; float32 _glonassTimeBias
    4
    ;; int64 _gpsClockSource
    8
    ;; float32 _bdsClockTimeUncertainty
    4
    ;; float32 _gpsToBdsTimeBiasMillisecondsUncertainty
    4
    ;; int64 _glonassYear
    8
    ;; float32 _galToGloTimeBiasMilliseconds
    4
    ;; int64 _galMilliseconds
    8
    ;; float32 _galToGloTimeBiasMillisecondsUncertainty
    4
    ;; float32 _clockFrequencyBias
    4
    ;; int64 _fCount
    8
    ;; int64 _gpsLeapSeconds
    8
    ;; bool _hasRtcTime
    1
    ;; int64 _bdsWeek
    8
    ;; float32 _glonassClockTimeUncertainty
    4
    ;; bool _hasGlonassMilliseconds
    1
    ;; int64 _systemRtcTime
    8
    ;; float32 _bdsTimeBias
    4
    ;; int64 _frequencySource
    8
    ;; int64 _glonassDay
    8
    ;; bool _hasGlonassDay
    1
    ;; float32 _gpsToGalTimeBiasMillisecondsUncertainty
    4
    ;; float32 _galTimeBias
    4
    ;; float32 _galClockTimeUncertainty
    4
    ;; float32 _gpsTimeBias
    4
    ;; int64 _lpmRtcCount
    8
    ;; int64 _glonassMilliseconds
    8
    ;; int64 _fCountOffset
    8
    ;; float32 _bdsToGloTimeBiasMilliseconds
    4
    ;; int64 _clockResets
    8
    ;; int64 _gpsLeapSecondsSource
    8
    ;; int64 _galClockSource
    8
    ;; bool _hasGpsMilliseconds
    1
    ;; float32 _gpsToBdsTimeBiasMilliseconds
    4
    ;; int64 _gpsWeek
    8
    ;; float32 _gpsClockTimeUncertainty
    4
    ;; float32 _bdsToGloTimeBiasMillisecondsUncertainty
    4
    ;; bool _hasGlonassYear
    1
    ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
    4
    ;; int64 _glonassClockSource
    8
    ;; float32 _galToBdsTimeBiasMilliseconds
    4
    ;; int64 _gpsLeapSecondsUncertainty
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _galToBdsTimeBiasMillisecondsUncertainty
       (sys::poke _galToBdsTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasFCount
       (if _hasFCount (write-byte -1 s) (write-byte 0 s))
     ;; int64 _bdsClockSource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bdsClockSource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bdsClockSource) (= (length (_bdsClockSource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bdsClockSource . bv) 0) 0) s)
              (write-long (ash (elt (_bdsClockSource . bv) 1) -1) s))
             ((and (class _bdsClockSource) (= (length (_bdsClockSource . bv)) 1)) ;; big1
              (write-long (elt (_bdsClockSource . bv) 0) s)
              (write-long (if (>= _bdsClockSource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bdsClockSource s)(write-long (if (>= _bdsClockSource 0) 0 #xffffffff) s)))
     ;; float32 _clockFrequencyUncertainty
       (sys::poke _clockFrequencyUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; bool _hasGpsWeek
       (if _hasGpsWeek (write-byte -1 s) (write-byte 0 s))
     ;; float32 _gpsToGlonassTimeBiasMilliseconds
       (sys::poke _gpsToGlonassTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _galWeek
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _galWeek (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _galWeek) (= (length (_galWeek . bv)) 2)) ;; bignum
              (write-long (ash (elt (_galWeek . bv) 0) 0) s)
              (write-long (ash (elt (_galWeek . bv) 1) -1) s))
             ((and (class _galWeek) (= (length (_galWeek . bv)) 1)) ;; big1
              (write-long (elt (_galWeek . bv) 0) s)
              (write-long (if (>= _galWeek 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _galWeek s)(write-long (if (>= _galWeek 0) 0 #xffffffff) s)))
     ;; int64 _bdsMilliseconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bdsMilliseconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bdsMilliseconds) (= (length (_bdsMilliseconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bdsMilliseconds . bv) 0) 0) s)
              (write-long (ash (elt (_bdsMilliseconds . bv) 1) -1) s))
             ((and (class _bdsMilliseconds) (= (length (_bdsMilliseconds . bv)) 1)) ;; big1
              (write-long (elt (_bdsMilliseconds . bv) 0) s)
              (write-long (if (>= _bdsMilliseconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bdsMilliseconds s)(write-long (if (>= _bdsMilliseconds 0) 0 #xffffffff) s)))
     ;; float32 _gpsToGalTimeBiasMilliseconds
       (sys::poke _gpsToGalTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32 _bdsClockTimeUncertainty
       (sys::poke _bdsClockTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gpsToBdsTimeBiasMillisecondsUncertainty
       (sys::poke _gpsToBdsTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32 _galToGloTimeBiasMilliseconds
       (sys::poke _galToGloTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _galMilliseconds
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _galMilliseconds (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _galMilliseconds) (= (length (_galMilliseconds . bv)) 2)) ;; bignum
              (write-long (ash (elt (_galMilliseconds . bv) 0) 0) s)
              (write-long (ash (elt (_galMilliseconds . bv) 1) -1) s))
             ((and (class _galMilliseconds) (= (length (_galMilliseconds . bv)) 1)) ;; big1
              (write-long (elt (_galMilliseconds . bv) 0) s)
              (write-long (if (>= _galMilliseconds 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _galMilliseconds s)(write-long (if (>= _galMilliseconds 0) 0 #xffffffff) s)))
     ;; float32 _galToGloTimeBiasMillisecondsUncertainty
       (sys::poke _galToGloTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _clockFrequencyBias
       (sys::poke _clockFrequencyBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; bool _hasRtcTime
       (if _hasRtcTime (write-byte -1 s) (write-byte 0 s))
     ;; int64 _bdsWeek
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bdsWeek (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bdsWeek) (= (length (_bdsWeek . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bdsWeek . bv) 0) 0) s)
              (write-long (ash (elt (_bdsWeek . bv) 1) -1) s))
             ((and (class _bdsWeek) (= (length (_bdsWeek . bv)) 1)) ;; big1
              (write-long (elt (_bdsWeek . bv) 0) s)
              (write-long (if (>= _bdsWeek 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bdsWeek s)(write-long (if (>= _bdsWeek 0) 0 #xffffffff) s)))
     ;; float32 _glonassClockTimeUncertainty
       (sys::poke _glonassClockTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasGlonassMilliseconds
       (if _hasGlonassMilliseconds (write-byte -1 s) (write-byte 0 s))
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
     ;; float32 _bdsTimeBias
       (sys::poke _bdsTimeBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; bool _hasGlonassDay
       (if _hasGlonassDay (write-byte -1 s) (write-byte 0 s))
     ;; float32 _gpsToGalTimeBiasMillisecondsUncertainty
       (sys::poke _gpsToGalTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _galTimeBias
       (sys::poke _galTimeBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _galClockTimeUncertainty
       (sys::poke _galClockTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gpsTimeBias
       (sys::poke _gpsTimeBias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _lpmRtcCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lpmRtcCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lpmRtcCount) (= (length (_lpmRtcCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lpmRtcCount . bv) 0) 0) s)
              (write-long (ash (elt (_lpmRtcCount . bv) 1) -1) s))
             ((and (class _lpmRtcCount) (= (length (_lpmRtcCount . bv)) 1)) ;; big1
              (write-long (elt (_lpmRtcCount . bv) 0) s)
              (write-long (if (>= _lpmRtcCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lpmRtcCount s)(write-long (if (>= _lpmRtcCount 0) 0 #xffffffff) s)))
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
     ;; int64 _fCountOffset
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fCountOffset (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fCountOffset) (= (length (_fCountOffset . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fCountOffset . bv) 0) 0) s)
              (write-long (ash (elt (_fCountOffset . bv) 1) -1) s))
             ((and (class _fCountOffset) (= (length (_fCountOffset . bv)) 1)) ;; big1
              (write-long (elt (_fCountOffset . bv) 0) s)
              (write-long (if (>= _fCountOffset 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fCountOffset s)(write-long (if (>= _fCountOffset 0) 0 #xffffffff) s)))
     ;; float32 _bdsToGloTimeBiasMilliseconds
       (sys::poke _bdsToGloTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; int64 _gpsLeapSecondsSource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpsLeapSecondsSource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpsLeapSecondsSource) (= (length (_gpsLeapSecondsSource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpsLeapSecondsSource . bv) 0) 0) s)
              (write-long (ash (elt (_gpsLeapSecondsSource . bv) 1) -1) s))
             ((and (class _gpsLeapSecondsSource) (= (length (_gpsLeapSecondsSource . bv)) 1)) ;; big1
              (write-long (elt (_gpsLeapSecondsSource . bv) 0) s)
              (write-long (if (>= _gpsLeapSecondsSource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpsLeapSecondsSource s)(write-long (if (>= _gpsLeapSecondsSource 0) 0 #xffffffff) s)))
     ;; int64 _galClockSource
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _galClockSource (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _galClockSource) (= (length (_galClockSource . bv)) 2)) ;; bignum
              (write-long (ash (elt (_galClockSource . bv) 0) 0) s)
              (write-long (ash (elt (_galClockSource . bv) 1) -1) s))
             ((and (class _galClockSource) (= (length (_galClockSource . bv)) 1)) ;; big1
              (write-long (elt (_galClockSource . bv) 0) s)
              (write-long (if (>= _galClockSource 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _galClockSource s)(write-long (if (>= _galClockSource 0) 0 #xffffffff) s)))
     ;; bool _hasGpsMilliseconds
       (if _hasGpsMilliseconds (write-byte -1 s) (write-byte 0 s))
     ;; float32 _gpsToBdsTimeBiasMilliseconds
       (sys::poke _gpsToBdsTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32 _gpsClockTimeUncertainty
       (sys::poke _gpsClockTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _bdsToGloTimeBiasMillisecondsUncertainty
       (sys::poke _bdsToGloTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasGlonassYear
       (if _hasGlonassYear (write-byte -1 s) (write-byte 0 s))
     ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
       (sys::poke _gpsToGlonassTimeBiasMillisecondsUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32 _galToBdsTimeBiasMilliseconds
       (sys::poke _galToBdsTimeBiasMilliseconds (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
   ;; float32 _galToBdsTimeBiasMillisecondsUncertainty
     (setq _galToBdsTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasFCount
     (setq _hasFCount (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _bdsClockSource
#+(or :alpha :irix6 :x86_64)
      (setf _bdsClockSource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bdsClockSource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _clockFrequencyUncertainty
     (setq _clockFrequencyUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; bool _hasGpsWeek
     (setq _hasGpsWeek (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _gpsToGlonassTimeBiasMilliseconds
     (setq _gpsToGlonassTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _galWeek
#+(or :alpha :irix6 :x86_64)
      (setf _galWeek (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _galWeek (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _bdsMilliseconds
#+(or :alpha :irix6 :x86_64)
      (setf _bdsMilliseconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bdsMilliseconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _gpsToGalTimeBiasMilliseconds
     (setq _gpsToGalTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32 _bdsClockTimeUncertainty
     (setq _bdsClockTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gpsToBdsTimeBiasMillisecondsUncertainty
     (setq _gpsToBdsTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32 _galToGloTimeBiasMilliseconds
     (setq _galToGloTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _galMilliseconds
#+(or :alpha :irix6 :x86_64)
      (setf _galMilliseconds (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _galMilliseconds (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _galToGloTimeBiasMillisecondsUncertainty
     (setq _galToGloTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _clockFrequencyBias
     (setq _clockFrequencyBias (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; bool _hasRtcTime
     (setq _hasRtcTime (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _bdsWeek
#+(or :alpha :irix6 :x86_64)
      (setf _bdsWeek (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bdsWeek (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _glonassClockTimeUncertainty
     (setq _glonassClockTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasGlonassMilliseconds
     (setq _hasGlonassMilliseconds (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
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
   ;; float32 _bdsTimeBias
     (setq _bdsTimeBias (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; bool _hasGlonassDay
     (setq _hasGlonassDay (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _gpsToGalTimeBiasMillisecondsUncertainty
     (setq _gpsToGalTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _galTimeBias
     (setq _galTimeBias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _galClockTimeUncertainty
     (setq _galClockTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gpsTimeBias
     (setq _gpsTimeBias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _lpmRtcCount
#+(or :alpha :irix6 :x86_64)
      (setf _lpmRtcCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lpmRtcCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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
   ;; int64 _fCountOffset
#+(or :alpha :irix6 :x86_64)
      (setf _fCountOffset (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fCountOffset (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _bdsToGloTimeBiasMilliseconds
     (setq _bdsToGloTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; int64 _gpsLeapSecondsSource
#+(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSecondsSource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpsLeapSecondsSource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _galClockSource
#+(or :alpha :irix6 :x86_64)
      (setf _galClockSource (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _galClockSource (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _hasGpsMilliseconds
     (setq _hasGpsMilliseconds (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _gpsToBdsTimeBiasMilliseconds
     (setq _gpsToBdsTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32 _gpsClockTimeUncertainty
     (setq _gpsClockTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _bdsToGloTimeBiasMillisecondsUncertainty
     (setq _bdsToGloTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasGlonassYear
     (setq _hasGlonassYear (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _gpsToGlonassTimeBiasMillisecondsUncertainty
     (setq _gpsToGlonassTimeBiasMillisecondsUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32 _galToBdsTimeBiasMilliseconds
     (setq _galToBdsTimeBiasMilliseconds (sys::peek buf ptr- :float)) (incf ptr- 4)
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

(setf (get openpilot_bridge::ClockReport :md5sum-) "9c5d965bc1d857db6ee7aaa1ec215d3f")
(setf (get openpilot_bridge::ClockReport :datatype-) "openpilot_bridge/ClockReport")
(setf (get openpilot_bridge::ClockReport :definition-)
      "Header header

float32 galToBdsTimeBiasMillisecondsUncertainty
bool hasFCount
int64 bdsClockSource
float32 clockFrequencyUncertainty
int64 gpsMilliseconds
bool hasGpsWeek
float32 gpsToGlonassTimeBiasMilliseconds
int64 galWeek
int64 bdsMilliseconds
float32 gpsToGalTimeBiasMilliseconds
float32 glonassTimeBias
int64 gpsClockSource
float32 bdsClockTimeUncertainty
float32 gpsToBdsTimeBiasMillisecondsUncertainty
int64 glonassYear
float32 galToGloTimeBiasMilliseconds
int64 galMilliseconds
float32 galToGloTimeBiasMillisecondsUncertainty
float32 clockFrequencyBias
int64 fCount
int64 gpsLeapSeconds
bool hasRtcTime
int64 bdsWeek
float32 glonassClockTimeUncertainty
bool hasGlonassMilliseconds
int64 systemRtcTime
float32 bdsTimeBias
int64 frequencySource
int64 glonassDay
bool hasGlonassDay
float32 gpsToGalTimeBiasMillisecondsUncertainty
float32 galTimeBias
float32 galClockTimeUncertainty
float32 gpsTimeBias
int64 lpmRtcCount
int64 glonassMilliseconds
int64 fCountOffset
float32 bdsToGloTimeBiasMilliseconds
int64 clockResets
int64 gpsLeapSecondsSource
int64 galClockSource
bool hasGpsMilliseconds
float32 gpsToBdsTimeBiasMilliseconds
int64 gpsWeek
float32 gpsClockTimeUncertainty
float32 bdsToGloTimeBiasMillisecondsUncertainty
bool hasGlonassYear
float32 gpsToGlonassTimeBiasMillisecondsUncertainty
int64 glonassClockSource
float32 galToBdsTimeBiasMilliseconds
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

")



(provide :openpilot_bridge/ClockReport "9c5d965bc1d857db6ee7aaa1ec215d3f")


