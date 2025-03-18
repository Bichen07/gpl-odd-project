;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::LaneNavgRoad)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'LaneNavgRoad (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LANENAVGROAD")
  (make-package "ROUTE_MISSION_HANDLER::LANENAVGROAD"))

(in-package "ROS")
;;//! \htmlinclude LaneNavgRoad.msg.html


(defclass route_mission_handler::LaneNavgRoad
  :super ros::object
  :slots (_lane_id _laneno _navgroad1 _isPositive1 _navgroad2 _isPositive2 _seqner ))

(defmethod route_mission_handler::LaneNavgRoad
  (:init
   (&key
    ((:lane_id __lane_id) 0)
    ((:laneno __laneno) 0)
    ((:navgroad1 __navgroad1) 0)
    ((:isPositive1 __isPositive1) nil)
    ((:navgroad2 __navgroad2) 0)
    ((:isPositive2 __isPositive2) nil)
    ((:seqner __seqner) "")
    )
   (send-super :init)
   (setq _lane_id (round __lane_id))
   (setq _laneno (round __laneno))
   (setq _navgroad1 (round __navgroad1))
   (setq _isPositive1 __isPositive1)
   (setq _navgroad2 (round __navgroad2))
   (setq _isPositive2 __isPositive2)
   (setq _seqner (string __seqner))
   self)
  (:lane_id
   (&optional __lane_id)
   (if __lane_id (setq _lane_id __lane_id)) _lane_id)
  (:laneno
   (&optional __laneno)
   (if __laneno (setq _laneno __laneno)) _laneno)
  (:navgroad1
   (&optional __navgroad1)
   (if __navgroad1 (setq _navgroad1 __navgroad1)) _navgroad1)
  (:isPositive1
   (&optional __isPositive1)
   (if __isPositive1 (setq _isPositive1 __isPositive1)) _isPositive1)
  (:navgroad2
   (&optional __navgroad2)
   (if __navgroad2 (setq _navgroad2 __navgroad2)) _navgroad2)
  (:isPositive2
   (&optional __isPositive2)
   (if __isPositive2 (setq _isPositive2 __isPositive2)) _isPositive2)
  (:seqner
   (&optional __seqner)
   (if __seqner (setq _seqner __seqner)) _seqner)
  (:serialization-length
   ()
   (+
    ;; int32 _lane_id
    4
    ;; int32 _laneno
    4
    ;; int32 _navgroad1
    4
    ;; bool _isPositive1
    1
    ;; int32 _navgroad2
    4
    ;; bool _isPositive2
    1
    ;; string _seqner
    4 (length _seqner)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _lane_id
       (write-long _lane_id s)
     ;; int32 _laneno
       (write-long _laneno s)
     ;; int32 _navgroad1
       (write-long _navgroad1 s)
     ;; bool _isPositive1
       (if _isPositive1 (write-byte -1 s) (write-byte 0 s))
     ;; int32 _navgroad2
       (write-long _navgroad2 s)
     ;; bool _isPositive2
       (if _isPositive2 (write-byte -1 s) (write-byte 0 s))
     ;; string _seqner
       (write-long (length _seqner) s) (princ _seqner s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _lane_id
     (setq _lane_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _laneno
     (setq _laneno (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _navgroad1
     (setq _navgroad1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _isPositive1
     (setq _isPositive1 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _navgroad2
     (setq _navgroad2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _isPositive2
     (setq _isPositive2 (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _seqner
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _seqner (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get route_mission_handler::LaneNavgRoad :md5sum-) "49966345243e73df88bc1cde32e2f8f0")
(setf (get route_mission_handler::LaneNavgRoad :datatype-) "route_mission_handler/LaneNavgRoad")
(setf (get route_mission_handler::LaneNavgRoad :definition-)
      "int32 lane_id
int32 laneno
int32 navgroad1
bool isPositive1
int32 navgroad2
bool isPositive2
string seqner

")



(provide :route_mission_handler/LaneNavgRoad "49966345243e73df88bc1cde32e2f8f0")


