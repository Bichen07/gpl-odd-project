;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ParkingInfo)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ParkingInfo (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PARKINGINFO")
  (make-package "ITRI_MSGS::PARKINGINFO"))

(in-package "ROS")
;;//! \htmlinclude ParkingInfo.msg.html


(defclass itri_msgs::ParkingInfo
  :super ros::object
  :slots (_totalParkingPathCount _currentPathNumber ))

(defmethod itri_msgs::ParkingInfo
  (:init
   (&key
    ((:totalParkingPathCount __totalParkingPathCount) 0)
    ((:currentPathNumber __currentPathNumber) 0)
    )
   (send-super :init)
   (setq _totalParkingPathCount (round __totalParkingPathCount))
   (setq _currentPathNumber (round __currentPathNumber))
   self)
  (:totalParkingPathCount
   (&optional __totalParkingPathCount)
   (if __totalParkingPathCount (setq _totalParkingPathCount __totalParkingPathCount)) _totalParkingPathCount)
  (:currentPathNumber
   (&optional __currentPathNumber)
   (if __currentPathNumber (setq _currentPathNumber __currentPathNumber)) _currentPathNumber)
  (:serialization-length
   ()
   (+
    ;; int32 _totalParkingPathCount
    4
    ;; int32 _currentPathNumber
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _totalParkingPathCount
       (write-long _totalParkingPathCount s)
     ;; int32 _currentPathNumber
       (write-long _currentPathNumber s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _totalParkingPathCount
     (setq _totalParkingPathCount (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _currentPathNumber
     (setq _currentPathNumber (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::ParkingInfo :md5sum-) "4ee64eeb93cd6229d15145ec3ca31a85")
(setf (get itri_msgs::ParkingInfo :datatype-) "itri_msgs/ParkingInfo")
(setf (get itri_msgs::ParkingInfo :definition-)
      "int32 totalParkingPathCount
int32 currentPathNumber
")



(provide :itri_msgs/ParkingInfo "4ee64eeb93cd6229d15145ec3ca31a85")


