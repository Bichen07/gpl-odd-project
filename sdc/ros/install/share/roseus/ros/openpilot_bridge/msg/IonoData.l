;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::IonoData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'IonoData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::IONODATA")
  (make-package "OPENPILOT_BRIDGE::IONODATA"))

(in-package "ROS")
;;//! \htmlinclude IonoData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::IonoData
  :super ros::object
  :slots (_header _healthValid _ionoAlpha _tow _gpsWeek _ionoBeta _svHealth _ionoCoeffsValid ))

(defmethod openpilot_bridge::IonoData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:healthValid __healthValid) nil)
    ((:ionoAlpha __ionoAlpha) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:tow __tow) 0.0)
    ((:gpsWeek __gpsWeek) 0.0)
    ((:ionoBeta __ionoBeta) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:svHealth __svHealth) 0)
    ((:ionoCoeffsValid __ionoCoeffsValid) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _healthValid __healthValid)
   (setq _ionoAlpha __ionoAlpha)
   (setq _tow (float __tow))
   (setq _gpsWeek (float __gpsWeek))
   (setq _ionoBeta __ionoBeta)
   (setq _svHealth (round __svHealth))
   (setq _ionoCoeffsValid __ionoCoeffsValid)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:healthValid
   (&optional __healthValid)
   (if __healthValid (setq _healthValid __healthValid)) _healthValid)
  (:ionoAlpha
   (&optional __ionoAlpha)
   (if __ionoAlpha (setq _ionoAlpha __ionoAlpha)) _ionoAlpha)
  (:tow
   (&optional __tow)
   (if __tow (setq _tow __tow)) _tow)
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:ionoBeta
   (&optional __ionoBeta)
   (if __ionoBeta (setq _ionoBeta __ionoBeta)) _ionoBeta)
  (:svHealth
   (&optional __svHealth)
   (if __svHealth (setq _svHealth __svHealth)) _svHealth)
  (:ionoCoeffsValid
   (&optional __ionoCoeffsValid)
   (if __ionoCoeffsValid (setq _ionoCoeffsValid __ionoCoeffsValid)) _ionoCoeffsValid)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _healthValid
    1
    ;; float32[] _ionoAlpha
    (* 4    (length _ionoAlpha)) 4
    ;; float32 _tow
    4
    ;; float32 _gpsWeek
    4
    ;; float32[] _ionoBeta
    (* 4    (length _ionoBeta)) 4
    ;; int64 _svHealth
    8
    ;; bool _ionoCoeffsValid
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _healthValid
       (if _healthValid (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _ionoAlpha
     (write-long (length _ionoAlpha) s)
     (dotimes (i (length _ionoAlpha))
       (sys::poke (elt _ionoAlpha i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _tow
       (sys::poke _tow (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gpsWeek
       (sys::poke _gpsWeek (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _ionoBeta
     (write-long (length _ionoBeta) s)
     (dotimes (i (length _ionoBeta))
       (sys::poke (elt _ionoBeta i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _svHealth
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _svHealth (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _svHealth) (= (length (_svHealth . bv)) 2)) ;; bignum
              (write-long (ash (elt (_svHealth . bv) 0) 0) s)
              (write-long (ash (elt (_svHealth . bv) 1) -1) s))
             ((and (class _svHealth) (= (length (_svHealth . bv)) 1)) ;; big1
              (write-long (elt (_svHealth . bv) 0) s)
              (write-long (if (>= _svHealth 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _svHealth s)(write-long (if (>= _svHealth 0) 0 #xffffffff) s)))
     ;; bool _ionoCoeffsValid
       (if _ionoCoeffsValid (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _healthValid
     (setq _healthValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _ionoAlpha
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ionoAlpha (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ionoAlpha i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _tow
     (setq _tow (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gpsWeek
     (setq _gpsWeek (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _ionoBeta
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ionoBeta (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ionoBeta i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _svHealth
#+(or :alpha :irix6 :x86_64)
      (setf _svHealth (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _svHealth (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _ionoCoeffsValid
     (setq _ionoCoeffsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::IonoData :md5sum-) "f905caa2eac71ee3a1208f47a49eafc0")
(setf (get openpilot_bridge::IonoData :datatype-) "openpilot_bridge/IonoData")
(setf (get openpilot_bridge::IonoData :definition-)
      "Header header

bool healthValid
float32[] ionoAlpha
float32 tow
float32 gpsWeek
float32[] ionoBeta
int64 svHealth
bool ionoCoeffsValid

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



(provide :openpilot_bridge/IonoData "f905caa2eac71ee3a1208f47a49eafc0")


