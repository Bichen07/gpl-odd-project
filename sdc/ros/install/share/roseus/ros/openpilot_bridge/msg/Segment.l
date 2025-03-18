;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Segment)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Segment (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::SEGMENT")
  (make-package "OPENPILOT_BRIDGE::SEGMENT"))

(in-package "ROS")
;;//! \htmlinclude Segment.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Segment
  :super ros::object
  :slots (_header _distance _updateTime _from _instruction _parts _to _crossTime _exitNo ))

(defmethod openpilot_bridge::Segment
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:distance __distance) 0)
    ((:updateTime __updateTime) 0)
    ((:from __from) (instance openpilot_bridge::LatLng :init))
    ((:instruction __instruction) 0)
    ((:parts __parts) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::LatLng :init) r)) r))
    ((:to __to) (instance openpilot_bridge::LatLng :init))
    ((:crossTime __crossTime) 0)
    ((:exitNo __exitNo) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _distance (round __distance))
   (setq _updateTime (round __updateTime))
   (setq _from __from)
   (setq _instruction (round __instruction))
   (setq _parts __parts)
   (setq _to __to)
   (setq _crossTime (round __crossTime))
   (setq _exitNo (round __exitNo))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:updateTime
   (&optional __updateTime)
   (if __updateTime (setq _updateTime __updateTime)) _updateTime)
  (:from
   (&rest __from)
   (if (keywordp (car __from))
       (send* _from __from)
     (progn
       (if __from (setq _from (car __from)))
       _from)))
  (:instruction
   (&optional __instruction)
   (if __instruction (setq _instruction __instruction)) _instruction)
  (:parts
   (&rest __parts)
   (if (keywordp (car __parts))
       (send* _parts __parts)
     (progn
       (if __parts (setq _parts (car __parts)))
       _parts)))
  (:to
   (&rest __to)
   (if (keywordp (car __to))
       (send* _to __to)
     (progn
       (if __to (setq _to (car __to)))
       _to)))
  (:crossTime
   (&optional __crossTime)
   (if __crossTime (setq _crossTime __crossTime)) _crossTime)
  (:exitNo
   (&optional __exitNo)
   (if __exitNo (setq _exitNo __exitNo)) _exitNo)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _distance
    4
    ;; int32 _updateTime
    4
    ;; openpilot_bridge/LatLng _from
    (send _from :serialization-length)
    ;; uint32 _instruction
    4
    ;; openpilot_bridge/LatLng[] _parts
    (apply #'+ (send-all _parts :serialization-length)) 4
    ;; openpilot_bridge/LatLng _to
    (send _to :serialization-length)
    ;; int32 _crossTime
    4
    ;; int32 _exitNo
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _distance
       (write-long _distance s)
     ;; int32 _updateTime
       (write-long _updateTime s)
     ;; openpilot_bridge/LatLng _from
       (send _from :serialize s)
     ;; uint32 _instruction
       (write-long _instruction s)
     ;; openpilot_bridge/LatLng[] _parts
     (write-long (length _parts) s)
     (dolist (elem _parts)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/LatLng _to
       (send _to :serialize s)
     ;; int32 _crossTime
       (write-long _crossTime s)
     ;; int32 _exitNo
       (write-long _exitNo s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _distance
     (setq _distance (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _updateTime
     (setq _updateTime (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/LatLng _from
     (send _from :deserialize buf ptr-) (incf ptr- (send _from :serialization-length))
   ;; uint32 _instruction
     (setq _instruction (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; openpilot_bridge/LatLng[] _parts
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _parts (let (r) (dotimes (i n) (push (instance openpilot_bridge::LatLng :init) r)) r))
     (dolist (elem- _parts)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/LatLng _to
     (send _to :deserialize buf ptr-) (incf ptr- (send _to :serialization-length))
   ;; int32 _crossTime
     (setq _crossTime (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _exitNo
     (setq _exitNo (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::Segment :md5sum-) "dfbd5c3557c55dec73407d19d628c5ef")
(setf (get openpilot_bridge::Segment :datatype-) "openpilot_bridge/Segment")
(setf (get openpilot_bridge::Segment :definition-)
      "Header header

int32 distance
int32 updateTime
LatLng from
uint32 instruction # enum const: Instruction
LatLng[] parts
LatLng to
int32 crossTime
int32 exitNo

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
MSG: openpilot_bridge/LatLng
Header header

float32 lat
float32 lng

")



(provide :openpilot_bridge/Segment "dfbd5c3557c55dec73407d19d628c5ef")


