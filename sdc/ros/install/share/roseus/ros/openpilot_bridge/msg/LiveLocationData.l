;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveLocationData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveLocationData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVELOCATIONDATA")
  (make-package "OPENPILOT_BRIDGE::LIVELOCATIONDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveLocationData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveLocationData
  :super ros::object
  :slots (_header _pitch _positionECEF _alt _speed _lon _source _roll _accuracy _status _yawCalibration _vNED _accel _fixMonoTime _lat _imuFrame _pitchCalibration _gyro _timeOfWeek _poseQuatECEF _gpsWeek _trackAngle _heading _wanderAngle ))

(defmethod openpilot_bridge::LiveLocationData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pitch __pitch) 0.0)
    ((:positionECEF __positionECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:alt __alt) 0.0)
    ((:speed __speed) 0.0)
    ((:lon __lon) 0.0)
    ((:source __source) 0)
    ((:roll __roll) 0.0)
    ((:accuracy __accuracy) (instance openpilot_bridge::Accuracy :init))
    ((:status __status) 0)
    ((:yawCalibration __yawCalibration) 0.0)
    ((:vNED __vNED) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:accel __accel) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:fixMonoTime __fixMonoTime) 0)
    ((:lat __lat) 0.0)
    ((:imuFrame __imuFrame) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:pitchCalibration __pitchCalibration) 0.0)
    ((:gyro __gyro) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:timeOfWeek __timeOfWeek) 0.0)
    ((:poseQuatECEF __poseQuatECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:gpsWeek __gpsWeek) 0)
    ((:trackAngle __trackAngle) 0.0)
    ((:heading __heading) 0.0)
    ((:wanderAngle __wanderAngle) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _pitch (float __pitch))
   (setq _positionECEF __positionECEF)
   (setq _alt (float __alt))
   (setq _speed (float __speed))
   (setq _lon (float __lon))
   (setq _source (round __source))
   (setq _roll (float __roll))
   (setq _accuracy __accuracy)
   (setq _status (round __status))
   (setq _yawCalibration (float __yawCalibration))
   (setq _vNED __vNED)
   (setq _accel __accel)
   (setq _fixMonoTime (round __fixMonoTime))
   (setq _lat (float __lat))
   (setq _imuFrame __imuFrame)
   (setq _pitchCalibration (float __pitchCalibration))
   (setq _gyro __gyro)
   (setq _timeOfWeek (float __timeOfWeek))
   (setq _poseQuatECEF __poseQuatECEF)
   (setq _gpsWeek (round __gpsWeek))
   (setq _trackAngle (float __trackAngle))
   (setq _heading (float __heading))
   (setq _wanderAngle (float __wanderAngle))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:positionECEF
   (&optional __positionECEF)
   (if __positionECEF (setq _positionECEF __positionECEF)) _positionECEF)
  (:alt
   (&optional __alt)
   (if __alt (setq _alt __alt)) _alt)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:lon
   (&optional __lon)
   (if __lon (setq _lon __lon)) _lon)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:roll
   (&optional __roll)
   (if __roll (setq _roll __roll)) _roll)
  (:accuracy
   (&rest __accuracy)
   (if (keywordp (car __accuracy))
       (send* _accuracy __accuracy)
     (progn
       (if __accuracy (setq _accuracy (car __accuracy)))
       _accuracy)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:yawCalibration
   (&optional __yawCalibration)
   (if __yawCalibration (setq _yawCalibration __yawCalibration)) _yawCalibration)
  (:vNED
   (&optional __vNED)
   (if __vNED (setq _vNED __vNED)) _vNED)
  (:accel
   (&optional __accel)
   (if __accel (setq _accel __accel)) _accel)
  (:fixMonoTime
   (&optional __fixMonoTime)
   (if __fixMonoTime (setq _fixMonoTime __fixMonoTime)) _fixMonoTime)
  (:lat
   (&optional __lat)
   (if __lat (setq _lat __lat)) _lat)
  (:imuFrame
   (&optional __imuFrame)
   (if __imuFrame (setq _imuFrame __imuFrame)) _imuFrame)
  (:pitchCalibration
   (&optional __pitchCalibration)
   (if __pitchCalibration (setq _pitchCalibration __pitchCalibration)) _pitchCalibration)
  (:gyro
   (&optional __gyro)
   (if __gyro (setq _gyro __gyro)) _gyro)
  (:timeOfWeek
   (&optional __timeOfWeek)
   (if __timeOfWeek (setq _timeOfWeek __timeOfWeek)) _timeOfWeek)
  (:poseQuatECEF
   (&optional __poseQuatECEF)
   (if __poseQuatECEF (setq _poseQuatECEF __poseQuatECEF)) _poseQuatECEF)
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:trackAngle
   (&optional __trackAngle)
   (if __trackAngle (setq _trackAngle __trackAngle)) _trackAngle)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:wanderAngle
   (&optional __wanderAngle)
   (if __wanderAngle (setq _wanderAngle __wanderAngle)) _wanderAngle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _pitch
    4
    ;; float32[] _positionECEF
    (* 4    (length _positionECEF)) 4
    ;; float32 _alt
    4
    ;; float32 _speed
    4
    ;; float32 _lon
    4
    ;; uint32 _source
    4
    ;; float32 _roll
    4
    ;; openpilot_bridge/Accuracy _accuracy
    (send _accuracy :serialization-length)
    ;; int64 _status
    8
    ;; float32 _yawCalibration
    4
    ;; float32[] _vNED
    (* 4    (length _vNED)) 4
    ;; float32[] _accel
    (* 4    (length _accel)) 4
    ;; int64 _fixMonoTime
    8
    ;; float32 _lat
    4
    ;; float32[] _imuFrame
    (* 4    (length _imuFrame)) 4
    ;; float32 _pitchCalibration
    4
    ;; float32[] _gyro
    (* 4    (length _gyro)) 4
    ;; float32 _timeOfWeek
    4
    ;; float32[] _poseQuatECEF
    (* 4    (length _poseQuatECEF)) 4
    ;; int32 _gpsWeek
    4
    ;; float32 _trackAngle
    4
    ;; float32 _heading
    4
    ;; float32 _wanderAngle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _positionECEF
     (write-long (length _positionECEF) s)
     (dotimes (i (length _positionECEF))
       (sys::poke (elt _positionECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _alt
       (sys::poke _alt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _lon
       (sys::poke _lon (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _source
       (write-long _source s)
     ;; float32 _roll
       (sys::poke _roll (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/Accuracy _accuracy
       (send _accuracy :serialize s)
     ;; int64 _status
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _status (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _status) (= (length (_status . bv)) 2)) ;; bignum
              (write-long (ash (elt (_status . bv) 0) 0) s)
              (write-long (ash (elt (_status . bv) 1) -1) s))
             ((and (class _status) (= (length (_status . bv)) 1)) ;; big1
              (write-long (elt (_status . bv) 0) s)
              (write-long (if (>= _status 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _status s)(write-long (if (>= _status 0) 0 #xffffffff) s)))
     ;; float32 _yawCalibration
       (sys::poke _yawCalibration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _vNED
     (write-long (length _vNED) s)
     (dotimes (i (length _vNED))
       (sys::poke (elt _vNED i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _accel
     (write-long (length _accel) s)
     (dotimes (i (length _accel))
       (sys::poke (elt _accel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _fixMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fixMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fixMonoTime) (= (length (_fixMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fixMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_fixMonoTime . bv) 1) -1) s))
             ((and (class _fixMonoTime) (= (length (_fixMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_fixMonoTime . bv) 0) s)
              (write-long (if (>= _fixMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fixMonoTime s)(write-long (if (>= _fixMonoTime 0) 0 #xffffffff) s)))
     ;; float32 _lat
       (sys::poke _lat (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _imuFrame
     (write-long (length _imuFrame) s)
     (dotimes (i (length _imuFrame))
       (sys::poke (elt _imuFrame i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _pitchCalibration
       (sys::poke _pitchCalibration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _gyro
     (write-long (length _gyro) s)
     (dotimes (i (length _gyro))
       (sys::poke (elt _gyro i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _timeOfWeek
       (sys::poke _timeOfWeek (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _poseQuatECEF
     (write-long (length _poseQuatECEF) s)
     (dotimes (i (length _poseQuatECEF))
       (sys::poke (elt _poseQuatECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _gpsWeek
       (write-long _gpsWeek s)
     ;; float32 _trackAngle
       (sys::poke _trackAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _wanderAngle
       (sys::poke _wanderAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _pitch
     (setq _pitch (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _positionECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _positionECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _positionECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _alt
     (setq _alt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _lon
     (setq _lon (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _source
     (setq _source (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _roll
     (setq _roll (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/Accuracy _accuracy
     (send _accuracy :deserialize buf ptr-) (incf ptr- (send _accuracy :serialization-length))
   ;; int64 _status
#+(or :alpha :irix6 :x86_64)
      (setf _status (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _status (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _yawCalibration
     (setq _yawCalibration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _vNED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vNED (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _vNED i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _accel
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _accel (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _accel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _fixMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _fixMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fixMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _lat
     (setq _lat (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _imuFrame
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _imuFrame (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _imuFrame i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _pitchCalibration
     (setq _pitchCalibration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _gyro
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gyro (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _gyro i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _timeOfWeek
     (setq _timeOfWeek (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _poseQuatECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poseQuatECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poseQuatECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _gpsWeek
     (setq _gpsWeek (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _trackAngle
     (setq _trackAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _heading
     (setq _heading (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _wanderAngle
     (setq _wanderAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveLocationData :md5sum-) "aa33a74620afc25f4a6862168bc66b52")
(setf (get openpilot_bridge::LiveLocationData :datatype-) "openpilot_bridge/LiveLocationData")
(setf (get openpilot_bridge::LiveLocationData :definition-)
      "Header header

float32 pitch
float32[] positionECEF
float32 alt
float32 speed
float32 lon
uint32 source # enum const: SensorSource
float32 roll
Accuracy accuracy
int64 status
float32 yawCalibration
float32[] vNED
float32[] accel
int64 fixMonoTime
float32 lat
float32[] imuFrame
float32 pitchCalibration
float32[] gyro
float32 timeOfWeek
float32[] poseQuatECEF
int32 gpsWeek
float32 trackAngle
float32 heading
float32 wanderAngle

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
MSG: openpilot_bridge/Accuracy
Header header

float32[] vNEDError
float32 rollError
float32 headingError
float32 ellipsoidSemiMajorError
float32 ellipsoidOrientationError
float32[] pNEDError
float32 ellipsoidSemiMinorError
float32 pitchError

")



(provide :openpilot_bridge/LiveLocationData "aa33a74620afc25f4a6862168bc66b52")


