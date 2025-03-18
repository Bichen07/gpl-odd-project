;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CarParams)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CarParams (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CARPARAMS")
  (make-package "OPENPILOT_BRIDGE::CARPARAMS"))

(in-package "ROS")
;;//! \htmlinclude CarParams.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CarParams
  :super ros::object
  :slots (_header _safetyParam _steerRatioRear _enableDsu _lateralTuning _steerControlType _carFingerprint _rotationalInertia _safetyModelPassive _carFw _minEnableSpeed _enableGasInterceptor _radarOffCan _steerRatio _vEgoStopping _enableCamera _enableCruise _tireStiffnessFront _minSteerSpeed _stoppingControl _steerLimitTimer _transmissionType _steerMaxV _openpilotLongitudinalControl _gasMaxBP _enableApgs _radarTimeStep _carName _safetyModel _carVin _steerMaxBP _gasMaxV _steerRateCost _brakeMaxV _tireStiffnessRear _centerToFront _dashcamOnly _startAccel _wheelbase _brakeMaxBP _mass _steerActuatorDelay _longitudinalTuning _directAccelControl _communityFeature _isPandaBlack _steerLimitAlert ))

(defmethod openpilot_bridge::CarParams
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:safetyParam __safetyParam) 0)
    ((:steerRatioRear __steerRatioRear) 0.0)
    ((:enableDsu __enableDsu) nil)
    ((:lateralTuning __lateralTuning) (instance openpilot_bridge::Lateraltuning :init))
    ((:steerControlType __steerControlType) 0)
    ((:carFingerprint __carFingerprint) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:rotationalInertia __rotationalInertia) 0.0)
    ((:safetyModelPassive __safetyModelPassive) 0)
    ((:carFw __carFw) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CarFw :init) r)) r))
    ((:minEnableSpeed __minEnableSpeed) 0.0)
    ((:enableGasInterceptor __enableGasInterceptor) nil)
    ((:radarOffCan __radarOffCan) nil)
    ((:steerRatio __steerRatio) 0.0)
    ((:vEgoStopping __vEgoStopping) 0.0)
    ((:enableCamera __enableCamera) nil)
    ((:enableCruise __enableCruise) nil)
    ((:tireStiffnessFront __tireStiffnessFront) 0.0)
    ((:minSteerSpeed __minSteerSpeed) 0.0)
    ((:stoppingControl __stoppingControl) nil)
    ((:steerLimitTimer __steerLimitTimer) 0.0)
    ((:transmissionType __transmissionType) 0)
    ((:steerMaxV __steerMaxV) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:openpilotLongitudinalControl __openpilotLongitudinalControl) nil)
    ((:gasMaxBP __gasMaxBP) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:enableApgs __enableApgs) nil)
    ((:radarTimeStep __radarTimeStep) 0.0)
    ((:carName __carName) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:safetyModel __safetyModel) 0)
    ((:carVin __carVin) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:steerMaxBP __steerMaxBP) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:gasMaxV __gasMaxV) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:steerRateCost __steerRateCost) 0.0)
    ((:brakeMaxV __brakeMaxV) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:tireStiffnessRear __tireStiffnessRear) 0.0)
    ((:centerToFront __centerToFront) 0.0)
    ((:dashcamOnly __dashcamOnly) nil)
    ((:startAccel __startAccel) 0.0)
    ((:wheelbase __wheelbase) 0.0)
    ((:brakeMaxBP __brakeMaxBP) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:mass __mass) 0.0)
    ((:steerActuatorDelay __steerActuatorDelay) 0.0)
    ((:longitudinalTuning __longitudinalTuning) (instance openpilot_bridge::LongitudinalPIDTuning :init))
    ((:directAccelControl __directAccelControl) nil)
    ((:communityFeature __communityFeature) nil)
    ((:isPandaBlack __isPandaBlack) nil)
    ((:steerLimitAlert __steerLimitAlert) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _safetyParam (round __safetyParam))
   (setq _steerRatioRear (float __steerRatioRear))
   (setq _enableDsu __enableDsu)
   (setq _lateralTuning __lateralTuning)
   (setq _steerControlType (round __steerControlType))
   (setq _carFingerprint __carFingerprint)
   (setq _rotationalInertia (float __rotationalInertia))
   (setq _safetyModelPassive (round __safetyModelPassive))
   (setq _carFw __carFw)
   (setq _minEnableSpeed (float __minEnableSpeed))
   (setq _enableGasInterceptor __enableGasInterceptor)
   (setq _radarOffCan __radarOffCan)
   (setq _steerRatio (float __steerRatio))
   (setq _vEgoStopping (float __vEgoStopping))
   (setq _enableCamera __enableCamera)
   (setq _enableCruise __enableCruise)
   (setq _tireStiffnessFront (float __tireStiffnessFront))
   (setq _minSteerSpeed (float __minSteerSpeed))
   (setq _stoppingControl __stoppingControl)
   (setq _steerLimitTimer (float __steerLimitTimer))
   (setq _transmissionType (round __transmissionType))
   (setq _steerMaxV __steerMaxV)
   (setq _openpilotLongitudinalControl __openpilotLongitudinalControl)
   (setq _gasMaxBP __gasMaxBP)
   (setq _enableApgs __enableApgs)
   (setq _radarTimeStep (float __radarTimeStep))
   (setq _carName __carName)
   (setq _safetyModel (round __safetyModel))
   (setq _carVin __carVin)
   (setq _steerMaxBP __steerMaxBP)
   (setq _gasMaxV __gasMaxV)
   (setq _steerRateCost (float __steerRateCost))
   (setq _brakeMaxV __brakeMaxV)
   (setq _tireStiffnessRear (float __tireStiffnessRear))
   (setq _centerToFront (float __centerToFront))
   (setq _dashcamOnly __dashcamOnly)
   (setq _startAccel (float __startAccel))
   (setq _wheelbase (float __wheelbase))
   (setq _brakeMaxBP __brakeMaxBP)
   (setq _mass (float __mass))
   (setq _steerActuatorDelay (float __steerActuatorDelay))
   (setq _longitudinalTuning __longitudinalTuning)
   (setq _directAccelControl __directAccelControl)
   (setq _communityFeature __communityFeature)
   (setq _isPandaBlack __isPandaBlack)
   (setq _steerLimitAlert __steerLimitAlert)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:safetyParam
   (&optional __safetyParam)
   (if __safetyParam (setq _safetyParam __safetyParam)) _safetyParam)
  (:steerRatioRear
   (&optional __steerRatioRear)
   (if __steerRatioRear (setq _steerRatioRear __steerRatioRear)) _steerRatioRear)
  (:enableDsu
   (&optional __enableDsu)
   (if __enableDsu (setq _enableDsu __enableDsu)) _enableDsu)
  (:lateralTuning
   (&rest __lateralTuning)
   (if (keywordp (car __lateralTuning))
       (send* _lateralTuning __lateralTuning)
     (progn
       (if __lateralTuning (setq _lateralTuning (car __lateralTuning)))
       _lateralTuning)))
  (:steerControlType
   (&optional __steerControlType)
   (if __steerControlType (setq _steerControlType __steerControlType)) _steerControlType)
  (:carFingerprint
   (&optional __carFingerprint)
   (if __carFingerprint (setq _carFingerprint __carFingerprint)) _carFingerprint)
  (:rotationalInertia
   (&optional __rotationalInertia)
   (if __rotationalInertia (setq _rotationalInertia __rotationalInertia)) _rotationalInertia)
  (:safetyModelPassive
   (&optional __safetyModelPassive)
   (if __safetyModelPassive (setq _safetyModelPassive __safetyModelPassive)) _safetyModelPassive)
  (:carFw
   (&rest __carFw)
   (if (keywordp (car __carFw))
       (send* _carFw __carFw)
     (progn
       (if __carFw (setq _carFw (car __carFw)))
       _carFw)))
  (:minEnableSpeed
   (&optional __minEnableSpeed)
   (if __minEnableSpeed (setq _minEnableSpeed __minEnableSpeed)) _minEnableSpeed)
  (:enableGasInterceptor
   (&optional __enableGasInterceptor)
   (if __enableGasInterceptor (setq _enableGasInterceptor __enableGasInterceptor)) _enableGasInterceptor)
  (:radarOffCan
   (&optional __radarOffCan)
   (if __radarOffCan (setq _radarOffCan __radarOffCan)) _radarOffCan)
  (:steerRatio
   (&optional __steerRatio)
   (if __steerRatio (setq _steerRatio __steerRatio)) _steerRatio)
  (:vEgoStopping
   (&optional __vEgoStopping)
   (if __vEgoStopping (setq _vEgoStopping __vEgoStopping)) _vEgoStopping)
  (:enableCamera
   (&optional __enableCamera)
   (if __enableCamera (setq _enableCamera __enableCamera)) _enableCamera)
  (:enableCruise
   (&optional __enableCruise)
   (if __enableCruise (setq _enableCruise __enableCruise)) _enableCruise)
  (:tireStiffnessFront
   (&optional __tireStiffnessFront)
   (if __tireStiffnessFront (setq _tireStiffnessFront __tireStiffnessFront)) _tireStiffnessFront)
  (:minSteerSpeed
   (&optional __minSteerSpeed)
   (if __minSteerSpeed (setq _minSteerSpeed __minSteerSpeed)) _minSteerSpeed)
  (:stoppingControl
   (&optional __stoppingControl)
   (if __stoppingControl (setq _stoppingControl __stoppingControl)) _stoppingControl)
  (:steerLimitTimer
   (&optional __steerLimitTimer)
   (if __steerLimitTimer (setq _steerLimitTimer __steerLimitTimer)) _steerLimitTimer)
  (:transmissionType
   (&optional __transmissionType)
   (if __transmissionType (setq _transmissionType __transmissionType)) _transmissionType)
  (:steerMaxV
   (&optional __steerMaxV)
   (if __steerMaxV (setq _steerMaxV __steerMaxV)) _steerMaxV)
  (:openpilotLongitudinalControl
   (&optional __openpilotLongitudinalControl)
   (if __openpilotLongitudinalControl (setq _openpilotLongitudinalControl __openpilotLongitudinalControl)) _openpilotLongitudinalControl)
  (:gasMaxBP
   (&optional __gasMaxBP)
   (if __gasMaxBP (setq _gasMaxBP __gasMaxBP)) _gasMaxBP)
  (:enableApgs
   (&optional __enableApgs)
   (if __enableApgs (setq _enableApgs __enableApgs)) _enableApgs)
  (:radarTimeStep
   (&optional __radarTimeStep)
   (if __radarTimeStep (setq _radarTimeStep __radarTimeStep)) _radarTimeStep)
  (:carName
   (&optional __carName)
   (if __carName (setq _carName __carName)) _carName)
  (:safetyModel
   (&optional __safetyModel)
   (if __safetyModel (setq _safetyModel __safetyModel)) _safetyModel)
  (:carVin
   (&optional __carVin)
   (if __carVin (setq _carVin __carVin)) _carVin)
  (:steerMaxBP
   (&optional __steerMaxBP)
   (if __steerMaxBP (setq _steerMaxBP __steerMaxBP)) _steerMaxBP)
  (:gasMaxV
   (&optional __gasMaxV)
   (if __gasMaxV (setq _gasMaxV __gasMaxV)) _gasMaxV)
  (:steerRateCost
   (&optional __steerRateCost)
   (if __steerRateCost (setq _steerRateCost __steerRateCost)) _steerRateCost)
  (:brakeMaxV
   (&optional __brakeMaxV)
   (if __brakeMaxV (setq _brakeMaxV __brakeMaxV)) _brakeMaxV)
  (:tireStiffnessRear
   (&optional __tireStiffnessRear)
   (if __tireStiffnessRear (setq _tireStiffnessRear __tireStiffnessRear)) _tireStiffnessRear)
  (:centerToFront
   (&optional __centerToFront)
   (if __centerToFront (setq _centerToFront __centerToFront)) _centerToFront)
  (:dashcamOnly
   (&optional __dashcamOnly)
   (if __dashcamOnly (setq _dashcamOnly __dashcamOnly)) _dashcamOnly)
  (:startAccel
   (&optional __startAccel)
   (if __startAccel (setq _startAccel __startAccel)) _startAccel)
  (:wheelbase
   (&optional __wheelbase)
   (if __wheelbase (setq _wheelbase __wheelbase)) _wheelbase)
  (:brakeMaxBP
   (&optional __brakeMaxBP)
   (if __brakeMaxBP (setq _brakeMaxBP __brakeMaxBP)) _brakeMaxBP)
  (:mass
   (&optional __mass)
   (if __mass (setq _mass __mass)) _mass)
  (:steerActuatorDelay
   (&optional __steerActuatorDelay)
   (if __steerActuatorDelay (setq _steerActuatorDelay __steerActuatorDelay)) _steerActuatorDelay)
  (:longitudinalTuning
   (&rest __longitudinalTuning)
   (if (keywordp (car __longitudinalTuning))
       (send* _longitudinalTuning __longitudinalTuning)
     (progn
       (if __longitudinalTuning (setq _longitudinalTuning (car __longitudinalTuning)))
       _longitudinalTuning)))
  (:directAccelControl
   (&optional __directAccelControl)
   (if __directAccelControl (setq _directAccelControl __directAccelControl)) _directAccelControl)
  (:communityFeature
   (&optional __communityFeature)
   (if __communityFeature (setq _communityFeature __communityFeature)) _communityFeature)
  (:isPandaBlack
   (&optional __isPandaBlack)
   (if __isPandaBlack (setq _isPandaBlack __isPandaBlack)) _isPandaBlack)
  (:steerLimitAlert
   (&optional __steerLimitAlert)
   (if __steerLimitAlert (setq _steerLimitAlert __steerLimitAlert)) _steerLimitAlert)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _safetyParam
    4
    ;; float32 _steerRatioRear
    4
    ;; bool _enableDsu
    1
    ;; openpilot_bridge/Lateraltuning _lateralTuning
    (send _lateralTuning :serialization-length)
    ;; uint32 _steerControlType
    4
    ;; string[] _carFingerprint
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _carFingerprint)) 4
    ;; float32 _rotationalInertia
    4
    ;; uint32 _safetyModelPassive
    4
    ;; openpilot_bridge/CarFw[] _carFw
    (apply #'+ (send-all _carFw :serialization-length)) 4
    ;; float32 _minEnableSpeed
    4
    ;; bool _enableGasInterceptor
    1
    ;; bool _radarOffCan
    1
    ;; float32 _steerRatio
    4
    ;; float32 _vEgoStopping
    4
    ;; bool _enableCamera
    1
    ;; bool _enableCruise
    1
    ;; float32 _tireStiffnessFront
    4
    ;; float32 _minSteerSpeed
    4
    ;; bool _stoppingControl
    1
    ;; float32 _steerLimitTimer
    4
    ;; uint32 _transmissionType
    4
    ;; float32[] _steerMaxV
    (* 4    (length _steerMaxV)) 4
    ;; bool _openpilotLongitudinalControl
    1
    ;; float32[] _gasMaxBP
    (* 4    (length _gasMaxBP)) 4
    ;; bool _enableApgs
    1
    ;; float32 _radarTimeStep
    4
    ;; string[] _carName
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _carName)) 4
    ;; uint32 _safetyModel
    4
    ;; string[] _carVin
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _carVin)) 4
    ;; float32[] _steerMaxBP
    (* 4    (length _steerMaxBP)) 4
    ;; float32[] _gasMaxV
    (* 4    (length _gasMaxV)) 4
    ;; float32 _steerRateCost
    4
    ;; float32[] _brakeMaxV
    (* 4    (length _brakeMaxV)) 4
    ;; float32 _tireStiffnessRear
    4
    ;; float32 _centerToFront
    4
    ;; bool _dashcamOnly
    1
    ;; float32 _startAccel
    4
    ;; float32 _wheelbase
    4
    ;; float32[] _brakeMaxBP
    (* 4    (length _brakeMaxBP)) 4
    ;; float32 _mass
    4
    ;; float32 _steerActuatorDelay
    4
    ;; openpilot_bridge/LongitudinalPIDTuning _longitudinalTuning
    (send _longitudinalTuning :serialization-length)
    ;; bool _directAccelControl
    1
    ;; bool _communityFeature
    1
    ;; bool _isPandaBlack
    1
    ;; bool _steerLimitAlert
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _safetyParam
       (write-long _safetyParam s)
     ;; float32 _steerRatioRear
       (sys::poke _steerRatioRear (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enableDsu
       (if _enableDsu (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/Lateraltuning _lateralTuning
       (send _lateralTuning :serialize s)
     ;; uint32 _steerControlType
       (write-long _steerControlType s)
     ;; string[] _carFingerprint
     (write-long (length _carFingerprint) s)
     (dolist (elem _carFingerprint)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _rotationalInertia
       (sys::poke _rotationalInertia (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _safetyModelPassive
       (write-long _safetyModelPassive s)
     ;; openpilot_bridge/CarFw[] _carFw
     (write-long (length _carFw) s)
     (dolist (elem _carFw)
       (send elem :serialize s)
       )
     ;; float32 _minEnableSpeed
       (sys::poke _minEnableSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enableGasInterceptor
       (if _enableGasInterceptor (write-byte -1 s) (write-byte 0 s))
     ;; bool _radarOffCan
       (if _radarOffCan (write-byte -1 s) (write-byte 0 s))
     ;; float32 _steerRatio
       (sys::poke _steerRatio (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vEgoStopping
       (sys::poke _vEgoStopping (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enableCamera
       (if _enableCamera (write-byte -1 s) (write-byte 0 s))
     ;; bool _enableCruise
       (if _enableCruise (write-byte -1 s) (write-byte 0 s))
     ;; float32 _tireStiffnessFront
       (sys::poke _tireStiffnessFront (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _minSteerSpeed
       (sys::poke _minSteerSpeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _stoppingControl
       (if _stoppingControl (write-byte -1 s) (write-byte 0 s))
     ;; float32 _steerLimitTimer
       (sys::poke _steerLimitTimer (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _transmissionType
       (write-long _transmissionType s)
     ;; float32[] _steerMaxV
     (write-long (length _steerMaxV) s)
     (dotimes (i (length _steerMaxV))
       (sys::poke (elt _steerMaxV i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _openpilotLongitudinalControl
       (if _openpilotLongitudinalControl (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _gasMaxBP
     (write-long (length _gasMaxBP) s)
     (dotimes (i (length _gasMaxBP))
       (sys::poke (elt _gasMaxBP i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _enableApgs
       (if _enableApgs (write-byte -1 s) (write-byte 0 s))
     ;; float32 _radarTimeStep
       (sys::poke _radarTimeStep (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _carName
     (write-long (length _carName) s)
     (dolist (elem _carName)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint32 _safetyModel
       (write-long _safetyModel s)
     ;; string[] _carVin
     (write-long (length _carVin) s)
     (dolist (elem _carVin)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32[] _steerMaxBP
     (write-long (length _steerMaxBP) s)
     (dotimes (i (length _steerMaxBP))
       (sys::poke (elt _steerMaxBP i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _gasMaxV
     (write-long (length _gasMaxV) s)
     (dotimes (i (length _gasMaxV))
       (sys::poke (elt _gasMaxV i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _steerRateCost
       (sys::poke _steerRateCost (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _brakeMaxV
     (write-long (length _brakeMaxV) s)
     (dotimes (i (length _brakeMaxV))
       (sys::poke (elt _brakeMaxV i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _tireStiffnessRear
       (sys::poke _tireStiffnessRear (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _centerToFront
       (sys::poke _centerToFront (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _dashcamOnly
       (if _dashcamOnly (write-byte -1 s) (write-byte 0 s))
     ;; float32 _startAccel
       (sys::poke _startAccel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _wheelbase
       (sys::poke _wheelbase (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _brakeMaxBP
     (write-long (length _brakeMaxBP) s)
     (dotimes (i (length _brakeMaxBP))
       (sys::poke (elt _brakeMaxBP i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _mass
       (sys::poke _mass (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerActuatorDelay
       (sys::poke _steerActuatorDelay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/LongitudinalPIDTuning _longitudinalTuning
       (send _longitudinalTuning :serialize s)
     ;; bool _directAccelControl
       (if _directAccelControl (write-byte -1 s) (write-byte 0 s))
     ;; bool _communityFeature
       (if _communityFeature (write-byte -1 s) (write-byte 0 s))
     ;; bool _isPandaBlack
       (if _isPandaBlack (write-byte -1 s) (write-byte 0 s))
     ;; bool _steerLimitAlert
       (if _steerLimitAlert (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _safetyParam
     (setq _safetyParam (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _steerRatioRear
     (setq _steerRatioRear (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enableDsu
     (setq _enableDsu (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/Lateraltuning _lateralTuning
     (send _lateralTuning :deserialize buf ptr-) (incf ptr- (send _lateralTuning :serialization-length))
   ;; uint32 _steerControlType
     (setq _steerControlType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _carFingerprint
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carFingerprint (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _carFingerprint i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _rotationalInertia
     (setq _rotationalInertia (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _safetyModelPassive
     (setq _safetyModelPassive (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/CarFw[] _carFw
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carFw (let (r) (dotimes (i n) (push (instance openpilot_bridge::CarFw :init) r)) r))
     (dolist (elem- _carFw)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32 _minEnableSpeed
     (setq _minEnableSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enableGasInterceptor
     (setq _enableGasInterceptor (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _radarOffCan
     (setq _radarOffCan (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _steerRatio
     (setq _steerRatio (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vEgoStopping
     (setq _vEgoStopping (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enableCamera
     (setq _enableCamera (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _enableCruise
     (setq _enableCruise (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _tireStiffnessFront
     (setq _tireStiffnessFront (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _minSteerSpeed
     (setq _minSteerSpeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _stoppingControl
     (setq _stoppingControl (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _steerLimitTimer
     (setq _steerLimitTimer (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _transmissionType
     (setq _transmissionType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _steerMaxV
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _steerMaxV (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _steerMaxV i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _openpilotLongitudinalControl
     (setq _openpilotLongitudinalControl (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _gasMaxBP
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gasMaxBP (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _gasMaxBP i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _enableApgs
     (setq _enableApgs (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _radarTimeStep
     (setq _radarTimeStep (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _carName
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carName (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _carName i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint32 _safetyModel
     (setq _safetyModel (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _carVin
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carVin (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _carVin i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32[] _steerMaxBP
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _steerMaxBP (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _steerMaxBP i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _gasMaxV
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gasMaxV (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _gasMaxV i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _steerRateCost
     (setq _steerRateCost (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _brakeMaxV
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _brakeMaxV (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _brakeMaxV i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _tireStiffnessRear
     (setq _tireStiffnessRear (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _centerToFront
     (setq _centerToFront (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _dashcamOnly
     (setq _dashcamOnly (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _startAccel
     (setq _startAccel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _wheelbase
     (setq _wheelbase (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _brakeMaxBP
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _brakeMaxBP (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _brakeMaxBP i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _mass
     (setq _mass (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerActuatorDelay
     (setq _steerActuatorDelay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/LongitudinalPIDTuning _longitudinalTuning
     (send _longitudinalTuning :deserialize buf ptr-) (incf ptr- (send _longitudinalTuning :serialization-length))
   ;; bool _directAccelControl
     (setq _directAccelControl (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _communityFeature
     (setq _communityFeature (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _isPandaBlack
     (setq _isPandaBlack (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _steerLimitAlert
     (setq _steerLimitAlert (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::CarParams :md5sum-) "ef560c6163951e81bdbf13272f514bb1")
(setf (get openpilot_bridge::CarParams :datatype-) "openpilot_bridge/CarParams")
(setf (get openpilot_bridge::CarParams :definition-)
      "Header header

int32 safetyParam
float32 steerRatioRear
bool enableDsu
Lateraltuning lateralTuning
uint32 steerControlType # enum const: SteerControlType
string[] carFingerprint
float32 rotationalInertia
uint32 safetyModelPassive # enum const: SafetyModel
CarFw[] carFw
float32 minEnableSpeed
bool enableGasInterceptor
bool radarOffCan
float32 steerRatio
float32 vEgoStopping
bool enableCamera
bool enableCruise
float32 tireStiffnessFront
float32 minSteerSpeed
bool stoppingControl
float32 steerLimitTimer
uint32 transmissionType # enum const: TransmissionType
float32[] steerMaxV
bool openpilotLongitudinalControl
float32[] gasMaxBP
bool enableApgs
float32 radarTimeStep
string[] carName
uint32 safetyModel # enum const: SafetyModel
string[] carVin
float32[] steerMaxBP
float32[] gasMaxV
float32 steerRateCost
float32[] brakeMaxV
float32 tireStiffnessRear
float32 centerToFront
bool dashcamOnly
float32 startAccel
float32 wheelbase
float32[] brakeMaxBP
float32 mass
float32 steerActuatorDelay
LongitudinalPIDTuning longitudinalTuning
bool directAccelControl
bool communityFeature
bool isPandaBlack
bool steerLimitAlert

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
MSG: openpilot_bridge/Lateraltuning
Header header

LateralINDITuning indi
LateralPIDTuning pid
LateralLQRTuning lqr

================================================================================
MSG: openpilot_bridge/LateralINDITuning
Header header

float32 actuatorEffectiveness
float32 outerLoopGain
float32 innerLoopGain
float32 timeConstant

================================================================================
MSG: openpilot_bridge/LateralPIDTuning
Header header

float32[] kiBP
float32 kf
float32[] kiV
float32[] kpV
float32[] kpBP

================================================================================
MSG: openpilot_bridge/LateralLQRTuning
Header header

float32[] a
float32[] c
float32 scale
float32 ki
float32[] l
float32[] b
float32 dcGain
float32[] k

================================================================================
MSG: openpilot_bridge/CarFw
Header header

uint32 ecu # enum const: Ecu
int64 subAddress
string[] fwVersion
int64 address

================================================================================
MSG: openpilot_bridge/LongitudinalPIDTuning
Header header

float32[] kpV
float32[] kpBP
float32[] deadzoneBP
float32[] kiV
float32[] deadzoneV
float32[] kiBP

")



(provide :openpilot_bridge/CarParams "ef560c6163951e81bdbf13272f514bb1")


