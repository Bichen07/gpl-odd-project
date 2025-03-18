; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude NavgRoad.msg.html

(cl:defclass <NavgRoad> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (positiveLaneNum
    :reader positiveLaneNum
    :initarg :positiveLaneNum
    :type cl:integer
    :initform 0)
   (negativeLaneNum
    :reader negativeLaneNum
    :initarg :negativeLaneNum
    :type cl:integer
    :initform 0)
   (twoWay
    :reader twoWay
    :initarg :twoWay
    :type cl:boolean
    :initform cl:nil)
   (positiveLaneIds
    :reader positiveLaneIds
    :initarg :positiveLaneIds
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (negativeLaneIds
    :reader negativeLaneIds
    :initarg :negativeLaneIds
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0)
   (r_class
    :reader r_class
    :initarg :r_class
    :type cl:integer
    :initform 0)
   (routing
    :reader routing
    :initarg :routing
    :type cl:integer
    :initform 0)
   (n_as
    :reader n_as
    :initarg :n_as
    :type cl:float
    :initform 0.0)
   (n_kph
    :reader n_kph
    :initarg :n_kph
    :type cl:float
    :initform 0.0)
   (p_as
    :reader p_as
    :initarg :p_as
    :type cl:float
    :initform 0.0)
   (p_kph
    :reader p_kph
    :initarg :p_kph
    :type cl:float
    :initform 0.0)
   (length
    :reader length
    :initarg :length
    :type cl:float
    :initform 0.0)
   (points
    :reader points
    :initarg :points
    :type (cl:vector route_mission_handler-msg:ItriPoint)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ItriPoint :initial-element (cl:make-instance 'route_mission_handler-msg:ItriPoint)))
   (heads
    :reader heads
    :initarg :heads
    :type (cl:vector route_mission_handler-msg:ConnectedNavgRoad)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ConnectedNavgRoad :initial-element (cl:make-instance 'route_mission_handler-msg:ConnectedNavgRoad)))
   (tails
    :reader tails
    :initarg :tails
    :type (cl:vector route_mission_handler-msg:ConnectedNavgRoad)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ConnectedNavgRoad :initial-element (cl:make-instance 'route_mission_handler-msg:ConnectedNavgRoad)))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0))
)

(cl:defclass NavgRoad (<NavgRoad>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavgRoad>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavgRoad)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<NavgRoad> is deprecated: use route_mission_handler-msg:NavgRoad instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'positiveLaneNum-val :lambda-list '(m))
(cl:defmethod positiveLaneNum-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:positiveLaneNum-val is deprecated.  Use route_mission_handler-msg:positiveLaneNum instead.")
  (positiveLaneNum m))

(cl:ensure-generic-function 'negativeLaneNum-val :lambda-list '(m))
(cl:defmethod negativeLaneNum-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:negativeLaneNum-val is deprecated.  Use route_mission_handler-msg:negativeLaneNum instead.")
  (negativeLaneNum m))

(cl:ensure-generic-function 'twoWay-val :lambda-list '(m))
(cl:defmethod twoWay-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:twoWay-val is deprecated.  Use route_mission_handler-msg:twoWay instead.")
  (twoWay m))

(cl:ensure-generic-function 'positiveLaneIds-val :lambda-list '(m))
(cl:defmethod positiveLaneIds-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:positiveLaneIds-val is deprecated.  Use route_mission_handler-msg:positiveLaneIds instead.")
  (positiveLaneIds m))

(cl:ensure-generic-function 'negativeLaneIds-val :lambda-list '(m))
(cl:defmethod negativeLaneIds-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:negativeLaneIds-val is deprecated.  Use route_mission_handler-msg:negativeLaneIds instead.")
  (negativeLaneIds m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:mode-val is deprecated.  Use route_mission_handler-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'r_class-val :lambda-list '(m))
(cl:defmethod r_class-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:r_class-val is deprecated.  Use route_mission_handler-msg:r_class instead.")
  (r_class m))

(cl:ensure-generic-function 'routing-val :lambda-list '(m))
(cl:defmethod routing-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:routing-val is deprecated.  Use route_mission_handler-msg:routing instead.")
  (routing m))

(cl:ensure-generic-function 'n_as-val :lambda-list '(m))
(cl:defmethod n_as-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:n_as-val is deprecated.  Use route_mission_handler-msg:n_as instead.")
  (n_as m))

(cl:ensure-generic-function 'n_kph-val :lambda-list '(m))
(cl:defmethod n_kph-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:n_kph-val is deprecated.  Use route_mission_handler-msg:n_kph instead.")
  (n_kph m))

(cl:ensure-generic-function 'p_as-val :lambda-list '(m))
(cl:defmethod p_as-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:p_as-val is deprecated.  Use route_mission_handler-msg:p_as instead.")
  (p_as m))

(cl:ensure-generic-function 'p_kph-val :lambda-list '(m))
(cl:defmethod p_kph-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:p_kph-val is deprecated.  Use route_mission_handler-msg:p_kph instead.")
  (p_kph m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:length-val is deprecated.  Use route_mission_handler-msg:length instead.")
  (length m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:points-val is deprecated.  Use route_mission_handler-msg:points instead.")
  (points m))

(cl:ensure-generic-function 'heads-val :lambda-list '(m))
(cl:defmethod heads-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:heads-val is deprecated.  Use route_mission_handler-msg:heads instead.")
  (heads m))

(cl:ensure-generic-function 'tails-val :lambda-list '(m))
(cl:defmethod tails-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:tails-val is deprecated.  Use route_mission_handler-msg:tails instead.")
  (tails m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <NavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:type-val is deprecated.  Use route_mission_handler-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<NavgRoad>)))
    "Constants for message type '<NavgRoad>"
  '((:ITRI_AREA . 5)
    (:EXPRESS_WAY . 8)
    (:EXIT_GATEWAY . 20)
    (:ENTRY_GATEWAY . 21))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'NavgRoad)))
    "Constants for message type 'NavgRoad"
  '((:ITRI_AREA . 5)
    (:EXPRESS_WAY . 8)
    (:EXIT_GATEWAY . 20)
    (:ENTRY_GATEWAY . 21))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavgRoad>) ostream)
  "Serializes a message object of type '<NavgRoad>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'positiveLaneNum)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'negativeLaneNum)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'twoWay) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'positiveLaneIds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'positiveLaneIds))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'negativeLaneIds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'negativeLaneIds))
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'r_class)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'routing)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'n_as))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'n_kph))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p_as))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p_kph))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'heads))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'heads))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tails))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tails))
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavgRoad>) istream)
  "Deserializes a message object of type '<NavgRoad>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'positiveLaneNum) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'negativeLaneNum) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'twoWay) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'positiveLaneIds) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'positiveLaneIds)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'negativeLaneIds) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'negativeLaneIds)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'r_class) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'routing) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'n_as) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'n_kph) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p_as) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p_kph) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'length) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ItriPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'heads) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'heads)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ConnectedNavgRoad))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tails) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tails)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ConnectedNavgRoad))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavgRoad>)))
  "Returns string type for a message object of type '<NavgRoad>"
  "route_mission_handler/NavgRoad")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavgRoad)))
  "Returns string type for a message object of type 'NavgRoad"
  "route_mission_handler/NavgRoad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavgRoad>)))
  "Returns md5sum for a message object of type '<NavgRoad>"
  "73b8e8bb29e86ce8898fc956cfd316b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavgRoad)))
  "Returns md5sum for a message object of type 'NavgRoad"
  "73b8e8bb29e86ce8898fc956cfd316b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavgRoad>)))
  "Returns full string definition for message of type '<NavgRoad>"
  (cl:format cl:nil "int32 ITRI_AREA=5~%int32 EXPRESS_WAY=8~%int32 EXIT_GATEWAY=20~%int32 ENTRY_GATEWAY=21~%~%int32 id~%int32 positiveLaneNum~%int32 negativeLaneNum~%bool twoWay~%int32[] positiveLaneIds~%int32[] negativeLaneIds~%int32 mode~%int32 r_class~%int32 routing~%float32 n_as~%float32 n_kph~%float32 p_as~%float32 p_kph~%float32 length~%ItriPoint[] points~%ConnectedNavgRoad[] heads~%ConnectedNavgRoad[] tails~%int32 type~%~%================================================================================~%MSG: route_mission_handler/ItriPoint~%int32 id~%int32 belongId~%int32 pointId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: route_mission_handler/ConnectedNavgRoad~%int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavgRoad)))
  "Returns full string definition for message of type 'NavgRoad"
  (cl:format cl:nil "int32 ITRI_AREA=5~%int32 EXPRESS_WAY=8~%int32 EXIT_GATEWAY=20~%int32 ENTRY_GATEWAY=21~%~%int32 id~%int32 positiveLaneNum~%int32 negativeLaneNum~%bool twoWay~%int32[] positiveLaneIds~%int32[] negativeLaneIds~%int32 mode~%int32 r_class~%int32 routing~%float32 n_as~%float32 n_kph~%float32 p_as~%float32 p_kph~%float32 length~%ItriPoint[] points~%ConnectedNavgRoad[] heads~%ConnectedNavgRoad[] tails~%int32 type~%~%================================================================================~%MSG: route_mission_handler/ItriPoint~%int32 id~%int32 belongId~%int32 pointId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: route_mission_handler/ConnectedNavgRoad~%int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavgRoad>))
  (cl:+ 0
     4
     4
     4
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'positiveLaneIds) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'negativeLaneIds) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'heads) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tails) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavgRoad>))
  "Converts a ROS message object to a list"
  (cl:list 'NavgRoad
    (cl:cons ':id (id msg))
    (cl:cons ':positiveLaneNum (positiveLaneNum msg))
    (cl:cons ':negativeLaneNum (negativeLaneNum msg))
    (cl:cons ':twoWay (twoWay msg))
    (cl:cons ':positiveLaneIds (positiveLaneIds msg))
    (cl:cons ':negativeLaneIds (negativeLaneIds msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':r_class (r_class msg))
    (cl:cons ':routing (routing msg))
    (cl:cons ':n_as (n_as msg))
    (cl:cons ':n_kph (n_kph msg))
    (cl:cons ':p_as (p_as msg))
    (cl:cons ':p_kph (p_kph msg))
    (cl:cons ':length (length msg))
    (cl:cons ':points (points msg))
    (cl:cons ':heads (heads msg))
    (cl:cons ':tails (tails msg))
    (cl:cons ':type (type msg))
))
