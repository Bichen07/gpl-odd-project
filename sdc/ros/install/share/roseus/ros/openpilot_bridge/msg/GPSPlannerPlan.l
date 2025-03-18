;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::GPSPlannerPlan)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'GPSPlannerPlan (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::GPSPLANNERPLAN")
  (make-package "OPENPILOT_BRIDGE::GPSPLANNERPLAN"))

(in-package "ROS")
;;//! \htmlinclude GPSPlannerPlan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::GPSPlannerPlan
  :super ros::object
  :slots (_header _acceleration _pointsDEPRECATED _trackName _poly _xLookahead _valid _speed _points ))

(defmethod openpilot_bridge::GPSPlannerPlan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:acceleration __acceleration) 0.0)
    ((:pointsDEPRECATED __pointsDEPRECATED) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ECEFPointDEPRECATED :init) r)) r))
    ((:trackName __trackName) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:poly __poly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:xLookahead __xLookahead) 0.0)
    ((:valid __valid) nil)
    ((:speed __speed) 0.0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ECEFPoint :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _acceleration (float __acceleration))
   (setq _pointsDEPRECATED __pointsDEPRECATED)
   (setq _trackName __trackName)
   (setq _poly __poly)
   (setq _xLookahead (float __xLookahead))
   (setq _valid __valid)
   (setq _speed (float __speed))
   (setq _points __points)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:pointsDEPRECATED
   (&rest __pointsDEPRECATED)
   (if (keywordp (car __pointsDEPRECATED))
       (send* _pointsDEPRECATED __pointsDEPRECATED)
     (progn
       (if __pointsDEPRECATED (setq _pointsDEPRECATED (car __pointsDEPRECATED)))
       _pointsDEPRECATED)))
  (:trackName
   (&optional __trackName)
   (if __trackName (setq _trackName __trackName)) _trackName)
  (:poly
   (&optional __poly)
   (if __poly (setq _poly __poly)) _poly)
  (:xLookahead
   (&optional __xLookahead)
   (if __xLookahead (setq _xLookahead __xLookahead)) _xLookahead)
  (:valid
   (&optional __valid)
   (if __valid (setq _valid __valid)) _valid)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
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
    ;; float32 _acceleration
    4
    ;; openpilot_bridge/ECEFPointDEPRECATED[] _pointsDEPRECATED
    (apply #'+ (send-all _pointsDEPRECATED :serialization-length)) 4
    ;; string[] _trackName
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _trackName)) 4
    ;; float32[] _poly
    (* 4    (length _poly)) 4
    ;; float32 _xLookahead
    4
    ;; bool _valid
    1
    ;; float32 _speed
    4
    ;; openpilot_bridge/ECEFPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/ECEFPointDEPRECATED[] _pointsDEPRECATED
     (write-long (length _pointsDEPRECATED) s)
     (dolist (elem _pointsDEPRECATED)
       (send elem :serialize s)
       )
     ;; string[] _trackName
     (write-long (length _trackName) s)
     (dolist (elem _trackName)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32[] _poly
     (write-long (length _poly) s)
     (dotimes (i (length _poly))
       (sys::poke (elt _poly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _xLookahead
       (sys::poke _xLookahead (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _valid
       (if _valid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/ECEFPoint[] _points
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
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/ECEFPointDEPRECATED[] _pointsDEPRECATED
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pointsDEPRECATED (let (r) (dotimes (i n) (push (instance openpilot_bridge::ECEFPointDEPRECATED :init) r)) r))
     (dolist (elem- _pointsDEPRECATED)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _trackName
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _trackName (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _trackName i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32[] _poly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _xLookahead
     (setq _xLookahead (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _valid
     (setq _valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/ECEFPoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance openpilot_bridge::ECEFPoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::GPSPlannerPlan :md5sum-) "998c57b3107ccfd3fc1d648cdbc3c857")
(setf (get openpilot_bridge::GPSPlannerPlan :datatype-) "openpilot_bridge/GPSPlannerPlan")
(setf (get openpilot_bridge::GPSPlannerPlan :definition-)
      "Header header

float32 acceleration
ECEFPointDEPRECATED[] pointsDEPRECATED
string[] trackName
float32[] poly
float32 xLookahead
bool valid
float32 speed
ECEFPoint[] points

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
MSG: openpilot_bridge/ECEFPointDEPRECATED
Header header

float32 y
float32 x
float32 z

================================================================================
MSG: openpilot_bridge/ECEFPoint
Header header

float32 y
float32 x
float32 z

")



(provide :openpilot_bridge/GPSPlannerPlan "998c57b3107ccfd3fc1d648cdbc3c857")


