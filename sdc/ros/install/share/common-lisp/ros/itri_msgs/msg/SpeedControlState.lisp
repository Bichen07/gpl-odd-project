; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude SpeedControlState.msg.html

(cl:defclass <SpeedControlState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (speed_control_enable
    :reader speed_control_enable
    :initarg :speed_control_enable
    :type cl:boolean
    :initform cl:nil)
   (CANLostFromECU
    :reader CANLostFromECU
    :initarg :CANLostFromECU
    :type cl:boolean
    :initform cl:nil)
   (CANLostFromEPS
    :reader CANLostFromEPS
    :initarg :CANLostFromEPS
    :type cl:boolean
    :initform cl:nil)
   (faultDBW
    :reader faultDBW
    :initarg :faultDBW
    :type cl:boolean
    :initform cl:nil)
   (readyAVCU
    :reader readyAVCU
    :initarg :readyAVCU
    :type cl:boolean
    :initform cl:nil)
   (CANLostFromiBooster
    :reader CANLostFromiBooster
    :initarg :CANLostFromiBooster
    :type cl:boolean
    :initform cl:nil)
   (CANLostFrom2024C
    :reader CANLostFrom2024C
    :initarg :CANLostFrom2024C
    :type cl:boolean
    :initform cl:nil)
   (CANLostFromAVCU
    :reader CANLostFromAVCU
    :initarg :CANLostFromAVCU
    :type cl:boolean
    :initform cl:nil)
   (velocityCmdState
    :reader velocityCmdState
    :initarg :velocityCmdState
    :type cl:fixnum
    :initform 0)
   (speedCmdState
    :reader speedCmdState
    :initarg :speedCmdState
    :type cl:fixnum
    :initform 0)
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type cl:float
    :initform 0.0)
   (forceComp
    :reader forceComp
    :initarg :forceComp
    :type cl:float
    :initform 0.0)
   (target_speed
    :reader target_speed
    :initarg :target_speed
    :type cl:float
    :initform 0.0)
   (current_speed
    :reader current_speed
    :initarg :current_speed
    :type cl:float
    :initform 0.0)
   (integral_term_action
    :reader integral_term_action
    :initarg :integral_term_action
    :type cl:float
    :initform 0.0)
   (p_term_action
    :reader p_term_action
    :initarg :p_term_action
    :type cl:float
    :initform 0.0)
   (feedforward_action
    :reader feedforward_action
    :initarg :feedforward_action
    :type cl:float
    :initform 0.0)
   (brake_pressure_f
    :reader brake_pressure_f
    :initarg :brake_pressure_f
    :type cl:float
    :initform 0.0)
   (brake_pressure_r
    :reader brake_pressure_r
    :initarg :brake_pressure_r
    :type cl:float
    :initform 0.0)
   (brake_pressure_f_tank
    :reader brake_pressure_f_tank
    :initarg :brake_pressure_f_tank
    :type cl:float
    :initform 0.0)
   (brake_pressure_r_tank
    :reader brake_pressure_r_tank
    :initarg :brake_pressure_r_tank
    :type cl:float
    :initform 0.0))
)

