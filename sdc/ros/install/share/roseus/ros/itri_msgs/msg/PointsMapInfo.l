;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PointsMapInfo)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PointsMapInfo (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::POINTSMAPINFO")
  (make-package "ITRI_MSGS::POINTSMAPINFO"))

(in-package "ROS")
;;//! \htmlinclude PointsMapInfo.msg.html


(defclass itri_msgs::PointsMapInfo
  :super ros::object
  :slots (_num_submaps _total_points _gps_reference ))

(defmethod itri_msgs::PointsMapInfo
  (:init
   (&key
    ((:num_submaps __num_submaps) 0)
    ((:total_points __total_points) 0)
    ((:gps_reference __gps_reference) (instance itri_msgs::GPS :init))
    )
   (send-super :init)
   (setq _num_submaps (round __num_submaps))
   (setq _total_points (round __total_points))
   (setq _gps_reference __gps_reference)
   self)
  (:num_submaps
   (&optional __num_submaps)
   (if __num_submaps (setq _num_submaps __num_submaps)) _num_submaps)
  (:total_points
   (&optional __total_points)
   (if __total_points (setq _total_points __total_points)) _total_points)
  (:gps_reference
   (&rest __gps_reference)
   (if (keywordp (car __gps_reference))
       (send* _gps_reference __gps_reference)
     (progn
       (if __gps_reference (setq _gps_reference (car __gps_reference)))
       _gps_reference)))
  (:serialization-length
   ()
   (+
    ;; uint32 _num_submaps
    4
    ;; uint32 _total_points
    4
    ;; itri_msgs/GPS _gps_reference
    (send _gps_reference :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _num_submaps
       (write-long _num_submaps s)
     ;; uint32 _total_points
       (write-long _total_points s)
     ;; itri_msgs/GPS _gps_reference
       (send _gps_reference :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _num_submaps
     (setq _num_submaps (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _total_points
     (setq _total_points (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; itri_msgs/GPS _gps_reference
     (send _gps_reference :deserialize buf ptr-) (incf ptr- (send _gps_reference :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::PointsMapInfo :md5sum-) "d0f5e60c33a648ff40401f308be12589")
(setf (get itri_msgs::PointsMapInfo :datatype-) "itri_msgs/PointsMapInfo")
(setf (get itri_msgs::PointsMapInfo :definition-)
      "uint32 num_submaps
uint32 total_points
GPS gps_reference

================================================================================
MSG: itri_msgs/GPS
float64 latitude
float64 longitude
float64 altitude

")



(provide :itri_msgs/PointsMapInfo "d0f5e60c33a648ff40401f308be12589")


