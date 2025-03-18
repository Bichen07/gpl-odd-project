;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::TrafficLightArray)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'TrafficLightArray (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::TRAFFICLIGHTARRAY")
  (make-package "ROUTE_MISSION_HANDLER::TRAFFICLIGHTARRAY"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightArray.msg.html


(defclass route_mission_handler::TrafficLightArray
  :super ros::object
  :slots (_lights ))

(defmethod route_mission_handler::TrafficLightArray
  (:init
   (&key
    ((:lights __lights) (let (r) (dotimes (i 0) (push (instance route_mission_handler::TrafficLight :init) r)) r))
    )
   (send-super :init)
   (setq _lights __lights)
   self)
  (:lights
   (&rest __lights)
   (if (keywordp (car __lights))
       (send* _lights __lights)
     (progn
       (if __lights (setq _lights (car __lights)))
       _lights)))
  (:serialization-length
   ()
   (+
    ;; route_mission_handler/TrafficLight[] _lights
    (apply #'+ (send-all _lights :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; route_mission_handler/TrafficLight[] _lights
     (write-long (length _lights) s)
     (dolist (elem _lights)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; route_mission_handler/TrafficLight[] _lights
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lights (let (r) (dotimes (i n) (push (instance route_mission_handler::TrafficLight :init) r)) r))
     (dolist (elem- _lights)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::TrafficLightArray :md5sum-) "baac1bc15bbef8708daeb8205a8b92da")
(setf (get route_mission_handler::TrafficLightArray :datatype-) "route_mission_handler/TrafficLightArray")
(setf (get route_mission_handler::TrafficLightArray :definition-)
      "TrafficLight[] lights

================================================================================
MSG: route_mission_handler/TrafficLight
int32 id
int32[] laneIds
int32 type
int32 lightNum
string vps
string vpe
float32 heading
geometry_msgs/Point[] points
string[] lights

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :route_mission_handler/TrafficLightArray "baac1bc15bbef8708daeb8205a8b92da")


