;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Ephemeris)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Ephemeris (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::EPHEMERIS")
  (make-package "OPENPILOT_BRIDGE::EPHEMERIS"))

(in-package "ROS")
;;//! \htmlinclude Ephemeris.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Ephemeris
  :super ros::object
  :slots (_header _iodc _fitInterval _month _second _tgd _year _gpsWeek _cus _ionoCoeffsValid _svId _svAcc _cuc _m0 _toc _deltaN _toe _cic _ionoBeta _ecc _iDot _i0 _svHealth _codesL2 _omega _day _minute _a _crs _ionoAlpha _hour _iode _af1 _cis _crc _l2 _omegaDot _af0 _omega0 _af2 _transmissionTime ))

(defmethod openpilot_bridge::Ephemeris
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:iodc __iodc) 0.0)
    ((:fitInterval __fitInterval) 0.0)
    ((:month __month) 0)
    ((:second __second) 0.0)
    ((:tgd __tgd) 0.0)
    ((:year __year) 0)
    ((:gpsWeek __gpsWeek) 0.0)
    ((:cus __cus) 0.0)
    ((:ionoCoeffsValid __ionoCoeffsValid) nil)
    ((:svId __svId) 0)
    ((:svAcc __svAcc) 0.0)
    ((:cuc __cuc) 0.0)
    ((:m0 __m0) 0.0)
    ((:toc __toc) 0.0)
    ((:deltaN __deltaN) 0.0)
    ((:toe __toe) 0.0)
    ((:cic __cic) 0.0)
    ((:ionoBeta __ionoBeta) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:ecc __ecc) 0.0)
    ((:iDot __iDot) 0.0)
    ((:i0 __i0) 0.0)
    ((:svHealth __svHealth) 0.0)
    ((:codesL2 __codesL2) 0.0)
    ((:omega __omega) 0.0)
    ((:day __day) 0)
    ((:minute __minute) 0)
    ((:a __a) 0.0)
    ((:crs __crs) 0.0)
    ((:ionoAlpha __ionoAlpha) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:hour __hour) 0)
    ((:iode __iode) 0.0)
    ((:af1 __af1) 0.0)
    ((:cis __cis) 0.0)
    ((:crc __crc) 0.0)
    ((:l2 __l2) 0.0)
    ((:omegaDot __omegaDot) 0.0)
    ((:af0 __af0) 0.0)
    ((:omega0 __omega0) 0.0)
    ((:af2 __af2) 0.0)
    ((:transmissionTime __transmissionTime) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _iodc (float __iodc))
   (setq _fitInterval (float __fitInterval))
   (setq _month (round __month))
   (setq _second (float __second))
   (setq _tgd (float __tgd))
   (setq _year (round __year))
   (setq _gpsWeek (float __gpsWeek))
   (setq _cus (float __cus))
   (setq _ionoCoeffsValid __ionoCoeffsValid)
   (setq _svId (round __svId))
   (setq _svAcc (float __svAcc))
   (setq _cuc (float __cuc))
   (setq _m0 (float __m0))
   (setq _toc (float __toc))
   (setq _deltaN (float __deltaN))
   (setq _toe (float __toe))
   (setq _cic (float __cic))
   (setq _ionoBeta __ionoBeta)
   (setq _ecc (float __ecc))
   (setq _iDot (float __iDot))
   (setq _i0 (float __i0))
   (setq _svHealth (float __svHealth))
   (setq _codesL2 (float __codesL2))
   (setq _omega (float __omega))
   (setq _day (round __day))
   (setq _minute (round __minute))
   (setq _a (float __a))
   (setq _crs (float __crs))
   (setq _ionoAlpha __ionoAlpha)
   (setq _hour (round __hour))
   (setq _iode (float __iode))
   (setq _af1 (float __af1))
   (setq _cis (float __cis))
   (setq _crc (float __crc))
   (setq _l2 (float __l2))
   (setq _omegaDot (float __omegaDot))
   (setq _af0 (float __af0))
   (setq _omega0 (float __omega0))
   (setq _af2 (float __af2))
   (setq _transmissionTime (float __transmissionTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:iodc
   (&optional __iodc)
   (if __iodc (setq _iodc __iodc)) _iodc)
  (:fitInterval
   (&optional __fitInterval)
   (if __fitInterval (setq _fitInterval __fitInterval)) _fitInterval)
  (:month
   (&optional __month)
   (if __month (setq _month __month)) _month)
  (:second
   (&optional __second)
   (if __second (setq _second __second)) _second)
  (:tgd
   (&optional __tgd)
   (if __tgd (setq _tgd __tgd)) _tgd)
  (:year
   (&optional __year)
   (if __year (setq _year __year)) _year)
  (:gpsWeek
   (&optional __gpsWeek)
   (if __gpsWeek (setq _gpsWeek __gpsWeek)) _gpsWeek)
  (:cus
   (&optional __cus)
   (if __cus (setq _cus __cus)) _cus)
  (:ionoCoeffsValid
   (&optional __ionoCoeffsValid)
   (if __ionoCoeffsValid (setq _ionoCoeffsValid __ionoCoeffsValid)) _ionoCoeffsValid)
  (:svId
   (&optional __svId)
   (if __svId (setq _svId __svId)) _svId)
  (:svAcc
   (&optional __svAcc)
   (if __svAcc (setq _svAcc __svAcc)) _svAcc)
  (:cuc
   (&optional __cuc)
   (if __cuc (setq _cuc __cuc)) _cuc)
  (:m0
   (&optional __m0)
   (if __m0 (setq _m0 __m0)) _m0)
  (:toc
   (&optional __toc)
   (if __toc (setq _toc __toc)) _toc)
  (:deltaN
   (&optional __deltaN)
   (if __deltaN (setq _deltaN __deltaN)) _deltaN)
  (:toe
   (&optional __toe)
   (if __toe (setq _toe __toe)) _toe)
  (:cic
   (&optional __cic)
   (if __cic (setq _cic __cic)) _cic)
  (:ionoBeta
   (&optional __ionoBeta)
   (if __ionoBeta (setq _ionoBeta __ionoBeta)) _ionoBeta)
  (:ecc
   (&optional __ecc)
   (if __ecc (setq _ecc __ecc)) _ecc)
  (:iDot
   (&optional __iDot)
   (if __iDot (setq _iDot __iDot)) _iDot)
  (:i0
   (&optional __i0)
   (if __i0 (setq _i0 __i0)) _i0)
  (:svHealth
   (&optional __svHealth)
   (if __svHealth (setq _svHealth __svHealth)) _svHealth)
  (:codesL2
   (&optional __codesL2)
   (if __codesL2 (setq _codesL2 __codesL2)) _codesL2)
  (:omega
   (&optional __omega)
   (if __omega (setq _omega __omega)) _omega)
  (:day
   (&optional __day)
   (if __day (setq _day __day)) _day)
  (:minute
   (&optional __minute)
   (if __minute (setq _minute __minute)) _minute)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:crs
   (&optional __crs)
   (if __crs (setq _crs __crs)) _crs)
  (:ionoAlpha
   (&optional __ionoAlpha)
   (if __ionoAlpha (setq _ionoAlpha __ionoAlpha)) _ionoAlpha)
  (:hour
   (&optional __hour)
   (if __hour (setq _hour __hour)) _hour)
  (:iode
   (&optional __iode)
   (if __iode (setq _iode __iode)) _iode)
  (:af1
   (&optional __af1)
   (if __af1 (setq _af1 __af1)) _af1)
  (:cis
   (&optional __cis)
   (if __cis (setq _cis __cis)) _cis)
  (:crc
   (&optional __crc)
   (if __crc (setq _crc __crc)) _crc)
  (:l2
   (&optional __l2)
   (if __l2 (setq _l2 __l2)) _l2)
  (:omegaDot
   (&optional __omegaDot)
   (if __omegaDot (setq _omegaDot __omegaDot)) _omegaDot)
  (:af0
   (&optional __af0)
   (if __af0 (setq _af0 __af0)) _af0)
  (:omega0
   (&optional __omega0)
   (if __omega0 (setq _omega0 __omega0)) _omega0)
  (:af2
   (&optional __af2)
   (if __af2 (setq _af2 __af2)) _af2)
  (:transmissionTime
   (&optional __transmissionTime)
   (if __transmissionTime (setq _transmissionTime __transmissionTime)) _transmissionTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _iodc
    4
    ;; float32 _fitInterval
    4
    ;; int64 _month
    8
    ;; float32 _second
    4
    ;; float32 _tgd
    4
    ;; int64 _year
    8
    ;; float32 _gpsWeek
    4
    ;; float32 _cus
    4
    ;; bool _ionoCoeffsValid
    1
    ;; int64 _svId
    8
    ;; float32 _svAcc
    4
    ;; float32 _cuc
    4
    ;; float32 _m0
    4
    ;; float32 _toc
    4
    ;; float32 _deltaN
    4
    ;; float32 _toe
    4
    ;; float32 _cic
    4
    ;; float32[] _ionoBeta
    (* 4    (length _ionoBeta)) 4
    ;; float32 _ecc
    4
    ;; float32 _iDot
    4
    ;; float32 _i0
    4
    ;; float32 _svHealth
    4
    ;; float32 _codesL2
    4
    ;; float32 _omega
    4
    ;; int64 _day
    8
    ;; int64 _minute
    8
    ;; float32 _a
    4
    ;; float32 _crs
    4
    ;; float32[] _ionoAlpha
    (* 4    (length _ionoAlpha)) 4
    ;; int64 _hour
    8
    ;; float32 _iode
    4
    ;; float32 _af1
    4
    ;; float32 _cis
    4
    ;; float32 _crc
    4
    ;; float32 _l2
    4
    ;; float32 _omegaDot
    4
    ;; float32 _af0
    4
    ;; float32 _omega0
    4
    ;; float32 _af2
    4
    ;; float32 _transmissionTime
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _iodc
       (sys::poke _iodc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fitInterval
       (sys::poke _fitInterval (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _month
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _month (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _month) (= (length (_month . bv)) 2)) ;; bignum
              (write-long (ash (elt (_month . bv) 0) 0) s)
              (write-long (ash (elt (_month . bv) 1) -1) s))
             ((and (class _month) (= (length (_month . bv)) 1)) ;; big1
              (write-long (elt (_month . bv) 0) s)
              (write-long (if (>= _month 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _month s)(write-long (if (>= _month 0) 0 #xffffffff) s)))
     ;; float32 _second
       (sys::poke _second (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tgd
       (sys::poke _tgd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _year
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _year (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _year) (= (length (_year . bv)) 2)) ;; bignum
              (write-long (ash (elt (_year . bv) 0) 0) s)
              (write-long (ash (elt (_year . bv) 1) -1) s))
             ((and (class _year) (= (length (_year . bv)) 1)) ;; big1
              (write-long (elt (_year . bv) 0) s)
              (write-long (if (>= _year 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _year s)(write-long (if (>= _year 0) 0 #xffffffff) s)))
     ;; float32 _gpsWeek
       (sys::poke _gpsWeek (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cus
       (sys::poke _cus (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _ionoCoeffsValid
       (if _ionoCoeffsValid (write-byte -1 s) (write-byte 0 s))
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
     ;; float32 _svAcc
       (sys::poke _svAcc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cuc
       (sys::poke _cuc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _m0
       (sys::poke _m0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _toc
       (sys::poke _toc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _deltaN
       (sys::poke _deltaN (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _toe
       (sys::poke _toe (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cic
       (sys::poke _cic (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _ionoBeta
     (write-long (length _ionoBeta) s)
     (dotimes (i (length _ionoBeta))
       (sys::poke (elt _ionoBeta i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _ecc
       (sys::poke _ecc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _iDot
       (sys::poke _iDot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _i0
       (sys::poke _i0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _svHealth
       (sys::poke _svHealth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _codesL2
       (sys::poke _codesL2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _omega
       (sys::poke _omega (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _day
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _day (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _day) (= (length (_day . bv)) 2)) ;; bignum
              (write-long (ash (elt (_day . bv) 0) 0) s)
              (write-long (ash (elt (_day . bv) 1) -1) s))
             ((and (class _day) (= (length (_day . bv)) 1)) ;; big1
              (write-long (elt (_day . bv) 0) s)
              (write-long (if (>= _day 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _day s)(write-long (if (>= _day 0) 0 #xffffffff) s)))
     ;; int64 _minute
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _minute (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _minute) (= (length (_minute . bv)) 2)) ;; bignum
              (write-long (ash (elt (_minute . bv) 0) 0) s)
              (write-long (ash (elt (_minute . bv) 1) -1) s))
             ((and (class _minute) (= (length (_minute . bv)) 1)) ;; big1
              (write-long (elt (_minute . bv) 0) s)
              (write-long (if (>= _minute 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _minute s)(write-long (if (>= _minute 0) 0 #xffffffff) s)))
     ;; float32 _a
       (sys::poke _a (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _crs
       (sys::poke _crs (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _ionoAlpha
     (write-long (length _ionoAlpha) s)
     (dotimes (i (length _ionoAlpha))
       (sys::poke (elt _ionoAlpha i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int64 _hour
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _hour (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _hour) (= (length (_hour . bv)) 2)) ;; bignum
              (write-long (ash (elt (_hour . bv) 0) 0) s)
              (write-long (ash (elt (_hour . bv) 1) -1) s))
             ((and (class _hour) (= (length (_hour . bv)) 1)) ;; big1
              (write-long (elt (_hour . bv) 0) s)
              (write-long (if (>= _hour 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _hour s)(write-long (if (>= _hour 0) 0 #xffffffff) s)))
     ;; float32 _iode
       (sys::poke _iode (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _af1
       (sys::poke _af1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cis
       (sys::poke _cis (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _crc
       (sys::poke _crc (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _l2
       (sys::poke _l2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _omegaDot
       (sys::poke _omegaDot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _af0
       (sys::poke _af0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _omega0
       (sys::poke _omega0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _af2
       (sys::poke _af2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _transmissionTime
       (sys::poke _transmissionTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _iodc
     (setq _iodc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fitInterval
     (setq _fitInterval (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _month
#+(or :alpha :irix6 :x86_64)
      (setf _month (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _month (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _second
     (setq _second (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tgd
     (setq _tgd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _year
#+(or :alpha :irix6 :x86_64)
      (setf _year (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _year (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _gpsWeek
     (setq _gpsWeek (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cus
     (setq _cus (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _ionoCoeffsValid
     (setq _ionoCoeffsValid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
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
   ;; float32 _svAcc
     (setq _svAcc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cuc
     (setq _cuc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _m0
     (setq _m0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _toc
     (setq _toc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _deltaN
     (setq _deltaN (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _toe
     (setq _toe (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cic
     (setq _cic (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _ionoBeta
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ionoBeta (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ionoBeta i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _ecc
     (setq _ecc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _iDot
     (setq _iDot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _i0
     (setq _i0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _svHealth
     (setq _svHealth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _codesL2
     (setq _codesL2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _omega
     (setq _omega (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _day
#+(or :alpha :irix6 :x86_64)
      (setf _day (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _day (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _minute
#+(or :alpha :irix6 :x86_64)
      (setf _minute (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _minute (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _a
     (setq _a (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _crs
     (setq _crs (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _ionoAlpha
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ionoAlpha (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ionoAlpha i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int64 _hour
#+(or :alpha :irix6 :x86_64)
      (setf _hour (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _hour (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _iode
     (setq _iode (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _af1
     (setq _af1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cis
     (setq _cis (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _crc
     (setq _crc (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _l2
     (setq _l2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _omegaDot
     (setq _omegaDot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _af0
     (setq _af0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _omega0
     (setq _omega0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _af2
     (setq _af2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _transmissionTime
     (setq _transmissionTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::Ephemeris :md5sum-) "50d32c9cb75750d1673e442b54a93a06")
(setf (get openpilot_bridge::Ephemeris :datatype-) "openpilot_bridge/Ephemeris")
(setf (get openpilot_bridge::Ephemeris :definition-)
      "Header header

float32 iodc
float32 fitInterval
int64 month
float32 second
float32 tgd
int64 year
float32 gpsWeek
float32 cus
bool ionoCoeffsValid
int64 svId
float32 svAcc
float32 cuc
float32 m0
float32 toc
float32 deltaN
float32 toe
float32 cic
float32[] ionoBeta
float32 ecc
float32 iDot
float32 i0
float32 svHealth
float32 codesL2
float32 omega
int64 day
int64 minute
float32 a
float32 crs
float32[] ionoAlpha
int64 hour
float32 iode
float32 af1
float32 cis
float32 crc
float32 l2
float32 omegaDot
float32 af0
float32 omega0
float32 af2
float32 transmissionTime

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



(provide :openpilot_bridge/Ephemeris "50d32c9cb75750d1673e442b54a93a06")


