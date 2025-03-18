;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::EncodeIndex)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'EncodeIndex (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ENCODEINDEX")
  (make-package "OPENPILOT_BRIDGE::ENCODEINDEX"))

(in-package "ROS")
;;//! \htmlinclude EncodeIndex.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::EncodeIndex
  :super ros::object
  :slots (_header _segmentId _segmentIdEncode _frameId _encodeId _type _segmentNum ))

(defmethod openpilot_bridge::EncodeIndex
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:segmentId __segmentId) 0)
    ((:segmentIdEncode __segmentIdEncode) 0)
    ((:frameId __frameId) 0)
    ((:encodeId __encodeId) 0)
    ((:type __type) 0)
    ((:segmentNum __segmentNum) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _segmentId (round __segmentId))
   (setq _segmentIdEncode (round __segmentIdEncode))
   (setq _frameId (round __frameId))
   (setq _encodeId (round __encodeId))
   (setq _type (round __type))
   (setq _segmentNum (round __segmentNum))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:segmentId
   (&optional __segmentId)
   (if __segmentId (setq _segmentId __segmentId)) _segmentId)
  (:segmentIdEncode
   (&optional __segmentIdEncode)
   (if __segmentIdEncode (setq _segmentIdEncode __segmentIdEncode)) _segmentIdEncode)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:encodeId
   (&optional __encodeId)
   (if __encodeId (setq _encodeId __encodeId)) _encodeId)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:segmentNum
   (&optional __segmentNum)
   (if __segmentNum (setq _segmentNum __segmentNum)) _segmentNum)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _segmentId
    8
    ;; int64 _segmentIdEncode
    8
    ;; int64 _frameId
    8
    ;; int64 _encodeId
    8
    ;; uint32 _type
    4
    ;; int32 _segmentNum
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _segmentId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _segmentId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _segmentId) (= (length (_segmentId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_segmentId . bv) 0) 0) s)
              (write-long (ash (elt (_segmentId . bv) 1) -1) s))
             ((and (class _segmentId) (= (length (_segmentId . bv)) 1)) ;; big1
              (write-long (elt (_segmentId . bv) 0) s)
              (write-long (if (>= _segmentId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _segmentId s)(write-long (if (>= _segmentId 0) 0 #xffffffff) s)))
     ;; int64 _segmentIdEncode
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _segmentIdEncode (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _segmentIdEncode) (= (length (_segmentIdEncode . bv)) 2)) ;; bignum
              (write-long (ash (elt (_segmentIdEncode . bv) 0) 0) s)
              (write-long (ash (elt (_segmentIdEncode . bv) 1) -1) s))
             ((and (class _segmentIdEncode) (= (length (_segmentIdEncode . bv)) 1)) ;; big1
              (write-long (elt (_segmentIdEncode . bv) 0) s)
              (write-long (if (>= _segmentIdEncode 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _segmentIdEncode s)(write-long (if (>= _segmentIdEncode 0) 0 #xffffffff) s)))
     ;; int64 _frameId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _frameId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _frameId) (= (length (_frameId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_frameId . bv) 0) 0) s)
              (write-long (ash (elt (_frameId . bv) 1) -1) s))
             ((and (class _frameId) (= (length (_frameId . bv)) 1)) ;; big1
              (write-long (elt (_frameId . bv) 0) s)
              (write-long (if (>= _frameId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _frameId s)(write-long (if (>= _frameId 0) 0 #xffffffff) s)))
     ;; int64 _encodeId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _encodeId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _encodeId) (= (length (_encodeId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_encodeId . bv) 0) 0) s)
              (write-long (ash (elt (_encodeId . bv) 1) -1) s))
             ((and (class _encodeId) (= (length (_encodeId . bv)) 1)) ;; big1
              (write-long (elt (_encodeId . bv) 0) s)
              (write-long (if (>= _encodeId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _encodeId s)(write-long (if (>= _encodeId 0) 0 #xffffffff) s)))
     ;; uint32 _type
       (write-long _type s)
     ;; int32 _segmentNum
       (write-long _segmentNum s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _segmentId
#+(or :alpha :irix6 :x86_64)
      (setf _segmentId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _segmentId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _segmentIdEncode
#+(or :alpha :irix6 :x86_64)
      (setf _segmentIdEncode (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _segmentIdEncode (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _frameId
#+(or :alpha :irix6 :x86_64)
      (setf _frameId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _frameId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _encodeId
#+(or :alpha :irix6 :x86_64)
      (setf _encodeId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _encodeId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _segmentNum
     (setq _segmentNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::EncodeIndex :md5sum-) "8777c88982f7111522c38f60cd2e924a")
(setf (get openpilot_bridge::EncodeIndex :datatype-) "openpilot_bridge/EncodeIndex")
(setf (get openpilot_bridge::EncodeIndex :definition-)
      "Header header

int64 segmentId
int64 segmentIdEncode
int64 frameId
int64 encodeId
uint32 type # enum const: Type
int32 segmentNum

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



(provide :openpilot_bridge/EncodeIndex "8777c88982f7111522c38f60cd2e924a")


