;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LeadData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LeadData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LEADDATA")
  (make-package "OPENPILOT_BRIDGE::LEADDATA"))

(in-package "ROS")
;;//! \htmlinclude LeadData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LeadData
  :super ros::object
  :slots (_header _dRel _yRel _vRel _aRel _vLead _aLeadDEPRECATED _dPath _vLat _vLeadK _aLeadK _fcw _status _aLeadTau _modelProb _radar ))

(defmethod openpilot_bridge::LeadData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:dRel __dRel) 0.0)
    ((:yRel __yRel) 0.0)
    ((:vRel __vRel) 0.0)
    ((:aRel __aRel) 0.0)
    ((:vLead __vLead) 0.0)
    ((:aLeadDEPRECATED __aLeadDEPRECATED) 0.0)
    ((:dPath __dPath) 0.0)
    ((:vLat __vLat) 0.0)
    ((:vLeadK __vLeadK) 0.0)
    ((:aLeadK __aLeadK) 0.0)
    ((:fcw __fcw) nil)
    ((:status __status) nil)
    ((:aLeadTau __aLeadTau) 0.0)
    ((:modelProb __modelProb) 0.0)
    ((:radar __radar) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _dRel (float __dRel))
   (setq _yRel (float __yRel))
   (setq _vRel (float __vRel))
   (setq _aRel (float __aRel))
   (setq _vLead (float __vLead))
   (setq _aLeadDEPRECATED (float __aLeadDEPRECATED))
   (setq _dPath (float __dPath))
   (setq _vLat (float __vLat))
   (setq _vLeadK (float __vLeadK))
   (setq _aLeadK (float __aLeadK))
   (setq _fcw __fcw)
   (setq _status __status)
   (setq _aLeadTau (float __aLeadTau))
   (setq _modelProb (float __modelProb))
   (setq _radar __radar)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:dRel
   (&optional __dRel)
   (if __dRel (setq _dRel __dRel)) _dRel)
  (:yRel
   (&optional __yRel)
   (if __yRel (setq _yRel __yRel)) _yRel)
  (:vRel
   (&optional __vRel)
   (if __vRel (setq _vRel __vRel)) _vRel)
  (:aRel
   (&optional __aRel)
   (if __aRel (setq _aRel __aRel)) _aRel)
  (:vLead
   (&optional __vLead)
   (if __vLead (setq _vLead __vLead)) _vLead)
  (:aLeadDEPRECATED
   (&optional __aLeadDEPRECATED)
   (if __aLeadDEPRECATED (setq _aLeadDEPRECATED __aLeadDEPRECATED)) _aLeadDEPRECATED)
  (:dPath
   (&optional __dPath)
   (if __dPath (setq _dPath __dPath)) _dPath)
  (:vLat
   (&optional __vLat)
   (if __vLat (setq _vLat __vLat)) _vLat)
  (:vLeadK
   (&optional __vLeadK)
   (if __vLeadK (setq _vLeadK __vLeadK)) _vLeadK)
  (:aLeadK
   (&optional __aLeadK)
   (if __aLeadK (setq _aLeadK __aLeadK)) _aLeadK)
  (:fcw
   (&optional __fcw)
   (if __fcw (setq _fcw __fcw)) _fcw)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:aLeadTau
   (&optional __aLeadTau)
   (if __aLeadTau (setq _aLeadTau __aLeadTau)) _aLeadTau)
  (:modelProb
   (&optional __modelProb)
   (if __modelProb (setq _modelProb __modelProb)) _modelProb)
  (:radar
   (&optional __radar)
   (if __radar (setq _radar __radar)) _radar)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _dRel
    4
    ;; float32 _yRel
    4
    ;; float32 _vRel
    4
    ;; float32 _aRel
    4
    ;; float32 _vLead
    4
    ;; float32 _aLeadDEPRECATED
    4
    ;; float32 _dPath
    4
    ;; float32 _vLat
    4
    ;; float32 _vLeadK
    4
    ;; float32 _aLeadK
    4
    ;; bool _fcw
    1
    ;; bool _status
    1
    ;; float32 _aLeadTau
    4
    ;; float32 _modelProb
    4
    ;; bool _radar
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _dRel
       (sys::poke _dRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yRel
       (sys::poke _yRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vRel
       (sys::poke _vRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aRel
       (sys::poke _aRel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vLead
       (sys::poke _vLead (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aLeadDEPRECATED
       (sys::poke _aLeadDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dPath
       (sys::poke _dPath (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vLat
       (sys::poke _vLat (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vLeadK
       (sys::poke _vLeadK (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aLeadK
       (sys::poke _aLeadK (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _fcw
       (if _fcw (write-byte -1 s) (write-byte 0 s))
     ;; bool _status
       (if _status (write-byte -1 s) (write-byte 0 s))
     ;; float32 _aLeadTau
       (sys::poke _aLeadTau (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _modelProb
       (sys::poke _modelProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _radar
       (if _radar (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _dRel
     (setq _dRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yRel
     (setq _yRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vRel
     (setq _vRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aRel
     (setq _aRel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vLead
     (setq _vLead (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aLeadDEPRECATED
     (setq _aLeadDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dPath
     (setq _dPath (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vLat
     (setq _vLat (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vLeadK
     (setq _vLeadK (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aLeadK
     (setq _aLeadK (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _fcw
     (setq _fcw (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _status
     (setq _status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _aLeadTau
     (setq _aLeadTau (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _modelProb
     (setq _modelProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _radar
     (setq _radar (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::LeadData :md5sum-) "2267c1a294f8eb3e2cb2f5c2e4aba833")
(setf (get openpilot_bridge::LeadData :datatype-) "openpilot_bridge/LeadData")
(setf (get openpilot_bridge::LeadData :definition-)
      "Header header

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



(provide :openpilot_bridge/LeadData "2267c1a294f8eb3e2cb2f5c2e4aba833")


