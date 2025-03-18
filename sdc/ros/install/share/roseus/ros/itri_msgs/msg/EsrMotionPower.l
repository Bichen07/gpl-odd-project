;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EsrMotionPower)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EsrMotionPower (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ESRMOTIONPOWER")
  (make-package "ITRI_MSGS::ESRMOTIONPOWER"))

(in-package "ROS")
;;//! \htmlinclude EsrMotionPower.msg.html


(defclass itri_msgs::EsrMotionPower
  :super ros::object
  :slots (_track_moving _track_movable_fast _track_movable_slow _track_power ))

(defmethod itri_msgs::EsrMotionPower
  (:init
   (&key
    ((:track_moving __track_moving) nil)
    ((:track_movable_fast __track_movable_fast) nil)
    ((:track_movable_slow __track_movable_slow) nil)
    ((:track_power __track_power) 0)
    )
   (send-super :init)
   (setq _track_moving __track_moving)
   (setq _track_movable_fast __track_movable_fast)
   (setq _track_movable_slow __track_movable_slow)
   (setq _track_power (round __track_power))
   self)
  (:track_moving
   (&optional __track_moving)
   (if __track_moving (setq _track_moving __track_moving)) _track_moving)
  (:track_movable_fast
   (&optional __track_movable_fast)
   (if __track_movable_fast (setq _track_movable_fast __track_movable_fast)) _track_movable_fast)
  (:track_movable_slow
   (&optional __track_movable_slow)
   (if __track_movable_slow (setq _track_movable_slow __track_movable_slow)) _track_movable_slow)
  (:track_power
   (&optional __track_power)
   (if __track_power (setq _track_power __track_power)) _track_power)
  (:serialization-length
   ()
   (+
    ;; bool _track_moving
    1
    ;; bool _track_movable_fast
    1
    ;; bool _track_movable_slow
    1
    ;; int16 _track_power
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _track_moving
       (if _track_moving (write-byte -1 s) (write-byte 0 s))
     ;; bool _track_movable_fast
       (if _track_movable_fast (write-byte -1 s) (write-byte 0 s))
     ;; bool _track_movable_slow
       (if _track_movable_slow (write-byte -1 s) (write-byte 0 s))
     ;; int16 _track_power
       (write-word _track_power s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _track_moving
     (setq _track_moving (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _track_movable_fast
     (setq _track_movable_fast (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _track_movable_slow
     (setq _track_movable_slow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int16 _track_power
     (setq _track_power (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get itri_msgs::EsrMotionPower :md5sum-) "adcd31c77e7090178d8bc4c127ff383f")
(setf (get itri_msgs::EsrMotionPower :datatype-) "itri_msgs/EsrMotionPower")
(setf (get itri_msgs::EsrMotionPower :definition-)
      "bool track_moving
bool track_movable_fast
bool track_movable_slow
int16 track_power

")



(provide :itri_msgs/EsrMotionPower "adcd31c77e7090178d8bc4c127ff383f")


