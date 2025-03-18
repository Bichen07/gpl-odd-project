;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::PathData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'PathData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PATHDATA")
  (make-package "OPENPILOT_BRIDGE::PATHDATA"))

(in-package "ROS")
;;//! \htmlinclude PathData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::PathData
  :super ros::object
  :slots (_header _std _poly _points _prob _stds ))

(defmethod openpilot_bridge::PathData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:std __std) 0.0)
    ((:poly __poly) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:points __points) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:prob __prob) 0.0)
    ((:stds __stds) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _std (float __std))
   (setq _poly __poly)
   (setq _points __points)
   (setq _prob (float __prob))
   (setq _stds __stds)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:std
   (&optional __std)
   (if __std (setq _std __std)) _std)
  (:poly
   (&optional __poly)
   (if __poly (setq _poly __poly)) _poly)
  (:points
   (&optional __points)
   (if __points (setq _points __points)) _points)
  (:prob
   (&optional __prob)
   (if __prob (setq _prob __prob)) _prob)
  (:stds
   (&optional __stds)
   (if __stds (setq _stds __stds)) _stds)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _std
    4
    ;; float32[] _poly
    (* 4    (length _poly)) 4
    ;; float32[] _points
    (* 4    (length _points)) 4
    ;; float32 _prob
    4
    ;; float32[] _stds
    (* 4    (length _stds)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _std
       (sys::poke _std (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _poly
     (write-long (length _poly) s)
     (dotimes (i (length _poly))
       (sys::poke (elt _poly i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _points
     (write-long (length _points) s)
     (dotimes (i (length _points))
       (sys::poke (elt _points i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _prob
       (sys::poke _prob (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _stds
     (write-long (length _stds) s)
     (dotimes (i (length _stds))
       (sys::poke (elt _stds i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _std
     (setq _std (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _poly
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _poly (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _poly i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _points i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _prob
     (setq _prob (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _stds
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _stds (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _stds i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::PathData :md5sum-) "1768c20992cd12541202687a4eee607d")
(setf (get openpilot_bridge::PathData :datatype-) "openpilot_bridge/PathData")
(setf (get openpilot_bridge::PathData :definition-)
      "Header header

float32 std
float32[] poly
float32[] points
float32 prob
float32[] stds

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



(provide :openpilot_bridge/PathData "1768c20992cd12541202687a4eee607d")


