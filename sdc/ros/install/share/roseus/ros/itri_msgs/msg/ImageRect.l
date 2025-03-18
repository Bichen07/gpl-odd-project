;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ImageRect)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ImageRect (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::IMAGERECT")
  (make-package "ITRI_MSGS::IMAGERECT"))

(in-package "ROS")
;;//! \htmlinclude ImageRect.msg.html


(defclass itri_msgs::ImageRect
  :super ros::object
  :slots (_id _x _y _height _width _score _cls ))

(defmethod itri_msgs::ImageRect
  (:init
   (&key
    ((:id __id) 0)
    ((:x __x) 0)
    ((:y __y) 0)
    ((:height __height) 0)
    ((:width __width) 0)
    ((:score __score) 0.0)
    ((:cls __cls) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _score (float __score))
   (setq _cls (string __cls))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
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
  (:cls
   (&optional __cls)
   (if __cls (setq _cls __cls)) _cls)
  (:serialization-length
   ()
   (+
    ;; int32 _id
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
    ;; string _cls
    4 (length _cls)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
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
     ;; string _cls
       (write-long (length _cls) s) (princ _cls s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
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
   ;; string _cls
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _cls (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get itri_msgs::ImageRect :md5sum-) "279d2c9dbb561ef4b61466e7dd7c6e45")
(setf (get itri_msgs::ImageRect :datatype-) "itri_msgs/ImageRect")
(setf (get itri_msgs::ImageRect :definition-)
      "int32 id
int32 x
int32 y
int32 height
int32 width
float32 score
string cls

")



(provide :itri_msgs/ImageRect "279d2c9dbb561ef4b61466e7dd7c6e45")


