;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::CameraObjectAnalysis)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'CameraObjectAnalysis (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::CAMERAOBJECTANALYSIS")
  (make-package "ITRI_MSGS::CAMERAOBJECTANALYSIS"))

(in-package "ROS")
;;//! \htmlinclude CameraObjectAnalysis.msg.html


(defclass itri_msgs::CameraObjectAnalysis
  :super ros::object
  :slots (_id _center_distance _diou ))

(defmethod itri_msgs::CameraObjectAnalysis
  (:init
   (&key
    ((:id __id) 0)
    ((:center_distance __center_distance) 0.0)
    ((:diou __diou) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _center_distance (float __center_distance))
   (setq _diou (float __diou))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:center_distance
   (&optional __center_distance)
   (if __center_distance (setq _center_distance __center_distance)) _center_distance)
  (:diou
   (&optional __diou)
   (if __diou (setq _diou __diou)) _diou)
  (:serialization-length
   ()
   (+
    ;; uint32 _id
    4
    ;; float32 _center_distance
    4
    ;; float32 _diou
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _id
       (write-long _id s)
     ;; float32 _center_distance
       (sys::poke _center_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _diou
       (sys::poke _diou (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _center_distance
     (setq _center_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _diou
     (setq _diou (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::CameraObjectAnalysis :md5sum-) "ced6441f7a38e34baaa1c710d22e6e89")
(setf (get itri_msgs::CameraObjectAnalysis :datatype-) "itri_msgs/CameraObjectAnalysis")
(setf (get itri_msgs::CameraObjectAnalysis :definition-)
      "uint32 id
float32 center_distance
float32 diou

")



(provide :itri_msgs/CameraObjectAnalysis "ced6441f7a38e34baaa1c710d22e6e89")


