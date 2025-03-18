;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::LaneNavgRoadArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'LaneNavgRoadArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANENAVGROADARRAY")
  (make-package "ROUTE_MISSION_HANDLER::LANENAVGROADARRAY"))

(in-package "ROS")
;;//! \htmlinclude LaneNavgRoadArray.msg.html


(defclass route_mission_handler::LaneNavgRoadArray
  :super ros::object
  :slots (_lanenavgroads ))

(defmethod route_mission_handler::LaneNavgRoadArray
  (:init
   (&key
    ((:lanenavgroads __lanenavgroads) (let (r) (dotimes (i 0) (push (instance route_mission_handler::LaneNavgRoad :init) r)) r))
    )
   (send-super :init)
   (setq _lanenavgroads __lanenavgroads)
   self)
  (:lanenavgroads
   (&rest __lanenavgroads)
   (if (keywordp (car __lanenavgroads))
       (send* _lanenavgroads __lanenavgroads)
     (progn
       (if __lanenavgroads (setq _lanenavgroads (car __lanenavgroads)))
       _lanenavgroads)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/LaneNavgRoad[] _lanenavgroads
    (apply #'+ (send-all _lanenavgroads :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/LaneNavgRoad[] _lanenavgroads
     (write-long (length _lanenavgroads) s)
     (dolist (elem _lanenavgroads)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/LaneNavgRoad[] _lanenavgroads
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lanenavgroads (let (r) (dotimes (i n) (push (instance route_mission_handler::LaneNavgRoad :init) r)) r))
     (dolist (elem- _lanenavgroads)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::LaneNavgRoadArray :md5sum-) "9dd8b7cd48bd0df0290a75d6bb5b2e91")
(setf (get route_mission_handler::LaneNavgRoadArray :datatype-) "route_mission_handler/LaneNavgRoadArray")
(setf (get route_mission_handler::LaneNavgRoadArray :definition-)
      "LaneNavgRoad[] lanenavgroads

================================================================================
MSG: route_mission_handler/LaneNavgRoad
int32 lane_id
int32 laneno
int32 navgroad1
bool isPositive1
int32 navgroad2
bool isPositive2
string seqner

")



(provide :route_mission_handler/LaneNavgRoadArray "9dd8b7cd48bd0df0290a75d6bb5b2e91")


