;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Paths)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Paths (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PATHS")
  (make-package "ROUTE_MISSION_HANDLER::PATHS"))

(in-package "ROS")
;;//! \htmlinclude Paths.msg.html


(defclass route_mission_handler::Paths
  :super ros::object
  :slots (_name _handdrive _lanes _distances _directions _isParkingPath ))

(defmethod route_mission_handler::Paths
  (:init
   (&key
    ((:name __name) "")
    ((:handdrive __handdrive) "")
    ((:lanes __lanes) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Lanes :init) r)) r))
    ((:distances __distances) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:directions __directions) (make-array 0 :initial-element 0 :element-type :integer))
    ((:isParkingPath __isParkingPath) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _handdrive (string __handdrive))
   (setq _lanes __lanes)
   (setq _distances __distances)
   (setq _directions __directions)
   (setq _isParkingPath __isParkingPath)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:handdrive
   (&optional __handdrive)
   (if __handdrive (setq _handdrive __handdrive)) _handdrive)
  (:lanes
   (&rest __lanes)
   (if (keywordp (car __lanes))
       (send* _lanes __lanes)
     (progn
       (if __lanes (setq _lanes (car __lanes)))
       _lanes)))
  (:distances
   (&optional __distances)
   (if __distances (setq _distances __distances)) _distances)
  (:directions
   (&optional __directions)
   (if __directions (setq _directions __directions)) _directions)
  (:isParkingPath
   (&optional __isParkingPath)
   (if __isParkingPath (setq _isParkingPath __isParkingPath)) _isParkingPath)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; string _handdrive
    4 (length _handdrive)
    ;; route_mission_handler/Lanes[] _lanes
    (apply #'+ (send-all _lanes :serialization-length)) 4
    ;; float64[] _distances
    (* 8    (length _distances)) 4
    ;; uint32[] _directions
    (* 4    (length _directions)) 4
    ;; bool _isParkingPath
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; string _handdrive
       (write-long (length _handdrive) s) (princ _handdrive s)
     ;; route_mission_handler/Lanes[] _lanes
     (write-long (length _lanes) s)
     (dolist (elem _lanes)
       (send elem :serialize s)
       )
     ;; float64[] _distances
     (write-long (length _distances) s)
     (dotimes (i (length _distances))
       (sys::poke (elt _distances i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; uint32[] _directions
     (write-long (length _directions) s)
     (dotimes (i (length _directions))
       (write-long (elt _directions i) s)
       )
     ;; bool _isParkingPath
       (if _isParkingPath (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _handdrive
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _handdrive (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; route_mission_handler/Lanes[] _lanes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanes (let (r) (dotimes (i n) (push (instance route_mission_handler::Lanes :init) r)) r))
     (dolist (elem- _lanes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float64[] _distances
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _distances (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _distances i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; uint32[] _directions
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _directions (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _directions i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; bool _isParkingPath
     (setq _isParkingPath (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get route_mission_handler::Paths :md5sum-) "5ef366520296bd63c5f4fdee08777872")
(setf (get route_mission_handler::Paths :datatype-) "route_mission_handler/Paths")
(setf (get route_mission_handler::Paths :definition-)
      "string name
string handdrive
Lanes[] lanes
float64[] distances
uint32[] directions
bool isParkingPath

================================================================================
MSG: route_mission_handler/Lanes
int32 type
int32 NORMAL=0
int32 SPLIT_LEFT=1
int32 SPLIT_RIGHT=2
int32 MERGE_TO_RIGHT=3
int32 MERGE_TO_LEFT=4
int32 TOBE_MERGED=5
int32 SPLIT_STRAIGHT=6

int32 id
bool isTurn
bool direction
int32 laneno
int32[] nexts
int32[] roadLineIds
Waypoints[] points
int32 max_speed_limit
int32 roadType

================================================================================
MSG: route_mission_handler/Waypoints
int32 laneId
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



(provide :route_mission_handler/Paths "5ef366520296bd63c5f4fdee08777872")


