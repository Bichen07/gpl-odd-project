;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::LedWrite)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'LedWrite (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LEDWRITE")
  (make-package "ITRI_MSGS::LEDWRITE"))

(in-package "ROS")
;;//! \htmlinclude LedWrite.msg.html


(defclass itri_msgs::LedWrite
  :super ros::object
  :slots (_data _mode _length _action _speed _stop_time _frame _numViews ))

(defmethod itri_msgs::LedWrite
  (:init
   (&key
    ((:data __data) (make-array 0 :initial-element 0 :element-type :integer))
    ((:mode __mode) 0)
    ((:length __length) 0)
    ((:action __action) 0)
    ((:speed __speed) 0)
    ((:stop_time __stop_time) 0)
    ((:frame __frame) 0)
    ((:numViews __numViews) 0)
    )
   (send-super :init)
   (setq _data __data)
   (setq _mode (round __mode))
   (setq _length (round __length))
   (setq _action (round __action))
   (setq _speed (round __speed))
   (setq _stop_time (round __stop_time))
   (setq _frame (round __frame))
   (setq _numViews (round __numViews))
   self)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:stop_time
   (&optional __stop_time)
   (if __stop_time (setq _stop_time __stop_time)) _stop_time)
  (:frame
   (&optional __frame)
   (if __frame (setq _frame __frame)) _frame)
  (:numViews
   (&optional __numViews)
   (if __numViews (setq _numViews __numViews)) _numViews)
  (:serialization-length
   ()
   (+
    ;; char[] _data
    (* 1    (length _data)) 4
    ;; uint8 _mode
    1
    ;; uint8 _length
    1
    ;; uint8 _action
    1
    ;; uint8 _speed
    1
    ;; uint8 _stop_time
    1
    ;; uint8 _frame
    1
    ;; uint8 _numViews
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; char[] _data
     (write-long (length _data) s)
     (dotimes (i (length _data))
       (write-byte (elt _data i) s)
       )
     ;; uint8 _mode
       (write-byte _mode s)
     ;; uint8 _length
       (write-byte _length s)
     ;; uint8 _action
       (write-byte _action s)
     ;; uint8 _speed
       (write-byte _speed s)
     ;; uint8 _stop_time
       (write-byte _stop_time s)
     ;; uint8 _frame
       (write-byte _frame s)
     ;; uint8 _numViews
       (write-byte _numViews s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; char[] _data
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _data (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _data i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     ))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _length
     (setq _length (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _action
     (setq _action (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _speed
     (setq _speed (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _stop_time
     (setq _stop_time (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _frame
     (setq _frame (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _numViews
     (setq _numViews (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::LedWrite :md5sum-) "0d492c2637a3aced37a6325f8359af16")
(setf (get itri_msgs::LedWrite :datatype-) "itri_msgs/LedWrite")
(setf (get itri_msgs::LedWrite :definition-)
      "char[] data
uint8 mode
uint8 length
uint8 action
uint8 speed
uint8 stop_time
uint8 frame
uint8 numViews

")



(provide :itri_msgs/LedWrite "0d492c2637a3aced37a6325f8359af16")


