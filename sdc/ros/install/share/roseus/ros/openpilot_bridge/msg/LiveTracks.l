;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveTracks)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveTracks (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVETRACKS")
  (make-package "OPENPILOT_BRIDGE::LIVETRACKS"))

(in-package "ROS")
;;//! \htmlinclude LiveTracks.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveTracks
  :super ros::object
  :slots (_header _status _yRel _currentTime _trackId _aRel _vRel _dRel _timeStamp _stationary _oncoming ))

(defmethod openpilot_bridge::LiveTracks
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:status __status) 0.0)
    ((:yRel __yRel) 0.0)
    ((:currentTime __currentTime) 0.0)
    ((:trackId __trackId) 0)
    ((:aRel __aRel) 0.0)
    ((:vRel __vRel) 0.0)
    ((:dRel __dRel) 0.0)
    ((:timeStamp __timeStamp) 0.0)
    ((:stationary __stationary) nil)
    ((:oncoming __oncoming) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _status (float __status))
   (setq _yRel (float __yRel))
   (setq _currentTime (float __currentTime))
   (setq _trackId (round __trackId))
   (setq _aRel (float __aRel))
   (setq _vRel (float __vRel))
   (setq _dRel (float __dRel))
   (setq _timeStamp (float __timeStamp))
   (setq _stationary __stationary)
   (setq _oncoming __oncoming)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:yRel
   (&optional __yRel)
   (if __yRel (setq _yRel __yRel)) _yRel)
  (:currentTime
   (&optional __currentTime)
   (if __currentTime (setq _currentTime __currentTime)) _currentTime)
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
  (:timeStamp
   (&optional __timeStamp)
   (if __timeStamp (setq _timeStamp __timeStamp)) _timeStamp)
  (:stationary
   (&optional __stationary)
   (if __stationary (setq _stationary __stationary)) _stationary)
  (:oncoming
   (&optional __oncoming)
   (if __oncoming (setq _oncoming __oncoming)) _oncoming)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _status
    4
    ;; float32 _yRel
    4
    ;; float32 _currentTime
    4
    ;; int32 _trackId
    4
    ;; float32 _aRel
    4
    ;; float32 _vRel
    4
    ;; float32 _dRel
    4
    ;; float32 _timeStamp
    4
    ;; bool _stationary
    1
    ;; bool _oncoming
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _status
       (sys::poke _status (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yRel
       (sys::poke _yRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _currentTime
       (sys::poke _currentTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _trackId
       (write-long _trackId s)
     ;; float32 _aRel
       (sys::poke _aRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vRel
       (sys::poke _vRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dRel
       (sys::poke _dRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _timeStamp
       (sys::poke _timeStamp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _stationary
       (if _stationary (write-byte -1 s) (write-byte 0 s))
     ;; bool _oncoming
       (if _oncoming (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _status
     (setq _status (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yRel
     (setq _yRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _currentTime
     (setq _currentTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _trackId
     (setq _trackId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _aRel
     (setq _aRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vRel
     (setq _vRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dRel
     (setq _dRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _timeStamp
     (setq _timeStamp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _stationary
     (setq _stationary (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _oncoming
     (setq _oncoming (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveTracks :md5sum-) "bc07fabc68ac3d8a8dc415053006b7ba")
(setf (get openpilot_bridge::LiveTracks :datatype-) "openpilot_bridge/LiveTracks")
(setf (get openpilot_bridge::LiveTracks :definition-)
      "Header header

float32 status
float32 yRel
float32 currentTime
int32 trackId
float32 aRel
float32 vRel
float32 dRel
float32 timeStamp
bool stationary
bool oncoming

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



(provide :openpilot_bridge/LiveTracks "bc07fabc68ac3d8a8dc415053006b7ba")


