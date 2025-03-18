;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::lane_info)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'lane_info (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LANE_INFO")
  (make-package "ITRI_MSGS::LANE_INFO"))

(in-package "ROS")
;;//! \htmlinclude lane_info.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::lane_info
  :super ros::object
  :slots (_header _lane_id _lane_num _lane_width _line_pos _line_type _front_line_dis _on_route_hint _traffic_stop_line _bumper _start_right_turn _end_right_turn _start_left_turn _end_left_turn _front_marker_point _stations _station_msg _remind_distance _remind_time _turn_type _length_to_turn ))

(defmethod itri_msgs::lane_info
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lane_id __lane_id) 0)
    ((:lane_num __lane_num) 0)
    ((:lane_width __lane_width) 0.0)
    ((:line_pos __line_pos) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:line_type __line_type) (make-array 0 :initial-element 0 :element-type :integer))
    ((:front_line_dis __front_line_dis) 0.0)
    ((:on_route_hint __on_route_hint) (let (r) (dotimes (i 0) (push nil r)) r))
    ((:traffic_stop_line __traffic_stop_line) (make-array 0 :initial-element 0 :element-type :integer))
    ((:bumper __bumper) (make-array 0 :initial-element 0 :element-type :integer))
    ((:start_right_turn __start_right_turn) (make-array 0 :initial-element 0 :element-type :integer))
    ((:end_right_turn __end_right_turn) (make-array 0 :initial-element 0 :element-type :integer))
    ((:start_left_turn __start_left_turn) (make-array 0 :initial-element 0 :element-type :integer))
    ((:end_left_turn __end_left_turn) (make-array 0 :initial-element 0 :element-type :integer))
    ((:front_marker_point __front_marker_point) (instance itri_msgs::Waypoint :init))
    ((:stations __stations) (let (r) (dotimes (i 0) (push (instance itri_msgs::StationInfo :init) r)) r))
    ((:station_msg __station_msg) "")
    ((:remind_distance __remind_distance) 0.0)
    ((:remind_time __remind_time) 0)
    ((:turn_type __turn_type) 0)
    ((:length_to_turn __length_to_turn) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _lane_id (round __lane_id))
   (setq _lane_num (round __lane_num))
   (setq _lane_width (float __lane_width))
   (setq _line_pos __line_pos)
   (setq _line_type __line_type)
   (setq _front_line_dis (float __front_line_dis))
   (setq _on_route_hint __on_route_hint)
   (setq _traffic_stop_line __traffic_stop_line)
   (setq _bumper __bumper)
   (setq _start_right_turn __start_right_turn)
   (setq _end_right_turn __end_right_turn)
   (setq _start_left_turn __start_left_turn)
   (setq _end_left_turn __end_left_turn)
   (setq _front_marker_point __front_marker_point)
   (setq _stations __stations)
   (setq _station_msg (string __station_msg))
   (setq _remind_distance (float __remind_distance))
   (setq _remind_time (round __remind_time))
   (setq _turn_type (round __turn_type))
   (setq _length_to_turn (float __length_to_turn))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lane_id
   (&optional __lane_id)
   (if __lane_id (setq _lane_id __lane_id)) _lane_id)
  (:lane_num
   (&optional __lane_num)
   (if __lane_num (setq _lane_num __lane_num)) _lane_num)
  (:lane_width
   (&optional __lane_width)
   (if __lane_width (setq _lane_width __lane_width)) _lane_width)
  (:line_pos
   (&optional __line_pos)
   (if __line_pos (setq _line_pos __line_pos)) _line_pos)
  (:line_type
   (&optional __line_type)
   (if __line_type (setq _line_type __line_type)) _line_type)
  (:front_line_dis
   (&optional __front_line_dis)
   (if __front_line_dis (setq _front_line_dis __front_line_dis)) _front_line_dis)
  (:on_route_hint
   (&optional __on_route_hint)
   (if __on_route_hint (setq _on_route_hint __on_route_hint)) _on_route_hint)
  (:traffic_stop_line
   (&optional __traffic_stop_line)
   (if __traffic_stop_line (setq _traffic_stop_line __traffic_stop_line)) _traffic_stop_line)
  (:bumper
   (&optional __bumper)
   (if __bumper (setq _bumper __bumper)) _bumper)
  (:start_right_turn
   (&optional __start_right_turn)
   (if __start_right_turn (setq _start_right_turn __start_right_turn)) _start_right_turn)
  (:end_right_turn
   (&optional __end_right_turn)
   (if __end_right_turn (setq _end_right_turn __end_right_turn)) _end_right_turn)
  (:start_left_turn
   (&optional __start_left_turn)
   (if __start_left_turn (setq _start_left_turn __start_left_turn)) _start_left_turn)
  (:end_left_turn
   (&optional __end_left_turn)
   (if __end_left_turn (setq _end_left_turn __end_left_turn)) _end_left_turn)
  (:front_marker_point
   (&rest __front_marker_point)
   (if (keywordp (car __front_marker_point))
       (send* _front_marker_point __front_marker_point)
     (progn
       (if __front_marker_point (setq _front_marker_point (car __front_marker_point)))
       _front_marker_point)))
  (:stations
   (&rest __stations)
   (if (keywordp (car __stations))
       (send* _stations __stations)
     (progn
       (if __stations (setq _stations (car __stations)))
       _stations)))
  (:station_msg
   (&optional __station_msg)
   (if __station_msg (setq _station_msg __station_msg)) _station_msg)
  (:remind_distance
   (&optional __remind_distance)
   (if __remind_distance (setq _remind_distance __remind_distance)) _remind_distance)
  (:remind_time
   (&optional __remind_time)
   (if __remind_time (setq _remind_time __remind_time)) _remind_time)
  (:turn_type
   (&optional __turn_type)
   (if __turn_type (setq _turn_type __turn_type)) _turn_type)
  (:length_to_turn
   (&optional __length_to_turn)
   (if __length_to_turn (setq _length_to_turn __length_to_turn)) _length_to_turn)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _lane_id
    4
    ;; int32 _lane_num
    4
    ;; float32 _lane_width
    4
    ;; string[] _line_pos
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _line_pos)) 4
    ;; uint32[] _line_type
    (* 4    (length _line_type)) 4
    ;; float64 _front_line_dis
    8
    ;; bool[] _on_route_hint
    (* 1    (length _on_route_hint)) 4
    ;; int32[] _traffic_stop_line
    (* 4    (length _traffic_stop_line)) 4
    ;; int32[] _bumper
    (* 4    (length _bumper)) 4
    ;; int32[] _start_right_turn
    (* 4    (length _start_right_turn)) 4
    ;; int32[] _end_right_turn
    (* 4    (length _end_right_turn)) 4
    ;; int32[] _start_left_turn
    (* 4    (length _start_left_turn)) 4
    ;; int32[] _end_left_turn
    (* 4    (length _end_left_turn)) 4
    ;; itri_msgs/Waypoint _front_marker_point
    (send _front_marker_point :serialization-length)
    ;; itri_msgs/StationInfo[] _stations
    (apply #'+ (send-all _stations :serialization-length)) 4
    ;; string _station_msg
    4 (length _station_msg)
    ;; float64 _remind_distance
    8
    ;; int32 _remind_time
    4
    ;; int32 _turn_type
    4
    ;; float64 _length_to_turn
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _lane_id
       (write-long _lane_id s)
     ;; int32 _lane_num
       (write-long _lane_num s)
     ;; float32 _lane_width
       (sys::poke _lane_width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _line_pos
     (write-long (length _line_pos) s)
     (dolist (elem _line_pos)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint32[] _line_type
     (write-long (length _line_type) s)
     (dotimes (i (length _line_type))
       (write-long (elt _line_type i) s)
       )
     ;; float64 _front_line_dis
       (sys::poke _front_line_dis (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool[] _on_route_hint
     (write-long (length _on_route_hint) s)
     (dotimes (i (length _on_route_hint))
       (if (elt _on_route_hint i) (write-byte -1 s) (write-byte 0 s))
       )
     ;; int32[] _traffic_stop_line
     (write-long (length _traffic_stop_line) s)
     (dotimes (i (length _traffic_stop_line))
       (write-long (elt _traffic_stop_line i) s)
       )
     ;; int32[] _bumper
     (write-long (length _bumper) s)
     (dotimes (i (length _bumper))
       (write-long (elt _bumper i) s)
       )
     ;; int32[] _start_right_turn
     (write-long (length _start_right_turn) s)
     (dotimes (i (length _start_right_turn))
       (write-long (elt _start_right_turn i) s)
       )
     ;; int32[] _end_right_turn
     (write-long (length _end_right_turn) s)
     (dotimes (i (length _end_right_turn))
       (write-long (elt _end_right_turn i) s)
       )
     ;; int32[] _start_left_turn
     (write-long (length _start_left_turn) s)
     (dotimes (i (length _start_left_turn))
       (write-long (elt _start_left_turn i) s)
       )
     ;; int32[] _end_left_turn
     (write-long (length _end_left_turn) s)
     (dotimes (i (length _end_left_turn))
       (write-long (elt _end_left_turn i) s)
       )
     ;; itri_msgs/Waypoint _front_marker_point
       (send _front_marker_point :serialize s)
     ;; itri_msgs/StationInfo[] _stations
     (write-long (length _stations) s)
     (dolist (elem _stations)
       (send elem :serialize s)
       )
     ;; string _station_msg
       (write-long (length _station_msg) s) (princ _station_msg s)
     ;; float64 _remind_distance
       (sys::poke _remind_distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _remind_time
       (write-long _remind_time s)
     ;; int32 _turn_type
       (write-long _turn_type s)
     ;; float64 _length_to_turn
       (sys::poke _length_to_turn (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _lane_id
     (setq _lane_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lane_num
     (setq _lane_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _lane_width
     (setq _lane_width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _line_pos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _line_pos (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _line_pos i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint32[] _line_type
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _line_type (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _line_type i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float64 _front_line_dis
     (setq _front_line_dis (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool[] _on_route_hint
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _on_route_hint (make-list n))
     (dotimes (i n)
     (setf (elt _on_route_hint i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;; int32[] _traffic_stop_line
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _traffic_stop_line (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _traffic_stop_line i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _bumper
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bumper (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _bumper i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _start_right_turn
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _start_right_turn (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _start_right_turn i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _end_right_turn
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _end_right_turn (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _end_right_turn i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _start_left_turn
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _start_left_turn (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _start_left_turn i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _end_left_turn
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _end_left_turn (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _end_left_turn i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; itri_msgs/Waypoint _front_marker_point
     (send _front_marker_point :deserialize buf ptr-) (incf ptr- (send _front_marker_point :serialization-length))
   ;; itri_msgs/StationInfo[] _stations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _stations (let (r) (dotimes (i n) (push (instance itri_msgs::StationInfo :init) r)) r))
     (dolist (elem- _stations)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string _station_msg
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _station_msg (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _remind_distance
     (setq _remind_distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _remind_time
     (setq _remind_time (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _turn_type
     (setq _turn_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _length_to_turn
     (setq _length_to_turn (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get itri_msgs::lane_info :md5sum-) "57b78446a83947a2f7f242b41660c9ea")
(setf (get itri_msgs::lane_info :datatype-) "itri_msgs/lane_info")
(setf (get itri_msgs::lane_info :definition-)
      "Header header
int32 lane_id   #current lane
int32 lane_num  #total number of lane
float32 lane_width

string[] line_pos

# Right = 'R'
# Left  = 'L'
# Front = 'F'

uint32[] line_type

# EMPTY = 0
# WHITE_DASHED_LINE = 1
# WHITE_SOLID_LINE = 2
# WHITE_DOUBLE_LINE = 3
# YELLOW_DASHED_LINE
# YELLOW_SOLID_LINE
# YELLOW_DOUBLE_LINE
# RED_SOLID_LINE
# STRAIGHT_ARROW
# TURN_LEFT_ARROW
# TURN_RIGHT_ARROW
# STRAIGHT_OR_RIGHT_ARROW
# STRAIGHT_OR_LEFT_ARROW
# TURN_RIGHT_ONLY
# STOP_LINE
# LONGER_BUMP
# SHORTER_BUMP
# SLOWDOWN
# YIELD
# STOP_SIGN
# SPEED_LIMIT_20KPH
# SPEED_LIMIT_30KPH
# SPEED_LIMIT_50KPH
# SCOOTER_PARKING_PLACE
# PARKING_SPACE

float64 front_line_dis

bool[] on_route_hint
int32[] traffic_stop_line
int32[] bumper
int32[] start_right_turn
int32[] end_right_turn
int32[] start_left_turn
int32[] end_left_turn

Waypoint front_marker_point

StationInfo[] stations
string station_msg

float64 remind_distance
int32 remind_time

int32 turn_type
float64 length_to_turn

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
MSG: itri_msgs/Waypoint
geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
int32 laneId
int32 pointId
geometry_msgs/Point point
float32 heading
float32 curvature
float32 speed_limit
int32 point_id
int32 lane_id
int32 nroad_id
float32 s
float32 d
float32 left_space
float32 right_space
float32 width
int32 road_type

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/TwistStamped
# A twist with reference coordinate frame and timestamp
Header header
Twist twist

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: itri_msgs/StationInfo
string name
bool isPass
Waypoint location
int32 nearPointIndex

")



(provide :itri_msgs/lane_info "57b78446a83947a2f7f242b41660c9ea")


