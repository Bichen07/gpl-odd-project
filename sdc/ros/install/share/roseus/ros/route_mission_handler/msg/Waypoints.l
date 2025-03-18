;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Waypoints)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Waypoints (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::WAYPOINTS")
  (make-package "ROUTE_MISSION_HANDLER::WAYPOINTS"))

(in-package "ROS")
;;//! \htmlinclude Waypoints.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::Waypoints
  :super ros::object
  :slots (_laneId _pointId _roadWidth _distToRightLine _distToLeftLine _right_road_bound _left_road_bound _curve _slope _bank_angle _pose _markerIds _markerTypes ))

(defmethod route_mission_handler::Waypoints
  (:init
   (&key
    ((:laneId __laneId) 0)
    ((:pointId __pointId) 0)
    ((:roadWidth __roadWidth) 0.0)
    ((:distToRightLine __distToRightLine) 0.0)
    ((:distToLeftLine __distToLeftLine) 0.0)
    ((:right_road_bound __right_road_bound) 0.0)
    ((:left_road_bound __left_road_bound) 0.0)
    ((:curve __curve) 0.0)
    ((:slope __slope) 0.0)
    ((:bank_angle __bank_angle) 0.0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:markerIds __markerIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:markerTypes __markerTypes) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _laneId (round __laneId))
   (setq _pointId (round __pointId))
   (setq _roadWidth (float __roadWidth))
   (setq _distToRightLine (float __distToRightLine))
   (setq _distToLeftLine (float __distToLeftLine))
   (setq _right_road_bound (float __right_road_bound))
   (setq _left_road_bound (float __left_road_bound))
   (setq _curve (float __curve))
   (setq _slope (float __slope))
   (setq _bank_angle (float __bank_angle))
   (setq _pose __pose)
   (setq _markerIds __markerIds)
   (setq _markerTypes __markerTypes)
   self)
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:roadWidth
   (&optional __roadWidth)
   (if __roadWidth (setq _roadWidth __roadWidth)) _roadWidth)
  (:distToRightLine
   (&optional __distToRightLine)
   (if __distToRightLine (setq _distToRightLine __distToRightLine)) _distToRightLine)
  (:distToLeftLine
   (&optional __distToLeftLine)
   (if __distToLeftLine (setq _distToLeftLine __distToLeftLine)) _distToLeftLine)
  (:right_road_bound
   (&optional __right_road_bound)
   (if __right_road_bound (setq _right_road_bound __right_road_bound)) _right_road_bound)
  (:left_road_bound
   (&optional __left_road_bound)
   (if __left_road_bound (setq _left_road_bound __left_road_bound)) _left_road_bound)
  (:curve
   (&optional __curve)
   (if __curve (setq _curve __curve)) _curve)
  (:slope
   (&optional __slope)
   (if __slope (setq _slope __slope)) _slope)
  (:bank_angle
   (&optional __bank_angle)
   (if __bank_angle (setq _bank_angle __bank_angle)) _bank_angle)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:markerIds
   (&optional __markerIds)
   (if __markerIds (setq _markerIds __markerIds)) _markerIds)
  (:markerTypes
   (&optional __markerTypes)
   (if __markerTypes (setq _markerTypes __markerTypes)) _markerTypes)
  (:serialization-length
   ()
   (+
    ;; int32 _laneId
    4
    ;; int32 _pointId
    4
    ;; float32 _roadWidth
    4
    ;; float32 _distToRightLine
    4
    ;; float32 _distToLeftLine
    4
    ;; float32 _right_road_bound
    4
    ;; float32 _left_road_bound
    4
    ;; float32 _curve
    4
    ;; float32 _slope
    4
    ;; float32 _bank_angle
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; int32[] _markerIds
    (* 4    (length _markerIds)) 4
    ;; int32[] _markerTypes
    (* 4    (length _markerTypes)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;; float32 _roadWidth
       (sys::poke _roadWidth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distToRightLine
       (sys::poke _distToRightLine (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distToLeftLine
       (sys::poke _distToLeftLine (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _right_road_bound
       (sys::poke _right_road_bound (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _left_road_bound
       (sys::poke _left_road_bound (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _curve
       (sys::poke _curve (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _slope
       (sys::poke _slope (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _bank_angle
       (sys::poke _bank_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; int32[] _markerIds
     (write-long (length _markerIds) s)
     (dotimes (i (length _markerIds))
       (write-long (elt _markerIds i) s)
       )
     ;; int32[] _markerTypes
     (write-long (length _markerTypes) s)
     (dotimes (i (length _markerTypes))
       (write-long (elt _markerTypes i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _roadWidth
     (setq _roadWidth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distToRightLine
     (setq _distToRightLine (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distToLeftLine
     (setq _distToLeftLine (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _right_road_bound
     (setq _right_road_bound (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _left_road_bound
     (setq _left_road_bound (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _curve
     (setq _curve (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _slope
     (setq _slope (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _bank_angle
     (setq _bank_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; int32[] _markerIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _markerIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _markerIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _markerTypes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _markerTypes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _markerTypes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::Waypoints :md5sum-) "2b80f75c6328a6dc05af65a457e56008")
(setf (get route_mission_handler::Waypoints :datatype-) "route_mission_handler/Waypoints")
(setf (get route_mission_handler::Waypoints :definition-)
      "int32 laneId
int32 pointId
float32 roadWidth
float32 distToRightLine
float32 distToLeftLine
float32 right_road_bound
float32 left_road_bound
float32 curve
float32 slope
float32 bank_angle
geometry_msgs/Pose pose
int32[] markerIds
int32[] markerTypes

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

")



(provide :route_mission_handler/Waypoints "2b80f75c6328a6dc05af65a457e56008")


