;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::CudaImage)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'CudaImage (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::CUDAIMAGE")
  (make-package "ITRI_MSGS::CUDAIMAGE"))

(in-package "ROS")
;;//! \htmlinclude CudaImage.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::CudaImage
  :super ros::object
  :slots (_header _height _width _encoding _ptr0 _ptr1 _ptr2 _step0 _step1 _step2 ))

(defmethod itri_msgs::CudaImage
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:height __height) 0)
    ((:width __width) 0)
    ((:encoding __encoding) "")
    ((:ptr0 __ptr0) 0)
    ((:ptr1 __ptr1) 0)
    ((:ptr2 __ptr2) 0)
    ((:step0 __step0) 0)
    ((:step1 __step1) 0)
    ((:step2 __step2) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _encoding (string __encoding))
   (setq _ptr0 (round __ptr0))
   (setq _ptr1 (round __ptr1))
   (setq _ptr2 (round __ptr2))
   (setq _step0 (round __step0))
   (setq _step1 (round __step1))
   (setq _step2 (round __step2))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:encoding
   (&optional __encoding)
   (if __encoding (setq _encoding __encoding)) _encoding)
  (:ptr0
   (&optional __ptr0)
   (if __ptr0 (setq _ptr0 __ptr0)) _ptr0)
  (:ptr1
   (&optional __ptr1)
   (if __ptr1 (setq _ptr1 __ptr1)) _ptr1)
  (:ptr2
   (&optional __ptr2)
   (if __ptr2 (setq _ptr2 __ptr2)) _ptr2)
  (:step0
   (&optional __step0)
   (if __step0 (setq _step0 __step0)) _step0)
  (:step1
   (&optional __step1)
   (if __step1 (setq _step1 __step1)) _step1)
  (:step2
   (&optional __step2)
   (if __step2 (setq _step2 __step2)) _step2)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _height
    4
    ;; uint32 _width
    4
    ;; string _encoding
    4 (length _encoding)
    ;; uint64 _ptr0
    8
    ;; uint64 _ptr1
    8
    ;; uint64 _ptr2
    8
    ;; uint32 _step0
    4
    ;; uint32 _step1
    4
    ;; uint32 _step2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _height
       (write-long _height s)
     ;; uint32 _width
       (write-long _width s)
     ;; string _encoding
       (write-long (length _encoding) s) (princ _encoding s)
     ;; uint64 _ptr0
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ptr0 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ptr0) (= (length (_ptr0 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ptr0 . bv) 0) 0) s)
              (write-long (ash (elt (_ptr0 . bv) 1) -1) s))
             ((and (class _ptr0) (= (length (_ptr0 . bv)) 1)) ;; big1
              (write-long (elt (_ptr0 . bv) 0) s)
              (write-long (if (>= _ptr0 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ptr0 s)(write-long (if (>= _ptr0 0) 0 #xffffffff) s)))
     ;; uint64 _ptr1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ptr1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ptr1) (= (length (_ptr1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ptr1 . bv) 0) 0) s)
              (write-long (ash (elt (_ptr1 . bv) 1) -1) s))
             ((and (class _ptr1) (= (length (_ptr1 . bv)) 1)) ;; big1
              (write-long (elt (_ptr1 . bv) 0) s)
              (write-long (if (>= _ptr1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ptr1 s)(write-long (if (>= _ptr1 0) 0 #xffffffff) s)))
     ;; uint64 _ptr2
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ptr2 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ptr2) (= (length (_ptr2 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ptr2 . bv) 0) 0) s)
              (write-long (ash (elt (_ptr2 . bv) 1) -1) s))
             ((and (class _ptr2) (= (length (_ptr2 . bv)) 1)) ;; big1
              (write-long (elt (_ptr2 . bv) 0) s)
              (write-long (if (>= _ptr2 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ptr2 s)(write-long (if (>= _ptr2 0) 0 #xffffffff) s)))
     ;; uint32 _step0
       (write-long _step0 s)
     ;; uint32 _step1
       (write-long _step1 s)
     ;; uint32 _step2
       (write-long _step2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _encoding
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _encoding (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint64 _ptr0
     
#+(or :alpha :irix6 :x86_64)
      (setf _ptr0 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ptr0 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint64 _ptr1
     
#+(or :alpha :irix6 :x86_64)
      (setf _ptr1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ptr1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint64 _ptr2
     
#+(or :alpha :irix6 :x86_64)
      (setf _ptr2 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ptr2 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint32 _step0
     (setq _step0 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _step1
     (setq _step1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _step2
     (setq _step2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::CudaImage :md5sum-) "fc947c96e9a65ec0628de254966abb43")
(setf (get itri_msgs::CudaImage :datatype-) "itri_msgs/CudaImage")
(setf (get itri_msgs::CudaImage :definition-)
      "std_msgs/Header header

uint32 height
uint32 width

string encoding

uint64 ptr0
uint64 ptr1
uint64 ptr2
uint32 step0
uint32 step1
uint32 step2

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



(provide :itri_msgs/CudaImage "fc947c96e9a65ec0628de254966abb43")


