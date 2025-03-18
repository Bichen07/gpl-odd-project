;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::InitData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'InitData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::INITDATA")
  (make-package "OPENPILOT_BRIDGE::INITDATA"))

(in-package "ROS")
;;//! \htmlinclude InitData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::InitData
  :super ros::object
  :slots (_header _kernelVersion _chffrAndroidExtra _androidProperties _androidSensors _pandaInfo _iosBuildInfo _gitRemote _androidBuildInfo _passive _params _version _deviceType _kernelArgs _gitCommit _gitBranch _dongleId _gctx _dirty ))

(defmethod openpilot_bridge::InitData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:kernelVersion __kernelVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:chffrAndroidExtra __chffrAndroidExtra) (instance openpilot_bridge::ChffrAndroidExtra :init))
    ((:androidProperties __androidProperties) (instance openpilot_bridge::Map :init))
    ((:androidSensors __androidSensors) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::AndroidSensor :init) r)) r))
    ((:pandaInfo __pandaInfo) (instance openpilot_bridge::PandaInfo :init))
    ((:iosBuildInfo __iosBuildInfo) (instance openpilot_bridge::IosBuildInfo :init))
    ((:gitRemote __gitRemote) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:androidBuildInfo __androidBuildInfo) (instance openpilot_bridge::AndroidBuildInfo :init))
    ((:passive __passive) nil)
    ((:params __params) (instance openpilot_bridge::Map :init))
    ((:version __version) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:deviceType __deviceType) 0)
    ((:kernelArgs __kernelArgs) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:gitCommit __gitCommit) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:gitBranch __gitBranch) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:dongleId __dongleId) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:gctx __gctx) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:dirty __dirty) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _kernelVersion __kernelVersion)
   (setq _chffrAndroidExtra __chffrAndroidExtra)
   (setq _androidProperties __androidProperties)
   (setq _androidSensors __androidSensors)
   (setq _pandaInfo __pandaInfo)
   (setq _iosBuildInfo __iosBuildInfo)
   (setq _gitRemote __gitRemote)
   (setq _androidBuildInfo __androidBuildInfo)
   (setq _passive __passive)
   (setq _params __params)
   (setq _version __version)
   (setq _deviceType (round __deviceType))
   (setq _kernelArgs __kernelArgs)
   (setq _gitCommit __gitCommit)
   (setq _gitBranch __gitBranch)
   (setq _dongleId __dongleId)
   (setq _gctx __gctx)
   (setq _dirty __dirty)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:kernelVersion
   (&optional __kernelVersion)
   (if __kernelVersion (setq _kernelVersion __kernelVersion)) _kernelVersion)
  (:chffrAndroidExtra
   (&rest __chffrAndroidExtra)
   (if (keywordp (car __chffrAndroidExtra))
       (send* _chffrAndroidExtra __chffrAndroidExtra)
     (progn
       (if __chffrAndroidExtra (setq _chffrAndroidExtra (car __chffrAndroidExtra)))
       _chffrAndroidExtra)))
  (:androidProperties
   (&rest __androidProperties)
   (if (keywordp (car __androidProperties))
       (send* _androidProperties __androidProperties)
     (progn
       (if __androidProperties (setq _androidProperties (car __androidProperties)))
       _androidProperties)))
  (:androidSensors
   (&rest __androidSensors)
   (if (keywordp (car __androidSensors))
       (send* _androidSensors __androidSensors)
     (progn
       (if __androidSensors (setq _androidSensors (car __androidSensors)))
       _androidSensors)))
  (:pandaInfo
   (&rest __pandaInfo)
   (if (keywordp (car __pandaInfo))
       (send* _pandaInfo __pandaInfo)
     (progn
       (if __pandaInfo (setq _pandaInfo (car __pandaInfo)))
       _pandaInfo)))
  (:iosBuildInfo
   (&rest __iosBuildInfo)
   (if (keywordp (car __iosBuildInfo))
       (send* _iosBuildInfo __iosBuildInfo)
     (progn
       (if __iosBuildInfo (setq _iosBuildInfo (car __iosBuildInfo)))
       _iosBuildInfo)))
  (:gitRemote
   (&optional __gitRemote)
   (if __gitRemote (setq _gitRemote __gitRemote)) _gitRemote)
  (:androidBuildInfo
   (&rest __androidBuildInfo)
   (if (keywordp (car __androidBuildInfo))
       (send* _androidBuildInfo __androidBuildInfo)
     (progn
       (if __androidBuildInfo (setq _androidBuildInfo (car __androidBuildInfo)))
       _androidBuildInfo)))
  (:passive
   (&optional __passive)
   (if __passive (setq _passive __passive)) _passive)
  (:params
   (&rest __params)
   (if (keywordp (car __params))
       (send* _params __params)
     (progn
       (if __params (setq _params (car __params)))
       _params)))
  (:version
   (&optional __version)
   (if __version (setq _version __version)) _version)
  (:deviceType
   (&optional __deviceType)
   (if __deviceType (setq _deviceType __deviceType)) _deviceType)
  (:kernelArgs
   (&optional __kernelArgs)
   (if __kernelArgs (setq _kernelArgs __kernelArgs)) _kernelArgs)
  (:gitCommit
   (&optional __gitCommit)
   (if __gitCommit (setq _gitCommit __gitCommit)) _gitCommit)
  (:gitBranch
   (&optional __gitBranch)
   (if __gitBranch (setq _gitBranch __gitBranch)) _gitBranch)
  (:dongleId
   (&optional __dongleId)
   (if __dongleId (setq _dongleId __dongleId)) _dongleId)
  (:gctx
   (&optional __gctx)
   (if __gctx (setq _gctx __gctx)) _gctx)
  (:dirty
   (&optional __dirty)
   (if __dirty (setq _dirty __dirty)) _dirty)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _kernelVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _kernelVersion)) 4
    ;; openpilot_bridge/ChffrAndroidExtra _chffrAndroidExtra
    (send _chffrAndroidExtra :serialization-length)
    ;; openpilot_bridge/Map _androidProperties
    (send _androidProperties :serialization-length)
    ;; openpilot_bridge/AndroidSensor[] _androidSensors
    (apply #'+ (send-all _androidSensors :serialization-length)) 4
    ;; openpilot_bridge/PandaInfo _pandaInfo
    (send _pandaInfo :serialization-length)
    ;; openpilot_bridge/IosBuildInfo _iosBuildInfo
    (send _iosBuildInfo :serialization-length)
    ;; string[] _gitRemote
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _gitRemote)) 4
    ;; openpilot_bridge/AndroidBuildInfo _androidBuildInfo
    (send _androidBuildInfo :serialization-length)
    ;; bool _passive
    1
    ;; openpilot_bridge/Map _params
    (send _params :serialization-length)
    ;; string[] _version
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _version)) 4
    ;; uint32 _deviceType
    4
    ;; string[] _kernelArgs
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _kernelArgs)) 4
    ;; string[] _gitCommit
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _gitCommit)) 4
    ;; string[] _gitBranch
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _gitBranch)) 4
    ;; string[] _dongleId
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _dongleId)) 4
    ;; string[] _gctx
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _gctx)) 4
    ;; bool _dirty
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _kernelVersion
     (write-long (length _kernelVersion) s)
     (dolist (elem _kernelVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/ChffrAndroidExtra _chffrAndroidExtra
       (send _chffrAndroidExtra :serialize s)
     ;; openpilot_bridge/Map _androidProperties
       (send _androidProperties :serialize s)
     ;; openpilot_bridge/AndroidSensor[] _androidSensors
     (write-long (length _androidSensors) s)
     (dolist (elem _androidSensors)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/PandaInfo _pandaInfo
       (send _pandaInfo :serialize s)
     ;; openpilot_bridge/IosBuildInfo _iosBuildInfo
       (send _iosBuildInfo :serialize s)
     ;; string[] _gitRemote
     (write-long (length _gitRemote) s)
     (dolist (elem _gitRemote)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/AndroidBuildInfo _androidBuildInfo
       (send _androidBuildInfo :serialize s)
     ;; bool _passive
       (if _passive (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/Map _params
       (send _params :serialize s)
     ;; string[] _version
     (write-long (length _version) s)
     (dolist (elem _version)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint32 _deviceType
       (write-long _deviceType s)
     ;; string[] _kernelArgs
     (write-long (length _kernelArgs) s)
     (dolist (elem _kernelArgs)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _gitCommit
     (write-long (length _gitCommit) s)
     (dolist (elem _gitCommit)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _gitBranch
     (write-long (length _gitBranch) s)
     (dolist (elem _gitBranch)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _dongleId
     (write-long (length _dongleId) s)
     (dolist (elem _dongleId)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _gctx
     (write-long (length _gctx) s)
     (dolist (elem _gctx)
       (write-long (length elem) s) (princ elem s)
       )
     ;; bool _dirty
       (if _dirty (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _kernelVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kernelVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _kernelVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/ChffrAndroidExtra _chffrAndroidExtra
     (send _chffrAndroidExtra :deserialize buf ptr-) (incf ptr- (send _chffrAndroidExtra :serialization-length))
   ;; openpilot_bridge/Map _androidProperties
     (send _androidProperties :deserialize buf ptr-) (incf ptr- (send _androidProperties :serialization-length))
   ;; openpilot_bridge/AndroidSensor[] _androidSensors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _androidSensors (let (r) (dotimes (i n) (push (instance openpilot_bridge::AndroidSensor :init) r)) r))
     (dolist (elem- _androidSensors)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/PandaInfo _pandaInfo
     (send _pandaInfo :deserialize buf ptr-) (incf ptr- (send _pandaInfo :serialization-length))
   ;; openpilot_bridge/IosBuildInfo _iosBuildInfo
     (send _iosBuildInfo :deserialize buf ptr-) (incf ptr- (send _iosBuildInfo :serialization-length))
   ;; string[] _gitRemote
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gitRemote (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _gitRemote i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/AndroidBuildInfo _androidBuildInfo
     (send _androidBuildInfo :deserialize buf ptr-) (incf ptr- (send _androidBuildInfo :serialization-length))
   ;; bool _passive
     (setq _passive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/Map _params
     (send _params :deserialize buf ptr-) (incf ptr- (send _params :serialization-length))
   ;; string[] _version
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _version (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _version i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint32 _deviceType
     (setq _deviceType (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _kernelArgs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kernelArgs (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _kernelArgs i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _gitCommit
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gitCommit (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _gitCommit i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _gitBranch
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gitBranch (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _gitBranch i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _dongleId
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dongleId (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _dongleId i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _gctx
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gctx (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _gctx i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; bool _dirty
     (setq _dirty (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::InitData :md5sum-) "76faf0d786e446ea0c4375f81f315e00")
(setf (get openpilot_bridge::InitData :datatype-) "openpilot_bridge/InitData")
(setf (get openpilot_bridge::InitData :definition-)
      "Header header

string[] kernelVersion
ChffrAndroidExtra chffrAndroidExtra
Map androidProperties
AndroidSensor[] androidSensors
PandaInfo pandaInfo
IosBuildInfo iosBuildInfo
string[] gitRemote
AndroidBuildInfo androidBuildInfo
bool passive
Map params
string[] version
uint32 deviceType # enum const: DeviceType
string[] kernelArgs
string[] gitCommit
string[] gitBranch
string[] dongleId
string[] gctx
bool dirty

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
MSG: openpilot_bridge/ChffrAndroidExtra
Header header

Map allCameraCharacteristics

================================================================================
MSG: openpilot_bridge/Map
Header header

Entry[] entries

================================================================================
MSG: openpilot_bridge/Entry
Header header

string value
string key

================================================================================
MSG: openpilot_bridge/AndroidSensor
Header header

float32 maxRange
string[] stringType
int32 maxDelay
int32 handle
string[] name
float32 power
int32 minDelay
float32 resolution
int64 fifoMaxEventCount
int32 version
int64 fifoReservedEventCount
string[] vendor
int32 type
int32 id

================================================================================
MSG: openpilot_bridge/PandaInfo
Header header

bool hasPanda
string[] stVersion
string[] dongleId
string[] espVersion

================================================================================
MSG: openpilot_bridge/IosBuildInfo
Header header

int64 appBuild
string[] appVersion
string[] osVersion
string[] deviceModel

================================================================================
MSG: openpilot_bridge/AndroidBuildInfo
Header header

string[] radioVersion
string[] versionCodename
string[] hardware
string[] versionSecurityPatch
string[] supportedAbis
string[] id
string[] board
string[] type
string[] product
string[] tags
string[] brand
string[] host
string[] user
string[] fingerprint
string[] device
string[] bootloader
string[] model
string[] serial
string[] manufacturer
string[] versionRelease
int32 time
int32 versionSdk
string[] display

")



(provide :openpilot_bridge/InitData "76faf0d786e446ea0c4375f81f315e00")


