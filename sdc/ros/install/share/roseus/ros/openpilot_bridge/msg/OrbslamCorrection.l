;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbslamCorrection)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbslamCorrection (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBSLAMCORRECTION")
  (make-package "OPENPILOT_BRIDGE::ORBSLAMCORRECTION"))

(in-package "ROS")
;;//! \htmlinclude OrbslamCorrection.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbslamCorrection
  :super ros::object
  :slots (_header _correctionMonoTime _prePositionECEF _postPositionECEF _postPoseQuatECEF _numInliers _prePoseQuatECEF ))

(defmethod openpilot_bridge::OrbslamCorrection
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:correctionMonoTime __correctionMonoTime) 0)
    ((:prePositionECEF __prePositionECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:postPositionECEF __postPositionECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:postPoseQuatECEF __postPoseQuatECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:numInliers __numInliers) 0)
    ((:prePoseQuatECEF __prePoseQuatECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _correctionMonoTime (round __correctionMonoTime))
   (setq _prePositionECEF __prePositionECEF)
   (setq _postPositionECEF __postPositionECEF)
   (setq _postPoseQuatECEF __postPoseQuatECEF)
   (setq _numInliers (round __numInliers))
   (setq _prePoseQuatECEF __prePoseQuatECEF)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:correctionMonoTime
   (&optional __correctionMonoTime)
   (if __correctionMonoTime (setq _correctionMonoTime __correctionMonoTime)) _correctionMonoTime)
  (:prePositionECEF
   (&optional __prePositionECEF)
   (if __prePositionECEF (setq _prePositionECEF __prePositionECEF)) _prePositionECEF)
  (:postPositionECEF
   (&optional __postPositionECEF)
   (if __postPositionECEF (setq _postPositionECEF __postPositionECEF)) _postPositionECEF)
  (:postPoseQuatECEF
   (&optional __postPoseQuatECEF)
   (if __postPoseQuatECEF (setq _postPoseQuatECEF __postPoseQuatECEF)) _postPoseQuatECEF)
  (:numInliers
   (&optional __numInliers)
   (if __numInliers (setq _numInliers __numInliers)) _numInliers)
  (:prePoseQuatECEF
   (&optional __prePoseQuatECEF)
   (if __prePoseQuatECEF (setq _prePoseQuatECEF __prePoseQuatECEF)) _prePoseQuatECEF)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _correctionMonoTime
    8
    ;; float32[] _prePositionECEF
    (* 4    (length _prePositionECEF)) 4
    ;; float32[] _postPositionECEF
    (* 4    (length _postPositionECEF)) 4
    ;; float32[] _postPoseQuatECEF
    (* 4    (length _postPoseQuatECEF)) 4
    ;; int64 _numInliers
    8
    ;; float32[] _prePoseQuatECEF
    (* 4    (length _prePoseQuatECEF)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _correctionMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _correctionMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _correctionMonoTime) (= (length (_correctionMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_correctionMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_correctionMonoTime . bv) 1) -1) s))
             ((and (class _correctionMonoTime) (= (length (_correctionMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_correctionMonoTime . bv) 0) s)
              (write-long (if (>= _correctionMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _correctionMonoTime s)(write-long (if (>= _correctionMonoTime 0) 0 #xffffffff) s)))
     ;; float32[] _prePositionECEF
     (write-long (length _prePositionECEF) s)
     (dotimes (i (length _prePositionECEF))
       (sys::poke (elt _prePositionECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _postPositionECEF
     (write-long (length _postPositionECEF) s)
     (dotimes (i (length _postPositionECEF))
       (sys::poke (elt _postPositionECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _postPoseQuatECEF
     (write-long (length _postPoseQuatECEF) s)
     (dotimes (i (length _postPoseQuatECEF))
       (sys::poke (elt _postPoseQuatECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _numInliers
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _numInliers (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _numInliers) (= (length (_numInliers . bv)) 2)) ;; bignum
              (write-long (ash (elt (_numInliers . bv) 0) 0) s)
              (write-long (ash (elt (_numInliers . bv) 1) -1) s))
             ((and (class _numInliers) (= (length (_numInliers . bv)) 1)) ;; big1
              (write-long (elt (_numInliers . bv) 0) s)
              (write-long (if (>= _numInliers 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _numInliers s)(write-long (if (>= _numInliers 0) 0 #xffffffff) s)))
     ;; float32[] _prePoseQuatECEF
     (write-long (length _prePoseQuatECEF) s)
     (dotimes (i (length _prePoseQuatECEF))
       (sys::poke (elt _prePoseQuatECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _correctionMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _correctionMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _correctionMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _prePositionECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _prePositionECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _prePositionECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _postPositionECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _postPositionECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _postPositionECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _postPoseQuatECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _postPoseQuatECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _postPoseQuatECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _numInliers
#+(or :alpha :irix6 :x86_64)
      (setf _numInliers (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _numInliers (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _prePoseQuatECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _prePoseQuatECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _prePoseQuatECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::OrbslamCorrection :md5sum-) "5782313d8262eba95695c847d7e1398d")
(setf (get openpilot_bridge::OrbslamCorrection :datatype-) "openpilot_bridge/OrbslamCorrection")
(setf (get openpilot_bridge::OrbslamCorrection :definition-)
      "Header header

int64 correctionMonoTime
float32[] prePositionECEF
float32[] postPositionECEF
float32[] postPoseQuatECEF
int64 numInliers
float32[] prePoseQuatECEF

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



(provide :openpilot_bridge/OrbslamCorrection "5782313d8262eba95695c847d7e1398d")


