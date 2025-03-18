;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PathSegment)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PathSegment (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PATHSEGMENT")
  (make-package "ITRI_MSGS::PATHSEGMENT"))

(in-package "ROS")
;;//! \htmlinclude PathSegment.msg.html


(defclass itri_msgs::PathSegment
  :super ros::object
  :slots (_laneId _startPoint _endPoint ))

(defmethod itri_msgs::PathSegment
  (:init
   (&key
    ((:laneId __laneId) 0)
    ((:startPoint __startPoint) 0)
    ((:endPoint __endPoint) 0)
    )
   (send-super :init)
   (setq _laneId (round __laneId))
   (setq _startPoint (round __startPoint))
   (setq _endPoint (round __endPoint))
   self)
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:startPoint
   (&optional __startPoint)
   (if __startPoint (setq _startPoint __startPoint)) _startPoint)
  (:endPoint
   (&optional __endPoint)
   (if __endPoint (setq _endPoint __endPoint)) _endPoint)
  (:serialization-length
   ()
   (+
    ;; int32 _laneId
    4
    ;; int32 _startPoint
    4
    ;; int32 _endPoint
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32 _startPoint
       (write-long _startPoint s)
     ;; int32 _endPoint
       (write-long _endPoint s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _startPoint
     (setq _startPoint (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _endPoint
     (setq _endPoint (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::PathSegment :md5sum-) "6ef80e49d1cec715d0fab363071a33fa")
(setf (get itri_msgs::PathSegment :datatype-) "itri_msgs/PathSegment")
(setf (get itri_msgs::PathSegment :definition-)
      "int32 laneId
int32 startPoint
int32 endPoint
")



(provide :itri_msgs/PathSegment "6ef80e49d1cec715d0fab363071a33fa")


