;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Lateraltuning)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Lateraltuning (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALTUNING")
  (make-package "OPENPILOT_BRIDGE::LATERALTUNING"))

(in-package "ROS")
;;//! \htmlinclude Lateraltuning.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Lateraltuning
  :super ros::object
  :slots (_header _indi _pid _lqr ))

(defmethod openpilot_bridge::Lateraltuning
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:indi __indi) (instance openpilot_bridge::LateralINDITuning :init))
    ((:pid __pid) (instance openpilot_bridge::LateralPIDTuning :init))
    ((:lqr __lqr) (instance openpilot_bridge::LateralLQRTuning :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _indi __indi)
   (setq _pid __pid)
   (setq _lqr __lqr)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:indi
   (&rest __indi)
   (if (keywordp (car __indi))
       (send* _indi __indi)
     (progn
       (if __indi (setq _indi (car __indi)))
       _indi)))
  (:pid
   (&rest __pid)
   (if (keywordp (car __pid))
       (send* _pid __pid)
     (progn
       (if __pid (setq _pid (car __pid)))
       _pid)))
  (:lqr
   (&rest __lqr)
   (if (keywordp (car __lqr))
       (send* _lqr __lqr)
     (progn
       (if __lqr (setq _lqr (car __lqr)))
       _lqr)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/LateralINDITuning _indi
    (send _indi :serialization-length)
    ;; openpilot_bridge/LateralPIDTuning _pid
    (send _pid :serialization-length)
    ;; openpilot_bridge/LateralLQRTuning _lqr
    (send _lqr :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/LateralINDITuning _indi
       (send _indi :serialize s)
     ;; openpilot_bridge/LateralPIDTuning _pid
       (send _pid :serialize s)
     ;; openpilot_bridge/LateralLQRTuning _lqr
       (send _lqr :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/LateralINDITuning _indi
     (send _indi :deserialize buf ptr-) (incf ptr- (send _indi :serialization-length))
   ;; openpilot_bridge/LateralPIDTuning _pid
     (send _pid :deserialize buf ptr-) (incf ptr- (send _pid :serialization-length))
   ;; openpilot_bridge/LateralLQRTuning _lqr
     (send _lqr :deserialize buf ptr-) (incf ptr- (send _lqr :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::Lateraltuning :md5sum-) "91bf1863abb4aef4fc1990bbeead3dc0")
(setf (get openpilot_bridge::Lateraltuning :datatype-) "openpilot_bridge/Lateraltuning")
(setf (get openpilot_bridge::Lateraltuning :definition-)
      "Header header

LateralINDITuning indi
LateralPIDTuning pid
LateralLQRTuning lqr

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
MSG: openpilot_bridge/LateralINDITuning
Header header

float32 actuatorEffectiveness
float32 outerLoopGain
float32 innerLoopGain
float32 timeConstant

================================================================================
MSG: openpilot_bridge/LateralPIDTuning
Header header

float32[] kiBP
float32 kf
float32[] kiV
float32[] kpV
float32[] kpBP

================================================================================
MSG: openpilot_bridge/LateralLQRTuning
Header header

float32[] a
float32[] c
float32 scale
float32 ki
float32[] l
float32[] b
float32 dcGain
float32[] k

")



(provide :openpilot_bridge/Lateraltuning "91bf1863abb4aef4fc1990bbeead3dc0")


