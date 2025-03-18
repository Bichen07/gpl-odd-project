;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::SV)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'SV (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SV")
  (make-package "OPENPILOT_BRIDGE::SV"))

(in-package "ROS")
;;//! \htmlinclude SV.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::SV
  :super ros::object
  :slots (_header _unfilteredTimeUncertainty _cycleSlipCount _unfilteredMeasurementIntegral _measurementStatus _filteredSpeedUncertainty _predetectInterval _unfilteredMeasurementFraction _filteredTimeUncertainty _carrierNoise _postdetections _latency _filterStages _multipathEstimate _svId _filteredMeasurementFraction _rfLoss _observations _fCount _dopplerAcceleration _elevation _filteredSpeed _fineSpeed _goodObservations _observationState _goodParity _carrierPhase _filteredMeasurementIntegral _parityErrorCount _unfilteredSpeedUncertainty _fineSpeedUncertainty _azimuth _unfilteredSpeed _glonassFrequencyIndex ))

(defmethod openpilot_bridge::SV
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:unfilteredTimeUncertainty __unfilteredTimeUncertainty) 0.0)
    ((:cycleSlipCount __cycleSlipCount) 0)
    ((:unfilteredMeasurementIntegral __unfilteredMeasurementIntegral) 0)
    ((:measurementStatus __measurementStatus) (instance openpilot_bridge::MeasurementStatus :init))
    ((:filteredSpeedUncertainty __filteredSpeedUncertainty) 0.0)
    ((:predetectInterval __predetectInterval) 0)
    ((:unfilteredMeasurementFraction __unfilteredMeasurementFraction) 0.0)
    ((:filteredTimeUncertainty __filteredTimeUncertainty) 0.0)
    ((:carrierNoise __carrierNoise) 0)
    ((:postdetections __postdetections) 0)
    ((:latency __latency) 0)
    ((:filterStages __filterStages) 0)
    ((:multipathEstimate __multipathEstimate) 0)
    ((:svId __svId) 0)
    ((:filteredMeasurementFraction __filteredMeasurementFraction) 0.0)
    ((:rfLoss __rfLoss) 0)
    ((:observations __observations) 0)
    ((:fCount __fCount) 0)
    ((:dopplerAcceleration __dopplerAcceleration) 0.0)
    ((:elevation __elevation) 0.0)
    ((:filteredSpeed __filteredSpeed) 0.0)
    ((:fineSpeed __fineSpeed) 0.0)
    ((:goodObservations __goodObservations) 0)
    ((:observationState __observationState) 0)
    ((:goodParity __goodParity) nil)
    ((:carrierPhase __carrierPhase) 0.0)
    ((:filteredMeasurementIntegral __filteredMeasurementIntegral) 0)
    ((:parityErrorCount __parityErrorCount) 0)
    ((:unfilteredSpeedUncertainty __unfilteredSpeedUncertainty) 0.0)
    ((:fineSpeedUncertainty __fineSpeedUncertainty) 0.0)
    ((:azimuth __azimuth) 0.0)
    ((:unfilteredSpeed __unfilteredSpeed) 0.0)
    ((:glonassFrequencyIndex __glonassFrequencyIndex) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _unfilteredTimeUncertainty (float __unfilteredTimeUncertainty))
   (setq _cycleSlipCount (round __cycleSlipCount))
   (setq _unfilteredMeasurementIntegral (round __unfilteredMeasurementIntegral))
   (setq _measurementStatus __measurementStatus)
   (setq _filteredSpeedUncertainty (float __filteredSpeedUncertainty))
   (setq _predetectInterval (round __predetectInterval))
   (setq _unfilteredMeasurementFraction (float __unfilteredMeasurementFraction))
   (setq _filteredTimeUncertainty (float __filteredTimeUncertainty))
   (setq _carrierNoise (round __carrierNoise))
   (setq _postdetections (round __postdetections))
   (setq _latency (round __latency))
   (setq _filterStages (round __filterStages))
   (setq _multipathEstimate (round __multipathEstimate))
   (setq _svId (round __svId))
   (setq _filteredMeasurementFraction (float __filteredMeasurementFraction))
   (setq _rfLoss (round __rfLoss))
   (setq _observations (round __observations))
   (setq _fCount (round __fCount))
   (setq _dopplerAcceleration (float __dopplerAcceleration))
   (setq _elevation (float __elevation))
   (setq _filteredSpeed (float __filteredSpeed))
   (setq _fineSpeed (float __fineSpeed))
   (setq _goodObservations (round __goodObservations))
   (setq _observationState (round __observationState))
   (setq _goodParity __goodParity)
   (setq _carrierPhase (float __carrierPhase))
   (setq _filteredMeasurementIntegral (round __filteredMeasurementIntegral))
   (setq _parityErrorCount (round __parityErrorCount))
   (setq _unfilteredSpeedUncertainty (float __unfilteredSpeedUncertainty))
   (setq _fineSpeedUncertainty (float __fineSpeedUncertainty))
   (setq _azimuth (float __azimuth))
   (setq _unfilteredSpeed (float __unfilteredSpeed))
   (setq _glonassFrequencyIndex (round __glonassFrequencyIndex))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:unfilteredTimeUncertainty
   (&optional __unfilteredTimeUncertainty)
   (if __unfilteredTimeUncertainty (setq _unfilteredTimeUncertainty __unfilteredTimeUncertainty)) _unfilteredTimeUncertainty)
  (:cycleSlipCount
   (&optional __cycleSlipCount)
   (if __cycleSlipCount (setq _cycleSlipCount __cycleSlipCount)) _cycleSlipCount)
  (:unfilteredMeasurementIntegral
   (&optional __unfilteredMeasurementIntegral)
   (if __unfilteredMeasurementIntegral (setq _unfilteredMeasurementIntegral __unfilteredMeasurementIntegral)) _unfilteredMeasurementIntegral)
  (:measurementStatus
   (&rest __measurementStatus)
   (if (keywordp (car __measurementStatus))
       (send* _measurementStatus __measurementStatus)
     (progn
       (if __measurementStatus (setq _measurementStatus (car __measurementStatus)))
       _measurementStatus)))
  (:filteredSpeedUncertainty
   (&optional __filteredSpeedUncertainty)
   (if __filteredSpeedUncertainty (setq _filteredSpeedUncertainty __filteredSpeedUncertainty)) _filteredSpeedUncertainty)
  (:predetectInterval
   (&optional __predetectInterval)
   (if __predetectInterval (setq _predetectInterval __predetectInterval)) _predetectInterval)
  (:unfilteredMeasurementFraction
   (&optional __unfilteredMeasurementFraction)
   (if __unfilteredMeasurementFraction (setq _unfilteredMeasurementFraction __unfilteredMeasurementFraction)) _unfilteredMeasurementFraction)
  (:filteredTimeUncertainty
   (&optional __filteredTimeUncertainty)
   (if __filteredTimeUncertainty (setq _filteredTimeUncertainty __filteredTimeUncertainty)) _filteredTimeUncertainty)
  (:carrierNoise
   (&optional __carrierNoise)
   (if __carrierNoise (setq _carrierNoise __carrierNoise)) _carrierNoise)
  (:postdetections
   (&optional __postdetections)
   (if __postdetections (setq _postdetections __postdetections)) _postdetections)
  (:latency
   (&optional __latency)
   (if __latency (setq _latency __latency)) _latency)
  (:filterStages
   (&optional __filterStages)
   (if __filterStages (setq _filterStages __filterStages)) _filterStages)
  (:multipathEstimate
   (&optional __multipathEstimate)
   (if __multipathEstimate (setq _multipathEstimate __multipathEstimate)) _multipathEstimate)
  (:svId
   (&optional __svId)
   (if __svId (setq _svId __svId)) _svId)
  (:filteredMeasurementFraction
   (&optional __filteredMeasurementFraction)
   (if __filteredMeasurementFraction (setq _filteredMeasurementFraction __filteredMeasurementFraction)) _filteredMeasurementFraction)
  (:rfLoss
   (&optional __rfLoss)
   (if __rfLoss (setq _rfLoss __rfLoss)) _rfLoss)
  (:observations
   (&optional __observations)
   (if __observations (setq _observations __observations)) _observations)
  (:fCount
   (&optional __fCount)
   (if __fCount (setq _fCount __fCount)) _fCount)
  (:dopplerAcceleration
   (&optional __dopplerAcceleration)
   (if __dopplerAcceleration (setq _dopplerAcceleration __dopplerAcceleration)) _dopplerAcceleration)
  (:elevation
   (&optional __elevation)
   (if __elevation (setq _elevation __elevation)) _elevation)
  (:filteredSpeed
   (&optional __filteredSpeed)
   (if __filteredSpeed (setq _filteredSpeed __filteredSpeed)) _filteredSpeed)
  (:fineSpeed
   (&optional __fineSpeed)
   (if __fineSpeed (setq _fineSpeed __fineSpeed)) _fineSpeed)
  (:goodObservations
   (&optional __goodObservations)
   (if __goodObservations (setq _goodObservations __goodObservations)) _goodObservations)
  (:observationState
   (&optional __observationState)
   (if __observationState (setq _observationState __observationState)) _observationState)
  (:goodParity
   (&optional __goodParity)
   (if __goodParity (setq _goodParity __goodParity)) _goodParity)
  (:carrierPhase
   (&optional __carrierPhase)
   (if __carrierPhase (setq _carrierPhase __carrierPhase)) _carrierPhase)
  (:filteredMeasurementIntegral
   (&optional __filteredMeasurementIntegral)
   (if __filteredMeasurementIntegral (setq _filteredMeasurementIntegral __filteredMeasurementIntegral)) _filteredMeasurementIntegral)
  (:parityErrorCount
   (&optional __parityErrorCount)
   (if __parityErrorCount (setq _parityErrorCount __parityErrorCount)) _parityErrorCount)
  (:unfilteredSpeedUncertainty
   (&optional __unfilteredSpeedUncertainty)
   (if __unfilteredSpeedUncertainty (setq _unfilteredSpeedUncertainty __unfilteredSpeedUncertainty)) _unfilteredSpeedUncertainty)
  (:fineSpeedUncertainty
   (&optional __fineSpeedUncertainty)
   (if __fineSpeedUncertainty (setq _fineSpeedUncertainty __fineSpeedUncertainty)) _fineSpeedUncertainty)
  (:azimuth
   (&optional __azimuth)
   (if __azimuth (setq _azimuth __azimuth)) _azimuth)
  (:unfilteredSpeed
   (&optional __unfilteredSpeed)
   (if __unfilteredSpeed (setq _unfilteredSpeed __unfilteredSpeed)) _unfilteredSpeed)
  (:glonassFrequencyIndex
   (&optional __glonassFrequencyIndex)
   (if __glonassFrequencyIndex (setq _glonassFrequencyIndex __glonassFrequencyIndex)) _glonassFrequencyIndex)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _unfilteredTimeUncertainty
    4
    ;; int64 _cycleSlipCount
    8
    ;; int64 _unfilteredMeasurementIntegral
    8
    ;; openpilot_bridge/MeasurementStatus _measurementStatus
    (send _measurementStatus :serialization-length)
    ;; float32 _filteredSpeedUncertainty
    4
    ;; int64 _predetectInterval
    8
    ;; float32 _unfilteredMeasurementFraction
    4
    ;; float32 _filteredTimeUncertainty
    4
    ;; int64 _carrierNoise
    8
    ;; int64 _postdetections
    8
    ;; int32 _latency
    4
    ;; int64 _filterStages
    8
    ;; int64 _multipathEstimate
    8
    ;; int64 _svId
    8
    ;; float32 _filteredMeasurementFraction
    4
    ;; int64 _rfLoss
    8
    ;; int64 _observations
    8
    ;; int64 _fCount
    8
    ;; float32 _dopplerAcceleration
    4
    ;; float32 _elevation
    4
    ;; float32 _filteredSpeed
    4
    ;; float32 _fineSpeed
    4
    ;; int64 _goodObservations
    8
    ;; uint32 _observationState
    4
    ;; bool _goodParity
    1
    ;; float32 _carrierPhase
    4
    ;; int64 _filteredMeasurementIntegral
    8
    ;; int64 _parityErrorCount
    8
    ;; float32 _unfilteredSpeedUncertainty
    4
    ;; float32 _fineSpeedUncertainty
    4
    ;; float32 _azimuth
    4
    ;; float32 _unfilteredSpeed
    4
    ;; int32 _glonassFrequencyIndex
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _unfilteredTimeUncertainty
       (sys::poke _unfilteredTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _cycleSlipCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cycleSlipCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cycleSlipCount) (= (length (_cycleSlipCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cycleSlipCount . bv) 0) 0) s)
              (write-long (ash (elt (_cycleSlipCount . bv) 1) -1) s))
             ((and (class _cycleSlipCount) (= (length (_cycleSlipCount . bv)) 1)) ;; big1
              (write-long (elt (_cycleSlipCount . bv) 0) s)
              (write-long (if (>= _cycleSlipCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cycleSlipCount s)(write-long (if (>= _cycleSlipCount 0) 0 #xffffffff) s)))
     ;; int64 _unfilteredMeasurementIntegral
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _unfilteredMeasurementIntegral (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _unfilteredMeasurementIntegral) (= (length (_unfilteredMeasurementIntegral . bv)) 2)) ;; bignum
              (write-long (ash (elt (_unfilteredMeasurementIntegral . bv) 0) 0) s)
              (write-long (ash (elt (_unfilteredMeasurementIntegral . bv) 1) -1) s))
             ((and (class _unfilteredMeasurementIntegral) (= (length (_unfilteredMeasurementIntegral . bv)) 1)) ;; big1
              (write-long (elt (_unfilteredMeasurementIntegral . bv) 0) s)
              (write-long (if (>= _unfilteredMeasurementIntegral 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _unfilteredMeasurementIntegral s)(write-long (if (>= _unfilteredMeasurementIntegral 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/MeasurementStatus _measurementStatus
       (send _measurementStatus :serialize s)
     ;; float32 _filteredSpeedUncertainty
       (sys::poke _filteredSpeedUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _predetectInterval
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _predetectInterval (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _predetectInterval) (= (length (_predetectInterval . bv)) 2)) ;; bignum
              (write-long (ash (elt (_predetectInterval . bv) 0) 0) s)
              (write-long (ash (elt (_predetectInterval . bv) 1) -1) s))
             ((and (class _predetectInterval) (= (length (_predetectInterval . bv)) 1)) ;; big1
              (write-long (elt (_predetectInterval . bv) 0) s)
              (write-long (if (>= _predetectInterval 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _predetectInterval s)(write-long (if (>= _predetectInterval 0) 0 #xffffffff) s)))
     ;; float32 _unfilteredMeasurementFraction
       (sys::poke _unfilteredMeasurementFraction (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _filteredTimeUncertainty
       (sys::poke _filteredTimeUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _carrierNoise
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _carrierNoise (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _carrierNoise) (= (length (_carrierNoise . bv)) 2)) ;; bignum
              (write-long (ash (elt (_carrierNoise . bv) 0) 0) s)
              (write-long (ash (elt (_carrierNoise . bv) 1) -1) s))
             ((and (class _carrierNoise) (= (length (_carrierNoise . bv)) 1)) ;; big1
              (write-long (elt (_carrierNoise . bv) 0) s)
              (write-long (if (>= _carrierNoise 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _carrierNoise s)(write-long (if (>= _carrierNoise 0) 0 #xffffffff) s)))
     ;; int64 _postdetections
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _postdetections (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _postdetections) (= (length (_postdetections . bv)) 2)) ;; bignum
              (write-long (ash (elt (_postdetections . bv) 0) 0) s)
              (write-long (ash (elt (_postdetections . bv) 1) -1) s))
             ((and (class _postdetections) (= (length (_postdetections . bv)) 1)) ;; big1
              (write-long (elt (_postdetections . bv) 0) s)
              (write-long (if (>= _postdetections 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _postdetections s)(write-long (if (>= _postdetections 0) 0 #xffffffff) s)))
     ;; int32 _latency
       (write-long _latency s)
     ;; int64 _filterStages
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _filterStages (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _filterStages) (= (length (_filterStages . bv)) 2)) ;; bignum
              (write-long (ash (elt (_filterStages . bv) 0) 0) s)
              (write-long (ash (elt (_filterStages . bv) 1) -1) s))
             ((and (class _filterStages) (= (length (_filterStages . bv)) 1)) ;; big1
              (write-long (elt (_filterStages . bv) 0) s)
              (write-long (if (>= _filterStages 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _filterStages s)(write-long (if (>= _filterStages 0) 0 #xffffffff) s)))
     ;; int64 _multipathEstimate
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _multipathEstimate (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _multipathEstimate) (= (length (_multipathEstimate . bv)) 2)) ;; bignum
              (write-long (ash (elt (_multipathEstimate . bv) 0) 0) s)
              (write-long (ash (elt (_multipathEstimate . bv) 1) -1) s))
             ((and (class _multipathEstimate) (= (length (_multipathEstimate . bv)) 1)) ;; big1
              (write-long (elt (_multipathEstimate . bv) 0) s)
              (write-long (if (>= _multipathEstimate 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _multipathEstimate s)(write-long (if (>= _multipathEstimate 0) 0 #xffffffff) s)))
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
     ;; float32 _filteredMeasurementFraction
       (sys::poke _filteredMeasurementFraction (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; int64 _observations
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _observations (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _observations) (= (length (_observations . bv)) 2)) ;; bignum
              (write-long (ash (elt (_observations . bv) 0) 0) s)
              (write-long (ash (elt (_observations . bv) 1) -1) s))
             ((and (class _observations) (= (length (_observations . bv)) 1)) ;; big1
              (write-long (elt (_observations . bv) 0) s)
              (write-long (if (>= _observations 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _observations s)(write-long (if (>= _observations 0) 0 #xffffffff) s)))
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
     ;; float32 _dopplerAcceleration
       (sys::poke _dopplerAcceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _elevation
       (sys::poke _elevation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _filteredSpeed
       (sys::poke _filteredSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fineSpeed
       (sys::poke _fineSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _goodObservations
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _goodObservations (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _goodObservations) (= (length (_goodObservations . bv)) 2)) ;; bignum
              (write-long (ash (elt (_goodObservations . bv) 0) 0) s)
              (write-long (ash (elt (_goodObservations . bv) 1) -1) s))
             ((and (class _goodObservations) (= (length (_goodObservations . bv)) 1)) ;; big1
              (write-long (elt (_goodObservations . bv) 0) s)
              (write-long (if (>= _goodObservations 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _goodObservations s)(write-long (if (>= _goodObservations 0) 0 #xffffffff) s)))
     ;; uint32 _observationState
       (write-long _observationState s)
     ;; bool _goodParity
       (if _goodParity (write-byte -1 s) (write-byte 0 s))
     ;; float32 _carrierPhase
       (sys::poke _carrierPhase (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _filteredMeasurementIntegral
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _filteredMeasurementIntegral (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _filteredMeasurementIntegral) (= (length (_filteredMeasurementIntegral . bv)) 2)) ;; bignum
              (write-long (ash (elt (_filteredMeasurementIntegral . bv) 0) 0) s)
              (write-long (ash (elt (_filteredMeasurementIntegral . bv) 1) -1) s))
             ((and (class _filteredMeasurementIntegral) (= (length (_filteredMeasurementIntegral . bv)) 1)) ;; big1
              (write-long (elt (_filteredMeasurementIntegral . bv) 0) s)
              (write-long (if (>= _filteredMeasurementIntegral 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _filteredMeasurementIntegral s)(write-long (if (>= _filteredMeasurementIntegral 0) 0 #xffffffff) s)))
     ;; int64 _parityErrorCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _parityErrorCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _parityErrorCount) (= (length (_parityErrorCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_parityErrorCount . bv) 0) 0) s)
              (write-long (ash (elt (_parityErrorCount . bv) 1) -1) s))
             ((and (class _parityErrorCount) (= (length (_parityErrorCount . bv)) 1)) ;; big1
              (write-long (elt (_parityErrorCount . bv) 0) s)
              (write-long (if (>= _parityErrorCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _parityErrorCount s)(write-long (if (>= _parityErrorCount 0) 0 #xffffffff) s)))
     ;; float32 _unfilteredSpeedUncertainty
       (sys::poke _unfilteredSpeedUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fineSpeedUncertainty
       (sys::poke _fineSpeedUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _azimuth
       (sys::poke _azimuth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _unfilteredSpeed
       (sys::poke _unfilteredSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _glonassFrequencyIndex
       (write-long _glonassFrequencyIndex s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _unfilteredTimeUncertainty
     (setq _unfilteredTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _cycleSlipCount
#+(or :alpha :irix6 :x86_64)
      (setf _cycleSlipCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cycleSlipCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _unfilteredMeasurementIntegral
#+(or :alpha :irix6 :x86_64)
      (setf _unfilteredMeasurementIntegral (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _unfilteredMeasurementIntegral (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/MeasurementStatus _measurementStatus
     (send _measurementStatus :deserialize buf ptr-) (incf ptr- (send _measurementStatus :serialization-length))
   ;; float32 _filteredSpeedUncertainty
     (setq _filteredSpeedUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _predetectInterval
#+(or :alpha :irix6 :x86_64)
      (setf _predetectInterval (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _predetectInterval (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _unfilteredMeasurementFraction
     (setq _unfilteredMeasurementFraction (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _filteredTimeUncertainty
     (setq _filteredTimeUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _carrierNoise
#+(or :alpha :irix6 :x86_64)
      (setf _carrierNoise (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _carrierNoise (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _postdetections
#+(or :alpha :irix6 :x86_64)
      (setf _postdetections (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _postdetections (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _latency
     (setq _latency (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _filterStages
#+(or :alpha :irix6 :x86_64)
      (setf _filterStages (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _filterStages (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _multipathEstimate
#+(or :alpha :irix6 :x86_64)
      (setf _multipathEstimate (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _multipathEstimate (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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
   ;; float32 _filteredMeasurementFraction
     (setq _filteredMeasurementFraction (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; int64 _observations
#+(or :alpha :irix6 :x86_64)
      (setf _observations (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _observations (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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
   ;; float32 _dopplerAcceleration
     (setq _dopplerAcceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _elevation
     (setq _elevation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _filteredSpeed
     (setq _filteredSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fineSpeed
     (setq _fineSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _goodObservations
#+(or :alpha :irix6 :x86_64)
      (setf _goodObservations (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _goodObservations (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _observationState
     (setq _observationState (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _goodParity
     (setq _goodParity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _carrierPhase
     (setq _carrierPhase (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _filteredMeasurementIntegral
#+(or :alpha :irix6 :x86_64)
      (setf _filteredMeasurementIntegral (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _filteredMeasurementIntegral (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _parityErrorCount
#+(or :alpha :irix6 :x86_64)
      (setf _parityErrorCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _parityErrorCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _unfilteredSpeedUncertainty
     (setq _unfilteredSpeedUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fineSpeedUncertainty
     (setq _fineSpeedUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _azimuth
     (setq _azimuth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _unfilteredSpeed
     (setq _unfilteredSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _glonassFrequencyIndex
     (setq _glonassFrequencyIndex (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::SV :md5sum-) "c2b444a1bc5918386f94442af6fb62e1")
(setf (get openpilot_bridge::SV :datatype-) "openpilot_bridge/SV")
(setf (get openpilot_bridge::SV :definition-)
      "Header header

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



(provide :openpilot_bridge/SV "c2b444a1bc5918386f94442af6fb62e1")


