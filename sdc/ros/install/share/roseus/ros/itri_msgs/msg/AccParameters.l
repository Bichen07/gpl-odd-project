;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::AccParameters)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'AccParameters (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ACCPARAMETERS")
  (make-package "ITRI_MSGS::ACCPARAMETERS"))

(in-package "ROS")
;;//! \htmlinclude AccParameters.msg.html


(defclass itri_msgs::AccParameters
  :super ros::object
  :slots (_Kp _Ki _Kd _velocitySetpoint _distanceSetpoint ))

(defmethod itri_msgs::AccParameters
  (:init
   (&key
    ((:Kp __Kp) 0.0)
    ((:Ki __Ki) 0.0)
    ((:Kd __Kd) 0.0)
    ((:velocitySetpoint __velocitySetpoint) 0.0)
    ((:distanceSetpoint __distanceSetpoint) 0.0)
    )
   (send-super :init)
   (setq _Kp (float __Kp))
   (setq _Ki (float __Ki))
   (setq _Kd (float __Kd))
   (setq _velocitySetpoint (float __velocitySetpoint))
   (setq _distanceSetpoint (float __distanceSetpoint))
   self)
  (:Kp
   (&optional __Kp)
   (if __Kp (setq _Kp __Kp)) _Kp)
  (:Ki
   (&optional __Ki)
   (if __Ki (setq _Ki __Ki)) _Ki)
  (:Kd
   (&optional __Kd)
   (if __Kd (setq _Kd __Kd)) _Kd)
  (:velocitySetpoint
   (&optional __velocitySetpoint)
   (if __velocitySetpoint (setq _velocitySetpoint __velocitySetpoint)) _velocitySetpoint)
  (:distanceSetpoint
   (&optional __distanceSetpoint)
   (if __distanceSetpoint (setq _distanceSetpoint __distanceSetpoint)) _distanceSetpoint)
  (:serialization-length
   ()
   (+
    ;; float32 _Kp
    4
    ;; float32 _Ki
    4
    ;; float32 _Kd
    4
    ;; float32 _velocitySetpoint
    4
    ;; float32 _distanceSetpoint
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _Kp
       (sys::poke _Kp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Ki
       (sys::poke _Ki (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Kd
       (sys::poke _Kd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _velocitySetpoint
       (sys::poke _velocitySetpoint (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distanceSetpoint
       (sys::poke _distanceSetpoint (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _Kp
     (setq _Kp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Ki
     (setq _Ki (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Kd
     (setq _Kd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _velocitySetpoint
     (setq _velocitySetpoint (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distanceSetpoint
     (setq _distanceSetpoint (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::AccParameters :md5sum-) "5eeae744c2e67ea25e37fe82a1c8dd42")
(setf (get itri_msgs::AccParameters :datatype-) "itri_msgs/AccParameters")
(setf (get itri_msgs::AccParameters :definition-)
      "float32 Kp
float32 Ki
float32 Kd
float32 velocitySetpoint
float32 distanceSetpoint


")



(provide :itri_msgs/AccParameters "5eeae744c2e67ea25e37fe82a1c8dd42")


