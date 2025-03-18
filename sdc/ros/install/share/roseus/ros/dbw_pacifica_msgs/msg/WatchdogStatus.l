;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::WatchdogStatus)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'WatchdogStatus (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS")
  (make-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))

(in-package "ROS")
;;//! \htmlinclude WatchdogStatus.msg.html


(intern "*NONE*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*NONE* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*NONE* 0)
(intern "*OTHER_BRAKE*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*OTHER_BRAKE* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*OTHER_BRAKE* 1)
(intern "*OTHER_ACCELERATOR_PEDAL*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*OTHER_ACCELERATOR_PEDAL* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*OTHER_ACCELERATOR_PEDAL* 2)
(intern "*OTHER_STEERING*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*OTHER_STEERING* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*OTHER_STEERING* 3)
(intern "*BRAKE_COUNTER*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*BRAKE_COUNTER* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*BRAKE_COUNTER* 4)
(intern "*BRAKE_DISABLED*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*BRAKE_DISABLED* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*BRAKE_DISABLED* 5)
(intern "*BRAKE_COMMAND*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*BRAKE_COMMAND* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*BRAKE_COMMAND* 6)
(intern "*BRAKE_REPORT*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*BRAKE_REPORT* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*BRAKE_REPORT* 7)
(intern "*ACCELERATOR_PEDAL_COUNTER*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*ACCELERATOR_PEDAL_COUNTER* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*ACCELERATOR_PEDAL_COUNTER* 8)
(intern "*ACCELERATOR_PEDAL_DISABLED*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*ACCELERATOR_PEDAL_DISABLED* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*ACCELERATOR_PEDAL_DISABLED* 9)
(intern "*ACCELERATOR_PEDAL_COMMAND*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*ACCELERATOR_PEDAL_COMMAND* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*ACCELERATOR_PEDAL_COMMAND* 10)
(intern "*ACCELERATOR_PEDAL_REPORT*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*ACCELERATOR_PEDAL_REPORT* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*ACCELERATOR_PEDAL_REPORT* 11)
(intern "*STEERING_COUNTER*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*STEERING_COUNTER* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*STEERING_COUNTER* 12)
(intern "*STEERING_DISABLED*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*STEERING_DISABLED* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*STEERING_DISABLED* 13)
(intern "*STEERING_COMMAND*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*STEERING_COMMAND* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*STEERING_COMMAND* 14)
(intern "*STEERING_REPORT*" (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(shadow '*STEERING_REPORT* (find-package "DBW_PACIFICA_MSGS::WATCHDOGSTATUS"))
(defconstant dbw_pacifica_msgs::WatchdogStatus::*STEERING_REPORT* 15)
(defclass dbw_pacifica_msgs::WatchdogStatus
  :super ros::object
  :slots (_source ))

(defmethod dbw_pacifica_msgs::WatchdogStatus
  (:init
   (&key
    ((:source __source) 0)
    )
   (send-super :init)
   (setq _source (round __source))
   self)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:serialization-length
   ()
   (+
    ;; uint8 _source
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _source
       (write-byte _source s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _source
     (setq _source (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::WatchdogStatus :md5sum-) "3e7ee28e0afc591098518c8b9bf36b8a")
(setf (get dbw_pacifica_msgs::WatchdogStatus :datatype-) "dbw_pacifica_msgs/WatchdogStatus")
(setf (get dbw_pacifica_msgs::WatchdogStatus :definition-)
      "uint8 source

uint8 NONE=0                        # No source for watchdog counter fault
uint8 OTHER_BRAKE=1                 # Fault determined by brake controller
uint8 OTHER_ACCELERATOR_PEDAL=2     # Fault determined by accelerator pedal controller
uint8 OTHER_STEERING=3              # Fault determined by steering controller
uint8 BRAKE_COUNTER=4               # Brake command counter failed to increment
uint8 BRAKE_DISABLED=5              # Brake transition to disabled while in gear or moving
uint8 BRAKE_COMMAND=6               # Brake command timeout after 100ms
uint8 BRAKE_REPORT=7                # Brake report timeout after 100ms
uint8 ACCELERATOR_PEDAL_COUNTER=8   # Accelerator pedal command counter failed to increment
uint8 ACCELERATOR_PEDAL_DISABLED=9  # Accelerator pedal transition to disabled while in gear or moving
uint8 ACCELERATOR_PEDAL_COMMAND=10  # Accelerator pedal command timeout after 100ms
uint8 ACCELERATOR_PEDAL_REPORT=11   # Accelerator pedal report timeout after 100ms
uint8 STEERING_COUNTER=12           # Steering command counter failed to increment
uint8 STEERING_DISABLED=13          # Steering transition to disabled while in gear or moving
uint8 STEERING_COMMAND=14           # Steering command timeout after 100ms
uint8 STEERING_REPORT=15            # Steering report timeout after 100ms

")



(provide :dbw_pacifica_msgs/WatchdogStatus "3e7ee28e0afc591098518c8b9bf36b8a")


