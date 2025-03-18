;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ChannelWidth)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ChannelWidth (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH")
  (make-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))

(in-package "ROS")
;;//! \htmlinclude ChannelWidth.msg.html


(intern "*W40MHZ*" (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(shadow '*W40MHZ* (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(defconstant openpilot_bridge::ChannelWidth::*W40MHZ* 1)
(intern "*W160MHZ*" (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(shadow '*W160MHZ* (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(defconstant openpilot_bridge::ChannelWidth::*W160MHZ* 3)
(intern "*W80MHZ*" (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(shadow '*W80MHZ* (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(defconstant openpilot_bridge::ChannelWidth::*W80MHZ* 2)
(intern "*W80PLUS80MHZ*" (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(shadow '*W80PLUS80MHZ* (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(defconstant openpilot_bridge::ChannelWidth::*W80PLUS80MHZ* 4)
(intern "*W20MHZ*" (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(shadow '*W20MHZ* (find-package "OPENPILOT_BRIDGE::CHANNELWIDTH"))
(defconstant openpilot_bridge::ChannelWidth::*W20MHZ* 0)
(defclass openpilot_bridge::ChannelWidth
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::ChannelWidth
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

(setf (get openpilot_bridge::ChannelWidth :md5sum-) "9ae570201d6a8de5bc884fa5c20bf751")
(setf (get openpilot_bridge::ChannelWidth :datatype-) "openpilot_bridge/ChannelWidth")
(setf (get openpilot_bridge::ChannelWidth :definition-)
      "uint32 w40Mhz=1
uint32 w160Mhz=3
uint32 w80Mhz=2
uint32 w80Plus80Mhz=4
uint32 w20Mhz=0

")



(provide :openpilot_bridge/ChannelWidth "9ae570201d6a8de5bc884fa5c20bf751")


