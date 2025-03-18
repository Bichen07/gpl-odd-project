;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbKeyFrame)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbKeyFrame (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBKEYFRAME")
  (make-package "OPENPILOT_BRIDGE::ORBKEYFRAME"))

(in-package "ROS")
;;//! \htmlinclude OrbKeyFrame.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbKeyFrame
  :super ros::object
  :slots (_header _descriptors _id _dpos _pos ))

(defmethod openpilot_bridge::OrbKeyFrame
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:descriptors __descriptors) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:id __id) 0)
    ((:dpos __dpos) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ECEFPoint :init) r)) r))
    ((:pos __pos) (instance openpilot_bridge::ECEFPoint :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _descriptors __descriptors)
   (setq _id (round __id))
   (setq _dpos __dpos)
   (setq _pos __pos)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:descriptors
   (&optional __descriptors)
   (if __descriptors (setq _descriptors __descriptors)) _descriptors)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:dpos
   (&rest __dpos)
   (if (keywordp (car __dpos))
       (send* _dpos __dpos)
     (progn
       (if __dpos (setq _dpos (car __dpos)))
       _dpos)))
  (:pos
   (&rest __pos)
   (if (keywordp (car __pos))
       (send* _pos __pos)
     (progn
       (if __pos (setq _pos (car __pos)))
       _pos)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _descriptors
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _descriptors)) 4
    ;; int64 _id
    8
    ;; openpilot_bridge/ECEFPoint[] _dpos
    (apply #'+ (send-all _dpos :serialization-length)) 4
    ;; openpilot_bridge/ECEFPoint _pos
    (send _pos :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _descriptors
     (write-long (length _descriptors) s)
     (dolist (elem _descriptors)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id) (= (length (_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id . bv) 0) 0) s)
              (write-long (ash (elt (_id . bv) 1) -1) s))
             ((and (class _id) (= (length (_id . bv)) 1)) ;; big1
              (write-long (elt (_id . bv) 0) s)
              (write-long (if (>= _id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id s)(write-long (if (>= _id 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/ECEFPoint[] _dpos
     (write-long (length _dpos) s)
     (dolist (elem _dpos)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/ECEFPoint _pos
       (send _pos :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _descriptors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _descriptors (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _descriptors i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _id
#+(or :alpha :irix6 :x86_64)
      (setf _id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/ECEFPoint[] _dpos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dpos (let (r) (dotimes (i n) (push (instance openpilot_bridge::ECEFPoint :init) r)) r))
     (dolist (elem- _dpos)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/ECEFPoint _pos
     (send _pos :deserialize buf ptr-) (incf ptr- (send _pos :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::OrbKeyFrame :md5sum-) "d8cc48e698f9b09e2b374a7618b05a1e")
(setf (get openpilot_bridge::OrbKeyFrame :datatype-) "openpilot_bridge/OrbKeyFrame")
(setf (get openpilot_bridge::OrbKeyFrame :definition-)
      "Header header

string[] descriptors
int64 id
ECEFPoint[] dpos
ECEFPoint pos

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

================================================================================
MSG: openpilot_bridge/ECEFPoint
Header header

float32 y
float32 x
float32 z

")



(provide :openpilot_bridge/OrbKeyFrame "d8cc48e698f9b09e2b374a7618b05a1e")


