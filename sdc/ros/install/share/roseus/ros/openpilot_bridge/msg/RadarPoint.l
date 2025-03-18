;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::RadarPoint)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'RadarPoint (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::RADARPOINT")
  (make-package "OPENPILOT_BRIDGE::RADARPOINT"))

(in-package "ROS")
;;//! \htmlinclude RadarPoint.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::RadarPoint
  :super ros::object
  :slots (_header _yRel _trackId _aRel _vRel _dRel _yvRel _measured ))

(defmethod openpilot_bridge::RadarPoint
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:yRel __yRel) 0.0)
    ((:trackId __trackId) 0)
    ((:aRel __aRel) 0.0)
    ((:vRel __vRel) 0.0)
    ((:dRel __dRel) 0.0)
    ((:yvRel __yvRel) 0.0)
    ((:measured __measured) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _yRel (float __yRel))
   (setq _trackId (round __trackId))
   (setq _aRel (float __aRel))
   (setq _vRel (float __vRel))
   (setq _dRel (float __dRel))
   (setq _yvRel (float __yvRel))
   (setq _measured __measured)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:yRel
   (&optional __yRel)
   (if __yRel (setq _yRel __yRel)) _yRel)
  (:trackId
   (&optional __trackId)
   (if __trackId (setq _trackId __trackId)) _trackId)
  (:aRel
   (&optional __aRel)
   (if __aRel (setq _aRel __aRel)) _aRel)
  (:vRel
   (&optional __vRel)
   (if __vRel (setq _vRel __vRel)) _vRel)
  (:dRel
   (&optional __dRel)
   (if __dRel (setq _dRel __dRel)) _dRel)
  (:yvRel
   (&optional __yvRel)
   (if __yvRel (setq _yvRel __yvRel)) _yvRel)
  (:measured
   (&optional __measured)
   (if __measured (setq _measured __measured)) _measured)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _yRel
    4
    ;; int64 _trackId
    8
    ;; float32 _aRel
    4
    ;; float32 _vRel
    4
    ;; float32 _dRel
    4
    ;; float32 _yvRel
    4
    ;; bool _measured
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _yRel
       (sys::poke _yRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _trackId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _trackId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _trackId) (= (length (_trackId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_trackId . bv) 0) 0) s)
              (write-long (ash (elt (_trackId . bv) 1) -1) s))
             ((and (class _trackId) (= (length (_trackId . bv)) 1)) ;; big1
              (write-long (elt (_trackId . bv) 0) s)
              (write-long (if (>= _trackId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _trackId s)(write-long (if (>= _trackId 0) 0 #xffffffff) s)))
     ;; float32 _aRel
       (sys::poke _aRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vRel
       (sys::poke _vRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dRel
       (sys::poke _dRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yvRel
       (sys::poke _yvRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _measured
       (if _measured (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _yRel
     (setq _yRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _trackId
#+(or :alpha :irix6 :x86_64)
      (setf _trackId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _trackId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _aRel
     (setq _aRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vRel
     (setq _vRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dRel
     (setq _dRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yvRel
     (setq _yvRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _measured
     (setq _measured (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::RadarPoint :md5sum-) "3ce9f9a91082e3c1c6436dc94453ce9e")
(setf (get openpilot_bridge::RadarPoint :datatype-) "openpilot_bridge/RadarPoint")
(setf (get openpilot_bridge::RadarPoint :definition-)
      "Header header

float32 yRel
int64 trackId
float32 aRel
float32 vRel
float32 dRel
float32 yvRel
bool measured

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



(provide :openpilot_bridge/RadarPoint "3ce9f9a91082e3c1c6436dc94453ce9e")


