;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Croad)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Croad (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::CROAD")
  (make-package "ROUTE_MISSION_HANDLER::CROAD"))

(in-package "ROS")
;;//! \htmlinclude Croad.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::Croad
  :super ros::object
  :slots (_nroad_id _isPositive _point_id _lane_ids _points _fixed ))

(defmethod route_mission_handler::Croad
  (:init
   (&key
    ((:nroad_id __nroad_id) 0)
    ((:isPositive __isPositive) nil)
    ((:point_id __point_id) 0)
    ((:lane_ids __lane_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:points __points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:fixed __fixed) nil)
    )
   (send-super :init)
   (setq _nroad_id (round __nroad_id))
   (setq _isPositive __isPositive)
   (setq _point_id (round __point_id))
   (setq _lane_ids __lane_ids)
   (setq _points __points)
   (setq _fixed __fixed)
   self)
  (:nroad_id
   (&optional __nroad_id)
   (if __nroad_id (setq _nroad_id __nroad_id)) _nroad_id)
  (:isPositive
   (&optional __isPositive)
   (if __isPositive (setq _isPositive __isPositive)) _isPositive)
  (:point_id
   (&optional __point_id)
   (if __point_id (setq _point_id __point_id)) _point_id)
  (:lane_ids
   (&optional __lane_ids)
   (if __lane_ids (setq _lane_ids __lane_ids)) _lane_ids)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:fixed
   (&optional __fixed)
   (if __fixed (setq _fixed __fixed)) _fixed)
  (:serialization-length
   ()
   (+
    ;; int32 _nroad_id
    4
    ;; bool _isPositive
    1
    ;; int32 _point_id
    4
    ;; int32[] _lane_ids
    (* 4    (length _lane_ids)) 4
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; bool _fixed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _nroad_id
       (write-long _nroad_id s)
     ;; bool _isPositive
       (if _isPositive (write-byte -1 s) (write-byte 0 s))
     ;; int32 _point_id
       (write-long _point_id s)
     ;; int32[] _lane_ids
     (write-long (length _lane_ids) s)
     (dotimes (i (length _lane_ids))
       (write-long (elt _lane_ids i) s)
       )
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; bool _fixed
       (if _fixed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _nroad_id
     (setq _nroad_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _isPositive
     (setq _isPositive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _point_id
     (setq _point_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _lane_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lane_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _lane_ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _fixed
     (setq _fixed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get route_mission_handler::Croad :md5sum-) "e73c05c21378699cef67e9582f6575b4")
(setf (get route_mission_handler::Croad :datatype-) "route_mission_handler/Croad")
(setf (get route_mission_handler::Croad :definition-)
      "int32 nroad_id
bool isPositive
int32 point_id
int32[] lane_ids
geometry_msgs/Point[] points
bool fixed

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/Croad "e73c05c21378699cef67e9582f6575b4")


