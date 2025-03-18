;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Instruction)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Instruction (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::INSTRUCTION")
  (make-package "OPENPILOT_BRIDGE::INSTRUCTION"))

(in-package "ROS")
;;//! \htmlinclude Instruction.msg.html


(intern "*UTURN*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UTURN* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UTURN* 19)
(intern "*ROUNDABOUTUTURN*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTUTURN* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTUTURN* 13)
(intern "*ARRIVE*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ARRIVE* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ARRIVE* 15)
(intern "*ROUNDABOUTSTRAIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTSTRAIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTSTRAIGHT* 9)
(intern "*TURNLEFT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*TURNLEFT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*TURNLEFT* 0)
(intern "*UNKN12*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UNKN12* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UNKN12* 12)
(intern "*ROUNDABOUTEXITNUMBER*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTEXITNUMBER* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTEXITNUMBER* 5)
(intern "*EXITLEFT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*EXITLEFT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*EXITLEFT* 16)
(intern "*UNKN8*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UNKN8* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UNKN8* 8)
(intern "*TURNRIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*TURNRIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*TURNRIGHT* 1)
(intern "*ROUNDABOUTEXIT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTEXIT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTEXIT* 6)
(intern "*ROUNDABOUTTURNRIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTTURNRIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTTURNRIGHT* 11)
(intern "*ROUNDABOUTTURNLEFT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*ROUNDABOUTTURNLEFT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*ROUNDABOUTTURNLEFT* 7)
(intern "*UNKN18*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UNKN18* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UNKN18* 18)
(intern "*EXITRIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*EXITRIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*EXITRIGHT* 17)
(intern "*KEEPRIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*KEEPRIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*KEEPRIGHT* 3)
(intern "*UNKN14*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UNKN14* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UNKN14* 14)
(intern "*KEEPLEFT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*KEEPLEFT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*KEEPLEFT* 2)
(intern "*STRAIGHT*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*STRAIGHT* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*STRAIGHT* 4)
(intern "*UNKN10*" (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(shadow '*UNKN10* (find-package "OPENPILOT_BRIDGE::INSTRUCTION"))
(defconstant openpilot_bridge::Instruction::*UNKN10* 10)
(defclass openpilot_bridge::Instruction
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::Instruction
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(setf (get openpilot_bridge::Instruction :md5sum-) "0ae55be583a3a2e13a4008c6f0412834")
(setf (get openpilot_bridge::Instruction :datatype-) "openpilot_bridge/Instruction")
(setf (get openpilot_bridge::Instruction :definition-)
      "uint32 uturn=19
uint32 roundaboutUturn=13
uint32 arrive=15
uint32 roundaboutStraight=9
uint32 turnLeft=0
uint32 unkn12=12
uint32 roundaboutExitNumber=5
uint32 exitLeft=16
uint32 unkn8=8
uint32 turnRight=1
uint32 roundaboutExit=6
uint32 roundaboutTurnRight=11
uint32 roundaboutTurnLeft=7
uint32 unkn18=18
uint32 exitRight=17
uint32 keepRight=3
uint32 unkn14=14
uint32 keepLeft=2
uint32 straight=4
uint32 unkn10=10

")



(provide :openpilot_bridge/Instruction "0ae55be583a3a2e13a4008c6f0412834")


