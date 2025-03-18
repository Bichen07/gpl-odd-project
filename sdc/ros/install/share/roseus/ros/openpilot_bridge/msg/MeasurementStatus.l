;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::MeasurementStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'MeasurementStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEASUREMENTSTATUS")
  (make-package "OPENPILOT_BRIDGE::MEASUREMENTSTATUS"))

(in-package "ROS")
;;//! \htmlinclude MeasurementStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::MeasurementStatus
  :super ros::object
  :slots (_header _glonassTimeMarkValid _lockPointValid _imdJammingIndicator _measuredVelocity _fineOrCoarseVelocity _gpsHighBandwidthNu4 _gpsRxDiversity _gpsHighBandwidthUniform _gpsHighBandwidthNu8 _subMillisecondIsValid _lastUpdateFromDifference _tentativeMeasurement _probationMode _directionIsValid _bitEdgeConfirmedFromSignal _gpsRoundRobinRxDiversity _freshMeasurementIndicator _lteB13TxJammingIndicator _lastUpdateFromVelocityDifference _measurementNotUsable _glonassMeanderBitEdgeValid _gpsLowBandwidthRxDiversityCombined _satelliteTimeIsKnown _strongIndicationOfCrossCorelation _subBitTimeIsKnown _lockPointPositive _multipathIndicator _sirCheckIsNeeded _multipathEstimateIsValid ))

