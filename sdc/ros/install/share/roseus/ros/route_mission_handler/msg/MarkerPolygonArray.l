;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::MarkerPolygonArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'MarkerPolygonArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::MARKERPOLYGONARRAY")
  (make-package "ROUTE_MISSION_HANDLER::MARKERPOLYGONARRAY"))

(in-package "ROS")
;;//! \htmlinclude MarkerPolygonArray.msg.html


(defclass route_mission_handler::MarkerPolygonArray
  :super ros::object
  :slots (_markers ))

(defmethod route_mission_handler::MarkerPolygonArray
  (:init
   (&key
    ((:markers __markers) (let (r) (dotimes (i 0) (push (instance route_mission_handler::MarkerPolygon :init) r)) r))
    )
   (send-super :init)
   (setq _markers __markers)
   self)
  (:markers
   (&rest __markers)
   (if (keywordp (car __markers))
       (send* _markers __markers)
     (progn
       (if __markers (setq _markers (car __markers)))
       _markers)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/MarkerPolygon[] _markers
    (apply #'+ (send-all _markers :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/MarkerPolygon[] _markers
     (write-long (length _markers) s)
     (dolist (elem _markers)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/MarkerPolygon[] _markers
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _markers (let (r) (dotimes (i n) (push (instance route_mission_handler::MarkerPolygon :init) r)) r))
     (dolist (elem- _markers)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::MarkerPolygonArray :md5sum-) "19ddbcf9494b79bc31ba9be72cf01eee")
(setf (get route_mission_handler::MarkerPolygonArray :datatype-) "route_mission_handler/MarkerPolygonArray")
(setf (get route_mission_handler::MarkerPolygonArray :definition-)
      "MarkerPolygon[] markers
================================================================================
MSG: route_mission_handler/MarkerPolygon
int32 id
int32 type
int32 navgId
Pair[] pairs
geometry_msgs/Point center_point
geometry_msgs/Point[] corner_points
bool on
string value

================================================================================
MSG: route_mission_handler/Pair
int32 laneId
int32[] pointIds

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/MarkerPolygonArray "19ddbcf9494b79bc31ba9be72cf01eee")


