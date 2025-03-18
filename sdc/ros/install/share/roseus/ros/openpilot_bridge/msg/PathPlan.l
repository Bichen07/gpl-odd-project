;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::PathPlan)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'PathPlan (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PATHPLAN")
  (make-package "OPENPILOT_BRIDGE::PATHPLAN"))

(in-package "ROS")
;;//! \htmlinclude PathPlan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::PathPlan
  :super ros::object
  :slots (_header _angleSteers _commIssue _lPoly _laneChangeState _sensorValid _mpcSolutionValid _lProb _modelValidDEPRECATED _rProb _cProb _rPoly _laneWidth _angleOffset _rateSteers _laneChangeDirection _paramsValid _cPoly _posenetValid _dPoly _desire ))

(defmethod openpilot_bridge::PathPlan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:angleSteers __angleSteers) 0.0)
    ((:commIssue __commIssue) nil)
    ((:lPoly __lPoly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:laneChangeState __laneChangeState) 0)
    ((:sensorValid __sensorValid) nil)
    ((:mpcSolutionValid __mpcSolutionValid) nil)
    ((:lProb __lProb) 0.0)
    ((:modelValidDEPRECATED __modelValidDEPRECATED) nil)
    ((:rProb __rProb) 0.0)
    ((:cProb __cProb) 0.0)
    ((:rPoly __rPoly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:laneWidth __laneWidth) 0.0)
    ((:angleOffset __angleOffset) 0.0)
    ((:rateSteers __rateSteers) 0.0)
    ((:laneChangeDirection __laneChangeDirection) 0)
    ((:paramsValid __paramsValid) nil)
    ((:cPoly __cPoly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:posenetValid __posenetValid) nil)
    ((:dPoly __dPoly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:desire __desire) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _angleSteers (float __angleSteers))
   (setq _commIssue __commIssue)
   (setq _lPoly __lPoly)
   (setq _laneChangeState (round __laneChangeState))
   (setq _sensorValid __sensorValid)
   (setq _mpcSolutionValid __mpcSolutionValid)
   (setq _lProb (float __lProb))
   (setq _modelValidDEPRECATED __modelValidDEPRECATED)
   (setq _rProb (float __rProb))
   (setq _cProb (float __cProb))
   (setq _rPoly __rPoly)
   (setq _laneWidth (float __laneWidth))
   (setq _angleOffset (float __angleOffset))
   (setq _rateSteers (float __rateSteers))
   (setq _laneChangeDirection (round __laneChangeDirection))
   (setq _paramsValid __paramsValid)
   (setq _cPoly __cPoly)
   (setq _posenetValid __posenetValid)
   (setq _dPoly __dPoly)
   (setq _desire (round __desire))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:angleSteers
   (&optional __angleSteers)
   (if __angleSteers (setq _angleSteers __angleSteers)) _angleSteers)
  (:commIssue
   (&optional __commIssue)
   (if __commIssue (setq _commIssue __commIssue)) _commIssue)
  (:lPoly
   (&optional __lPoly)
   (if __lPoly (setq _lPoly __lPoly)) _lPoly)
  (:laneChangeState
   (&optional __laneChangeState)
   (if __laneChangeState (setq _laneChangeState __laneChangeState)) _laneChangeState)
  (:sensorValid
   (&optional __sensorValid)
   (if __sensorValid (setq _sensorValid __sensorValid)) _sensorValid)
  (:mpcSolutionValid
   (&optional __mpcSolutionValid)
   (if __mpcSolutionValid (setq _mpcSolutionValid __mpcSolutionValid)) _mpcSolutionValid)
  (:lProb
   (&optional __lProb)
   (if __lProb (setq _lProb __lProb)) _lProb)
  (:modelValidDEPRECATED
   (&optional __modelValidDEPRECATED)
   (if __modelValidDEPRECATED (setq _modelValidDEPRECATED __modelValidDEPRECATED)) _modelValidDEPRECATED)
  (:rProb
   (&optional __rProb)
   (if __rProb (setq _rProb __rProb)) _rProb)
  (:cProb
   (&optional __cProb)
   (if __cProb (setq _cProb __cProb)) _cProb)
  (:rPoly
   (&optional __rPoly)
   (if __rPoly (setq _rPoly __rPoly)) _rPoly)
  (:laneWidth
   (&optional __laneWidth)
   (if __laneWidth (setq _laneWidth __laneWidth)) _laneWidth)
  (:angleOffset
   (&optional __angleOffset)
   (if __angleOffset (setq _angleOffset __angleOffset)) _angleOffset)
  (:rateSteers
   (&optional __rateSteers)
   (if __rateSteers (setq _rateSteers __rateSteers)) _rateSteers)
  (:laneChangeDirection
   (&optional __laneChangeDirection)
   (if __laneChangeDirection (setq _laneChangeDirection __laneChangeDirection)) _laneChangeDirection)
  (:paramsValid
   (&optional __paramsValid)
   (if __paramsValid (setq _paramsValid __paramsValid)) _paramsValid)
  (:cPoly
   (&optional __cPoly)
   (if __cPoly (setq _cPoly __cPoly)) _cPoly)
  (:posenetValid
   (&optional __posenetValid)
   (if __posenetValid (setq _posenetValid __posenetValid)) _posenetValid)
  (:dPoly
   (&optional __dPoly)
   (if __dPoly (setq _dPoly __dPoly)) _dPoly)
  (:desire
   (&optional __desire)
   (if __desire (setq _desire __desire)) _desire)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _angleSteers
    4
    ;; bool _commIssue
    1
    ;; float32[] _lPoly
    (* 4    (length _lPoly)) 4
    ;; uint32 _laneChangeState
    4
    ;; bool _sensorValid
    1
    ;; bool _mpcSolutionValid
    1
    ;; float32 _lProb
    4
    ;; bool _modelValidDEPRECATED
    1
    ;; float32 _rProb
    4
    ;; float32 _cProb
    4
    ;; float32[] _rPoly
    (* 4    (length _rPoly)) 4
    ;; float32 _laneWidth
    4
    ;; float32 _angleOffset
    4
    ;; float32 _rateSteers
    4
    ;; uint32 _laneChangeDirection
    4
    ;; bool _paramsValid
    1
    ;; float32[] _cPoly
    (* 4    (length _cPoly)) 4
    ;; bool _posenetValid
    1
    ;; float32[] _dPoly
    (* 4    (length _dPoly)) 4
    ;; uint32 _desire
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _angleSteers
       (sys::poke _angleSteers (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _commIssue
       (if _commIssue (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _lPoly
     (write-long (length _lPoly) s)
     (dotimes (i (length _lPoly))
       (sys::poke (elt _lPoly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; uint32 _laneChangeState
       (write-long _laneChangeState s)
     ;; bool _sensorValid
       (if _sensorValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _mpcSolutionValid
       (if _mpcSolutionValid (write-byte -1 s) (write-byte 0 s))
     ;; float32 _lProb
       (sys::poke _lProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _modelValidDEPRECATED
       (if _modelValidDEPRECATED (write-byte -1 s) (write-byte 0 s))
     ;; float32 _rProb
       (sys::poke _rProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cProb
       (sys::poke _cProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _rPoly
     (write-long (length _rPoly) s)
     (dotimes (i (length _rPoly))
       (sys::poke (elt _rPoly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _laneWidth
       (sys::poke _laneWidth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angleOffset
       (sys::poke _angleOffset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rateSteers
       (sys::poke _rateSteers (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint32 _laneChangeDirection
       (write-long _laneChangeDirection s)
     ;; bool _paramsValid
       (if _paramsValid (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _cPoly
     (write-long (length _cPoly) s)
     (dotimes (i (length _cPoly))
       (sys::poke (elt _cPoly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _posenetValid
       (if _posenetValid (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _dPoly
     (write-long (length _dPoly) s)
     (dotimes (i (length _dPoly))
       (sys::poke (elt _dPoly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; uint32 _desire
       (write-long _desire s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _angleSteers
     (setq _angleSteers (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _commIssue
     (setq _commIssue (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _lPoly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lPoly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _lPoly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; uint32 _laneChangeState
     (setq _laneChangeState (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _sensorValid
     (setq _sensorValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _mpcSolutionValid
     (setq _mpcSolutionValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _lProb
     (setq _lProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _modelValidDEPRECATED
     (setq _modelValidDEPRECATED (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _rProb
     (setq _rProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cProb
     (setq _cProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _rPoly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rPoly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rPoly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _laneWidth
     (setq _laneWidth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angleOffset
     (setq _angleOffset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rateSteers
     (setq _rateSteers (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint32 _laneChangeDirection
     (setq _laneChangeDirection (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _paramsValid
     (setq _paramsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _cPoly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cPoly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _cPoly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _posenetValid
     (setq _posenetValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _dPoly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dPoly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _dPoly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; uint32 _desire
     (setq _desire (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::PathPlan :md5sum-) "39d44bb8d0ae27698feefef0dbe76a71")
(setf (get openpilot_bridge::PathPlan :datatype-) "openpilot_bridge/PathPlan")
(setf (get openpilot_bridge::PathPlan :definition-)
      "Header header

float32 angleSteers
bool commIssue
float32[] lPoly
uint32 laneChangeState # enum const: LaneChangeState
bool sensorValid
bool mpcSolutionValid
float32 lProb
bool modelValidDEPRECATED
float32 rProb
float32 cProb
float32[] rPoly
float32 laneWidth
float32 angleOffset
float32 rateSteers
uint32 laneChangeDirection # enum const: LaneChangeDirection
bool paramsValid
float32[] cPoly
bool posenetValid
float32[] dPoly
uint32 desire # enum const: Desire

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



(provide :openpilot_bridge/PathPlan "39d44bb8d0ae27698feefef0dbe76a71")


