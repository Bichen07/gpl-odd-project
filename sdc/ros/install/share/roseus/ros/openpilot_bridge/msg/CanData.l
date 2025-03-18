;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CanData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CanData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CANDATA")
  (make-package "OPENPILOT_BRIDGE::CANDATA"))

(in-package "ROS")
;;//! \htmlinclude CanData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CanData
  :super ros::object
  :slots (_header _dat _src _busTime _address ))

(defmethod openpilot_bridge::CanData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:dat __dat) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:src __src) 0)
    ((:busTime __busTime) 0)
    ((:address __address) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _dat __dat)
   (setq _src (round __src))
   (setq _busTime (round __busTime))
   (setq _address (round __address))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:dat
   (&optional __dat)
   (if __dat (setq _dat __dat)) _dat)
  (:src
   (&optional __src)
   (if __src (setq _src __src)) _src)
  (:busTime
   (&optional __busTime)
   (if __busTime (setq _busTime __busTime)) _busTime)
  (:address
   (&optional __address)
   (if __address (setq _address __address)) _address)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _dat
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _dat)) 4
    ;; int64 _src
    8
    ;; int64 _busTime
    8
    ;; int64 _address
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _dat
     (write-long (length _dat) s)
     (dolist (elem _dat)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _src
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _src (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _src) (= (length (_src . bv)) 2)) ;; bignum
              (write-long (ash (elt (_src . bv) 0) 0) s)
              (write-long (ash (elt (_src . bv) 1) -1) s))
             ((and (class _src) (= (length (_src . bv)) 1)) ;; big1
              (write-long (elt (_src . bv) 0) s)
              (write-long (if (>= _src 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _src s)(write-long (if (>= _src 0) 0 #xffffffff) s)))
     ;; int64 _busTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _busTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _busTime) (= (length (_busTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_busTime . bv) 0) 0) s)
              (write-long (ash (elt (_busTime . bv) 1) -1) s))
             ((and (class _busTime) (= (length (_busTime . bv)) 1)) ;; big1
              (write-long (elt (_busTime . bv) 0) s)
              (write-long (if (>= _busTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _busTime s)(write-long (if (>= _busTime 0) 0 #xffffffff) s)))
     ;; int64 _address
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _address (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _address) (= (length (_address . bv)) 2)) ;; bignum
              (write-long (ash (elt (_address . bv) 0) 0) s)
              (write-long (ash (elt (_address . bv) 1) -1) s))
             ((and (class _address) (= (length (_address . bv)) 1)) ;; big1
              (write-long (elt (_address . bv) 0) s)
              (write-long (if (>= _address 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _address s)(write-long (if (>= _address 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _dat
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dat (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _dat i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _src
#+(or :alpha :irix6 :x86_64)
      (setf _src (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _src (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _busTime
#+(or :alpha :irix6 :x86_64)
      (setf _busTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _busTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _address
#+(or :alpha :irix6 :x86_64)
      (setf _address (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _address (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::CanData :md5sum-) "2bb06e6e3a8a81e0172131c09a692026")
(setf (get openpilot_bridge::CanData :datatype-) "openpilot_bridge/CanData")
(setf (get openpilot_bridge::CanData :definition-)
      "Header header

string[] dat
int64 src
int64 busTime
int64 address

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



(provide :openpilot_bridge/CanData "2bb06e6e3a8a81e0172131c09a692026")


