;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PredictedPath)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PredictedPath (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PREDICTEDPATH")
  (make-package "ITRI_MSGS::PREDICTEDPATH"))

(in-package "ROS")
;;//! \htmlinclude PredictedPath.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass itri_msgs::PredictedPath
  :super ros::object
  :slots (_probability _predicted_path _predicted_velocity ))

(defmethod itri_msgs::PredictedPath
  (:init
   (&key
    ((:probability __probability) 0.0)
    ((:predicted_path __predicted_path) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:predicted_velocity __predicted_velocity) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _probability (float __probability))
   (setq _predicted_path __predicted_path)
   (setq _predicted_velocity __predicted_velocity)
   self)
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:predicted_path
   (&rest __predicted_path)
   (if (keywordp (car __predicted_path))
       (send* _predicted_path __predicted_path)
     (progn
       (if __predicted_path (setq _predicted_path (car __predicted_path)))
       _predicted_path)))
  (:predicted_velocity
   (&rest __predicted_velocity)
   (if (keywordp (car __predicted_velocity))
       (send* _predicted_velocity __predicted_velocity)
     (progn
       (if __predicted_velocity (setq _predicted_velocity (car __predicted_velocity)))
       _predicted_velocity)))
  (:serialization-length
   ()
   (+
    ;; float32 _probability
    4
    ;; geometry_msgs/Point[] _predicted_path
    (apply #'+ (send-all _predicted_path :serialization-length)) 4
    ;; geometry_msgs/Point[] _predicted_velocity
    (apply #'+ (send-all _predicted_velocity :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _probability
       (sys::poke _probability (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Point[] _predicted_path
     (write-long (length _predicted_path) s)
     (dolist (elem _predicted_path)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _predicted_velocity
     (write-long (length _predicted_velocity) s)
     (dolist (elem _predicted_velocity)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _probability
     (setq _probability (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _predicted_path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_path (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _predicted_path)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _predicted_velocity
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_velocity (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _predicted_velocity)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::PredictedPath :md5sum-) "46863c23a206bf9673e0a4bf16fae636")
(setf (get itri_msgs::PredictedPath :datatype-) "itri_msgs/PredictedPath")
(setf (get itri_msgs::PredictedPath :definition-)
      "float32 probability
geometry_msgs/Point[] predicted_path
geometry_msgs/Point[] predicted_velocity

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :itri_msgs/PredictedPath "46863c23a206bf9673e0a4bf16fae636")


