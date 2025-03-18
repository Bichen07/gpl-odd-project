;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ExceptionMission)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ExceptionMission (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::EXCEPTIONMISSION")
  (make-package "ITRI_MSGS::EXCEPTIONMISSION"))

(in-package "ROS")
;;//! \htmlinclude ExceptionMission.msg.html


(defclass itri_msgs::ExceptionMission
  :super ros::object
  :slots (_exception_event _request _mission ))

(defmethod itri_msgs::ExceptionMission
  (:init
   (&key
    ((:exception_event __exception_event) (instance itri_msgs::ExceptionEvent :init))
    ((:request __request) (instance itri_msgs::RequestState :init))
    ((:mission __mission) (instance itri_msgs::MissionStatus :init))
    )
   (send-super :init)
   (setq _exception_event __exception_event)
   (setq _request __request)
   (setq _mission __mission)
   self)
  (:exception_event
   (&rest __exception_event)
   (if (keywordp (car __exception_event))
       (send* _exception_event __exception_event)
     (progn
       (if __exception_event (setq _exception_event (car __exception_event)))
       _exception_event)))
  (:request
   (&rest __request)
   (if (keywordp (car __request))
       (send* _request __request)
     (progn
       (if __request (setq _request (car __request)))
       _request)))
  (:mission
   (&rest __mission)
   (if (keywordp (car __mission))
       (send* _mission __mission)
     (progn
       (if __mission (setq _mission (car __mission)))
       _mission)))
  (:serialization-length
   ()
   (+
    ;; itri_msgs/ExceptionEvent _exception_event
    (send _exception_event :serialization-length)
    ;; itri_msgs/RequestState _request
    (send _request :serialization-length)
    ;; itri_msgs/MissionStatus _mission
    (send _mission :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; itri_msgs/ExceptionEvent _exception_event
       (send _exception_event :serialize s)
     ;; itri_msgs/RequestState _request
       (send _request :serialize s)
     ;; itri_msgs/MissionStatus _mission
       (send _mission :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; itri_msgs/ExceptionEvent _exception_event
     (send _exception_event :deserialize buf ptr-) (incf ptr- (send _exception_event :serialization-length))
   ;; itri_msgs/RequestState _request
     (send _request :deserialize buf ptr-) (incf ptr- (send _request :serialization-length))
   ;; itri_msgs/MissionStatus _mission
     (send _mission :deserialize buf ptr-) (incf ptr- (send _mission :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::ExceptionMission :md5sum-) "0471831326b1596371ad11eb9cb10158")
(setf (get itri_msgs::ExceptionMission :datatype-) "itri_msgs/ExceptionMission")
(setf (get itri_msgs::ExceptionMission :definition-)
      "ExceptionEvent exception_event
RequestState request
MissionStatus mission

================================================================================
MSG: itri_msgs/ExceptionEvent
# exception event
uint8 NORMAL = 0
uint8 HARD_BRAKE = 1
uint8 MILD_BRAKE = 2
uint8 DETOUR     = 3
uint8 PULL_OVER  = 4
uint8 TIME_OUT  = 5

uint32 event

================================================================================
MSG: itri_msgs/RequestState
# exception request_state
uint8 NORMAL = 0
uint8 REQUEST = 1
uint8 RESUME = 2

uint8 state

================================================================================
MSG: itri_msgs/MissionStatus
# exception misssion status
uint8 NORMAL = 0
uint8 EXECUTION = 1
uint8 COMPLETED = 2
uint8 REQUEST = 3

uint8 status

")



(provide :itri_msgs/ExceptionMission "0471831326b1596371ad11eb9cb10158")


