;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::GPSPlannerPoints)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'GPSPlannerPoints (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::GPSPLANNERPOINTS")
  (make-package "OPENPILOT_BRIDGE::GPSPLANNERPOINTS"))

(in-package "ROS")
;;//! \htmlinclude GPSPlannerPoints.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::GPSPlannerPoints
  :super ros::object
  :slots (_header _accelTarget _pointsDEPRECATED _trackName _curPos _valid _speedLimit _curPosDEPRECATED _points ))

(defmethod openpilot_bridge::GPSPlannerPoints
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:accelTarget __accelTarget) 0.0)
    ((:pointsDEPRECATED __pointsDEPRECATED) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ECEFPointDEPRECATED :init) r)) r))
    ((:trackName __trackName) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:curPos __curPos) (instance openpilot_bridge::ECEFPoint :init))
    ((:valid __valid) nil)
    ((:speedLimit __speedLimit) 0.0)
    ((:curPosDEPRECATED __curPosDEPRECATED) (instance openpilot_bridge::ECEFPointDEPRECATED :init))
    ((:points __points) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::ECEFPoint :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _accelTarget (float __accelTarget))
   (setq _pointsDEPRECATED __pointsDEPRECATED)
   (setq _trackName __trackName)
   (setq _curPos __curPos)
   (setq _valid __valid)
   (setq _speedLimit (float __speedLimit))
   (setq _curPosDEPRECATED __curPosDEPRECATED)
   (setq _points __points)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:accelTarget
   (&optional __accelTarget)
   (if __accelTarget (setq _accelTarget __accelTarget)) _accelTarget)
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
  (:curPos
   (&rest __curPos)
   (if (keywordp (car __curPos))
       (send* _curPos __curPos)
     (progn
       (if __curPos (setq _curPos (car __curPos)))
       _curPos)))
  (:valid
   (&optional __valid)
   (if __valid (setq _valid __valid)) _valid)
  (:speedLimit
   (&optional __speedLimit)
   (if __speedLimit (setq _speedLimit __speedLimit)) _speedLimit)
  (:curPosDEPRECATED
   (&rest __curPosDEPRECATED)
   (if (keywordp (car __curPosDEPRECATED))
       (send* _curPosDEPRECATED __curPosDEPRECATED)
     (progn
       (if __curPosDEPRECATED (setq _curPosDEPRECATED (car __curPosDEPRECATED)))
       _curPosDEPRECATED)))
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
    ;; float32 _accelTarget
    4
    ;; openpilot_bridge/ECEFPointDEPRECATED[] _pointsDEPRECATED
    (apply #'+ (send-all _pointsDEPRECATED :serialization-length)) 4
    ;; string[] _trackName
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _trackName)) 4
    ;; openpilot_bridge/ECEFPoint _curPos
    (send _curPos :serialization-length)
    ;; bool _valid
    1
    ;; float32 _speedLimit
    4
    ;; openpilot_bridge/ECEFPointDEPRECATED _curPosDEPRECATED
    (send _curPosDEPRECATED :serialization-length)
    ;; openpilot_bridge/ECEFPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _accelTarget
       (sys::poke _accelTarget (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
     ;; openpilot_bridge/ECEFPoint _curPos
       (send _curPos :serialize s)
     ;; bool _valid
       (if _valid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speedLimit
       (sys::poke _speedLimit (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/ECEFPointDEPRECATED _curPosDEPRECATED
       (send _curPosDEPRECATED :serialize s)
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
   ;; float32 _accelTarget
     (setq _accelTarget (sys::peek buf ptr- :float)) (incf ptr- 4)
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
   ;; openpilot_bridge/ECEFPoint _curPos
     (send _curPos :deserialize buf ptr-) (incf ptr- (send _curPos :serialization-length))
   ;; bool _valid
     (setq _valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speedLimit
     (setq _speedLimit (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/ECEFPointDEPRECATED _curPosDEPRECATED
     (send _curPosDEPRECATED :deserialize buf ptr-) (incf ptr- (send _curPosDEPRECATED :serialization-length))
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

(setf (get openpilot_bridge::GPSPlannerPoints :md5sum-) "2dad0805756f4e9be824594497faa155")
(setf (get openpilot_bridge::GPSPlannerPoints :datatype-) "openpilot_bridge/GPSPlannerPoints")
(setf (get openpilot_bridge::GPSPlannerPoints :definition-)
      "Header header

float32 accelTarget
ECEFPointDEPRECATED[] pointsDEPRECATED
string[] trackName
ECEFPoint curPos
bool valid
float32 speedLimit
ECEFPointDEPRECATED curPosDEPRECATED
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



(provide :openpilot_bridge/GPSPlannerPoints "2dad0805756f4e9be824594497faa155")


