;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::TrafficLight)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'TrafficLight (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::TRAFFICLIGHT")
  (make-package "ROUTE_MISSION_HANDLER::TRAFFICLIGHT"))

(in-package "ROS")
;;//! \htmlinclude TrafficLight.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass route_mission_handler::TrafficLight
  :super ros::object
  :slots (_id _laneIds _type _lightNum _vps _vpe _heading _points _lights ))

(defmethod route_mission_handler::TrafficLight
  (:init
   (&key
    ((:id __id) 0)
    ((:laneIds __laneIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:type __type) 0)
    ((:lightNum __lightNum) 0)
    ((:vps __vps) "")
    ((:vpe __vpe) "")
    ((:heading __heading) 0.0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:lights __lights) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _laneIds __laneIds)
   (setq _type (round __type))
   (setq _lightNum (round __lightNum))
   (setq _vps (string __vps))
   (setq _vpe (string __vpe))
   (setq _heading (float __heading))
   (setq _points __points)
   (setq _lights __lights)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:laneIds
   (&optional __laneIds)
   (if __laneIds (setq _laneIds __laneIds)) _laneIds)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:lightNum
   (&optional __lightNum)
   (if __lightNum (setq _lightNum __lightNum)) _lightNum)
  (:vps
   (&optional __vps)
   (if __vps (setq _vps __vps)) _vps)
  (:vpe
   (&optional __vpe)
   (if __vpe (setq _vpe __vpe)) _vpe)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:lights
   (&optional __lights)
   (if __lights (setq _lights __lights)) _lights)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32[] _laneIds
    (* 4    (length _laneIds)) 4
    ;; int32 _type
    4
    ;; int32 _lightNum
    4
    ;; string _vps
    4 (length _vps)
    ;; string _vpe
    4 (length _vpe)
    ;; float32 _heading
    4
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; string[] _lights
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _lights)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32[] _laneIds
     (write-long (length _laneIds) s)
     (dotimes (i (length _laneIds))
       (write-long (elt _laneIds i) s)
       )
     ;; int32 _type
       (write-long _type s)
     ;; int32 _lightNum
       (write-long _lightNum s)
     ;; string _vps
       (write-long (length _vps) s) (princ _vps s)
     ;; string _vpe
       (write-long (length _vpe) s) (princ _vpe s)
     ;; float32 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; string[] _lights
     (write-long (length _lights) s)
     (dolist (elem _lights)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _laneIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _laneIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _laneIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lightNum
     (setq _lightNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _vps
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _vps (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _vpe
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _vpe (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _heading
     (setq _heading (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _lights
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lights (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _lights i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::TrafficLight :md5sum-) "48c6cfe6d51fe7a3ff894f880970f709")
(setf (get route_mission_handler::TrafficLight :datatype-) "route_mission_handler/TrafficLight")
(setf (get route_mission_handler::TrafficLight :definition-)
      "int32 id
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



(provide :route_mission_handler/TrafficLight "48c6cfe6d51fe7a3ff894f880970f709")


