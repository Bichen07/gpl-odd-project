;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::MarkerPolygon)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'MarkerPolygon (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::MARKERPOLYGON")
  (make-package "ROUTE_MISSION_HANDLER::MARKERPOLYGON"))

(in-package "ROS")
;;//! \htmlinclude MarkerPolygon.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::MarkerPolygon
  :super ros::object
  :slots (_id _type _navgId _pairs _center_point _corner_points _on _value ))

(defmethod route_mission_handler::MarkerPolygon
  (:init
   (&key
    ((:id __id) 0)
    ((:type __type) 0)
    ((:navgId __navgId) 0)
    ((:pairs __pairs) (let (r) (dotimes (i 0) (push (instance route_mission_handler::Pair :init) r)) r))
    ((:center_point __center_point) (instance geometry_msgs::Point :init))
    ((:corner_points __corner_points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:on __on) nil)
    ((:value __value) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _type (round __type))
   (setq _navgId (round __navgId))
   (setq _pairs __pairs)
   (setq _center_point __center_point)
   (setq _corner_points __corner_points)
   (setq _on __on)
   (setq _value (string __value))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:navgId
   (&optional __navgId)
   (if __navgId (setq _navgId __navgId)) _navgId)
  (:pairs
   (&rest __pairs)
   (if (keywordp (car __pairs))
       (send* _pairs __pairs)
     (progn
       (if __pairs (setq _pairs (car __pairs)))
       _pairs)))
  (:center_point
   (&rest __center_point)
   (if (keywordp (car __center_point))
       (send* _center_point __center_point)
     (progn
       (if __center_point (setq _center_point (car __center_point)))
       _center_point)))
  (:corner_points
   (&rest __corner_points)
   (if (keywordp (car __corner_points))
       (send* _corner_points __corner_points)
     (progn
       (if __corner_points (setq _corner_points (car __corner_points)))
       _corner_points)))
  (:on
   (&optional __on)
   (if __on (setq _on __on)) _on)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _type
    4
    ;; int32 _navgId
    4
    ;; route_mission_handler/Pair[] _pairs
    (apply #'+ (send-all _pairs :serialization-length)) 4
    ;; geometry_msgs/Point _center_point
    (send _center_point :serialization-length)
    ;; geometry_msgs/Point[] _corner_points
    (apply #'+ (send-all _corner_points :serialization-length)) 4
    ;; bool _on
    1
    ;; string _value
    4 (length _value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _type
       (write-long _type s)
     ;; int32 _navgId
       (write-long _navgId s)
     ;; route_mission_handler/Pair[] _pairs
     (write-long (length _pairs) s)
     (dolist (elem _pairs)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point _center_point
       (send _center_point :serialize s)
     ;; geometry_msgs/Point[] _corner_points
     (write-long (length _corner_points) s)
     (dolist (elem _corner_points)
       (send elem :serialize s)
       )
     ;; bool _on
       (if _on (write-byte -1 s) (write-byte 0 s))
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _navgId
     (setq _navgId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; route_mission_handler/Pair[] _pairs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pairs (let (r) (dotimes (i n) (push (instance route_mission_handler::Pair :init) r)) r))
     (dolist (elem- _pairs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point _center_point
     (send _center_point :deserialize buf ptr-) (incf ptr- (send _center_point :serialization-length))
   ;; geometry_msgs/Point[] _corner_points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _corner_points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _corner_points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _on
     (setq _on (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get route_mission_handler::MarkerPolygon :md5sum-) "040152815f20ff5033794b4d0e7f012f")
(setf (get route_mission_handler::MarkerPolygon :datatype-) "route_mission_handler/MarkerPolygon")
(setf (get route_mission_handler::MarkerPolygon :definition-)
      "int32 id
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



(provide :route_mission_handler/MarkerPolygon "040152815f20ff5033794b4d0e7f012f")


