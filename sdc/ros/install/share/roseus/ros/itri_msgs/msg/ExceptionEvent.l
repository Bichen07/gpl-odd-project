;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ExceptionEvent)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ExceptionEvent (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::EXCEPTIONEVENT")
  (make-package "ITRI_MSGS::EXCEPTIONEVENT"))

(in-package "ROS")
;;//! \htmlinclude ExceptionEvent.msg.html


(intern "*NORMAL*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*NORMAL* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*NORMAL* 0)
(intern "*HARD_BRAKE*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*HARD_BRAKE* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*HARD_BRAKE* 1)
(intern "*MILD_BRAKE*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*MILD_BRAKE* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*MILD_BRAKE* 2)
(intern "*DETOUR*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*DETOUR* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*DETOUR* 3)
(intern "*PULL_OVER*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*PULL_OVER* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*PULL_OVER* 4)
(intern "*TIME_OUT*" (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(shadow '*TIME_OUT* (find-package "ITRI_MSGS::EXCEPTIONEVENT"))
(defconstant itri_msgs::ExceptionEvent::*TIME_OUT* 5)
(defclass itri_msgs::ExceptionEvent
  :super ros::object
  :slots (_event ))

(defmethod itri_msgs::ExceptionEvent
  (:init
   (&key
    ((:event __event) 0)
    )
   (send-super :init)
   (setq _event (round __event))
   self)
  (:event
   (&optional __event)
   (if __event (setq _event __event)) _event)
  (:serialization-length
   ()
   (+
    ;; uint32 _event
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _event
       (write-long _event s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _event
     (setq _event (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::ExceptionEvent :md5sum-) "8fe25700fd3ceb690ea90fb4ee026e1d")
(setf (get itri_msgs::ExceptionEvent :datatype-) "itri_msgs/ExceptionEvent")
(setf (get itri_msgs::ExceptionEvent :definition-)
      "# exception event
uint8 NORMAL = 0
uint8 HARD_BRAKE = 1
uint8 MILD_BRAKE = 2
uint8 DETOUR     = 3
uint8 PULL_OVER  = 4
uint8 TIME_OUT  = 5

uint32 event

")



(provide :itri_msgs/ExceptionEvent "8fe25700fd3ceb690ea90fb4ee026e1d")


