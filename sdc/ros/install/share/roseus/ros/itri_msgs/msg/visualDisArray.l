;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::visualDisArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'visualDisArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::VISUALDISARRAY")
  (make-package "ITRI_MSGS::VISUALDISARRAY"))

(in-package "ROS")
;;//! \htmlinclude visualDisArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::visualDisArray
  :super ros::object
  :slots (_header _carDis _busDis _truckDis _bicycleDis _motorbikeDis _personDis ))

(defmethod itri_msgs::visualDisArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:carDis __carDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    ((:busDis __busDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    ((:truckDis __truckDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    ((:bicycleDis __bicycleDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    ((:motorbikeDis __motorbikeDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    ((:personDis __personDis) (let (r) (dotimes (i 0) (push (instance itri_msgs::visualDis :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _carDis __carDis)
   (setq _busDis __busDis)
   (setq _truckDis __truckDis)
   (setq _bicycleDis __bicycleDis)
   (setq _motorbikeDis __motorbikeDis)
   (setq _personDis __personDis)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:carDis
   (&rest __carDis)
   (if (keywordp (car __carDis))
       (send* _carDis __carDis)
     (progn
       (if __carDis (setq _carDis (car __carDis)))
       _carDis)))
  (:busDis
   (&rest __busDis)
   (if (keywordp (car __busDis))
       (send* _busDis __busDis)
     (progn
       (if __busDis (setq _busDis (car __busDis)))
       _busDis)))
  (:truckDis
   (&rest __truckDis)
   (if (keywordp (car __truckDis))
       (send* _truckDis __truckDis)
     (progn
       (if __truckDis (setq _truckDis (car __truckDis)))
       _truckDis)))
  (:bicycleDis
   (&rest __bicycleDis)
   (if (keywordp (car __bicycleDis))
       (send* _bicycleDis __bicycleDis)
     (progn
       (if __bicycleDis (setq _bicycleDis (car __bicycleDis)))
       _bicycleDis)))
  (:motorbikeDis
   (&rest __motorbikeDis)
   (if (keywordp (car __motorbikeDis))
       (send* _motorbikeDis __motorbikeDis)
     (progn
       (if __motorbikeDis (setq _motorbikeDis (car __motorbikeDis)))
       _motorbikeDis)))
  (:personDis
   (&rest __personDis)
   (if (keywordp (car __personDis))
       (send* _personDis __personDis)
     (progn
       (if __personDis (setq _personDis (car __personDis)))
       _personDis)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/visualDis[] _carDis
    (apply #'+ (send-all _carDis :serialization-length)) 4
    ;; itri_msgs/visualDis[] _busDis
    (apply #'+ (send-all _busDis :serialization-length)) 4
    ;; itri_msgs/visualDis[] _truckDis
    (apply #'+ (send-all _truckDis :serialization-length)) 4
    ;; itri_msgs/visualDis[] _bicycleDis
    (apply #'+ (send-all _bicycleDis :serialization-length)) 4
    ;; itri_msgs/visualDis[] _motorbikeDis
    (apply #'+ (send-all _motorbikeDis :serialization-length)) 4
    ;; itri_msgs/visualDis[] _personDis
    (apply #'+ (send-all _personDis :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/visualDis[] _carDis
     (write-long (length _carDis) s)
     (dolist (elem _carDis)
       (send elem :serialize s)
       )
     ;; itri_msgs/visualDis[] _busDis
     (write-long (length _busDis) s)
     (dolist (elem _busDis)
       (send elem :serialize s)
       )
     ;; itri_msgs/visualDis[] _truckDis
     (write-long (length _truckDis) s)
     (dolist (elem _truckDis)
       (send elem :serialize s)
       )
     ;; itri_msgs/visualDis[] _bicycleDis
     (write-long (length _bicycleDis) s)
     (dolist (elem _bicycleDis)
       (send elem :serialize s)
       )
     ;; itri_msgs/visualDis[] _motorbikeDis
     (write-long (length _motorbikeDis) s)
     (dolist (elem _motorbikeDis)
       (send elem :serialize s)
       )
     ;; itri_msgs/visualDis[] _personDis
     (write-long (length _personDis) s)
     (dolist (elem _personDis)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/visualDis[] _carDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _carDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _carDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/visualDis[] _busDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _busDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _busDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/visualDis[] _truckDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _truckDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _truckDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/visualDis[] _bicycleDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _bicycleDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _bicycleDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/visualDis[] _motorbikeDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _motorbikeDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _motorbikeDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/visualDis[] _personDis
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _personDis (let (r) (dotimes (i n) (push (instance itri_msgs::visualDis :init) r)) r))
     (dolist (elem- _personDis)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::visualDisArray :md5sum-) "e2e9c59e0f49a1e406fa51abca933f4d")
(setf (get itri_msgs::visualDisArray :datatype-) "itri_msgs/visualDisArray")
(setf (get itri_msgs::visualDisArray :definition-)
      "Header header
visualDis[] carDis
visualDis[] busDis
visualDis[] truckDis
visualDis[] bicycleDis
visualDis[] motorbikeDis
visualDis[] personDis

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

================================================================================
MSG: itri_msgs/visualDis
int32 realDis_x
int32 realDis_y
int32 x
int32 y
int32 height
int32 width
float32 score

")



(provide :itri_msgs/visualDisArray "e2e9c59e0f49a1e406fa51abca933f4d")


