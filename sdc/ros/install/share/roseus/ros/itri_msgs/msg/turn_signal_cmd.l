;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::turn_signal_cmd)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'turn_signal_cmd (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TURN_SIGNAL_CMD")
  (make-package "ITRI_MSGS::TURN_SIGNAL_CMD"))

(in-package "ROS")
;;//! \htmlinclude turn_signal_cmd.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*NONE*" (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(shadow '*NONE* (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(defconstant itri_msgs::turn_signal_cmd::*NONE* 0)
(intern "*LEFT*" (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(shadow '*LEFT* (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(defconstant itri_msgs::turn_signal_cmd::*LEFT* 1)
(intern "*RIGHT*" (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(shadow '*RIGHT* (find-package "ITRI_MSGS::TURN_SIGNAL_CMD"))
(defconstant itri_msgs::turn_signal_cmd::*RIGHT* 2)
(defclass itri_msgs::turn_signal_cmd
  :super ros::object
  :slots (_header _turn_signal _source ))

(defmethod itri_msgs::turn_signal_cmd
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:turn_signal __turn_signal) 0)
    ((:source __source) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _turn_signal (round __turn_signal))
   (setq _source (string __source))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:turn_signal
   (&optional __turn_signal)
   (if __turn_signal (setq _turn_signal __turn_signal)) _turn_signal)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _turn_signal
    1
    ;; string _source
    4 (length _source)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _turn_signal
       (write-byte _turn_signal s)
     ;; string _source
       (write-long (length _source) s) (princ _source s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _turn_signal
     (setq _turn_signal (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get itri_msgs::turn_signal_cmd :md5sum-) "2c84172b1f795dd07d42fd3f7cec332e")
(setf (get itri_msgs::turn_signal_cmd :datatype-) "itri_msgs/turn_signal_cmd")
(setf (get itri_msgs::turn_signal_cmd :definition-)
      "Header header

uint8 NONE = 0
uint8 LEFT = 1
uint8 RIGHT = 2

uint8 turn_signal
string source

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



(provide :itri_msgs/turn_signal_cmd "2c84172b1f795dd07d42fd3f7cec332e")


