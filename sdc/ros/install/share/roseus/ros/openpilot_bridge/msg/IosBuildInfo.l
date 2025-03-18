;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::IosBuildInfo)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'IosBuildInfo (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::IOSBUILDINFO")
  (make-package "OPENPILOT_BRIDGE::IOSBUILDINFO"))

(in-package "ROS")
;;//! \htmlinclude IosBuildInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::IosBuildInfo
  :super ros::object
  :slots (_header _appBuild _appVersion _osVersion _deviceModel ))

(defmethod openpilot_bridge::IosBuildInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:appBuild __appBuild) 0)
    ((:appVersion __appVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:osVersion __osVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:deviceModel __deviceModel) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _appBuild (round __appBuild))
   (setq _appVersion __appVersion)
   (setq _osVersion __osVersion)
   (setq _deviceModel __deviceModel)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:appBuild
   (&optional __appBuild)
   (if __appBuild (setq _appBuild __appBuild)) _appBuild)
  (:appVersion
   (&optional __appVersion)
   (if __appVersion (setq _appVersion __appVersion)) _appVersion)
  (:osVersion
   (&optional __osVersion)
   (if __osVersion (setq _osVersion __osVersion)) _osVersion)
  (:deviceModel
   (&optional __deviceModel)
   (if __deviceModel (setq _deviceModel __deviceModel)) _deviceModel)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _appBuild
    8
    ;; string[] _appVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _appVersion)) 4
    ;; string[] _osVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _osVersion)) 4
    ;; string[] _deviceModel
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _deviceModel)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _appBuild
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _appBuild (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _appBuild) (= (length (_appBuild . bv)) 2)) ;; bignum
              (write-long (ash (elt (_appBuild . bv) 0) 0) s)
              (write-long (ash (elt (_appBuild . bv) 1) -1) s))
             ((and (class _appBuild) (= (length (_appBuild . bv)) 1)) ;; big1
              (write-long (elt (_appBuild . bv) 0) s)
              (write-long (if (>= _appBuild 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _appBuild s)(write-long (if (>= _appBuild 0) 0 #xffffffff) s)))
     ;; string[] _appVersion
     (write-long (length _appVersion) s)
     (dolist (elem _appVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _osVersion
     (write-long (length _osVersion) s)
     (dolist (elem _osVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _deviceModel
     (write-long (length _deviceModel) s)
     (dolist (elem _deviceModel)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _appBuild
#+(or :alpha :irix6 :x86_64)
      (setf _appBuild (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _appBuild (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _appVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _appVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _appVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _osVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _osVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _osVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _deviceModel
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _deviceModel (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _deviceModel i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::IosBuildInfo :md5sum-) "e054f580a75e5ffd7d3c3d10ffbadbfd")
(setf (get openpilot_bridge::IosBuildInfo :datatype-) "openpilot_bridge/IosBuildInfo")
(setf (get openpilot_bridge::IosBuildInfo :definition-)
      "Header header

int64 appBuild
string[] appVersion
string[] osVersion
string[] deviceModel

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



(provide :openpilot_bridge/IosBuildInfo "e054f580a75e5ffd7d3c3d10ffbadbfd")


