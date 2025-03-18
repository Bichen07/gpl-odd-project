;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LiveCalibrationData)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LiveCalibrationData (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIVECALIBRATIONDATA")
  (make-package "OPENPILOT_BRIDGE::LIVECALIBRATIONDATA"))

(in-package "ROS")
;;//! \htmlinclude LiveCalibrationData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LiveCalibrationData
  :super ros::object
  :slots (_header _warpMatrix2 _warpMatrix _rpyCalib _warpMatrixBig _calCycle _extrinsicMatrix _calPerc _calStatus ))

(defmethod openpilot_bridge::LiveCalibrationData
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:warpMatrix2 __warpMatrix2) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:warpMatrix __warpMatrix) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:rpyCalib __rpyCalib) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:warpMatrixBig __warpMatrixBig) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:calCycle __calCycle) 0)
    ((:extrinsicMatrix __extrinsicMatrix) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:calPerc __calPerc) 0)
    ((:calStatus __calStatus) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _warpMatrix2 __warpMatrix2)
   (setq _warpMatrix __warpMatrix)
   (setq _rpyCalib __rpyCalib)
   (setq _warpMatrixBig __warpMatrixBig)
   (setq _calCycle (round __calCycle))
   (setq _extrinsicMatrix __extrinsicMatrix)
   (setq _calPerc (round __calPerc))
   (setq _calStatus (round __calStatus))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:warpMatrix2
   (&optional __warpMatrix2)
   (if __warpMatrix2 (setq _warpMatrix2 __warpMatrix2)) _warpMatrix2)
  (:warpMatrix
   (&optional __warpMatrix)
   (if __warpMatrix (setq _warpMatrix __warpMatrix)) _warpMatrix)
  (:rpyCalib
   (&optional __rpyCalib)
   (if __rpyCalib (setq _rpyCalib __rpyCalib)) _rpyCalib)
  (:warpMatrixBig
   (&optional __warpMatrixBig)
   (if __warpMatrixBig (setq _warpMatrixBig __warpMatrixBig)) _warpMatrixBig)
  (:calCycle
   (&optional __calCycle)
   (if __calCycle (setq _calCycle __calCycle)) _calCycle)
  (:extrinsicMatrix
   (&optional __extrinsicMatrix)
   (if __extrinsicMatrix (setq _extrinsicMatrix __extrinsicMatrix)) _extrinsicMatrix)
  (:calPerc
   (&optional __calPerc)
   (if __calPerc (setq _calPerc __calPerc)) _calPerc)
  (:calStatus
   (&optional __calStatus)
   (if __calStatus (setq _calStatus __calStatus)) _calStatus)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _warpMatrix2
    (* 4    (length _warpMatrix2)) 4
    ;; float32[] _warpMatrix
    (* 4    (length _warpMatrix)) 4
    ;; float32[] _rpyCalib
    (* 4    (length _rpyCalib)) 4
    ;; float32[] _warpMatrixBig
    (* 4    (length _warpMatrixBig)) 4
    ;; int32 _calCycle
    4
    ;; float32[] _extrinsicMatrix
    (* 4    (length _extrinsicMatrix)) 4
    ;; int32 _calPerc
    4
    ;; int32 _calStatus
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _warpMatrix2
     (write-long (length _warpMatrix2) s)
     (dotimes (i (length _warpMatrix2))
       (sys::poke (elt _warpMatrix2 i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _warpMatrix
     (write-long (length _warpMatrix) s)
     (dotimes (i (length _warpMatrix))
       (sys::poke (elt _warpMatrix i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _rpyCalib
     (write-long (length _rpyCalib) s)
     (dotimes (i (length _rpyCalib))
       (sys::poke (elt _rpyCalib i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _warpMatrixBig
     (write-long (length _warpMatrixBig) s)
     (dotimes (i (length _warpMatrixBig))
       (sys::poke (elt _warpMatrixBig i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _calCycle
       (write-long _calCycle s)
     ;; float32[] _extrinsicMatrix
     (write-long (length _extrinsicMatrix) s)
     (dotimes (i (length _extrinsicMatrix))
       (sys::poke (elt _extrinsicMatrix i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _calPerc
       (write-long _calPerc s)
     ;; int32 _calStatus
       (write-long _calStatus s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _warpMatrix2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _warpMatrix2 (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _warpMatrix2 i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _warpMatrix
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _warpMatrix (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _warpMatrix i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _rpyCalib
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rpyCalib (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rpyCalib i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _warpMatrixBig
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _warpMatrixBig (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _warpMatrixBig i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _calCycle
     (setq _calCycle (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _extrinsicMatrix
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _extrinsicMatrix (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _extrinsicMatrix i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _calPerc
     (setq _calPerc (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _calStatus
     (setq _calStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LiveCalibrationData :md5sum-) "db636023439d7c81d14cf8eb57e5cb27")
(setf (get openpilot_bridge::LiveCalibrationData :datatype-) "openpilot_bridge/LiveCalibrationData")
(setf (get openpilot_bridge::LiveCalibrationData :definition-)
      "Header header

float32[] warpMatrix2
float32[] warpMatrix
float32[] rpyCalib
float32[] warpMatrixBig
int32 calCycle
float32[] extrinsicMatrix
int32 calPerc
int32 calStatus

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



(provide :openpilot_bridge/LiveCalibrationData "db636023439d7c81d14cf8eb57e5cb27")


