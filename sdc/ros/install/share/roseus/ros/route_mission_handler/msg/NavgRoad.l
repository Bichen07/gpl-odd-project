;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::NavgRoad)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'NavgRoad (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::NAVGROAD")
  (make-package "ROUTE_MISSION_HANDLER::NAVGROAD"))

(in-package "ROS")
;;//! \htmlinclude NavgRoad.msg.html


(intern "*ITRI_AREA*" (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(shadow '*ITRI_AREA* (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(defconstant route_mission_handler::NavgRoad::*ITRI_AREA* 5)
(intern "*EXPRESS_WAY*" (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(shadow '*EXPRESS_WAY* (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(defconstant route_mission_handler::NavgRoad::*EXPRESS_WAY* 8)
(intern "*EXIT_GATEWAY*" (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(shadow '*EXIT_GATEWAY* (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(defconstant route_mission_handler::NavgRoad::*EXIT_GATEWAY* 20)
(intern "*ENTRY_GATEWAY*" (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(shadow '*ENTRY_GATEWAY* (find-package "ROUTE_MISSION_HANDLER::NAVGROAD"))
(defconstant route_mission_handler::NavgRoad::*ENTRY_GATEWAY* 21)
(defclass route_mission_handler::NavgRoad
  :super ros::object
  :slots (_id _positiveLaneNum _negativeLaneNum _twoWay _positiveLaneIds _negativeLaneIds _mode _r_class _routing _n_as _n_kph _p_as _p_kph _length _points _heads _tails _type ))

(defmethod route_mission_handler::NavgRoad
  (:init
   (&key
    ((:id __id) 0)
    ((:positiveLaneNum __positiveLaneNum) 0)
    ((:negativeLaneNum __negativeLaneNum) 0)
    ((:twoWay __twoWay) nil)
    ((:positiveLaneIds __positiveLaneIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:negativeLaneIds __negativeLaneIds) (make-array 0 :initial-element 0 :element-type :integer))
    ((:mode __mode) 0)
    ((:r_class __r_class) 0)
    ((:routing __routing) 0)
    ((:n_as __n_as) 0.0)
    ((:n_kph __n_kph) 0.0)
    ((:p_as __p_as) 0.0)
    ((:p_kph __p_kph) 0.0)
    ((:length __length) 0.0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ItriPoint :init) r)) r))
    ((:heads __heads) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ConnectedNavgRoad :init) r)) r))
    ((:tails __tails) (let (r) (dotimes (i 0) (push (instance route_mission_handler::ConnectedNavgRoad :init) r)) r))
    ((:type __type) 0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _positiveLaneNum (round __positiveLaneNum))
   (setq _negativeLaneNum (round __negativeLaneNum))
   (setq _twoWay __twoWay)
   (setq _positiveLaneIds __positiveLaneIds)
   (setq _negativeLaneIds __negativeLaneIds)
   (setq _mode (round __mode))
   (setq _r_class (round __r_class))
   (setq _routing (round __routing))
   (setq _n_as (float __n_as))
   (setq _n_kph (float __n_kph))
   (setq _p_as (float __p_as))
   (setq _p_kph (float __p_kph))
   (setq _length (float __length))
   (setq _points __points)
   (setq _heads __heads)
   (setq _tails __tails)
   (setq _type (round __type))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:positiveLaneNum
   (&optional __positiveLaneNum)
   (if __positiveLaneNum (setq _positiveLaneNum __positiveLaneNum)) _positiveLaneNum)
  (:negativeLaneNum
   (&optional __negativeLaneNum)
   (if __negativeLaneNum (setq _negativeLaneNum __negativeLaneNum)) _negativeLaneNum)
  (:twoWay
   (&optional __twoWay)
   (if __twoWay (setq _twoWay __twoWay)) _twoWay)
  (:positiveLaneIds
   (&optional __positiveLaneIds)
   (if __positiveLaneIds (setq _positiveLaneIds __positiveLaneIds)) _positiveLaneIds)
  (:negativeLaneIds
   (&optional __negativeLaneIds)
   (if __negativeLaneIds (setq _negativeLaneIds __negativeLaneIds)) _negativeLaneIds)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:r_class
   (&optional __r_class)
   (if __r_class (setq _r_class __r_class)) _r_class)
  (:routing
   (&optional __routing)
   (if __routing (setq _routing __routing)) _routing)
  (:n_as
   (&optional __n_as)
   (if __n_as (setq _n_as __n_as)) _n_as)
  (:n_kph
   (&optional __n_kph)
   (if __n_kph (setq _n_kph __n_kph)) _n_kph)
  (:p_as
   (&optional __p_as)
   (if __p_as (setq _p_as __p_as)) _p_as)
  (:p_kph
   (&optional __p_kph)
   (if __p_kph (setq _p_kph __p_kph)) _p_kph)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:heads
   (&rest __heads)
   (if (keywordp (car __heads))
       (send* _heads __heads)
     (progn
       (if __heads (setq _heads (car __heads)))
       _heads)))
  (:tails
   (&rest __tails)
   (if (keywordp (car __tails))
       (send* _tails __tails)
     (progn
       (if __tails (setq _tails (car __tails)))
       _tails)))
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _positiveLaneNum
    4
    ;; int32 _negativeLaneNum
    4
    ;; bool _twoWay
    1
    ;; int32[] _positiveLaneIds
    (* 4    (length _positiveLaneIds)) 4
    ;; int32[] _negativeLaneIds
    (* 4    (length _negativeLaneIds)) 4
    ;; int32 _mode
    4
    ;; int32 _r_class
    4
    ;; int32 _routing
    4
    ;; float32 _n_as
    4
    ;; float32 _n_kph
    4
    ;; float32 _p_as
    4
    ;; float32 _p_kph
    4
    ;; float32 _length
    4
    ;; route_mission_handler/ItriPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; route_mission_handler/ConnectedNavgRoad[] _heads
    (apply #'+ (send-all _heads :serialization-length)) 4
    ;; route_mission_handler/ConnectedNavgRoad[] _tails
    (apply #'+ (send-all _tails :serialization-length)) 4
    ;; int32 _type
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _positiveLaneNum
       (write-long _positiveLaneNum s)
     ;; int32 _negativeLaneNum
       (write-long _negativeLaneNum s)
     ;; bool _twoWay
       (if _twoWay (write-byte -1 s) (write-byte 0 s))
     ;; int32[] _positiveLaneIds
     (write-long (length _positiveLaneIds) s)
     (dotimes (i (length _positiveLaneIds))
       (write-long (elt _positiveLaneIds i) s)
       )
     ;; int32[] _negativeLaneIds
     (write-long (length _negativeLaneIds) s)
     (dotimes (i (length _negativeLaneIds))
       (write-long (elt _negativeLaneIds i) s)
       )
     ;; int32 _mode
       (write-long _mode s)
     ;; int32 _r_class
       (write-long _r_class s)
     ;; int32 _routing
       (write-long _routing s)
     ;; float32 _n_as
       (sys::poke _n_as (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _n_kph
       (sys::poke _n_kph (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _p_as
       (sys::poke _p_as (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _p_kph
       (sys::poke _p_kph (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _length
       (sys::poke _length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; route_mission_handler/ItriPoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; route_mission_handler/ConnectedNavgRoad[] _heads
     (write-long (length _heads) s)
     (dolist (elem _heads)
       (send elem :serialize s)
       )
     ;; route_mission_handler/ConnectedNavgRoad[] _tails
     (write-long (length _tails) s)
     (dolist (elem _tails)
       (send elem :serialize s)
       )
     ;; int32 _type
       (write-long _type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _positiveLaneNum
     (setq _positiveLaneNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _negativeLaneNum
     (setq _negativeLaneNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _twoWay
     (setq _twoWay (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32[] _positiveLaneIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _positiveLaneIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _positiveLaneIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _negativeLaneIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _negativeLaneIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _negativeLaneIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32 _mode
     (setq _mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _r_class
     (setq _r_class (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _routing
     (setq _routing (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _n_as
     (setq _n_as (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _n_kph
     (setq _n_kph (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _p_as
     (setq _p_as (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _p_kph
     (setq _p_kph (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _length
     (setq _length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; route_mission_handler/ItriPoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance route_mission_handler::ItriPoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/ConnectedNavgRoad[] _heads
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _heads (let (r) (dotimes (i n) (push (instance route_mission_handler::ConnectedNavgRoad :init) r)) r))
     (dolist (elem- _heads)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; route_mission_handler/ConnectedNavgRoad[] _tails
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tails (let (r) (dotimes (i n) (push (instance route_mission_handler::ConnectedNavgRoad :init) r)) r))
     (dolist (elem- _tails)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::NavgRoad :md5sum-) "73b8e8bb29e86ce8898fc956cfd316b4")
(setf (get route_mission_handler::NavgRoad :datatype-) "route_mission_handler/NavgRoad")
(setf (get route_mission_handler::NavgRoad :definition-)
      "int32 ITRI_AREA=5
int32 EXPRESS_WAY=8
int32 EXIT_GATEWAY=20
int32 ENTRY_GATEWAY=21

int32 id
int32 positiveLaneNum
int32 negativeLaneNum
bool twoWay
int32[] positiveLaneIds
int32[] negativeLaneIds
int32 mode
int32 r_class
int32 routing
float32 n_as
float32 n_kph
float32 p_as
float32 p_kph
float32 length
ItriPoint[] points
ConnectedNavgRoad[] heads
ConnectedNavgRoad[] tails
int32 type

================================================================================
MSG: route_mission_handler/ItriPoint
int32 id
int32 belongId
int32 pointId
geometry_msgs/Pose pose

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
MSG: route_mission_handler/ConnectedNavgRoad
int32 id
int32 pointId
float32 length

")



(provide :route_mission_handler/NavgRoad "73b8e8bb29e86ce8898fc956cfd316b4")


