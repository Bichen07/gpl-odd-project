; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude PointsMapInfo.msg.html

(cl:defclass <PointsMapInfo> (roslisp-msg-protocol:ros-message)
  ((num_submaps
    :reader num_submaps
    :initarg :num_submaps
    :type cl:integer
    :initform 0)
   (total_points
    :reader total_points
    :initarg :total_points
    :type cl:integer
    :initform 0)
   (gps_reference
    :reader gps_reference
    :initarg :gps_reference
    :type itri_msgs-msg:GPS
    :initform (cl:make-instance 'itri_msgs-msg:GPS)))
)

(cl:defclass PointsMapInfo (<PointsMapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PointsMapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PointsMapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<PointsMapInfo> is deprecated: use itri_msgs-msg:PointsMapInfo instead.")))

(cl:ensure-generic-function 'num_submaps-val :lambda-list '(m))
(cl:defmethod num_submaps-val ((m <PointsMapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:num_submaps-val is deprecated.  Use itri_msgs-msg:num_submaps instead.")
  (num_submaps m))

(cl:ensure-generic-function 'total_points-val :lambda-list '(m))
(cl:defmethod total_points-val ((m <PointsMapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:total_points-val is deprecated.  Use itri_msgs-msg:total_points instead.")
  (total_points m))

(cl:ensure-generic-function 'gps_reference-val :lambda-list '(m))
(cl:defmethod gps_reference-val ((m <PointsMapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gps_reference-val is deprecated.  Use itri_msgs-msg:gps_reference instead.")
  (gps_reference m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PointsMapInfo>) ostream)
  "Serializes a message object of type '<PointsMapInfo>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_submaps)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'num_submaps)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'num_submaps)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'num_submaps)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'total_points)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'total_points)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'total_points)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'total_points)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gps_reference) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PointsMapInfo>) istream)
  "Deserializes a message object of type '<PointsMapInfo>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num_submaps)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'num_submaps)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'num_submaps)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'num_submaps)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'total_points)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'total_points)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'total_points)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'total_points)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gps_reference) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PointsMapInfo>)))
  "Returns string type for a message object of type '<PointsMapInfo>"
  "itri_msgs/PointsMapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PointsMapInfo)))
  "Returns string type for a message object of type 'PointsMapInfo"
  "itri_msgs/PointsMapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PointsMapInfo>)))
  "Returns md5sum for a message object of type '<PointsMapInfo>"
  "d0f5e60c33a648ff40401f308be12589")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PointsMapInfo)))
  "Returns md5sum for a message object of type 'PointsMapInfo"
  "d0f5e60c33a648ff40401f308be12589")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PointsMapInfo>)))
  "Returns full string definition for message of type '<PointsMapInfo>"
  (cl:format cl:nil "uint32 num_submaps~%uint32 total_points~%GPS gps_reference~%~%================================================================================~%MSG: itri_msgs/GPS~%float64 latitude~%float64 longitude~%float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PointsMapInfo)))
  "Returns full string definition for message of type 'PointsMapInfo"
  (cl:format cl:nil "uint32 num_submaps~%uint32 total_points~%GPS gps_reference~%~%================================================================================~%MSG: itri_msgs/GPS~%float64 latitude~%float64 longitude~%float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PointsMapInfo>))
  (cl:+ 0
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gps_reference))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PointsMapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'PointsMapInfo
    (cl:cons ':num_submaps (num_submaps msg))
    (cl:cons ':total_points (total_points msg))
    (cl:cons ':gps_reference (gps_reference msg))
))
