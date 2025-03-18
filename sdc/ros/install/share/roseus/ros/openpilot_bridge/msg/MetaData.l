;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::MetaData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'MetaData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::METADATA")
  (make-package "OPENPILOT_BRIDGE::METADATA"))

(in-package "ROS")
;;//! \htmlinclude MetaData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::MetaData
  :super ros::object
  :slots (_header _gasDisengageProb _brakeDisengageProb _steerOverrideProb _engagedProb _desirePrediction ))

(defmethod openpilot_bridge::MetaData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gasDisengageProb __gasDisengageProb) 0.0)
    ((:brakeDisengageProb __brakeDisengageProb) 0.0)
    ((:steerOverrideProb __steerOverrideProb) 0.0)
    ((:engagedProb __engagedProb) 0.0)
    ((:desirePrediction __desirePrediction) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _gasDisengageProb (float __gasDisengageProb))
   (setq _brakeDisengageProb (float __brakeDisengageProb))
   (setq _steerOverrideProb (float __steerOverrideProb))
   (setq _engagedProb (float __engagedProb))
   (setq _desirePrediction __desirePrediction)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gasDisengageProb
   (&optional __gasDisengageProb)
   (if __gasDisengageProb (setq _gasDisengageProb __gasDisengageProb)) _gasDisengageProb)
  (:brakeDisengageProb
   (&optional __brakeDisengageProb)
   (if __brakeDisengageProb (setq _brakeDisengageProb __brakeDisengageProb)) _brakeDisengageProb)
  (:steerOverrideProb
   (&optional __steerOverrideProb)
   (if __steerOverrideProb (setq _steerOverrideProb __steerOverrideProb)) _steerOverrideProb)
  (:engagedProb
   (&optional __engagedProb)
   (if __engagedProb (setq _engagedProb __engagedProb)) _engagedProb)
  (:desirePrediction
   (&optional __desirePrediction)
   (if __desirePrediction (setq _desirePrediction __desirePrediction)) _desirePrediction)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _gasDisengageProb
    4
    ;; float32 _brakeDisengageProb
    4
    ;; float32 _steerOverrideProb
    4
    ;; float32 _engagedProb
    4
    ;; float32[] _desirePrediction
    (* 4    (length _desirePrediction)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _gasDisengageProb
       (sys::poke _gasDisengageProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _brakeDisengageProb
       (sys::poke _brakeDisengageProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerOverrideProb
       (sys::poke _steerOverrideProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _engagedProb
       (sys::poke _engagedProb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _desirePrediction
     (write-long (length _desirePrediction) s)
     (dotimes (i (length _desirePrediction))
       (sys::poke (elt _desirePrediction i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _gasDisengageProb
     (setq _gasDisengageProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _brakeDisengageProb
     (setq _brakeDisengageProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerOverrideProb
     (setq _steerOverrideProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _engagedProb
     (setq _engagedProb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _desirePrediction
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _desirePrediction (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _desirePrediction i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::MetaData :md5sum-) "edac01773b36419f37d774b07e331e9b")
(setf (get openpilot_bridge::MetaData :datatype-) "openpilot_bridge/MetaData")
(setf (get openpilot_bridge::MetaData :definition-)
      "Header header

float32 gasDisengageProb
float32 brakeDisengageProb
float32 steerOverrideProb
float32 engagedProb
float32[] desirePrediction

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



(provide :openpilot_bridge/MetaData "edac01773b36419f37d774b07e331e9b")


