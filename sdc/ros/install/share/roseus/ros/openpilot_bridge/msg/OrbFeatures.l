;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbFeatures)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbFeatures (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBFEATURES")
  (make-package "OPENPILOT_BRIDGE::ORBFEATURES"))

(in-package "ROS")
;;//! \htmlinclude OrbFeatures.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbFeatures
  :super ros::object
  :slots (_header _octaves _matches _descriptors _timestampEof _timestampLastEof _xs _ys ))

(defmethod openpilot_bridge::OrbFeatures
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:octaves __octaves) (make-array 0 :initial-element 0 :element-type :integer))
    ((:matches __matches) (make-array 0 :initial-element 0 :element-type :integer))
    ((:descriptors __descriptors) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:timestampEof __timestampEof) 0)
    ((:timestampLastEof __timestampLastEof) 0)
    ((:xs __xs) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:ys __ys) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _octaves __octaves)
   (setq _matches __matches)
   (setq _descriptors __descriptors)
   (setq _timestampEof (round __timestampEof))
   (setq _timestampLastEof (round __timestampLastEof))
   (setq _xs __xs)
   (setq _ys __ys)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:octaves
   (&optional __octaves)
   (if __octaves (setq _octaves __octaves)) _octaves)
  (:matches
   (&optional __matches)
   (if __matches (setq _matches __matches)) _matches)
  (:descriptors
   (&optional __descriptors)
   (if __descriptors (setq _descriptors __descriptors)) _descriptors)
  (:timestampEof
   (&optional __timestampEof)
   (if __timestampEof (setq _timestampEof __timestampEof)) _timestampEof)
  (:timestampLastEof
   (&optional __timestampLastEof)
   (if __timestampLastEof (setq _timestampLastEof __timestampLastEof)) _timestampLastEof)
  (:xs
   (&optional __xs)
   (if __xs (setq _xs __xs)) _xs)
  (:ys
   (&optional __ys)
   (if __ys (setq _ys __ys)) _ys)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32[] _octaves
    (* 4    (length _octaves)) 4
    ;; int32[] _matches
    (* 4    (length _matches)) 4
    ;; string[] _descriptors
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _descriptors)) 4
    ;; int64 _timestampEof
    8
    ;; int64 _timestampLastEof
    8
    ;; float32[] _xs
    (* 4    (length _xs)) 4
    ;; float32[] _ys
    (* 4    (length _ys)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32[] _octaves
     (write-long (length _octaves) s)
     (dotimes (i (length _octaves))
       (write-long (elt _octaves i) s)
       )
     ;; int32[] _matches
     (write-long (length _matches) s)
     (dotimes (i (length _matches))
       (write-long (elt _matches i) s)
       )
     ;; string[] _descriptors
     (write-long (length _descriptors) s)
     (dolist (elem _descriptors)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestampEof (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestampEof) (= (length (_timestampEof . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestampEof . bv) 0) 0) s)
              (write-long (ash (elt (_timestampEof . bv) 1) -1) s))
             ((and (class _timestampEof) (= (length (_timestampEof . bv)) 1)) ;; big1
              (write-long (elt (_timestampEof . bv) 0) s)
              (write-long (if (>= _timestampEof 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestampEof s)(write-long (if (>= _timestampEof 0) 0 #xffffffff) s)))
     ;; int64 _timestampLastEof
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestampLastEof (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestampLastEof) (= (length (_timestampLastEof . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestampLastEof . bv) 0) 0) s)
              (write-long (ash (elt (_timestampLastEof . bv) 1) -1) s))
             ((and (class _timestampLastEof) (= (length (_timestampLastEof . bv)) 1)) ;; big1
              (write-long (elt (_timestampLastEof . bv) 0) s)
              (write-long (if (>= _timestampLastEof 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestampLastEof s)(write-long (if (>= _timestampLastEof 0) 0 #xffffffff) s)))
     ;; float32[] _xs
     (write-long (length _xs) s)
     (dotimes (i (length _xs))
       (sys::poke (elt _xs i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _ys
     (write-long (length _ys) s)
     (dotimes (i (length _ys))
       (sys::poke (elt _ys i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32[] _octaves
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _octaves (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _octaves i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _matches
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _matches (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _matches i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; string[] _descriptors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _descriptors (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _descriptors i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
      (setf _timestampEof (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestampEof (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _timestampLastEof
#+(or :alpha :irix6 :x86_64)
      (setf _timestampLastEof (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestampLastEof (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _xs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _xs (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _xs i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _ys
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ys (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ys i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::OrbFeatures :md5sum-) "c1391d81b99a78f3f4c88eddd0353256")
(setf (get openpilot_bridge::OrbFeatures :datatype-) "openpilot_bridge/OrbFeatures")
(setf (get openpilot_bridge::OrbFeatures :definition-)
      "Header header

int32[] octaves
int32[] matches
string[] descriptors
int64 timestampEof
int64 timestampLastEof
float32[] xs
float32[] ys

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



(provide :openpilot_bridge/OrbFeatures "c1391d81b99a78f3f4c88eddd0353256")


