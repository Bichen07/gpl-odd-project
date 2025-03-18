;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::TrackingStatus)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'TrackingStatus (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::TRACKINGSTATUS")
  (make-package "OPENPILOT_BRIDGE::TRACKINGSTATUS"))

(in-package "ROS")
;;//! \htmlinclude TrackingStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::TrackingStatus
  :super ros::object
  :slots (_header _halfCycleSubtracted _carrierPhaseValid _pseudorangeValid _halfCycleValid ))

(defmethod openpilot_bridge::TrackingStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:halfCycleSubtracted __halfCycleSubtracted) nil)
    ((:carrierPhaseValid __carrierPhaseValid) nil)
    ((:pseudorangeValid __pseudorangeValid) nil)
    ((:halfCycleValid __halfCycleValid) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _halfCycleSubtracted __halfCycleSubtracted)
   (setq _carrierPhaseValid __carrierPhaseValid)
   (setq _pseudorangeValid __pseudorangeValid)
   (setq _halfCycleValid __halfCycleValid)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:halfCycleSubtracted
   (&optional __halfCycleSubtracted)
   (if __halfCycleSubtracted (setq _halfCycleSubtracted __halfCycleSubtracted)) _halfCycleSubtracted)
  (:carrierPhaseValid
   (&optional __carrierPhaseValid)
   (if __carrierPhaseValid (setq _carrierPhaseValid __carrierPhaseValid)) _carrierPhaseValid)
  (:pseudorangeValid
   (&optional __pseudorangeValid)
   (if __pseudorangeValid (setq _pseudorangeValid __pseudorangeValid)) _pseudorangeValid)
  (:halfCycleValid
   (&optional __halfCycleValid)
   (if __halfCycleValid (setq _halfCycleValid __halfCycleValid)) _halfCycleValid)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _halfCycleSubtracted
    1
    ;; bool _carrierPhaseValid
    1
    ;; bool _pseudorangeValid
    1
    ;; bool _halfCycleValid
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _halfCycleSubtracted
       (if _halfCycleSubtracted (write-byte -1 s) (write-byte 0 s))
     ;; bool _carrierPhaseValid
       (if _carrierPhaseValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _pseudorangeValid
       (if _pseudorangeValid (write-byte -1 s) (write-byte 0 s))
     ;; bool _halfCycleValid
       (if _halfCycleValid (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _halfCycleSubtracted
     (setq _halfCycleSubtracted (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _carrierPhaseValid
     (setq _carrierPhaseValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _pseudorangeValid
     (setq _pseudorangeValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _halfCycleValid
     (setq _halfCycleValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::TrackingStatus :md5sum-) "1e90e81b8d405c8d5cd8beba0fd09111")
(setf (get openpilot_bridge::TrackingStatus :datatype-) "openpilot_bridge/TrackingStatus")
(setf (get openpilot_bridge::TrackingStatus :definition-)
      "Header header

bool halfCycleSubtracted
bool carrierPhaseValid
bool pseudorangeValid
bool halfCycleValid

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



(provide :openpilot_bridge/TrackingStatus "1e90e81b8d405c8d5cd8beba0fd09111")


