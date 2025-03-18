;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::Pair)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'Pair (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::PAIR")
  (make-package "ROUTE_MISSION_HANDLER::PAIR"))

(in-package "ROS")
;;//! \htmlinclude Pair.msg.html


(defclass route_mission_handler::Pair
  :super ros::object
  :slots (_laneId _pointIds ))

(defmethod route_mission_handler::Pair
  (:init
   (&key
    ((:laneId __laneId) 0)
    ((:pointIds __pointIds) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _laneId (round __laneId))
   (setq _pointIds __pointIds)
   self)
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:pointIds
   (&optional __pointIds)
   (if __pointIds (setq _pointIds __pointIds)) _pointIds)
  (:serialization-length
   ()
   (+
    ;; int32 _laneId
    4
    ;; int32[] _pointIds
    (* 4    (length _pointIds)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32[] _pointIds
     (write-long (length _pointIds) s)
     (dotimes (i (length _pointIds))
       (write-long (elt _pointIds i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _pointIds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pointIds (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _pointIds i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get route_mission_handler::Pair :md5sum-) "9c79f7b537dfd0f3480010c95f09d489")
(setf (get route_mission_handler::Pair :datatype-) "route_mission_handler/Pair")
(setf (get route_mission_handler::Pair :definition-)
      "int32 laneId
int32[] pointIds

")



(provide :route_mission_handler/Pair "9c79f7b537dfd0f3480010c95f09d489")


