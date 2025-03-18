;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficLightObject)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficLightObject (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECT")
  (make-package "ITRI_MSGS::TRAFFICLIGHTOBJECT"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(intern "*DETECTOR*" (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECT"))
(shadow '*DETECTOR* (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECT"))
(defconstant itri_msgs::TrafficLightObject::*DETECTOR* 0)
(intern "*RSU*" (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECT"))
(shadow '*RSU* (find-package "ITRI_MSGS::TRAFFICLIGHTOBJECT"))
(defconstant itri_msgs::TrafficLightObject::*RSU* 1)
(defclass itri_msgs::TrafficLightObject
  :super ros::object
  :slots (_dontCare _green _left _red _right _straight _yellow _flashyellow _flashred _blocked _traffic_light_map_points _roi _score _id _distance _remain_sec _lights _lightsroi _source ))

(defmethod itri_msgs::TrafficLightObject
  (:init
   (&key
    ((:dontCare __dontCare) nil)
    ((:green __green) nil)
    ((:left __left) nil)
    ((:red __red) nil)
    ((:right __right) nil)
    ((:straight __straight) nil)
    ((:yellow __yellow) nil)
    ((:flashyellow __flashyellow) nil)
    ((:flashred __flashred) nil)
    ((:blocked __blocked) nil)
    ((:traffic_light_map_points __traffic_light_map_points) (instance geometry_msgs::Polygon :init))
    ((:roi __roi) (instance sensor_msgs::RegionOfInterest :init))
    ((:score __score) 0.0)
    ((:id __id) 0)
    ((:distance __distance) 0.0)
    ((:remain_sec __remain_sec) 0.0)
    ((:lights __lights) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:lightsroi __lightsroi) (let (r) (dotimes (i 0) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
    ((:source __source) 0)
    )
   (send-super :init)
   (setq _dontCare __dontCare)
   (setq _green __green)
   (setq _left __left)
   (setq _red __red)
   (setq _right __right)
   (setq _straight __straight)
   (setq _yellow __yellow)
   (setq _flashyellow __flashyellow)
   (setq _flashred __flashred)
   (setq _blocked __blocked)
   (setq _traffic_light_map_points __traffic_light_map_points)
   (setq _roi __roi)
   (setq _score (float __score))
   (setq _id (round __id))
   (setq _distance (float __distance))
   (setq _remain_sec (float __remain_sec))
   (setq _lights __lights)
   (setq _lightsroi __lightsroi)
   (setq _source (round __source))
   self)
  (:dontCare
   (&optional __dontCare)
   (if __dontCare (setq _dontCare __dontCare)) _dontCare)
  (:green
   (&optional __green)
   (if __green (setq _green __green)) _green)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:red
   (&optional __red)
   (if __red (setq _red __red)) _red)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:straight
   (&optional __straight)
   (if __straight (setq _straight __straight)) _straight)
  (:yellow
   (&optional __yellow)
   (if __yellow (setq _yellow __yellow)) _yellow)
  (:flashyellow
   (&optional __flashyellow)
   (if __flashyellow (setq _flashyellow __flashyellow)) _flashyellow)
  (:flashred
   (&optional __flashred)
   (if __flashred (setq _flashred __flashred)) _flashred)
  (:blocked
   (&optional __blocked)
   (if __blocked (setq _blocked __blocked)) _blocked)
  (:traffic_light_map_points
   (&rest __traffic_light_map_points)
   (if (keywordp (car __traffic_light_map_points))
       (send* _traffic_light_map_points __traffic_light_map_points)
     (progn
       (if __traffic_light_map_points (setq _traffic_light_map_points (car __traffic_light_map_points)))
       _traffic_light_map_points)))
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
  (:remain_sec
   (&optional __remain_sec)
   (if __remain_sec (setq _remain_sec __remain_sec)) _remain_sec)
  (:lights
   (&optional __lights)
   (if __lights (setq _lights __lights)) _lights)
  (:lightsroi
   (&rest __lightsroi)
   (if (keywordp (car __lightsroi))
       (send* _lightsroi __lightsroi)
     (progn
       (if __lightsroi (setq _lightsroi (car __lightsroi)))
       _lightsroi)))
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:serialization-length
   ()
   (+
    ;; bool _dontCare
    1
    ;; bool _green
    1
    ;; bool _left
    1
    ;; bool _red
    1
    ;; bool _right
    1
    ;; bool _straight
    1
    ;; bool _yellow
    1
    ;; bool _flashyellow
    1
    ;; bool _flashred
    1
    ;; bool _blocked
    1
    ;; geometry_msgs/Polygon _traffic_light_map_points
    (send _traffic_light_map_points :serialization-length)
    ;; sensor_msgs/RegionOfInterest _roi
    (send _roi :serialization-length)
    ;; float32 _score
    4
    ;; int32 _id
    4
    ;; float32 _distance
    4
    ;; float32 _remain_sec
    4
    ;; string[] _lights
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _lights)) 4
    ;; sensor_msgs/RegionOfInterest[] _lightsroi
    (apply #'+ (send-all _lightsroi :serialization-length)) 4
    ;; uint8 _source
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _dontCare
       (if _dontCare (write-byte -1 s) (write-byte 0 s))
     ;; bool _green
       (if _green (write-byte -1 s) (write-byte 0 s))
     ;; bool _left
       (if _left (write-byte -1 s) (write-byte 0 s))
     ;; bool _red
       (if _red (write-byte -1 s) (write-byte 0 s))
     ;; bool _right
       (if _right (write-byte -1 s) (write-byte 0 s))
     ;; bool _straight
       (if _straight (write-byte -1 s) (write-byte 0 s))
     ;; bool _yellow
       (if _yellow (write-byte -1 s) (write-byte 0 s))
     ;; bool _flashyellow
       (if _flashyellow (write-byte -1 s) (write-byte 0 s))
     ;; bool _flashred
       (if _flashred (write-byte -1 s) (write-byte 0 s))
     ;; bool _blocked
       (if _blocked (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Polygon _traffic_light_map_points
       (send _traffic_light_map_points :serialize s)
     ;; sensor_msgs/RegionOfInterest _roi
       (send _roi :serialize s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _id
       (write-long _id s)
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _remain_sec
       (sys::poke _remain_sec (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _lights
     (write-long (length _lights) s)
     (dolist (elem _lights)
       (write-long (length elem) s) (princ elem s)
       )
     ;; sensor_msgs/RegionOfInterest[] _lightsroi
     (write-long (length _lightsroi) s)
     (dolist (elem _lightsroi)
       (send elem :serialize s)
       )
     ;; uint8 _source
       (write-byte _source s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _dontCare
     (setq _dontCare (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _green
     (setq _green (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _left
     (setq _left (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _red
     (setq _red (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _right
     (setq _right (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _straight
     (setq _straight (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _yellow
     (setq _yellow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _flashyellow
     (setq _flashyellow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _flashred
     (setq _flashred (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _blocked
     (setq _blocked (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/Polygon _traffic_light_map_points
     (send _traffic_light_map_points :deserialize buf ptr-) (incf ptr- (send _traffic_light_map_points :serialization-length))
   ;; sensor_msgs/RegionOfInterest _roi
     (send _roi :deserialize buf ptr-) (incf ptr- (send _roi :serialization-length))
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _remain_sec
     (setq _remain_sec (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _lights
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lights (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _lights i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; sensor_msgs/RegionOfInterest[] _lightsroi
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lightsroi (let (r) (dotimes (i n) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
     (dolist (elem- _lightsroi)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8 _source
     (setq _source (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::TrafficLightObject :md5sum-) "f24c9677aaa490b50d0084132ed5fd5e")
(setf (get itri_msgs::TrafficLightObject :datatype-) "itri_msgs/TrafficLightObject")
(setf (get itri_msgs::TrafficLightObject :definition-)
      "bool dontCare
bool green
bool left
bool red
bool right
bool straight
bool yellow
bool flashyellow
bool flashred

bool blocked
geometry_msgs/Polygon traffic_light_map_points
sensor_msgs/RegionOfInterest roi
float32 score

int32 id
float32 distance
float32 remain_sec
string[] lights
sensor_msgs/RegionOfInterest[] lightsroi

uint8 DETECTOR=0
uint8 RSU=1
uint8 source

================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
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



(provide :itri_msgs/TrafficLightObject "f24c9677aaa490b50d0084132ed5fd5e")


