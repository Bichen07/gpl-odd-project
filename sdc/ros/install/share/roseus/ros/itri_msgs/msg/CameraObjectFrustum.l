;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::CameraObjectFrustum)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'CameraObjectFrustum (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::CAMERAOBJECTFRUSTUM")
  (make-package "ITRI_MSGS::CAMERAOBJECTFRUSTUM"))

(in-package "ROS")
;;//! \htmlinclude CameraObjectFrustum.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass itri_msgs::CameraObjectFrustum
  :super ros::object
  :slots (_Points _FaceInsidePlanesNorm ))

(defmethod itri_msgs::CameraObjectFrustum
  (:init
   (&key
    ((:Points __Points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:FaceInsidePlanesNorm __FaceInsidePlanesNorm) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Quaternion :init) r)) r))
    )
   (send-super :init)
   (setq _Points __Points)
   (setq _FaceInsidePlanesNorm __FaceInsidePlanesNorm)
   self)
  (:Points
   (&rest __Points)
   (if (keywordp (car __Points))
       (send* _Points __Points)
     (progn
       (if __Points (setq _Points (car __Points)))
       _Points)))
  (:FaceInsidePlanesNorm
   (&rest __FaceInsidePlanesNorm)
   (if (keywordp (car __FaceInsidePlanesNorm))
       (send* _FaceInsidePlanesNorm __FaceInsidePlanesNorm)
     (progn
       (if __FaceInsidePlanesNorm (setq _FaceInsidePlanesNorm (car __FaceInsidePlanesNorm)))
       _FaceInsidePlanesNorm)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point[] _Points
    (apply #'+ (send-all _Points :serialization-length)) 4
    ;; geometry_msgs/Quaternion[] _FaceInsidePlanesNorm
    (apply #'+ (send-all _FaceInsidePlanesNorm :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point[] _Points
     (write-long (length _Points) s)
     (dolist (elem _Points)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Quaternion[] _FaceInsidePlanesNorm
     (write-long (length _FaceInsidePlanesNorm) s)
     (dolist (elem _FaceInsidePlanesNorm)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point[] _Points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _Points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _Points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Quaternion[] _FaceInsidePlanesNorm
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _FaceInsidePlanesNorm (let (r) (dotimes (i n) (push (instance geometry_msgs::Quaternion :init) r)) r))
     (dolist (elem- _FaceInsidePlanesNorm)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::CameraObjectFrustum :md5sum-) "be09e2784edfc92465e8db4d441a3c5b")
(setf (get itri_msgs::CameraObjectFrustum :datatype-) "itri_msgs/CameraObjectFrustum")
(setf (get itri_msgs::CameraObjectFrustum :definition-)
      "geometry_msgs/Point[] Points
geometry_msgs/Quaternion[] FaceInsidePlanesNorm
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :itri_msgs/CameraObjectFrustum "be09e2784edfc92465e8db4d441a3c5b")


