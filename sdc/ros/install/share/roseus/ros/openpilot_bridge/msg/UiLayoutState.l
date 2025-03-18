;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::UiLayoutState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'UiLayoutState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::UILAYOUTSTATE")
  (make-package "OPENPILOT_BRIDGE::UILAYOUTSTATE"))

(in-package "ROS")
;;//! \htmlinclude UiLayoutState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::UiLayoutState
  :super ros::object
  :slots (_header _activeApp _mapEnabled _sidebarCollapsed ))

(defmethod openpilot_bridge::UiLayoutState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:activeApp __activeApp) 0)
    ((:mapEnabled __mapEnabled) nil)
    ((:sidebarCollapsed __sidebarCollapsed) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _activeApp (round __activeApp))
   (setq _mapEnabled __mapEnabled)
   (setq _sidebarCollapsed __sidebarCollapsed)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:activeApp
   (&optional __activeApp)
   (if __activeApp (setq _activeApp __activeApp)) _activeApp)
  (:mapEnabled
   (&optional __mapEnabled)
   (if __mapEnabled (setq _mapEnabled __mapEnabled)) _mapEnabled)
  (:sidebarCollapsed
   (&optional __sidebarCollapsed)
   (if __sidebarCollapsed (setq _sidebarCollapsed __sidebarCollapsed)) _sidebarCollapsed)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _activeApp
    4
    ;; bool _mapEnabled
    1
    ;; bool _sidebarCollapsed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _activeApp
       (write-long _activeApp s)
     ;; bool _mapEnabled
       (if _mapEnabled (write-byte -1 s) (write-byte 0 s))
     ;; bool _sidebarCollapsed
       (if _sidebarCollapsed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _activeApp
     (setq _activeApp (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _mapEnabled
     (setq _mapEnabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _sidebarCollapsed
     (setq _sidebarCollapsed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::UiLayoutState :md5sum-) "15f553c11275eeabf5a5565d40667440")
(setf (get openpilot_bridge::UiLayoutState :datatype-) "openpilot_bridge/UiLayoutState")
(setf (get openpilot_bridge::UiLayoutState :definition-)
      "Header header

uint32 activeApp # enum const: App
bool mapEnabled
bool sidebarCollapsed

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



(provide :openpilot_bridge/UiLayoutState "15f553c11275eeabf5a5565d40667440")


