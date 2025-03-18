;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::Brake2Report)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'Brake2Report (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::BRAKE2REPORT")
  (make-package "DBW_PACIFICA_MSGS::BRAKE2REPORT"))

(in-package "ROS")
;;//! \htmlinclude Brake2Report.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::Brake2Report
  :super ros::object
  :slots (_header _brake_pressure _estimated_road_slope _speed_setpt ))

(defmethod dbw_pacifica_msgs::Brake2Report
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:brake_pressure __brake_pressure) 0.0)
    ((:estimated_road_slope __estimated_road_slope) 0.0)
    ((:speed_setpt __speed_setpt) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _brake_pressure (float __brake_pressure))
   (setq _estimated_road_slope (float __estimated_road_slope))
   (setq _speed_setpt (float __speed_setpt))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:brake_pressure
   (&optional __brake_pressure)
   (if __brake_pressure (setq _brake_pressure __brake_pressure)) _brake_pressure)
  (:estimated_road_slope
   (&optional __estimated_road_slope)
   (if __estimated_road_slope (setq _estimated_road_slope __estimated_road_slope)) _estimated_road_slope)
  (:speed_setpt
   (&optional __speed_setpt)
   (if __speed_setpt (setq _speed_setpt __speed_setpt)) _speed_setpt)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _brake_pressure
    4
    ;; float32 _estimated_road_slope
    4
    ;; float32 _speed_setpt
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _brake_pressure
       (sys::poke _brake_pressure (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _estimated_road_slope
       (sys::poke _estimated_road_slope (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed_setpt
       (sys::poke _speed_setpt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _brake_pressure
     (setq _brake_pressure (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _estimated_road_slope
     (setq _estimated_road_slope (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed_setpt
     (setq _speed_setpt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::Brake2Report :md5sum-) "8583a20888957d7b6a8c8423931dbe91")
(setf (get dbw_pacifica_msgs::Brake2Report :datatype-) "dbw_pacifica_msgs/Brake2Report")
(setf (get dbw_pacifica_msgs::Brake2Report :definition-)
      "Header header

float32 brake_pressure # units are bars, gauge pressure

float32 estimated_road_slope # degrees

float32 speed_setpt

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



(provide :dbw_pacifica_msgs/Brake2Report "8583a20888957d7b6a8c8423931dbe91")


