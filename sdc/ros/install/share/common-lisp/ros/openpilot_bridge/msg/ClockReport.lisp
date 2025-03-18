; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ClockReport.msg.html

(cl:defclass <ClockReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (galToBdsTimeBiasMillisecondsUncertainty
    :reader galToBdsTimeBiasMillisecondsUncertainty
    :initarg :galToBdsTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (hasFCount
    :reader hasFCount
    :initarg :hasFCount
    :type cl:boolean
    :initform cl:nil)
   (bdsClockSource
    :reader bdsClockSource
    :initarg :bdsClockSource
    :type cl:integer
    :initform 0)
   (clockFrequencyUncertainty
    :reader clockFrequencyUncertainty
    :initarg :clockFrequencyUncertainty
    :type cl:float
    :initform 0.0)
   (gpsMilliseconds
    :reader gpsMilliseconds
    :initarg :gpsMilliseconds
    :type cl:integer
    :initform 0)
   (hasGpsWeek
    :reader hasGpsWeek
    :initarg :hasGpsWeek
    :type cl:boolean
    :initform cl:nil)
   (gpsToGlonassTimeBiasMilliseconds
    :reader gpsToGlonassTimeBiasMilliseconds
    :initarg :gpsToGlonassTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (galWeek
    :reader galWeek
    :initarg :galWeek
    :type cl:integer
    :initform 0)
   (bdsMilliseconds
    :reader bdsMilliseconds
    :initarg :bdsMilliseconds
    :type cl:integer
    :initform 0)
   (gpsToGalTimeBiasMilliseconds
    :reader gpsToGalTimeBiasMilliseconds
    :initarg :gpsToGalTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
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
   (bdsClockTimeUncertainty
    :reader bdsClockTimeUncertainty
    :initarg :bdsClockTimeUncertainty
    :type cl:float
    :initform 0.0)
   (gpsToBdsTimeBiasMillisecondsUncertainty
    :reader gpsToBdsTimeBiasMillisecondsUncertainty
    :initarg :gpsToBdsTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (glonassYear
    :reader glonassYear
    :initarg :glonassYear
    :type cl:integer
    :initform 0)
   (galToGloTimeBiasMilliseconds
    :reader galToGloTimeBiasMilliseconds
    :initarg :galToGloTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (galMilliseconds
    :reader galMilliseconds
    :initarg :galMilliseconds
    :type cl:integer
    :initform 0)
   (galToGloTimeBiasMillisecondsUncertainty
    :reader galToGloTimeBiasMillisecondsUncertainty
    :initarg :galToGloTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (clockFrequencyBias
    :reader clockFrequencyBias
    :initarg :clockFrequencyBias
    :type cl:float
    :initform 0.0)
   (fCount
    :reader fCount
    :initarg :fCount
    :type cl:integer
    :initform 0)
   (gpsLeapSeconds
    :reader gpsLeapSeconds
    :initarg :gpsLeapSeconds
    :type cl:integer
    :initform 0)
   (hasRtcTime
    :reader hasRtcTime
    :initarg :hasRtcTime
    :type cl:boolean
    :initform cl:nil)
   (bdsWeek
    :reader bdsWeek
    :initarg :bdsWeek
    :type cl:integer
    :initform 0)
   (glonassClockTimeUncertainty
    :reader glonassClockTimeUncertainty
    :initarg :glonassClockTimeUncertainty
    :type cl:float
    :initform 0.0)
   (hasGlonassMilliseconds
    :reader hasGlonassMilliseconds
    :initarg :hasGlonassMilliseconds
    :type cl:boolean
    :initform cl:nil)
   (systemRtcTime
    :reader systemRtcTime
    :initarg :systemRtcTime
    :type cl:integer
    :initform 0)
   (bdsTimeBias
    :reader bdsTimeBias
    :initarg :bdsTimeBias
    :type cl:float
    :initform 0.0)
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
   (hasGlonassDay
    :reader hasGlonassDay
    :initarg :hasGlonassDay
    :type cl:boolean
    :initform cl:nil)
   (gpsToGalTimeBiasMillisecondsUncertainty
    :reader gpsToGalTimeBiasMillisecondsUncertainty
    :initarg :gpsToGalTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (galTimeBias
    :reader galTimeBias
    :initarg :galTimeBias
    :type cl:float
    :initform 0.0)
   (galClockTimeUncertainty
    :reader galClockTimeUncertainty
    :initarg :galClockTimeUncertainty
    :type cl:float
    :initform 0.0)
   (gpsTimeBias
    :reader gpsTimeBias
    :initarg :gpsTimeBias
    :type cl:float
    :initform 0.0)
   (lpmRtcCount
    :reader lpmRtcCount
    :initarg :lpmRtcCount
    :type cl:integer
    :initform 0)
   (glonassMilliseconds
    :reader glonassMilliseconds
    :initarg :glonassMilliseconds
    :type cl:integer
    :initform 0)
   (fCountOffset
    :reader fCountOffset
    :initarg :fCountOffset
    :type cl:integer
    :initform 0)
   (bdsToGloTimeBiasMilliseconds
    :reader bdsToGloTimeBiasMilliseconds
    :initarg :bdsToGloTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (clockResets
    :reader clockResets
    :initarg :clockResets
    :type cl:integer
    :initform 0)
   (gpsLeapSecondsSource
    :reader gpsLeapSecondsSource
    :initarg :gpsLeapSecondsSource
    :type cl:integer
    :initform 0)
   (galClockSource
    :reader galClockSource
    :initarg :galClockSource
    :type cl:integer
    :initform 0)
   (hasGpsMilliseconds
    :reader hasGpsMilliseconds
    :initarg :hasGpsMilliseconds
    :type cl:boolean
    :initform cl:nil)
   (gpsToBdsTimeBiasMilliseconds
    :reader gpsToBdsTimeBiasMilliseconds
    :initarg :gpsToBdsTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (gpsWeek
    :reader gpsWeek
    :initarg :gpsWeek
    :type cl:integer
    :initform 0)
   (gpsClockTimeUncertainty
    :reader gpsClockTimeUncertainty
    :initarg :gpsClockTimeUncertainty
    :type cl:float
    :initform 0.0)
   (bdsToGloTimeBiasMillisecondsUncertainty
    :reader bdsToGloTimeBiasMillisecondsUncertainty
    :initarg :bdsToGloTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (hasGlonassYear
    :reader hasGlonassYear
    :initarg :hasGlonassYear
    :type cl:boolean
    :initform cl:nil)
   (gpsToGlonassTimeBiasMillisecondsUncertainty
    :reader gpsToGlonassTimeBiasMillisecondsUncertainty
    :initarg :gpsToGlonassTimeBiasMillisecondsUncertainty
    :type cl:float
    :initform 0.0)
   (glonassClockSource
    :reader glonassClockSource
    :initarg :glonassClockSource
    :type cl:integer
    :initform 0)
   (galToBdsTimeBiasMilliseconds
    :reader galToBdsTimeBiasMilliseconds
    :initarg :galToBdsTimeBiasMilliseconds
    :type cl:float
    :initform 0.0)
   (gpsLeapSecondsUncertainty
    :reader gpsLeapSecondsUncertainty
    :initarg :gpsLeapSecondsUncertainty
    :type cl:integer
    :initform 0))
)

(cl:defclass ClockReport (<ClockReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClockReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClockReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ClockReport> is deprecated: use openpilot_bridge-msg:ClockReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'galToBdsTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod galToBdsTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galToBdsTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:galToBdsTimeBiasMillisecondsUncertainty instead.")
  (galToBdsTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'hasFCount-val :lambda-list '(m))
(cl:defmethod hasFCount-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasFCount-val is deprecated.  Use openpilot_bridge-msg:hasFCount instead.")
  (hasFCount m))

(cl:ensure-generic-function 'bdsClockSource-val :lambda-list '(m))
(cl:defmethod bdsClockSource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsClockSource-val is deprecated.  Use openpilot_bridge-msg:bdsClockSource instead.")
  (bdsClockSource m))

(cl:ensure-generic-function 'clockFrequencyUncertainty-val :lambda-list '(m))
(cl:defmethod clockFrequencyUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockFrequencyUncertainty-val is deprecated.  Use openpilot_bridge-msg:clockFrequencyUncertainty instead.")
  (clockFrequencyUncertainty m))

(cl:ensure-generic-function 'gpsMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsMilliseconds instead.")
  (gpsMilliseconds m))

(cl:ensure-generic-function 'hasGpsWeek-val :lambda-list '(m))
(cl:defmethod hasGpsWeek-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGpsWeek-val is deprecated.  Use openpilot_bridge-msg:hasGpsWeek instead.")
  (hasGpsWeek m))

(cl:ensure-generic-function 'gpsToGlonassTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsToGlonassTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGlonassTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsToGlonassTimeBiasMilliseconds instead.")
  (gpsToGlonassTimeBiasMilliseconds m))

(cl:ensure-generic-function 'galWeek-val :lambda-list '(m))
(cl:defmethod galWeek-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galWeek-val is deprecated.  Use openpilot_bridge-msg:galWeek instead.")
  (galWeek m))

(cl:ensure-generic-function 'bdsMilliseconds-val :lambda-list '(m))
(cl:defmethod bdsMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsMilliseconds-val is deprecated.  Use openpilot_bridge-msg:bdsMilliseconds instead.")
  (bdsMilliseconds m))

(cl:ensure-generic-function 'gpsToGalTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsToGalTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGalTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsToGalTimeBiasMilliseconds instead.")
  (gpsToGalTimeBiasMilliseconds m))

(cl:ensure-generic-function 'glonassTimeBias-val :lambda-list '(m))
(cl:defmethod glonassTimeBias-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassTimeBias-val is deprecated.  Use openpilot_bridge-msg:glonassTimeBias instead.")
  (glonassTimeBias m))

(cl:ensure-generic-function 'gpsClockSource-val :lambda-list '(m))
(cl:defmethod gpsClockSource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsClockSource-val is deprecated.  Use openpilot_bridge-msg:gpsClockSource instead.")
  (gpsClockSource m))

(cl:ensure-generic-function 'bdsClockTimeUncertainty-val :lambda-list '(m))
(cl:defmethod bdsClockTimeUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsClockTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:bdsClockTimeUncertainty instead.")
  (bdsClockTimeUncertainty m))

(cl:ensure-generic-function 'gpsToBdsTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsToBdsTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToBdsTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsToBdsTimeBiasMillisecondsUncertainty instead.")
  (gpsToBdsTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'glonassYear-val :lambda-list '(m))
(cl:defmethod glonassYear-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassYear-val is deprecated.  Use openpilot_bridge-msg:glonassYear instead.")
  (glonassYear m))

(cl:ensure-generic-function 'galToGloTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod galToGloTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galToGloTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:galToGloTimeBiasMilliseconds instead.")
  (galToGloTimeBiasMilliseconds m))

(cl:ensure-generic-function 'galMilliseconds-val :lambda-list '(m))
(cl:defmethod galMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galMilliseconds-val is deprecated.  Use openpilot_bridge-msg:galMilliseconds instead.")
  (galMilliseconds m))

(cl:ensure-generic-function 'galToGloTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod galToGloTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galToGloTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:galToGloTimeBiasMillisecondsUncertainty instead.")
  (galToGloTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'clockFrequencyBias-val :lambda-list '(m))
(cl:defmethod clockFrequencyBias-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockFrequencyBias-val is deprecated.  Use openpilot_bridge-msg:clockFrequencyBias instead.")
  (clockFrequencyBias m))

(cl:ensure-generic-function 'fCount-val :lambda-list '(m))
(cl:defmethod fCount-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fCount-val is deprecated.  Use openpilot_bridge-msg:fCount instead.")
  (fCount m))

(cl:ensure-generic-function 'gpsLeapSeconds-val :lambda-list '(m))
(cl:defmethod gpsLeapSeconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLeapSeconds-val is deprecated.  Use openpilot_bridge-msg:gpsLeapSeconds instead.")
  (gpsLeapSeconds m))

(cl:ensure-generic-function 'hasRtcTime-val :lambda-list '(m))
(cl:defmethod hasRtcTime-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasRtcTime-val is deprecated.  Use openpilot_bridge-msg:hasRtcTime instead.")
  (hasRtcTime m))

(cl:ensure-generic-function 'bdsWeek-val :lambda-list '(m))
(cl:defmethod bdsWeek-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsWeek-val is deprecated.  Use openpilot_bridge-msg:bdsWeek instead.")
  (bdsWeek m))

(cl:ensure-generic-function 'glonassClockTimeUncertainty-val :lambda-list '(m))
(cl:defmethod glonassClockTimeUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassClockTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:glonassClockTimeUncertainty instead.")
  (glonassClockTimeUncertainty m))

(cl:ensure-generic-function 'hasGlonassMilliseconds-val :lambda-list '(m))
(cl:defmethod hasGlonassMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGlonassMilliseconds-val is deprecated.  Use openpilot_bridge-msg:hasGlonassMilliseconds instead.")
  (hasGlonassMilliseconds m))

(cl:ensure-generic-function 'systemRtcTime-val :lambda-list '(m))
(cl:defmethod systemRtcTime-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:systemRtcTime-val is deprecated.  Use openpilot_bridge-msg:systemRtcTime instead.")
  (systemRtcTime m))

(cl:ensure-generic-function 'bdsTimeBias-val :lambda-list '(m))
(cl:defmethod bdsTimeBias-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsTimeBias-val is deprecated.  Use openpilot_bridge-msg:bdsTimeBias instead.")
  (bdsTimeBias m))

(cl:ensure-generic-function 'frequencySource-val :lambda-list '(m))
(cl:defmethod frequencySource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frequencySource-val is deprecated.  Use openpilot_bridge-msg:frequencySource instead.")
  (frequencySource m))

(cl:ensure-generic-function 'glonassDay-val :lambda-list '(m))
(cl:defmethod glonassDay-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassDay-val is deprecated.  Use openpilot_bridge-msg:glonassDay instead.")
  (glonassDay m))

(cl:ensure-generic-function 'hasGlonassDay-val :lambda-list '(m))
(cl:defmethod hasGlonassDay-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGlonassDay-val is deprecated.  Use openpilot_bridge-msg:hasGlonassDay instead.")
  (hasGlonassDay m))

(cl:ensure-generic-function 'gpsToGalTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsToGalTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGalTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsToGalTimeBiasMillisecondsUncertainty instead.")
  (gpsToGalTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'galTimeBias-val :lambda-list '(m))
(cl:defmethod galTimeBias-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galTimeBias-val is deprecated.  Use openpilot_bridge-msg:galTimeBias instead.")
  (galTimeBias m))

(cl:ensure-generic-function 'galClockTimeUncertainty-val :lambda-list '(m))
(cl:defmethod galClockTimeUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galClockTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:galClockTimeUncertainty instead.")
  (galClockTimeUncertainty m))

(cl:ensure-generic-function 'gpsTimeBias-val :lambda-list '(m))
(cl:defmethod gpsTimeBias-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsTimeBias-val is deprecated.  Use openpilot_bridge-msg:gpsTimeBias instead.")
  (gpsTimeBias m))

(cl:ensure-generic-function 'lpmRtcCount-val :lambda-list '(m))
(cl:defmethod lpmRtcCount-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lpmRtcCount-val is deprecated.  Use openpilot_bridge-msg:lpmRtcCount instead.")
  (lpmRtcCount m))

(cl:ensure-generic-function 'glonassMilliseconds-val :lambda-list '(m))
(cl:defmethod glonassMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassMilliseconds-val is deprecated.  Use openpilot_bridge-msg:glonassMilliseconds instead.")
  (glonassMilliseconds m))

(cl:ensure-generic-function 'fCountOffset-val :lambda-list '(m))
(cl:defmethod fCountOffset-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fCountOffset-val is deprecated.  Use openpilot_bridge-msg:fCountOffset instead.")
  (fCountOffset m))

(cl:ensure-generic-function 'bdsToGloTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod bdsToGloTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsToGloTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:bdsToGloTimeBiasMilliseconds instead.")
  (bdsToGloTimeBiasMilliseconds m))

(cl:ensure-generic-function 'clockResets-val :lambda-list '(m))
(cl:defmethod clockResets-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockResets-val is deprecated.  Use openpilot_bridge-msg:clockResets instead.")
  (clockResets m))

(cl:ensure-generic-function 'gpsLeapSecondsSource-val :lambda-list '(m))
(cl:defmethod gpsLeapSecondsSource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLeapSecondsSource-val is deprecated.  Use openpilot_bridge-msg:gpsLeapSecondsSource instead.")
  (gpsLeapSecondsSource m))

(cl:ensure-generic-function 'galClockSource-val :lambda-list '(m))
(cl:defmethod galClockSource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galClockSource-val is deprecated.  Use openpilot_bridge-msg:galClockSource instead.")
  (galClockSource m))

(cl:ensure-generic-function 'hasGpsMilliseconds-val :lambda-list '(m))
(cl:defmethod hasGpsMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGpsMilliseconds-val is deprecated.  Use openpilot_bridge-msg:hasGpsMilliseconds instead.")
  (hasGpsMilliseconds m))

(cl:ensure-generic-function 'gpsToBdsTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod gpsToBdsTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToBdsTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:gpsToBdsTimeBiasMilliseconds instead.")
  (gpsToBdsTimeBiasMilliseconds m))

(cl:ensure-generic-function 'gpsWeek-val :lambda-list '(m))
(cl:defmethod gpsWeek-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsWeek-val is deprecated.  Use openpilot_bridge-msg:gpsWeek instead.")
  (gpsWeek m))

(cl:ensure-generic-function 'gpsClockTimeUncertainty-val :lambda-list '(m))
(cl:defmethod gpsClockTimeUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsClockTimeUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsClockTimeUncertainty instead.")
  (gpsClockTimeUncertainty m))

(cl:ensure-generic-function 'bdsToGloTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod bdsToGloTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bdsToGloTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:bdsToGloTimeBiasMillisecondsUncertainty instead.")
  (bdsToGloTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'hasGlonassYear-val :lambda-list '(m))
(cl:defmethod hasGlonassYear-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasGlonassYear-val is deprecated.  Use openpilot_bridge-msg:hasGlonassYear instead.")
  (hasGlonassYear m))

(cl:ensure-generic-function 'gpsToGlonassTimeBiasMillisecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsToGlonassTimeBiasMillisecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsToGlonassTimeBiasMillisecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsToGlonassTimeBiasMillisecondsUncertainty instead.")
  (gpsToGlonassTimeBiasMillisecondsUncertainty m))

(cl:ensure-generic-function 'glonassClockSource-val :lambda-list '(m))
(cl:defmethod glonassClockSource-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassClockSource-val is deprecated.  Use openpilot_bridge-msg:glonassClockSource instead.")
  (glonassClockSource m))

(cl:ensure-generic-function 'galToBdsTimeBiasMilliseconds-val :lambda-list '(m))
(cl:defmethod galToBdsTimeBiasMilliseconds-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:galToBdsTimeBiasMilliseconds-val is deprecated.  Use openpilot_bridge-msg:galToBdsTimeBiasMilliseconds instead.")
  (galToBdsTimeBiasMilliseconds m))

(cl:ensure-generic-function 'gpsLeapSecondsUncertainty-val :lambda-list '(m))
(cl:defmethod gpsLeapSecondsUncertainty-val ((m <ClockReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLeapSecondsUncertainty-val is deprecated.  Use openpilot_bridge-msg:gpsLeapSecondsUncertainty instead.")
  (gpsLeapSecondsUncertainty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClockReport>) ostream)
  "Serializes a message object of type '<ClockReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galToBdsTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasFCount) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'bdsClockSource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGpsWeek) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGlonassTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'galWeek)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'bdsMilliseconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGalTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bdsClockTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToBdsTimeBiasMillisecondsUncertainty))))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galToGloTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'galMilliseconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galToGloTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'clockFrequencyBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasRtcTime) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'bdsWeek)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGlonassMilliseconds) 1 0)) ostream)
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bdsTimeBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGlonassDay) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGalTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galTimeBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galClockTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsTimeBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'lpmRtcCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
  (cl:let* ((signed (cl:slot-value msg 'fCountOffset)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bdsToGloTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:let* ((signed (cl:slot-value msg 'gpsLeapSecondsSource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'galClockSource)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGpsMilliseconds) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToBdsTimeBiasMilliseconds))))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsClockTimeUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bdsToGloTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasGlonassYear) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsToGlonassTimeBiasMillisecondsUncertainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'galToBdsTimeBiasMilliseconds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClockReport>) istream)
  "Deserializes a message object of type '<ClockReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galToBdsTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasFCount) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bdsClockSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
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
      (cl:setf (cl:slot-value msg 'gpsMilliseconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'hasGpsWeek) (cl:not (cl:zerop (cl:read-byte istream))))
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
      (cl:setf (cl:slot-value msg 'galWeek) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bdsMilliseconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToGalTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:setf (cl:slot-value msg 'bdsClockTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToBdsTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galToGloTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'galMilliseconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galToGloTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'clockFrequencyBias) (roslisp-utils:decode-single-float-bits bits)))
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
      (cl:setf (cl:slot-value msg 'gpsLeapSeconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'hasRtcTime) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bdsWeek) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'glonassClockTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasGlonassMilliseconds) (cl:not (cl:zerop (cl:read-byte istream))))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bdsTimeBias) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:setf (cl:slot-value msg 'hasGlonassDay) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToGalTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galTimeBias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galClockTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsTimeBias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lpmRtcCount) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
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
      (cl:setf (cl:slot-value msg 'fCountOffset) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bdsToGloTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsLeapSecondsSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'galClockSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'hasGpsMilliseconds) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsToBdsTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsClockTimeUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bdsToGloTimeBiasMillisecondsUncertainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasGlonassYear) (cl:not (cl:zerop (cl:read-byte istream))))
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
      (cl:setf (cl:slot-value msg 'glonassClockSource) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'galToBdsTimeBiasMilliseconds) (roslisp-utils:decode-single-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClockReport>)))
  "Returns string type for a message object of type '<ClockReport>"
  "openpilot_bridge/ClockReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClockReport)))
  "Returns string type for a message object of type 'ClockReport"
  "openpilot_bridge/ClockReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClockReport>)))
  "Returns md5sum for a message object of type '<ClockReport>"
  "9c5d965bc1d857db6ee7aaa1ec215d3f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClockReport)))
  "Returns md5sum for a message object of type 'ClockReport"
  "9c5d965bc1d857db6ee7aaa1ec215d3f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClockReport>)))
  "Returns full string definition for message of type '<ClockReport>"
  (cl:format cl:nil "Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClockReport)))
  "Returns full string definition for message of type 'ClockReport"
  (cl:format cl:nil "Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClockReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     8
     4
     8
     1
     4
     8
     8
     4
     4
     8
     4
     4
     8
     4
     8
     4
     4
     8
     8
     1
     8
     4
     1
     8
     4
     8
     8
     1
     4
     4
     4
     4
     8
     8
     8
     4
     8
     8
     8
     1
     4
     8
     4
     4
     1
     4
     8
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClockReport>))
  "Converts a ROS message object to a list"
  (cl:list 'ClockReport
    (cl:cons ':header (header msg))
    (cl:cons ':galToBdsTimeBiasMillisecondsUncertainty (galToBdsTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':hasFCount (hasFCount msg))
    (cl:cons ':bdsClockSource (bdsClockSource msg))
    (cl:cons ':clockFrequencyUncertainty (clockFrequencyUncertainty msg))
    (cl:cons ':gpsMilliseconds (gpsMilliseconds msg))
    (cl:cons ':hasGpsWeek (hasGpsWeek msg))
    (cl:cons ':gpsToGlonassTimeBiasMilliseconds (gpsToGlonassTimeBiasMilliseconds msg))
    (cl:cons ':galWeek (galWeek msg))
    (cl:cons ':bdsMilliseconds (bdsMilliseconds msg))
    (cl:cons ':gpsToGalTimeBiasMilliseconds (gpsToGalTimeBiasMilliseconds msg))
    (cl:cons ':glonassTimeBias (glonassTimeBias msg))
    (cl:cons ':gpsClockSource (gpsClockSource msg))
    (cl:cons ':bdsClockTimeUncertainty (bdsClockTimeUncertainty msg))
    (cl:cons ':gpsToBdsTimeBiasMillisecondsUncertainty (gpsToBdsTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':glonassYear (glonassYear msg))
    (cl:cons ':galToGloTimeBiasMilliseconds (galToGloTimeBiasMilliseconds msg))
    (cl:cons ':galMilliseconds (galMilliseconds msg))
    (cl:cons ':galToGloTimeBiasMillisecondsUncertainty (galToGloTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':clockFrequencyBias (clockFrequencyBias msg))
    (cl:cons ':fCount (fCount msg))
    (cl:cons ':gpsLeapSeconds (gpsLeapSeconds msg))
    (cl:cons ':hasRtcTime (hasRtcTime msg))
    (cl:cons ':bdsWeek (bdsWeek msg))
    (cl:cons ':glonassClockTimeUncertainty (glonassClockTimeUncertainty msg))
    (cl:cons ':hasGlonassMilliseconds (hasGlonassMilliseconds msg))
    (cl:cons ':systemRtcTime (systemRtcTime msg))
    (cl:cons ':bdsTimeBias (bdsTimeBias msg))
    (cl:cons ':frequencySource (frequencySource msg))
    (cl:cons ':glonassDay (glonassDay msg))
    (cl:cons ':hasGlonassDay (hasGlonassDay msg))
    (cl:cons ':gpsToGalTimeBiasMillisecondsUncertainty (gpsToGalTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':galTimeBias (galTimeBias msg))
    (cl:cons ':galClockTimeUncertainty (galClockTimeUncertainty msg))
    (cl:cons ':gpsTimeBias (gpsTimeBias msg))
    (cl:cons ':lpmRtcCount (lpmRtcCount msg))
    (cl:cons ':glonassMilliseconds (glonassMilliseconds msg))
    (cl:cons ':fCountOffset (fCountOffset msg))
    (cl:cons ':bdsToGloTimeBiasMilliseconds (bdsToGloTimeBiasMilliseconds msg))
    (cl:cons ':clockResets (clockResets msg))
    (cl:cons ':gpsLeapSecondsSource (gpsLeapSecondsSource msg))
    (cl:cons ':galClockSource (galClockSource msg))
    (cl:cons ':hasGpsMilliseconds (hasGpsMilliseconds msg))
    (cl:cons ':gpsToBdsTimeBiasMilliseconds (gpsToBdsTimeBiasMilliseconds msg))
    (cl:cons ':gpsWeek (gpsWeek msg))
    (cl:cons ':gpsClockTimeUncertainty (gpsClockTimeUncertainty msg))
    (cl:cons ':bdsToGloTimeBiasMillisecondsUncertainty (bdsToGloTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':hasGlonassYear (hasGlonassYear msg))
    (cl:cons ':gpsToGlonassTimeBiasMillisecondsUncertainty (gpsToGlonassTimeBiasMillisecondsUncertainty msg))
    (cl:cons ':glonassClockSource (glonassClockSource msg))
    (cl:cons ':galToBdsTimeBiasMilliseconds (galToBdsTimeBiasMilliseconds msg))
    (cl:cons ':gpsLeapSecondsUncertainty (gpsLeapSecondsUncertainty msg))
))
