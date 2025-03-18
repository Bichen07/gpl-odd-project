;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::EthernetPacket)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'EthernetPacket (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ETHERNETPACKET")
  (make-package "OPENPILOT_BRIDGE::ETHERNETPACKET"))

(in-package "ROS")
;;//! \htmlinclude EthernetPacket.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::EthernetPacket
  :super ros::object
  :slots (_header _ts _pkt ))

(defmethod openpilot_bridge::EthernetPacket
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ts __ts) 0.0)
    ((:pkt __pkt) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _ts (float __ts))
   (setq _pkt __pkt)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:ts
   (&optional __ts)
   (if __ts (setq _ts __ts)) _ts)
  (:pkt
   (&optional __pkt)
   (if __pkt (setq _pkt __pkt)) _pkt)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _ts
    4
    ;; string[] _pkt
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _pkt)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _ts
       (sys::poke _ts (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _pkt
     (write-long (length _pkt) s)
     (dolist (elem _pkt)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _ts
     (setq _ts (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _pkt
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pkt (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _pkt i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::EthernetPacket :md5sum-) "b9af5e69491ee49e5097fdc7ef9d6fc5")
(setf (get openpilot_bridge::EthernetPacket :datatype-) "openpilot_bridge/EthernetPacket")
(setf (get openpilot_bridge::EthernetPacket :definition-)
      "Header header

float32 ts
string[] pkt

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



(provide :openpilot_bridge/EthernetPacket "b9af5e69491ee49e5097fdc7ef9d6fc5")


