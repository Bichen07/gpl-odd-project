;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AndroidCaptureResult)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AndroidCaptureResult (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ANDROIDCAPTURERESULT")
  (make-package "OPENPILOT_BRIDGE::ANDROIDCAPTURERESULT"))

(in-package "ROS")
;;//! \htmlinclude AndroidCaptureResult.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::AndroidCaptureResult
  :super ros::object
  :slots (_header _exposureTime _displayRotation _colorCorrectionGains _sensitivity _rollingShutterSkew _colorCorrectionTransform _frameDuration ))

(defmethod openpilot_bridge::AndroidCaptureResult
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:exposureTime __exposureTime) 0)
    ((:displayRotation __displayRotation) 0)
    ((:colorCorrectionGains __colorCorrectionGains) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:sensitivity __sensitivity) 0)
    ((:rollingShutterSkew __rollingShutterSkew) 0)
    ((:colorCorrectionTransform __colorCorrectionTransform) (make-array 0 :initial-element 0 :element-type :integer))
    ((:frameDuration __frameDuration) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _exposureTime (round __exposureTime))
   (setq _displayRotation (round __displayRotation))
   (setq _colorCorrectionGains __colorCorrectionGains)
   (setq _sensitivity (round __sensitivity))
   (setq _rollingShutterSkew (round __rollingShutterSkew))
   (setq _colorCorrectionTransform __colorCorrectionTransform)
   (setq _frameDuration (round __frameDuration))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:exposureTime
   (&optional __exposureTime)
   (if __exposureTime (setq _exposureTime __exposureTime)) _exposureTime)
  (:displayRotation
   (&optional __displayRotation)
   (if __displayRotation (setq _displayRotation __displayRotation)) _displayRotation)
  (:colorCorrectionGains
   (&optional __colorCorrectionGains)
   (if __colorCorrectionGains (setq _colorCorrectionGains __colorCorrectionGains)) _colorCorrectionGains)
  (:sensitivity
   (&optional __sensitivity)
   (if __sensitivity (setq _sensitivity __sensitivity)) _sensitivity)
  (:rollingShutterSkew
   (&optional __rollingShutterSkew)
   (if __rollingShutterSkew (setq _rollingShutterSkew __rollingShutterSkew)) _rollingShutterSkew)
  (:colorCorrectionTransform
   (&optional __colorCorrectionTransform)
   (if __colorCorrectionTransform (setq _colorCorrectionTransform __colorCorrectionTransform)) _colorCorrectionTransform)
  (:frameDuration
   (&optional __frameDuration)
   (if __frameDuration (setq _frameDuration __frameDuration)) _frameDuration)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _exposureTime
    4
    ;; int32 _displayRotation
    4
    ;; float32[] _colorCorrectionGains
    (* 4    (length _colorCorrectionGains)) 4
    ;; int32 _sensitivity
    4
    ;; int64 _rollingShutterSkew
    8
    ;; int32[] _colorCorrectionTransform
    (* 4    (length _colorCorrectionTransform)) 4
    ;; int32 _frameDuration
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _exposureTime
       (write-long _exposureTime s)
     ;; int32 _displayRotation
       (write-long _displayRotation s)
     ;; float32[] _colorCorrectionGains
     (write-long (length _colorCorrectionGains) s)
     (dotimes (i (length _colorCorrectionGains))
       (sys::poke (elt _colorCorrectionGains i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _sensitivity
       (write-long _sensitivity s)
     ;; int64 _rollingShutterSkew
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _rollingShutterSkew (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _rollingShutterSkew) (= (length (_rollingShutterSkew . bv)) 2)) ;; bignum
              (write-long (ash (elt (_rollingShutterSkew . bv) 0) 0) s)
              (write-long (ash (elt (_rollingShutterSkew . bv) 1) -1) s))
             ((and (class _rollingShutterSkew) (= (length (_rollingShutterSkew . bv)) 1)) ;; big1
              (write-long (elt (_rollingShutterSkew . bv) 0) s)
              (write-long (if (>= _rollingShutterSkew 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _rollingShutterSkew s)(write-long (if (>= _rollingShutterSkew 0) 0 #xffffffff) s)))
     ;; int32[] _colorCorrectionTransform
     (write-long (length _colorCorrectionTransform) s)
     (dotimes (i (length _colorCorrectionTransform))
       (write-long (elt _colorCorrectionTransform i) s)
       )
     ;; int32 _frameDuration
       (write-long _frameDuration s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _exposureTime
     (setq _exposureTime (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _displayRotation
     (setq _displayRotation (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _colorCorrectionGains
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _colorCorrectionGains (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _colorCorrectionGains i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _sensitivity
     (setq _sensitivity (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _rollingShutterSkew
#+(or :alpha :irix6 :x86_64)
      (setf _rollingShutterSkew (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _rollingShutterSkew (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32[] _colorCorrectionTransform
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _colorCorrectionTransform (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _colorCorrectionTransform i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32 _frameDuration
     (setq _frameDuration (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::AndroidCaptureResult :md5sum-) "896962cc0ef44d3d658a8c60bd9f9307")
(setf (get openpilot_bridge::AndroidCaptureResult :datatype-) "openpilot_bridge/AndroidCaptureResult")
(setf (get openpilot_bridge::AndroidCaptureResult :definition-)
      "Header header

int32 exposureTime
int32 displayRotation
float32[] colorCorrectionGains
int32 sensitivity
int64 rollingShutterSkew
int32[] colorCorrectionTransform
int32 frameDuration

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



(provide :openpilot_bridge/AndroidCaptureResult "896962cc0ef44d3d658a8c60bd9f9307")


