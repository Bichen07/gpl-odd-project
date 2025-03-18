;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::GlobalEnableCmd)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'GlobalEnableCmd (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::GLOBALENABLECMD")
  (make-package "DBW_PACIFICA_MSGS::GLOBALENABLECMD"))

(in-package "ROS")
;;//! \htmlinclude GlobalEnableCmd.msg.html


(defclass dbw_pacifica_msgs::GlobalEnableCmd
  :super ros::object
  :slots (_global_enable _enable_joystick_limits _ecu_build_number _rolling_counter _global_cmd_checksum ))

(defmethod dbw_pacifica_msgs::GlobalEnableCmd
  (:init
   (&key
    ((:global_enable __global_enable) nil)
    ((:enable_joystick_limits __enable_joystick_limits) nil)
    ((:ecu_build_number __ecu_build_number) 0)
    ((:rolling_counter __rolling_counter) 0)
    ((:global_cmd_checksum __global_cmd_checksum) 0.0)
    )
   (send-super :init)
   (setq _global_enable __global_enable)
   (setq _enable_joystick_limits __enable_joystick_limits)
   (setq _ecu_build_number (round __ecu_build_number))
   (setq _rolling_counter (round __rolling_counter))
   (setq _global_cmd_checksum (float __global_cmd_checksum))
   self)
  (:global_enable
   (&optional __global_enable)
   (if __global_enable (setq _global_enable __global_enable)) _global_enable)
  (:enable_joystick_limits
   (&optional __enable_joystick_limits)
   (if __enable_joystick_limits (setq _enable_joystick_limits __enable_joystick_limits)) _enable_joystick_limits)
  (:ecu_build_number
   (&optional __ecu_build_number)
   (if __ecu_build_number (setq _ecu_build_number __ecu_build_number)) _ecu_build_number)
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:global_cmd_checksum
   (&optional __global_cmd_checksum)
   (if __global_cmd_checksum (setq _global_cmd_checksum __global_cmd_checksum)) _global_cmd_checksum)
  (:serialization-length
   ()
   (+
    ;; bool _global_enable
    1
    ;; bool _enable_joystick_limits
    1
    ;; uint16 _ecu_build_number
    2
    ;; uint8 _rolling_counter
    1
    ;; float32 _global_cmd_checksum
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _global_enable
       (if _global_enable (write-byte -1 s) (write-byte 0 s))
     ;; bool _enable_joystick_limits
       (if _enable_joystick_limits (write-byte -1 s) (write-byte 0 s))
     ;; uint16 _ecu_build_number
       (write-word _ecu_build_number s)
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; float32 _global_cmd_checksum
       (sys::poke _global_cmd_checksum (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _global_enable
     (setq _global_enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _enable_joystick_limits
     (setq _enable_joystick_limits (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint16 _ecu_build_number
     (setq _ecu_build_number (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _global_cmd_checksum
     (setq _global_cmd_checksum (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::GlobalEnableCmd :md5sum-) "6bed8b1974abe40f81a2b6c9d5a493f6")
(setf (get dbw_pacifica_msgs::GlobalEnableCmd :datatype-) "dbw_pacifica_msgs/GlobalEnableCmd")
(setf (get dbw_pacifica_msgs::GlobalEnableCmd :definition-)
      "bool global_enable

bool enable_joystick_limits

uint16 ecu_build_number

uint8 rolling_counter

float32 global_cmd_checksum

")



(provide :dbw_pacifica_msgs/GlobalEnableCmd "6bed8b1974abe40f81a2b6c9d5a493f6")


