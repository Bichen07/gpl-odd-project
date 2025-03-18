;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::GPSNMEAData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'GPSNMEAData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::GPSNMEADATA")
  (make-package "OPENPILOT_BRIDGE::GPSNMEADATA"))

(in-package "ROS")
;;//! \htmlinclude GPSNMEAData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::GPSNMEAData
  :super ros::object
  :slots (_header _timestamp _nmea _localWallTime ))

(defmethod openpilot_bridge::GPSNMEAData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:timestamp __timestamp) 0)
    ((:nmea __nmea) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:localWallTime __localWallTime) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _timestamp (round __timestamp))
   (setq _nmea __nmea)
   (setq _localWallTime (round __localWallTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:nmea
   (&optional __nmea)
   (if __nmea (setq _nmea __nmea)) _nmea)
  (:localWallTime
   (&optional __localWallTime)
   (if __localWallTime (setq _localWallTime __localWallTime)) _localWallTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _timestamp
    4
    ;; string[] _nmea
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _nmea)) 4
    ;; int64 _localWallTime
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _timestamp
       (write-long _timestamp s)
     ;; string[] _nmea
     (write-long (length _nmea) s)
     (dolist (elem _nmea)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _localWallTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _localWallTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _localWallTime) (= (length (_localWallTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_localWallTime . bv) 0) 0) s)
              (write-long (ash (elt (_localWallTime . bv) 1) -1) s))
             ((and (class _localWallTime) (= (length (_localWallTime . bv)) 1)) ;; big1
              (write-long (elt (_localWallTime . bv) 0) s)
              (write-long (if (>= _localWallTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _localWallTime s)(write-long (if (>= _localWallTime 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _timestamp
     (setq _timestamp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _nmea
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nmea (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _nmea i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _localWallTime
#+(or :alpha :irix6 :x86_64)
      (setf _localWallTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _localWallTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::GPSNMEAData :md5sum-) "473a7724942a495946b6258948b21149")
(setf (get openpilot_bridge::GPSNMEAData :datatype-) "openpilot_bridge/GPSNMEAData")
(setf (get openpilot_bridge::GPSNMEAData :definition-)
      "Header header

int32 timestamp
string[] nmea
int64 localWallTime

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



(provide :openpilot_bridge/GPSNMEAData "473a7724942a495946b6258948b21149")


