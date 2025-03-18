; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude MeasurementStatus.msg.html

(cl:defclass <MeasurementStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (glonassTimeMarkValid
    :reader glonassTimeMarkValid
    :initarg :glonassTimeMarkValid
    :type cl:boolean
    :initform cl:nil)
   (lockPointValid
    :reader lockPointValid
    :initarg :lockPointValid
    :type cl:boolean
    :initform cl:nil)
   (imdJammingIndicator
    :reader imdJammingIndicator
    :initarg :imdJammingIndicator
    :type cl:boolean
    :initform cl:nil)
   (measuredVelocity
    :reader measuredVelocity
    :initarg :measuredVelocity
    :type cl:boolean
    :initform cl:nil)
   (fineOrCoarseVelocity
    :reader fineOrCoarseVelocity
    :initarg :fineOrCoarseVelocity
    :type cl:boolean
    :initform cl:nil)
   (gpsHighBandwidthNu4
    :reader gpsHighBandwidthNu4
    :initarg :gpsHighBandwidthNu4
    :type cl:boolean
    :initform cl:nil)
   (gpsRxDiversity
    :reader gpsRxDiversity
    :initarg :gpsRxDiversity
    :type cl:boolean
    :initform cl:nil)
   (gpsHighBandwidthUniform
    :reader gpsHighBandwidthUniform
    :initarg :gpsHighBandwidthUniform
    :type cl:boolean
    :initform cl:nil)
   (gpsHighBandwidthNu8
    :reader gpsHighBandwidthNu8
    :initarg :gpsHighBandwidthNu8
    :type cl:boolean
    :initform cl:nil)
   (subMillisecondIsValid
    :reader subMillisecondIsValid
    :initarg :subMillisecondIsValid
    :type cl:boolean
    :initform cl:nil)
   (lastUpdateFromDifference
    :reader lastUpdateFromDifference
    :initarg :lastUpdateFromDifference
    :type cl:boolean
    :initform cl:nil)
   (tentativeMeasurement
    :reader tentativeMeasurement
    :initarg :tentativeMeasurement
    :type cl:boolean
    :initform cl:nil)
   (probationMode
    :reader probationMode
    :initarg :probationMode
    :type cl:boolean
    :initform cl:nil)
   (directionIsValid
    :reader directionIsValid
    :initarg :directionIsValid
    :type cl:boolean
    :initform cl:nil)
   (bitEdgeConfirmedFromSignal
    :reader bitEdgeConfirmedFromSignal
    :initarg :bitEdgeConfirmedFromSignal
    :type cl:boolean
    :initform cl:nil)
   (gpsRoundRobinRxDiversity
    :reader gpsRoundRobinRxDiversity
    :initarg :gpsRoundRobinRxDiversity
    :type cl:boolean
    :initform cl:nil)
   (freshMeasurementIndicator
    :reader freshMeasurementIndicator
    :initarg :freshMeasurementIndicator
    :type cl:boolean
    :initform cl:nil)
   (lteB13TxJammingIndicator
    :reader lteB13TxJammingIndicator
    :initarg :lteB13TxJammingIndicator
    :type cl:boolean
    :initform cl:nil)
   (lastUpdateFromVelocityDifference
    :reader lastUpdateFromVelocityDifference
    :initarg :lastUpdateFromVelocityDifference
    :type cl:boolean
    :initform cl:nil)
   (measurementNotUsable
    :reader measurementNotUsable
    :initarg :measurementNotUsable
    :type cl:boolean
    :initform cl:nil)
   (glonassMeanderBitEdgeValid
    :reader glonassMeanderBitEdgeValid
    :initarg :glonassMeanderBitEdgeValid
    :type cl:boolean
    :initform cl:nil)
   (gpsLowBandwidthRxDiversityCombined
    :reader gpsLowBandwidthRxDiversityCombined
    :initarg :gpsLowBandwidthRxDiversityCombined
    :type cl:boolean
    :initform cl:nil)
   (satelliteTimeIsKnown
    :reader satelliteTimeIsKnown
    :initarg :satelliteTimeIsKnown
    :type cl:boolean
    :initform cl:nil)
   (strongIndicationOfCrossCorelation
    :reader strongIndicationOfCrossCorelation
    :initarg :strongIndicationOfCrossCorelation
    :type cl:boolean
    :initform cl:nil)
   (subBitTimeIsKnown
    :reader subBitTimeIsKnown
    :initarg :subBitTimeIsKnown
    :type cl:boolean
    :initform cl:nil)
   (lockPointPositive
    :reader lockPointPositive
    :initarg :lockPointPositive
    :type cl:boolean
    :initform cl:nil)
   (multipathIndicator
    :reader multipathIndicator
    :initarg :multipathIndicator
    :type cl:boolean
    :initform cl:nil)
   (sirCheckIsNeeded
    :reader sirCheckIsNeeded
    :initarg :sirCheckIsNeeded
    :type cl:boolean
    :initform cl:nil)
   (multipathEstimateIsValid
    :reader multipathEstimateIsValid
    :initarg :multipathEstimateIsValid
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MeasurementStatus (<MeasurementStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MeasurementStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MeasurementStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<MeasurementStatus> is deprecated: use openpilot_bridge-msg:MeasurementStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'glonassTimeMarkValid-val :lambda-list '(m))
(cl:defmethod glonassTimeMarkValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassTimeMarkValid-val is deprecated.  Use openpilot_bridge-msg:glonassTimeMarkValid instead.")
  (glonassTimeMarkValid m))

(cl:ensure-generic-function 'lockPointValid-val :lambda-list '(m))
(cl:defmethod lockPointValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lockPointValid-val is deprecated.  Use openpilot_bridge-msg:lockPointValid instead.")
  (lockPointValid m))

(cl:ensure-generic-function 'imdJammingIndicator-val :lambda-list '(m))
(cl:defmethod imdJammingIndicator-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:imdJammingIndicator-val is deprecated.  Use openpilot_bridge-msg:imdJammingIndicator instead.")
  (imdJammingIndicator m))

(cl:ensure-generic-function 'measuredVelocity-val :lambda-list '(m))
(cl:defmethod measuredVelocity-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measuredVelocity-val is deprecated.  Use openpilot_bridge-msg:measuredVelocity instead.")
  (measuredVelocity m))

(cl:ensure-generic-function 'fineOrCoarseVelocity-val :lambda-list '(m))
(cl:defmethod fineOrCoarseVelocity-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fineOrCoarseVelocity-val is deprecated.  Use openpilot_bridge-msg:fineOrCoarseVelocity instead.")
  (fineOrCoarseVelocity m))

(cl:ensure-generic-function 'gpsHighBandwidthNu4-val :lambda-list '(m))
(cl:defmethod gpsHighBandwidthNu4-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsHighBandwidthNu4-val is deprecated.  Use openpilot_bridge-msg:gpsHighBandwidthNu4 instead.")
  (gpsHighBandwidthNu4 m))

(cl:ensure-generic-function 'gpsRxDiversity-val :lambda-list '(m))
(cl:defmethod gpsRxDiversity-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsRxDiversity-val is deprecated.  Use openpilot_bridge-msg:gpsRxDiversity instead.")
  (gpsRxDiversity m))

(cl:ensure-generic-function 'gpsHighBandwidthUniform-val :lambda-list '(m))
(cl:defmethod gpsHighBandwidthUniform-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsHighBandwidthUniform-val is deprecated.  Use openpilot_bridge-msg:gpsHighBandwidthUniform instead.")
  (gpsHighBandwidthUniform m))

(cl:ensure-generic-function 'gpsHighBandwidthNu8-val :lambda-list '(m))
(cl:defmethod gpsHighBandwidthNu8-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsHighBandwidthNu8-val is deprecated.  Use openpilot_bridge-msg:gpsHighBandwidthNu8 instead.")
  (gpsHighBandwidthNu8 m))

(cl:ensure-generic-function 'subMillisecondIsValid-val :lambda-list '(m))
(cl:defmethod subMillisecondIsValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:subMillisecondIsValid-val is deprecated.  Use openpilot_bridge-msg:subMillisecondIsValid instead.")
  (subMillisecondIsValid m))

(cl:ensure-generic-function 'lastUpdateFromDifference-val :lambda-list '(m))
(cl:defmethod lastUpdateFromDifference-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lastUpdateFromDifference-val is deprecated.  Use openpilot_bridge-msg:lastUpdateFromDifference instead.")
  (lastUpdateFromDifference m))

(cl:ensure-generic-function 'tentativeMeasurement-val :lambda-list '(m))
(cl:defmethod tentativeMeasurement-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:tentativeMeasurement-val is deprecated.  Use openpilot_bridge-msg:tentativeMeasurement instead.")
  (tentativeMeasurement m))

(cl:ensure-generic-function 'probationMode-val :lambda-list '(m))
(cl:defmethod probationMode-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:probationMode-val is deprecated.  Use openpilot_bridge-msg:probationMode instead.")
  (probationMode m))

(cl:ensure-generic-function 'directionIsValid-val :lambda-list '(m))
(cl:defmethod directionIsValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:directionIsValid-val is deprecated.  Use openpilot_bridge-msg:directionIsValid instead.")
  (directionIsValid m))

(cl:ensure-generic-function 'bitEdgeConfirmedFromSignal-val :lambda-list '(m))
(cl:defmethod bitEdgeConfirmedFromSignal-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:bitEdgeConfirmedFromSignal-val is deprecated.  Use openpilot_bridge-msg:bitEdgeConfirmedFromSignal instead.")
  (bitEdgeConfirmedFromSignal m))

(cl:ensure-generic-function 'gpsRoundRobinRxDiversity-val :lambda-list '(m))
(cl:defmethod gpsRoundRobinRxDiversity-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsRoundRobinRxDiversity-val is deprecated.  Use openpilot_bridge-msg:gpsRoundRobinRxDiversity instead.")
  (gpsRoundRobinRxDiversity m))

(cl:ensure-generic-function 'freshMeasurementIndicator-val :lambda-list '(m))
(cl:defmethod freshMeasurementIndicator-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:freshMeasurementIndicator-val is deprecated.  Use openpilot_bridge-msg:freshMeasurementIndicator instead.")
  (freshMeasurementIndicator m))

(cl:ensure-generic-function 'lteB13TxJammingIndicator-val :lambda-list '(m))
(cl:defmethod lteB13TxJammingIndicator-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lteB13TxJammingIndicator-val is deprecated.  Use openpilot_bridge-msg:lteB13TxJammingIndicator instead.")
  (lteB13TxJammingIndicator m))

(cl:ensure-generic-function 'lastUpdateFromVelocityDifference-val :lambda-list '(m))
(cl:defmethod lastUpdateFromVelocityDifference-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lastUpdateFromVelocityDifference-val is deprecated.  Use openpilot_bridge-msg:lastUpdateFromVelocityDifference instead.")
  (lastUpdateFromVelocityDifference m))

(cl:ensure-generic-function 'measurementNotUsable-val :lambda-list '(m))
(cl:defmethod measurementNotUsable-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurementNotUsable-val is deprecated.  Use openpilot_bridge-msg:measurementNotUsable instead.")
  (measurementNotUsable m))

(cl:ensure-generic-function 'glonassMeanderBitEdgeValid-val :lambda-list '(m))
(cl:defmethod glonassMeanderBitEdgeValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:glonassMeanderBitEdgeValid-val is deprecated.  Use openpilot_bridge-msg:glonassMeanderBitEdgeValid instead.")
  (glonassMeanderBitEdgeValid m))

(cl:ensure-generic-function 'gpsLowBandwidthRxDiversityCombined-val :lambda-list '(m))
(cl:defmethod gpsLowBandwidthRxDiversityCombined-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsLowBandwidthRxDiversityCombined-val is deprecated.  Use openpilot_bridge-msg:gpsLowBandwidthRxDiversityCombined instead.")
  (gpsLowBandwidthRxDiversityCombined m))

(cl:ensure-generic-function 'satelliteTimeIsKnown-val :lambda-list '(m))
(cl:defmethod satelliteTimeIsKnown-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:satelliteTimeIsKnown-val is deprecated.  Use openpilot_bridge-msg:satelliteTimeIsKnown instead.")
  (satelliteTimeIsKnown m))

(cl:ensure-generic-function 'strongIndicationOfCrossCorelation-val :lambda-list '(m))
(cl:defmethod strongIndicationOfCrossCorelation-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:strongIndicationOfCrossCorelation-val is deprecated.  Use openpilot_bridge-msg:strongIndicationOfCrossCorelation instead.")
  (strongIndicationOfCrossCorelation m))

(cl:ensure-generic-function 'subBitTimeIsKnown-val :lambda-list '(m))
(cl:defmethod subBitTimeIsKnown-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:subBitTimeIsKnown-val is deprecated.  Use openpilot_bridge-msg:subBitTimeIsKnown instead.")
  (subBitTimeIsKnown m))

(cl:ensure-generic-function 'lockPointPositive-val :lambda-list '(m))
(cl:defmethod lockPointPositive-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lockPointPositive-val is deprecated.  Use openpilot_bridge-msg:lockPointPositive instead.")
  (lockPointPositive m))

(cl:ensure-generic-function 'multipathIndicator-val :lambda-list '(m))
(cl:defmethod multipathIndicator-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:multipathIndicator-val is deprecated.  Use openpilot_bridge-msg:multipathIndicator instead.")
  (multipathIndicator m))

(cl:ensure-generic-function 'sirCheckIsNeeded-val :lambda-list '(m))
(cl:defmethod sirCheckIsNeeded-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sirCheckIsNeeded-val is deprecated.  Use openpilot_bridge-msg:sirCheckIsNeeded instead.")
  (sirCheckIsNeeded m))

(cl:ensure-generic-function 'multipathEstimateIsValid-val :lambda-list '(m))
(cl:defmethod multipathEstimateIsValid-val ((m <MeasurementStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:multipathEstimateIsValid-val is deprecated.  Use openpilot_bridge-msg:multipathEstimateIsValid instead.")
  (multipathEstimateIsValid m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MeasurementStatus>) ostream)
  "Serializes a message object of type '<MeasurementStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'glonassTimeMarkValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lockPointValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'imdJammingIndicator) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'measuredVelocity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fineOrCoarseVelocity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsHighBandwidthNu4) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsRxDiversity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsHighBandwidthUniform) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsHighBandwidthNu8) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'subMillisecondIsValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lastUpdateFromDifference) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'tentativeMeasurement) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'probationMode) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'directionIsValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'bitEdgeConfirmedFromSignal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsRoundRobinRxDiversity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'freshMeasurementIndicator) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lteB13TxJammingIndicator) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lastUpdateFromVelocityDifference) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'measurementNotUsable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'glonassMeanderBitEdgeValid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsLowBandwidthRxDiversityCombined) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'satelliteTimeIsKnown) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'strongIndicationOfCrossCorelation) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'subBitTimeIsKnown) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lockPointPositive) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'multipathIndicator) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'sirCheckIsNeeded) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'multipathEstimateIsValid) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MeasurementStatus>) istream)
  "Deserializes a message object of type '<MeasurementStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'glonassTimeMarkValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lockPointValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'imdJammingIndicator) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'measuredVelocity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fineOrCoarseVelocity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsHighBandwidthNu4) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsRxDiversity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsHighBandwidthUniform) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsHighBandwidthNu8) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'subMillisecondIsValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lastUpdateFromDifference) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'tentativeMeasurement) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'probationMode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'directionIsValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'bitEdgeConfirmedFromSignal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsRoundRobinRxDiversity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'freshMeasurementIndicator) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lteB13TxJammingIndicator) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lastUpdateFromVelocityDifference) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'measurementNotUsable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'glonassMeanderBitEdgeValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsLowBandwidthRxDiversityCombined) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'satelliteTimeIsKnown) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'strongIndicationOfCrossCorelation) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'subBitTimeIsKnown) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lockPointPositive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'multipathIndicator) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'sirCheckIsNeeded) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'multipathEstimateIsValid) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MeasurementStatus>)))
  "Returns string type for a message object of type '<MeasurementStatus>"
  "openpilot_bridge/MeasurementStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MeasurementStatus)))
  "Returns string type for a message object of type 'MeasurementStatus"
  "openpilot_bridge/MeasurementStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MeasurementStatus>)))
  "Returns md5sum for a message object of type '<MeasurementStatus>"
  "a21dccf859aded23d20028d0485351fb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MeasurementStatus)))
  "Returns md5sum for a message object of type 'MeasurementStatus"
  "a21dccf859aded23d20028d0485351fb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MeasurementStatus>)))
  "Returns full string definition for message of type '<MeasurementStatus>"
  (cl:format cl:nil "Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MeasurementStatus)))
  "Returns full string definition for message of type 'MeasurementStatus"
  (cl:format cl:nil "Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MeasurementStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MeasurementStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'MeasurementStatus
    (cl:cons ':header (header msg))
    (cl:cons ':glonassTimeMarkValid (glonassTimeMarkValid msg))
    (cl:cons ':lockPointValid (lockPointValid msg))
    (cl:cons ':imdJammingIndicator (imdJammingIndicator msg))
    (cl:cons ':measuredVelocity (measuredVelocity msg))
    (cl:cons ':fineOrCoarseVelocity (fineOrCoarseVelocity msg))
    (cl:cons ':gpsHighBandwidthNu4 (gpsHighBandwidthNu4 msg))
    (cl:cons ':gpsRxDiversity (gpsRxDiversity msg))
    (cl:cons ':gpsHighBandwidthUniform (gpsHighBandwidthUniform msg))
    (cl:cons ':gpsHighBandwidthNu8 (gpsHighBandwidthNu8 msg))
    (cl:cons ':subMillisecondIsValid (subMillisecondIsValid msg))
    (cl:cons ':lastUpdateFromDifference (lastUpdateFromDifference msg))
    (cl:cons ':tentativeMeasurement (tentativeMeasurement msg))
    (cl:cons ':probationMode (probationMode msg))
    (cl:cons ':directionIsValid (directionIsValid msg))
    (cl:cons ':bitEdgeConfirmedFromSignal (bitEdgeConfirmedFromSignal msg))
    (cl:cons ':gpsRoundRobinRxDiversity (gpsRoundRobinRxDiversity msg))
    (cl:cons ':freshMeasurementIndicator (freshMeasurementIndicator msg))
    (cl:cons ':lteB13TxJammingIndicator (lteB13TxJammingIndicator msg))
    (cl:cons ':lastUpdateFromVelocityDifference (lastUpdateFromVelocityDifference msg))
    (cl:cons ':measurementNotUsable (measurementNotUsable msg))
    (cl:cons ':glonassMeanderBitEdgeValid (glonassMeanderBitEdgeValid msg))
    (cl:cons ':gpsLowBandwidthRxDiversityCombined (gpsLowBandwidthRxDiversityCombined msg))
    (cl:cons ':satelliteTimeIsKnown (satelliteTimeIsKnown msg))
    (cl:cons ':strongIndicationOfCrossCorelation (strongIndicationOfCrossCorelation msg))
    (cl:cons ':subBitTimeIsKnown (subBitTimeIsKnown msg))
    (cl:cons ':lockPointPositive (lockPointPositive msg))
    (cl:cons ':multipathIndicator (multipathIndicator msg))
    (cl:cons ':sirCheckIsNeeded (sirCheckIsNeeded msg))
    (cl:cons ':multipathEstimateIsValid (multipathEstimateIsValid msg))
))
