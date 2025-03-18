;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EsrDetection)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EsrDetection (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ESRDETECTION")
  (make-package "ITRI_MSGS::ESRDETECTION"))

(in-package "ROS")
;;//! \htmlinclude EsrDetection.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::EsrDetection
  :super ros::object
  :slots (_header _path_id_acc_stat _path_id_acc _path_id_cmbb_move _path_id_cmbb_stat _path_id_fcw_move _path_id_fcw_stat _water_spray_target_id _filtered_xohp_acc_cipv _path_id_acc_2 _path_id_acc_3 _lr_only_grating_lobe_det _truck_target_det ))

(defmethod itri_msgs::EsrDetection
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:path_id_acc_stat __path_id_acc_stat) 0)
    ((:path_id_acc __path_id_acc) 0)
    ((:path_id_cmbb_move __path_id_cmbb_move) 0)
    ((:path_id_cmbb_stat __path_id_cmbb_stat) 0)
    ((:path_id_fcw_move __path_id_fcw_move) 0)
    ((:path_id_fcw_stat __path_id_fcw_stat) 0)
    ((:water_spray_target_id __water_spray_target_id) 0)
    ((:filtered_xohp_acc_cipv __filtered_xohp_acc_cipv) 0.0)
    ((:path_id_acc_2 __path_id_acc_2) 0)
    ((:path_id_acc_3 __path_id_acc_3) 0)
    ((:lr_only_grating_lobe_det __lr_only_grating_lobe_det) nil)
    ((:truck_target_det __truck_target_det) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _path_id_acc_stat (round __path_id_acc_stat))
   (setq _path_id_acc (round __path_id_acc))
   (setq _path_id_cmbb_move (round __path_id_cmbb_move))
   (setq _path_id_cmbb_stat (round __path_id_cmbb_stat))
   (setq _path_id_fcw_move (round __path_id_fcw_move))
   (setq _path_id_fcw_stat (round __path_id_fcw_stat))
   (setq _water_spray_target_id (round __water_spray_target_id))
   (setq _filtered_xohp_acc_cipv (float __filtered_xohp_acc_cipv))
   (setq _path_id_acc_2 (round __path_id_acc_2))
   (setq _path_id_acc_3 (round __path_id_acc_3))
   (setq _lr_only_grating_lobe_det __lr_only_grating_lobe_det)
   (setq _truck_target_det __truck_target_det)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:path_id_acc_stat
   (&optional __path_id_acc_stat)
   (if __path_id_acc_stat (setq _path_id_acc_stat __path_id_acc_stat)) _path_id_acc_stat)
  (:path_id_acc
   (&optional __path_id_acc)
   (if __path_id_acc (setq _path_id_acc __path_id_acc)) _path_id_acc)
  (:path_id_cmbb_move
   (&optional __path_id_cmbb_move)
   (if __path_id_cmbb_move (setq _path_id_cmbb_move __path_id_cmbb_move)) _path_id_cmbb_move)
  (:path_id_cmbb_stat
   (&optional __path_id_cmbb_stat)
   (if __path_id_cmbb_stat (setq _path_id_cmbb_stat __path_id_cmbb_stat)) _path_id_cmbb_stat)
  (:path_id_fcw_move
   (&optional __path_id_fcw_move)
   (if __path_id_fcw_move (setq _path_id_fcw_move __path_id_fcw_move)) _path_id_fcw_move)
  (:path_id_fcw_stat
   (&optional __path_id_fcw_stat)
   (if __path_id_fcw_stat (setq _path_id_fcw_stat __path_id_fcw_stat)) _path_id_fcw_stat)
  (:water_spray_target_id
   (&optional __water_spray_target_id)
   (if __water_spray_target_id (setq _water_spray_target_id __water_spray_target_id)) _water_spray_target_id)
  (:filtered_xohp_acc_cipv
   (&optional __filtered_xohp_acc_cipv)
   (if __filtered_xohp_acc_cipv (setq _filtered_xohp_acc_cipv __filtered_xohp_acc_cipv)) _filtered_xohp_acc_cipv)
  (:path_id_acc_2
   (&optional __path_id_acc_2)
   (if __path_id_acc_2 (setq _path_id_acc_2 __path_id_acc_2)) _path_id_acc_2)
  (:path_id_acc_3
   (&optional __path_id_acc_3)
   (if __path_id_acc_3 (setq _path_id_acc_3 __path_id_acc_3)) _path_id_acc_3)
  (:lr_only_grating_lobe_det
   (&optional __lr_only_grating_lobe_det)
   (if __lr_only_grating_lobe_det (setq _lr_only_grating_lobe_det __lr_only_grating_lobe_det)) _lr_only_grating_lobe_det)
  (:truck_target_det
   (&optional __truck_target_det)
   (if __truck_target_det (setq _truck_target_det __truck_target_det)) _truck_target_det)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _path_id_acc_stat
    1
    ;; uint8 _path_id_acc
    1
    ;; uint8 _path_id_cmbb_move
    1
    ;; uint8 _path_id_cmbb_stat
    1
    ;; uint8 _path_id_fcw_move
    1
    ;; uint8 _path_id_fcw_stat
    1
    ;; uint8 _water_spray_target_id
    1
    ;; float32 _filtered_xohp_acc_cipv
    4
    ;; uint8 _path_id_acc_2
    1
    ;; uint8 _path_id_acc_3
    1
    ;; bool _lr_only_grating_lobe_det
    1
    ;; bool _truck_target_det
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _path_id_acc_stat
       (write-byte _path_id_acc_stat s)
     ;; uint8 _path_id_acc
       (write-byte _path_id_acc s)
     ;; uint8 _path_id_cmbb_move
       (write-byte _path_id_cmbb_move s)
     ;; uint8 _path_id_cmbb_stat
       (write-byte _path_id_cmbb_stat s)
     ;; uint8 _path_id_fcw_move
       (write-byte _path_id_fcw_move s)
     ;; uint8 _path_id_fcw_stat
       (write-byte _path_id_fcw_stat s)
     ;; uint8 _water_spray_target_id
       (write-byte _water_spray_target_id s)
     ;; float32 _filtered_xohp_acc_cipv
       (sys::poke _filtered_xohp_acc_cipv (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _path_id_acc_2
       (write-byte _path_id_acc_2 s)
     ;; uint8 _path_id_acc_3
       (write-byte _path_id_acc_3 s)
     ;; bool _lr_only_grating_lobe_det
       (if _lr_only_grating_lobe_det (write-byte -1 s) (write-byte 0 s))
     ;; bool _truck_target_det
       (if _truck_target_det (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _path_id_acc_stat
     (setq _path_id_acc_stat (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_acc
     (setq _path_id_acc (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_cmbb_move
     (setq _path_id_cmbb_move (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_cmbb_stat
     (setq _path_id_cmbb_stat (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_fcw_move
     (setq _path_id_fcw_move (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_fcw_stat
     (setq _path_id_fcw_stat (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _water_spray_target_id
     (setq _water_spray_target_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _filtered_xohp_acc_cipv
     (setq _filtered_xohp_acc_cipv (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _path_id_acc_2
     (setq _path_id_acc_2 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _path_id_acc_3
     (setq _path_id_acc_3 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _lr_only_grating_lobe_det
     (setq _lr_only_grating_lobe_det (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _truck_target_det
     (setq _truck_target_det (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::EsrDetection :md5sum-) "3accabc22902f1ec54cb36c33644a9c0")
(setf (get itri_msgs::EsrDetection :datatype-) "itri_msgs/EsrDetection")
(setf (get itri_msgs::EsrDetection :definition-)
      "Header header
uint8 path_id_acc_stat
uint8 path_id_acc
uint8 path_id_cmbb_move
uint8 path_id_cmbb_stat
uint8 path_id_fcw_move
uint8 path_id_fcw_stat
uint8 water_spray_target_id
float32 filtered_xohp_acc_cipv
uint8 path_id_acc_2
uint8 path_id_acc_3
bool lr_only_grating_lobe_det
bool truck_target_det

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



(provide :itri_msgs/EsrDetection "3accabc22902f1ec54cb36c33644a9c0")


