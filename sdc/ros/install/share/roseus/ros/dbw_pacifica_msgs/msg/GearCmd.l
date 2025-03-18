;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::GearCmd)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'GearCmd (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::GEARCMD")
  (make-package "DBW_PACIFICA_MSGS::GEARCMD"))

(in-package "ROS")
;;//! \htmlinclude GearCmd.msg.html


(defclass dbw_pacifica_msgs::GearCmd
  :super ros::object
  :slots (_cmd _enable _rolling_counter _gear_cmd_checksum ))

(defmethod dbw_pacifica_msgs::GearCmd
  (:init
   (&key
    ((:cmd __cmd) (instance dbw_pacifica_msgs::Gear :init))
    ((:enable __enable) nil)
    ((:rolling_counter __rolling_counter) 0)
    ((:gear_cmd_checksum __gear_cmd_checksum) 0.0)
    )
   (send-super :init)
   (setq _cmd __cmd)
   (setq _enable __enable)
   (setq _rolling_counter (round __rolling_counter))
   (setq _gear_cmd_checksum (float __gear_cmd_checksum))
   self)
  (:cmd
   (&rest __cmd)
   (if (keywordp (car __cmd))
       (send* _cmd __cmd)
     (progn
       (if __cmd (setq _cmd (car __cmd)))
       _cmd)))
  (:enable
   (&optional __enable)
   (if __enable (setq _enable __enable)) _enable)
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:gear_cmd_checksum
   (&optional __gear_cmd_checksum)
   (if __gear_cmd_checksum (setq _gear_cmd_checksum __gear_cmd_checksum)) _gear_cmd_checksum)
  (:serialization-length
   ()
   (+
    ;; dbw_pacifica_msgs/Gear _cmd
    (send _cmd :serialization-length)
    ;; bool _enable
    1
    ;; uint8 _rolling_counter
    1
    ;; float32 _gear_cmd_checksum
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; dbw_pacifica_msgs/Gear _cmd
       (send _cmd :serialize s)
     ;; bool _enable
       (if _enable (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; float32 _gear_cmd_checksum
       (sys::poke _gear_cmd_checksum (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; dbw_pacifica_msgs/Gear _cmd
     (send _cmd :deserialize buf ptr-) (incf ptr- (send _cmd :serialization-length))
   ;; bool _enable
     (setq _enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _gear_cmd_checksum
     (setq _gear_cmd_checksum (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::GearCmd :md5sum-) "0e1ada801a24754a8b6ec38e04e82ab5")
(setf (get dbw_pacifica_msgs::GearCmd :datatype-) "dbw_pacifica_msgs/GearCmd")
(setf (get dbw_pacifica_msgs::GearCmd :definition-)
      "# Gear command enumeration
Gear cmd

bool enable

# Watchdog counter
uint8 rolling_counter

float32 gear_cmd_checksum

================================================================================
MSG: dbw_pacifica_msgs/Gear
uint8 gear

uint8 NONE=0
uint8 PARK=1
uint8 REVERSE=2
uint8 NEUTRAL=3
uint8 DRIVE=4
uint8 LOW=5

")



(provide :dbw_pacifica_msgs/GearCmd "0e1ada801a24754a8b6ec38e04e82ab5")


