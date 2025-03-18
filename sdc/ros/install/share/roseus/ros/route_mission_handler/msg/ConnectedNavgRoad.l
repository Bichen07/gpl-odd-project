;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::ConnectedNavgRoad)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'ConnectedNavgRoad (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::CONNECTEDNAVGROAD")
  (make-package "ROUTE_MISSION_HANDLER::CONNECTEDNAVGROAD"))

(in-package "ROS")
;;//! \htmlinclude ConnectedNavgRoad.msg.html


(defclass route_mission_handler::ConnectedNavgRoad
  :super ros::object
  :slots (_id _pointId _length ))

(defmethod route_mission_handler::ConnectedNavgRoad
  (:init
   (&key
    ((:id __id) 0)
    ((:pointId __pointId) 0)
    ((:length __length) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _pointId (round __pointId))
   (setq _length (float __length))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _pointId
    4
    ;; float32 _length
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;; float32 _length
       (sys::poke _length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _length
     (setq _length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get route_mission_handler::ConnectedNavgRoad :md5sum-) "28d69e6e69d7145b1fab1ae5d4c70e8a")
(setf (get route_mission_handler::ConnectedNavgRoad :datatype-) "route_mission_handler/ConnectedNavgRoad")
(setf (get route_mission_handler::ConnectedNavgRoad :definition-)
      "int32 id
int32 pointId
float32 length

")



(provide :route_mission_handler/ConnectedNavgRoad "28d69e6e69d7145b1fab1ae5d4c70e8a")


