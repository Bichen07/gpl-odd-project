;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ThermalData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ThermalData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::THERMALDATA")
  (make-package "OPENPILOT_BRIDGE::THERMALDATA"))

(in-package "ROS")
;;//! \htmlinclude ThermalData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ThermalData
  :super ros::object
  :slots (_header _batteryVoltage _chargingError _cpuPerc _chargingDisabled _fanSpeed _batteryCurrent _started _pa0 _batteryPercent _gpu _thermalStatus _freeSpace _usbOnline _mem _cpu2 _cpu3 _cpu0 _cpu1 _startedTs _batteryStatus _memUsedPercent _bat ))

(defmethod openpilot_bridge::ThermalData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:batteryVoltage __batteryVoltage) 0)
    ((:chargingError __chargingError) nil)
    ((:cpuPerc __cpuPerc) 0)
    ((:chargingDisabled __chargingDisabled) nil)
    ((:fanSpeed __fanSpeed) 0)
    ((:batteryCurrent __batteryCurrent) 0)
    ((:started __started) nil)
    ((:pa0 __pa0) 0)
    ((:batteryPercent __batteryPercent) 0)
    ((:gpu __gpu) 0)
    ((:thermalStatus __thermalStatus) 0)
    ((:freeSpace __freeSpace) 0.0)
    ((:usbOnline __usbOnline) nil)
    ((:mem __mem) 0)
    ((:cpu2 __cpu2) 0)
    ((:cpu3 __cpu3) 0)
    ((:cpu0 __cpu0) 0)
    ((:cpu1 __cpu1) 0)
    ((:startedTs __startedTs) 0)
    ((:batteryStatus __batteryStatus) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:memUsedPercent __memUsedPercent) 0)
    ((:bat __bat) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _batteryVoltage (round __batteryVoltage))
   (setq _chargingError __chargingError)
   (setq _cpuPerc (round __cpuPerc))
   (setq _chargingDisabled __chargingDisabled)
   (setq _fanSpeed (round __fanSpeed))
   (setq _batteryCurrent (round __batteryCurrent))
   (setq _started __started)
   (setq _pa0 (round __pa0))
   (setq _batteryPercent (round __batteryPercent))
   (setq _gpu (round __gpu))
   (setq _thermalStatus (round __thermalStatus))
   (setq _freeSpace (float __freeSpace))
   (setq _usbOnline __usbOnline)
   (setq _mem (round __mem))
   (setq _cpu2 (round __cpu2))
   (setq _cpu3 (round __cpu3))
   (setq _cpu0 (round __cpu0))
   (setq _cpu1 (round __cpu1))
   (setq _startedTs (round __startedTs))
   (setq _batteryStatus __batteryStatus)
   (setq _memUsedPercent (round __memUsedPercent))
   (setq _bat (round __bat))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:batteryVoltage
   (&optional __batteryVoltage)
   (if __batteryVoltage (setq _batteryVoltage __batteryVoltage)) _batteryVoltage)
  (:chargingError
   (&optional __chargingError)
   (if __chargingError (setq _chargingError __chargingError)) _chargingError)
  (:cpuPerc
   (&optional __cpuPerc)
   (if __cpuPerc (setq _cpuPerc __cpuPerc)) _cpuPerc)
  (:chargingDisabled
   (&optional __chargingDisabled)
   (if __chargingDisabled (setq _chargingDisabled __chargingDisabled)) _chargingDisabled)
  (:fanSpeed
   (&optional __fanSpeed)
   (if __fanSpeed (setq _fanSpeed __fanSpeed)) _fanSpeed)
  (:batteryCurrent
   (&optional __batteryCurrent)
   (if __batteryCurrent (setq _batteryCurrent __batteryCurrent)) _batteryCurrent)
  (:started
   (&optional __started)
   (if __started (setq _started __started)) _started)
  (:pa0
   (&optional __pa0)
   (if __pa0 (setq _pa0 __pa0)) _pa0)
  (:batteryPercent
   (&optional __batteryPercent)
   (if __batteryPercent (setq _batteryPercent __batteryPercent)) _batteryPercent)
  (:gpu
   (&optional __gpu)
   (if __gpu (setq _gpu __gpu)) _gpu)
  (:thermalStatus
   (&optional __thermalStatus)
   (if __thermalStatus (setq _thermalStatus __thermalStatus)) _thermalStatus)
  (:freeSpace
   (&optional __freeSpace)
   (if __freeSpace (setq _freeSpace __freeSpace)) _freeSpace)
  (:usbOnline
   (&optional __usbOnline)
   (if __usbOnline (setq _usbOnline __usbOnline)) _usbOnline)
  (:mem
   (&optional __mem)
   (if __mem (setq _mem __mem)) _mem)
  (:cpu2
   (&optional __cpu2)
   (if __cpu2 (setq _cpu2 __cpu2)) _cpu2)
  (:cpu3
   (&optional __cpu3)
   (if __cpu3 (setq _cpu3 __cpu3)) _cpu3)
  (:cpu0
   (&optional __cpu0)
   (if __cpu0 (setq _cpu0 __cpu0)) _cpu0)
  (:cpu1
   (&optional __cpu1)
   (if __cpu1 (setq _cpu1 __cpu1)) _cpu1)
  (:startedTs
   (&optional __startedTs)
   (if __startedTs (setq _startedTs __startedTs)) _startedTs)
  (:batteryStatus
   (&optional __batteryStatus)
   (if __batteryStatus (setq _batteryStatus __batteryStatus)) _batteryStatus)
  (:memUsedPercent
   (&optional __memUsedPercent)
   (if __memUsedPercent (setq _memUsedPercent __memUsedPercent)) _memUsedPercent)
  (:bat
   (&optional __bat)
   (if __bat (setq _bat __bat)) _bat)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _batteryVoltage
    4
    ;; bool _chargingError
    1
    ;; int32 _cpuPerc
    4
    ;; bool _chargingDisabled
    1
    ;; int64 _fanSpeed
    8
    ;; int32 _batteryCurrent
    4
    ;; bool _started
    1
    ;; int64 _pa0
    8
    ;; int32 _batteryPercent
    4
    ;; int64 _gpu
    8
    ;; uint32 _thermalStatus
    4
    ;; float32 _freeSpace
    4
    ;; bool _usbOnline
    1
    ;; int64 _mem
    8
    ;; int64 _cpu2
    8
    ;; int64 _cpu3
    8
    ;; int64 _cpu0
    8
    ;; int64 _cpu1
    8
    ;; int64 _startedTs
    8
    ;; string[] _batteryStatus
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _batteryStatus)) 4
    ;; int32 _memUsedPercent
    4
    ;; int64 _bat
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _batteryVoltage
       (write-long _batteryVoltage s)
     ;; bool _chargingError
       (if _chargingError (write-byte -1 s) (write-byte 0 s))
     ;; int32 _cpuPerc
       (write-long _cpuPerc s)
     ;; bool _chargingDisabled
       (if _chargingDisabled (write-byte -1 s) (write-byte 0 s))
     ;; int64 _fanSpeed
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fanSpeed (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fanSpeed) (= (length (_fanSpeed . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fanSpeed . bv) 0) 0) s)
              (write-long (ash (elt (_fanSpeed . bv) 1) -1) s))
             ((and (class _fanSpeed) (= (length (_fanSpeed . bv)) 1)) ;; big1
              (write-long (elt (_fanSpeed . bv) 0) s)
              (write-long (if (>= _fanSpeed 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fanSpeed s)(write-long (if (>= _fanSpeed 0) 0 #xffffffff) s)))
     ;; int32 _batteryCurrent
       (write-long _batteryCurrent s)
     ;; bool _started
       (if _started (write-byte -1 s) (write-byte 0 s))
     ;; int64 _pa0
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _pa0 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _pa0) (= (length (_pa0 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_pa0 . bv) 0) 0) s)
              (write-long (ash (elt (_pa0 . bv) 1) -1) s))
             ((and (class _pa0) (= (length (_pa0 . bv)) 1)) ;; big1
              (write-long (elt (_pa0 . bv) 0) s)
              (write-long (if (>= _pa0 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _pa0 s)(write-long (if (>= _pa0 0) 0 #xffffffff) s)))
     ;; int32 _batteryPercent
       (write-long _batteryPercent s)
     ;; int64 _gpu
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gpu (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gpu) (= (length (_gpu . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gpu . bv) 0) 0) s)
              (write-long (ash (elt (_gpu . bv) 1) -1) s))
             ((and (class _gpu) (= (length (_gpu . bv)) 1)) ;; big1
              (write-long (elt (_gpu . bv) 0) s)
              (write-long (if (>= _gpu 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gpu s)(write-long (if (>= _gpu 0) 0 #xffffffff) s)))
     ;; uint32 _thermalStatus
       (write-long _thermalStatus s)
     ;; float32 _freeSpace
       (sys::poke _freeSpace (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _usbOnline
       (if _usbOnline (write-byte -1 s) (write-byte 0 s))
     ;; int64 _mem
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mem (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mem) (= (length (_mem . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mem . bv) 0) 0) s)
              (write-long (ash (elt (_mem . bv) 1) -1) s))
             ((and (class _mem) (= (length (_mem . bv)) 1)) ;; big1
              (write-long (elt (_mem . bv) 0) s)
              (write-long (if (>= _mem 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mem s)(write-long (if (>= _mem 0) 0 #xffffffff) s)))
     ;; int64 _cpu2
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cpu2 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cpu2) (= (length (_cpu2 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cpu2 . bv) 0) 0) s)
              (write-long (ash (elt (_cpu2 . bv) 1) -1) s))
             ((and (class _cpu2) (= (length (_cpu2 . bv)) 1)) ;; big1
              (write-long (elt (_cpu2 . bv) 0) s)
              (write-long (if (>= _cpu2 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cpu2 s)(write-long (if (>= _cpu2 0) 0 #xffffffff) s)))
     ;; int64 _cpu3
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cpu3 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cpu3) (= (length (_cpu3 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cpu3 . bv) 0) 0) s)
              (write-long (ash (elt (_cpu3 . bv) 1) -1) s))
             ((and (class _cpu3) (= (length (_cpu3 . bv)) 1)) ;; big1
              (write-long (elt (_cpu3 . bv) 0) s)
              (write-long (if (>= _cpu3 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cpu3 s)(write-long (if (>= _cpu3 0) 0 #xffffffff) s)))
     ;; int64 _cpu0
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cpu0 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cpu0) (= (length (_cpu0 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cpu0 . bv) 0) 0) s)
              (write-long (ash (elt (_cpu0 . bv) 1) -1) s))
             ((and (class _cpu0) (= (length (_cpu0 . bv)) 1)) ;; big1
              (write-long (elt (_cpu0 . bv) 0) s)
              (write-long (if (>= _cpu0 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cpu0 s)(write-long (if (>= _cpu0 0) 0 #xffffffff) s)))
     ;; int64 _cpu1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cpu1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cpu1) (= (length (_cpu1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cpu1 . bv) 0) 0) s)
              (write-long (ash (elt (_cpu1 . bv) 1) -1) s))
             ((and (class _cpu1) (= (length (_cpu1 . bv)) 1)) ;; big1
              (write-long (elt (_cpu1 . bv) 0) s)
              (write-long (if (>= _cpu1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cpu1 s)(write-long (if (>= _cpu1 0) 0 #xffffffff) s)))
     ;; int64 _startedTs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _startedTs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _startedTs) (= (length (_startedTs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_startedTs . bv) 0) 0) s)
              (write-long (ash (elt (_startedTs . bv) 1) -1) s))
             ((and (class _startedTs) (= (length (_startedTs . bv)) 1)) ;; big1
              (write-long (elt (_startedTs . bv) 0) s)
              (write-long (if (>= _startedTs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _startedTs s)(write-long (if (>= _startedTs 0) 0 #xffffffff) s)))
     ;; string[] _batteryStatus
     (write-long (length _batteryStatus) s)
     (dolist (elem _batteryStatus)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _memUsedPercent
       (write-long _memUsedPercent s)
     ;; int64 _bat
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bat (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bat) (= (length (_bat . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bat . bv) 0) 0) s)
              (write-long (ash (elt (_bat . bv) 1) -1) s))
             ((and (class _bat) (= (length (_bat . bv)) 1)) ;; big1
              (write-long (elt (_bat . bv) 0) s)
              (write-long (if (>= _bat 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bat s)(write-long (if (>= _bat 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _batteryVoltage
     (setq _batteryVoltage (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _chargingError
     (setq _chargingError (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _cpuPerc
     (setq _cpuPerc (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _chargingDisabled
     (setq _chargingDisabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _fanSpeed
#+(or :alpha :irix6 :x86_64)
      (setf _fanSpeed (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fanSpeed (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _batteryCurrent
     (setq _batteryCurrent (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _started
     (setq _started (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _pa0
#+(or :alpha :irix6 :x86_64)
      (setf _pa0 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _pa0 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _batteryPercent
     (setq _batteryPercent (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _gpu
#+(or :alpha :irix6 :x86_64)
      (setf _gpu (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gpu (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _thermalStatus
     (setq _thermalStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _freeSpace
     (setq _freeSpace (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _usbOnline
     (setq _usbOnline (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _mem
#+(or :alpha :irix6 :x86_64)
      (setf _mem (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mem (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _cpu2
#+(or :alpha :irix6 :x86_64)
      (setf _cpu2 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cpu2 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _cpu3
#+(or :alpha :irix6 :x86_64)
      (setf _cpu3 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cpu3 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _cpu0
#+(or :alpha :irix6 :x86_64)
      (setf _cpu0 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cpu0 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _cpu1
#+(or :alpha :irix6 :x86_64)
      (setf _cpu1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cpu1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _startedTs
#+(or :alpha :irix6 :x86_64)
      (setf _startedTs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _startedTs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _batteryStatus
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _batteryStatus (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _batteryStatus i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _memUsedPercent
     (setq _memUsedPercent (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _bat
#+(or :alpha :irix6 :x86_64)
      (setf _bat (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bat (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get openpilot_bridge::ThermalData :md5sum-) "b82c596c149fdb826f5238d89c0ed390")
(setf (get openpilot_bridge::ThermalData :datatype-) "openpilot_bridge/ThermalData")
(setf (get openpilot_bridge::ThermalData :definition-)
      "Header header

int32 batteryVoltage
bool chargingError
int32 cpuPerc
bool chargingDisabled
int64 fanSpeed
int32 batteryCurrent
bool started
int64 pa0
int32 batteryPercent
int64 gpu
uint32 thermalStatus # enum const: ThermalStatus
float32 freeSpace
bool usbOnline
int64 mem
int64 cpu2
int64 cpu3
int64 cpu0
int64 cpu1
int64 startedTs
string[] batteryStatus
int32 memUsedPercent
int64 bat

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



(provide :openpilot_bridge/ThermalData "b82c596c149fdb826f5238d89c0ed390")


