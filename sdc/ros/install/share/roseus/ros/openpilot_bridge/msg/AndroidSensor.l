;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AndroidSensor)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AndroidSensor (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ANDROIDSENSOR")
  (make-package "OPENPILOT_BRIDGE::ANDROIDSENSOR"))

(in-package "ROS")
;;//! \htmlinclude AndroidSensor.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::AndroidSensor
  :super ros::object
  :slots (_header _maxRange _stringType _maxDelay _handle _name _power _minDelay _resolution _fifoMaxEventCount _version _fifoReservedEventCount _vendor _type _id ))

(defmethod openpilot_bridge::AndroidSensor
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:maxRange __maxRange) 0.0)
    ((:stringType __stringType) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:maxDelay __maxDelay) 0)
    ((:handle __handle) 0)
    ((:name __name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:power __power) 0.0)
    ((:minDelay __minDelay) 0)
    ((:resolution __resolution) 0.0)
    ((:fifoMaxEventCount __fifoMaxEventCount) 0)
    ((:version __version) 0)
    ((:fifoReservedEventCount __fifoReservedEventCount) 0)
    ((:vendor __vendor) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:type __type) 0)
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _maxRange (float __maxRange))
   (setq _stringType __stringType)
   (setq _maxDelay (round __maxDelay))
   (setq _handle (round __handle))
   (setq _name __name)
   (setq _power (float __power))
   (setq _minDelay (round __minDelay))
   (setq _resolution (float __resolution))
   (setq _fifoMaxEventCount (round __fifoMaxEventCount))
   (setq _version (round __version))
   (setq _fifoReservedEventCount (round __fifoReservedEventCount))
   (setq _vendor __vendor)
   (setq _type (round __type))
   (setq _id (round __id))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:maxRange
   (&optional __maxRange)
   (if __maxRange (setq _maxRange __maxRange)) _maxRange)
  (:stringType
   (&optional __stringType)
   (if __stringType (setq _stringType __stringType)) _stringType)
  (:maxDelay
   (&optional __maxDelay)
   (if __maxDelay (setq _maxDelay __maxDelay)) _maxDelay)
  (:handle
   (&optional __handle)
   (if __handle (setq _handle __handle)) _handle)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:power
   (&optional __power)
   (if __power (setq _power __power)) _power)
  (:minDelay
   (&optional __minDelay)
   (if __minDelay (setq _minDelay __minDelay)) _minDelay)
  (:resolution
   (&optional __resolution)
   (if __resolution (setq _resolution __resolution)) _resolution)
  (:fifoMaxEventCount
   (&optional __fifoMaxEventCount)
   (if __fifoMaxEventCount (setq _fifoMaxEventCount __fifoMaxEventCount)) _fifoMaxEventCount)
  (:version
   (&optional __version)
   (if __version (setq _version __version)) _version)
  (:fifoReservedEventCount
   (&optional __fifoReservedEventCount)
   (if __fifoReservedEventCount (setq _fifoReservedEventCount __fifoReservedEventCount)) _fifoReservedEventCount)
  (:vendor
   (&optional __vendor)
   (if __vendor (setq _vendor __vendor)) _vendor)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _maxRange
    4
    ;; string[] _stringType
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _stringType)) 4
    ;; int32 _maxDelay
    4
    ;; int32 _handle
    4
    ;; string[] _name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _name)) 4
    ;; float32 _power
    4
    ;; int32 _minDelay
    4
    ;; float32 _resolution
    4
    ;; int64 _fifoMaxEventCount
    8
    ;; int32 _version
    4
    ;; int64 _fifoReservedEventCount
    8
    ;; string[] _vendor
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _vendor)) 4
    ;; int32 _type
    4
    ;; int32 _id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _maxRange
       (sys::poke _maxRange (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _stringType
     (write-long (length _stringType) s)
     (dolist (elem _stringType)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _maxDelay
       (write-long _maxDelay s)
     ;; int32 _handle
       (write-long _handle s)
     ;; string[] _name
     (write-long (length _name) s)
     (dolist (elem _name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _power
       (sys::poke _power (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _minDelay
       (write-long _minDelay s)
     ;; float32 _resolution
       (sys::poke _resolution (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _fifoMaxEventCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fifoMaxEventCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fifoMaxEventCount) (= (length (_fifoMaxEventCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fifoMaxEventCount . bv) 0) 0) s)
              (write-long (ash (elt (_fifoMaxEventCount . bv) 1) -1) s))
             ((and (class _fifoMaxEventCount) (= (length (_fifoMaxEventCount . bv)) 1)) ;; big1
              (write-long (elt (_fifoMaxEventCount . bv) 0) s)
              (write-long (if (>= _fifoMaxEventCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fifoMaxEventCount s)(write-long (if (>= _fifoMaxEventCount 0) 0 #xffffffff) s)))
     ;; int32 _version
       (write-long _version s)
     ;; int64 _fifoReservedEventCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _fifoReservedEventCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _fifoReservedEventCount) (= (length (_fifoReservedEventCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_fifoReservedEventCount . bv) 0) 0) s)
              (write-long (ash (elt (_fifoReservedEventCount . bv) 1) -1) s))
             ((and (class _fifoReservedEventCount) (= (length (_fifoReservedEventCount . bv)) 1)) ;; big1
              (write-long (elt (_fifoReservedEventCount . bv) 0) s)
              (write-long (if (>= _fifoReservedEventCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _fifoReservedEventCount s)(write-long (if (>= _fifoReservedEventCount 0) 0 #xffffffff) s)))
     ;; string[] _vendor
     (write-long (length _vendor) s)
     (dolist (elem _vendor)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _type
       (write-long _type s)
     ;; int32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _maxRange
     (setq _maxRange (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _stringType
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _stringType (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _stringType i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _maxDelay
     (setq _maxDelay (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _handle
     (setq _handle (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _power
     (setq _power (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _minDelay
     (setq _minDelay (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _resolution
     (setq _resolution (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _fifoMaxEventCount
#+(or :alpha :irix6 :x86_64)
      (setf _fifoMaxEventCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fifoMaxEventCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _version
     (setq _version (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _fifoReservedEventCount
#+(or :alpha :irix6 :x86_64)
      (setf _fifoReservedEventCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _fifoReservedEventCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _vendor
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vendor (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _vendor i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::AndroidSensor :md5sum-) "28a5145614ef6b4a40314b3f2013a478")
(setf (get openpilot_bridge::AndroidSensor :datatype-) "openpilot_bridge/AndroidSensor")
(setf (get openpilot_bridge::AndroidSensor :definition-)
      "Header header

float32 maxRange
string[] stringType
int32 maxDelay
int32 handle
string[] name
float32 power
int32 minDelay
float32 resolution
int64 fifoMaxEventCount
int32 version
int64 fifoReservedEventCount
string[] vendor
int32 type
int32 id

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



(provide :openpilot_bridge/AndroidSensor "28a5145614ef6b4a40314b3f2013a478")


