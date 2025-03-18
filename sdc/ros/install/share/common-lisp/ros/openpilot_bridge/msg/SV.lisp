; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SV.msg.html

(cl:defclass <SV> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (unfilteredTimeUncertainty
    :reader unfilteredTimeUncertainty
    :initarg :unfilteredTimeUncertainty
    :type cl:float
    :initform 0.0)
   (cycleSlipCount
    :reader cycleSlipCount
    :initarg :cycleSlipCount
    :type cl:integer
    :initform 0)
   (unfilteredMeasurementIntegral
    :reader unfilteredMeasurementIntegral
    :initarg :unfilteredMeasurementIntegral
    :type cl:integer
    :initform 0)
   (measurementStatus
    :reader measurementStatus
    :initarg :measurementStatus
    :type openpilot_bridge-msg:MeasurementStatus
    :initform (cl:make-instance 'openpilot_bridge-msg:MeasurementStatus))
   (filteredSpeedUncertainty
    :reader filteredSpeedUncertainty
    :initarg :filteredSpeedUncertainty
    :type cl:float
    :initform 0.0)
   (predetectInterval
    :reader predetectInterval
    :initarg :predetectInterval
    :type cl:integer
    :initform 0)
   (unfilteredMeasurementFraction
    :reader unfilteredMeasurementFraction
    :initarg :unfilteredMeasurementFraction
    :type cl:float
    :initform 0.0)
   (filteredTimeUncertainty
    :reader filteredTimeUncertainty
    :initarg :filteredTimeUncertainty
    :type cl:float
    :initform 0.0)
   (carrierNoise
    :reader carrierNoise
    :initarg :carrierNoise
    :type cl:integer
    :initform 0)
   (postdetections
    :reader postdetections
    :initarg :postdetections
    :type cl:integer
    :initform 0)
   (latency
    :reader latency
    :initarg :latency
    :type cl:integer
    :initform 0)
   (filterStages
    :reader filterStages
    :initarg :filterStages
    :type cl:integer
    :initform 0)
   (multipathEstimate
    :reader multipathEstimate
    :initarg :multipathEstimate
    :type cl:integer
    :initform 0)
   (svId
    :reader svId
    :initarg :svId
    :type cl:integer
    :initform 0)
   (filteredMeasurementFraction
    :reader filteredMeasurementFraction
    :initarg :filteredMeasurementFraction
    :type cl:float
    :initform 0.0)
   (rfLoss
    :reader rfLoss
    :initarg :rfLoss
    :type cl:integer
    :initform 0)
   (observations
    :reader observations
    :initarg :observations
    :type cl:integer
    :initform 0)
   (fCount
    :reader fCount
    :initarg :fCount
    :type cl:integer
    :initform 0)
   (dopplerAcceleration
    :reader dopplerAcceleration
    :initarg :dopplerAcceleration
    :type cl:float
    :initform 0.0)
   (elevation
    :reader elevation
    :initarg :elevation
    :type cl:float
    :initform 0.0)
   (filteredSpeed
    :reader filteredSpeed
    :initarg :filteredSpeed
    :type cl:float
    :initform 0.0)
   (fineSpeed
    :reader fineSpeed
    :initarg :fineSpeed
    :type cl:float
    :initform 0.0)
   (goodObservations
    :reader goodObservations
    :initarg :goodObservations
    :type cl:integer
    :initform 0)
   (observationState
    :reader observationState
    :initarg :observationState
    :type cl:integer
    :initform 0)
   (goodParity
    :reader goodParity
    :initarg :goodParity
    :type cl:boolean
    :initform cl:nil)
   (carrierPhase
    :reader carrierPhase
    :initarg :carrierPhase
    :type cl:float
    :initform 0.0)
   (filteredMeasurementIntegral
    :reader filteredMeasurementIntegral
    :initarg :filteredMeasurementIntegral
    :type cl:integer
    :initform 0)
   (parityErrorCount
    :reader parityErrorCount
    :initarg :parityErrorCount
    :type cl:integer
    :initform 0)
   (unfilteredSpeedUncertainty
    :reader unfilteredSpeedUncertainty
    :initarg :unfilteredSpeedUncertainty
    :type cl:float
    :initform 0.0)
   (fineSpeedUncertainty
    :reader fineSpeedUncertainty
    :initarg :fineSpeedUncertainty
    :type cl:float
    :initform 0.0)
   (azimuth
    :reader azimuth
    :initarg :azimuth
    :type cl:float
    :initform 0.0)
   (unfilteredSpeed
    :reader unfilteredSpeed
    :initarg :unfilteredSpeed
    :type cl:float
    :initform 0.0)
   (glonassFrequencyIndex
    :reader glonassFrequencyIndex
    :initarg :glonassFrequencyIndex
    :type cl:integer
    :initform 0))
)

(cl:defclass SV (<SV>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SV>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SV)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SV> is deprecated: use openpilot_bridge-msg:SV instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'unfilteredTimeUncertainty-val :lambda-list '(m))
(cl:defmethod unfilteredTimeUncertainty-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:unfilteredTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:unfilteredTimeUncertainty instead.")
  (unfilteredTimeUncertainty m))

(cl:ensure-generic-function 'cycleSlipCount-val :lambda-list '(m))
(cl:defmethod cycleSlipCount-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cycleSlipCount-val is deprecated.  Use openpilot_bridge-msg:cycleSlipCount instead.")
  (cycleSlipCount m))

(cl:ensure-generic-function 'unfilteredMeasurementIntegral-val :lambda-list '(m))
(cl:defmethod unfilteredMeasurementIntegral-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:unfilteredMeasurementIntegral-val is deprecated.  Use openpilot_bridge-msg:unfilteredMeasurementIntegral instead.")
  (unfilteredMeasurementIntegral m))

(cl:ensure-generic-function 'measurementStatus-val :lambda-list '(m))
(cl:defmethod measurementStatus-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurementStatus-val is deprecated.  Use openpilot_bridge-msg:measurementStatus instead.")
  (measurementStatus m))

(cl:ensure-generic-function 'filteredSpeedUncertainty-val :lambda-list '(m))
(cl:defmethod filteredSpeedUncertainty-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filteredSpeedUncertainty-val is deprecated.  Use openpilot_bridge-msg:filteredSpeedUncertainty instead.")
  (filteredSpeedUncertainty m))

(cl:ensure-generic-function 'predetectInterval-val :lambda-list '(m))
(cl:defmethod predetectInterval-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:predetectInterval-val is deprecated.  Use openpilot_bridge-msg:predetectInterval instead.")
  (predetectInterval m))

(cl:ensure-generic-function 'unfilteredMeasurementFraction-val :lambda-list '(m))
(cl:defmethod unfilteredMeasurementFraction-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:unfilteredMeasurementFraction-val is deprecated.  Use openpilot_bridge-msg:unfilteredMeasurementFraction instead.")
  (unfilteredMeasurementFraction m))

(cl:ensure-generic-function 'filteredTimeUncertainty-val :lambda-list '(m))
(cl:defmethod filteredTimeUncertainty-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filteredTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:filteredTimeUncertainty instead.")
  (filteredTimeUncertainty m))

(cl:ensure-generic-function 'carrierNoise-val :lambda-list '(m))
(cl:defmethod carrierNoise-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carrierNoise-val is deprecated.  Use openpilot_bridge-msg:carrierNoise instead.")
  (carrierNoise m))

(cl:ensure-generic-function 'postdetections-val :lambda-list '(m))
(cl:defmethod postdetections-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:postdetections-val is deprecated.  Use openpilot_bridge-msg:postdetections instead.")
  (postdetections m))

(cl:ensure-generic-function 'latency-val :lambda-list '(m))
(cl:defmethod latency-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:latency-val is deprecated.  Use openpilot_bridge-msg:latency instead.")
  (latency m))

(cl:ensure-generic-function 'filterStages-val :lambda-list '(m))
(cl:defmethod filterStages-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filterStages-val is deprecated.  Use openpilot_bridge-msg:filterStages instead.")
  (filterStages m))

(cl:ensure-generic-function 'multipathEstimate-val :lambda-list '(m))
(cl:defmethod multipathEstimate-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:multipathEstimate-val is deprecated.  Use openpilot_bridge-msg:multipathEstimate instead.")
  (multipathEstimate m))

(cl:ensure-generic-function 'svId-val :lambda-list '(m))
(cl:defmethod svId-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:svId-val is deprecated.  Use openpilot_bridge-msg:svId instead.")
  (svId m))

(cl:ensure-generic-function 'filteredMeasurementFraction-val :lambda-list '(m))
(cl:defmethod filteredMeasurementFraction-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filteredMeasurementFraction-val is deprecated.  Use openpilot_bridge-msg:filteredMeasurementFraction instead.")
  (filteredMeasurementFraction m))

(cl:ensure-generic-function 'rfLoss-val :lambda-list '(m))
(cl:defmethod rfLoss-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rfLoss-val is deprecated.  Use openpilot_bridge-msg:rfLoss instead.")
  (rfLoss m))

(cl:ensure-generic-function 'observations-val :lambda-list '(m))
(cl:defmethod observations-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:observations-val is deprecated.  Use openpilot_bridge-msg:observations instead.")
  (observations m))

(cl:ensure-generic-function 'fCount-val :lambda-list '(m))
(cl:defmethod fCount-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fCount-val is deprecated.  Use openpilot_bridge-msg:fCount instead.")
  (fCount m))

(cl:ensure-generic-function 'dopplerAcceleration-val :lambda-list '(m))
(cl:defmethod dopplerAcceleration-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dopplerAcceleration-val is deprecated.  Use openpilot_bridge-msg:dopplerAcceleration instead.")
  (dopplerAcceleration m))

(cl:ensure-generic-function 'elevation-val :lambda-list '(m))
(cl:defmethod elevation-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:elevation-val is deprecated.  Use openpilot_bridge-msg:elevation instead.")
  (elevation m))

(cl:ensure-generic-function 'filteredSpeed-val :lambda-list '(m))
(cl:defmethod filteredSpeed-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filteredSpeed-val is deprecated.  Use openpilot_bridge-msg:filteredSpeed instead.")
  (filteredSpeed m))

(cl:ensure-generic-function 'fineSpeed-val :lambda-list '(m))
(cl:defmethod fineSpeed-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fineSpeed-val is deprecated.  Use openpilot_bridge-msg:fineSpeed instead.")
  (fineSpeed m))

(cl:ensure-generic-function 'goodObservations-val :lambda-list '(m))
(cl:defmethod goodObservations-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:goodObservations-val is deprecated.  Use openpilot_bridge-msg:goodObservations instead.")
  (goodObservations m))

(cl:ensure-generic-function 'observationState-val :lambda-list '(m))
(cl:defmethod observationState-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:observationState-val is deprecated.  Use openpilot_bridge-msg:observationState instead.")
  (observationState m))

(cl:ensure-generic-function 'goodParity-val :lambda-list '(m))
(cl:defmethod goodParity-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:goodParity-val is deprecated.  Use openpilot_bridge-msg:goodParity instead.")
  (goodParity m))

(cl:ensure-generic-function 'carrierPhase-val :lambda-list '(m))
(cl:defmethod carrierPhase-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:carrierPhase-val is deprecated.  Use openpilot_bridge-msg:carrierPhase instead.")
  (carrierPhase m))

(cl:ensure-generic-function 'filteredMeasurementIntegral-val :lambda-list '(m))
(cl:defmethod filteredMeasurementIntegral-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:filteredMeasurementIntegral-val is deprecated.  Use openpilot_bridge-msg:filteredMeasurementIntegral instead.")
  (filteredMeasurementIntegral m))

(cl:ensure-generic-function 'parityErrorCount-val :lambda-list '(m))
(cl:defmethod parityErrorCount-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:parityErrorCount-val is deprecated.  Use openpilot_bridge-msg:parityErrorCount instead.")
  (parityErrorCount m))

(cl:ensure-generic-function 'unfilteredSpeedUncertainty-val :lambda-list '(m))
(cl:defmethod unfilteredSpeedUncertainty-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:unfilteredSpeedUncertainty-val is deprecated.  Use openpilot_bridge-msg:unfilteredSpeedUncertainty instead.")
  (unfilteredSpeedUncertainty m))

(cl:ensure-generic-function 'fineSpeedUncertainty-val :lambda-list '(m))
(cl:defmethod fineSpeedUncertainty-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fineSpeedUncertainty-val is deprecated.  Use openpilot_bridge-msg:fineSpeedUncertainty instead.")
  (fineSpeedUncertainty m))

(cl:ensure-generic-function 'azimuth-val :lambda-list '(m))
(cl:defmethod azimuth-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:azimuth-val is deprecated.  Use openpilot_bridge-msg:azimuth instead.")
  (azimuth m))

(cl:ensure-generic-function 'unfilteredSpeed-val :lambda-list '(m))
(cl:defmethod unfilteredSpeed-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:unfilteredSpeed-val is deprecated.  Use openpilot_bridge-msg:unfilteredSpeed instead.")
  (unfilteredSpeed m))

(cl:ensure-generic-function 'glonassFrequencyIndex-val :lambda-list '(m))
(cl:defmethod glonassFrequencyIndex-val ((m <SV>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassFrequencyIndex-val is deprecated.  Use openpilot_bridge-msg:glonassFrequencyIndex instead.")
  (glonassFrequencyIndex m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SV>) ostream)
  "Serializes a message object of type '<SV>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'unfilteredTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'cycleSlipCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'unfilteredMeasurementIntegral)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measurementStatus) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'filteredSpeedUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'predetectInterval)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'unfilteredMeasurementFraction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'filteredTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'carrierNoise)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'postdetections)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'latency)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'filterStages)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'multipathEstimate)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'svId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'filteredMeasurementFraction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'rfLoss)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'observations)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'fCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dopplerAcceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'elevation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'filteredSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fineSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'goodObservations)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'observationState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'observationState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'observationState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'observationState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'goodParity) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'carrierPhase))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'filteredMeasurementIntegral)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'parityErrorCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'unfilteredSpeedUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fineSpeedUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'azimuth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'unfilteredSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'glonassFrequencyIndex)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SV>) istream)
  "Deserializes a message object of type '<SV>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'unfilteredTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'cycleSlipCount) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'unfilteredMeasurementIntegral) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measurementStatus) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'filteredSpeedUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'predetectInterval) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'unfilteredMeasurementFraction) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'filteredTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'carrierNoise) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'postdetections) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'latency) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filterStages) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'multipathEstimate) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'svId) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'filteredMeasurementFraction) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rfLoss) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'observations) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'fCount) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dopplerAcceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'elevation) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'filteredSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fineSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'goodObservations) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'observationState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'observationState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'observationState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'observationState)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'goodParity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'carrierPhase) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filteredMeasurementIntegral) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parityErrorCount) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'unfilteredSpeedUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fineSpeedUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'azimuth) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'unfilteredSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'glonassFrequencyIndex) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SV>)))
  "Returns string type for a message object of type '<SV>"
  "openpilot_bridge/SV")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SV)))
  "Returns string type for a message object of type 'SV"
  "openpilot_bridge/SV")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SV>)))
  "Returns md5sum for a message object of type '<SV>"
  "c2b444a1bc5918386f94442af6fb62e1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SV)))
  "Returns md5sum for a message object of type 'SV"
  "c2b444a1bc5918386f94442af6fb62e1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SV>)))
  "Returns full string definition for message of type '<SV>"
  (cl:format cl:nil "Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SV)))
  "Returns full string definition for message of type 'SV"
  (cl:format cl:nil "Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SV>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     8
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measurementStatus))
     4
     8
     4
     4
     8
     8
     4
     8
     8
     8
     4
     8
     8
     8
     4
     4
     4
     4
     8
     4
     1
     4
     8
     8
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SV>))
  "Converts a ROS message object to a list"
  (cl:list 'SV
    (cl:cons ':header (header msg))
    (cl:cons ':unfilteredTimeUncertainty (unfilteredTimeUncertainty msg))
    (cl:cons ':cycleSlipCount (cycleSlipCount msg))
    (cl:cons ':unfilteredMeasurementIntegral (unfilteredMeasurementIntegral msg))
    (cl:cons ':measurementStatus (measurementStatus msg))
    (cl:cons ':filteredSpeedUncertainty (filteredSpeedUncertainty msg))
    (cl:cons ':predetectInterval (predetectInterval msg))
    (cl:cons ':unfilteredMeasurementFraction (unfilteredMeasurementFraction msg))
    (cl:cons ':filteredTimeUncertainty (filteredTimeUncertainty msg))
    (cl:cons ':carrierNoise (carrierNoise msg))
    (cl:cons ':postdetections (postdetections msg))
    (cl:cons ':latency (latency msg))
    (cl:cons ':filterStages (filterStages msg))
    (cl:cons ':multipathEstimate (multipathEstimate msg))
    (cl:cons ':svId (svId msg))
    (cl:cons ':filteredMeasurementFraction (filteredMeasurementFraction msg))
    (cl:cons ':rfLoss (rfLoss msg))
    (cl:cons ':observations (observations msg))
    (cl:cons ':fCount (fCount msg))
    (cl:cons ':dopplerAcceleration (dopplerAcceleration msg))
    (cl:cons ':elevation (elevation msg))
    (cl:cons ':filteredSpeed (filteredSpeed msg))
    (cl:cons ':fineSpeed (fineSpeed msg))
    (cl:cons ':goodObservations (goodObservations msg))
    (cl:cons ':observationState (observationState msg))
    (cl:cons ':goodParity (goodParity msg))
    (cl:cons ':carrierPhase (carrierPhase msg))
    (cl:cons ':filteredMeasurementIntegral (filteredMeasurementIntegral msg))
    (cl:cons ':parityErrorCount (parityErrorCount msg))
    (cl:cons ':unfilteredSpeedUncertainty (unfilteredSpeedUncertainty msg))
    (cl:cons ':fineSpeedUncertainty (fineSpeedUncertainty msg))
    (cl:cons ':azimuth (azimuth msg))
    (cl:cons ':unfilteredSpeed (unfilteredSpeed msg))
    (cl:cons ':glonassFrequencyIndex (glonassFrequencyIndex msg))
))
