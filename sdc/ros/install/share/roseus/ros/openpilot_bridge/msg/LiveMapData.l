;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveMapData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveMapData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVEMAPDATA")
  (make-package "OPENPILOT_BRIDGE::LIVEMAPDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveMapData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveMapData
  :super ros::object
  :slots (_header _roadCurvatureX _wayId _speedLimitValid _distToTurn _curvature _roadCurvature _mapValid _roadY _roadX _speedLimitAheadDistance _curvatureValid _speedLimitAheadValid _speedAdvisoryValid _speedLimit _speedAdvisory _lastGps _speedLimitAhead ))

(defmethod openpilot_bridge::LiveMapData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:roadCurvatureX __roadCurvatureX) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:wayId __wayId) 0)
    ((:speedLimitValid __speedLimitValid) nil)
    ((:distToTurn __distToTurn) 0.0)
    ((:curvature __curvature) 0.0)
    ((:roadCurvature __roadCurvature) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:mapValid __mapValid) nil)
    ((:roadY __roadY) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:roadX __roadX) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:speedLimitAheadDistance __speedLimitAheadDistance) 0.0)
    ((:curvatureValid __curvatureValid) nil)
    ((:speedLimitAheadValid __speedLimitAheadValid) nil)
    ((:speedAdvisoryValid __speedAdvisoryValid) nil)
    ((:speedLimit __speedLimit) 0.0)
    ((:speedAdvisory __speedAdvisory) 0.0)
    ((:lastGps __lastGps) (instance openpilot_bridge::GpsLocationData :init))
    ((:speedLimitAhead __speedLimitAhead) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _roadCurvatureX __roadCurvatureX)
   (setq _wayId (round __wayId))
   (setq _speedLimitValid __speedLimitValid)
   (setq _distToTurn (float __distToTurn))
   (setq _curvature (float __curvature))
   (setq _roadCurvature __roadCurvature)
   (setq _mapValid __mapValid)
   (setq _roadY __roadY)
   (setq _roadX __roadX)
   (setq _speedLimitAheadDistance (float __speedLimitAheadDistance))
   (setq _curvatureValid __curvatureValid)
   (setq _speedLimitAheadValid __speedLimitAheadValid)
   (setq _speedAdvisoryValid __speedAdvisoryValid)
   (setq _speedLimit (float __speedLimit))
   (setq _speedAdvisory (float __speedAdvisory))
   (setq _lastGps __lastGps)
   (setq _speedLimitAhead (float __speedLimitAhead))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:roadCurvatureX
   (&optional __roadCurvatureX)
   (if __roadCurvatureX (setq _roadCurvatureX __roadCurvatureX)) _roadCurvatureX)
  (:wayId
   (&optional __wayId)
   (if __wayId (setq _wayId __wayId)) _wayId)
  (:speedLimitValid
   (&optional __speedLimitValid)
   (if __speedLimitValid (setq _speedLimitValid __speedLimitValid)) _speedLimitValid)
  (:distToTurn
   (&optional __distToTurn)
   (if __distToTurn (setq _distToTurn __distToTurn)) _distToTurn)
  (:curvature
   (&optional __curvature)
   (if __curvature (setq _curvature __curvature)) _curvature)
  (:roadCurvature
   (&optional __roadCurvature)
   (if __roadCurvature (setq _roadCurvature __roadCurvature)) _roadCurvature)
  (:mapValid
   (&optional __mapValid)
   (if __mapValid (setq _mapValid __mapValid)) _mapValid)
  (:roadY
   (&optional __roadY)
   (if __roadY (setq _roadY __roadY)) _roadY)
  (:roadX
   (&optional __roadX)
   (if __roadX (setq _roadX __roadX)) _roadX)
  (:speedLimitAheadDistance
   (&optional __speedLimitAheadDistance)
   (if __speedLimitAheadDistance (setq _speedLimitAheadDistance __speedLimitAheadDistance)) _speedLimitAheadDistance)
  (:curvatureValid
   (&optional __curvatureValid)
   (if __curvatureValid (setq _curvatureValid __curvatureValid)) _curvatureValid)
  (:speedLimitAheadValid
   (&optional __speedLimitAheadValid)
   (if __speedLimitAheadValid (setq _speedLimitAheadValid __speedLimitAheadValid)) _speedLimitAheadValid)
  (:speedAdvisoryValid
   (&optional __speedAdvisoryValid)
   (if __speedAdvisoryValid (setq _speedAdvisoryValid __speedAdvisoryValid)) _speedAdvisoryValid)
  (:speedLimit
   (&optional __speedLimit)
   (if __speedLimit (setq _speedLimit __speedLimit)) _speedLimit)
  (:speedAdvisory
   (&optional __speedAdvisory)
   (if __speedAdvisory (setq _speedAdvisory __speedAdvisory)) _speedAdvisory)
  (:lastGps
   (&rest __lastGps)
   (if (keywordp (car __lastGps))
       (send* _lastGps __lastGps)
     (progn
       (if __lastGps (setq _lastGps (car __lastGps)))
       _lastGps)))
  (:speedLimitAhead
   (&optional __speedLimitAhead)
   (if __speedLimitAhead (setq _speedLimitAhead __speedLimitAhead)) _speedLimitAhead)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _roadCurvatureX
    (* 4    (length _roadCurvatureX)) 4
    ;; int64 _wayId
    8
    ;; bool _speedLimitValid
    1
    ;; float32 _distToTurn
    4
    ;; float32 _curvature
    4
    ;; float32[] _roadCurvature
    (* 4    (length _roadCurvature)) 4
    ;; bool _mapValid
    1
    ;; float32[] _roadY
    (* 4    (length _roadY)) 4
    ;; float32[] _roadX
    (* 4    (length _roadX)) 4
    ;; float32 _speedLimitAheadDistance
    4
    ;; bool _curvatureValid
    1
    ;; bool _speedLimitAheadValid
    1
    ;; bool _speedAdvisoryValid
    1
    ;; float32 _speedLimit
    4
    ;; float32 _speedAdvisory
    4
    ;; openpilot_bridge/GpsLocationData _lastGps
    (send _lastGps :serialization-length)
    ;; float32 _speedLimitAhead
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _roadCurvatureX
     (write-long (length _roadCurvatureX) s)
     (dotimes (i (length _roadCurvatureX))
       (sys::poke (elt _roadCurvatureX i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _wayId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _wayId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _wayId) (= (length (_wayId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_wayId . bv) 0) 0) s)
              (write-long (ash (elt (_wayId . bv) 1) -1) s))
             ((and (class _wayId) (= (length (_wayId . bv)) 1)) ;; big1
              (write-long (elt (_wayId . bv) 0) s)
              (write-long (if (>= _wayId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _wayId s)(write-long (if (>= _wayId 0) 0 #xffffffff) s)))
     ;; bool _speedLimitValid
       (if _speedLimitValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _distToTurn
       (sys::poke _distToTurn (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _curvature
       (sys::poke _curvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _roadCurvature
     (write-long (length _roadCurvature) s)
     (dotimes (i (length _roadCurvature))
       (sys::poke (elt _roadCurvature i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _mapValid
       (if _mapValid (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _roadY
     (write-long (length _roadY) s)
     (dotimes (i (length _roadY))
       (sys::poke (elt _roadY i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _roadX
     (write-long (length _roadX) s)
     (dotimes (i (length _roadX))
       (sys::poke (elt _roadX i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _speedLimitAheadDistance
       (sys::poke _speedLimitAheadDistance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _curvatureValid
       (if _curvatureValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _speedLimitAheadValid
       (if _speedLimitAheadValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _speedAdvisoryValid
       (if _speedAdvisoryValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speedLimit
       (sys::poke _speedLimit (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speedAdvisory
       (sys::poke _speedAdvisory (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/GpsLocationData _lastGps
       (send _lastGps :serialize s)
     ;; float32 _speedLimitAhead
       (sys::poke _speedLimitAhead (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _roadCurvatureX
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _roadCurvatureX (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _roadCurvatureX i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _wayId
#+(or :alpha :irix6 :x86_64)
      (setf _wayId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _wayId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _speedLimitValid
     (setq _speedLimitValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _distToTurn
     (setq _distToTurn (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _curvature
     (setq _curvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _roadCurvature
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _roadCurvature (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _roadCurvature i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _mapValid
     (setq _mapValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _roadY
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _roadY (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _roadY i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _roadX
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _roadX (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _roadX i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _speedLimitAheadDistance
     (setq _speedLimitAheadDistance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _curvatureValid
     (setq _curvatureValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _speedLimitAheadValid
     (setq _speedLimitAheadValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _speedAdvisoryValid
     (setq _speedAdvisoryValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speedLimit
     (setq _speedLimit (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speedAdvisory
     (setq _speedAdvisory (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/GpsLocationData _lastGps
     (send _lastGps :deserialize buf ptr-) (incf ptr- (send _lastGps :serialization-length))
   ;; float32 _speedLimitAhead
     (setq _speedLimitAhead (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveMapData :md5sum-) "8e75e0f0b1c9d773cf5d7c8618aae41e")
(setf (get openpilot_bridge::LiveMapData :datatype-) "openpilot_bridge/LiveMapData")
(setf (get openpilot_bridge::LiveMapData :definition-)
      "Header header

float32[] roadCurvatureX
int64 wayId
bool speedLimitValid
float32 distToTurn
float32 curvature
float32[] roadCurvature
bool mapValid
float32[] roadY
float32[] roadX
float32 speedLimitAheadDistance
bool curvatureValid
bool speedLimitAheadValid
bool speedAdvisoryValid
float32 speedLimit
float32 speedAdvisory
GpsLocationData lastGps
float32 speedLimitAhead

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
MSG: openpilot_bridge/GpsLocationData
Header header

float32 bearing
float32[] vNED
int32 timestamp
float32 altitude
float32 longitude
uint32 source # enum const: SensorSource
float32 speedAccuracy
int64 flags
float32 latitude
float32 bearingAccuracy
float32 speed
float32 verticalAccuracy
float32 accuracy

")



(provide :openpilot_bridge/LiveMapData "8e75e0f0b1c9d773cf5d7c8618aae41e")


