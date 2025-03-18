;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbObservation)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbObservation (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBOBSERVATION")
  (make-package "OPENPILOT_BRIDGE::ORBOBSERVATION"))

(in-package "ROS")
;;//! \htmlinclude OrbObservation.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbObservation
  :super ros::object
  :slots (_header _matchDistance _locationECEF _normalizedCoordinates _observationMonoTime ))

(defmethod openpilot_bridge::OrbObservation
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:matchDistance __matchDistance) 0)
    ((:locationECEF __locationECEF) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:normalizedCoordinates __normalizedCoordinates) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:observationMonoTime __observationMonoTime) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _matchDistance (round __matchDistance))
   (setq _locationECEF __locationECEF)
   (setq _normalizedCoordinates __normalizedCoordinates)
   (setq _observationMonoTime (round __observationMonoTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:matchDistance
   (&optional __matchDistance)
   (if __matchDistance (setq _matchDistance __matchDistance)) _matchDistance)
  (:locationECEF
   (&optional __locationECEF)
   (if __locationECEF (setq _locationECEF __locationECEF)) _locationECEF)
  (:normalizedCoordinates
   (&optional __normalizedCoordinates)
   (if __normalizedCoordinates (setq _normalizedCoordinates __normalizedCoordinates)) _normalizedCoordinates)
  (:observationMonoTime
   (&optional __observationMonoTime)
   (if __observationMonoTime (setq _observationMonoTime __observationMonoTime)) _observationMonoTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _matchDistance
    8
    ;; float32[] _locationECEF
    (* 4    (length _locationECEF)) 4
    ;; float32[] _normalizedCoordinates
    (* 4    (length _normalizedCoordinates)) 4
    ;; int64 _observationMonoTime
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _matchDistance
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _matchDistance (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _matchDistance) (= (length (_matchDistance . bv)) 2)) ;; bignum
              (write-long (ash (elt (_matchDistance . bv) 0) 0) s)
              (write-long (ash (elt (_matchDistance . bv) 1) -1) s))
             ((and (class _matchDistance) (= (length (_matchDistance . bv)) 1)) ;; big1
              (write-long (elt (_matchDistance . bv) 0) s)
              (write-long (if (>= _matchDistance 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _matchDistance s)(write-long (if (>= _matchDistance 0) 0 #xffffffff) s)))
     ;; float32[] _locationECEF
     (write-long (length _locationECEF) s)
     (dotimes (i (length _locationECEF))
       (sys::poke (elt _locationECEF i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _normalizedCoordinates
     (write-long (length _normalizedCoordinates) s)
     (dotimes (i (length _normalizedCoordinates))
       (sys::poke (elt _normalizedCoordinates i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _observationMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _observationMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _observationMonoTime) (= (length (_observationMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_observationMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_observationMonoTime . bv) 1) -1) s))
             ((and (class _observationMonoTime) (= (length (_observationMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_observationMonoTime . bv) 0) s)
              (write-long (if (>= _observationMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _observationMonoTime s)(write-long (if (>= _observationMonoTime 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _matchDistance
#+(or :alpha :irix6 :x86_64)
      (setf _matchDistance (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _matchDistance (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _locationECEF
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _locationECEF (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _locationECEF i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _normalizedCoordinates
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _normalizedCoordinates (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _normalizedCoordinates i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _observationMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _observationMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _observationMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::OrbObservation :md5sum-) "6de73ce37ca42db3178ce06f49587a3a")
(setf (get openpilot_bridge::OrbObservation :datatype-) "openpilot_bridge/OrbObservation")
(setf (get openpilot_bridge::OrbObservation :definition-)
      "Header header

int64 matchDistance
float32[] locationECEF
float32[] normalizedCoordinates
int64 observationMonoTime

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



(provide :openpilot_bridge/OrbObservation "6de73ce37ca42db3178ce06f49587a3a")


