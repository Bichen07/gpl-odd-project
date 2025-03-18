; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude CameraObjectFrustum.msg.html

(cl:defclass <CameraObjectFrustum> (roslisp-msg-protocol:ros-message)
  ((Points
    :reader Points
    :initarg :Points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (FaceInsidePlanesNorm
    :reader FaceInsidePlanesNorm
    :initarg :FaceInsidePlanesNorm
    :type (cl:vector geometry_msgs-msg:Quaternion)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Quaternion :initial-element (cl:make-instance 'geometry_msgs-msg:Quaternion))))
)

(cl:defclass CameraObjectFrustum (<CameraObjectFrustum>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraObjectFrustum>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraObjectFrustum)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<CameraObjectFrustum> is deprecated: use itri_msgs-msg:CameraObjectFrustum instead.")))

(cl:ensure-generic-function 'Points-val :lambda-list '(m))
(cl:defmethod Points-val ((m <CameraObjectFrustum>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:Points-val is deprecated.  Use itri_msgs-msg:Points instead.")
  (Points m))

(cl:ensure-generic-function 'FaceInsidePlanesNorm-val :lambda-list '(m))
(cl:defmethod FaceInsidePlanesNorm-val ((m <CameraObjectFrustum>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:FaceInsidePlanesNorm-val is deprecated.  Use itri_msgs-msg:FaceInsidePlanesNorm instead.")
  (FaceInsidePlanesNorm m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraObjectFrustum>) ostream)
  "Serializes a message object of type '<CameraObjectFrustum>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'Points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'Points))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'FaceInsidePlanesNorm))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'FaceInsidePlanesNorm))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraObjectFrustum>) istream)
  "Deserializes a message object of type '<CameraObjectFrustum>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'Points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'Points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'FaceInsidePlanesNorm) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'FaceInsidePlanesNorm)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Quaternion))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraObjectFrustum>)))
  "Returns string type for a message object of type '<CameraObjectFrustum>"
  "itri_msgs/CameraObjectFrustum")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraObjectFrustum)))
  "Returns string type for a message object of type 'CameraObjectFrustum"
  "itri_msgs/CameraObjectFrustum")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraObjectFrustum>)))
  "Returns md5sum for a message object of type '<CameraObjectFrustum>"
  "be09e2784edfc92465e8db4d441a3c5b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraObjectFrustum)))
  "Returns md5sum for a message object of type 'CameraObjectFrustum"
  "be09e2784edfc92465e8db4d441a3c5b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraObjectFrustum>)))
  "Returns full string definition for message of type '<CameraObjectFrustum>"
  (cl:format cl:nil "geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraObjectFrustum)))
  "Returns full string definition for message of type 'CameraObjectFrustum"
  (cl:format cl:nil "geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraObjectFrustum>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'Points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'FaceInsidePlanesNorm) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraObjectFrustum>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraObjectFrustum
    (cl:cons ':Points (Points msg))
    (cl:cons ':FaceInsidePlanesNorm (FaceInsidePlanesNorm msg))
))
