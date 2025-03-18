;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::GpsLocationData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'GpsLocationData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::GPSLOCATIONDATA")
  (make-package "OPENPILOT_BRIDGE::GPSLOCATIONDATA"))

(in-package "ROS")
;;//! \htmlinclude GpsLocationData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::GpsLocationData
  :super ros::object
  :slots (_header _bearing _vNED _timestamp _altitude _longitude _source _speedAccuracy _flags _latitude _bearingAccuracy _speed _verticalAccuracy _accuracy ))

(defmethod openpilot_bridge::GpsLocationData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:bearing __bearing) 0.0)
    ((:vNED __vNED) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:timestamp __timestamp) 0)
    ((:altitude __altitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:source __source) 0)
    ((:speedAccuracy __speedAccuracy) 0.0)
    ((:flags __flags) 0)
    ((:latitude __latitude) 0.0)
    ((:bearingAccuracy __bearingAccuracy) 0.0)
    ((:speed __speed) 0.0)
    ((:verticalAccuracy __verticalAccuracy) 0.0)
    ((:accuracy __accuracy) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _bearing (float __bearing))
   (setq _vNED __vNED)
   (setq _timestamp (round __timestamp))
   (setq _altitude (float __altitude))
   (setq _longitude (float __longitude))
   (setq _source (round __source))
   (setq _speedAccuracy (float __speedAccuracy))
   (setq _flags (round __flags))
   (setq _latitude (float __latitude))
   (setq _bearingAccuracy (float __bearingAccuracy))
   (setq _speed (float __speed))
   (setq _verticalAccuracy (float __verticalAccuracy))
   (setq _accuracy (float __accuracy))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:bearing
   (&optional __bearing)
   (if __bearing (setq _bearing __bearing)) _bearing)
  (:vNED
   (&optional __vNED)
   (if __vNED (setq _vNED __vNED)) _vNED)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:speedAccuracy
   (&optional __speedAccuracy)
   (if __speedAccuracy (setq _speedAccuracy __speedAccuracy)) _speedAccuracy)
  (:flags
   (&optional __flags)
   (if __flags (setq _flags __flags)) _flags)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:bearingAccuracy
   (&optional __bearingAccuracy)
   (if __bearingAccuracy (setq _bearingAccuracy __bearingAccuracy)) _bearingAccuracy)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:verticalAccuracy
   (&optional __verticalAccuracy)
   (if __verticalAccuracy (setq _verticalAccuracy __verticalAccuracy)) _verticalAccuracy)
  (:accuracy
   (&optional __accuracy)
   (if __accuracy (setq _accuracy __accuracy)) _accuracy)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _bearing
    4
    ;; float32[] _vNED
    (* 4    (length _vNED)) 4
    ;; int32 _timestamp
    4
    ;; float32 _altitude
    4
    ;; float32 _longitude
    4
    ;; uint32 _source
    4
    ;; float32 _speedAccuracy
    4
    ;; int64 _flags
    8
    ;; float32 _latitude
    4
    ;; float32 _bearingAccuracy
    4
    ;; float32 _speed
    4
    ;; float32 _verticalAccuracy
    4
    ;; float32 _accuracy
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _bearing
       (sys::poke _bearing (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _vNED
     (write-long (length _vNED) s)
     (dotimes (i (length _vNED))
       (sys::poke (elt _vNED i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _timestamp
       (write-long _timestamp s)
     ;; float32 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _source
       (write-long _source s)
     ;; float32 _speedAccuracy
       (sys::poke _speedAccuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _flags
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _flags (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _flags) (= (length (_flags . bv)) 2)) ;; bignum
              (write-long (ash (elt (_flags . bv) 0) 0) s)
              (write-long (ash (elt (_flags . bv) 1) -1) s))
             ((and (class _flags) (= (length (_flags . bv)) 1)) ;; big1
              (write-long (elt (_flags . bv) 0) s)
              (write-long (if (>= _flags 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _flags s)(write-long (if (>= _flags 0) 0 #xffffffff) s)))
     ;; float32 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _bearingAccuracy
       (sys::poke _bearingAccuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _verticalAccuracy
       (sys::poke _verticalAccuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accuracy
       (sys::poke _accuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _bearing
     (setq _bearing (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _vNED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vNED (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _vNED i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _timestamp
     (setq _timestamp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _altitude
     (setq _altitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _longitude
     (setq _longitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _source
     (setq _source (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _speedAccuracy
     (setq _speedAccuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _flags
#+(or :alpha :irix6 :x86_64)
      (setf _flags (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _flags (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _latitude
     (setq _latitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _bearingAccuracy
     (setq _bearingAccuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _verticalAccuracy
     (setq _verticalAccuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accuracy
     (setq _accuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::GpsLocationData :md5sum-) "4424f612bc9ad1e23801532f061abcb5")
(setf (get openpilot_bridge::GpsLocationData :datatype-) "openpilot_bridge/GpsLocationData")
(setf (get openpilot_bridge::GpsLocationData :definition-)
      "Header header

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



(provide :openpilot_bridge/GpsLocationData "4424f612bc9ad1e23801532f061abcb5")


