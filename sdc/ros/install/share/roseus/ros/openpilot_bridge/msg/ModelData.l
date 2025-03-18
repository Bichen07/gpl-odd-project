;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ModelData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ModelData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MODELDATA")
  (make-package "OPENPILOT_BRIDGE::MODELDATA"))

(in-package "ROS")
;;//! \htmlinclude ModelData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ModelData
  :super ros::object
  :slots (_header _longitudinal _leadFuture _lead _settings _leftLane _timestampEof _frameId _rightLane _meta _path _speed _freePath ))

(defmethod openpilot_bridge::ModelData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:longitudinal __longitudinal) (instance openpilot_bridge::LongitudinalData :init))
    ((:leadFuture __leadFuture) (instance openpilot_bridge::LeadData :init))
    ((:lead __lead) (instance openpilot_bridge::LeadData :init))
    ((:settings __settings) (instance openpilot_bridge::ModelSettings :init))
    ((:leftLane __leftLane) (instance openpilot_bridge::PathData :init))
    ((:timestampEof __timestampEof) 0)
    ((:frameId __frameId) 0)
    ((:rightLane __rightLane) (instance openpilot_bridge::PathData :init))
    ((:meta __meta) (instance openpilot_bridge::MetaData :init))
    ((:path __path) (instance openpilot_bridge::PathData :init))
    ((:speed __speed) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:freePath __freePath) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _longitudinal __longitudinal)
   (setq _leadFuture __leadFuture)
   (setq _lead __lead)
   (setq _settings __settings)
   (setq _leftLane __leftLane)
   (setq _timestampEof (round __timestampEof))
   (setq _frameId (round __frameId))
   (setq _rightLane __rightLane)
   (setq _meta __meta)
   (setq _path __path)
   (setq _speed __speed)
   (setq _freePath __freePath)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:longitudinal
   (&rest __longitudinal)
   (if (keywordp (car __longitudinal))
       (send* _longitudinal __longitudinal)
     (progn
       (if __longitudinal (setq _longitudinal (car __longitudinal)))
       _longitudinal)))
  (:leadFuture
   (&rest __leadFuture)
   (if (keywordp (car __leadFuture))
       (send* _leadFuture __leadFuture)
     (progn
       (if __leadFuture (setq _leadFuture (car __leadFuture)))
       _leadFuture)))
  (:lead
   (&rest __lead)
   (if (keywordp (car __lead))
       (send* _lead __lead)
     (progn
       (if __lead (setq _lead (car __lead)))
       _lead)))
  (:settings
   (&rest __settings)
   (if (keywordp (car __settings))
       (send* _settings __settings)
     (progn
       (if __settings (setq _settings (car __settings)))
       _settings)))
  (:leftLane
   (&rest __leftLane)
   (if (keywordp (car __leftLane))
       (send* _leftLane __leftLane)
     (progn
       (if __leftLane (setq _leftLane (car __leftLane)))
       _leftLane)))
  (:timestampEof
   (&optional __timestampEof)
   (if __timestampEof (setq _timestampEof __timestampEof)) _timestampEof)
  (:frameId
   (&optional __frameId)
   (if __frameId (setq _frameId __frameId)) _frameId)
  (:rightLane
   (&rest __rightLane)
   (if (keywordp (car __rightLane))
       (send* _rightLane __rightLane)
     (progn
       (if __rightLane (setq _rightLane (car __rightLane)))
       _rightLane)))
  (:meta
   (&rest __meta)
   (if (keywordp (car __meta))
       (send* _meta __meta)
     (progn
       (if __meta (setq _meta (car __meta)))
       _meta)))
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:freePath
   (&optional __freePath)
   (if __freePath (setq _freePath __freePath)) _freePath)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/LongitudinalData _longitudinal
    (send _longitudinal :serialization-length)
    ;; openpilot_bridge/LeadData _leadFuture
    (send _leadFuture :serialization-length)
    ;; openpilot_bridge/LeadData _lead
    (send _lead :serialization-length)
    ;; openpilot_bridge/ModelSettings _settings
    (send _settings :serialization-length)
    ;; openpilot_bridge/PathData _leftLane
    (send _leftLane :serialization-length)
    ;; int64 _timestampEof
    8
    ;; int64 _frameId
    8
    ;; openpilot_bridge/PathData _rightLane
    (send _rightLane :serialization-length)
    ;; openpilot_bridge/MetaData _meta
    (send _meta :serialization-length)
    ;; openpilot_bridge/PathData _path
    (send _path :serialization-length)
    ;; float32[] _speed
    (* 4    (length _speed)) 4
    ;; float32[] _freePath
    (* 4    (length _freePath)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/LongitudinalData _longitudinal
       (send _longitudinal :serialize s)
     ;; openpilot_bridge/LeadData _leadFuture
       (send _leadFuture :serialize s)
     ;; openpilot_bridge/LeadData _lead
       (send _lead :serialize s)
     ;; openpilot_bridge/ModelSettings _settings
       (send _settings :serialize s)
     ;; openpilot_bridge/PathData _leftLane
       (send _leftLane :serialize s)
     ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestampEof (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestampEof) (= (length (_timestampEof . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestampEof . bv) 0) 0) s)
              (write-long (ash (elt (_timestampEof . bv) 1) -1) s))
             ((and (class _timestampEof) (= (length (_timestampEof . bv)) 1)) ;; big1
              (write-long (elt (_timestampEof . bv) 0) s)
              (write-long (if (>= _timestampEof 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestampEof s)(write-long (if (>= _timestampEof 0) 0 #xffffffff) s)))
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
     ;; openpilot_bridge/PathData _rightLane
       (send _rightLane :serialize s)
     ;; openpilot_bridge/MetaData _meta
       (send _meta :serialize s)
     ;; openpilot_bridge/PathData _path
       (send _path :serialize s)
     ;; float32[] _speed
     (write-long (length _speed) s)
     (dotimes (i (length _speed))
       (sys::poke (elt _speed i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _freePath
     (write-long (length _freePath) s)
     (dotimes (i (length _freePath))
       (sys::poke (elt _freePath i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/LongitudinalData _longitudinal
     (send _longitudinal :deserialize buf ptr-) (incf ptr- (send _longitudinal :serialization-length))
   ;; openpilot_bridge/LeadData _leadFuture
     (send _leadFuture :deserialize buf ptr-) (incf ptr- (send _leadFuture :serialization-length))
   ;; openpilot_bridge/LeadData _lead
     (send _lead :deserialize buf ptr-) (incf ptr- (send _lead :serialization-length))
   ;; openpilot_bridge/ModelSettings _settings
     (send _settings :deserialize buf ptr-) (incf ptr- (send _settings :serialization-length))
   ;; openpilot_bridge/PathData _leftLane
     (send _leftLane :deserialize buf ptr-) (incf ptr- (send _leftLane :serialization-length))
   ;; int64 _timestampEof
#+(or :alpha :irix6 :x86_64)
      (setf _timestampEof (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestampEof (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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
   ;; openpilot_bridge/PathData _rightLane
     (send _rightLane :deserialize buf ptr-) (incf ptr- (send _rightLane :serialization-length))
   ;; openpilot_bridge/MetaData _meta
     (send _meta :deserialize buf ptr-) (incf ptr- (send _meta :serialization-length))
   ;; openpilot_bridge/PathData _path
     (send _path :deserialize buf ptr-) (incf ptr- (send _path :serialization-length))
   ;; float32[] _speed
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _speed (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _speed i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _freePath
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _freePath (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _freePath i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::ModelData :md5sum-) "9f8b0d877672d1e2fbed816c428d4d5c")
(setf (get openpilot_bridge::ModelData :datatype-) "openpilot_bridge/ModelData")
(setf (get openpilot_bridge::ModelData :definition-)
      "Header header

LongitudinalData longitudinal
LeadData leadFuture
LeadData lead
ModelSettings settings
PathData leftLane
int64 timestampEof
int64 frameId
PathData rightLane
MetaData meta
PathData path
float32[] speed
float32[] freePath

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
MSG: openpilot_bridge/LongitudinalData
Header header

float32[] accelerations
float32[] speeds

================================================================================
MSG: openpilot_bridge/LeadData
Header header

float32 dRel
float32 yRel
float32 vRel
float32 aRel
float32 vLead
float32 aLeadDEPRECATED
float32 dPath
float32 vLat
float32 vLeadK
float32 aLeadK
bool fcw
bool status
float32 aLeadTau
float32 modelProb
bool radar

================================================================================
MSG: openpilot_bridge/ModelSettings
Header header

int64 bigBoxX
int64 bigBoxY
float32[] inputTransform
int64 bigBoxHeight
int64 bigBoxWidth
float32[] boxProjection
float32[] yuvCorrection

================================================================================
MSG: openpilot_bridge/PathData
Header header

float32 std
float32[] poly
float32[] points
float32 prob
float32[] stds

================================================================================
MSG: openpilot_bridge/MetaData
Header header

float32 gasDisengageProb
float32 brakeDisengageProb
float32 steerOverrideProb
float32 engagedProb
float32[] desirePrediction

")



(provide :openpilot_bridge/ModelData "9f8b0d877672d1e2fbed816c428d4d5c")


