;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CarState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CarState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CARSTATE")
  (make-package "OPENPILOT_BRIDGE::CARSTATE"))

(in-package "ROS")
;;//! \htmlinclude CarState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CarState
  :super ros::object
  :slots (_header _gearShifter _seatbeltUnlatched _clutchPressed _vEgoRaw _errorsDEPRECATED _brake _vEgo _steeringAngle _leftBlinker _wheelSpeeds _steeringRateLimited _stockFcw _doorOpen _steeringRate _events _steeringPressed _canValid _cruiseState _yawRate _steeringTorqueEps _gas _steeringTorque _genericToggle _brakeLights _buttonEvents _standstill _gasPressed _stockAeb _rightBlinker _brakePressed _aEgo _canMonoTimes ))

(defmethod openpilot_bridge::CarState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gearShifter __gearShifter) 0)
    ((:seatbeltUnlatched __seatbeltUnlatched) nil)
    ((:clutchPressed __clutchPressed) nil)
    ((:vEgoRaw __vEgoRaw) 0.0)
    ((:errorsDEPRECATED __errorsDEPRECATED) (make-array 0 :initial-element 0 :element-type :integer))
    ((:brake __brake) 0.0)
    ((:vEgo __vEgo) 0.0)
    ((:steeringAngle __steeringAngle) 0.0)
    ((:leftBlinker __leftBlinker) nil)
    ((:wheelSpeeds __wheelSpeeds) (instance openpilot_bridge::WheelSpeeds :init))
    ((:steeringRateLimited __steeringRateLimited) nil)
    ((:stockFcw __stockFcw) nil)
    ((:doorOpen __doorOpen) nil)
    ((:steeringRate __steeringRate) 0.0)
    ((:events __events) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CarEvent :init) r)) r))
    ((:steeringPressed __steeringPressed) nil)
    ((:canValid __canValid) nil)
    ((:cruiseState __cruiseState) (instance openpilot_bridge::CruiseState :init))
    ((:yawRate __yawRate) 0.0)
    ((:steeringTorqueEps __steeringTorqueEps) 0.0)
    ((:gas __gas) 0.0)
    ((:steeringTorque __steeringTorque) 0.0)
    ((:genericToggle __genericToggle) nil)
    ((:brakeLights __brakeLights) nil)
    ((:buttonEvents __buttonEvents) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ButtonEvent :init) r)) r))
    ((:standstill __standstill) nil)
    ((:gasPressed __gasPressed) nil)
    ((:stockAeb __stockAeb) nil)
    ((:rightBlinker __rightBlinker) nil)
    ((:brakePressed __brakePressed) nil)
    ((:aEgo __aEgo) 0.0)
    ((:canMonoTimes __canMonoTimes) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _header __header)
   (setq _gearShifter (round __gearShifter))
   (setq _seatbeltUnlatched __seatbeltUnlatched)
   (setq _clutchPressed __clutchPressed)
   (setq _vEgoRaw (float __vEgoRaw))
   (setq _errorsDEPRECATED __errorsDEPRECATED)
   (setq _brake (float __brake))
   (setq _vEgo (float __vEgo))
   (setq _steeringAngle (float __steeringAngle))
   (setq _leftBlinker __leftBlinker)
   (setq _wheelSpeeds __wheelSpeeds)
   (setq _steeringRateLimited __steeringRateLimited)
   (setq _stockFcw __stockFcw)
   (setq _doorOpen __doorOpen)
   (setq _steeringRate (float __steeringRate))
   (setq _events __events)
   (setq _steeringPressed __steeringPressed)
   (setq _canValid __canValid)
   (setq _cruiseState __cruiseState)
   (setq _yawRate (float __yawRate))
   (setq _steeringTorqueEps (float __steeringTorqueEps))
   (setq _gas (float __gas))
   (setq _steeringTorque (float __steeringTorque))
   (setq _genericToggle __genericToggle)
   (setq _brakeLights __brakeLights)
   (setq _buttonEvents __buttonEvents)
   (setq _standstill __standstill)
   (setq _gasPressed __gasPressed)
   (setq _stockAeb __stockAeb)
   (setq _rightBlinker __rightBlinker)
   (setq _brakePressed __brakePressed)
   (setq _aEgo (float __aEgo))
   (setq _canMonoTimes __canMonoTimes)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gearShifter
   (&optional __gearShifter)
   (if __gearShifter (setq _gearShifter __gearShifter)) _gearShifter)
  (:seatbeltUnlatched
   (&optional __seatbeltUnlatched)
   (if __seatbeltUnlatched (setq _seatbeltUnlatched __seatbeltUnlatched)) _seatbeltUnlatched)
  (:clutchPressed
   (&optional __clutchPressed)
   (if __clutchPressed (setq _clutchPressed __clutchPressed)) _clutchPressed)
  (:vEgoRaw
   (&optional __vEgoRaw)
   (if __vEgoRaw (setq _vEgoRaw __vEgoRaw)) _vEgoRaw)
  (:errorsDEPRECATED
   (&optional __errorsDEPRECATED)
   (if __errorsDEPRECATED (setq _errorsDEPRECATED __errorsDEPRECATED)) _errorsDEPRECATED)
  (:brake
   (&optional __brake)
   (if __brake (setq _brake __brake)) _brake)
  (:vEgo
   (&optional __vEgo)
   (if __vEgo (setq _vEgo __vEgo)) _vEgo)
  (:steeringAngle
   (&optional __steeringAngle)
   (if __steeringAngle (setq _steeringAngle __steeringAngle)) _steeringAngle)
  (:leftBlinker
   (&optional __leftBlinker)
   (if __leftBlinker (setq _leftBlinker __leftBlinker)) _leftBlinker)
  (:wheelSpeeds
   (&rest __wheelSpeeds)
   (if (keywordp (car __wheelSpeeds))
       (send* _wheelSpeeds __wheelSpeeds)
     (progn
       (if __wheelSpeeds (setq _wheelSpeeds (car __wheelSpeeds)))
       _wheelSpeeds)))
  (:steeringRateLimited
   (&optional __steeringRateLimited)
   (if __steeringRateLimited (setq _steeringRateLimited __steeringRateLimited)) _steeringRateLimited)
  (:stockFcw
   (&optional __stockFcw)
   (if __stockFcw (setq _stockFcw __stockFcw)) _stockFcw)
  (:doorOpen
   (&optional __doorOpen)
   (if __doorOpen (setq _doorOpen __doorOpen)) _doorOpen)
  (:steeringRate
   (&optional __steeringRate)
   (if __steeringRate (setq _steeringRate __steeringRate)) _steeringRate)
  (:events
   (&rest __events)
   (if (keywordp (car __events))
       (send* _events __events)
     (progn
       (if __events (setq _events (car __events)))
       _events)))
  (:steeringPressed
   (&optional __steeringPressed)
   (if __steeringPressed (setq _steeringPressed __steeringPressed)) _steeringPressed)
  (:canValid
   (&optional __canValid)
   (if __canValid (setq _canValid __canValid)) _canValid)
  (:cruiseState
   (&rest __cruiseState)
   (if (keywordp (car __cruiseState))
       (send* _cruiseState __cruiseState)
     (progn
       (if __cruiseState (setq _cruiseState (car __cruiseState)))
       _cruiseState)))
  (:yawRate
   (&optional __yawRate)
   (if __yawRate (setq _yawRate __yawRate)) _yawRate)
  (:steeringTorqueEps
   (&optional __steeringTorqueEps)
   (if __steeringTorqueEps (setq _steeringTorqueEps __steeringTorqueEps)) _steeringTorqueEps)
  (:gas
   (&optional __gas)
   (if __gas (setq _gas __gas)) _gas)
  (:steeringTorque
   (&optional __steeringTorque)
   (if __steeringTorque (setq _steeringTorque __steeringTorque)) _steeringTorque)
  (:genericToggle
   (&optional __genericToggle)
   (if __genericToggle (setq _genericToggle __genericToggle)) _genericToggle)
  (:brakeLights
   (&optional __brakeLights)
   (if __brakeLights (setq _brakeLights __brakeLights)) _brakeLights)
  (:buttonEvents
   (&rest __buttonEvents)
   (if (keywordp (car __buttonEvents))
       (send* _buttonEvents __buttonEvents)
     (progn
       (if __buttonEvents (setq _buttonEvents (car __buttonEvents)))
       _buttonEvents)))
  (:standstill
   (&optional __standstill)
   (if __standstill (setq _standstill __standstill)) _standstill)
  (:gasPressed
   (&optional __gasPressed)
   (if __gasPressed (setq _gasPressed __gasPressed)) _gasPressed)
  (:stockAeb
   (&optional __stockAeb)
   (if __stockAeb (setq _stockAeb __stockAeb)) _stockAeb)
  (:rightBlinker
   (&optional __rightBlinker)
   (if __rightBlinker (setq _rightBlinker __rightBlinker)) _rightBlinker)
  (:brakePressed
   (&optional __brakePressed)
   (if __brakePressed (setq _brakePressed __brakePressed)) _brakePressed)
  (:aEgo
   (&optional __aEgo)
   (if __aEgo (setq _aEgo __aEgo)) _aEgo)
  (:canMonoTimes
   (&optional __canMonoTimes)
   (if __canMonoTimes (setq _canMonoTimes __canMonoTimes)) _canMonoTimes)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _gearShifter
    4
    ;; bool _seatbeltUnlatched
    1
    ;; bool _clutchPressed
    1
    ;; float32 _vEgoRaw
    4
    ;; uint32[] _errorsDEPRECATED
    (* 4    (length _errorsDEPRECATED)) 4
    ;; float32 _brake
    4
    ;; float32 _vEgo
    4
    ;; float32 _steeringAngle
    4
    ;; bool _leftBlinker
    1
    ;; openpilot_bridge/WheelSpeeds _wheelSpeeds
    (send _wheelSpeeds :serialization-length)
    ;; bool _steeringRateLimited
    1
    ;; bool _stockFcw
    1
    ;; bool _doorOpen
    1
    ;; float32 _steeringRate
    4
    ;; openpilot_bridge/CarEvent[] _events
    (apply #'+ (send-all _events :serialization-length)) 4
    ;; bool _steeringPressed
    1
    ;; bool _canValid
    1
    ;; openpilot_bridge/CruiseState _cruiseState
    (send _cruiseState :serialization-length)
    ;; float32 _yawRate
    4
    ;; float32 _steeringTorqueEps
    4
    ;; float32 _gas
    4
    ;; float32 _steeringTorque
    4
    ;; bool _genericToggle
    1
    ;; bool _brakeLights
    1
    ;; openpilot_bridge/ButtonEvent[] _buttonEvents
    (apply #'+ (send-all _buttonEvents :serialization-length)) 4
    ;; bool _standstill
    1
    ;; bool _gasPressed
    1
    ;; bool _stockAeb
    1
    ;; bool _rightBlinker
    1
    ;; bool _brakePressed
    1
    ;; float32 _aEgo
    4
    ;; int64[] _canMonoTimes
    (* 8    (length _canMonoTimes)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _gearShifter
       (write-long _gearShifter s)
     ;; bool _seatbeltUnlatched
       (if _seatbeltUnlatched (write-byte -1 s) (write-byte 0 s))
     ;; bool _clutchPressed
       (if _clutchPressed (write-byte -1 s) (write-byte 0 s))
     ;; float32 _vEgoRaw
       (sys::poke _vEgoRaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32[] _errorsDEPRECATED
     (write-long (length _errorsDEPRECATED) s)
     (dotimes (i (length _errorsDEPRECATED))
       (write-long (elt _errorsDEPRECATED i) s)
       )
     ;; float32 _brake
       (sys::poke _brake (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vEgo
       (sys::poke _vEgo (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steeringAngle
       (sys::poke _steeringAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _leftBlinker
       (if _leftBlinker (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/WheelSpeeds _wheelSpeeds
       (send _wheelSpeeds :serialize s)
     ;; bool _steeringRateLimited
       (if _steeringRateLimited (write-byte -1 s) (write-byte 0 s))
     ;; bool _stockFcw
       (if _stockFcw (write-byte -1 s) (write-byte 0 s))
     ;; bool _doorOpen
       (if _doorOpen (write-byte -1 s) (write-byte 0 s))
     ;; float32 _steeringRate
       (sys::poke _steeringRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/CarEvent[] _events
     (write-long (length _events) s)
     (dolist (elem _events)
       (send elem :serialize s)
       )
     ;; bool _steeringPressed
       (if _steeringPressed (write-byte -1 s) (write-byte 0 s))
     ;; bool _canValid
       (if _canValid (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/CruiseState _cruiseState
       (send _cruiseState :serialize s)
     ;; float32 _yawRate
       (sys::poke _yawRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steeringTorqueEps
       (sys::poke _steeringTorqueEps (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gas
       (sys::poke _gas (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steeringTorque
       (sys::poke _steeringTorque (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _genericToggle
       (if _genericToggle (write-byte -1 s) (write-byte 0 s))
     ;; bool _brakeLights
       (if _brakeLights (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/ButtonEvent[] _buttonEvents
     (write-long (length _buttonEvents) s)
     (dolist (elem _buttonEvents)
       (send elem :serialize s)
       )
     ;; bool _standstill
       (if _standstill (write-byte -1 s) (write-byte 0 s))
     ;; bool _gasPressed
       (if _gasPressed (write-byte -1 s) (write-byte 0 s))
     ;; bool _stockAeb
       (if _stockAeb (write-byte -1 s) (write-byte 0 s))
     ;; bool _rightBlinker
       (if _rightBlinker (write-byte -1 s) (write-byte 0 s))
     ;; bool _brakePressed
       (if _brakePressed (write-byte -1 s) (write-byte 0 s))
     ;; float32 _aEgo
       (sys::poke _aEgo (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _gearShifter
     (setq _gearShifter (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _seatbeltUnlatched
     (setq _seatbeltUnlatched (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _clutchPressed
     (setq _clutchPressed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _vEgoRaw
     (setq _vEgoRaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32[] _errorsDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _errorsDEPRECATED (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _errorsDEPRECATED i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float32 _brake
     (setq _brake (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vEgo
     (setq _vEgo (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steeringAngle
     (setq _steeringAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _leftBlinker
     (setq _leftBlinker (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/WheelSpeeds _wheelSpeeds
     (send _wheelSpeeds :deserialize buf ptr-) (incf ptr- (send _wheelSpeeds :serialization-length))
   ;; bool _steeringRateLimited
     (setq _steeringRateLimited (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _stockFcw
     (setq _stockFcw (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _doorOpen
     (setq _doorOpen (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _steeringRate
     (setq _steeringRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/CarEvent[] _events
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _events (let (r) (dotimes (i n) (push (instance openpilot_bridge::CarEvent :init) r)) r))
     (dolist (elem- _events)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _steeringPressed
     (setq _steeringPressed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _canValid
     (setq _canValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/CruiseState _cruiseState
     (send _cruiseState :deserialize buf ptr-) (incf ptr- (send _cruiseState :serialization-length))
   ;; float32 _yawRate
     (setq _yawRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steeringTorqueEps
     (setq _steeringTorqueEps (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gas
     (setq _gas (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steeringTorque
     (setq _steeringTorque (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _genericToggle
     (setq _genericToggle (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _brakeLights
     (setq _brakeLights (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/ButtonEvent[] _buttonEvents
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _buttonEvents (let (r) (dotimes (i n) (push (instance openpilot_bridge::ButtonEvent :init) r)) r))
     (dolist (elem- _buttonEvents)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _standstill
     (setq _standstill (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gasPressed
     (setq _gasPressed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _stockAeb
     (setq _stockAeb (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rightBlinker
     (setq _rightBlinker (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _brakePressed
     (setq _brakePressed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _aEgo
     (setq _aEgo (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;;
   self)
  )

(setf (get openpilot_bridge::CarState :md5sum-) "aa82270c536e806e4bbbc48f00d9d6a7")
(setf (get openpilot_bridge::CarState :datatype-) "openpilot_bridge/CarState")
(setf (get openpilot_bridge::CarState :definition-)
      "Header header

uint32 gearShifter # enum const: GearShifter
bool seatbeltUnlatched
bool clutchPressed
float32 vEgoRaw
uint32[] errorsDEPRECATED # enum const: EventName
float32 brake
float32 vEgo
float32 steeringAngle
bool leftBlinker
WheelSpeeds wheelSpeeds
bool steeringRateLimited
bool stockFcw
bool doorOpen
float32 steeringRate
CarEvent[] events
bool steeringPressed
bool canValid
CruiseState cruiseState
float32 yawRate
float32 steeringTorqueEps
float32 gas
float32 steeringTorque
bool genericToggle
bool brakeLights
ButtonEvent[] buttonEvents
bool standstill
bool gasPressed
bool stockAeb
bool rightBlinker
bool brakePressed
float32 aEgo
int64[] canMonoTimes

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
MSG: openpilot_bridge/WheelSpeeds
Header header

float32 rl
float32 fr
float32 fl
float32 rr

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
MSG: openpilot_bridge/CruiseState
Header header

bool available
float32 speed
float32 speedOffset
bool enabled
bool standstill

================================================================================
MSG: openpilot_bridge/ButtonEvent
Header header

uint32 type # enum const: Type
bool pressed

")



(provide :openpilot_bridge/CarState "aa82270c536e806e4bbbc48f00d9d6a7")


