;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::LineParm)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'LineParm (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LINEPARM")
  (make-package "ITRI_MSGS::LINEPARM"))

(in-package "ROS")
;;//! \htmlinclude LineParm.msg.html


(defclass itri_msgs::LineParm
  :super ros::object
  :slots (_parm0 _parm1 _parm2 _confidentScore _frameIdx ))

(defmethod itri_msgs::LineParm
  (:init
   (&key
    ((:parm0 __parm0) 0.0)
    ((:parm1 __parm1) 0.0)
    ((:parm2 __parm2) 0.0)
    ((:confidentScore __confidentScore) 0)
    ((:frameIdx __frameIdx) 0)
    )
   (send-super :init)
   (setq _parm0 (float __parm0))
   (setq _parm1 (float __parm1))
   (setq _parm2 (float __parm2))
   (setq _confidentScore (round __confidentScore))
   (setq _frameIdx (round __frameIdx))
   self)
  (:parm0
   (&optional __parm0)
   (if __parm0 (setq _parm0 __parm0)) _parm0)
  (:parm1
   (&optional __parm1)
   (if __parm1 (setq _parm1 __parm1)) _parm1)
  (:parm2
   (&optional __parm2)
   (if __parm2 (setq _parm2 __parm2)) _parm2)
  (:confidentScore
   (&optional __confidentScore)
   (if __confidentScore (setq _confidentScore __confidentScore)) _confidentScore)
  (:frameIdx
   (&optional __frameIdx)
   (if __frameIdx (setq _frameIdx __frameIdx)) _frameIdx)
  (:serialization-length
   ()
   (+
    ;; float32 _parm0
    4
    ;; float32 _parm1
    4
    ;; float32 _parm2
    4
    ;; uint16 _confidentScore
    2
    ;; uint16 _frameIdx
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _parm0
       (sys::poke _parm0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _parm1
       (sys::poke _parm1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _parm2
       (sys::poke _parm2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint16 _confidentScore
       (write-word _confidentScore s)
     ;; uint16 _frameIdx
       (write-word _frameIdx s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _parm0
     (setq _parm0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _parm1
     (setq _parm1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _parm2
     (setq _parm2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint16 _confidentScore
     (setq _confidentScore (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _frameIdx
     (setq _frameIdx (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get itri_msgs::LineParm :md5sum-) "4ba0e2d1442ddcc8696bcf7cb4f9b46e")
(setf (get itri_msgs::LineParm :datatype-) "itri_msgs/LineParm")
(setf (get itri_msgs::LineParm :definition-)
      "float32 parm0
float32 parm1
float32 parm2
uint16 confidentScore
uint16 frameIdx

")



(provide :itri_msgs/LineParm "4ba0e2d1442ddcc8696bcf7cb4f9b46e")


