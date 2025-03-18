;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::AEB)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'AEB (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::AEB")
  (make-package "ITRI_MSGS::AEB"))

(in-package "ROS")
;;//! \htmlinclude AEB.msg.html


(intern "*CLOSE*" (find-package "ITRI_MSGS::AEB"))
(shadow '*CLOSE* (find-package "ITRI_MSGS::AEB"))
(defconstant itri_msgs::AEB::*CLOSE* 0)
(intern "*OPEN*" (find-package "ITRI_MSGS::AEB"))
(shadow '*OPEN* (find-package "ITRI_MSGS::AEB"))
(defconstant itri_msgs::AEB::*OPEN* 1)
(defclass itri_msgs::AEB
  :super ros::object
  :slots (_aeb_active ))

(defmethod itri_msgs::AEB
  (:init
   (&key
    ((:aeb_active __aeb_active) 0)
    )
   (send-super :init)
   (setq _aeb_active (round __aeb_active))
   self)
  (:aeb_active
   (&optional __aeb_active)
   (if __aeb_active (setq _aeb_active __aeb_active)) _aeb_active)
  (:serialization-length
   ()
   (+
    ;; uint8 _aeb_active
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _aeb_active
       (write-byte _aeb_active s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _aeb_active
     (setq _aeb_active (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::AEB :md5sum-) "4c603c1cf5fc3ab31bd6a40781aee3d6")
(setf (get itri_msgs::AEB :datatype-) "itri_msgs/AEB")
(setf (get itri_msgs::AEB :definition-)
      "uint8 CLOSE = 0
uint8 OPEN = 1

uint8 aeb_active

")



(provide :itri_msgs/AEB "4c603c1cf5fc3ab31bd6a40781aee3d6")


