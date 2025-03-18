;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ModelSettings)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ModelSettings (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MODELSETTINGS")
  (make-package "OPENPILOT_BRIDGE::MODELSETTINGS"))

(in-package "ROS")
;;//! \htmlinclude ModelSettings.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ModelSettings
  :super ros::object
  :slots (_header _bigBoxX _bigBoxY _inputTransform _bigBoxHeight _bigBoxWidth _boxProjection _yuvCorrection ))

(defmethod openpilot_bridge::ModelSettings
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:bigBoxX __bigBoxX) 0)
    ((:bigBoxY __bigBoxY) 0)
    ((:inputTransform __inputTransform) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:bigBoxHeight __bigBoxHeight) 0)
    ((:bigBoxWidth __bigBoxWidth) 0)
    ((:boxProjection __boxProjection) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:yuvCorrection __yuvCorrection) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _bigBoxX (round __bigBoxX))
   (setq _bigBoxY (round __bigBoxY))
   (setq _inputTransform __inputTransform)
   (setq _bigBoxHeight (round __bigBoxHeight))
   (setq _bigBoxWidth (round __bigBoxWidth))
   (setq _boxProjection __boxProjection)
   (setq _yuvCorrection __yuvCorrection)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:bigBoxX
   (&optional __bigBoxX)
   (if __bigBoxX (setq _bigBoxX __bigBoxX)) _bigBoxX)
  (:bigBoxY
   (&optional __bigBoxY)
   (if __bigBoxY (setq _bigBoxY __bigBoxY)) _bigBoxY)
  (:inputTransform
   (&optional __inputTransform)
   (if __inputTransform (setq _inputTransform __inputTransform)) _inputTransform)
  (:bigBoxHeight
   (&optional __bigBoxHeight)
   (if __bigBoxHeight (setq _bigBoxHeight __bigBoxHeight)) _bigBoxHeight)
  (:bigBoxWidth
   (&optional __bigBoxWidth)
   (if __bigBoxWidth (setq _bigBoxWidth __bigBoxWidth)) _bigBoxWidth)
  (:boxProjection
   (&optional __boxProjection)
   (if __boxProjection (setq _boxProjection __boxProjection)) _boxProjection)
  (:yuvCorrection
   (&optional __yuvCorrection)
   (if __yuvCorrection (setq _yuvCorrection __yuvCorrection)) _yuvCorrection)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _bigBoxX
    8
    ;; int64 _bigBoxY
    8
    ;; float32[] _inputTransform
    (* 4    (length _inputTransform)) 4
    ;; int64 _bigBoxHeight
    8
    ;; int64 _bigBoxWidth
    8
    ;; float32[] _boxProjection
    (* 4    (length _boxProjection)) 4
    ;; float32[] _yuvCorrection
    (* 4    (length _yuvCorrection)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _bigBoxX
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bigBoxX (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bigBoxX) (= (length (_bigBoxX . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bigBoxX . bv) 0) 0) s)
              (write-long (ash (elt (_bigBoxX . bv) 1) -1) s))
             ((and (class _bigBoxX) (= (length (_bigBoxX . bv)) 1)) ;; big1
              (write-long (elt (_bigBoxX . bv) 0) s)
              (write-long (if (>= _bigBoxX 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bigBoxX s)(write-long (if (>= _bigBoxX 0) 0 #xffffffff) s)))
     ;; int64 _bigBoxY
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bigBoxY (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bigBoxY) (= (length (_bigBoxY . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bigBoxY . bv) 0) 0) s)
              (write-long (ash (elt (_bigBoxY . bv) 1) -1) s))
             ((and (class _bigBoxY) (= (length (_bigBoxY . bv)) 1)) ;; big1
              (write-long (elt (_bigBoxY . bv) 0) s)
              (write-long (if (>= _bigBoxY 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bigBoxY s)(write-long (if (>= _bigBoxY 0) 0 #xffffffff) s)))
     ;; float32[] _inputTransform
     (write-long (length _inputTransform) s)
     (dotimes (i (length _inputTransform))
       (sys::poke (elt _inputTransform i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _bigBoxHeight
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bigBoxHeight (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bigBoxHeight) (= (length (_bigBoxHeight . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bigBoxHeight . bv) 0) 0) s)
              (write-long (ash (elt (_bigBoxHeight . bv) 1) -1) s))
             ((and (class _bigBoxHeight) (= (length (_bigBoxHeight . bv)) 1)) ;; big1
              (write-long (elt (_bigBoxHeight . bv) 0) s)
              (write-long (if (>= _bigBoxHeight 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bigBoxHeight s)(write-long (if (>= _bigBoxHeight 0) 0 #xffffffff) s)))
     ;; int64 _bigBoxWidth
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bigBoxWidth (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bigBoxWidth) (= (length (_bigBoxWidth . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bigBoxWidth . bv) 0) 0) s)
              (write-long (ash (elt (_bigBoxWidth . bv) 1) -1) s))
             ((and (class _bigBoxWidth) (= (length (_bigBoxWidth . bv)) 1)) ;; big1
              (write-long (elt (_bigBoxWidth . bv) 0) s)
              (write-long (if (>= _bigBoxWidth 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bigBoxWidth s)(write-long (if (>= _bigBoxWidth 0) 0 #xffffffff) s)))
     ;; float32[] _boxProjection
     (write-long (length _boxProjection) s)
     (dotimes (i (length _boxProjection))
       (sys::poke (elt _boxProjection i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _yuvCorrection
     (write-long (length _yuvCorrection) s)
     (dotimes (i (length _yuvCorrection))
       (sys::poke (elt _yuvCorrection i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _bigBoxX
#+(or :alpha :irix6 :x86_64)
      (setf _bigBoxX (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bigBoxX (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _bigBoxY
#+(or :alpha :irix6 :x86_64)
      (setf _bigBoxY (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bigBoxY (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _inputTransform
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _inputTransform (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _inputTransform i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _bigBoxHeight
#+(or :alpha :irix6 :x86_64)
      (setf _bigBoxHeight (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bigBoxHeight (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _bigBoxWidth
#+(or :alpha :irix6 :x86_64)
      (setf _bigBoxWidth (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bigBoxWidth (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32[] _boxProjection
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _boxProjection (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _boxProjection i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _yuvCorrection
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _yuvCorrection (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _yuvCorrection i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::ModelSettings :md5sum-) "eb1d31c1be30c211c4413eefd71f6439")
(setf (get openpilot_bridge::ModelSettings :datatype-) "openpilot_bridge/ModelSettings")
(setf (get openpilot_bridge::ModelSettings :definition-)
      "Header header

int64 bigBoxX
int64 bigBoxY
float32[] inputTransform
int64 bigBoxHeight
int64 bigBoxWidth
float32[] boxProjection
float32[] yuvCorrection

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



(provide :openpilot_bridge/ModelSettings "eb1d31c1be30c211c4413eefd71f6439")


