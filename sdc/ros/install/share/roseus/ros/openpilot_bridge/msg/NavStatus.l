;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::NavStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'NavStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::NAVSTATUS")
  (make-package "OPENPILOT_BRIDGE::NAVSTATUS"))

(in-package "ROS")
;;//! \htmlinclude NavStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::NavStatus
  :super ros::object
  :slots (_header _isNavigating _currentAddress ))

(defmethod openpilot_bridge::NavStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:isNavigating __isNavigating) nil)
    ((:currentAddress __currentAddress) (instance openpilot_bridge::Address :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _isNavigating __isNavigating)
   (setq _currentAddress __currentAddress)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:isNavigating
   (&optional __isNavigating)
   (if __isNavigating (setq _isNavigating __isNavigating)) _isNavigating)
  (:currentAddress
   (&rest __currentAddress)
   (if (keywordp (car __currentAddress))
       (send* _currentAddress __currentAddress)
     (progn
       (if __currentAddress (setq _currentAddress (car __currentAddress)))
       _currentAddress)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _isNavigating
    1
    ;; openpilot_bridge/Address _currentAddress
    (send _currentAddress :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _isNavigating
       (if _isNavigating (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/Address _currentAddress
       (send _currentAddress :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _isNavigating
     (setq _isNavigating (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/Address _currentAddress
     (send _currentAddress :deserialize buf ptr-) (incf ptr- (send _currentAddress :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::NavStatus :md5sum-) "fd019d3ff14a21235dbb5ba7e40cd211")
(setf (get openpilot_bridge::NavStatus :datatype-) "openpilot_bridge/NavStatus")
(setf (get openpilot_bridge::NavStatus :definition-)
      "Header header

bool isNavigating
Address currentAddress

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
MSG: openpilot_bridge/Address
Header header

string[] city
string[] title
string[] house
string[] state
string[] street
string[] address
float32 lat
float32 lng
string[] country

")



(provide :openpilot_bridge/NavStatus "fd019d3ff14a21235dbb5ba7e40cd211")


