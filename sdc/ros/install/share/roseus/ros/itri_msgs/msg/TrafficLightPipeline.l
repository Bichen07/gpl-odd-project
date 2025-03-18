;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::TrafficLightPipeline)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'TrafficLightPipeline (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::TRAFFICLIGHTPIPELINE")
  (make-package "ITRI_MSGS::TRAFFICLIGHTPIPELINE"))

(in-package "ROS")
;;//! \htmlinclude TrafficLightPipeline.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::TrafficLightPipeline
  :super ros::object
  :slots (_header _image_topic _tone_map_full_image _lights_full_image _id _light_status _light_rules _x_enlarge_factor _y_enlarge_factor _x_offset_factor _y_offset_factor _distance _tone_map_roi_image _lights_roi_image _traffic_light_map_points _traffic_light_points _traffic_light_roi _all_traffic_light_points _all_traffic_light_roi _tone_map_detect_light_box _tone_map_detect_light_status _lights_detect_light_status _merged_result_light_box _merged_result_red _merged_result_yellow _merged_result_green _merged_result_left _merged_result_straight _merged_result_right _red _yellow _green _left _straight _right _flashred _flashyellow ))

(defmethod itri_msgs::TrafficLightPipeline
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:image_topic __image_topic) "")
    ((:tone_map_full_image __tone_map_full_image) (instance sensor_msgs::Image :init))
    ((:lights_full_image __lights_full_image) (instance sensor_msgs::Image :init))
    ((:id __id) 0)
    ((:light_status __light_status) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:light_rules __light_rules) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:x_enlarge_factor __x_enlarge_factor) 0.0)
    ((:y_enlarge_factor __y_enlarge_factor) 0.0)
    ((:x_offset_factor __x_offset_factor) 0.0)
    ((:y_offset_factor __y_offset_factor) 0.0)
    ((:distance __distance) 0)
    ((:tone_map_roi_image __tone_map_roi_image) (instance sensor_msgs::Image :init))
    ((:lights_roi_image __lights_roi_image) (instance sensor_msgs::Image :init))
    ((:traffic_light_map_points __traffic_light_map_points) (instance geometry_msgs::Polygon :init))
    ((:traffic_light_points __traffic_light_points) (instance geometry_msgs::Polygon :init))
    ((:traffic_light_roi __traffic_light_roi) (instance sensor_msgs::RegionOfInterest :init))
    ((:all_traffic_light_points __all_traffic_light_points) (instance geometry_msgs::Polygon :init))
    ((:all_traffic_light_roi __all_traffic_light_roi) (let (r) (dotimes (i 0) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
    ((:tone_map_detect_light_box __tone_map_detect_light_box) (instance itri_msgs::ImageObj :init))
    ((:tone_map_detect_light_status __tone_map_detect_light_status) (instance itri_msgs::ImageObj :init))
    ((:lights_detect_light_status __lights_detect_light_status) (instance itri_msgs::ImageObj :init))
    ((:merged_result_light_box __merged_result_light_box) nil)
    ((:merged_result_red __merged_result_red) nil)
    ((:merged_result_yellow __merged_result_yellow) nil)
    ((:merged_result_green __merged_result_green) nil)
    ((:merged_result_left __merged_result_left) nil)
    ((:merged_result_straight __merged_result_straight) nil)
    ((:merged_result_right __merged_result_right) nil)
    ((:red __red) nil)
    ((:yellow __yellow) nil)
    ((:green __green) nil)
    ((:left __left) nil)
    ((:straight __straight) nil)
    ((:right __right) nil)
    ((:flashred __flashred) nil)
    ((:flashyellow __flashyellow) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _image_topic (string __image_topic))
   (setq _tone_map_full_image __tone_map_full_image)
   (setq _lights_full_image __lights_full_image)
   (setq _id (round __id))
   (setq _light_status __light_status)
   (setq _light_rules __light_rules)
   (setq _x_enlarge_factor (float __x_enlarge_factor))
   (setq _y_enlarge_factor (float __y_enlarge_factor))
   (setq _x_offset_factor (float __x_offset_factor))
   (setq _y_offset_factor (float __y_offset_factor))
   (setq _distance (round __distance))
   (setq _tone_map_roi_image __tone_map_roi_image)
   (setq _lights_roi_image __lights_roi_image)
   (setq _traffic_light_map_points __traffic_light_map_points)
   (setq _traffic_light_points __traffic_light_points)
   (setq _traffic_light_roi __traffic_light_roi)
   (setq _all_traffic_light_points __all_traffic_light_points)
   (setq _all_traffic_light_roi __all_traffic_light_roi)
   (setq _tone_map_detect_light_box __tone_map_detect_light_box)
   (setq _tone_map_detect_light_status __tone_map_detect_light_status)
   (setq _lights_detect_light_status __lights_detect_light_status)
   (setq _merged_result_light_box __merged_result_light_box)
   (setq _merged_result_red __merged_result_red)
   (setq _merged_result_yellow __merged_result_yellow)
   (setq _merged_result_green __merged_result_green)
   (setq _merged_result_left __merged_result_left)
   (setq _merged_result_straight __merged_result_straight)
   (setq _merged_result_right __merged_result_right)
   (setq _red __red)
   (setq _yellow __yellow)
   (setq _green __green)
   (setq _left __left)
   (setq _straight __straight)
   (setq _right __right)
   (setq _flashred __flashred)
   (setq _flashyellow __flashyellow)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:image_topic
   (&optional __image_topic)
   (if __image_topic (setq _image_topic __image_topic)) _image_topic)
  (:tone_map_full_image
   (&rest __tone_map_full_image)
   (if (keywordp (car __tone_map_full_image))
       (send* _tone_map_full_image __tone_map_full_image)
     (progn
       (if __tone_map_full_image (setq _tone_map_full_image (car __tone_map_full_image)))
       _tone_map_full_image)))
  (:lights_full_image
   (&rest __lights_full_image)
   (if (keywordp (car __lights_full_image))
       (send* _lights_full_image __lights_full_image)
     (progn
       (if __lights_full_image (setq _lights_full_image (car __lights_full_image)))
       _lights_full_image)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:light_status
   (&optional __light_status)
   (if __light_status (setq _light_status __light_status)) _light_status)
  (:light_rules
   (&optional __light_rules)
   (if __light_rules (setq _light_rules __light_rules)) _light_rules)
  (:x_enlarge_factor
   (&optional __x_enlarge_factor)
   (if __x_enlarge_factor (setq _x_enlarge_factor __x_enlarge_factor)) _x_enlarge_factor)
  (:y_enlarge_factor
   (&optional __y_enlarge_factor)
   (if __y_enlarge_factor (setq _y_enlarge_factor __y_enlarge_factor)) _y_enlarge_factor)
  (:x_offset_factor
   (&optional __x_offset_factor)
   (if __x_offset_factor (setq _x_offset_factor __x_offset_factor)) _x_offset_factor)
  (:y_offset_factor
   (&optional __y_offset_factor)
   (if __y_offset_factor (setq _y_offset_factor __y_offset_factor)) _y_offset_factor)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:tone_map_roi_image
   (&rest __tone_map_roi_image)
   (if (keywordp (car __tone_map_roi_image))
       (send* _tone_map_roi_image __tone_map_roi_image)
     (progn
       (if __tone_map_roi_image (setq _tone_map_roi_image (car __tone_map_roi_image)))
       _tone_map_roi_image)))
  (:lights_roi_image
   (&rest __lights_roi_image)
   (if (keywordp (car __lights_roi_image))
       (send* _lights_roi_image __lights_roi_image)
     (progn
       (if __lights_roi_image (setq _lights_roi_image (car __lights_roi_image)))
       _lights_roi_image)))
  (:traffic_light_map_points
   (&rest __traffic_light_map_points)
   (if (keywordp (car __traffic_light_map_points))
       (send* _traffic_light_map_points __traffic_light_map_points)
     (progn
       (if __traffic_light_map_points (setq _traffic_light_map_points (car __traffic_light_map_points)))
       _traffic_light_map_points)))
  (:traffic_light_points
   (&rest __traffic_light_points)
   (if (keywordp (car __traffic_light_points))
       (send* _traffic_light_points __traffic_light_points)
     (progn
       (if __traffic_light_points (setq _traffic_light_points (car __traffic_light_points)))
       _traffic_light_points)))
  (:traffic_light_roi
   (&rest __traffic_light_roi)
   (if (keywordp (car __traffic_light_roi))
       (send* _traffic_light_roi __traffic_light_roi)
     (progn
       (if __traffic_light_roi (setq _traffic_light_roi (car __traffic_light_roi)))
       _traffic_light_roi)))
  (:all_traffic_light_points
   (&rest __all_traffic_light_points)
   (if (keywordp (car __all_traffic_light_points))
       (send* _all_traffic_light_points __all_traffic_light_points)
     (progn
       (if __all_traffic_light_points (setq _all_traffic_light_points (car __all_traffic_light_points)))
       _all_traffic_light_points)))
  (:all_traffic_light_roi
   (&rest __all_traffic_light_roi)
   (if (keywordp (car __all_traffic_light_roi))
       (send* _all_traffic_light_roi __all_traffic_light_roi)
     (progn
       (if __all_traffic_light_roi (setq _all_traffic_light_roi (car __all_traffic_light_roi)))
       _all_traffic_light_roi)))
  (:tone_map_detect_light_box
   (&rest __tone_map_detect_light_box)
   (if (keywordp (car __tone_map_detect_light_box))
       (send* _tone_map_detect_light_box __tone_map_detect_light_box)
     (progn
       (if __tone_map_detect_light_box (setq _tone_map_detect_light_box (car __tone_map_detect_light_box)))
       _tone_map_detect_light_box)))
  (:tone_map_detect_light_status
   (&rest __tone_map_detect_light_status)
   (if (keywordp (car __tone_map_detect_light_status))
       (send* _tone_map_detect_light_status __tone_map_detect_light_status)
     (progn
       (if __tone_map_detect_light_status (setq _tone_map_detect_light_status (car __tone_map_detect_light_status)))
       _tone_map_detect_light_status)))
  (:lights_detect_light_status
   (&rest __lights_detect_light_status)
   (if (keywordp (car __lights_detect_light_status))
       (send* _lights_detect_light_status __lights_detect_light_status)
     (progn
       (if __lights_detect_light_status (setq _lights_detect_light_status (car __lights_detect_light_status)))
       _lights_detect_light_status)))
  (:merged_result_light_box
   (&optional __merged_result_light_box)
   (if __merged_result_light_box (setq _merged_result_light_box __merged_result_light_box)) _merged_result_light_box)
  (:merged_result_red
   (&optional __merged_result_red)
   (if __merged_result_red (setq _merged_result_red __merged_result_red)) _merged_result_red)
  (:merged_result_yellow
   (&optional __merged_result_yellow)
   (if __merged_result_yellow (setq _merged_result_yellow __merged_result_yellow)) _merged_result_yellow)
  (:merged_result_green
   (&optional __merged_result_green)
   (if __merged_result_green (setq _merged_result_green __merged_result_green)) _merged_result_green)
  (:merged_result_left
   (&optional __merged_result_left)
   (if __merged_result_left (setq _merged_result_left __merged_result_left)) _merged_result_left)
  (:merged_result_straight
   (&optional __merged_result_straight)
   (if __merged_result_straight (setq _merged_result_straight __merged_result_straight)) _merged_result_straight)
  (:merged_result_right
   (&optional __merged_result_right)
   (if __merged_result_right (setq _merged_result_right __merged_result_right)) _merged_result_right)
  (:red
   (&optional __red)
   (if __red (setq _red __red)) _red)
  (:yellow
   (&optional __yellow)
   (if __yellow (setq _yellow __yellow)) _yellow)
  (:green
   (&optional __green)
   (if __green (setq _green __green)) _green)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:straight
   (&optional __straight)
   (if __straight (setq _straight __straight)) _straight)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:flashred
   (&optional __flashred)
   (if __flashred (setq _flashred __flashred)) _flashred)
  (:flashyellow
   (&optional __flashyellow)
   (if __flashyellow (setq _flashyellow __flashyellow)) _flashyellow)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _image_topic
    4 (length _image_topic)
    ;; sensor_msgs/Image _tone_map_full_image
    (send _tone_map_full_image :serialization-length)
    ;; sensor_msgs/Image _lights_full_image
    (send _lights_full_image :serialization-length)
    ;; int32 _id
    4
    ;; string[] _light_status
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _light_status)) 4
    ;; string[] _light_rules
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _light_rules)) 4
    ;; float32 _x_enlarge_factor
    4
    ;; float32 _y_enlarge_factor
    4
    ;; float32 _x_offset_factor
    4
    ;; float32 _y_offset_factor
    4
    ;; int32 _distance
    4
    ;; sensor_msgs/Image _tone_map_roi_image
    (send _tone_map_roi_image :serialization-length)
    ;; sensor_msgs/Image _lights_roi_image
    (send _lights_roi_image :serialization-length)
    ;; geometry_msgs/Polygon _traffic_light_map_points
    (send _traffic_light_map_points :serialization-length)
    ;; geometry_msgs/Polygon _traffic_light_points
    (send _traffic_light_points :serialization-length)
    ;; sensor_msgs/RegionOfInterest _traffic_light_roi
    (send _traffic_light_roi :serialization-length)
    ;; geometry_msgs/Polygon _all_traffic_light_points
    (send _all_traffic_light_points :serialization-length)
    ;; sensor_msgs/RegionOfInterest[] _all_traffic_light_roi
    (apply #'+ (send-all _all_traffic_light_roi :serialization-length)) 4
    ;; itri_msgs/ImageObj _tone_map_detect_light_box
    (send _tone_map_detect_light_box :serialization-length)
    ;; itri_msgs/ImageObj _tone_map_detect_light_status
    (send _tone_map_detect_light_status :serialization-length)
    ;; itri_msgs/ImageObj _lights_detect_light_status
    (send _lights_detect_light_status :serialization-length)
    ;; bool _merged_result_light_box
    1
    ;; bool _merged_result_red
    1
    ;; bool _merged_result_yellow
    1
    ;; bool _merged_result_green
    1
    ;; bool _merged_result_left
    1
    ;; bool _merged_result_straight
    1
    ;; bool _merged_result_right
    1
    ;; bool _red
    1
    ;; bool _yellow
    1
    ;; bool _green
    1
    ;; bool _left
    1
    ;; bool _straight
    1
    ;; bool _right
    1
    ;; bool _flashred
    1
    ;; bool _flashyellow
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _image_topic
       (write-long (length _image_topic) s) (princ _image_topic s)
     ;; sensor_msgs/Image _tone_map_full_image
       (send _tone_map_full_image :serialize s)
     ;; sensor_msgs/Image _lights_full_image
       (send _lights_full_image :serialize s)
     ;; int32 _id
       (write-long _id s)
     ;; string[] _light_status
     (write-long (length _light_status) s)
     (dolist (elem _light_status)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _light_rules
     (write-long (length _light_rules) s)
     (dolist (elem _light_rules)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _x_enlarge_factor
       (sys::poke _x_enlarge_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_enlarge_factor
       (sys::poke _y_enlarge_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x_offset_factor
       (sys::poke _x_offset_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y_offset_factor
       (sys::poke _y_offset_factor (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _distance
       (write-long _distance s)
     ;; sensor_msgs/Image _tone_map_roi_image
       (send _tone_map_roi_image :serialize s)
     ;; sensor_msgs/Image _lights_roi_image
       (send _lights_roi_image :serialize s)
     ;; geometry_msgs/Polygon _traffic_light_map_points
       (send _traffic_light_map_points :serialize s)
     ;; geometry_msgs/Polygon _traffic_light_points
       (send _traffic_light_points :serialize s)
     ;; sensor_msgs/RegionOfInterest _traffic_light_roi
       (send _traffic_light_roi :serialize s)
     ;; geometry_msgs/Polygon _all_traffic_light_points
       (send _all_traffic_light_points :serialize s)
     ;; sensor_msgs/RegionOfInterest[] _all_traffic_light_roi
     (write-long (length _all_traffic_light_roi) s)
     (dolist (elem _all_traffic_light_roi)
       (send elem :serialize s)
       )
     ;; itri_msgs/ImageObj _tone_map_detect_light_box
       (send _tone_map_detect_light_box :serialize s)
     ;; itri_msgs/ImageObj _tone_map_detect_light_status
       (send _tone_map_detect_light_status :serialize s)
     ;; itri_msgs/ImageObj _lights_detect_light_status
       (send _lights_detect_light_status :serialize s)
     ;; bool _merged_result_light_box
       (if _merged_result_light_box (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_red
       (if _merged_result_red (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_yellow
       (if _merged_result_yellow (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_green
       (if _merged_result_green (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_left
       (if _merged_result_left (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_straight
       (if _merged_result_straight (write-byte -1 s) (write-byte 0 s))
     ;; bool _merged_result_right
       (if _merged_result_right (write-byte -1 s) (write-byte 0 s))
     ;; bool _red
       (if _red (write-byte -1 s) (write-byte 0 s))
     ;; bool _yellow
       (if _yellow (write-byte -1 s) (write-byte 0 s))
     ;; bool _green
       (if _green (write-byte -1 s) (write-byte 0 s))
     ;; bool _left
       (if _left (write-byte -1 s) (write-byte 0 s))
     ;; bool _straight
       (if _straight (write-byte -1 s) (write-byte 0 s))
     ;; bool _right
       (if _right (write-byte -1 s) (write-byte 0 s))
     ;; bool _flashred
       (if _flashred (write-byte -1 s) (write-byte 0 s))
     ;; bool _flashyellow
       (if _flashyellow (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _image_topic
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _image_topic (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; sensor_msgs/Image _tone_map_full_image
     (send _tone_map_full_image :deserialize buf ptr-) (incf ptr- (send _tone_map_full_image :serialization-length))
   ;; sensor_msgs/Image _lights_full_image
     (send _lights_full_image :deserialize buf ptr-) (incf ptr- (send _lights_full_image :serialization-length))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _light_status
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _light_status (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _light_status i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _light_rules
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _light_rules (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _light_rules i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _x_enlarge_factor
     (setq _x_enlarge_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_enlarge_factor
     (setq _y_enlarge_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x_offset_factor
     (setq _x_offset_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y_offset_factor
     (setq _y_offset_factor (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _distance
     (setq _distance (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; sensor_msgs/Image _tone_map_roi_image
     (send _tone_map_roi_image :deserialize buf ptr-) (incf ptr- (send _tone_map_roi_image :serialization-length))
   ;; sensor_msgs/Image _lights_roi_image
     (send _lights_roi_image :deserialize buf ptr-) (incf ptr- (send _lights_roi_image :serialization-length))
   ;; geometry_msgs/Polygon _traffic_light_map_points
     (send _traffic_light_map_points :deserialize buf ptr-) (incf ptr- (send _traffic_light_map_points :serialization-length))
   ;; geometry_msgs/Polygon _traffic_light_points
     (send _traffic_light_points :deserialize buf ptr-) (incf ptr- (send _traffic_light_points :serialization-length))
   ;; sensor_msgs/RegionOfInterest _traffic_light_roi
     (send _traffic_light_roi :deserialize buf ptr-) (incf ptr- (send _traffic_light_roi :serialization-length))
   ;; geometry_msgs/Polygon _all_traffic_light_points
     (send _all_traffic_light_points :deserialize buf ptr-) (incf ptr- (send _all_traffic_light_points :serialization-length))
   ;; sensor_msgs/RegionOfInterest[] _all_traffic_light_roi
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _all_traffic_light_roi (let (r) (dotimes (i n) (push (instance sensor_msgs::RegionOfInterest :init) r)) r))
     (dolist (elem- _all_traffic_light_roi)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/ImageObj _tone_map_detect_light_box
     (send _tone_map_detect_light_box :deserialize buf ptr-) (incf ptr- (send _tone_map_detect_light_box :serialization-length))
   ;; itri_msgs/ImageObj _tone_map_detect_light_status
     (send _tone_map_detect_light_status :deserialize buf ptr-) (incf ptr- (send _tone_map_detect_light_status :serialization-length))
   ;; itri_msgs/ImageObj _lights_detect_light_status
     (send _lights_detect_light_status :deserialize buf ptr-) (incf ptr- (send _lights_detect_light_status :serialization-length))
   ;; bool _merged_result_light_box
     (setq _merged_result_light_box (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_red
     (setq _merged_result_red (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_yellow
     (setq _merged_result_yellow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_green
     (setq _merged_result_green (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_left
     (setq _merged_result_left (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_straight
     (setq _merged_result_straight (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _merged_result_right
     (setq _merged_result_right (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _red
     (setq _red (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _yellow
     (setq _yellow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _green
     (setq _green (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _left
     (setq _left (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _straight
     (setq _straight (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _right
     (setq _right (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _flashred
     (setq _flashred (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _flashyellow
     (setq _flashyellow (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::TrafficLightPipeline :md5sum-) "9f2248593a306be31f383e3661e2dc25")
(setf (get itri_msgs::TrafficLightPipeline :datatype-) "itri_msgs/TrafficLightPipeline")
(setf (get itri_msgs::TrafficLightPipeline :definition-)
      "Header header

# image info
string image_topic
sensor_msgs/Image tone_map_full_image
sensor_msgs/Image lights_full_image

# semantic map info
int32 id
string[] light_status
string[] light_rules

float32 x_enlarge_factor
float32 y_enlarge_factor
float32 x_offset_factor
float32 y_offset_factor

# traffic_light_projection info
int32 distance
sensor_msgs/Image tone_map_roi_image
sensor_msgs/Image lights_roi_image
geometry_msgs/Polygon traffic_light_map_points

geometry_msgs/Polygon traffic_light_points
sensor_msgs/RegionOfInterest traffic_light_roi
geometry_msgs/Polygon all_traffic_light_points
sensor_msgs/RegionOfInterest[] all_traffic_light_roi

# traffic_light_detection info
itri_msgs/ImageObj tone_map_detect_light_box
itri_msgs/ImageObj tone_map_detect_light_status
itri_msgs/ImageObj lights_detect_light_status

# traffic_light_merge info
bool merged_result_light_box
bool merged_result_red
bool merged_result_yellow
bool merged_result_green
bool merged_result_left
bool merged_result_straight
bool merged_result_right

# traffic_light_queue info
bool red
bool yellow
bool green
bool left
bool straight
bool right
bool flashred
bool flashyellow

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

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

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

================================================================================
MSG: itri_msgs/ImageObj
Header header
string type
ImageRect[] obj
# XXX Should this message have 'score' ?

================================================================================
MSG: itri_msgs/ImageRect
int32 id
int32 x
int32 y
int32 height
int32 width
float32 score
string cls

")



(provide :itri_msgs/TrafficLightPipeline "9f2248593a306be31f383e3661e2dc25")


