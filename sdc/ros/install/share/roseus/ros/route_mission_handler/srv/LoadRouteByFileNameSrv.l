;; Auto-generated. Do not edit!


(when (boundp 'route_mission_handler::LoadRouteByFileNameSrv)
  (if (not (find-package "ROUTE_MISSION_HANDLER"))
    (make-package "ROUTE_MISSION_HANDLER"))
  (shadow 'LoadRouteByFileNameSrv (find-package "ROUTE_MISSION_HANDLER")))
(unless (find-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRV")
  (make-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRV"))
(unless (find-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRVREQUEST")
  (make-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRVREQUEST"))
(unless (find-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRVRESPONSE")
  (make-package "ROUTE_MISSION_HANDLER::LOADROUTEBYFILENAMESRVRESPONSE"))

(in-package "ROS")





(defclass route_mission_handler::LoadRouteByFileNameSrvRequest
  :super ros::object
  :slots (_selectedRouteFileName ))

(defmethod route_mission_handler::LoadRouteByFileNameSrvRequest
  (:init
   (&key
    ((:selectedRouteFileName __selectedRouteFileName) "")
    )
   (send-super :init)
   (setq _selectedRouteFileName (string __selectedRouteFileName))
   self)
  (:selectedRouteFileName
   (&optional __selectedRouteFileName)
   (if __selectedRouteFileName (setq _selectedRouteFileName __selectedRouteFileName)) _selectedRouteFileName)
  (:serialization-length
   ()
   (+
    ;; string _selectedRouteFileName
    4 (length _selectedRouteFileName)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _selectedRouteFileName
       (write-long (length _selectedRouteFileName) s) (princ _selectedRouteFileName s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _selectedRouteFileName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _selectedRouteFileName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass route_mission_handler::LoadRouteByFileNameSrvResponse
  :super ros::object
  :slots ())

(defmethod route_mission_handler::LoadRouteByFileNameSrvResponse
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

(defclass route_mission_handler::LoadRouteByFileNameSrv
  :super ros::object
  :slots ())

(setf (get route_mission_handler::LoadRouteByFileNameSrv :md5sum-) "68217d558fc6fb063653bf22c8dd0a04")
(setf (get route_mission_handler::LoadRouteByFileNameSrv :datatype-) "route_mission_handler/LoadRouteByFileNameSrv")
(setf (get route_mission_handler::LoadRouteByFileNameSrv :request) route_mission_handler::LoadRouteByFileNameSrvRequest)
(setf (get route_mission_handler::LoadRouteByFileNameSrv :response) route_mission_handler::LoadRouteByFileNameSrvResponse)

(defmethod route_mission_handler::LoadRouteByFileNameSrvRequest
  (:response () (instance route_mission_handler::LoadRouteByFileNameSrvResponse :init)))

(setf (get route_mission_handler::LoadRouteByFileNameSrvRequest :md5sum-) "68217d558fc6fb063653bf22c8dd0a04")
(setf (get route_mission_handler::LoadRouteByFileNameSrvRequest :datatype-) "route_mission_handler/LoadRouteByFileNameSrvRequest")
(setf (get route_mission_handler::LoadRouteByFileNameSrvRequest :definition-)
      "string selectedRouteFileName
---

")

(setf (get route_mission_handler::LoadRouteByFileNameSrvResponse :md5sum-) "68217d558fc6fb063653bf22c8dd0a04")
(setf (get route_mission_handler::LoadRouteByFileNameSrvResponse :datatype-) "route_mission_handler/LoadRouteByFileNameSrvResponse")
(setf (get route_mission_handler::LoadRouteByFileNameSrvResponse :definition-)
      "string selectedRouteFileName
---

")



(provide :route_mission_handler/LoadRouteByFileNameSrv "68217d558fc6fb063653bf22c8dd0a04")


