;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::SurroundReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'SurroundReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::SURROUNDREPORT")
  (make-package "DBW_PACIFICA_MSGS::SURROUNDREPORT"))

(in-package "ROS")
;;//! \htmlinclude SurroundReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::SurroundReport
  :super ros::object
  :slots (_header _front_radar_object_distance _rear_radar_object_distance _rear_right _rear_left _rear_center _front_right _front_left _front_center _front_radar_distance_valid _parking_sonar_data_valid ))

(defmethod dbw_pacifica_msgs::SurroundReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:front_radar_object_distance __front_radar_object_distance) 0.0)
    ((:rear_radar_object_distance __rear_radar_object_distance) 0.0)
    ((:rear_right __rear_right) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:rear_left __rear_left) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:rear_center __rear_center) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:front_right __front_right) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:front_left __front_left) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:front_center __front_center) (instance dbw_pacifica_msgs::SonarArcNum :init))
    ((:front_radar_distance_valid __front_radar_distance_valid) nil)
    ((:parking_sonar_data_valid __parking_sonar_data_valid) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _front_radar_object_distance (float __front_radar_object_distance))
   (setq _rear_radar_object_distance (float __rear_radar_object_distance))
   (setq _rear_right __rear_right)
   (setq _rear_left __rear_left)
   (setq _rear_center __rear_center)
   (setq _front_right __front_right)
   (setq _front_left __front_left)
   (setq _front_center __front_center)
   (setq _front_radar_distance_valid __front_radar_distance_valid)
   (setq _parking_sonar_data_valid __parking_sonar_data_valid)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:front_radar_object_distance
   (&optional __front_radar_object_distance)
   (if __front_radar_object_distance (setq _front_radar_object_distance __front_radar_object_distance)) _front_radar_object_distance)
  (:rear_radar_object_distance
   (&optional __rear_radar_object_distance)
   (if __rear_radar_object_distance (setq _rear_radar_object_distance __rear_radar_object_distance)) _rear_radar_object_distance)
  (:rear_right
   (&rest __rear_right)
   (if (keywordp (car __rear_right))
       (send* _rear_right __rear_right)
     (progn
       (if __rear_right (setq _rear_right (car __rear_right)))
       _rear_right)))
  (:rear_left
   (&rest __rear_left)
   (if (keywordp (car __rear_left))
       (send* _rear_left __rear_left)
     (progn
       (if __rear_left (setq _rear_left (car __rear_left)))
       _rear_left)))
  (:rear_center
   (&rest __rear_center)
   (if (keywordp (car __rear_center))
       (send* _rear_center __rear_center)
     (progn
       (if __rear_center (setq _rear_center (car __rear_center)))
       _rear_center)))
  (:front_right
   (&rest __front_right)
   (if (keywordp (car __front_right))
       (send* _front_right __front_right)
     (progn
       (if __front_right (setq _front_right (car __front_right)))
       _front_right)))
  (:front_left
   (&rest __front_left)
   (if (keywordp (car __front_left))
       (send* _front_left __front_left)
     (progn
       (if __front_left (setq _front_left (car __front_left)))
       _front_left)))
  (:front_center
   (&rest __front_center)
   (if (keywordp (car __front_center))
       (send* _front_center __front_center)
     (progn
       (if __front_center (setq _front_center (car __front_center)))
       _front_center)))
  (:front_radar_distance_valid
   (&optional __front_radar_distance_valid)
   (if __front_radar_distance_valid (setq _front_radar_distance_valid __front_radar_distance_valid)) _front_radar_distance_valid)
  (:parking_sonar_data_valid
   (&optional __parking_sonar_data_valid)
   (if __parking_sonar_data_valid (setq _parking_sonar_data_valid __parking_sonar_data_valid)) _parking_sonar_data_valid)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _front_radar_object_distance
    4
    ;; float32 _rear_radar_object_distance
    4
    ;; dbw_pacifica_msgs/SonarArcNum _rear_right
    (send _rear_right :serialization-length)
    ;; dbw_pacifica_msgs/SonarArcNum _rear_left
    (send _rear_left :serialization-length)
    ;; dbw_pacifica_msgs/SonarArcNum _rear_center
    (send _rear_center :serialization-length)
    ;; dbw_pacifica_msgs/SonarArcNum _front_right
    (send _front_right :serialization-length)
    ;; dbw_pacifica_msgs/SonarArcNum _front_left
    (send _front_left :serialization-length)
    ;; dbw_pacifica_msgs/SonarArcNum _front_center
    (send _front_center :serialization-length)
    ;; bool _front_radar_distance_valid
    1
    ;; bool _parking_sonar_data_valid
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _front_radar_object_distance
       (sys::poke _front_radar_object_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rear_radar_object_distance
       (sys::poke _rear_radar_object_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; dbw_pacifica_msgs/SonarArcNum _rear_right
       (send _rear_right :serialize s)
     ;; dbw_pacifica_msgs/SonarArcNum _rear_left
       (send _rear_left :serialize s)
     ;; dbw_pacifica_msgs/SonarArcNum _rear_center
       (send _rear_center :serialize s)
     ;; dbw_pacifica_msgs/SonarArcNum _front_right
       (send _front_right :serialize s)
     ;; dbw_pacifica_msgs/SonarArcNum _front_left
       (send _front_left :serialize s)
     ;; dbw_pacifica_msgs/SonarArcNum _front_center
       (send _front_center :serialize s)
     ;; bool _front_radar_distance_valid
       (if _front_radar_distance_valid (write-byte -1 s) (write-byte 0 s))
     ;; bool _parking_sonar_data_valid
       (if _parking_sonar_data_valid (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _front_radar_object_distance
     (setq _front_radar_object_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rear_radar_object_distance
     (setq _rear_radar_object_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; dbw_pacifica_msgs/SonarArcNum _rear_right
     (send _rear_right :deserialize buf ptr-) (incf ptr- (send _rear_right :serialization-length))
   ;; dbw_pacifica_msgs/SonarArcNum _rear_left
     (send _rear_left :deserialize buf ptr-) (incf ptr- (send _rear_left :serialization-length))
   ;; dbw_pacifica_msgs/SonarArcNum _rear_center
     (send _rear_center :deserialize buf ptr-) (incf ptr- (send _rear_center :serialization-length))
   ;; dbw_pacifica_msgs/SonarArcNum _front_right
     (send _front_right :deserialize buf ptr-) (incf ptr- (send _front_right :serialization-length))
   ;; dbw_pacifica_msgs/SonarArcNum _front_left
     (send _front_left :deserialize buf ptr-) (incf ptr- (send _front_left :serialization-length))
   ;; dbw_pacifica_msgs/SonarArcNum _front_center
     (send _front_center :deserialize buf ptr-) (incf ptr- (send _front_center :serialization-length))
   ;; bool _front_radar_distance_valid
     (setq _front_radar_distance_valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _parking_sonar_data_valid
     (setq _parking_sonar_data_valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::SurroundReport :md5sum-) "7fb6baa192c10e400b9071053bd9c683")
(setf (get dbw_pacifica_msgs::SurroundReport :datatype-) "dbw_pacifica_msgs/SurroundReport")
(setf (get dbw_pacifica_msgs::SurroundReport :definition-)
      "Header header

float32 front_radar_object_distance # meters
float32 rear_radar_object_distance # meters

SonarArcNum rear_right
SonarArcNum rear_left
SonarArcNum rear_center
SonarArcNum front_right
SonarArcNum front_left
SonarArcNum front_center

bool front_radar_distance_valid
bool parking_sonar_data_valid

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
MSG: dbw_pacifica_msgs/SonarArcNum
uint8 status

# Unitless - based on bars on display
uint8 NO_DISTANCE = 0
uint8 ARC1 = 1
uint8 ARC2 = 2
uint8 ARC3 = 3
uint8 ARC4 = 4
uint8 ARC5 = 5
uint8 ARC6 = 6
uint8 ARC7 = 7
uint8 ARC8 = 8
uint8 NO_ARC = 15

")



(provide :dbw_pacifica_msgs/SurroundReport "7fb6baa192c10e400b9071053bd9c683")


