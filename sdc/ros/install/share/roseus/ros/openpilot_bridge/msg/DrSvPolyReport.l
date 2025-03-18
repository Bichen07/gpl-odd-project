;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::DrSvPolyReport)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'DrSvPolyReport (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::DRSVPOLYREPORT")
  (make-package "OPENPILOT_BRIDGE::DRSVPOLYREPORT"))

(in-package "ROS")
;;//! \htmlinclude DrSvPolyReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::DrSvPolyReport
  :super ros::object
  :slots (_header _xyzN _hasSbasIono _positionUncertainty _svId _elevationUncertainty _polyFromXtra _other _ionoDot _hasIono _frequencyIndex _velocityCoeff _elevation _ionoDelay _sbasIonoDelay _hasPosition _hasElevation _iode _elevationDot _t0 _xyz0 _hasTropo _tropoDelay _sbasIonoDot ))

(defmethod openpilot_bridge::DrSvPolyReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:xyzN __xyzN) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:hasSbasIono __hasSbasIono) nil)
    ((:positionUncertainty __positionUncertainty) 0.0)
    ((:svId __svId) 0)
    ((:elevationUncertainty __elevationUncertainty) 0.0)
    ((:polyFromXtra __polyFromXtra) nil)
    ((:other __other) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:ionoDot __ionoDot) 0.0)
    ((:hasIono __hasIono) nil)
    ((:frequencyIndex __frequencyIndex) 0)
    ((:velocityCoeff __velocityCoeff) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:elevation __elevation) 0.0)
    ((:ionoDelay __ionoDelay) 0.0)
    ((:sbasIonoDelay __sbasIonoDelay) 0.0)
    ((:hasPosition __hasPosition) nil)
    ((:hasElevation __hasElevation) nil)
    ((:iode __iode) 0)
    ((:elevationDot __elevationDot) 0.0)
    ((:t0 __t0) 0.0)
    ((:xyz0 __xyz0) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:hasTropo __hasTropo) nil)
    ((:tropoDelay __tropoDelay) 0.0)
    ((:sbasIonoDot __sbasIonoDot) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _xyzN __xyzN)
   (setq _hasSbasIono __hasSbasIono)
   (setq _positionUncertainty (float __positionUncertainty))
   (setq _svId (round __svId))
   (setq _elevationUncertainty (float __elevationUncertainty))
   (setq _polyFromXtra __polyFromXtra)
   (setq _other __other)
   (setq _ionoDot (float __ionoDot))
   (setq _hasIono __hasIono)
   (setq _frequencyIndex (round __frequencyIndex))
   (setq _velocityCoeff __velocityCoeff)
   (setq _elevation (float __elevation))
   (setq _ionoDelay (float __ionoDelay))
   (setq _sbasIonoDelay (float __sbasIonoDelay))
   (setq _hasPosition __hasPosition)
   (setq _hasElevation __hasElevation)
   (setq _iode (round __iode))
   (setq _elevationDot (float __elevationDot))
   (setq _t0 (float __t0))
   (setq _xyz0 __xyz0)
   (setq _hasTropo __hasTropo)
   (setq _tropoDelay (float __tropoDelay))
   (setq _sbasIonoDot (float __sbasIonoDot))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:xyzN
   (&optional __xyzN)
   (if __xyzN (setq _xyzN __xyzN)) _xyzN)
  (:hasSbasIono
   (&optional __hasSbasIono)
   (if __hasSbasIono (setq _hasSbasIono __hasSbasIono)) _hasSbasIono)
  (:positionUncertainty
   (&optional __positionUncertainty)
   (if __positionUncertainty (setq _positionUncertainty __positionUncertainty)) _positionUncertainty)
  (:svId
   (&optional __svId)
   (if __svId (setq _svId __svId)) _svId)
  (:elevationUncertainty
   (&optional __elevationUncertainty)
   (if __elevationUncertainty (setq _elevationUncertainty __elevationUncertainty)) _elevationUncertainty)
  (:polyFromXtra
   (&optional __polyFromXtra)
   (if __polyFromXtra (setq _polyFromXtra __polyFromXtra)) _polyFromXtra)
  (:other
   (&optional __other)
   (if __other (setq _other __other)) _other)
  (:ionoDot
   (&optional __ionoDot)
   (if __ionoDot (setq _ionoDot __ionoDot)) _ionoDot)
  (:hasIono
   (&optional __hasIono)
   (if __hasIono (setq _hasIono __hasIono)) _hasIono)
  (:frequencyIndex
   (&optional __frequencyIndex)
   (if __frequencyIndex (setq _frequencyIndex __frequencyIndex)) _frequencyIndex)
  (:velocityCoeff
   (&optional __velocityCoeff)
   (if __velocityCoeff (setq _velocityCoeff __velocityCoeff)) _velocityCoeff)
  (:elevation
   (&optional __elevation)
   (if __elevation (setq _elevation __elevation)) _elevation)
  (:ionoDelay
   (&optional __ionoDelay)
   (if __ionoDelay (setq _ionoDelay __ionoDelay)) _ionoDelay)
  (:sbasIonoDelay
   (&optional __sbasIonoDelay)
   (if __sbasIonoDelay (setq _sbasIonoDelay __sbasIonoDelay)) _sbasIonoDelay)
  (:hasPosition
   (&optional __hasPosition)
   (if __hasPosition (setq _hasPosition __hasPosition)) _hasPosition)
  (:hasElevation
   (&optional __hasElevation)
   (if __hasElevation (setq _hasElevation __hasElevation)) _hasElevation)
  (:iode
   (&optional __iode)
   (if __iode (setq _iode __iode)) _iode)
  (:elevationDot
   (&optional __elevationDot)
   (if __elevationDot (setq _elevationDot __elevationDot)) _elevationDot)
  (:t0
   (&optional __t0)
   (if __t0 (setq _t0 __t0)) _t0)
  (:xyz0
   (&optional __xyz0)
   (if __xyz0 (setq _xyz0 __xyz0)) _xyz0)
  (:hasTropo
   (&optional __hasTropo)
   (if __hasTropo (setq _hasTropo __hasTropo)) _hasTropo)
  (:tropoDelay
   (&optional __tropoDelay)
   (if __tropoDelay (setq _tropoDelay __tropoDelay)) _tropoDelay)
  (:sbasIonoDot
   (&optional __sbasIonoDot)
   (if __sbasIonoDot (setq _sbasIonoDot __sbasIonoDot)) _sbasIonoDot)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32[] _xyzN
    (* 4    (length _xyzN)) 4
    ;; bool _hasSbasIono
    1
    ;; float32 _positionUncertainty
    4
    ;; int64 _svId
    8
    ;; float32 _elevationUncertainty
    4
    ;; bool _polyFromXtra
    1
    ;; float32[] _other
    (* 4    (length _other)) 4
    ;; float32 _ionoDot
    4
    ;; bool _hasIono
    1
    ;; int32 _frequencyIndex
    4
    ;; float32[] _velocityCoeff
    (* 4    (length _velocityCoeff)) 4
    ;; float32 _elevation
    4
    ;; float32 _ionoDelay
    4
    ;; float32 _sbasIonoDelay
    4
    ;; bool _hasPosition
    1
    ;; bool _hasElevation
    1
    ;; int64 _iode
    8
    ;; float32 _elevationDot
    4
    ;; float32 _t0
    4
    ;; float32[] _xyz0
    (* 4    (length _xyz0)) 4
    ;; bool _hasTropo
    1
    ;; float32 _tropoDelay
    4
    ;; float32 _sbasIonoDot
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32[] _xyzN
     (write-long (length _xyzN) s)
     (dotimes (i (length _xyzN))
       (sys::poke (elt _xyzN i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _hasSbasIono
       (if _hasSbasIono (write-byte -1 s) (write-byte 0 s))
     ;; float32 _positionUncertainty
       (sys::poke _positionUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _svId
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _svId (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _svId) (= (length (_svId . bv)) 2)) ;; bignum
              (write-long (ash (elt (_svId . bv) 0) 0) s)
              (write-long (ash (elt (_svId . bv) 1) -1) s))
             ((and (class _svId) (= (length (_svId . bv)) 1)) ;; big1
              (write-long (elt (_svId . bv) 0) s)
              (write-long (if (>= _svId 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _svId s)(write-long (if (>= _svId 0) 0 #xffffffff) s)))
     ;; float32 _elevationUncertainty
       (sys::poke _elevationUncertainty (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _polyFromXtra
       (if _polyFromXtra (write-byte -1 s) (write-byte 0 s))
     ;; float32[] _other
     (write-long (length _other) s)
     (dotimes (i (length _other))
       (sys::poke (elt _other i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _ionoDot
       (sys::poke _ionoDot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasIono
       (if _hasIono (write-byte -1 s) (write-byte 0 s))
     ;; int32 _frequencyIndex
       (write-long _frequencyIndex s)
     ;; float32[] _velocityCoeff
     (write-long (length _velocityCoeff) s)
     (dotimes (i (length _velocityCoeff))
       (sys::poke (elt _velocityCoeff i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _elevation
       (sys::poke _elevation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ionoDelay
       (sys::poke _ionoDelay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _sbasIonoDelay
       (sys::poke _sbasIonoDelay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasPosition
       (if _hasPosition (write-byte -1 s) (write-byte 0 s))
     ;; bool _hasElevation
       (if _hasElevation (write-byte -1 s) (write-byte 0 s))
     ;; int64 _iode
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _iode (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _iode) (= (length (_iode . bv)) 2)) ;; bignum
              (write-long (ash (elt (_iode . bv) 0) 0) s)
              (write-long (ash (elt (_iode . bv) 1) -1) s))
             ((and (class _iode) (= (length (_iode . bv)) 1)) ;; big1
              (write-long (elt (_iode . bv) 0) s)
              (write-long (if (>= _iode 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _iode s)(write-long (if (>= _iode 0) 0 #xffffffff) s)))
     ;; float32 _elevationDot
       (sys::poke _elevationDot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _t0
       (sys::poke _t0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _xyz0
     (write-long (length _xyz0) s)
     (dotimes (i (length _xyz0))
       (sys::poke (elt _xyz0 i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; bool _hasTropo
       (if _hasTropo (write-byte -1 s) (write-byte 0 s))
     ;; float32 _tropoDelay
       (sys::poke _tropoDelay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _sbasIonoDot
       (sys::poke _sbasIonoDot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32[] _xyzN
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _xyzN (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _xyzN i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _hasSbasIono
     (setq _hasSbasIono (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _positionUncertainty
     (setq _positionUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _svId
#+(or :alpha :irix6 :x86_64)
      (setf _svId (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _svId (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _elevationUncertainty
     (setq _elevationUncertainty (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _polyFromXtra
     (setq _polyFromXtra (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[] _other
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _other (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _other i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _ionoDot
     (setq _ionoDot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasIono
     (setq _hasIono (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _frequencyIndex
     (setq _frequencyIndex (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _velocityCoeff
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _velocityCoeff (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _velocityCoeff i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _elevation
     (setq _elevation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ionoDelay
     (setq _ionoDelay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _sbasIonoDelay
     (setq _sbasIonoDelay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasPosition
     (setq _hasPosition (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _hasElevation
     (setq _hasElevation (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int64 _iode
#+(or :alpha :irix6 :x86_64)
      (setf _iode (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _iode (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _elevationDot
     (setq _elevationDot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _t0
     (setq _t0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _xyz0
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _xyz0 (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _xyz0 i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; bool _hasTropo
     (setq _hasTropo (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _tropoDelay
     (setq _tropoDelay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _sbasIonoDot
     (setq _sbasIonoDot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::DrSvPolyReport :md5sum-) "9cc05f066482fefea9be7e6ffcf5850f")
(setf (get openpilot_bridge::DrSvPolyReport :datatype-) "openpilot_bridge/DrSvPolyReport")
(setf (get openpilot_bridge::DrSvPolyReport :definition-)
      "Header header

float32[] xyzN
bool hasSbasIono
float32 positionUncertainty
int64 svId
float32 elevationUncertainty
bool polyFromXtra
float32[] other
float32 ionoDot
bool hasIono
int32 frequencyIndex
float32[] velocityCoeff
float32 elevation
float32 ionoDelay
float32 sbasIonoDelay
bool hasPosition
bool hasElevation
int64 iode
float32 elevationDot
float32 t0
float32[] xyz0
bool hasTropo
float32 tropoDelay
float32 sbasIonoDot

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



(provide :openpilot_bridge/DrSvPolyReport "9cc05f066482fefea9be7e6ffcf5850f")


