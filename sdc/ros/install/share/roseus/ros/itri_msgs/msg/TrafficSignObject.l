;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficSignObject)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficSignObject (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICSIGNOBJECT")
  (make-package "ITRI_MSGS::TRAFFICSIGNOBJECT"))

(in-package "ROS")
;;//! \htmlinclude TrafficSignObject.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass itri_msgs::TrafficSignObject
  :super ros::object
  :slots (_stop _roi _score _id _distance _sign ))

(defmethod itri_msgs::TrafficSignObject
  (:init
   (&key
    ((:stop __stop) nil)
    ((:roi __roi) (instance sensor_msgs::RegionOfInterest :init))
    ((:score __score) 0.0)
    ((:id __id) 0)
    ((:distance __distance) 0.0)
    ((:sign __sign) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _stop __stop)
   (setq _roi __roi)
   (setq _score (float __score))
   (setq _id (round __id))
   (setq _distance (float __distance))
   (setq _sign __sign)
   self)
  (:stop
   (&optional __stop)
   (if __stop (setq _stop __stop)) _stop)
  (:roi
   (&rest __roi)
   (if (keywordp (car __roi))
       (send* _roi __roi)
     (progn
       (if __roi (setq _roi (car __roi)))
       _roi)))
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:sign
   (&optional __sign)
   (if __sign (setq _sign __sign)) _sign)
  (:serialization-length
   ()
   (+
    ;; bool _stop
    1
    ;; sensor_msgs/RegionOfInterest _roi
    (send _roi :serialization-length)
    ;; float32 _score
    4
    ;; int32 _id
    4
    ;; float32 _distance
    4
    ;; string[] _sign
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _sign)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _stop
       (if _stop (write-byte -1 s) (write-byte 0 s))
     ;; sensor_msgs/RegionOfInterest _roi
       (send _roi :serialize s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _id
       (write-long _id s)
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _sign
     (write-long (length _sign) s)
     (dolist (elem _sign)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _stop
     (setq _stop (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; sensor_msgs/RegionOfInterest _roi
     (send _roi :deserialize buf ptr-) (incf ptr- (send _roi :serialization-length))
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _sign
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sign (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _sign i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::TrafficSignObject :md5sum-) "089249b55d06265666c205f0a6631f4d")
(setf (get itri_msgs::TrafficSignObject :datatype-) "itri_msgs/TrafficSignObject")
(setf (get itri_msgs::TrafficSignObject :definition-)
      "bool stop

sensor_msgs/RegionOfInterest roi
float32 score

int32 id
float32 distance
string[] sign

================================================================================
MSG: sensor_msgs/RegionOfInterest
# This message is used to specify a region of interest within an image.
#
# When used to specify the ROI setting of the camera when the image was
# taken, the height and width fields should either match the height and
# width fields for the associated image; or height = width = 0
# indicates that the full resolution image was captured.

uint32 x_offset  # Leftmost pixel of the ROI
                 # (0 if the ROI includes the left edge of the image)
uint32 y_offset  # Topmost pixel of the ROI
                 # (0 if the ROI includes the top edge of the image)
uint32 height    # Height of ROI
uint32 width     # Width of ROI

# True if a distinct rectified ROI should be calculated from the \"raw\"
# ROI in this message. Typically this should be False if the full image
# is captured (ROI not used), and True if a subwindow is captured (ROI
# used).
bool do_rectify

")



(provide :itri_msgs/TrafficSignObject "089249b55d06265666c205f0a6631f4d")


