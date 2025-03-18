;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::BehaviorState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'BehaviorState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::BEHAVIORSTATE")
  (make-package "ITRI_MSGS::BEHAVIORSTATE"))

(in-package "ROS")
;;//! \htmlinclude BehaviorState.msg.html


(intern "*INITIAL*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*INITIAL* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*INITIAL* 0)
(intern "*AEB*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*AEB* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*AEB* 1)
(intern "*LANE_FOLLOW*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*LANE_FOLLOW* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*LANE_FOLLOW* 2)
(intern "*LANE_CHANGE*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*LANE_CHANGE* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*LANE_CHANGE* 3)
(intern "*AVOIDANCE*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*AVOIDANCE* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*AVOIDANCE* 4)
(intern "*STOP*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*STOP* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*STOP* 5)
(intern "*PARKING*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*PARKING* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*PARKING* 6)
(intern "*EMERGENCY*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*EMERGENCY* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*EMERGENCY* 7)
(intern "*FINISH*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*FINISH* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*FINISH* 8)
(intern "*ACC*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*ACC* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*ACC* 9)
(intern "*BUMP*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*BUMP* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*BUMP* 10)
(intern "*INTERSECTION*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*INTERSECTION* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*INTERSECTION* 11)
(intern "*TRAFFIC_LIGHT_RED*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*TRAFFIC_LIGHT_RED* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*TRAFFIC_LIGHT_RED* 12)
(intern "*TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT* 13)
(intern "*TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT* 14)
(intern "*CURVE*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*CURVE* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*CURVE* 15)
(intern "*SPEEDUP*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*SPEEDUP* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*SPEEDUP* 16)
(intern "*DESTINATIONWAYPOINTS*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*DESTINATIONWAYPOINTS* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*DESTINATIONWAYPOINTS* 17)
(intern "*DESTINATIONGLOBALPATH*" (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(shadow '*DESTINATIONGLOBALPATH* (find-package "ITRI_MSGS::BEHAVIORSTATE"))
(defconstant itri_msgs::BehaviorState::*DESTINATIONGLOBALPATH* 18)
(defclass itri_msgs::BehaviorState
  :super ros::object
  :slots (_behavior_state _behavior_stete_string _obj_id _obstacles _avoidance ))

(defmethod itri_msgs::BehaviorState
  (:init
   (&key
    ((:behavior_state __behavior_state) 0)
    ((:behavior_stete_string __behavior_stete_string) "")
    ((:obj_id __obj_id) 0)
    ((:obstacles __obstacles) nil)
    ((:avoidance __avoidance) nil)
    )
   (send-super :init)
   (setq _behavior_state (round __behavior_state))
   (setq _behavior_stete_string (string __behavior_stete_string))
   (setq _obj_id (round __obj_id))
   (setq _obstacles __obstacles)
   (setq _avoidance __avoidance)
   self)
  (:behavior_state
   (&optional __behavior_state)
   (if __behavior_state (setq _behavior_state __behavior_state)) _behavior_state)
  (:behavior_stete_string
   (&optional __behavior_stete_string)
   (if __behavior_stete_string (setq _behavior_stete_string __behavior_stete_string)) _behavior_stete_string)
  (:obj_id
   (&optional __obj_id)
   (if __obj_id (setq _obj_id __obj_id)) _obj_id)
  (:obstacles
   (&optional __obstacles)
   (if __obstacles (setq _obstacles __obstacles)) _obstacles)
  (:avoidance
   (&optional __avoidance)
   (if __avoidance (setq _avoidance __avoidance)) _avoidance)
  (:serialization-length
   ()
   (+
    ;; int32 _behavior_state
    4
    ;; string _behavior_stete_string
    4 (length _behavior_stete_string)
    ;; int32 _obj_id
    4
    ;; bool _obstacles
    1
    ;; bool _avoidance
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _behavior_state
       (write-long _behavior_state s)
     ;; string _behavior_stete_string
       (write-long (length _behavior_stete_string) s) (princ _behavior_stete_string s)
     ;; int32 _obj_id
       (write-long _obj_id s)
     ;; bool _obstacles
       (if _obstacles (write-byte -1 s) (write-byte 0 s))
     ;; bool _avoidance
       (if _avoidance (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _behavior_state
     (setq _behavior_state (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _behavior_stete_string
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _behavior_stete_string (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _obj_id
     (setq _obj_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _obstacles
     (setq _obstacles (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _avoidance
     (setq _avoidance (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::BehaviorState :md5sum-) "b7ef9dd36a2ceb7fe32edd273643bca2")
(setf (get itri_msgs::BehaviorState :datatype-) "itri_msgs/BehaviorState")
(setf (get itri_msgs::BehaviorState :definition-)
      "int32 behavior_state
string behavior_stete_string

uint8 INITIAL = 0
uint8 AEB = 1
uint8 LANE_FOLLOW = 2
uint8 LANE_CHANGE = 3
uint8 AVOIDANCE = 4
uint8 STOP = 5
uint8 PARKING = 6
uint8 EMERGENCY = 7
uint8 FINISH = 8
uint8 ACC = 9
uint8 BUMP = 10
uint8 INTERSECTION = 11
uint8 TRAFFIC_LIGHT_RED = 12
uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT = 13
uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT = 14
uint8 CURVE = 15
uint8 SPEEDUP = 16
uint8 DestinationWaypoints = 17
uint8 DestinationGlobalPath = 18


int32 obj_id
bool obstacles
bool avoidance

")



(provide :itri_msgs/BehaviorState "b7ef9dd36a2ceb7fe32edd273643bca2")


