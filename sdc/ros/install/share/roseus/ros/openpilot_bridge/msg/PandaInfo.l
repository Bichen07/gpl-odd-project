;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::PandaInfo)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'PandaInfo (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PANDAINFO")
  (make-package "OPENPILOT_BRIDGE::PANDAINFO"))

(in-package "ROS")
;;//! \htmlinclude PandaInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::PandaInfo
  :super ros::object
  :slots (_header _hasPanda _stVersion _dongleId _espVersion ))

(defmethod openpilot_bridge::PandaInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:hasPanda __hasPanda) nil)
    ((:stVersion __stVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:dongleId __dongleId) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:espVersion __espVersion) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _hasPanda __hasPanda)
   (setq _stVersion __stVersion)
   (setq _dongleId __dongleId)
   (setq _espVersion __espVersion)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:hasPanda
   (&optional __hasPanda)
   (if __hasPanda (setq _hasPanda __hasPanda)) _hasPanda)
  (:stVersion
   (&optional __stVersion)
   (if __stVersion (setq _stVersion __stVersion)) _stVersion)
  (:dongleId
   (&optional __dongleId)
   (if __dongleId (setq _dongleId __dongleId)) _dongleId)
  (:espVersion
   (&optional __espVersion)
   (if __espVersion (setq _espVersion __espVersion)) _espVersion)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _hasPanda
    1
    ;; string[] _stVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _stVersion)) 4
    ;; string[] _dongleId
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _dongleId)) 4
    ;; string[] _espVersion
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _espVersion)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _hasPanda
       (if _hasPanda (write-byte -1 s) (write-byte 0 s))
     ;; string[] _stVersion
     (write-long (length _stVersion) s)
     (dolist (elem _stVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _dongleId
     (write-long (length _dongleId) s)
     (dolist (elem _dongleId)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _espVersion
     (write-long (length _espVersion) s)
     (dolist (elem _espVersion)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _hasPanda
     (setq _hasPanda (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string[] _stVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _stVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _stVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _dongleId
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dongleId (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _dongleId i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _espVersion
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _espVersion (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _espVersion i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::PandaInfo :md5sum-) "e7a7de0c09e904ad133bf935bf403dcf")
(setf (get openpilot_bridge::PandaInfo :datatype-) "openpilot_bridge/PandaInfo")
(setf (get openpilot_bridge::PandaInfo :definition-)
      "Header header

bool hasPanda
string[] stVersion
string[] dongleId
string[] espVersion

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



(provide :openpilot_bridge/PandaInfo "e7a7de0c09e904ad133bf935bf403dcf")


