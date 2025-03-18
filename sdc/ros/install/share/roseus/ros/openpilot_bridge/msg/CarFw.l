;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CarFw)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CarFw (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CARFW")
  (make-package "OPENPILOT_BRIDGE::CARFW"))

(in-package "ROS")
;;//! \htmlinclude CarFw.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CarFw
  :super ros::object
  :slots (_header _ecu _subAddress _fwVersion _address ))

(defmethod openpilot_bridge::CarFw
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ecu __ecu) 0)
    ((:subAddress __subAddress) 0)
    ((:fwVersion __fwVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:address __address) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _ecu (round __ecu))
   (setq _subAddress (round __subAddress))
   (setq _fwVersion __fwVersion)
   (setq _address (round __address))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:ecu
   (&optional __ecu)
   (if __ecu (setq _ecu __ecu)) _ecu)
  (:subAddress
   (&optional __subAddress)
   (if __subAddress (setq _subAddress __subAddress)) _subAddress)
  (:fwVersion
   (&optional __fwVersion)
   (if __fwVersion (setq _fwVersion __fwVersion)) _fwVersion)
  (:address
   (&optional __address)
   (if __address (setq _address __address)) _address)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _ecu
    4
    ;; int64 _subAddress
    8
    ;; string[] _fwVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _fwVersion)) 4
    ;; int64 _address
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _ecu
       (write-long _ecu s)
     ;; int64 _subAddress
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _subAddress (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _subAddress) (= (length (_subAddress . bv)) 2)) ;; bignum
              (write-long (ash (elt (_subAddress . bv) 0) 0) s)
              (write-long (ash (elt (_subAddress . bv) 1) -1) s))
             ((and (class _subAddress) (= (length (_subAddress . bv)) 1)) ;; big1
              (write-long (elt (_subAddress . bv) 0) s)
              (write-long (if (>= _subAddress 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _subAddress s)(write-long (if (>= _subAddress 0) 0 #xffffffff) s)))
     ;; string[] _fwVersion
     (write-long (length _fwVersion) s)
     (dolist (elem _fwVersion)
       (write-long (length elem) s) (princ elem s)
       )
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
   ;; uint32 _ecu
     (setq _ecu (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _subAddress
#+(or :alpha :irix6 :x86_64)
      (setf _subAddress (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _subAddress (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _fwVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _fwVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _fwVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
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

(setf (get openpilot_bridge::CarFw :md5sum-) "032226e9b604d6d0ae12c42eae70f306")
(setf (get openpilot_bridge::CarFw :datatype-) "openpilot_bridge/CarFw")
(setf (get openpilot_bridge::CarFw :definition-)
      "Header header

uint32 ecu # enum const: Ecu
int64 subAddress
string[] fwVersion
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



(provide :openpilot_bridge/CarFw "032226e9b604d6d0ae12c42eae70f306")


