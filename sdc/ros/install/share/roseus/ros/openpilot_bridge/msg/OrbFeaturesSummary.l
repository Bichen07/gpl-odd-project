;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbFeaturesSummary)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbFeaturesSummary (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBFEATURESSUMMARY")
  (make-package "OPENPILOT_BRIDGE::ORBFEATURESSUMMARY"))

(in-package "ROS")
;;//! \htmlinclude OrbFeaturesSummary.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbFeaturesSummary
  :super ros::object
  :slots (_header _timestampEof _featureCount _matchCount _timestampLastEof _computeNs ))

(defmethod openpilot_bridge::OrbFeaturesSummary
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:timestampEof __timestampEof) 0)
    ((:featureCount __featureCount) 0)
    ((:matchCount __matchCount) 0)
    ((:timestampLastEof __timestampLastEof) 0)
    ((:computeNs __computeNs) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _timestampEof (round __timestampEof))
   (setq _featureCount (round __featureCount))
   (setq _matchCount (round __matchCount))
   (setq _timestampLastEof (round __timestampLastEof))
   (setq _computeNs (round __computeNs))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:timestampEof
   (&optional __timestampEof)
   (if __timestampEof (setq _timestampEof __timestampEof)) _timestampEof)
  (:featureCount
   (&optional __featureCount)
   (if __featureCount (setq _featureCount __featureCount)) _featureCount)
  (:matchCount
   (&optional __matchCount)
   (if __matchCount (setq _matchCount __matchCount)) _matchCount)
  (:timestampLastEof
   (&optional __timestampLastEof)
   (if __timestampLastEof (setq _timestampLastEof __timestampLastEof)) _timestampLastEof)
  (:computeNs
   (&optional __computeNs)
   (if __computeNs (setq _computeNs __computeNs)) _computeNs)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _timestampEof
    8
    ;; int64 _featureCount
    8
    ;; int64 _matchCount
    8
    ;; int64 _timestampLastEof
    8
    ;; int64 _computeNs
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
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
     ;; int64 _featureCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _featureCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _featureCount) (= (length (_featureCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_featureCount . bv) 0) 0) s)
              (write-long (ash (elt (_featureCount . bv) 1) -1) s))
             ((and (class _featureCount) (= (length (_featureCount . bv)) 1)) ;; big1
              (write-long (elt (_featureCount . bv) 0) s)
              (write-long (if (>= _featureCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _featureCount s)(write-long (if (>= _featureCount 0) 0 #xffffffff) s)))
     ;; int64 _matchCount
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _matchCount (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _matchCount) (= (length (_matchCount . bv)) 2)) ;; bignum
              (write-long (ash (elt (_matchCount . bv) 0) 0) s)
              (write-long (ash (elt (_matchCount . bv) 1) -1) s))
             ((and (class _matchCount) (= (length (_matchCount . bv)) 1)) ;; big1
              (write-long (elt (_matchCount . bv) 0) s)
              (write-long (if (>= _matchCount 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _matchCount s)(write-long (if (>= _matchCount 0) 0 #xffffffff) s)))
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
     ;; int64 _computeNs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _computeNs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _computeNs) (= (length (_computeNs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_computeNs . bv) 0) 0) s)
              (write-long (ash (elt (_computeNs . bv) 1) -1) s))
             ((and (class _computeNs) (= (length (_computeNs . bv)) 1)) ;; big1
              (write-long (elt (_computeNs . bv) 0) s)
              (write-long (if (>= _computeNs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _computeNs s)(write-long (if (>= _computeNs 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
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
   ;; int64 _featureCount
#+(or :alpha :irix6 :x86_64)
      (setf _featureCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _featureCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _matchCount
#+(or :alpha :irix6 :x86_64)
      (setf _matchCount (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _matchCount (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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
   ;; int64 _computeNs
#+(or :alpha :irix6 :x86_64)
      (setf _computeNs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _computeNs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::OrbFeaturesSummary :md5sum-) "afb40913cace05ea0c7922dff3fa207f")
(setf (get openpilot_bridge::OrbFeaturesSummary :datatype-) "openpilot_bridge/OrbFeaturesSummary")
(setf (get openpilot_bridge::OrbFeaturesSummary :definition-)
      "Header header

int64 timestampEof
int64 featureCount
int64 matchCount
int64 timestampLastEof
int64 computeNs

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



(provide :openpilot_bridge/OrbFeaturesSummary "afb40913cace05ea0c7922dff3fa207f")