(cl:defclass SpeedControlState (<SpeedControlState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpeedControlState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpeedControlState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<SpeedControlState> is deprecated: use itri_msgs-msg:SpeedControlState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'speed_control_enable-val :lambda-list '(m))
(cl:defmethod speed_control_enable-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:speed_control_enable-val is deprecated.  Use itri_msgs-msg:speed_control_enable instead.")
  (speed_control_enable m))

(cl:ensure-generic-function 'CANLostFromECU-val :lambda-list '(m))
(cl:defmethod CANLostFromECU-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:CANLostFromECU-val is deprecated.  Use itri_msgs-msg:CANLostFromECU instead.")
  (CANLostFromECU m))

(cl:ensure-generic-function 'CANLostFromEPS-val :lambda-list '(m))
(cl:defmethod CANLostFromEPS-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:CANLostFromEPS-val is deprecated.  Use itri_msgs-msg:CANLostFromEPS instead.")
  (CANLostFromEPS m))

(cl:ensure-generic-function 'faultDBW-val :lambda-list '(m))
(cl:defmethod faultDBW-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:faultDBW-val is deprecated.  Use itri_msgs-msg:faultDBW instead.")
  (faultDBW m))

(cl:ensure-generic-function 'readyAVCU-val :lambda-list '(m))
(cl:defmethod readyAVCU-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:readyAVCU-val is deprecated.  Use itri_msgs-msg:readyAVCU instead.")
  (readyAVCU m))

(cl:ensure-generic-function 'CANLostFromiBooster-val :lambda-list '(m))
(cl:defmethod CANLostFromiBooster-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:CANLostFromiBooster-val is deprecated.  Use itri_msgs-msg:CANLostFromiBooster instead.")
  (CANLostFromiBooster m))

(cl:ensure-generic-function 'CANLostFrom2024C-val :lambda-list '(m))
(cl:defmethod CANLostFrom2024C-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:CANLostFrom2024C-val is deprecated.  Use itri_msgs-msg:CANLostFrom2024C instead.")
  (CANLostFrom2024C m))

(cl:ensure-generic-function 'CANLostFromAVCU-val :lambda-list '(m))
(cl:defmethod CANLostFromAVCU-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:CANLostFromAVCU-val is deprecated.  Use itri_msgs-msg:CANLostFromAVCU instead.")
  (CANLostFromAVCU m))

(cl:ensure-generic-function 'velocityCmdState-val :lambda-list '(m))
(cl:defmethod velocityCmdState-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocityCmdState-val is deprecated.  Use itri_msgs-msg:velocityCmdState instead.")
  (velocityCmdState m))

(cl:ensure-generic-function 'speedCmdState-val :lambda-list '(m))
(cl:defmethod speedCmdState-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:speedCmdState-val is deprecated.  Use itri_msgs-msg:speedCmdState instead.")
  (speedCmdState m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:acceleration-val is deprecated.  Use itri_msgs-msg:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'forceComp-val :lambda-list '(m))
(cl:defmethod forceComp-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:forceComp-val is deprecated.  Use itri_msgs-msg:forceComp instead.")
  (forceComp m))

(cl:ensure-generic-function 'target_speed-val :lambda-list '(m))
(cl:defmethod target_speed-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:target_speed-val is deprecated.  Use itri_msgs-msg:target_speed instead.")
  (target_speed m))

(cl:ensure-generic-function 'current_speed-val :lambda-list '(m))
(cl:defmethod current_speed-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:current_speed-val is deprecated.  Use itri_msgs-msg:current_speed instead.")
  (current_speed m))

(cl:ensure-generic-function 'integral_term_action-val :lambda-list '(m))
(cl:defmethod integral_term_action-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:integral_term_action-val is deprecated.  Use itri_msgs-msg:integral_term_action instead.")
  (integral_term_action m))

(cl:ensure-generic-function 'p_term_action-val :lambda-list '(m))
(cl:defmethod p_term_action-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:p_term_action-val is deprecated.  Use itri_msgs-msg:p_term_action instead.")
  (p_term_action m))

(cl:ensure-generic-function 'feedforward_action-val :lambda-list '(m))
(cl:defmethod feedforward_action-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:feedforward_action-val is deprecated.  Use itri_msgs-msg:feedforward_action instead.")
  (feedforward_action m))

(cl:ensure-generic-function 'brake_pressure_f-val :lambda-list '(m))
(cl:defmethod brake_pressure_f-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_pressure_f-val is deprecated.  Use itri_msgs-msg:brake_pressure_f instead.")
  (brake_pressure_f m))

(cl:ensure-generic-function 'brake_pressure_r-val :lambda-list '(m))
(cl:defmethod brake_pressure_r-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_pressure_r-val is deprecated.  Use itri_msgs-msg:brake_pressure_r instead.")
  (brake_pressure_r m))

(cl:ensure-generic-function 'brake_pressure_f_tank-val :lambda-list '(m))
(cl:defmethod brake_pressure_f_tank-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_pressure_f_tank-val is deprecated.  Use itri_msgs-msg:brake_pressure_f_tank instead.")
  (brake_pressure_f_tank m))

(cl:ensure-generic-function 'brake_pressure_r_tank-val :lambda-list '(m))
(cl:defmethod brake_pressure_r_tank-val ((m <SpeedControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_pressure_r_tank-val is deprecated.  Use itri_msgs-msg:brake_pressure_r_tank instead.")
  (brake_pressure_r_tank m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpeedControlState>) ostream)
  "Serializes a message object of type '<SpeedControlState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'speed_control_enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'CANLostFromECU) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'CANLostFromEPS) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'faultDBW) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'readyAVCU) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'CANLostFromiBooster) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'CANLostFrom2024C) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'CANLostFromAVCU) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'velocityCmdState)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'speedCmdState)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'forceComp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'target_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'integral_term_action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p_term_action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'feedforward_action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_pressure_f))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_pressure_r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_pressure_f_tank))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_pressure_r_tank))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpeedControlState>) istream)
  "Deserializes a message object of type '<SpeedControlState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'speed_control_enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'CANLostFromECU) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'CANLostFromEPS) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'faultDBW) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'readyAVCU) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'CANLostFromiBooster) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'CANLostFrom2024C) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'CANLostFromAVCU) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'velocityCmdState)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'speedCmdState) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'forceComp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'integral_term_action) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p_term_action) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'feedforward_action) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_pressure_f) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_pressure_r) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_pressure_f_tank) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_pressure_r_tank) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpeedControlState>)))
  "Returns string type for a message object of type '<SpeedControlState>"
  "itri_msgs/SpeedControlState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpeedControlState)))
  "Returns string type for a message object of type 'SpeedControlState"
  "itri_msgs/SpeedControlState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpeedControlState>)))
  "Returns md5sum for a message object of type '<SpeedControlState>"
  "78bc1c667e28edd5e1f5d662fd51ba0b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpeedControlState)))
  "Returns md5sum for a message object of type 'SpeedControlState"
  "78bc1c667e28edd5e1f5d662fd51ba0b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpeedControlState>)))
  "Returns full string definition for message of type '<SpeedControlState>"
  (cl:format cl:nil "Header header~%~%bool speed_control_enable~%bool CANLostFromECU~%bool CANLostFromEPS~%bool faultDBW~%bool readyAVCU~%bool CANLostFromiBooster~%bool CANLostFrom2024C~%bool CANLostFromAVCU~%uint8 velocityCmdState~%int8 speedCmdState~%float32 acceleration~%float32 forceComp~%float32 target_speed~%float32 current_speed~%float32 integral_term_action~%float32 p_term_action~%float32 feedforward_action~%float32 brake_pressure_f~%float32 brake_pressure_r~%float32 brake_pressure_f_tank~%float32 brake_pressure_r_tank~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpeedControlState)))
  "Returns full string definition for message of type 'SpeedControlState"
  (cl:format cl:nil "Header header~%~%bool speed_control_enable~%bool CANLostFromECU~%bool CANLostFromEPS~%bool faultDBW~%bool readyAVCU~%bool CANLostFromiBooster~%bool CANLostFrom2024C~%bool CANLostFromAVCU~%uint8 velocityCmdState~%int8 speedCmdState~%float32 acceleration~%float32 forceComp~%float32 target_speed~%float32 current_speed~%float32 integral_term_action~%float32 p_term_action~%float32 feedforward_action~%float32 brake_pressure_f~%float32 brake_pressure_r~%float32 brake_pressure_f_tank~%float32 brake_pressure_r_tank~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpeedControlState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpeedControlState>))
  "Converts a ROS message object to a list"
  (cl:list 'SpeedControlState
    (cl:cons ':header (header msg))
    (cl:cons ':speed_control_enable (speed_control_enable msg))
    (cl:cons ':CANLostFromECU (CANLostFromECU msg))
    (cl:cons ':CANLostFromEPS (CANLostFromEPS msg))
    (cl:cons ':faultDBW (faultDBW msg))
    (cl:cons ':readyAVCU (readyAVCU msg))
    (cl:cons ':CANLostFromiBooster (CANLostFromiBooster msg))
    (cl:cons ':CANLostFrom2024C (CANLostFrom2024C msg))
    (cl:cons ':CANLostFromAVCU (CANLostFromAVCU msg))
    (cl:cons ':velocityCmdState (velocityCmdState msg))
    (cl:cons ':speedCmdState (speedCmdState msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':forceComp (forceComp msg))
    (cl:cons ':target_speed (target_speed msg))
    (cl:cons ':current_speed (current_speed msg))
    (cl:cons ':integral_term_action (integral_term_action msg))
    (cl:cons ':p_term_action (p_term_action msg))
    (cl:cons ':feedforward_action (feedforward_action msg))
    (cl:cons ':brake_pressure_f (brake_pressure_f msg))
    (cl:cons ':brake_pressure_r (brake_pressure_r msg))
    (cl:cons ':brake_pressure_f_tank (brake_pressure_f_tank msg))
    (cl:cons ':brake_pressure_r_tank (brake_pressure_r_tank msg))
))
