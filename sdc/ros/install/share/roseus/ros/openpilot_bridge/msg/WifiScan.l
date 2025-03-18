;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::WifiScan)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'WifiScan (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::WIFISCAN")
  (make-package "OPENPILOT_BRIDGE::WIFISCAN"))

(in-package "ROS")
;;//! \htmlinclude WifiScan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::WifiScan
  :super ros::object
  :slots (_header _is80211mcResponder _operatorFriendlyName _channelWidth _distanceSdCm _ssid _bssid _level _timestamp _capabilities _distanceCm _centerFreq0 _centerFreq1 _frequency _passpoint _venueName ))

(defmethod openpilot_bridge::WifiScan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:is80211mcResponder __is80211mcResponder) nil)
    ((:operatorFriendlyName __operatorFriendlyName) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:channelWidth __channelWidth) 0)
    ((:distanceSdCm __distanceSdCm) 0)
    ((:ssid __ssid) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:bssid __bssid) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:level __level) 0)
    ((:timestamp __timestamp) 0)
    ((:capabilities __capabilities) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:distanceCm __distanceCm) 0)
    ((:centerFreq0 __centerFreq0) 0)
    ((:centerFreq1 __centerFreq1) 0)
    ((:frequency __frequency) 0)
    ((:passpoint __passpoint) nil)
    ((:venueName __venueName) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _is80211mcResponder __is80211mcResponder)
   (setq _operatorFriendlyName __operatorFriendlyName)
   (setq _channelWidth (round __channelWidth))
   (setq _distanceSdCm (round __distanceSdCm))
   (setq _ssid __ssid)
   (setq _bssid __bssid)
   (setq _level (round __level))
   (setq _timestamp (round __timestamp))
   (setq _capabilities __capabilities)
   (setq _distanceCm (round __distanceCm))
   (setq _centerFreq0 (round __centerFreq0))
   (setq _centerFreq1 (round __centerFreq1))
   (setq _frequency (round __frequency))
   (setq _passpoint __passpoint)
   (setq _venueName __venueName)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:is80211mcResponder
   (&optional __is80211mcResponder)
   (if __is80211mcResponder (setq _is80211mcResponder __is80211mcResponder)) _is80211mcResponder)
  (:operatorFriendlyName
   (&optional __operatorFriendlyName)
   (if __operatorFriendlyName (setq _operatorFriendlyName __operatorFriendlyName)) _operatorFriendlyName)
  (:channelWidth
   (&optional __channelWidth)
   (if __channelWidth (setq _channelWidth __channelWidth)) _channelWidth)
  (:distanceSdCm
   (&optional __distanceSdCm)
   (if __distanceSdCm (setq _distanceSdCm __distanceSdCm)) _distanceSdCm)
  (:ssid
   (&optional __ssid)
   (if __ssid (setq _ssid __ssid)) _ssid)
  (:bssid
   (&optional __bssid)
   (if __bssid (setq _bssid __bssid)) _bssid)
  (:level
   (&optional __level)
   (if __level (setq _level __level)) _level)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:capabilities
   (&optional __capabilities)
   (if __capabilities (setq _capabilities __capabilities)) _capabilities)
  (:distanceCm
   (&optional __distanceCm)
   (if __distanceCm (setq _distanceCm __distanceCm)) _distanceCm)
  (:centerFreq0
   (&optional __centerFreq0)
   (if __centerFreq0 (setq _centerFreq0 __centerFreq0)) _centerFreq0)
  (:centerFreq1
   (&optional __centerFreq1)
   (if __centerFreq1 (setq _centerFreq1 __centerFreq1)) _centerFreq1)
  (:frequency
   (&optional __frequency)
   (if __frequency (setq _frequency __frequency)) _frequency)
  (:passpoint
   (&optional __passpoint)
   (if __passpoint (setq _passpoint __passpoint)) _passpoint)
  (:venueName
   (&optional __venueName)
   (if __venueName (setq _venueName __venueName)) _venueName)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _is80211mcResponder
    1
    ;; string[] _operatorFriendlyName
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _operatorFriendlyName)) 4
    ;; uint32 _channelWidth
    4
    ;; int32 _distanceSdCm
    4
    ;; string[] _ssid
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _ssid)) 4
    ;; string[] _bssid
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _bssid)) 4
    ;; int32 _level
    4
    ;; int32 _timestamp
    4
    ;; string[] _capabilities
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _capabilities)) 4
    ;; int32 _distanceCm
    4
    ;; int32 _centerFreq0
    4
    ;; int32 _centerFreq1
    4
    ;; int32 _frequency
    4
    ;; bool _passpoint
    1
    ;; string[] _venueName
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _venueName)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _is80211mcResponder
       (if _is80211mcResponder (write-byte -1 s) (write-byte 0 s))
     ;; string[] _operatorFriendlyName
     (write-long (length _operatorFriendlyName) s)
     (dolist (elem _operatorFriendlyName)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint32 _channelWidth
       (write-long _channelWidth s)
     ;; int32 _distanceSdCm
       (write-long _distanceSdCm s)
     ;; string[] _ssid
     (write-long (length _ssid) s)
     (dolist (elem _ssid)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _bssid
     (write-long (length _bssid) s)
     (dolist (elem _bssid)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _level
       (write-long _level s)
     ;; int32 _timestamp
       (write-long _timestamp s)
     ;; string[] _capabilities
     (write-long (length _capabilities) s)
     (dolist (elem _capabilities)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _distanceCm
       (write-long _distanceCm s)
     ;; int32 _centerFreq0
       (write-long _centerFreq0 s)
     ;; int32 _centerFreq1
       (write-long _centerFreq1 s)
     ;; int32 _frequency
       (write-long _frequency s)
     ;; bool _passpoint
       (if _passpoint (write-byte -1 s) (write-byte 0 s))
     ;; string[] _venueName
     (write-long (length _venueName) s)
     (dolist (elem _venueName)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _is80211mcResponder
     (setq _is80211mcResponder (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string[] _operatorFriendlyName
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _operatorFriendlyName (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _operatorFriendlyName i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint32 _channelWidth
     (setq _channelWidth (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _distanceSdCm
     (setq _distanceSdCm (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _ssid
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ssid (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _ssid i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _bssid
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bssid (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _bssid i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _level
     (setq _level (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _timestamp
     (setq _timestamp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _capabilities
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _capabilities (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _capabilities i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _distanceCm
     (setq _distanceCm (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _centerFreq0
     (setq _centerFreq0 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _centerFreq1
     (setq _centerFreq1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _frequency
     (setq _frequency (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _passpoint
     (setq _passpoint (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string[] _venueName
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _venueName (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _venueName i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::WifiScan :md5sum-) "6ba40279298cca39ad687f78eb902fd0")
(setf (get openpilot_bridge::WifiScan :datatype-) "openpilot_bridge/WifiScan")
(setf (get openpilot_bridge::WifiScan :definition-)
      "Header header

bool is80211mcResponder
string[] operatorFriendlyName
uint32 channelWidth # enum const: ChannelWidth
int32 distanceSdCm
string[] ssid
string[] bssid
int32 level
int32 timestamp
string[] capabilities
int32 distanceCm
int32 centerFreq0
int32 centerFreq1
int32 frequency
bool passpoint
string[] venueName

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



(provide :openpilot_bridge/WifiScan "6ba40279298cca39ad687f78eb902fd0")


