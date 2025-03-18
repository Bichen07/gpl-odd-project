;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::RadarData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'RadarData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::RADARDATA")
  (make-package "OPENPILOT_BRIDGE::RADARDATA"))

(in-package "ROS")
;;//! \htmlinclude RadarData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::RadarData
  :super ros::object
  :slots (_header _canMonoTimes _errors _points ))

(defmethod openpilot_bridge::RadarData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:canMonoTimes __canMonoTimes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:errors __errors) (make-array 0 :initial-element 0 :element-type :integer))
    ((:points __points) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::RadarPoint :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _canMonoTimes __canMonoTimes)
   (setq _errors __errors)
   (setq _points __points)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:canMonoTimes
   (&optional __canMonoTimes)
   (if __canMonoTimes (setq _canMonoTimes __canMonoTimes)) _canMonoTimes)
  (:errors
   (&optional __errors)
   (if __errors (setq _errors __errors)) _errors)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64[] _canMonoTimes
    (* 8    (length _canMonoTimes)) 4
    ;; uint32[] _errors
    (* 4    (length _errors)) 4
    ;; openpilot_bridge/RadarPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64[] _canMonoTimes
     (write-long (length _canMonoTimes) s)
     (dotimes (i (length _canMonoTimes))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _canMonoTimes i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _canMonoTimes i)) (= (length ((elt _canMonoTimes i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _canMonoTimes i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _canMonoTimes i) . bv) 1) -1) s))
             ((and (class (elt _canMonoTimes i)) (= (length ((elt _canMonoTimes i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _canMonoTimes i) . bv) 0) s)
              (write-long (if (>= (elt _canMonoTimes i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _canMonoTimes i) s)(write-long (if (>= (elt _canMonoTimes i) 0) 0 #xffffffff) s)))
       )
     ;; uint32[] _errors
     (write-long (length _errors) s)
     (dotimes (i (length _errors))
       (write-long (elt _errors i) s)
       )
     ;; openpilot_bridge/RadarPoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64[] _canMonoTimes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _canMonoTimes (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _canMonoTimes i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _canMonoTimes i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; uint32[] _errors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _errors (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _errors i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; openpilot_bridge/RadarPoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance openpilot_bridge::RadarPoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::RadarData :md5sum-) "76b62543761f0d42ee75ec49ef018fe1")
(setf (get openpilot_bridge::RadarData :datatype-) "openpilot_bridge/RadarData")
(setf (get openpilot_bridge::RadarData :definition-)
      "Header header

int64[] canMonoTimes
uint32[] errors # enum const: Error
RadarPoint[] points

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
MSG: openpilot_bridge/RadarPoint
Header header

float32 yRel
int64 trackId
float32 aRel
float32 vRel
float32 dRel
float32 yvRel
bool measured

")



(provide :openpilot_bridge/RadarData "76b62543761f0d42ee75ec49ef018fe1")


