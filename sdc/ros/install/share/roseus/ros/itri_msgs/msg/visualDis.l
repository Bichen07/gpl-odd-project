;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::visualDis)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'visualDis (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::VISUALDIS")
  (make-package "ITRI_MSGS::VISUALDIS"))

(in-package "ROS")
;;//! \htmlinclude visualDis.msg.html


(defclass itri_msgs::visualDis
  :super ros::object
  :slots (_realDis_x _realDis_y _x _y _height _width _score ))

(defmethod itri_msgs::visualDis
  (:init
   (&key
    ((:realDis_x __realDis_x) 0)
    ((:realDis_y __realDis_y) 0)
    ((:x __x) 0)
    ((:y __y) 0)
    ((:height __height) 0)
    ((:width __width) 0)
    ((:score __score) 0.0)
    )
   (send-super :init)
   (setq _realDis_x (round __realDis_x))
   (setq _realDis_y (round __realDis_y))
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _score (float __score))
   self)
  (:realDis_x
   (&optional __realDis_x)
   (if __realDis_x (setq _realDis_x __realDis_x)) _realDis_x)
  (:realDis_y
   (&optional __realDis_y)
   (if __realDis_y (setq _realDis_y __realDis_y)) _realDis_y)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:serialization-length
   ()
   (+
    ;; int32 _realDis_x
    4
    ;; int32 _realDis_y
    4
    ;; int32 _x
    4
    ;; int32 _y
    4
    ;; int32 _height
    4
    ;; int32 _width
    4
    ;; float32 _score
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _realDis_x
       (write-long _realDis_x s)
     ;; int32 _realDis_y
       (write-long _realDis_y s)
     ;; int32 _x
       (write-long _x s)
     ;; int32 _y
       (write-long _y s)
     ;; int32 _height
       (write-long _height s)
     ;; int32 _width
       (write-long _width s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _realDis_x
     (setq _realDis_x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _realDis_y
     (setq _realDis_y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _x
     (setq _x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y
     (setq _y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::visualDis :md5sum-) "1d1e3a579add3817de8a1597d76c8b8e")
(setf (get itri_msgs::visualDis :datatype-) "itri_msgs/visualDis")
(setf (get itri_msgs::visualDis :definition-)
      "int32 realDis_x
int32 realDis_y
int32 x
int32 y
int32 height
int32 width
float32 score

")



(provide :itri_msgs/visualDis "1d1e3a579add3817de8a1597d76c8b8e")


