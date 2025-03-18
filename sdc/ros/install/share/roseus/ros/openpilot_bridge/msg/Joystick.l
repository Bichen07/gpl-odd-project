;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Joystick)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Joystick (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::JOYSTICK")
  (make-package "OPENPILOT_BRIDGE::JOYSTICK"))

(in-package "ROS")
;;//! \htmlinclude Joystick.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Joystick
  :super ros::object
  :slots (_header _buttons _axes ))

(defmethod openpilot_bridge::Joystick
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:buttons __buttons) (let (r) (dotimes (i 0) (push nil r)) r))
    ((:axes __axes) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _buttons __buttons)
   (setq _axes __axes)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:buttons
   (&optional __buttons)
   (if __buttons (setq _buttons __buttons)) _buttons)
  (:axes
   (&optional __axes)
   (if __axes (setq _axes __axes)) _axes)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool[] _buttons
    (* 1    (length _buttons)) 4
    ;; float32[] _axes
    (* 4    (length _axes)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool[] _buttons
     (write-long (length _buttons) s)
     (dotimes (i (length _buttons))
       (if (elt _buttons i) (write-byte -1 s) (write-byte 0 s))
       )
     ;; float32[] _axes
     (write-long (length _axes) s)
     (dotimes (i (length _axes))
       (sys::poke (elt _axes i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool[] _buttons
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _buttons (make-list n))
     (dotimes (i n)
     (setf (elt _buttons i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;; float32[] _axes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _axes (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _axes i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::Joystick :md5sum-) "7ac6f48951afbf0bc6ae7b9a64b04d72")
(setf (get openpilot_bridge::Joystick :datatype-) "openpilot_bridge/Joystick")
(setf (get openpilot_bridge::Joystick :definition-)
      "Header header

bool[] buttons
float32[] axes

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



(provide :openpilot_bridge/Joystick "7ac6f48951afbf0bc6ae7b9a64b04d72")


