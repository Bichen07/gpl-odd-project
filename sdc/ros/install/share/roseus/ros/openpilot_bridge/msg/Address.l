;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Address)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Address (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ADDRESS")
  (make-package "OPENPILOT_BRIDGE::ADDRESS"))

(in-package "ROS")
;;//! \htmlinclude Address.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Address
  :super ros::object
  :slots (_header _city _title _house _state _street _address _lat _lng _country ))

(defmethod openpilot_bridge::Address
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:city __city) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:title __title) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:house __house) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:state __state) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:street __street) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:address __address) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:lat __lat) 0.0)
    ((:lng __lng) 0.0)
    ((:country __country) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _city __city)
   (setq _title __title)
   (setq _house __house)
   (setq _state __state)
   (setq _street __street)
   (setq _address __address)
   (setq _lat (float __lat))
   (setq _lng (float __lng))
   (setq _country __country)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:city
   (&optional __city)
   (if __city (setq _city __city)) _city)
  (:title
   (&optional __title)
   (if __title (setq _title __title)) _title)
  (:house
   (&optional __house)
   (if __house (setq _house __house)) _house)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:street
   (&optional __street)
   (if __street (setq _street __street)) _street)
  (:address
   (&optional __address)
   (if __address (setq _address __address)) _address)
  (:lat
   (&optional __lat)
   (if __lat (setq _lat __lat)) _lat)
  (:lng
   (&optional __lng)
   (if __lng (setq _lng __lng)) _lng)
  (:country
   (&optional __country)
   (if __country (setq _country __country)) _country)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _city
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _city)) 4
    ;; string[] _title
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _title)) 4
    ;; string[] _house
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _house)) 4
    ;; string[] _state
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _state)) 4
    ;; string[] _street
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _street)) 4
    ;; string[] _address
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _address)) 4
    ;; float32 _lat
    4
    ;; float32 _lng
    4
    ;; string[] _country
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _country)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _city
     (write-long (length _city) s)
     (dolist (elem _city)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _title
     (write-long (length _title) s)
     (dolist (elem _title)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _house
     (write-long (length _house) s)
     (dolist (elem _house)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _state
     (write-long (length _state) s)
     (dolist (elem _state)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _street
     (write-long (length _street) s)
     (dolist (elem _street)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _address
     (write-long (length _address) s)
     (dolist (elem _address)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _lat
       (sys::poke _lat (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _lng
       (sys::poke _lng (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _country
     (write-long (length _country) s)
     (dolist (elem _country)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _city
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _city (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _city i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _title
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _title (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _title i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _house
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _house (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _house i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _state
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _state (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _state i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _street
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _street (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _street i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _address
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _address (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _address i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _lat
     (setq _lat (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _lng
     (setq _lng (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _country
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _country (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _country i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::Address :md5sum-) "e8f8610485d199d8ba159f7b07e0e495")
(setf (get openpilot_bridge::Address :datatype-) "openpilot_bridge/Address")
(setf (get openpilot_bridge::Address :definition-)
      "Header header

string[] city
string[] title
string[] house
string[] state
string[] street
string[] address
float32 lat
float32 lng
string[] country

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



(provide :openpilot_bridge/Address "e8f8610485d199d8ba159f7b07e0e495")


