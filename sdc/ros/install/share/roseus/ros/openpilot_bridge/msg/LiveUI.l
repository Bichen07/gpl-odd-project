;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveUI)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveUI (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVEUI")
  (make-package "OPENPILOT_BRIDGE::LIVEUI"))

(in-package "ROS")
;;//! \htmlinclude LiveUI.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveUI
  :super ros::object
  :slots (_header _rearViewCam _awarenessStatus _alertText2 _alertText1 ))

(defmethod openpilot_bridge::LiveUI
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rearViewCam __rearViewCam) nil)
    ((:awarenessStatus __awarenessStatus) 0.0)
    ((:alertText2 __alertText2) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:alertText1 __alertText1) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _rearViewCam __rearViewCam)
   (setq _awarenessStatus (float __awarenessStatus))
   (setq _alertText2 __alertText2)
   (setq _alertText1 __alertText1)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rearViewCam
   (&optional __rearViewCam)
   (if __rearViewCam (setq _rearViewCam __rearViewCam)) _rearViewCam)
  (:awarenessStatus
   (&optional __awarenessStatus)
   (if __awarenessStatus (setq _awarenessStatus __awarenessStatus)) _awarenessStatus)
  (:alertText2
   (&optional __alertText2)
   (if __alertText2 (setq _alertText2 __alertText2)) _alertText2)
  (:alertText1
   (&optional __alertText1)
   (if __alertText1 (setq _alertText1 __alertText1)) _alertText1)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _rearViewCam
    1
    ;; float32 _awarenessStatus
    4
    ;; string[] _alertText2
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertText2)) 4
    ;; string[] _alertText1
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _alertText1)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _rearViewCam
       (if _rearViewCam (write-byte -1 s) (write-byte 0 s))
     ;; float32 _awarenessStatus
       (sys::poke _awarenessStatus (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _alertText2
     (write-long (length _alertText2) s)
     (dolist (elem _alertText2)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _alertText1
     (write-long (length _alertText1) s)
     (dolist (elem _alertText1)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _rearViewCam
     (setq _rearViewCam (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _awarenessStatus
     (setq _awarenessStatus (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _alertText2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertText2 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertText2 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _alertText1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _alertText1 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _alertText1 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveUI :md5sum-) "d29f5a921a14307ce3b00a6621ee4f4a")
(setf (get openpilot_bridge::LiveUI :datatype-) "openpilot_bridge/LiveUI")
(setf (get openpilot_bridge::LiveUI :definition-)
      "Header header

bool rearViewCam
float32 awarenessStatus
string[] alertText2
string[] alertText1

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



(provide :openpilot_bridge/LiveUI "d29f5a921a14307ce3b00a6621ee4f4a")