(defmethod openpilot_bridge::MeasurementStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:glonassTimeMarkValid __glonassTimeMarkValid) nil)
    ((:lockPointValid __lockPointValid) nil)
    ((:imdJammingIndicator __imdJammingIndicator) nil)
    ((:measuredVelocity __measuredVelocity) nil)
    ((:fineOrCoarseVelocity __fineOrCoarseVelocity) nil)
    ((:gpsHighBandwidthNu4 __gpsHighBandwidthNu4) nil)
    ((:gpsRxDiversity __gpsRxDiversity) nil)
    ((:gpsHighBandwidthUniform __gpsHighBandwidthUniform) nil)
    ((:gpsHighBandwidthNu8 __gpsHighBandwidthNu8) nil)
    ((:subMillisecondIsValid __subMillisecondIsValid) nil)
    ((:lastUpdateFromDifference __lastUpdateFromDifference) nil)
    ((:tentativeMeasurement __tentativeMeasurement) nil)
    ((:probationMode __probationMode) nil)
    ((:directionIsValid __directionIsValid) nil)
    ((:bitEdgeConfirmedFromSignal __bitEdgeConfirmedFromSignal) nil)
    ((:gpsRoundRobinRxDiversity __gpsRoundRobinRxDiversity) nil)
    ((:freshMeasurementIndicator __freshMeasurementIndicator) nil)
    ((:lteB13TxJammingIndicator __lteB13TxJammingIndicator) nil)
    ((:lastUpdateFromVelocityDifference __lastUpdateFromVelocityDifference) nil)
    ((:measurementNotUsable __measurementNotUsable) nil)
    ((:glonassMeanderBitEdgeValid __glonassMeanderBitEdgeValid) nil)
    ((:gpsLowBandwidthRxDiversityCombined __gpsLowBandwidthRxDiversityCombined) nil)
    ((:satelliteTimeIsKnown __satelliteTimeIsKnown) nil)
    ((:strongIndicationOfCrossCorelation __strongIndicationOfCrossCorelation) nil)
    ((:subBitTimeIsKnown __subBitTimeIsKnown) nil)
    ((:lockPointPositive __lockPointPositive) nil)
    ((:multipathIndicator __multipathIndicator) nil)
    ((:sirCheckIsNeeded __sirCheckIsNeeded) nil)
    ((:multipathEstimateIsValid __multipathEstimateIsValid) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _glonassTimeMarkValid __glonassTimeMarkValid)
   (setq _lockPointValid __lockPointValid)
   (setq _imdJammingIndicator __imdJammingIndicator)
   (setq _measuredVelocity __measuredVelocity)
   (setq _fineOrCoarseVelocity __fineOrCoarseVelocity)
   (setq _gpsHighBandwidthNu4 __gpsHighBandwidthNu4)
   (setq _gpsRxDiversity __gpsRxDiversity)
   (setq _gpsHighBandwidthUniform __gpsHighBandwidthUniform)
   (setq _gpsHighBandwidthNu8 __gpsHighBandwidthNu8)
   (setq _subMillisecondIsValid __subMillisecondIsValid)
   (setq _lastUpdateFromDifference __lastUpdateFromDifference)
   (setq _tentativeMeasurement __tentativeMeasurement)
   (setq _probationMode __probationMode)
   (setq _directionIsValid __directionIsValid)
   (setq _bitEdgeConfirmedFromSignal __bitEdgeConfirmedFromSignal)
   (setq _gpsRoundRobinRxDiversity __gpsRoundRobinRxDiversity)
   (setq _freshMeasurementIndicator __freshMeasurementIndicator)
   (setq _lteB13TxJammingIndicator __lteB13TxJammingIndicator)
   (setq _lastUpdateFromVelocityDifference __lastUpdateFromVelocityDifference)
   (setq _measurementNotUsable __measurementNotUsable)
   (setq _glonassMeanderBitEdgeValid __glonassMeanderBitEdgeValid)
   (setq _gpsLowBandwidthRxDiversityCombined __gpsLowBandwidthRxDiversityCombined)
   (setq _satelliteTimeIsKnown __satelliteTimeIsKnown)
   (setq _strongIndicationOfCrossCorelation __strongIndicationOfCrossCorelation)
   (setq _subBitTimeIsKnown __subBitTimeIsKnown)
   (setq _lockPointPositive __lockPointPositive)
   (setq _multipathIndicator __multipathIndicator)
   (setq _sirCheckIsNeeded __sirCheckIsNeeded)
   (setq _multipathEstimateIsValid __multipathEstimateIsValid)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:glonassTimeMarkValid
   (&optional __glonassTimeMarkValid)
   (if __glonassTimeMarkValid (setq _glonassTimeMarkValid __glonassTimeMarkValid)) _glonassTimeMarkValid)
  (:lockPointValid
   (&optional __lockPointValid)
   (if __lockPointValid (setq _lockPointValid __lockPointValid)) _lockPointValid)
  (:imdJammingIndicator
   (&optional __imdJammingIndicator)
   (if __imdJammingIndicator (setq _imdJammingIndicator __imdJammingIndicator)) _imdJammingIndicator)
  (:measuredVelocity
   (&optional __measuredVelocity)
   (if __measuredVelocity (setq _measuredVelocity __measuredVelocity)) _measuredVelocity)
  (:fineOrCoarseVelocity
   (&optional __fineOrCoarseVelocity)
   (if __fineOrCoarseVelocity (setq _fineOrCoarseVelocity __fineOrCoarseVelocity)) _fineOrCoarseVelocity)
  (:gpsHighBandwidthNu4
   (&optional __gpsHighBandwidthNu4)
   (if __gpsHighBandwidthNu4 (setq _gpsHighBandwidthNu4 __gpsHighBandwidthNu4)) _gpsHighBandwidthNu4)
  (:gpsRxDiversity
   (&optional __gpsRxDiversity)
   (if __gpsRxDiversity (setq _gpsRxDiversity __gpsRxDiversity)) _gpsRxDiversity)
  (:gpsHighBandwidthUniform
   (&optional __gpsHighBandwidthUniform)
   (if __gpsHighBandwidthUniform (setq _gpsHighBandwidthUniform __gpsHighBandwidthUniform)) _gpsHighBandwidthUniform)
  (:gpsHighBandwidthNu8
   (&optional __gpsHighBandwidthNu8)
   (if __gpsHighBandwidthNu8 (setq _gpsHighBandwidthNu8 __gpsHighBandwidthNu8)) _gpsHighBandwidthNu8)
  (:subMillisecondIsValid
   (&optional __subMillisecondIsValid)
   (if __subMillisecondIsValid (setq _subMillisecondIsValid __subMillisecondIsValid)) _subMillisecondIsValid)
  (:lastUpdateFromDifference
   (&optional __lastUpdateFromDifference)
   (if __lastUpdateFromDifference (setq _lastUpdateFromDifference __lastUpdateFromDifference)) _lastUpdateFromDifference)
  (:tentativeMeasurement
   (&optional __tentativeMeasurement)
   (if __tentativeMeasurement (setq _tentativeMeasurement __tentativeMeasurement)) _tentativeMeasurement)
  (:probationMode
   (&optional __probationMode)
   (if __probationMode (setq _probationMode __probationMode)) _probationMode)
  (:directionIsValid
   (&optional __directionIsValid)
   (if __directionIsValid (setq _directionIsValid __directionIsValid)) _directionIsValid)
  (:bitEdgeConfirmedFromSignal
   (&optional __bitEdgeConfirmedFromSignal)
   (if __bitEdgeConfirmedFromSignal (setq _bitEdgeConfirmedFromSignal __bitEdgeConfirmedFromSignal)) _bitEdgeConfirmedFromSignal)
  (:gpsRoundRobinRxDiversity
   (&optional __gpsRoundRobinRxDiversity)
   (if __gpsRoundRobinRxDiversity (setq _gpsRoundRobinRxDiversity __gpsRoundRobinRxDiversity)) _gpsRoundRobinRxDiversity)
  (:freshMeasurementIndicator
   (&optional __freshMeasurementIndicator)
   (if __freshMeasurementIndicator (setq _freshMeasurementIndicator __freshMeasurementIndicator)) _freshMeasurementIndicator)
  (:lteB13TxJammingIndicator
   (&optional __lteB13TxJammingIndicator)
   (if __lteB13TxJammingIndicator (setq _lteB13TxJammingIndicator __lteB13TxJammingIndicator)) _lteB13TxJammingIndicator)
  (:lastUpdateFromVelocityDifference
   (&optional __lastUpdateFromVelocityDifference)
   (if __lastUpdateFromVelocityDifference (setq _lastUpdateFromVelocityDifference __lastUpdateFromVelocityDifference)) _lastUpdateFromVelocityDifference)
  (:measurementNotUsable
   (&optional __measurementNotUsable)
   (if __measurementNotUsable (setq _measurementNotUsable __measurementNotUsable)) _measurementNotUsable)
  (:glonassMeanderBitEdgeValid
   (&optional __glonassMeanderBitEdgeValid)
   (if __glonassMeanderBitEdgeValid (setq _glonassMeanderBitEdgeValid __glonassMeanderBitEdgeValid)) _glonassMeanderBitEdgeValid)
  (:gpsLowBandwidthRxDiversityCombined
   (&optional __gpsLowBandwidthRxDiversityCombined)
   (if __gpsLowBandwidthRxDiversityCombined (setq _gpsLowBandwidthRxDiversityCombined __gpsLowBandwidthRxDiversityCombined)) _gpsLowBandwidthRxDiversityCombined)
  (:satelliteTimeIsKnown
   (&optional __satelliteTimeIsKnown)
   (if __satelliteTimeIsKnown (setq _satelliteTimeIsKnown __satelliteTimeIsKnown)) _satelliteTimeIsKnown)
  (:strongIndicationOfCrossCorelation
   (&optional __strongIndicationOfCrossCorelation)
   (if __strongIndicationOfCrossCorelation (setq _strongIndicationOfCrossCorelation __strongIndicationOfCrossCorelation)) _strongIndicationOfCrossCorelation)
  (:subBitTimeIsKnown
   (&optional __subBitTimeIsKnown)
   (if __subBitTimeIsKnown (setq _subBitTimeIsKnown __subBitTimeIsKnown)) _subBitTimeIsKnown)
  (:lockPointPositive
   (&optional __lockPointPositive)
   (if __lockPointPositive (setq _lockPointPositive __lockPointPositive)) _lockPointPositive)
  (:multipathIndicator
   (&optional __multipathIndicator)
   (if __multipathIndicator (setq _multipathIndicator __multipathIndicator)) _multipathIndicator)
  (:sirCheckIsNeeded
   (&optional __sirCheckIsNeeded)
   (if __sirCheckIsNeeded (setq _sirCheckIsNeeded __sirCheckIsNeeded)) _sirCheckIsNeeded)
  (:multipathEstimateIsValid
   (&optional __multipathEstimateIsValid)
   (if __multipathEstimateIsValid (setq _multipathEstimateIsValid __multipathEstimateIsValid)) _multipathEstimateIsValid)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _glonassTimeMarkValid
    1
    ;; bool _lockPointValid
    1
    ;; bool _imdJammingIndicator
    1
    ;; bool _measuredVelocity
    1
    ;; bool _fineOrCoarseVelocity
    1
    ;; bool _gpsHighBandwidthNu4
    1
    ;; bool _gpsRxDiversity
    1
    ;; bool _gpsHighBandwidthUniform
    1
    ;; bool _gpsHighBandwidthNu8
    1
    ;; bool _subMillisecondIsValid
    1
    ;; bool _lastUpdateFromDifference
    1
    ;; bool _tentativeMeasurement
    1
    ;; bool _probationMode
    1
    ;; bool _directionIsValid
    1
    ;; bool _bitEdgeConfirmedFromSignal
    1
    ;; bool _gpsRoundRobinRxDiversity
    1
    ;; bool _freshMeasurementIndicator
    1
    ;; bool _lteB13TxJammingIndicator
    1
    ;; bool _lastUpdateFromVelocityDifference
    1
    ;; bool _measurementNotUsable
    1
    ;; bool _glonassMeanderBitEdgeValid
    1
    ;; bool _gpsLowBandwidthRxDiversityCombined
    1
    ;; bool _satelliteTimeIsKnown
    1
    ;; bool _strongIndicationOfCrossCorelation
    1
    ;; bool _subBitTimeIsKnown
    1
    ;; bool _lockPointPositive
    1
    ;; bool _multipathIndicator
    1
    ;; bool _sirCheckIsNeeded
    1
    ;; bool _multipathEstimateIsValid
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _glonassTimeMarkValid
       (if _glonassTimeMarkValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _lockPointValid
       (if _lockPointValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _imdJammingIndicator
       (if _imdJammingIndicator (write-byte -1 s) (write-byte 0 s))
     ;; bool _measuredVelocity
       (if _measuredVelocity (write-byte -1 s) (write-byte 0 s))
     ;; bool _fineOrCoarseVelocity
       (if _fineOrCoarseVelocity (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsHighBandwidthNu4
       (if _gpsHighBandwidthNu4 (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsRxDiversity
       (if _gpsRxDiversity (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsHighBandwidthUniform
       (if _gpsHighBandwidthUniform (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsHighBandwidthNu8
       (if _gpsHighBandwidthNu8 (write-byte -1 s) (write-byte 0 s))
     ;; bool _subMillisecondIsValid
       (if _subMillisecondIsValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _lastUpdateFromDifference
       (if _lastUpdateFromDifference (write-byte -1 s) (write-byte 0 s))
     ;; bool _tentativeMeasurement
       (if _tentativeMeasurement (write-byte -1 s) (write-byte 0 s))
     ;; bool _probationMode
       (if _probationMode (write-byte -1 s) (write-byte 0 s))
     ;; bool _directionIsValid
       (if _directionIsValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _bitEdgeConfirmedFromSignal
       (if _bitEdgeConfirmedFromSignal (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsRoundRobinRxDiversity
       (if _gpsRoundRobinRxDiversity (write-byte -1 s) (write-byte 0 s))
     ;; bool _freshMeasurementIndicator
       (if _freshMeasurementIndicator (write-byte -1 s) (write-byte 0 s))
     ;; bool _lteB13TxJammingIndicator
       (if _lteB13TxJammingIndicator (write-byte -1 s) (write-byte 0 s))
     ;; bool _lastUpdateFromVelocityDifference
       (if _lastUpdateFromVelocityDifference (write-byte -1 s) (write-byte 0 s))
     ;; bool _measurementNotUsable
       (if _measurementNotUsable (write-byte -1 s) (write-byte 0 s))
     ;; bool _glonassMeanderBitEdgeValid
       (if _glonassMeanderBitEdgeValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsLowBandwidthRxDiversityCombined
       (if _gpsLowBandwidthRxDiversityCombined (write-byte -1 s) (write-byte 0 s))
     ;; bool _satelliteTimeIsKnown
       (if _satelliteTimeIsKnown (write-byte -1 s) (write-byte 0 s))
     ;; bool _strongIndicationOfCrossCorelation
       (if _strongIndicationOfCrossCorelation (write-byte -1 s) (write-byte 0 s))
     ;; bool _subBitTimeIsKnown
       (if _subBitTimeIsKnown (write-byte -1 s) (write-byte 0 s))
     ;; bool _lockPointPositive
       (if _lockPointPositive (write-byte -1 s) (write-byte 0 s))
     ;; bool _multipathIndicator
       (if _multipathIndicator (write-byte -1 s) (write-byte 0 s))
     ;; bool _sirCheckIsNeeded
       (if _sirCheckIsNeeded (write-byte -1 s) (write-byte 0 s))
     ;; bool _multipathEstimateIsValid
       (if _multipathEstimateIsValid (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _glonassTimeMarkValid
     (setq _glonassTimeMarkValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lockPointValid
     (setq _lockPointValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _imdJammingIndicator
     (setq _imdJammingIndicator (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _measuredVelocity
     (setq _measuredVelocity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fineOrCoarseVelocity
     (setq _fineOrCoarseVelocity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsHighBandwidthNu4
     (setq _gpsHighBandwidthNu4 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsRxDiversity
     (setq _gpsRxDiversity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsHighBandwidthUniform
     (setq _gpsHighBandwidthUniform (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsHighBandwidthNu8
     (setq _gpsHighBandwidthNu8 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _subMillisecondIsValid
     (setq _subMillisecondIsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lastUpdateFromDifference
     (setq _lastUpdateFromDifference (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _tentativeMeasurement
     (setq _tentativeMeasurement (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _probationMode
     (setq _probationMode (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _directionIsValid
     (setq _directionIsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _bitEdgeConfirmedFromSignal
     (setq _bitEdgeConfirmedFromSignal (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsRoundRobinRxDiversity
     (setq _gpsRoundRobinRxDiversity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _freshMeasurementIndicator
     (setq _freshMeasurementIndicator (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lteB13TxJammingIndicator
     (setq _lteB13TxJammingIndicator (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lastUpdateFromVelocityDifference
     (setq _lastUpdateFromVelocityDifference (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _measurementNotUsable
     (setq _measurementNotUsable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _glonassMeanderBitEdgeValid
     (setq _glonassMeanderBitEdgeValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsLowBandwidthRxDiversityCombined
     (setq _gpsLowBandwidthRxDiversityCombined (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _satelliteTimeIsKnown
     (setq _satelliteTimeIsKnown (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _strongIndicationOfCrossCorelation
     (setq _strongIndicationOfCrossCorelation (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _subBitTimeIsKnown
     (setq _subBitTimeIsKnown (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _lockPointPositive
     (setq _lockPointPositive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _multipathIndicator
     (setq _multipathIndicator (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _sirCheckIsNeeded
     (setq _sirCheckIsNeeded (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _multipathEstimateIsValid
     (setq _multipathEstimateIsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::MeasurementStatus :md5sum-) "a21dccf859aded23d20028d0485351fb")
(setf (get openpilot_bridge::MeasurementStatus :datatype-) "openpilot_bridge/MeasurementStatus")
(setf (get openpilot_bridge::MeasurementStatus :definition-)
      "Header header

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



(provide :openpilot_bridge/MeasurementStatus "a21dccf859aded23d20028d0485351fb")


