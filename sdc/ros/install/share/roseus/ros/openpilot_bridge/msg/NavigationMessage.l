;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::NavigationMessage)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'NavigationMessage (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::NAVIGATIONMESSAGE")
  (make-package "OPENPILOT_BRIDGE::NAVIGATIONMESSAGE"))

(in-package "ROS")
;;//! \htmlinclude NavigationMessage.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::NavigationMessage
  :super ros::object
  :slots (_header _status _data _svId _messageId _submessageId _type ))

(defmethod openpilot_bridge::NavigationMessage
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:status __status) 0)
    ((:data __data) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:svId __svId) 0)
    ((:messageId __messageId) 0)
    ((:submessageId __submessageId) 0)
    ((:type __type) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _status (round __status))
   (setq _data __data)
   (setq _svId (round __svId))
   (setq _messageId (round __messageId))
   (setq _submessageId (round __submessageId))
   (setq _type (round __type))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:svId
   (&optional __svId)
   (if __svId (setq _svId __svId)) _svId)
  (:messageId
   (&optional __messageId)
   (if __messageId (setq _messageId __messageId)) _messageId)
  (:submessageId
   (&optional __submessageId)
   (if __submessageId (setq _submessageId __submessageId)) _submessageId)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _status
    4
    ;; string[] _data
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _data)) 4
    ;; int32 _svId
    4
    ;; int32 _messageId
    4
    ;; int32 _submessageId
    4
    ;; int32 _type
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _status
       (write-long _status s)
     ;; string[] _data
     (write-long (length _data) s)
     (dolist (elem _data)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _svId
       (write-long _svId s)
     ;; int32 _messageId
       (write-long _messageId s)
     ;; int32 _submessageId
       (write-long _submessageId s)
     ;; int32 _type
       (write-long _type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _data i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _svId
     (setq _svId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _messageId
     (setq _messageId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _submessageId
     (setq _submessageId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::NavigationMessage :md5sum-) "569f54f20fd84534027c20594ae8f9bf")
(setf (get openpilot_bridge::NavigationMessage :datatype-) "openpilot_bridge/NavigationMessage")
(setf (get openpilot_bridge::NavigationMessage :definition-)
      "Header header

uint32 status # enum const: Status
string[] data
int32 svId
int32 messageId
int32 submessageId
int32 type

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



(provide :openpilot_bridge/NavigationMessage "569f54f20fd84534027c20594ae8f9bf")


