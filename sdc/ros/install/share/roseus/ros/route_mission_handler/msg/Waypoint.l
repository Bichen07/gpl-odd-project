;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Waypoint)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Waypoint (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::WAYPOINT")
  (make-package "ROUTE_MISSION_HANDLER::WAYPOINT"))

(in-package "ROS")
;;//! \htmlinclude Waypoint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::Waypoint
  :super ros::object
  :slots (_lane_id _point_id _nroad_id _roadWidth _distToRightLine _distToLeftLine _right_road_bound _left_road_bound _curvature _heading _point _markerIds _markerTypes _parkingLotId _parkingLotLaneId ))

(defmethod route_mission_handler::Waypoint
  (:init
   (&key
    ((:lane_id __lane_id) 0)
    ((:point_id __point_id) 0)
    ((:nroad_id __nroad_id) 0)
    ((:roadWidth __roadWidth) 0.0)
    ((:distToRightLine __distToRightLine) 0.0)
    ((:distToLeftLine __distToLeftLine) 0.0)
    ((:right_road_bound __right_road_bound) 0.0)
    ((:left_road_bound __left_road_bound) 0.0)
    ((:curvature __curvature) 0.0)
    ((:heading __heading) 0.0)
    ((:point __point) (instance geometry_msgs::Point :init))
    ((:markerIds __markerIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:markerTypes __markerTypes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:parkingLotId __parkingLotId) 0)
    ((:parkingLotLaneId __parkingLotLaneId) 0)
    )
   (send-super :init)
   (setq _lane_id (round __lane_id))
   (setq _point_id (round __point_id))
   (setq _nroad_id (round __nroad_id))
   (setq _roadWidth (float __roadWidth))
   (setq _distToRightLine (float __distToRightLine))
   (setq _distToLeftLine (float __distToLeftLine))
   (setq _right_road_bound (float __right_road_bound))
   (setq _left_road_bound (float __left_road_bound))
   (setq _curvature (float __curvature))
   (setq _heading (float __heading))
   (setq _point __point)
   (setq _markerIds __markerIds)
   (setq _markerTypes __markerTypes)
   (setq _parkingLotId (round __parkingLotId))
   (setq _parkingLotLaneId (round __parkingLotLaneId))
   self)
  (:lane_id
   (&optional __lane_id)
   (if __lane_id (setq _lane_id __lane_id)) _lane_id)
  (:point_id
   (&optional __point_id)
   (if __point_id (setq _point_id __point_id)) _point_id)
  (:nroad_id
   (&optional __nroad_id)
   (if __nroad_id (setq _nroad_id __nroad_id)) _nroad_id)
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
  (:curvature
   (&optional __curvature)
   (if __curvature (setq _curvature __curvature)) _curvature)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:point
   (&rest __point)
   (if (keywordp (car __point))
       (send* _point __point)
     (progn
       (if __point (setq _point (car __point)))
       _point)))
  (:markerIds
   (&optional __markerIds)
   (if __markerIds (setq _markerIds __markerIds)) _markerIds)
  (:markerTypes
   (&optional __markerTypes)
   (if __markerTypes (setq _markerTypes __markerTypes)) _markerTypes)
  (:parkingLotId
   (&optional __parkingLotId)
   (if __parkingLotId (setq _parkingLotId __parkingLotId)) _parkingLotId)
  (:parkingLotLaneId
   (&optional __parkingLotLaneId)
   (if __parkingLotLaneId (setq _parkingLotLaneId __parkingLotLaneId)) _parkingLotLaneId)
  (:serialization-length
   ()
   (+
    ;; int32 _lane_id
    4
    ;; int32 _point_id
    4
    ;; int32 _nroad_id
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
    ;; float32 _curvature
    4
    ;; float32 _heading
    4
    ;; geometry_msgs/Point _point
    (send _point :serialization-length)
    ;; int32[] _markerIds
    (* 4    (length _markerIds)) 4
    ;; int32[] _markerTypes
    (* 4    (length _markerTypes)) 4
    ;; int32 _parkingLotId
    4
    ;; int32 _parkingLotLaneId
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _lane_id
       (write-long _lane_id s)
     ;; int32 _point_id
       (write-long _point_id s)
     ;; int32 _nroad_id
       (write-long _nroad_id s)
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
     ;; float32 _curvature
       (sys::poke _curvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Point _point
       (send _point :serialize s)
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
     ;; int32 _parkingLotId
       (write-long _parkingLotId s)
     ;; int32 _parkingLotLaneId
       (write-long _parkingLotLaneId s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _lane_id
     (setq _lane_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _point_id
     (setq _point_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _nroad_id
     (setq _nroad_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
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
   ;; float32 _curvature
     (setq _curvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _heading
     (setq _heading (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Point _point
     (send _point :deserialize buf ptr-) (incf ptr- (send _point :serialization-length))
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
   ;; int32 _parkingLotId
     (setq _parkingLotId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _parkingLotLaneId
     (setq _parkingLotLaneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::Waypoint :md5sum-) "a3470e7d3e109ed20173633523dd455c")
(setf (get route_mission_handler::Waypoint :datatype-) "route_mission_handler/Waypoint")
(setf (get route_mission_handler::Waypoint :definition-)
      "int32 lane_id
int32 point_id
int32 nroad_id
float32 roadWidth
float32 distToRightLine
float32 distToLeftLine
float32 right_road_bound
float32 left_road_bound
float32 curvature
float32 heading
geometry_msgs/Point point
int32[] markerIds
int32[] markerTypes
int32 parkingLotId
int32 parkingLotLaneId

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/Waypoint "a3470e7d3e109ed20173633523dd455c")


