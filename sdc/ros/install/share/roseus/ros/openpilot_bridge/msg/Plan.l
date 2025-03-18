;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Plan)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Plan (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PLAN")
  (make-package "OPENPILOT_BRIDGE::PLAN"))

(in-package "ROS")
;;//! \htmlinclude Plan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Plan
  :super ros::object
  :slots (_header _decelForTurn _vTarget _lateralValidDEPRECATED _longitudinalPlanSource _hasLead _radarStateMonoTime _jerkFactor _vCurvature _aTarget _mdMonoTime _aTargetMaxDEPRECATED _laneWidthDEPRECATED _radarValid _gpsPlannerActive _fcw _processingDelay _longitudinalValidDEPRECATED _aStart _eventsDEPRECATED _hasRightLaneDEPRECATED _vStart _aCruise _commIssue _vTargetFuture _gpsTrajectory _hasLeftLaneDEPRECATED _vCruise _aTargetMinDEPRECATED _mapValid _radarCanError _vMax _dPolyDEPRECATED ))

(defmethod openpilot_bridge::Plan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:decelForTurn __decelForTurn) nil)
    ((:vTarget __vTarget) 0.0)
    ((:lateralValidDEPRECATED __lateralValidDEPRECATED) nil)
    ((:longitudinalPlanSource __longitudinalPlanSource) 0)
    ((:hasLead __hasLead) nil)
    ((:radarStateMonoTime __radarStateMonoTime) 0)
    ((:jerkFactor __jerkFactor) 0.0)
    ((:vCurvature __vCurvature) 0.0)
    ((:aTarget __aTarget) 0.0)
    ((:mdMonoTime __mdMonoTime) 0)
    ((:aTargetMaxDEPRECATED __aTargetMaxDEPRECATED) 0.0)
    ((:laneWidthDEPRECATED __laneWidthDEPRECATED) 0.0)
    ((:radarValid __radarValid) nil)
    ((:gpsPlannerActive __gpsPlannerActive) nil)
    ((:fcw __fcw) nil)
    ((:processingDelay __processingDelay) 0.0)
    ((:longitudinalValidDEPRECATED __longitudinalValidDEPRECATED) nil)
    ((:aStart __aStart) 0.0)
    ((:eventsDEPRECATED __eventsDEPRECATED) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CarEvent :init) r)) r))
    ((:hasRightLaneDEPRECATED __hasRightLaneDEPRECATED) nil)
    ((:vStart __vStart) 0.0)
    ((:aCruise __aCruise) 0.0)
    ((:commIssue __commIssue) nil)
    ((:vTargetFuture __vTargetFuture) 0.0)
    ((:gpsTrajectory __gpsTrajectory) (instance openpilot_bridge::GpsTrajectory :init))
    ((:hasLeftLaneDEPRECATED __hasLeftLaneDEPRECATED) nil)
    ((:vCruise __vCruise) 0.0)
    ((:aTargetMinDEPRECATED __aTargetMinDEPRECATED) 0.0)
    ((:mapValid __mapValid) nil)
    ((:radarCanError __radarCanError) nil)
    ((:vMax __vMax) 0.0)
    ((:dPolyDEPRECATED __dPolyDEPRECATED) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _decelForTurn __decelForTurn)
   (setq _vTarget (float __vTarget))
   (setq _lateralValidDEPRECATED __lateralValidDEPRECATED)
   (setq _longitudinalPlanSource (round __longitudinalPlanSource))
   (setq _hasLead __hasLead)
   (setq _radarStateMonoTime (round __radarStateMonoTime))
   (setq _jerkFactor (float __jerkFactor))
   (setq _vCurvature (float __vCurvature))
   (setq _aTarget (float __aTarget))
   (setq _mdMonoTime (round __mdMonoTime))
   (setq _aTargetMaxDEPRECATED (float __aTargetMaxDEPRECATED))
   (setq _laneWidthDEPRECATED (float __laneWidthDEPRECATED))
   (setq _radarValid __radarValid)
   (setq _gpsPlannerActive __gpsPlannerActive)
   (setq _fcw __fcw)
   (setq _processingDelay (float __processingDelay))
   (setq _longitudinalValidDEPRECATED __longitudinalValidDEPRECATED)
   (setq _aStart (float __aStart))
   (setq _eventsDEPRECATED __eventsDEPRECATED)
   (setq _hasRightLaneDEPRECATED __hasRightLaneDEPRECATED)
   (setq _vStart (float __vStart))
   (setq _aCruise (float __aCruise))
   (setq _commIssue __commIssue)
   (setq _vTargetFuture (float __vTargetFuture))
   (setq _gpsTrajectory __gpsTrajectory)
   (setq _hasLeftLaneDEPRECATED __hasLeftLaneDEPRECATED)
   (setq _vCruise (float __vCruise))
   (setq _aTargetMinDEPRECATED (float __aTargetMinDEPRECATED))
   (setq _mapValid __mapValid)
   (setq _radarCanError __radarCanError)
   (setq _vMax (float __vMax))
   (setq _dPolyDEPRECATED __dPolyDEPRECATED)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:decelForTurn
   (&optional __decelForTurn)
   (if __decelForTurn (setq _decelForTurn __decelForTurn)) _decelForTurn)
  (:vTarget
   (&optional __vTarget)
   (if __vTarget (setq _vTarget __vTarget)) _vTarget)
  (:lateralValidDEPRECATED
   (&optional __lateralValidDEPRECATED)
   (if __lateralValidDEPRECATED (setq _lateralValidDEPRECATED __lateralValidDEPRECATED)) _lateralValidDEPRECATED)
  (:longitudinalPlanSource
   (&optional __longitudinalPlanSource)
   (if __longitudinalPlanSource (setq _longitudinalPlanSource __longitudinalPlanSource)) _longitudinalPlanSource)
  (:hasLead
   (&optional __hasLead)
   (if __hasLead (setq _hasLead __hasLead)) _hasLead)
  (:radarStateMonoTime
   (&optional __radarStateMonoTime)
   (if __radarStateMonoTime (setq _radarStateMonoTime __radarStateMonoTime)) _radarStateMonoTime)
  (:jerkFactor
   (&optional __jerkFactor)
   (if __jerkFactor (setq _jerkFactor __jerkFactor)) _jerkFactor)
  (:vCurvature
   (&optional __vCurvature)
   (if __vCurvature (setq _vCurvature __vCurvature)) _vCurvature)
  (:aTarget
   (&optional __aTarget)
   (if __aTarget (setq _aTarget __aTarget)) _aTarget)
  (:mdMonoTime
   (&optional __mdMonoTime)
   (if __mdMonoTime (setq _mdMonoTime __mdMonoTime)) _mdMonoTime)
  (:aTargetMaxDEPRECATED
   (&optional __aTargetMaxDEPRECATED)
   (if __aTargetMaxDEPRECATED (setq _aTargetMaxDEPRECATED __aTargetMaxDEPRECATED)) _aTargetMaxDEPRECATED)
  (:laneWidthDEPRECATED
   (&optional __laneWidthDEPRECATED)
   (if __laneWidthDEPRECATED (setq _laneWidthDEPRECATED __laneWidthDEPRECATED)) _laneWidthDEPRECATED)
  (:radarValid
   (&optional __radarValid)
   (if __radarValid (setq _radarValid __radarValid)) _radarValid)
  (:gpsPlannerActive
   (&optional __gpsPlannerActive)
   (if __gpsPlannerActive (setq _gpsPlannerActive __gpsPlannerActive)) _gpsPlannerActive)
  (:fcw
   (&optional __fcw)
   (if __fcw (setq _fcw __fcw)) _fcw)
  (:processingDelay
   (&optional __processingDelay)
   (if __processingDelay (setq _processingDelay __processingDelay)) _processingDelay)
  (:longitudinalValidDEPRECATED
   (&optional __longitudinalValidDEPRECATED)
   (if __longitudinalValidDEPRECATED (setq _longitudinalValidDEPRECATED __longitudinalValidDEPRECATED)) _longitudinalValidDEPRECATED)
  (:aStart
   (&optional __aStart)
   (if __aStart (setq _aStart __aStart)) _aStart)
  (:eventsDEPRECATED
   (&rest __eventsDEPRECATED)
   (if (keywordp (car __eventsDEPRECATED))
       (send* _eventsDEPRECATED __eventsDEPRECATED)
     (progn
       (if __eventsDEPRECATED (setq _eventsDEPRECATED (car __eventsDEPRECATED)))
       _eventsDEPRECATED)))
  (:hasRightLaneDEPRECATED
   (&optional __hasRightLaneDEPRECATED)
   (if __hasRightLaneDEPRECATED (setq _hasRightLaneDEPRECATED __hasRightLaneDEPRECATED)) _hasRightLaneDEPRECATED)
  (:vStart
   (&optional __vStart)
   (if __vStart (setq _vStart __vStart)) _vStart)
  (:aCruise
   (&optional __aCruise)
   (if __aCruise (setq _aCruise __aCruise)) _aCruise)
  (:commIssue
   (&optional __commIssue)
   (if __commIssue (setq _commIssue __commIssue)) _commIssue)
  (:vTargetFuture
   (&optional __vTargetFuture)
   (if __vTargetFuture (setq _vTargetFuture __vTargetFuture)) _vTargetFuture)
  (:gpsTrajectory
   (&rest __gpsTrajectory)
   (if (keywordp (car __gpsTrajectory))
       (send* _gpsTrajectory __gpsTrajectory)
     (progn
       (if __gpsTrajectory (setq _gpsTrajectory (car __gpsTrajectory)))
       _gpsTrajectory)))
  (:hasLeftLaneDEPRECATED
   (&optional __hasLeftLaneDEPRECATED)
   (if __hasLeftLaneDEPRECATED (setq _hasLeftLaneDEPRECATED __hasLeftLaneDEPRECATED)) _hasLeftLaneDEPRECATED)
  (:vCruise
   (&optional __vCruise)
   (if __vCruise (setq _vCruise __vCruise)) _vCruise)
  (:aTargetMinDEPRECATED
   (&optional __aTargetMinDEPRECATED)
   (if __aTargetMinDEPRECATED (setq _aTargetMinDEPRECATED __aTargetMinDEPRECATED)) _aTargetMinDEPRECATED)
  (:mapValid
   (&optional __mapValid)
   (if __mapValid (setq _mapValid __mapValid)) _mapValid)
  (:radarCanError
   (&optional __radarCanError)
   (if __radarCanError (setq _radarCanError __radarCanError)) _radarCanError)
  (:vMax
   (&optional __vMax)
   (if __vMax (setq _vMax __vMax)) _vMax)
  (:dPolyDEPRECATED
   (&optional __dPolyDEPRECATED)
   (if __dPolyDEPRECATED (setq _dPolyDEPRECATED __dPolyDEPRECATED)) _dPolyDEPRECATED)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _decelForTurn
    1
    ;; float32 _vTarget
    4
    ;; bool _lateralValidDEPRECATED
    1
    ;; uint32 _longitudinalPlanSource
    4
    ;; bool _hasLead
    1
    ;; int64 _radarStateMonoTime
    8
    ;; float32 _jerkFactor
    4
    ;; float32 _vCurvature
    4
    ;; float32 _aTarget
    4
    ;; int64 _mdMonoTime
    8
    ;; float32 _aTargetMaxDEPRECATED
    4
    ;; float32 _laneWidthDEPRECATED
    4
    ;; bool _radarValid
    1
    ;; bool _gpsPlannerActive
    1
    ;; bool _fcw
    1
    ;; float32 _processingDelay
    4
    ;; bool _longitudinalValidDEPRECATED
    1
    ;; float32 _aStart
    4
    ;; openpilot_bridge/CarEvent[] _eventsDEPRECATED
    (apply #'+ (send-all _eventsDEPRECATED :serialization-length)) 4
    ;; bool _hasRightLaneDEPRECATED
    1
    ;; float32 _vStart
    4
    ;; float32 _aCruise
    4
    ;; bool _commIssue
    1
    ;; float32 _vTargetFuture
    4
    ;; openpilot_bridge/GpsTrajectory _gpsTrajectory
    (send _gpsTrajectory :serialization-length)
    ;; bool _hasLeftLaneDEPRECATED
    1
    ;; float32 _vCruise
    4
    ;; float32 _aTargetMinDEPRECATED
    4
    ;; bool _mapValid
    1
    ;; bool _radarCanError
    1
    ;; float32 _vMax
    4
    ;; float32[] _dPolyDEPRECATED
    (* 4    (length _dPolyDEPRECATED)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _decelForTurn
       (if _decelForTurn (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vTarget
       (sys::poke _vTarget (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _lateralValidDEPRECATED
       (if _lateralValidDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _longitudinalPlanSource
       (write-long _longitudinalPlanSource s)
     ;; bool _hasLead
       (if _hasLead (write-byte -1 s) (write-byte 0 s))
     ;; int64 _radarStateMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _radarStateMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _radarStateMonoTime) (= (length (_radarStateMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_radarStateMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_radarStateMonoTime . bv) 1) -1) s))
             ((and (class _radarStateMonoTime) (= (length (_radarStateMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_radarStateMonoTime . bv) 0) s)
              (write-long (if (>= _radarStateMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _radarStateMonoTime s)(write-long (if (>= _radarStateMonoTime 0) 0 #xffffffff) s)))
     ;; float32 _jerkFactor
       (sys::poke _jerkFactor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vCurvature
       (sys::poke _vCurvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aTarget
       (sys::poke _aTarget (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _mdMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mdMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mdMonoTime) (= (length (_mdMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mdMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_mdMonoTime . bv) 1) -1) s))
             ((and (class _mdMonoTime) (= (length (_mdMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_mdMonoTime . bv) 0) s)
              (write-long (if (>= _mdMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mdMonoTime s)(write-long (if (>= _mdMonoTime 0) 0 #xffffffff) s)))
     ;; float32 _aTargetMaxDEPRECATED
       (sys::poke _aTargetMaxDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _laneWidthDEPRECATED
       (sys::poke _laneWidthDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _radarValid
       (if _radarValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpsPlannerActive
       (if _gpsPlannerActive (write-byte -1 s) (write-byte 0 s))
     ;; bool _fcw
       (if _fcw (write-byte -1 s) (write-byte 0 s))
     ;; float32 _processingDelay
       (sys::poke _processingDelay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _longitudinalValidDEPRECATED
       (if _longitudinalValidDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;; float32 _aStart
       (sys::poke _aStart (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/CarEvent[] _eventsDEPRECATED
     (write-long (length _eventsDEPRECATED) s)
     (dolist (elem _eventsDEPRECATED)
       (send elem :serialize s)
       )
     ;; bool _hasRightLaneDEPRECATED
       (if _hasRightLaneDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vStart
       (sys::poke _vStart (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aCruise
       (sys::poke _aCruise (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _commIssue
       (if _commIssue (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vTargetFuture
       (sys::poke _vTargetFuture (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/GpsTrajectory _gpsTrajectory
       (send _gpsTrajectory :serialize s)
     ;; bool _hasLeftLaneDEPRECATED
       (if _hasLeftLaneDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vCruise
       (sys::poke _vCruise (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aTargetMinDEPRECATED
       (sys::poke _aTargetMinDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _mapValid
       (if _mapValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _radarCanError
       (if _radarCanError (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vMax
       (sys::poke _vMax (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _dPolyDEPRECATED
     (write-long (length _dPolyDEPRECATED) s)
     (dotimes (i (length _dPolyDEPRECATED))
       (sys::poke (elt _dPolyDEPRECATED i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _decelForTurn
     (setq _decelForTurn (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vTarget
     (setq _vTarget (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _lateralValidDEPRECATED
     (setq _lateralValidDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _longitudinalPlanSource
     (setq _longitudinalPlanSource (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _hasLead
     (setq _hasLead (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _radarStateMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _radarStateMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _radarStateMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _jerkFactor
     (setq _jerkFactor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vCurvature
     (setq _vCurvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aTarget
     (setq _aTarget (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _mdMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _mdMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mdMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _aTargetMaxDEPRECATED
     (setq _aTargetMaxDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _laneWidthDEPRECATED
     (setq _laneWidthDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _radarValid
     (setq _radarValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpsPlannerActive
     (setq _gpsPlannerActive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _fcw
     (setq _fcw (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _processingDelay
     (setq _processingDelay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _longitudinalValidDEPRECATED
     (setq _longitudinalValidDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _aStart
     (setq _aStart (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/CarEvent[] _eventsDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _eventsDEPRECATED (let (r) (dotimes (i n) (push (instance openpilot_bridge::CarEvent :init) r)) r))
     (dolist (elem- _eventsDEPRECATED)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _hasRightLaneDEPRECATED
     (setq _hasRightLaneDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vStart
     (setq _vStart (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aCruise
     (setq _aCruise (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _commIssue
     (setq _commIssue (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vTargetFuture
     (setq _vTargetFuture (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/GpsTrajectory _gpsTrajectory
     (send _gpsTrajectory :deserialize buf ptr-) (incf ptr- (send _gpsTrajectory :serialization-length))
   ;; bool _hasLeftLaneDEPRECATED
     (setq _hasLeftLaneDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vCruise
     (setq _vCruise (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aTargetMinDEPRECATED
     (setq _aTargetMinDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _mapValid
     (setq _mapValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _radarCanError
     (setq _radarCanError (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vMax
     (setq _vMax (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _dPolyDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dPolyDEPRECATED (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _dPolyDEPRECATED i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::Plan :md5sum-) "5122b757463340c2ae5f629a57ec2ba5")
(setf (get openpilot_bridge::Plan :datatype-) "openpilot_bridge/Plan")
(setf (get openpilot_bridge::Plan :definition-)
      "Header header

bool decelForTurn
float32 vTarget
bool lateralValidDEPRECATED
uint32 longitudinalPlanSource # enum const: LongitudinalPlanSource
bool hasLead
int64 radarStateMonoTime
float32 jerkFactor
float32 vCurvature
float32 aTarget
int64 mdMonoTime
float32 aTargetMaxDEPRECATED
float32 laneWidthDEPRECATED
bool radarValid
bool gpsPlannerActive
bool fcw
float32 processingDelay
bool longitudinalValidDEPRECATED
float32 aStart
CarEvent[] eventsDEPRECATED
bool hasRightLaneDEPRECATED
float32 vStart
float32 aCruise
bool commIssue
float32 vTargetFuture
GpsTrajectory gpsTrajectory
bool hasLeftLaneDEPRECATED
float32 vCruise
float32 aTargetMinDEPRECATED
bool mapValid
bool radarCanError
float32 vMax
float32[] dPolyDEPRECATED

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
MSG: openpilot_bridge/CarEvent
Header header

bool enable
bool noEntry
uint32 name # enum const: EventName
bool immediateDisable
bool warning
bool permanent
bool softDisable
bool userDisable
bool preEnable

================================================================================
MSG: openpilot_bridge/GpsTrajectory
Header header

float32[] y
float32[] x

")



(provide :openpilot_bridge/Plan "5122b757463340c2ae5f629a57ec2ba5")


