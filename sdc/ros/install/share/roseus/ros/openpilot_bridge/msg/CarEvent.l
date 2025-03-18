;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CarEvent)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CarEvent (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CAREVENT")
  (make-package "OPENPILOT_BRIDGE::CAREVENT"))

(in-package "ROS")
;;//! \htmlinclude CarEvent.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CarEvent
  :super ros::object
  :slots (_header _enable _noEntry _name _immediateDisable _warning _permanent _softDisable _userDisable _preEnable ))

(defmethod openpilot_bridge::CarEvent
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:enable __enable) nil)
    ((:noEntry __noEntry) nil)
    ((:name __name) 0)
    ((:immediateDisable __immediateDisable) nil)
    ((:warning __warning) nil)
    ((:permanent __permanent) nil)
    ((:softDisable __softDisable) nil)
    ((:userDisable __userDisable) nil)
    ((:preEnable __preEnable) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _enable __enable)
   (setq _noEntry __noEntry)
   (setq _name (round __name))
   (setq _immediateDisable __immediateDisable)
   (setq _warning __warning)
   (setq _permanent __permanent)
   (setq _softDisable __softDisable)
   (setq _userDisable __userDisable)
   (setq _preEnable __preEnable)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:enable
   (&optional __enable)
   (if __enable (setq _enable __enable)) _enable)
  (:noEntry
   (&optional __noEntry)
   (if __noEntry (setq _noEntry __noEntry)) _noEntry)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:immediateDisable
   (&optional __immediateDisable)
   (if __immediateDisable (setq _immediateDisable __immediateDisable)) _immediateDisable)
  (:warning
   (&optional __warning)
   (if __warning (setq _warning __warning)) _warning)
  (:permanent
   (&optional __permanent)
   (if __permanent (setq _permanent __permanent)) _permanent)
  (:softDisable
   (&optional __softDisable)
   (if __softDisable (setq _softDisable __softDisable)) _softDisable)
  (:userDisable
   (&optional __userDisable)
   (if __userDisable (setq _userDisable __userDisable)) _userDisable)
  (:preEnable
   (&optional __preEnable)
   (if __preEnable (setq _preEnable __preEnable)) _preEnable)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _enable
    1
    ;; bool _noEntry
    1
    ;; uint32 _name
    4
    ;; bool _immediateDisable
    1
    ;; bool _warning
    1
    ;; bool _permanent
    1
    ;; bool _softDisable
    1
    ;; bool _userDisable
    1
    ;; bool _preEnable
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _enable
       (if _enable (write-byte -1 s) (write-byte 0 s))
     ;; bool _noEntry
       (if _noEntry (write-byte -1 s) (write-byte 0 s))
     ;; uint32 _name
       (write-long _name s)
     ;; bool _immediateDisable
       (if _immediateDisable (write-byte -1 s) (write-byte 0 s))
     ;; bool _warning
       (if _warning (write-byte -1 s) (write-byte 0 s))
     ;; bool _permanent
       (if _permanent (write-byte -1 s) (write-byte 0 s))
     ;; bool _softDisable
       (if _softDisable (write-byte -1 s) (write-byte 0 s))
     ;; bool _userDisable
       (if _userDisable (write-byte -1 s) (write-byte 0 s))
     ;; bool _preEnable
       (if _preEnable (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _enable
     (setq _enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _noEntry
     (setq _noEntry (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint32 _name
     (setq _name (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _immediateDisable
     (setq _immediateDisable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _warning
     (setq _warning (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _permanent
     (setq _permanent (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _softDisable
     (setq _softDisable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _userDisable
     (setq _userDisable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _preEnable
     (setq _preEnable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::CarEvent :md5sum-) "2f52d8ded2e13e6f9192006e63d11d91")
(setf (get openpilot_bridge::CarEvent :datatype-) "openpilot_bridge/CarEvent")
(setf (get openpilot_bridge::CarEvent :definition-)
      "Header header

bool enable
bool noEntry
uint32 name # enum const: EventName
bool immediateDisable
bool warning
bool permanent
bool softDisable
bool userDisable
bool preEnable

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



(provide :openpilot_bridge/CarEvent "2f52d8ded2e13e6f9192006e63d11d91")


