;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::State)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'State (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::STATE")
  (make-package "OPENPILOT_BRIDGE::STATE"))

(in-package "ROS")
;;//! \htmlinclude State.msg.html


(intern "*BDSD2BITSYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*BDSD2BITSYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*BDSD2BITSYNC* 9)
(intern "*TOWDECODED*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*TOWDECODED* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*TOWDECODED* 4)
(intern "*GALE1BCCODELOCK*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*GALE1BCCODELOCK* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*GALE1BCCODELOCK* 11)
(intern "*SBASSYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*SBASSYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*SBASSYNC* 14)
(intern "*SYMBOLSYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*SYMBOLSYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*SYMBOLSYNC* 6)
(intern "*UNKNOWN*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*UNKNOWN* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*UNKNOWN* 0)
(intern "*BDSD2SUBFRAMESYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*BDSD2SUBFRAMESYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*BDSD2SUBFRAMESYNC* 10)
(intern "*CODELOCK*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*CODELOCK* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*CODELOCK* 1)
(intern "*SUBFRAMESYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*SUBFRAMESYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*SUBFRAMESYNC* 3)
(intern "*GALE1BPAGESYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*GALE1BPAGESYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*GALE1BPAGESYNC* 13)
(intern "*BITSYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*BITSYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*BITSYNC* 2)
(intern "*GALE1C2NDCODELOCK*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*GALE1C2NDCODELOCK* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*GALE1C2NDCODELOCK* 12)
(intern "*GLOSTRINGSYNC*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*GLOSTRINGSYNC* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*GLOSTRINGSYNC* 7)
(intern "*GLOTODDECODED*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*GLOTODDECODED* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*GLOTODDECODED* 8)
(intern "*MSECAMBIGUOUS*" (find-package "OPENPILOT_BRIDGE::STATE"))
(shadow '*MSECAMBIGUOUS* (find-package "OPENPILOT_BRIDGE::STATE"))
(defconstant openpilot_bridge::State::*MSECAMBIGUOUS* 5)
(defclass openpilot_bridge::State
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::State
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

(setf (get openpilot_bridge::State :md5sum-) "e9a71513332f5cfbf861cb985b6c816e")
(setf (get openpilot_bridge::State :datatype-) "openpilot_bridge/State")
(setf (get openpilot_bridge::State :definition-)
      "uint32 bdsD2BitSync=9
uint32 towDecoded=4
uint32 galE1bcCodeLock=11
uint32 sbasSync=14
uint32 symbolSync=6
uint32 unknown=0
uint32 bdsD2SubframeSync=10
uint32 codeLock=1
uint32 subframeSync=3
uint32 galE1bPageSync=13
uint32 bitSync=2
uint32 galE1c2ndCodeLock=12
uint32 gloStringSync=7
uint32 gloTodDecoded=8
uint32 msecAmbiguous=5

")



(provide :openpilot_bridge/State "e9a71513332f5cfbf861cb985b6c816e")


