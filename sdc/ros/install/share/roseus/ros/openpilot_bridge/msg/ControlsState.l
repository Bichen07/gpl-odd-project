;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ControlsState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ControlsState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CONTROLSSTATE")
  (make-package "OPENPILOT_BRIDGE::CONTROLSSTATE"))

(in-package "ROS")
;;//! \htmlinclude ControlsState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ControlsState
  :super ros::object
  :slots (_header _ufSteerDEPRECATED _angleSteersDes _decelForTurn _steerOverride _rearViewCam _canErrorCounter _lateralControlState _vEgoRaw _forceDecel _alertSound _upSteerDEPRECATED _vEgo _angleSteers _jerkFactor _alertType _aTarget _alertStatus _alertSize _planMonoTime _aTargetMaxDEPRECATED _uiAccelCmd _state _alertBlinkingRate _angleModelBiasDEPRECATED _alertText2 _alertText1 _yDesDEPRECATED _vPid _vTargetLead _decelForModel _gpsPlannerActive _startMonoTime _canMonoTimeDEPRECATED _curvature _upAccelCmd _vCurvature _hudLeadDEPRECATED _active _awarenessStatus _uiSteerDEPRECATED _aEgoDEPRECATED _alertSoundDEPRECATED _ufAccelCmd _vCruise _yActualDEPRECATED _enabled _aTargetMinDEPRECATED _cumLagMs _mapValid _pathPlanMonoTime _engageable _mdMonoTimeDEPRECATED _driverMonitoringOn _canMonoTimes _radarStateMonoTimeDEPRECATED _longControlState ))

