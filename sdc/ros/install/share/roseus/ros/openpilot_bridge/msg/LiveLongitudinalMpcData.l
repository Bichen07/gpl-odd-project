;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveLongitudinalMpcData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveLongitudinalMpcData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVELONGITUDINALMPCDATA")
  (make-package "OPENPILOT_BRIDGE::LIVELONGITUDINALMPCDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveLongitudinalMpcData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveLongitudinalMpcData
  :super ros::object
  :slots (_header _aLeadTau _vLead _aLead _xEgo _xLead _mpcId _cost _aEgo _calculationTime _qpIterations _vEgo ))

(defmethod openpilot_bridge::LiveLongitudinalMpcData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:aLeadTau __aLeadTau) 0.0)
    ((:vLead __vLead) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:aLead __aLead) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:xEgo __xEgo) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:xLead __xLead) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:mpcId __mpcId) 0)
    ((:cost __cost) 0.0)
    ((:aEgo __aEgo) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:calculationTime __calculationTime) 0)
    ((:qpIterations __qpIterations) 0)
    ((:vEgo __vEgo) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _aLeadTau (float __aLeadTau))
   (setq _vLead __vLead)
   (setq _aLead __aLead)
   (setq _xEgo __xEgo)
   (setq _xLead __xLead)
   (setq _mpcId (round __mpcId))
   (setq _cost (float __cost))
   (setq _aEgo __aEgo)
   (setq _calculationTime (round __calculationTime))
   (setq _qpIterations (round __qpIterations))
   (setq _vEgo __vEgo)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:aLeadTau
   (&optional __aLeadTau)
   (if __aLeadTau (setq _aLeadTau __aLeadTau)) _aLeadTau)
  (:vLead
   (&optional __vLead)
   (if __vLead (setq _vLead __vLead)) _vLead)
  (:aLead
   (&optional __aLead)
   (if __aLead (setq _aLead __aLead)) _aLead)
  (:xEgo
   (&optional __xEgo)
   (if __xEgo (setq _xEgo __xEgo)) _xEgo)
  (:xLead
   (&optional __xLead)
   (if __xLead (setq _xLead __xLead)) _xLead)
  (:mpcId
   (&optional __mpcId)
   (if __mpcId (setq _mpcId __mpcId)) _mpcId)
  (:cost
   (&optional __cost)
   (if __cost (setq _cost __cost)) _cost)
  (:aEgo
   (&optional __aEgo)
   (if __aEgo (setq _aEgo __aEgo)) _aEgo)
  (:calculationTime
   (&optional __calculationTime)
   (if __calculationTime (setq _calculationTime __calculationTime)) _calculationTime)
  (:qpIterations
   (&optional __qpIterations)
   (if __qpIterations (setq _qpIterations __qpIterations)) _qpIterations)
  (:vEgo
   (&optional __vEgo)
   (if __vEgo (setq _vEgo __vEgo)) _vEgo)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _aLeadTau
    4
    ;; float32[] _vLead
    (* 4    (length _vLead)) 4
    ;; float32[] _aLead
    (* 4    (length _aLead)) 4
    ;; float32[] _xEgo
    (* 4    (length _xEgo)) 4
    ;; float32[] _xLead
    (* 4    (length _xLead)) 4
    ;; int64 _mpcId
    8
    ;; float32 _cost
    4
    ;; float32[] _aEgo
    (* 4    (length _aEgo)) 4
    ;; int64 _calculationTime
    8
    ;; int64 _qpIterations
    8
    ;; float32[] _vEgo
    (* 4    (length _vEgo)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _aLeadTau
       (sys::poke _aLeadTau (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _vLead
     (write-long (length _vLead) s)
     (dotimes (i (length _vLead))
       (sys::poke (elt _vLead i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _aLead
     (write-long (length _aLead) s)
     (dotimes (i (length _aLead))
       (sys::poke (elt _aLead i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _xEgo
     (write-long (length _xEgo) s)
     (dotimes (i (length _xEgo))
       (sys::poke (elt _xEgo i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _xLead
     (write-long (length _xLead) s)
     (dotimes (i (length _xLead))
       (sys::poke (elt _xLead i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _mpcId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mpcId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mpcId) (= (length (_mpcId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mpcId . bv) 0) 0) s)
              (write-long (ash (elt (_mpcId . bv) 1) -1) s))
             ((and (class _mpcId) (= (length (_mpcId . bv)) 1)) ;; big1
              (write-long (elt (_mpcId . bv) 0) s)
              (write-long (if (>= _mpcId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mpcId s)(write-long (if (>= _mpcId 0) 0 #xffffffff) s)))
     ;; float32 _cost
       (sys::poke _cost (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _aEgo
     (write-long (length _aEgo) s)
     (dotimes (i (length _aEgo))
       (sys::poke (elt _aEgo i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; float32[] _vEgo
     (write-long (length _vEgo) s)
     (dotimes (i (length _vEgo))
       (sys::poke (elt _vEgo i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _aLeadTau
     (setq _aLeadTau (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _vLead
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vLead (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _vLead i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _aLead
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _aLead (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _aLead i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _xEgo
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _xEgo (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _xEgo i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _xLead
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _xLead (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _xLead i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _mpcId
#+(or :alpha :irix6 :x86_64)
      (setf _mpcId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mpcId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _cost
     (setq _cost (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _aEgo
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _aEgo (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _aEgo i) (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; float32[] _vEgo
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vEgo (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _vEgo i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveLongitudinalMpcData :md5sum-) "4c7abc357e4c77b07789c23a2bc077f9")
(setf (get openpilot_bridge::LiveLongitudinalMpcData :datatype-) "openpilot_bridge/LiveLongitudinalMpcData")
(setf (get openpilot_bridge::LiveLongitudinalMpcData :definition-)
      "Header header

float32 aLeadTau
float32[] vLead
float32[] aLead
float32[] xEgo
float32[] xLead
int64 mpcId
float32 cost
float32[] aEgo
int64 calculationTime
int64 qpIterations
float32[] vEgo

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



(provide :openpilot_bridge/LiveLongitudinalMpcData "4c7abc357e4c77b07789c23a2bc077f9")


