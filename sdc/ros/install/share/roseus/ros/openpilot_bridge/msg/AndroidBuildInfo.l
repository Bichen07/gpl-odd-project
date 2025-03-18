;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AndroidBuildInfo)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AndroidBuildInfo (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ANDROIDBUILDINFO")
  (make-package "OPENPILOT_BRIDGE::ANDROIDBUILDINFO"))

(in-package "ROS")
;;//! \htmlinclude AndroidBuildInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::AndroidBuildInfo
  :super ros::object
  :slots (_header _radioVersion _versionCodename _hardware _versionSecurityPatch _supportedAbis _id _board _type _product _tags _brand _host _user _fingerprint _device _bootloader _model _serial _manufacturer _versionRelease _time _versionSdk _display ))

(defmethod openpilot_bridge::AndroidBuildInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:radioVersion __radioVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:versionCodename __versionCodename) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:hardware __hardware) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:versionSecurityPatch __versionSecurityPatch) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:supportedAbis __supportedAbis) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:id __id) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:board __board) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:type __type) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:product __product) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:tags __tags) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:brand __brand) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:host __host) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:user __user) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:fingerprint __fingerprint) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:device __device) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:bootloader __bootloader) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:model __model) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:serial __serial) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:manufacturer __manufacturer) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:versionRelease __versionRelease) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:time __time) 0)
    ((:versionSdk __versionSdk) 0)
    ((:display __display) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _radioVersion __radioVersion)
   (setq _versionCodename __versionCodename)
   (setq _hardware __hardware)
   (setq _versionSecurityPatch __versionSecurityPatch)
   (setq _supportedAbis __supportedAbis)
   (setq _id __id)
   (setq _board __board)
   (setq _type __type)
   (setq _product __product)
   (setq _tags __tags)
   (setq _brand __brand)
   (setq _host __host)
   (setq _user __user)
   (setq _fingerprint __fingerprint)
   (setq _device __device)
   (setq _bootloader __bootloader)
   (setq _model __model)
   (setq _serial __serial)
   (setq _manufacturer __manufacturer)
   (setq _versionRelease __versionRelease)
   (setq _time (round __time))
   (setq _versionSdk (round __versionSdk))
   (setq _display __display)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:radioVersion
   (&optional __radioVersion)
   (if __radioVersion (setq _radioVersion __radioVersion)) _radioVersion)
  (:versionCodename
   (&optional __versionCodename)
   (if __versionCodename (setq _versionCodename __versionCodename)) _versionCodename)
  (:hardware
   (&optional __hardware)
   (if __hardware (setq _hardware __hardware)) _hardware)
  (:versionSecurityPatch
   (&optional __versionSecurityPatch)
   (if __versionSecurityPatch (setq _versionSecurityPatch __versionSecurityPatch)) _versionSecurityPatch)
  (:supportedAbis
   (&optional __supportedAbis)
   (if __supportedAbis (setq _supportedAbis __supportedAbis)) _supportedAbis)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:board
   (&optional __board)
   (if __board (setq _board __board)) _board)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:product
   (&optional __product)
   (if __product (setq _product __product)) _product)
  (:tags
   (&optional __tags)
   (if __tags (setq _tags __tags)) _tags)
  (:brand
   (&optional __brand)
   (if __brand (setq _brand __brand)) _brand)
  (:host
   (&optional __host)
   (if __host (setq _host __host)) _host)
  (:user
   (&optional __user)
   (if __user (setq _user __user)) _user)
  (:fingerprint
   (&optional __fingerprint)
   (if __fingerprint (setq _fingerprint __fingerprint)) _fingerprint)
  (:device
   (&optional __device)
   (if __device (setq _device __device)) _device)
  (:bootloader
   (&optional __bootloader)
   (if __bootloader (setq _bootloader __bootloader)) _bootloader)
  (:model
   (&optional __model)
   (if __model (setq _model __model)) _model)
  (:serial
   (&optional __serial)
   (if __serial (setq _serial __serial)) _serial)
  (:manufacturer
   (&optional __manufacturer)
   (if __manufacturer (setq _manufacturer __manufacturer)) _manufacturer)
  (:versionRelease
   (&optional __versionRelease)
   (if __versionRelease (setq _versionRelease __versionRelease)) _versionRelease)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:versionSdk
   (&optional __versionSdk)
   (if __versionSdk (setq _versionSdk __versionSdk)) _versionSdk)
  (:display
   (&optional __display)
   (if __display (setq _display __display)) _display)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _radioVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _radioVersion)) 4
    ;; string[] _versionCodename
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _versionCodename)) 4
    ;; string[] _hardware
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _hardware)) 4
    ;; string[] _versionSecurityPatch
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _versionSecurityPatch)) 4
    ;; string[] _supportedAbis
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _supportedAbis)) 4
    ;; string[] _id
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _id)) 4
    ;; string[] _board
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _board)) 4
    ;; string[] _type
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _type)) 4
    ;; string[] _product
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _product)) 4
    ;; string[] _tags
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _tags)) 4
    ;; string[] _brand
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _brand)) 4
    ;; string[] _host
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _host)) 4
    ;; string[] _user
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _user)) 4
    ;; string[] _fingerprint
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _fingerprint)) 4
    ;; string[] _device
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _device)) 4
    ;; string[] _bootloader
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _bootloader)) 4
    ;; string[] _model
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _model)) 4
    ;; string[] _serial
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _serial)) 4
    ;; string[] _manufacturer
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _manufacturer)) 4
    ;; string[] _versionRelease
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _versionRelease)) 4
    ;; int32 _time
    4
    ;; int32 _versionSdk
    4
    ;; string[] _display
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _display)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _radioVersion
     (write-long (length _radioVersion) s)
     (dolist (elem _radioVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _versionCodename
     (write-long (length _versionCodename) s)
     (dolist (elem _versionCodename)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _hardware
     (write-long (length _hardware) s)
     (dolist (elem _hardware)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _versionSecurityPatch
     (write-long (length _versionSecurityPatch) s)
     (dolist (elem _versionSecurityPatch)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _supportedAbis
     (write-long (length _supportedAbis) s)
     (dolist (elem _supportedAbis)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _id
     (write-long (length _id) s)
     (dolist (elem _id)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _board
     (write-long (length _board) s)
     (dolist (elem _board)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _type
     (write-long (length _type) s)
     (dolist (elem _type)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _product
     (write-long (length _product) s)
     (dolist (elem _product)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _tags
     (write-long (length _tags) s)
     (dolist (elem _tags)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _brand
     (write-long (length _brand) s)
     (dolist (elem _brand)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _host
     (write-long (length _host) s)
     (dolist (elem _host)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _user
     (write-long (length _user) s)
     (dolist (elem _user)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _fingerprint
     (write-long (length _fingerprint) s)
     (dolist (elem _fingerprint)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _device
     (write-long (length _device) s)
     (dolist (elem _device)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _bootloader
     (write-long (length _bootloader) s)
     (dolist (elem _bootloader)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _model
     (write-long (length _model) s)
     (dolist (elem _model)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _serial
     (write-long (length _serial) s)
     (dolist (elem _serial)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _manufacturer
     (write-long (length _manufacturer) s)
     (dolist (elem _manufacturer)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _versionRelease
     (write-long (length _versionRelease) s)
     (dolist (elem _versionRelease)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _time
       (write-long _time s)
     ;; int32 _versionSdk
       (write-long _versionSdk s)
     ;; string[] _display
     (write-long (length _display) s)
     (dolist (elem _display)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _radioVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _radioVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _radioVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _versionCodename
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _versionCodename (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _versionCodename i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _hardware
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _hardware (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _hardware i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _versionSecurityPatch
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _versionSecurityPatch (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _versionSecurityPatch i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _supportedAbis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _supportedAbis (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _supportedAbis i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _id
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _id (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _id i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _board
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _board (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _board i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _type
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _type (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _type i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _product
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _product (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _product i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _tags
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tags (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _tags i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _brand
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _brand (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _brand i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _host
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _host (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _host i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _user
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _user (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _user i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _fingerprint
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _fingerprint (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _fingerprint i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _device
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _device (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _device i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _bootloader
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bootloader (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _bootloader i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _model
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _model (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _model i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _serial
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _serial (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _serial i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _manufacturer
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _manufacturer (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _manufacturer i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _versionRelease
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _versionRelease (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _versionRelease i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _time
     (setq _time (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _versionSdk
     (setq _versionSdk (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _display
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _display (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _display i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::AndroidBuildInfo :md5sum-) "4c98358a2334b0eb124ac03cd7ebfa27")
(setf (get openpilot_bridge::AndroidBuildInfo :datatype-) "openpilot_bridge/AndroidBuildInfo")
(setf (get openpilot_bridge::AndroidBuildInfo :definition-)
      "Header header

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



(provide :openpilot_bridge/AndroidBuildInfo "4c98358a2334b0eb124ac03cd7ebfa27")


