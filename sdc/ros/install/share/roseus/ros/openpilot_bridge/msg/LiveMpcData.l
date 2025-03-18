;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveMpcData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveMpcData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVEMPCDATA")
  (make-package "OPENPILOT_BRIDGE::LIVEMPCDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveMpcData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveMpcData
  :super ros::object
  :slots (_header _psi _qpIterations _cost _delta _y _x _calculationTime ))

(defmethod openpilot_bridge::LiveMpcData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:psi __psi) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:qpIterations __qpIterations) 0)
    ((:cost __cost) 0.0)
    ((:delta __delta) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:y __y) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:x __x) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:calculationTime __calculationTime) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _psi __psi)
   (setq _qpIterations (round __qpIterations))
   (setq _cost (float __cost))
   (setq _delta __delta)
   (setq _y __y)
   (setq _x __x)
   (setq _calculationTime (round __calculationTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:psi
   (&optional __psi)
   (if __psi (setq _psi __psi)) _psi)
  (:qpIterations
   (&optional __qpIterations)
   (if __qpIterations (setq _qpIterations __qpIterations)) _qpIterations)
  (:cost
   (&optional __cost)
   (if __cost (setq _cost __cost)) _cost)
  (:delta
   (&optional __delta)
   (if __delta (setq _delta __delta)) _delta)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:calculationTime
   (&optional __calculationTime)
   (if __calculationTime (setq _calculationTime __calculationTime)) _calculationTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _psi
    (* 4    (length _psi)) 4
    ;; int64 _qpIterations
    8
    ;; float32 _cost
    4
    ;; float32[] _delta
    (* 4    (length _delta)) 4
    ;; float32[] _y
    (* 4    (length _y)) 4
    ;; float32[] _x
    (* 4    (length _x)) 4
    ;; int64 _calculationTime
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _psi
     (write-long (length _psi) s)
     (dotimes (i (length _psi))
       (sys::poke (elt _psi i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _qpIterations
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _qpIterations (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _qpIterations) (= (length (_qpIterations . bv)) 2)) ;; bignum
              (write-long (ash (elt (_qpIterations . bv) 0) 0) s)
              (write-long (ash (elt (_qpIterations . bv) 1) -1) s))
             ((and (class _qpIterations) (= (length (_qpIterations . bv)) 1)) ;; big1
              (write-long (elt (_qpIterations . bv) 0) s)
              (write-long (if (>= _qpIterations 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _qpIterations s)(write-long (if (>= _qpIterations 0) 0 #xffffffff) s)))
     ;; float32 _cost
       (sys::poke _cost (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _delta
     (write-long (length _delta) s)
     (dotimes (i (length _delta))
       (sys::poke (elt _delta i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _y
     (write-long (length _y) s)
     (dotimes (i (length _y))
       (sys::poke (elt _y i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _x
     (write-long (length _x) s)
     (dotimes (i (length _x))
       (sys::poke (elt _x i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _calculationTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _calculationTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _calculationTime) (= (length (_calculationTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_calculationTime . bv) 0) 0) s)
              (write-long (ash (elt (_calculationTime . bv) 1) -1) s))
             ((and (class _calculationTime) (= (length (_calculationTime . bv)) 1)) ;; big1
              (write-long (elt (_calculationTime . bv) 0) s)
              (write-long (if (>= _calculationTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _calculationTime s)(write-long (if (>= _calculationTime 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _psi
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _psi (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _psi i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _qpIterations
#+(or :alpha :irix6 :x86_64)
      (setf _qpIterations (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _qpIterations (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _cost
     (setq _cost (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _delta
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _delta (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _delta i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _y
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _y (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _y i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _x
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _x (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _x i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _calculationTime
#+(or :alpha :irix6 :x86_64)
      (setf _calculationTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _calculationTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::LiveMpcData :md5sum-) "311969c98af5c48778808efefe644446")
(setf (get openpilot_bridge::LiveMpcData :datatype-) "openpilot_bridge/LiveMpcData")
(setf (get openpilot_bridge::LiveMpcData :definition-)
      "Header header

float32[] psi
int64 qpIterations
float32 cost
float32[] delta
float32[] y
float32[] x
int64 calculationTime

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



(provide :openpilot_bridge/LiveMpcData "311969c98af5c48778808efefe644446")


