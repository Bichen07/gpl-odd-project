;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::HealthData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'HealthData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::HEALTHDATA")
  (make-package "OPENPILOT_BRIDGE::HEALTHDATA"))

(in-package "ROS")
;;//! \htmlinclude HealthData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::HealthData
  :super ros::object
  :slots (_header _gasInterceptorDetected _faultStatus _hasGps _fanSpeedRpm _startedSignalDetectedDeprecated _canRxErrs _faults _canFwdErrs _uptime _powerSaveEnabled _current _hwType _ignitionCan _voltage _canSendErrs _usbPowerMode _gmlanSendErrs _ignitionLine _safetyModel _controlsAllowed ))

(defmethod openpilot_bridge::HealthData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gasInterceptorDetected __gasInterceptorDetected) nil)
    ((:faultStatus __faultStatus) 0)
    ((:hasGps __hasGps) nil)
    ((:fanSpeedRpm __fanSpeedRpm) 0)
    ((:startedSignalDetectedDeprecated __startedSignalDetectedDeprecated) nil)
    ((:canRxErrs __canRxErrs) 0)
    ((:faults __faults) (make-array 0 :initial-element 0 :element-type :integer))
    ((:canFwdErrs __canFwdErrs) 0)
    ((:uptime __uptime) 0)
    ((:powerSaveEnabled __powerSaveEnabled) nil)
    ((:current __current) 0)
    ((:hwType __hwType) 0)
    ((:ignitionCan __ignitionCan) nil)
    ((:voltage __voltage) 0)
    ((:canSendErrs __canSendErrs) 0)
    ((:usbPowerMode __usbPowerMode) 0)
    ((:gmlanSendErrs __gmlanSendErrs) 0)
    ((:ignitionLine __ignitionLine) nil)
    ((:safetyModel __safetyModel) 0)
    ((:controlsAllowed __controlsAllowed) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _gasInterceptorDetected __gasInterceptorDetected)
   (setq _faultStatus (round __faultStatus))
   (setq _hasGps __hasGps)
   (setq _fanSpeedRpm (round __fanSpeedRpm))
   (setq _startedSignalDetectedDeprecated __startedSignalDetectedDeprecated)
   (setq _canRxErrs (round __canRxErrs))
   (setq _faults __faults)
   (setq _canFwdErrs (round __canFwdErrs))
   (setq _uptime (round __uptime))
   (setq _powerSaveEnabled __powerSaveEnabled)
   (setq _current (round __current))
   (setq _hwType (round __hwType))
   (setq _ignitionCan __ignitionCan)
   (setq _voltage (round __voltage))
   (setq _canSendErrs (round __canSendErrs))
   (setq _usbPowerMode (round __usbPowerMode))
   (setq _gmlanSendErrs (round __gmlanSendErrs))
   (setq _ignitionLine __ignitionLine)
   (setq _safetyModel (round __safetyModel))
   (setq _controlsAllowed __controlsAllowed)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gasInterceptorDetected
   (&optional __gasInterceptorDetected)
   (if __gasInterceptorDetected (setq _gasInterceptorDetected __gasInterceptorDetected)) _gasInterceptorDetected)
  (:faultStatus
   (&optional __faultStatus)
   (if __faultStatus (setq _faultStatus __faultStatus)) _faultStatus)
  (:hasGps
   (&optional __hasGps)
   (if __hasGps (setq _hasGps __hasGps)) _hasGps)
  (:fanSpeedRpm
   (&optional __fanSpeedRpm)
   (if __fanSpeedRpm (setq _fanSpeedRpm __fanSpeedRpm)) _fanSpeedRpm)
  (:startedSignalDetectedDeprecated
   (&optional __startedSignalDetectedDeprecated)
   (if __startedSignalDetectedDeprecated (setq _startedSignalDetectedDeprecated __startedSignalDetectedDeprecated)) _startedSignalDetectedDeprecated)
  (:canRxErrs
   (&optional __canRxErrs)
   (if __canRxErrs (setq _canRxErrs __canRxErrs)) _canRxErrs)
  (:faults
   (&optional __faults)
   (if __faults (setq _faults __faults)) _faults)
  (:canFwdErrs
   (&optional __canFwdErrs)
   (if __canFwdErrs (setq _canFwdErrs __canFwdErrs)) _canFwdErrs)
  (:uptime
   (&optional __uptime)
   (if __uptime (setq _uptime __uptime)) _uptime)
  (:powerSaveEnabled
   (&optional __powerSaveEnabled)
   (if __powerSaveEnabled (setq _powerSaveEnabled __powerSaveEnabled)) _powerSaveEnabled)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:hwType
   (&optional __hwType)
   (if __hwType (setq _hwType __hwType)) _hwType)
  (:ignitionCan
   (&optional __ignitionCan)
   (if __ignitionCan (setq _ignitionCan __ignitionCan)) _ignitionCan)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:canSendErrs
   (&optional __canSendErrs)
   (if __canSendErrs (setq _canSendErrs __canSendErrs)) _canSendErrs)
  (:usbPowerMode
   (&optional __usbPowerMode)
   (if __usbPowerMode (setq _usbPowerMode __usbPowerMode)) _usbPowerMode)
  (:gmlanSendErrs
   (&optional __gmlanSendErrs)
   (if __gmlanSendErrs (setq _gmlanSendErrs __gmlanSendErrs)) _gmlanSendErrs)
  (:ignitionLine
   (&optional __ignitionLine)
   (if __ignitionLine (setq _ignitionLine __ignitionLine)) _ignitionLine)
  (:safetyModel
   (&optional __safetyModel)
   (if __safetyModel (setq _safetyModel __safetyModel)) _safetyModel)
  (:controlsAllowed
   (&optional __controlsAllowed)
   (if __controlsAllowed (setq _controlsAllowed __controlsAllowed)) _controlsAllowed)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _gasInterceptorDetected
    1
    ;; uint32 _faultStatus
    4
    ;; bool _hasGps
    1
    ;; int64 _fanSpeedRpm
    8
    ;; bool _startedSignalDetectedDeprecated
    1
    ;; int64 _canRxErrs
    8
    ;; uint32[] _faults
    (* 4    (length _faults)) 4
    ;; int64 _canFwdErrs
    8
    ;; int64 _uptime
    8
    ;; bool _powerSaveEnabled
    1
    ;; int64 _current
    8
    ;; uint32 _hwType
    4
    ;; bool _ignitionCan
    1
    ;; int64 _voltage
    8
    ;; int64 _canSendErrs
    8
    ;; uint32 _usbPowerMode
    4
    ;; int64 _gmlanSendErrs
    8
    ;; bool _ignitionLine
    1
    ;; uint32 _safetyModel
    4
    ;; bool _controlsAllowed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _gasInterceptorDetected
       (if _gasInterceptorDetected (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _faultStatus
       (write-long _faultStatus s)
     ;; bool _hasGps
       (if _hasGps (write-byte -1 s) (write-byte 0 s))
     ;; int64 _fanSpeedRpm
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fanSpeedRpm (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fanSpeedRpm) (= (length (_fanSpeedRpm . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fanSpeedRpm . bv) 0) 0) s)
              (write-long (ash (elt (_fanSpeedRpm . bv) 1) -1) s))
             ((and (class _fanSpeedRpm) (= (length (_fanSpeedRpm . bv)) 1)) ;; big1
              (write-long (elt (_fanSpeedRpm . bv) 0) s)
              (write-long (if (>= _fanSpeedRpm 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fanSpeedRpm s)(write-long (if (>= _fanSpeedRpm 0) 0 #xffffffff) s)))
     ;; bool _startedSignalDetectedDeprecated
       (if _startedSignalDetectedDeprecated (write-byte -1 s) (write-byte 0 s))
     ;; int64 _canRxErrs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _canRxErrs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _canRxErrs) (= (length (_canRxErrs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_canRxErrs . bv) 0) 0) s)
              (write-long (ash (elt (_canRxErrs . bv) 1) -1) s))
             ((and (class _canRxErrs) (= (length (_canRxErrs . bv)) 1)) ;; big1
              (write-long (elt (_canRxErrs . bv) 0) s)
              (write-long (if (>= _canRxErrs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _canRxErrs s)(write-long (if (>= _canRxErrs 0) 0 #xffffffff) s)))
     ;; uint32[] _faults
     (write-long (length _faults) s)
     (dotimes (i (length _faults))
       (write-long (elt _faults i) s)
       )
     ;; int64 _canFwdErrs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _canFwdErrs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _canFwdErrs) (= (length (_canFwdErrs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_canFwdErrs . bv) 0) 0) s)
              (write-long (ash (elt (_canFwdErrs . bv) 1) -1) s))
             ((and (class _canFwdErrs) (= (length (_canFwdErrs . bv)) 1)) ;; big1
              (write-long (elt (_canFwdErrs . bv) 0) s)
              (write-long (if (>= _canFwdErrs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _canFwdErrs s)(write-long (if (>= _canFwdErrs 0) 0 #xffffffff) s)))
     ;; int64 _uptime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _uptime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _uptime) (= (length (_uptime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_uptime . bv) 0) 0) s)
              (write-long (ash (elt (_uptime . bv) 1) -1) s))
             ((and (class _uptime) (= (length (_uptime . bv)) 1)) ;; big1
              (write-long (elt (_uptime . bv) 0) s)
              (write-long (if (>= _uptime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _uptime s)(write-long (if (>= _uptime 0) 0 #xffffffff) s)))
     ;; bool _powerSaveEnabled
       (if _powerSaveEnabled (write-byte -1 s) (write-byte 0 s))
     ;; int64 _current
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _current (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _current) (= (length (_current . bv)) 2)) ;; bignum
              (write-long (ash (elt (_current . bv) 0) 0) s)
              (write-long (ash (elt (_current . bv) 1) -1) s))
             ((and (class _current) (= (length (_current . bv)) 1)) ;; big1
              (write-long (elt (_current . bv) 0) s)
              (write-long (if (>= _current 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _current s)(write-long (if (>= _current 0) 0 #xffffffff) s)))
     ;; uint32 _hwType
       (write-long _hwType s)
     ;; bool _ignitionCan
       (if _ignitionCan (write-byte -1 s) (write-byte 0 s))
     ;; int64 _voltage
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _voltage (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _voltage) (= (length (_voltage . bv)) 2)) ;; bignum
              (write-long (ash (elt (_voltage . bv) 0) 0) s)
              (write-long (ash (elt (_voltage . bv) 1) -1) s))
             ((and (class _voltage) (= (length (_voltage . bv)) 1)) ;; big1
              (write-long (elt (_voltage . bv) 0) s)
              (write-long (if (>= _voltage 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _voltage s)(write-long (if (>= _voltage 0) 0 #xffffffff) s)))
     ;; int64 _canSendErrs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _canSendErrs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _canSendErrs) (= (length (_canSendErrs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_canSendErrs . bv) 0) 0) s)
              (write-long (ash (elt (_canSendErrs . bv) 1) -1) s))
             ((and (class _canSendErrs) (= (length (_canSendErrs . bv)) 1)) ;; big1
              (write-long (elt (_canSendErrs . bv) 0) s)
              (write-long (if (>= _canSendErrs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _canSendErrs s)(write-long (if (>= _canSendErrs 0) 0 #xffffffff) s)))
     ;; uint32 _usbPowerMode
       (write-long _usbPowerMode s)
     ;; int64 _gmlanSendErrs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gmlanSendErrs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gmlanSendErrs) (= (length (_gmlanSendErrs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gmlanSendErrs . bv) 0) 0) s)
              (write-long (ash (elt (_gmlanSendErrs . bv) 1) -1) s))
             ((and (class _gmlanSendErrs) (= (length (_gmlanSendErrs . bv)) 1)) ;; big1
              (write-long (elt (_gmlanSendErrs . bv) 0) s)
              (write-long (if (>= _gmlanSendErrs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gmlanSendErrs s)(write-long (if (>= _gmlanSendErrs 0) 0 #xffffffff) s)))
     ;; bool _ignitionLine
       (if _ignitionLine (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _safetyModel
       (write-long _safetyModel s)
     ;; bool _controlsAllowed
       (if _controlsAllowed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _gasInterceptorDetected
     (setq _gasInterceptorDetected (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _faultStatus
     (setq _faultStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _hasGps
     (setq _hasGps (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _fanSpeedRpm
#+(or :alpha :irix6 :x86_64)
      (setf _fanSpeedRpm (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fanSpeedRpm (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _startedSignalDetectedDeprecated
     (setq _startedSignalDetectedDeprecated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _canRxErrs
#+(or :alpha :irix6 :x86_64)
      (setf _canRxErrs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _canRxErrs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32[] _faults
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faults (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _faults i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int64 _canFwdErrs
#+(or :alpha :irix6 :x86_64)
      (setf _canFwdErrs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _canFwdErrs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _uptime
#+(or :alpha :irix6 :x86_64)
      (setf _uptime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _uptime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _powerSaveEnabled
     (setq _powerSaveEnabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _current
#+(or :alpha :irix6 :x86_64)
      (setf _current (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _current (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _hwType
     (setq _hwType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _ignitionCan
     (setq _ignitionCan (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _voltage
#+(or :alpha :irix6 :x86_64)
      (setf _voltage (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _voltage (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _canSendErrs
#+(or :alpha :irix6 :x86_64)
      (setf _canSendErrs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _canSendErrs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _usbPowerMode
     (setq _usbPowerMode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _gmlanSendErrs
#+(or :alpha :irix6 :x86_64)
      (setf _gmlanSendErrs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gmlanSendErrs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _ignitionLine
     (setq _ignitionLine (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _safetyModel
     (setq _safetyModel (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _controlsAllowed
     (setq _controlsAllowed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::HealthData :md5sum-) "383ae8386ab9b895fcd32fe297b6db75")
(setf (get openpilot_bridge::HealthData :datatype-) "openpilot_bridge/HealthData")
(setf (get openpilot_bridge::HealthData :definition-)
      "Header header

bool gasInterceptorDetected
uint32 faultStatus # enum const: FaultStatus
bool hasGps
int64 fanSpeedRpm
bool startedSignalDetectedDeprecated
int64 canRxErrs
uint32[] faults # enum const: FaultType
int64 canFwdErrs
int64 uptime
bool powerSaveEnabled
int64 current
uint32 hwType # enum const: HwType
bool ignitionCan
int64 voltage
int64 canSendErrs
uint32 usbPowerMode # enum const: UsbPowerMode
int64 gmlanSendErrs
bool ignitionLine
uint32 safetyModel # enum const: SafetyModel
bool controlsAllowed

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



(provide :openpilot_bridge/HealthData "383ae8386ab9b895fcd32fe297b6db75")


