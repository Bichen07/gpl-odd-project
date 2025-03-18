;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::OpenPilotLine)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'OpenPilotLine (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::OPENPILOTLINE")
  (make-package "ITRI_MSGS::OPENPILOTLINE"))

(in-package "ROS")
;;//! \htmlinclude OpenPilotLine.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::OpenPilotLine
  :super ros::object
  :slots (_header _probability _coefficient ))

(defmethod itri_msgs::OpenPilotLine
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:probability __probability) 0)
    ((:coefficient __coefficient) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _probability (round __probability))
   (setq _coefficient __coefficient)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:coefficient
   (&optional __coefficient)
   (if __coefficient (setq _coefficient __coefficient)) _coefficient)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _probability
    1
    ;; float32[] _coefficient
    (* 4    (length _coefficient)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _probability
       (write-byte _probability s)
     ;; float32[] _coefficient
     (write-long (length _coefficient) s)
     (dotimes (i (length _coefficient))
       (sys::poke (elt _coefficient i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _probability
     (setq _probability (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[] _coefficient
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _coefficient (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _coefficient i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get itri_msgs::OpenPilotLine :md5sum-) "97d974b7382eef820389ec52864575e8")
(setf (get itri_msgs::OpenPilotLine :datatype-) "itri_msgs/OpenPilotLine")
(setf (get itri_msgs::OpenPilotLine :definition-)
      "std_msgs/Header header

uint8 probability
float32[] coefficient

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



(provide :itri_msgs/OpenPilotLine "97d974b7382eef820389ec52864575e8")


