; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude DrMeasurementReport.msg.html

(cl:defclass <DrMeasurementReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gpsToGlonassTimeBiasMilliseconds
    :reader gpsToGlonassTimeBiasMilliseconds
    :initarg :gpsToGlonassTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (gpsMilliseconds
    :reader gpsMilliseconds
    :initarg :gpsMilliseconds
    :type cl:integer
    :initform 0)
   (seqMax
    :reader seqMax
    :initarg :seqMax
    :type cl:integer
    :initform 0)
   (gpsClockTimeUncertaintyMs
    :reader gpsClockTimeUncertaintyMs
    :initarg :gpsClockTimeUncertaintyMs
    :type cl:integer
    :initform 0)
   (glonassClockSource
    :reader glonassClockSource
    :initarg :glonassClockSource
    :type cl:integer
    :initform 0)
   (glonassTimeBias
    :reader glonassTimeBias
    :initarg :glonassTimeBias
    :type cl:float
    :initform 0.0)
   (gpsClockSource
    :reader gpsClockSource
    :initarg :gpsClockSource
    :type cl:integer
    :initform 0)
   (clockFrequencyBias
    :reader clockFrequencyBias
    :initarg :clockFrequencyBias
    :type cl:float
    :initform 0.0)
   (source
    :reader source
    :initarg :source
    :type cl:integer
    :initform 0)
   (rfLoss
    :reader rfLoss
    :initarg :rfLoss
    :type cl:integer
    :initform 0)
   (fCount
    :reader fCount
    :initarg :fCount
    :type cl:integer
    :initform 0)
   (gpsTimeBiasMs
    :reader gpsTimeBiasMs
    :initarg :gpsTimeBiasMs
    :type cl:integer
    :initform 0)
   (clockFrequencyUncertainty
    :reader clockFrequencyUncertainty
    :initarg :clockFrequencyUncertainty
    :type cl:float
    :initform 0.0)
   (systemRtcTime
    :reader systemRtcTime
    :initarg :systemRtcTime
    :type cl:integer
    :initform 0)
   (seqNum
    :reader seqNum
    :initarg :seqNum
    :type cl:integer
    :initform 0)
   (frequencySource
    :reader frequencySource
    :initarg :frequencySource
    :type cl:integer
    :initform 0)
   (glonassDay
    :reader glonassDay
    :initarg :glonassDay
    :type cl:integer
    :initform 0)
   (reason
    :reader reason
    :initarg :reason
    :type cl:integer
    :initform 0)
   (glonassMilliseconds
    :reader glonassMilliseconds
    :initarg :glonassMilliseconds
    :type cl:integer
    :initform 0)
   (clockResets
    :reader clockResets
    :initarg :clockResets
    :type cl:integer
    :initform 0)
   (sv
    :reader sv
    :initarg :sv
    :type (cl:vector openpilot_bridge-msg:SV)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:SV :initial-element (cl:make-instance 'openpilot_bridge-msg:SV)))
   (gpsLeapSeconds
    :reader gpsLeapSeconds
    :initarg :gpsLeapSeconds
    :type cl:integer
    :initform 0)
   (glonassClockTimeUncertainty
    :reader glonassClockTimeUncertainty
    :initarg :glonassClockTimeUncertainty
    :type cl:float
    :initform 0.0)
   (gpsWeek
    :reader gpsWeek
    :initarg :gpsWeek
    :type cl:integer
    :initform 0)
   (systemRtcValid
    :reader systemRtcValid
    :initarg :systemRtcValid
    :type cl:boolean
    :initform cl:nil)
   (gpsToGlonassTimeBiasMillisecondsUncertainty
    :reader gpsToGlonassTimeBiasMillisecondsUncertainty
    :initarg :gpsToGlonassTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (glonassYear
    :reader glonassYear
    :initarg :glonassYear
    :type cl:integer
    :initform 0)
   (gpsLeapSecondsUncertainty
    :reader gpsLeapSecondsUncertainty
    :initarg :gpsLeapSecondsUncertainty
    :type cl:integer
    :initform 0))
)

(cl:defclass DrMeasurementReport (<DrMeasurementReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DrMeasurementReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DrMeasurementReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<DrMeasurementReport> is deprecated: use openpilot_bridge-msg:DrMeasurementReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gpsToGlonassTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsToGlonassTimeBiasMilliseconds-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGlonassTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsToGlonassTimeBiasMilliseconds instead.")
  (gpsToGlonassTimeBiasMilliseconds m))

(cl:ensure-generic-function 'gpsMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsMilliseconds-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsMilliseconds instead.")
  (gpsMilliseconds m))

(cl:ensure-generic-function 'seqMax-val :lambda-list '(m))
(cl:defmethod seqMax-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:seqMax-val is deprecated.  Use openpilot_bridge-msg:seqMax instead.")
  (seqMax m))

(cl:ensure-generic-function 'gpsClockTimeUncertaintyMs-val :lambda-list '(m))
(cl:defmethod gpsClockTimeUncertaintyMs-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsClockTimeUncertaintyMs-val is deprecated.  Use openpilot_bridge-msg:gpsClockTimeUncertaintyMs instead.")
  (gpsClockTimeUncertaintyMs m))

(cl:ensure-generic-function 'glonassClockSource-val :lambda-list '(m))
(cl:defmethod glonassClockSource-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassClockSource-val is deprecated.  Use openpilot_bridge-msg:glonassClockSource instead.")
  (glonassClockSource m))

(cl:ensure-generic-function 'glonassTimeBias-val :lambda-list '(m))
(cl:defmethod glonassTimeBias-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassTimeBias-val is deprecated.  Use openpilot_bridge-msg:glonassTimeBias instead.")
  (glonassTimeBias m))

(cl:ensure-generic-function 'gpsClockSource-val :lambda-list '(m))
(cl:defmethod gpsClockSource-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsClockSource-val is deprecated.  Use openpilot_bridge-msg:gpsClockSource instead.")
  (gpsClockSource m))

(cl:ensure-generic-function 'clockFrequencyBias-val :lambda-list '(m))
(cl:defmethod clockFrequencyBias-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockFrequencyBias-val is deprecated.  Use openpilot_bridge-msg:clockFrequencyBias instead.")
  (clockFrequencyBias m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:source-val is deprecated.  Use openpilot_bridge-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'rfLoss-val :lambda-list '(m))
(cl:defmethod rfLoss-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rfLoss-val is deprecated.  Use openpilot_bridge-msg:rfLoss instead.")
  (rfLoss m))

(cl:ensure-generic-function 'fCount-val :lambda-list '(m))
(cl:defmethod fCount-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fCount-val is deprecated.  Use openpilot_bridge-msg:fCount instead.")
  (fCount m))

(cl:ensure-generic-function 'gpsTimeBiasMs-val :lambda-list '(m))
(cl:defmethod gpsTimeBiasMs-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsTimeBiasMs-val is deprecated.  Use openpilot_bridge-msg:gpsTimeBiasMs instead.")
  (gpsTimeBiasMs m))

(cl:ensure-generic-function 'clockFrequencyUncertainty-val :lambda-list '(m))
(cl:defmethod clockFrequencyUncertainty-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockFrequencyUncertainty-val is deprecated.  Use openpilot_bridge-msg:clockFrequencyUncertainty instead.")
  (clockFrequencyUncertainty m))

(cl:ensure-generic-function 'systemRtcTime-val :lambda-list '(m))
(cl:defmethod systemRtcTime-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:systemRtcTime-val is deprecated.  Use openpilot_bridge-msg:systemRtcTime instead.")
  (systemRtcTime m))

(cl:ensure-generic-function 'seqNum-val :lambda-list '(m))
(cl:defmethod seqNum-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:seqNum-val is deprecated.  Use openpilot_bridge-msg:seqNum instead.")
  (seqNum m))

(cl:ensure-generic-function 'frequencySource-val :lambda-list '(m))
(cl:defmethod frequencySource-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frequencySource-val is deprecated.  Use openpilot_bridge-msg:frequencySource instead.")
  (frequencySource m))

(cl:ensure-generic-function 'glonassDay-val :lambda-list '(m))
(cl:defmethod glonassDay-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassDay-val is deprecated.  Use openpilot_bridge-msg:glonassDay instead.")
  (glonassDay m))

(cl:ensure-generic-function 'reason-val :lambda-list '(m))
(cl:defmethod reason-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:reason-val is deprecated.  Use openpilot_bridge-msg:reason instead.")
  (reason m))

(cl:ensure-generic-function 'glonassMilliseconds-val :lambda-list '(m))
(cl:defmethod glonassMilliseconds-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassMilliseconds-val is deprecated.  Use openpilot_bridge-msg:glonassMilliseconds instead.")
  (glonassMilliseconds m))

(cl:ensure-generic-function 'clockResets-val :lambda-list '(m))
(cl:defmethod clockResets-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockResets-val is deprecated.  Use openpilot_bridge-msg:clockResets instead.")
  (clockResets m))

(cl:ensure-generic-function 'sv-val :lambda-list '(m))
(cl:defmethod sv-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sv-val is deprecated.  Use openpilot_bridge-msg:sv instead.")
  (sv m))

(cl:ensure-generic-function 'gpsLeapSeconds-val :lambda-list '(m))
(cl:defmethod gpsLeapSeconds-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLeapSeconds-val is deprecated.  Use openpilot_bridge-msg:gpsLeapSeconds instead.")
  (gpsLeapSeconds m))

(cl:ensure-generic-function 'glonassClockTimeUncertainty-val :lambda-list '(m))
(cl:defmethod glonassClockTimeUncertainty-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassClockTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:glonassClockTimeUncertainty instead.")
  (glonassClockTimeUncertainty m))

(cl:ensure-generic-function 'gpsWeek-val :lambda-list '(m))
(cl:defmethod gpsWeek-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsWeek-val is deprecated.  Use openpilot_bridge-msg:gpsWeek instead.")
  (gpsWeek m))

(cl:ensure-generic-function 'systemRtcValid-val :lambda-list '(m))
(cl:defmethod systemRtcValid-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:systemRtcValid-val is deprecated.  Use openpilot_bridge-msg:systemRtcValid instead.")
  (systemRtcValid m))

(cl:ensure-generic-function 'gpsToGlonassTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsToGlonassTimeBiasMillisecondsUncertainty-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGlonassTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsToGlonassTimeBiasMillisecondsUncertainty instead.")
  (gpsToGlonassTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'glonassYear-val :lambda-list '(m))
(cl:defmethod glonassYear-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassYear-val is deprecated.  Use openpilot_bridge-msg:glonassYear instead.")
  (glonassYear m))

(cl:ensure-generic-function 'gpsLeapSecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsLeapSecondsUncertainty-val ((m <DrMeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLeapSecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsLeapSecondsUncertainty instead.")
  (gpsLeapSecondsUncertainty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DrMeasurementReport>) ostream)
  "Serializes a message object of type '<DrMeasurementReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGlonassTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'gpsMilliseconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'seqMax)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gpsClockTimeUncertaintyMs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'glonassClockSource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'glonassTimeBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'gpsClockSource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'clockFrequencyBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source)) ostream)
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
  (cl:let* ((signed (cl:slot-value msg 'gpsTimeBiasMs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'clockFrequencyUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'systemRtcTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'seqNum)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'frequencySource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'glonassDay)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'reason)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'glonassMilliseconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'clockResets)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sv))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'sv))
  (cl:let* ((signed (cl:slot-value msg 'gpsLeapSeconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'glonassClockTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'gpsWeek)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'systemRtcValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGlonassTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'glonassYear)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gpsLeapSecondsUncertainty)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DrMeasurementReport>) istream)
  "Deserializes a message object of type '<DrMeasurementReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToGlonassTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsMilliseconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'seqMax) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsClockTimeUncertaintyMs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'glonassClockSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'glonassTimeBias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsClockSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'clockFrequencyBias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source)) (cl:read-byte istream))
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
      (cl:setf (cl:slot-value msg 'fCount) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsTimeBiasMs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'clockFrequencyUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'systemRtcTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'seqNum) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frequencySource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'glonassDay) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'reason) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'glonassMilliseconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'clockResets) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sv) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sv)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:SV))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsLeapSeconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'glonassClockTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsWeek) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'systemRtcValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToGlonassTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'glonassYear) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsLeapSecondsUncertainty) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DrMeasurementReport>)))
  "Returns string type for a message object of type '<DrMeasurementReport>"
  "openpilot_bridge/DrMeasurementReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DrMeasurementReport)))
  "Returns string type for a message object of type 'DrMeasurementReport"
  "openpilot_bridge/DrMeasurementReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DrMeasurementReport>)))
  "Returns md5sum for a message object of type '<DrMeasurementReport>"
  "16e006938fe71bd40015db11503053ce")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DrMeasurementReport)))
  "Returns md5sum for a message object of type 'DrMeasurementReport"
  "16e006938fe71bd40015db11503053ce")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DrMeasurementReport>)))
  "Returns full string definition for message of type '<DrMeasurementReport>"
  (cl:format cl:nil "Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DrMeasurementReport)))
  "Returns full string definition for message of type 'DrMeasurementReport"
  (cl:format cl:nil "Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DrMeasurementReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     8
     8
     8
     8
     4
     8
     4
     4
     8
     8
     8
     4
     8
     8
     8
     8
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sv) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     8
     4
     8
     1
     4
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DrMeasurementReport>))
  "Converts a ROS message object to a list"
  (cl:list 'DrMeasurementReport
    (cl:cons ':header (header msg))
    (cl:cons ':gpsToGlonassTimeBiasMilliseconds (gpsToGlonassTimeBiasMilliseconds msg))
    (cl:cons ':gpsMilliseconds (gpsMilliseconds msg))
    (cl:cons ':seqMax (seqMax msg))
    (cl:cons ':gpsClockTimeUncertaintyMs (gpsClockTimeUncertaintyMs msg))
    (cl:cons ':glonassClockSource (glonassClockSource msg))
    (cl:cons ':glonassTimeBias (glonassTimeBias msg))
    (cl:cons ':gpsClockSource (gpsClockSource msg))
    (cl:cons ':clockFrequencyBias (clockFrequencyBias msg))
    (cl:cons ':source (source msg))
    (cl:cons ':rfLoss (rfLoss msg))
    (cl:cons ':fCount (fCount msg))
    (cl:cons ':gpsTimeBiasMs (gpsTimeBiasMs msg))
    (cl:cons ':clockFrequencyUncertainty (clockFrequencyUncertainty msg))
    (cl:cons ':systemRtcTime (systemRtcTime msg))
    (cl:cons ':seqNum (seqNum msg))
    (cl:cons ':frequencySource (frequencySource msg))
    (cl:cons ':glonassDay (glonassDay msg))
    (cl:cons ':reason (reason msg))
    (cl:cons ':glonassMilliseconds (glonassMilliseconds msg))
    (cl:cons ':clockResets (clockResets msg))
    (cl:cons ':sv (sv msg))
    (cl:cons ':gpsLeapSeconds (gpsLeapSeconds msg))
    (cl:cons ':glonassClockTimeUncertainty (glonassClockTimeUncertainty msg))
    (cl:cons ':gpsWeek (gpsWeek msg))
    (cl:cons ':systemRtcValid (systemRtcValid msg))
    (cl:cons ':gpsToGlonassTimeBiasMillisecondsUncertainty (gpsToGlonassTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':glonassYear (glonassYear msg))
    (cl:cons ':gpsLeapSecondsUncertainty (gpsLeapSecondsUncertainty msg))
))
