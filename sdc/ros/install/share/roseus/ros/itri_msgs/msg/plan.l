;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::plan)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'plan (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PLAN")
  (make-package "ITRI_MSGS::PLAN"))

(in-package "ROS")
;;//! \htmlinclude plan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*OA*" (find-package "ITRI_MSGS::PLAN"))
(shadow '*OA* (find-package "ITRI_MSGS::PLAN"))
(defconstant itri_msgs::plan::*OA* 0)
(intern "*BUS*" (find-package "ITRI_MSGS::PLAN"))
(shadow '*BUS* (find-package "ITRI_MSGS::PLAN"))
(defconstant itri_msgs::plan::*BUS* 1)
(intern "*PARKING*" (find-package "ITRI_MSGS::PLAN"))
(shadow '*PARKING* (find-package "ITRI_MSGS::PLAN"))
(defconstant itri_msgs::plan::*PARKING* 2)
(intern "*LC*" (find-package "ITRI_MSGS::PLAN"))
(shadow '*LC* (find-package "ITRI_MSGS::PLAN"))
(defconstant itri_msgs::plan::*LC* 3)
(defclass itri_msgs::plan
  :super ros::object
  :slots (_header _bias _bias_rate _safe_distance _parking_start _type ))

(defmethod itri_msgs::plan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:bias __bias) 0.0)
    ((:bias_rate __bias_rate) 0.0)
    ((:safe_distance __safe_distance) 0.0)
    ((:parking_start __parking_start) nil)
    ((:type __type) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _bias (float __bias))
   (setq _bias_rate (float __bias_rate))
   (setq _safe_distance (float __safe_distance))
   (setq _parking_start __parking_start)
   (setq _type (round __type))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:bias
   (&optional __bias)
   (if __bias (setq _bias __bias)) _bias)
  (:bias_rate
   (&optional __bias_rate)
   (if __bias_rate (setq _bias_rate __bias_rate)) _bias_rate)
  (:safe_distance
   (&optional __safe_distance)
   (if __safe_distance (setq _safe_distance __safe_distance)) _safe_distance)
  (:parking_start
   (&optional __parking_start)
   (if __parking_start (setq _parking_start __parking_start)) _parking_start)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _bias
    4
    ;; float32 _bias_rate
    4
    ;; float32 _safe_distance
    4
    ;; bool _parking_start
    1
    ;; uint8 _type
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _bias
       (sys::poke _bias (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _bias_rate
       (sys::poke _bias_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _safe_distance
       (sys::poke _safe_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _parking_start
       (if _parking_start (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _type
       (write-byte _type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _bias
     (setq _bias (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _bias_rate
     (setq _bias_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _safe_distance
     (setq _safe_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _parking_start
     (setq _parking_start (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::plan :md5sum-) "4efb8b16e81fe1d48cfd91a5f58116e1")
(setf (get itri_msgs::plan :datatype-) "itri_msgs/plan")
(setf (get itri_msgs::plan :definition-)
      "Header header
float32 bias
float32 bias_rate
float32 safe_distance
bool parking_start

uint8 OA = 0
uint8 BUS = 1
uint8 PARKING = 2
uint8 LC = 3
uint8 type

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :itri_msgs/plan "4efb8b16e81fe1d48cfd91a5f58116e1")


