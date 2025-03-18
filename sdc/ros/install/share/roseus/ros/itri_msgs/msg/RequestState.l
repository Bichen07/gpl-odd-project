;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::RequestState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'RequestState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::REQUESTSTATE")
  (make-package "ITRI_MSGS::REQUESTSTATE"))

(in-package "ROS")
;;//! \htmlinclude RequestState.msg.html


(intern "*NORMAL*" (find-package "ITRI_MSGS::REQUESTSTATE"))
(shadow '*NORMAL* (find-package "ITRI_MSGS::REQUESTSTATE"))
(defconstant itri_msgs::RequestState::*NORMAL* 0)
(intern "*REQUEST*" (find-package "ITRI_MSGS::REQUESTSTATE"))
(shadow '*REQUEST* (find-package "ITRI_MSGS::REQUESTSTATE"))
(defconstant itri_msgs::RequestState::*REQUEST* 1)
(intern "*RESUME*" (find-package "ITRI_MSGS::REQUESTSTATE"))
(shadow '*RESUME* (find-package "ITRI_MSGS::REQUESTSTATE"))
(defconstant itri_msgs::RequestState::*RESUME* 2)
(defclass itri_msgs::RequestState
  :super ros::object
  :slots (_state ))

(defmethod itri_msgs::RequestState
  (:init
   (&key
    ((:state __state) 0)
    )
   (send-super :init)
   (setq _state (round __state))
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; uint8 _state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _state
       (write-byte _state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _state
     (setq _state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::RequestState :md5sum-) "9ef62ea4045988e9b9bb57b5f100a0ce")
(setf (get itri_msgs::RequestState :datatype-) "itri_msgs/RequestState")
(setf (get itri_msgs::RequestState :definition-)
      "# exception request_state
uint8 NORMAL = 0
uint8 REQUEST = 1
uint8 RESUME = 2

uint8 state

")



(provide :itri_msgs/RequestState "9ef62ea4045988e9b9bb57b5f100a0ce")