(defmethod openpilot_bridge::ControlsState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ufSteerDEPRECATED __ufSteerDEPRECATED) 0.0)
    ((:angleSteersDes __angleSteersDes) 0.0)
    ((:decelForTurn __decelForTurn) nil)
    ((:steerOverride __steerOverride) nil)
    ((:rearViewCam __rearViewCam) nil)
    ((:canErrorCounter __canErrorCounter) 0)
    ((:lateralControlState __lateralControlState) (instance openpilot_bridge::Lateralcontrolstate :init))
    ((:vEgoRaw __vEgoRaw) 0.0)
    ((:forceDecel __forceDecel) nil)
    ((:alertSound __alertSound) 0)
    ((:upSteerDEPRECATED __upSteerDEPRECATED) 0.0)
    ((:vEgo __vEgo) 0.0)
    ((:angleSteers __angleSteers) 0.0)
    ((:jerkFactor __jerkFactor) 0.0)
    ((:alertType __alertType) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:aTarget __aTarget) 0.0)
    ((:alertStatus __alertStatus) 0)
    ((:alertSize __alertSize) 0)
    ((:planMonoTime __planMonoTime) 0)
    ((:aTargetMaxDEPRECATED __aTargetMaxDEPRECATED) 0.0)
    ((:uiAccelCmd __uiAccelCmd) 0.0)
    ((:state __state) 0)
    ((:alertBlinkingRate __alertBlinkingRate) 0.0)
    ((:angleModelBiasDEPRECATED __angleModelBiasDEPRECATED) 0.0)
    ((:alertText2 __alertText2) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:alertText1 __alertText1) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:yDesDEPRECATED __yDesDEPRECATED) 0.0)
    ((:vPid __vPid) 0.0)
    ((:vTargetLead __vTargetLead) 0.0)
    ((:decelForModel __decelForModel) nil)
    ((:gpsPlannerActive __gpsPlannerActive) nil)
    ((:startMonoTime __startMonoTime) 0)
    ((:canMonoTimeDEPRECATED __canMonoTimeDEPRECATED) 0)
    ((:curvature __curvature) 0.0)
    ((:upAccelCmd __upAccelCmd) 0.0)
    ((:vCurvature __vCurvature) 0.0)
    ((:hudLeadDEPRECATED __hudLeadDEPRECATED) 0)
    ((:active __active) nil)
    ((:awarenessStatus __awarenessStatus) 0.0)
    ((:uiSteerDEPRECATED __uiSteerDEPRECATED) 0.0)
    ((:aEgoDEPRECATED __aEgoDEPRECATED) 0.0)
    ((:alertSoundDEPRECATED __alertSoundDEPRECATED) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:ufAccelCmd __ufAccelCmd) 0.0)
    ((:vCruise __vCruise) 0.0)
    ((:yActualDEPRECATED __yActualDEPRECATED) 0.0)
    ((:enabled __enabled) nil)
    ((:aTargetMinDEPRECATED __aTargetMinDEPRECATED) 0.0)
    ((:cumLagMs __cumLagMs) 0.0)
    ((:mapValid __mapValid) nil)
    ((:pathPlanMonoTime __pathPlanMonoTime) 0)
    ((:engageable __engageable) nil)
    ((:mdMonoTimeDEPRECATED __mdMonoTimeDEPRECATED) 0)
    ((:driverMonitoringOn __driverMonitoringOn) nil)
    ((:canMonoTimes __canMonoTimes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:radarStateMonoTimeDEPRECATED __radarStateMonoTimeDEPRECATED) 0)
    ((:longControlState __longControlState) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _ufSteerDEPRECATED (float __ufSteerDEPRECATED))
   (setq _angleSteersDes (float __angleSteersDes))
   (setq _decelForTurn __decelForTurn)
   (setq _steerOverride __steerOverride)
   (setq _rearViewCam __rearViewCam)
   (setq _canErrorCounter (round __canErrorCounter))
   (setq _lateralControlState __lateralControlState)
   (setq _vEgoRaw (float __vEgoRaw))
   (setq _forceDecel __forceDecel)
   (setq _alertSound (round __alertSound))
   (setq _upSteerDEPRECATED (float __upSteerDEPRECATED))
   (setq _vEgo (float __vEgo))
   (setq _angleSteers (float __angleSteers))
   (setq _jerkFactor (float __jerkFactor))
   (setq _alertType __alertType)
   (setq _aTarget (float __aTarget))
   (setq _alertStatus (round __alertStatus))
   (setq _alertSize (round __alertSize))
   (setq _planMonoTime (round __planMonoTime))
   (setq _aTargetMaxDEPRECATED (float __aTargetMaxDEPRECATED))
   (setq _uiAccelCmd (float __uiAccelCmd))
   (setq _state (round __state))
   (setq _alertBlinkingRate (float __alertBlinkingRate))
   (setq _angleModelBiasDEPRECATED (float __angleModelBiasDEPRECATED))
   (setq _alertText2 __alertText2)
   (setq _alertText1 __alertText1)
   (setq _yDesDEPRECATED (float __yDesDEPRECATED))
   (setq _vPid (float __vPid))
   (setq _vTargetLead (float __vTargetLead))
   (setq _decelForModel __decelForModel)
   (setq _gpsPlannerActive __gpsPlannerActive)
   (setq _startMonoTime (round __startMonoTime))
   (setq _canMonoTimeDEPRECATED (round __canMonoTimeDEPRECATED))
   (setq _curvature (float __curvature))
   (setq _upAccelCmd (float __upAccelCmd))
   (setq _vCurvature (float __vCurvature))
   (setq _hudLeadDEPRECATED (round __hudLeadDEPRECATED))
   (setq _active __active)
   (setq _awarenessStatus (float __awarenessStatus))
   (setq _uiSteerDEPRECATED (float __uiSteerDEPRECATED))
   (setq _aEgoDEPRECATED (float __aEgoDEPRECATED))
   (setq _alertSoundDEPRECATED __alertSoundDEPRECATED)
   (setq _ufAccelCmd (float __ufAccelCmd))
   (setq _vCruise (float __vCruise))
   (setq _yActualDEPRECATED (float __yActualDEPRECATED))
   (setq _enabled __enabled)
   (setq _aTargetMinDEPRECATED (float __aTargetMinDEPRECATED))
   (setq _cumLagMs (float __cumLagMs))
   (setq _mapValid __mapValid)
   (setq _pathPlanMonoTime (round __pathPlanMonoTime))
   (setq _engageable __engageable)
   (setq _mdMonoTimeDEPRECATED (round __mdMonoTimeDEPRECATED))
   (setq _driverMonitoringOn __driverMonitoringOn)
   (setq _canMonoTimes __canMonoTimes)
   (setq _radarStateMonoTimeDEPRECATED (round __radarStateMonoTimeDEPRECATED))
   (setq _longControlState (round __longControlState))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:ufSteerDEPRECATED
   (&optional __ufSteerDEPRECATED)
   (if __ufSteerDEPRECATED (setq _ufSteerDEPRECATED __ufSteerDEPRECATED)) _ufSteerDEPRECATED)
  (:angleSteersDes
   (&optional __angleSteersDes)
   (if __angleSteersDes (setq _angleSteersDes __angleSteersDes)) _angleSteersDes)
  (:decelForTurn
   (&optional __decelForTurn)
   (if __decelForTurn (setq _decelForTurn __decelForTurn)) _decelForTurn)
  (:steerOverride
   (&optional __steerOverride)
   (if __steerOverride (setq _steerOverride __steerOverride)) _steerOverride)
  (:rearViewCam
   (&optional __rearViewCam)
   (if __rearViewCam (setq _rearViewCam __rearViewCam)) _rearViewCam)
  (:canErrorCounter
   (&optional __canErrorCounter)
   (if __canErrorCounter (setq _canErrorCounter __canErrorCounter)) _canErrorCounter)
  (:lateralControlState
   (&rest __lateralControlState)
   (if (keywordp (car __lateralControlState))
       (send* _lateralControlState __lateralControlState)
     (progn
       (if __lateralControlState (setq _lateralControlState (car __lateralControlState)))
       _lateralControlState)))
  (:vEgoRaw
   (&optional __vEgoRaw)
   (if __vEgoRaw (setq _vEgoRaw __vEgoRaw)) _vEgoRaw)
  (:forceDecel
   (&optional __forceDecel)
   (if __forceDecel (setq _forceDecel __forceDecel)) _forceDecel)
  (:alertSound
   (&optional __alertSound)
   (if __alertSound (setq _alertSound __alertSound)) _alertSound)
  (:upSteerDEPRECATED
   (&optional __upSteerDEPRECATED)
   (if __upSteerDEPRECATED (setq _upSteerDEPRECATED __upSteerDEPRECATED)) _upSteerDEPRECATED)
  (:vEgo
   (&optional __vEgo)
   (if __vEgo (setq _vEgo __vEgo)) _vEgo)
  (:angleSteers
   (&optional __angleSteers)
   (if __angleSteers (setq _angleSteers __angleSteers)) _angleSteers)
  (:jerkFactor
   (&optional __jerkFactor)
   (if __jerkFactor (setq _jerkFactor __jerkFactor)) _jerkFactor)
  (:alertType
   (&optional __alertType)
   (if __alertType (setq _alertType __alertType)) _alertType)
  (:aTarget
   (&optional __aTarget)
   (if __aTarget (setq _aTarget __aTarget)) _aTarget)
  (:alertStatus
   (&optional __alertStatus)
   (if __alertStatus (setq _alertStatus __alertStatus)) _alertStatus)
  (:alertSize
   (&optional __alertSize)
   (if __alertSize (setq _alertSize __alertSize)) _alertSize)
  (:planMonoTime
   (&optional __planMonoTime)
   (if __planMonoTime (setq _planMonoTime __planMonoTime)) _planMonoTime)
  (:aTargetMaxDEPRECATED
   (&optional __aTargetMaxDEPRECATED)
   (if __aTargetMaxDEPRECATED (setq _aTargetMaxDEPRECATED __aTargetMaxDEPRECATED)) _aTargetMaxDEPRECATED)
  (:uiAccelCmd
   (&optional __uiAccelCmd)
   (if __uiAccelCmd (setq _uiAccelCmd __uiAccelCmd)) _uiAccelCmd)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:alertBlinkingRate
   (&optional __alertBlinkingRate)
   (if __alertBlinkingRate (setq _alertBlinkingRate __alertBlinkingRate)) _alertBlinkingRate)
  (:angleModelBiasDEPRECATED
   (&optional __angleModelBiasDEPRECATED)
   (if __angleModelBiasDEPRECATED (setq _angleModelBiasDEPRECATED __angleModelBiasDEPRECATED)) _angleModelBiasDEPRECATED)
  (:alertText2
   (&optional __alertText2)
   (if __alertText2 (setq _alertText2 __alertText2)) _alertText2)
  (:alertText1
   (&optional __alertText1)
   (if __alertText1 (setq _alertText1 __alertText1)) _alertText1)
  (:yDesDEPRECATED
   (&optional __yDesDEPRECATED)
   (if __yDesDEPRECATED (setq _yDesDEPRECATED __yDesDEPRECATED)) _yDesDEPRECATED)
  (:vPid
   (&optional __vPid)
   (if __vPid (setq _vPid __vPid)) _vPid)
  (:vTargetLead
   (&optional __vTargetLead)
   (if __vTargetLead (setq _vTargetLead __vTargetLead)) _vTargetLead)
  (:decelForModel
   (&optional __decelForModel)
   (if __decelForModel (setq _decelForModel __decelForModel)) _decelForModel)
  (:gpsPlannerActive
   (&optional __gpsPlannerActive)
   (if __gpsPlannerActive (setq _gpsPlannerActive __gpsPlannerActive)) _gpsPlannerActive)
  (:startMonoTime
   (&optional __startMonoTime)
   (if __startMonoTime (setq _startMonoTime __startMonoTime)) _startMonoTime)
  (:canMonoTimeDEPRECATED
   (&optional __canMonoTimeDEPRECATED)
   (if __canMonoTimeDEPRECATED (setq _canMonoTimeDEPRECATED __canMonoTimeDEPRECATED)) _canMonoTimeDEPRECATED)
  (:curvature
   (&optional __curvature)
   (if __curvature (setq _curvature __curvature)) _curvature)
  (:upAccelCmd
   (&optional __upAccelCmd)
   (if __upAccelCmd (setq _upAccelCmd __upAccelCmd)) _upAccelCmd)
  (:vCurvature
   (&optional __vCurvature)
   (if __vCurvature (setq _vCurvature __vCurvature)) _vCurvature)
  (:hudLeadDEPRECATED
   (&optional __hudLeadDEPRECATED)
   (if __hudLeadDEPRECATED (setq _hudLeadDEPRECATED __hudLeadDEPRECATED)) _hudLeadDEPRECATED)
  (:active
   (&optional __active)
   (if __active (setq _active __active)) _active)
  (:awarenessStatus
   (&optional __awarenessStatus)
   (if __awarenessStatus (setq _awarenessStatus __awarenessStatus)) _awarenessStatus)
  (:uiSteerDEPRECATED
   (&optional __uiSteerDEPRECATED)
   (if __uiSteerDEPRECATED (setq _uiSteerDEPRECATED __uiSteerDEPRECATED)) _uiSteerDEPRECATED)
  (:aEgoDEPRECATED
   (&optional __aEgoDEPRECATED)
   (if __aEgoDEPRECATED (setq _aEgoDEPRECATED __aEgoDEPRECATED)) _aEgoDEPRECATED)
  (:alertSoundDEPRECATED
   (&optional __alertSoundDEPRECATED)
   (if __alertSoundDEPRECATED (setq _alertSoundDEPRECATED __alertSoundDEPRECATED)) _alertSoundDEPRECATED)
  (:ufAccelCmd
   (&optional __ufAccelCmd)
   (if __ufAccelCmd (setq _ufAccelCmd __ufAccelCmd)) _ufAccelCmd)
  (:vCruise
   (&optional __vCruise)
   (if __vCruise (setq _vCruise __vCruise)) _vCruise)
  (:yActualDEPRECATED
   (&optional __yActualDEPRECATED)
   (if __yActualDEPRECATED (setq _yActualDEPRECATED __yActualDEPRECATED)) _yActualDEPRECATED)
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:aTargetMinDEPRECATED
   (&optional __aTargetMinDEPRECATED)
   (if __aTargetMinDEPRECATED (setq _aTargetMinDEPRECATED __aTargetMinDEPRECATED)) _aTargetMinDEPRECATED)
  (:cumLagMs
   (&optional __cumLagMs)
   (if __cumLagMs (setq _cumLagMs __cumLagMs)) _cumLagMs)
  (:mapValid
   (&optional __mapValid)
   (if __mapValid (setq _mapValid __mapValid)) _mapValid)
  (:pathPlanMonoTime
   (&optional __pathPlanMonoTime)
   (if __pathPlanMonoTime (setq _pathPlanMonoTime __pathPlanMonoTime)) _pathPlanMonoTime)
  (:engageable
   (&optional __engageable)
   (if __engageable (setq _engageable __engageable)) _engageable)
  (:mdMonoTimeDEPRECATED
   (&optional __mdMonoTimeDEPRECATED)
   (if __mdMonoTimeDEPRECATED (setq _mdMonoTimeDEPRECATED __mdMonoTimeDEPRECATED)) _mdMonoTimeDEPRECATED)
  (:driverMonitoringOn
   (&optional __driverMonitoringOn)
   (if __driverMonitoringOn (setq _driverMonitoringOn __driverMonitoringOn)) _driverMonitoringOn)
  (:canMonoTimes
   (&optional __canMonoTimes)
   (if __canMonoTimes (setq _canMonoTimes __canMonoTimes)) _canMonoTimes)
  (:radarStateMonoTimeDEPRECATED
   (&optional __radarStateMonoTimeDEPRECATED)
   (if __radarStateMonoTimeDEPRECATED (setq _radarStateMonoTimeDEPRECATED __radarStateMonoTimeDEPRECATED)) _radarStateMonoTimeDEPRECATED)
  (:longControlState
   (&optional __longControlState)
   (if __longControlState (setq _longControlState __longControlState)) _longControlState)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _ufSteerDEPRECATED
    4
    ;; float32 _angleSteersDes
    4
    ;; bool _decelForTurn
    1
    ;; bool _steerOverride
    1
    ;; bool _rearViewCam
    1
    ;; int64 _canErrorCounter
    8
    ;; openpilot_bridge/Lateralcontrolstate _lateralControlState
    (send _lateralControlState :serialization-length)
    ;; float32 _vEgoRaw
    4
    ;; bool _forceDecel
    1
    ;; uint32 _alertSound
    4
    ;; float32 _upSteerDEPRECATED
    4
    ;; float32 _vEgo
    4
    ;; float32 _angleSteers
    4
    ;; float32 _jerkFactor
    4
    ;; string[] _alertType
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertType)) 4
    ;; float32 _aTarget
    4
    ;; uint32 _alertStatus
    4
    ;; uint32 _alertSize
    4
    ;; int64 _planMonoTime
    8
    ;; float32 _aTargetMaxDEPRECATED
    4
    ;; float32 _uiAccelCmd
    4
    ;; uint32 _state
    4
    ;; float32 _alertBlinkingRate
    4
    ;; float32 _angleModelBiasDEPRECATED
    4
    ;; string[] _alertText2
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertText2)) 4
    ;; string[] _alertText1
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertText1)) 4
    ;; float32 _yDesDEPRECATED
    4
    ;; float32 _vPid
    4
    ;; float32 _vTargetLead
    4
    ;; bool _decelForModel
    1
    ;; bool _gpsPlannerActive
    1
    ;; int64 _startMonoTime
    8
    ;; int64 _canMonoTimeDEPRECATED
    8
    ;; float32 _curvature
    4
    ;; float32 _upAccelCmd
    4
    ;; float32 _vCurvature
    4
    ;; int32 _hudLeadDEPRECATED
    4
    ;; bool _active
    1
    ;; float32 _awarenessStatus
    4
    ;; float32 _uiSteerDEPRECATED
    4
    ;; float32 _aEgoDEPRECATED
    4
    ;; string[] _alertSoundDEPRECATED
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertSoundDEPRECATED)) 4
    ;; float32 _ufAccelCmd
    4
    ;; float32 _vCruise
    4
    ;; float32 _yActualDEPRECATED
    4
    ;; bool _enabled
    1
    ;; float32 _aTargetMinDEPRECATED
    4
    ;; float32 _cumLagMs
    4
    ;; bool _mapValid
    1
    ;; int64 _pathPlanMonoTime
    8
    ;; bool _engageable
    1
    ;; int64 _mdMonoTimeDEPRECATED
    8
    ;; bool _driverMonitoringOn
    1
    ;; int64[] _canMonoTimes
    (* 8    (length _canMonoTimes)) 4
    ;; int64 _radarStateMonoTimeDEPRECATED
    8
    ;; uint32 _longControlState
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _ufSteerDEPRECATED
       (sys::poke _ufSteerDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleSteersDes
       (sys::poke _angleSteersDes (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _decelForTurn
       (if _decelForTurn (write-byte -1 s) (write-byte 0 s))
     ;; bool _steerOverride
       (if _steerOverride (write-byte -1 s) (write-byte 0 s))
     ;; bool _rearViewCam
       (if _rearViewCam (write-byte -1 s) (write-byte 0 s))
     ;; int64 _canErrorCounter
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _canErrorCounter (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _canErrorCounter) (= (length (_canErrorCounter . bv)) 2)) ;; bignum
              (write-long (ash (elt (_canErrorCounter . bv) 0) 0) s)
              (write-long (ash (elt (_canErrorCounter . bv) 1) -1) s))
             ((and (class _canErrorCounter) (= (length (_canErrorCounter . bv)) 1)) ;; big1
              (write-long (elt (_canErrorCounter . bv) 0) s)
              (write-long (if (>= _canErrorCounter 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _canErrorCounter s)(write-long (if (>= _canErrorCounter 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/Lateralcontrolstate _lateralControlState
       (send _lateralControlState :serialize s)
     ;; float32 _vEgoRaw
       (sys::poke _vEgoRaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _forceDecel
       (if _forceDecel (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _alertSound
       (write-long _alertSound s)
     ;; float32 _upSteerDEPRECATED
       (sys::poke _upSteerDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vEgo
       (sys::poke _vEgo (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleSteers
       (sys::poke _angleSteers (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _jerkFactor
       (sys::poke _jerkFactor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _alertType
     (write-long (length _alertType) s)
     (dolist (elem _alertType)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _aTarget
       (sys::poke _aTarget (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _alertStatus
       (write-long _alertStatus s)
     ;; uint32 _alertSize
       (write-long _alertSize s)
     ;; int64 _planMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _planMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _planMonoTime) (= (length (_planMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_planMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_planMonoTime . bv) 1) -1) s))
             ((and (class _planMonoTime) (= (length (_planMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_planMonoTime . bv) 0) s)
              (write-long (if (>= _planMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _planMonoTime s)(write-long (if (>= _planMonoTime 0) 0 #xffffffff) s)))
     ;; float32 _aTargetMaxDEPRECATED
       (sys::poke _aTargetMaxDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _uiAccelCmd
       (sys::poke _uiAccelCmd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _state
       (write-long _state s)
     ;; float32 _alertBlinkingRate
       (sys::poke _alertBlinkingRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleModelBiasDEPRECATED
       (sys::poke _angleModelBiasDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _alertText2
     (write-long (length _alertText2) s)
     (dolist (elem _alertText2)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _alertText1
     (write-long (length _alertText1) s)
     (dolist (elem _alertText1)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _yDesDEPRECATED
       (sys::poke _yDesDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vPid
       (sys::poke _vPid (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vTargetLead
       (sys::poke _vTargetLead (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _decelForModel
       (if _decelForModel (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsPlannerActive
       (if _gpsPlannerActive (write-byte -1 s) (write-byte 0 s))
     ;; int64 _startMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _startMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _startMonoTime) (= (length (_startMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_startMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_startMonoTime . bv) 1) -1) s))
             ((and (class _startMonoTime) (= (length (_startMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_startMonoTime . bv) 0) s)
              (write-long (if (>= _startMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _startMonoTime s)(write-long (if (>= _startMonoTime 0) 0 #xffffffff) s)))
     ;; int64 _canMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _canMonoTimeDEPRECATED (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _canMonoTimeDEPRECATED) (= (length (_canMonoTimeDEPRECATED . bv)) 2)) ;; bignum
              (write-long (ash (elt (_canMonoTimeDEPRECATED . bv) 0) 0) s)
              (write-long (ash (elt (_canMonoTimeDEPRECATED . bv) 1) -1) s))
             ((and (class _canMonoTimeDEPRECATED) (= (length (_canMonoTimeDEPRECATED . bv)) 1)) ;; big1
              (write-long (elt (_canMonoTimeDEPRECATED . bv) 0) s)
              (write-long (if (>= _canMonoTimeDEPRECATED 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _canMonoTimeDEPRECATED s)(write-long (if (>= _canMonoTimeDEPRECATED 0) 0 #xffffffff) s)))
     ;; float32 _curvature
       (sys::poke _curvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _upAccelCmd
       (sys::poke _upAccelCmd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vCurvature
       (sys::poke _vCurvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _hudLeadDEPRECATED
       (write-long _hudLeadDEPRECATED s)
     ;; bool _active
       (if _active (write-byte -1 s) (write-byte 0 s))
     ;; float32 _awarenessStatus
       (sys::poke _awarenessStatus (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _uiSteerDEPRECATED
       (sys::poke _uiSteerDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aEgoDEPRECATED
       (sys::poke _aEgoDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _alertSoundDEPRECATED
     (write-long (length _alertSoundDEPRECATED) s)
     (dolist (elem _alertSoundDEPRECATED)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _ufAccelCmd
       (sys::poke _ufAccelCmd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vCruise
       (sys::poke _vCruise (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yActualDEPRECATED
       (sys::poke _yActualDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;; float32 _aTargetMinDEPRECATED
       (sys::poke _aTargetMinDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cumLagMs
       (sys::poke _cumLagMs (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _mapValid
       (if _mapValid (write-byte -1 s) (write-byte 0 s))
     ;; int64 _pathPlanMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _pathPlanMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _pathPlanMonoTime) (= (length (_pathPlanMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_pathPlanMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_pathPlanMonoTime . bv) 1) -1) s))
             ((and (class _pathPlanMonoTime) (= (length (_pathPlanMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_pathPlanMonoTime . bv) 0) s)
              (write-long (if (>= _pathPlanMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _pathPlanMonoTime s)(write-long (if (>= _pathPlanMonoTime 0) 0 #xffffffff) s)))
     ;; bool _engageable
       (if _engageable (write-byte -1 s) (write-byte 0 s))
     ;; int64 _mdMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mdMonoTimeDEPRECATED (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mdMonoTimeDEPRECATED) (= (length (_mdMonoTimeDEPRECATED . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mdMonoTimeDEPRECATED . bv) 0) 0) s)
              (write-long (ash (elt (_mdMonoTimeDEPRECATED . bv) 1) -1) s))
             ((and (class _mdMonoTimeDEPRECATED) (= (length (_mdMonoTimeDEPRECATED . bv)) 1)) ;; big1
              (write-long (elt (_mdMonoTimeDEPRECATED . bv) 0) s)
              (write-long (if (>= _mdMonoTimeDEPRECATED 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mdMonoTimeDEPRECATED s)(write-long (if (>= _mdMonoTimeDEPRECATED 0) 0 #xffffffff) s)))
     ;; bool _driverMonitoringOn
       (if _driverMonitoringOn (write-byte -1 s) (write-byte 0 s))
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
     ;; int64 _radarStateMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _radarStateMonoTimeDEPRECATED (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _radarStateMonoTimeDEPRECATED) (= (length (_radarStateMonoTimeDEPRECATED . bv)) 2)) ;; bignum
              (write-long (ash (elt (_radarStateMonoTimeDEPRECATED . bv) 0) 0) s)
              (write-long (ash (elt (_radarStateMonoTimeDEPRECATED . bv) 1) -1) s))
             ((and (class _radarStateMonoTimeDEPRECATED) (= (length (_radarStateMonoTimeDEPRECATED . bv)) 1)) ;; big1
              (write-long (elt (_radarStateMonoTimeDEPRECATED . bv) 0) s)
              (write-long (if (>= _radarStateMonoTimeDEPRECATED 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _radarStateMonoTimeDEPRECATED s)(write-long (if (>= _radarStateMonoTimeDEPRECATED 0) 0 #xffffffff) s)))
     ;; uint32 _longControlState
       (write-long _longControlState s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _ufSteerDEPRECATED
     (setq _ufSteerDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleSteersDes
     (setq _angleSteersDes (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _decelForTurn
     (setq _decelForTurn (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _steerOverride
     (setq _steerOverride (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rearViewCam
     (setq _rearViewCam (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _canErrorCounter
#+(or :alpha :irix6 :x86_64)
      (setf _canErrorCounter (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _canErrorCounter (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/Lateralcontrolstate _lateralControlState
     (send _lateralControlState :deserialize buf ptr-) (incf ptr- (send _lateralControlState :serialization-length))
   ;; float32 _vEgoRaw
     (setq _vEgoRaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _forceDecel
     (setq _forceDecel (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _alertSound
     (setq _alertSound (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _upSteerDEPRECATED
     (setq _upSteerDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vEgo
     (setq _vEgo (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleSteers
     (setq _angleSteers (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _jerkFactor
     (setq _jerkFactor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _alertType
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertType (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertType i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _aTarget
     (setq _aTarget (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _alertStatus
     (setq _alertStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _alertSize
     (setq _alertSize (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _planMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _planMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _planMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _aTargetMaxDEPRECATED
     (setq _aTargetMaxDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _uiAccelCmd
     (setq _uiAccelCmd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _state
     (setq _state (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _alertBlinkingRate
     (setq _alertBlinkingRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleModelBiasDEPRECATED
     (setq _angleModelBiasDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _alertText2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertText2 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertText2 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _alertText1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertText1 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertText1 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _yDesDEPRECATED
     (setq _yDesDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vPid
     (setq _vPid (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vTargetLead
     (setq _vTargetLead (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _decelForModel
     (setq _decelForModel (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsPlannerActive
     (setq _gpsPlannerActive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _startMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _startMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _startMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _canMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
      (setf _canMonoTimeDEPRECATED (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _canMonoTimeDEPRECATED (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _curvature
     (setq _curvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _upAccelCmd
     (setq _upAccelCmd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vCurvature
     (setq _vCurvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _hudLeadDEPRECATED
     (setq _hudLeadDEPRECATED (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _active
     (setq _active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _awarenessStatus
     (setq _awarenessStatus (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _uiSteerDEPRECATED
     (setq _uiSteerDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aEgoDEPRECATED
     (setq _aEgoDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _alertSoundDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertSoundDEPRECATED (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertSoundDEPRECATED i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _ufAccelCmd
     (setq _ufAccelCmd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vCruise
     (setq _vCruise (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yActualDEPRECATED
     (setq _yActualDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _aTargetMinDEPRECATED
     (setq _aTargetMinDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cumLagMs
     (setq _cumLagMs (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _mapValid
     (setq _mapValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _pathPlanMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _pathPlanMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _pathPlanMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _engageable
     (setq _engageable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _mdMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
      (setf _mdMonoTimeDEPRECATED (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mdMonoTimeDEPRECATED (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _driverMonitoringOn
     (setq _driverMonitoringOn (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
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
   ;; int64 _radarStateMonoTimeDEPRECATED
#+(or :alpha :irix6 :x86_64)
      (setf _radarStateMonoTimeDEPRECATED (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _radarStateMonoTimeDEPRECATED (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _longControlState
     (setq _longControlState (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::ControlsState :md5sum-) "0a15b01853a70f5b28cd348ddb6112ec")
(setf (get openpilot_bridge::ControlsState :datatype-) "openpilot_bridge/ControlsState")
(setf (get openpilot_bridge::ControlsState :definition-)
      "Header header

float32 ufSteerDEPRECATED
float32 angleSteersDes
bool decelForTurn
bool steerOverride
bool rearViewCam
int64 canErrorCounter
Lateralcontrolstate lateralControlState
float32 vEgoRaw
bool forceDecel
uint32 alertSound # enum const: AudibleAlert
float32 upSteerDEPRECATED
float32 vEgo
float32 angleSteers
float32 jerkFactor
string[] alertType
float32 aTarget
uint32 alertStatus # enum const: AlertStatus
uint32 alertSize # enum const: AlertSize
int64 planMonoTime
float32 aTargetMaxDEPRECATED
float32 uiAccelCmd
uint32 state # enum const: OpenpilotState
float32 alertBlinkingRate
float32 angleModelBiasDEPRECATED
string[] alertText2
string[] alertText1
float32 yDesDEPRECATED
float32 vPid
float32 vTargetLead
bool decelForModel
bool gpsPlannerActive
int64 startMonoTime
int64 canMonoTimeDEPRECATED
float32 curvature
float32 upAccelCmd
float32 vCurvature
int32 hudLeadDEPRECATED
bool active
float32 awarenessStatus
float32 uiSteerDEPRECATED
float32 aEgoDEPRECATED
string[] alertSoundDEPRECATED
float32 ufAccelCmd
float32 vCruise
float32 yActualDEPRECATED
bool enabled
float32 aTargetMinDEPRECATED
float32 cumLagMs
bool mapValid
int64 pathPlanMonoTime
bool engageable
int64 mdMonoTimeDEPRECATED
bool driverMonitoringOn
int64[] canMonoTimes
int64 radarStateMonoTimeDEPRECATED
uint32 longControlState # enum const: LongControlState

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
MSG: openpilot_bridge/Lateralcontrolstate
Header header

LateralLQRState lqrState
LateralPIDState pidState
LateralINDIState indiState

================================================================================
MSG: openpilot_bridge/LateralLQRState
Header header

bool saturated
float32 i
float32 lqrOutput
bool active
float32 output
float32 steerAngle

================================================================================
MSG: openpilot_bridge/LateralPIDState
Header header

bool saturated
float32 p
float32 steerRate
float32 f
float32 i
float32 angleError
bool active
float32 output
float32 steerAngle

================================================================================
MSG: openpilot_bridge/LateralINDIState
Header header

float32 rateSetPoint
float32 delayedOutput
bool saturated
float32 steerAccel
float32 steerRate
float32 delta
float32 accelError
float32 accelSetPoint
bool active
float32 output
float32 steerAngle

")



(provide :openpilot_bridge/ControlsState "0a15b01853a70f5b28cd348ddb6112ec")


