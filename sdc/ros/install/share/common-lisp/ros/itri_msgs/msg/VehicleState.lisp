; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude VehicleState.msg.html

(cl:defclass <VehicleState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (vehicle_ready_to_drive
    :reader vehicle_ready_to_drive
    :initarg :vehicle_ready_to_drive
    :type cl:boolean
    :initform cl:nil)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (steering_angle
    :reader steering_angle
    :initarg :steering_angle
    :type cl:float
    :initform 0.0)
   (steering_torque
    :reader steering_torque
    :initarg :steering_torque
    :type cl:float
    :initform 0.0)
   (mode
    :reader mode
    :initarg :mode
    :type cl:fixnum
    :initform 0)
   (gear
    :reader gear
    :initarg :gear
    :type cl:fixnum
    :initform 0)
   (gear_state
    :reader gear_state
    :initarg :gear_state
    :type cl:integer
    :initform 0)
   (eps_state
    :reader eps_state
    :initarg :eps_state
    :type cl:fixnum
    :initform 0)
   (throttle_state
    :reader throttle_state
    :initarg :throttle_state
    :type cl:fixnum
    :initform 0)
   (brake_state
    :reader brake_state
    :initarg :brake_state
    :type cl:fixnum
    :initform 0)
   (gear_mode
    :reader gear_mode
    :initarg :gear_mode
    :type cl:fixnum
    :initform 0)
   (engine_speed
    :reader engine_speed
    :initarg :engine_speed
    :type cl:float
    :initform 0.0)
   (gateway_keep_alive
    :reader gateway_keep_alive
    :initarg :gateway_keep_alive
    :type cl:fixnum
    :initform 0)
   (amt_gear_pos
    :reader amt_gear_pos
    :initarg :amt_gear_pos
    :type cl:fixnum
    :initform 0)
   (blinker
    :reader blinker
    :initarg :blinker
    :type cl:fixnum
    :initform 0)
   (aeb_set
    :reader aeb_set
    :initarg :aeb_set
    :type cl:fixnum
    :initform 0)
   (brake_cmd_fb
    :reader brake_cmd_fb
    :initarg :brake_cmd_fb
    :type cl:fixnum
    :initform 0)
   (accele_cmd_fb
    :reader accele_cmd_fb
    :initarg :accele_cmd_fb
    :type cl:fixnum
    :initform 0)
   (brake_pedal
    :reader brake_pedal
    :initarg :brake_pedal
    :type cl:fixnum
    :initform 0)
   (accele_pedal
    :reader accele_pedal
    :initarg :accele_pedal
    :type cl:fixnum
    :initform 0)
   (steer_mcu_error
    :reader steer_mcu_error
    :initarg :steer_mcu_error
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_aeb
    :reader ctrl_switch_aeb
    :initarg :ctrl_switch_aeb
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_amt
    :reader ctrl_switch_amt
    :initarg :ctrl_switch_amt
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_blinker
    :reader ctrl_switch_blinker
    :initarg :ctrl_switch_blinker
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_brake
    :reader ctrl_switch_brake
    :initarg :ctrl_switch_brake
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_engine
    :reader ctrl_switch_engine
    :initarg :ctrl_switch_engine
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_steer
    :reader ctrl_switch_steer
    :initarg :ctrl_switch_steer
    :type cl:fixnum
    :initform 0)
   (ctrl_switch_gear
    :reader ctrl_switch_gear
    :initarg :ctrl_switch_gear
    :type cl:fixnum
    :initform 0)
   (brake_req_check
    :reader brake_req_check
    :initarg :brake_req_check
    :type cl:fixnum
    :initform 0)
   (engine_req_check
    :reader engine_req_check
    :initarg :engine_req_check
    :type cl:fixnum
    :initform 0)
   (steer_req_check
    :reader steer_req_check
    :initarg :steer_req_check
    :type cl:fixnum
    :initform 0)
   (gear_req_check
    :reader gear_req_check
    :initarg :gear_req_check
    :type cl:fixnum
    :initform 0)
   (eme_button
    :reader eme_button
    :initarg :eme_button
    :type cl:fixnum
    :initform 0)
   (brake_active_flag
    :reader brake_active_flag
    :initarg :brake_active_flag
    :type cl:fixnum
    :initform 0)
   (dbw_counter
    :reader dbw_counter
    :initarg :dbw_counter
    :type cl:fixnum
    :initform 0)
   (requestCheck
    :reader requestCheck
    :initarg :requestCheck
    :type cl:fixnum
    :initform 0)
   (aebEnable
    :reader aebEnable
    :initarg :aebEnable
    :type cl:fixnum
    :initform 0)
   (speedCtrlStatus
    :reader speedCtrlStatus
    :initarg :speedCtrlStatus
    :type cl:fixnum
    :initform 0)
   (doorFR
    :reader doorFR
    :initarg :doorFR
    :type cl:fixnum
    :initform 0)
   (doorRR
    :reader doorRR
    :initarg :doorRR
    :type cl:fixnum
    :initform 0)
   (brakePressure
    :reader brakePressure
    :initarg :brakePressure
    :type cl:float
    :initform 0.0))
)

(cl:defclass VehicleState (<VehicleState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VehicleState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VehicleState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<VehicleState> is deprecated: use itri_msgs-msg:VehicleState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'vehicle_ready_to_drive-val :lambda-list '(m))
(cl:defmethod vehicle_ready_to_drive-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:vehicle_ready_to_drive-val is deprecated.  Use itri_msgs-msg:vehicle_ready_to_drive instead.")
  (vehicle_ready_to_drive m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:speed-val is deprecated.  Use itri_msgs-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'steering_angle-val :lambda-list '(m))
(cl:defmethod steering_angle-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:steering_angle-val is deprecated.  Use itri_msgs-msg:steering_angle instead.")
  (steering_angle m))

(cl:ensure-generic-function 'steering_torque-val :lambda-list '(m))
(cl:defmethod steering_torque-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:steering_torque-val is deprecated.  Use itri_msgs-msg:steering_torque instead.")
  (steering_torque m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:mode-val is deprecated.  Use itri_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'gear-val :lambda-list '(m))
(cl:defmethod gear-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gear-val is deprecated.  Use itri_msgs-msg:gear instead.")
  (gear m))

(cl:ensure-generic-function 'gear_state-val :lambda-list '(m))
(cl:defmethod gear_state-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gear_state-val is deprecated.  Use itri_msgs-msg:gear_state instead.")
  (gear_state m))

(cl:ensure-generic-function 'eps_state-val :lambda-list '(m))
(cl:defmethod eps_state-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:eps_state-val is deprecated.  Use itri_msgs-msg:eps_state instead.")
  (eps_state m))

(cl:ensure-generic-function 'throttle_state-val :lambda-list '(m))
(cl:defmethod throttle_state-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:throttle_state-val is deprecated.  Use itri_msgs-msg:throttle_state instead.")
  (throttle_state m))

(cl:ensure-generic-function 'brake_state-val :lambda-list '(m))
(cl:defmethod brake_state-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_state-val is deprecated.  Use itri_msgs-msg:brake_state instead.")
  (brake_state m))

(cl:ensure-generic-function 'gear_mode-val :lambda-list '(m))
(cl:defmethod gear_mode-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gear_mode-val is deprecated.  Use itri_msgs-msg:gear_mode instead.")
  (gear_mode m))

(cl:ensure-generic-function 'engine_speed-val :lambda-list '(m))
(cl:defmethod engine_speed-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_speed-val is deprecated.  Use itri_msgs-msg:engine_speed instead.")
  (engine_speed m))

(cl:ensure-generic-function 'gateway_keep_alive-val :lambda-list '(m))
(cl:defmethod gateway_keep_alive-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gateway_keep_alive-val is deprecated.  Use itri_msgs-msg:gateway_keep_alive instead.")
  (gateway_keep_alive m))

(cl:ensure-generic-function 'amt_gear_pos-val :lambda-list '(m))
(cl:defmethod amt_gear_pos-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:amt_gear_pos-val is deprecated.  Use itri_msgs-msg:amt_gear_pos instead.")
  (amt_gear_pos m))

(cl:ensure-generic-function 'blinker-val :lambda-list '(m))
(cl:defmethod blinker-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:blinker-val is deprecated.  Use itri_msgs-msg:blinker instead.")
  (blinker m))

(cl:ensure-generic-function 'aeb_set-val :lambda-list '(m))
(cl:defmethod aeb_set-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:aeb_set-val is deprecated.  Use itri_msgs-msg:aeb_set instead.")
  (aeb_set m))

(cl:ensure-generic-function 'brake_cmd_fb-val :lambda-list '(m))
(cl:defmethod brake_cmd_fb-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_cmd_fb-val is deprecated.  Use itri_msgs-msg:brake_cmd_fb instead.")
  (brake_cmd_fb m))

(cl:ensure-generic-function 'accele_cmd_fb-val :lambda-list '(m))
(cl:defmethod accele_cmd_fb-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:accele_cmd_fb-val is deprecated.  Use itri_msgs-msg:accele_cmd_fb instead.")
  (accele_cmd_fb m))

(cl:ensure-generic-function 'brake_pedal-val :lambda-list '(m))
(cl:defmethod brake_pedal-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_pedal-val is deprecated.  Use itri_msgs-msg:brake_pedal instead.")
  (brake_pedal m))

(cl:ensure-generic-function 'accele_pedal-val :lambda-list '(m))
(cl:defmethod accele_pedal-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:accele_pedal-val is deprecated.  Use itri_msgs-msg:accele_pedal instead.")
  (accele_pedal m))

(cl:ensure-generic-function 'steer_mcu_error-val :lambda-list '(m))
(cl:defmethod steer_mcu_error-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:steer_mcu_error-val is deprecated.  Use itri_msgs-msg:steer_mcu_error instead.")
  (steer_mcu_error m))

(cl:ensure-generic-function 'ctrl_switch_aeb-val :lambda-list '(m))
(cl:defmethod ctrl_switch_aeb-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_aeb-val is deprecated.  Use itri_msgs-msg:ctrl_switch_aeb instead.")
  (ctrl_switch_aeb m))

(cl:ensure-generic-function 'ctrl_switch_amt-val :lambda-list '(m))
(cl:defmethod ctrl_switch_amt-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_amt-val is deprecated.  Use itri_msgs-msg:ctrl_switch_amt instead.")
  (ctrl_switch_amt m))

(cl:ensure-generic-function 'ctrl_switch_blinker-val :lambda-list '(m))
(cl:defmethod ctrl_switch_blinker-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_blinker-val is deprecated.  Use itri_msgs-msg:ctrl_switch_blinker instead.")
  (ctrl_switch_blinker m))

(cl:ensure-generic-function 'ctrl_switch_brake-val :lambda-list '(m))
(cl:defmethod ctrl_switch_brake-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_brake-val is deprecated.  Use itri_msgs-msg:ctrl_switch_brake instead.")
  (ctrl_switch_brake m))

(cl:ensure-generic-function 'ctrl_switch_engine-val :lambda-list '(m))
(cl:defmethod ctrl_switch_engine-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_engine-val is deprecated.  Use itri_msgs-msg:ctrl_switch_engine instead.")
  (ctrl_switch_engine m))

(cl:ensure-generic-function 'ctrl_switch_steer-val :lambda-list '(m))
(cl:defmethod ctrl_switch_steer-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_steer-val is deprecated.  Use itri_msgs-msg:ctrl_switch_steer instead.")
  (ctrl_switch_steer m))

(cl:ensure-generic-function 'ctrl_switch_gear-val :lambda-list '(m))
(cl:defmethod ctrl_switch_gear-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:ctrl_switch_gear-val is deprecated.  Use itri_msgs-msg:ctrl_switch_gear instead.")
  (ctrl_switch_gear m))

(cl:ensure-generic-function 'brake_req_check-val :lambda-list '(m))
(cl:defmethod brake_req_check-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_req_check-val is deprecated.  Use itri_msgs-msg:brake_req_check instead.")
  (brake_req_check m))

(cl:ensure-generic-function 'engine_req_check-val :lambda-list '(m))
(cl:defmethod engine_req_check-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_req_check-val is deprecated.  Use itri_msgs-msg:engine_req_check instead.")
  (engine_req_check m))

(cl:ensure-generic-function 'steer_req_check-val :lambda-list '(m))
(cl:defmethod steer_req_check-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:steer_req_check-val is deprecated.  Use itri_msgs-msg:steer_req_check instead.")
  (steer_req_check m))

(cl:ensure-generic-function 'gear_req_check-val :lambda-list '(m))
(cl:defmethod gear_req_check-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gear_req_check-val is deprecated.  Use itri_msgs-msg:gear_req_check instead.")
  (gear_req_check m))

(cl:ensure-generic-function 'eme_button-val :lambda-list '(m))
(cl:defmethod eme_button-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:eme_button-val is deprecated.  Use itri_msgs-msg:eme_button instead.")
  (eme_button m))

(cl:ensure-generic-function 'brake_active_flag-val :lambda-list '(m))
(cl:defmethod brake_active_flag-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brake_active_flag-val is deprecated.  Use itri_msgs-msg:brake_active_flag instead.")
  (brake_active_flag m))

(cl:ensure-generic-function 'dbw_counter-val :lambda-list '(m))
(cl:defmethod dbw_counter-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:dbw_counter-val is deprecated.  Use itri_msgs-msg:dbw_counter instead.")
  (dbw_counter m))

(cl:ensure-generic-function 'requestCheck-val :lambda-list '(m))
(cl:defmethod requestCheck-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:requestCheck-val is deprecated.  Use itri_msgs-msg:requestCheck instead.")
  (requestCheck m))

(cl:ensure-generic-function 'aebEnable-val :lambda-list '(m))
(cl:defmethod aebEnable-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:aebEnable-val is deprecated.  Use itri_msgs-msg:aebEnable instead.")
  (aebEnable m))

(cl:ensure-generic-function 'speedCtrlStatus-val :lambda-list '(m))
(cl:defmethod speedCtrlStatus-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:speedCtrlStatus-val is deprecated.  Use itri_msgs-msg:speedCtrlStatus instead.")
  (speedCtrlStatus m))

(cl:ensure-generic-function 'doorFR-val :lambda-list '(m))
(cl:defmethod doorFR-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:doorFR-val is deprecated.  Use itri_msgs-msg:doorFR instead.")
  (doorFR m))

(cl:ensure-generic-function 'doorRR-val :lambda-list '(m))
(cl:defmethod doorRR-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:doorRR-val is deprecated.  Use itri_msgs-msg:doorRR instead.")
  (doorRR m))

(cl:ensure-generic-function 'brakePressure-val :lambda-list '(m))
(cl:defmethod brakePressure-val ((m <VehicleState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:brakePressure-val is deprecated.  Use itri_msgs-msg:brakePressure instead.")
  (brakePressure m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<VehicleState>)))
    "Constants for message type '<VehicleState>"
  '((:MANUAL . 0)
    (:READY . 1)
    (:SPEED_ONLY . 2)
    (:STEER_ONLY . 3)
    (:AUTO . 4)
    (:JOYSTICK . 5)
    (:GEAR_NONE . 0)
    (:GEAR_P . 1)
    (:GEAR_R . 2)
    (:GEAR_N . 3)
    (:GEAR_D . 4)
    (:CONTROL_NOT_READY . 0)
    (:CONTROL_READY . 1)
    (:CONTROL_ENGAGED . 2)
    (:CONTROL_REJECT . 3)
    (:CONTROL_FAULT . 3)
    (:DBW_ENABLE_SWITCH_OFF . 0)
    (:DBW_ENABLE_SWITCH_ON . 1)
    (:DBW_ENABLE_NO_ACTION . 3)
    (:STEER_MCU_NO_ERROR . 0)
    (:STEER_MCU_ERROR . 1)
    (:STEER_MCU_ZERO_POINT_NOT_LEARNED . 2)
    (:STEER_MCU_NO_ACTION . 3)
    (:BRAKE_PEDAL_SWITCH_OFF . 0)
    (:BRAKE_PEDAL_SWITCH_ON . 1)
    (:BRAKE_PEDAL_SWITCH_NO_ACTION . 3)
    (:BLINKER_TURN_OFF . 0)
    (:BLINKER_TURN_RIGHT . 1)
    (:BLINKER_TURN_LEFT . 2)
    (:BLINKER_TURN_HAZARD . 3)
    (:AEB_SET_INACTIVE . 0)
    (:AEB_SET_ACTIVE . 1)
    (:AEB_SET_DISALLOW . 2)
    (:AEB_SET_NO_ACTION . 3)
    (:AMT_GEAR_R . 0)
    (:AMT_GEAR_R_SLOW . 1)
    (:AMT_GEAR_N . 2)
    (:AMT_GEAR_D_SLOW . 3)
    (:AMT_GEAR_D . 4)
    (:AMT_GEAR_NO_ACTION . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'VehicleState)))
    "Constants for message type 'VehicleState"
  '((:MANUAL . 0)
    (:READY . 1)
    (:SPEED_ONLY . 2)
    (:STEER_ONLY . 3)
    (:AUTO . 4)
    (:JOYSTICK . 5)
    (:GEAR_NONE . 0)
    (:GEAR_P . 1)
    (:GEAR_R . 2)
    (:GEAR_N . 3)
    (:GEAR_D . 4)
    (:CONTROL_NOT_READY . 0)
    (:CONTROL_READY . 1)
    (:CONTROL_ENGAGED . 2)
    (:CONTROL_REJECT . 3)
    (:CONTROL_FAULT . 3)
    (:DBW_ENABLE_SWITCH_OFF . 0)
    (:DBW_ENABLE_SWITCH_ON . 1)
    (:DBW_ENABLE_NO_ACTION . 3)
    (:STEER_MCU_NO_ERROR . 0)
    (:STEER_MCU_ERROR . 1)
    (:STEER_MCU_ZERO_POINT_NOT_LEARNED . 2)
    (:STEER_MCU_NO_ACTION . 3)
    (:BRAKE_PEDAL_SWITCH_OFF . 0)
    (:BRAKE_PEDAL_SWITCH_ON . 1)
    (:BRAKE_PEDAL_SWITCH_NO_ACTION . 3)
    (:BLINKER_TURN_OFF . 0)
    (:BLINKER_TURN_RIGHT . 1)
    (:BLINKER_TURN_LEFT . 2)
    (:BLINKER_TURN_HAZARD . 3)
    (:AEB_SET_INACTIVE . 0)
    (:AEB_SET_ACTIVE . 1)
    (:AEB_SET_DISALLOW . 2)
    (:AEB_SET_NO_ACTION . 3)
    (:AMT_GEAR_R . 0)
    (:AMT_GEAR_R_SLOW . 1)
    (:AMT_GEAR_N . 2)
    (:AMT_GEAR_D_SLOW . 3)
    (:AMT_GEAR_D . 4)
    (:AMT_GEAR_NO_ACTION . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VehicleState>) ostream)
  "Serializes a message object of type '<VehicleState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'vehicle_ready_to_drive) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_torque))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'gear)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gear_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gear_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gear_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'eps_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'throttle_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_mode)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gateway_keep_alive)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'amt_gear_pos)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blinker)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aeb_set)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_cmd_fb)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'accele_cmd_fb)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_pedal)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'accele_pedal)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steer_mcu_error)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_aeb)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_amt)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_blinker)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_brake)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_engine)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_steer)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_gear)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_req_check)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_req_check)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steer_req_check)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_req_check)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'eme_button)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_active_flag)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dbw_counter)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'requestCheck)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aebEnable)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'speedCtrlStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doorFR)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doorRR)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brakePressure))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VehicleState>) istream)
  "Deserializes a message object of type '<VehicleState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'vehicle_ready_to_drive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_torque) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gear) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'gear_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'gear_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'gear_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'eps_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'throttle_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_mode)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gateway_keep_alive)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'amt_gear_pos)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blinker)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aeb_set)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_cmd_fb)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'accele_cmd_fb)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_pedal)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'accele_pedal)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steer_mcu_error)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_aeb)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_amt)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_blinker)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_brake)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_engine)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_steer)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ctrl_switch_gear)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_req_check)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_req_check)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'steer_req_check)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gear_req_check)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'eme_button)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'brake_active_flag)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dbw_counter)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'requestCheck)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aebEnable)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'speedCtrlStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doorFR)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'doorRR)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brakePressure) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VehicleState>)))
  "Returns string type for a message object of type '<VehicleState>"
  "itri_msgs/VehicleState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VehicleState)))
  "Returns string type for a message object of type 'VehicleState"
  "itri_msgs/VehicleState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VehicleState>)))
  "Returns md5sum for a message object of type '<VehicleState>"
  "881a907f8805fbfdbd60729b6284d20c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VehicleState)))
  "Returns md5sum for a message object of type 'VehicleState"
  "881a907f8805fbfdbd60729b6284d20c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VehicleState>)))
  "Returns full string definition for message of type '<VehicleState>"
  (cl:format cl:nil "Header header~%~%uint8 MANUAL = 0~%uint8 READY = 1~%uint8 SPEED_ONLY = 2~%uint8 STEER_ONLY = 3~%uint8 AUTO = 4~%uint8 JOYSTICK = 5~%~%uint8 GEAR_NONE = 0~%uint8 GEAR_P = 1~%uint8 GEAR_R = 2~%uint8 GEAR_N = 3~%uint8 GEAR_D = 4~%~%uint8 CONTROL_NOT_READY = 0~%uint8 CONTROL_READY = 1~%uint8 CONTROL_ENGAGED = 2~%uint8 CONTROL_REJECT = 3~%uint8 CONTROL_FAULT = 3~%~%bool vehicle_ready_to_drive~%float32 speed~%float32 steering_angle~%float32 steering_torque~%uint8 mode~%int8 gear~%uint32 gear_state~%uint8 eps_state~%uint8 throttle_state~%uint8 brake_state~%uint8 gear_mode~%~%uint8 DBW_ENABLE_SWITCH_OFF = 0~%uint8 DBW_ENABLE_SWITCH_ON = 1~%uint8 DBW_ENABLE_NO_ACTION = 3~%~%uint8 STEER_MCU_NO_ERROR = 0~%uint8 STEER_MCU_ERROR = 1~%uint8 STEER_MCU_ZERO_POINT_NOT_LEARNED = 2~%uint8 STEER_MCU_NO_ACTION = 3~%~%uint8 BRAKE_PEDAL_SWITCH_OFF = 0~%uint8 BRAKE_PEDAL_SWITCH_ON = 1~%uint8 BRAKE_PEDAL_SWITCH_NO_ACTION = 3~%~%uint8 BLINKER_TURN_OFF = 0~%uint8 BLINKER_TURN_RIGHT = 1~%uint8 BLINKER_TURN_LEFT = 2~%uint8 BLINKER_TURN_HAZARD = 3~%~%uint8 AEB_SET_INACTIVE = 0~%uint8 AEB_SET_ACTIVE = 1~%uint8 AEB_SET_DISALLOW = 2~%uint8 AEB_SET_NO_ACTION = 3~%~%uint8 AMT_GEAR_R = 0~%uint8 AMT_GEAR_R_SLOW = 1~%uint8 AMT_GEAR_N = 2~%uint8 AMT_GEAR_D_SLOW = 3~%uint8 AMT_GEAR_D = 4~%uint8 AMT_GEAR_NO_ACTION = 5~%~%float32 engine_speed~%uint8 gateway_keep_alive~%uint8 amt_gear_pos~%uint8 blinker~%uint8 aeb_set~%uint8 brake_cmd_fb~%uint8 accele_cmd_fb~%uint8 brake_pedal~%uint8 accele_pedal~%uint8 steer_mcu_error~%uint8 ctrl_switch_aeb~%uint8 ctrl_switch_amt~%uint8 ctrl_switch_blinker~%uint8 ctrl_switch_brake~%uint8 ctrl_switch_engine~%uint8 ctrl_switch_steer~%uint8 ctrl_switch_gear~%~%uint8 brake_req_check~%uint8 engine_req_check~%uint8 steer_req_check~%uint8 gear_req_check~%~%uint8 eme_button~%uint8 brake_active_flag~%uint8 dbw_counter~%uint8 requestCheck~%uint8 aebEnable~%uint8 speedCtrlStatus~%~%uint8 doorFR~%uint8 doorRR~%float32 brakePressure~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VehicleState)))
  "Returns full string definition for message of type 'VehicleState"
  (cl:format cl:nil "Header header~%~%uint8 MANUAL = 0~%uint8 READY = 1~%uint8 SPEED_ONLY = 2~%uint8 STEER_ONLY = 3~%uint8 AUTO = 4~%uint8 JOYSTICK = 5~%~%uint8 GEAR_NONE = 0~%uint8 GEAR_P = 1~%uint8 GEAR_R = 2~%uint8 GEAR_N = 3~%uint8 GEAR_D = 4~%~%uint8 CONTROL_NOT_READY = 0~%uint8 CONTROL_READY = 1~%uint8 CONTROL_ENGAGED = 2~%uint8 CONTROL_REJECT = 3~%uint8 CONTROL_FAULT = 3~%~%bool vehicle_ready_to_drive~%float32 speed~%float32 steering_angle~%float32 steering_torque~%uint8 mode~%int8 gear~%uint32 gear_state~%uint8 eps_state~%uint8 throttle_state~%uint8 brake_state~%uint8 gear_mode~%~%uint8 DBW_ENABLE_SWITCH_OFF = 0~%uint8 DBW_ENABLE_SWITCH_ON = 1~%uint8 DBW_ENABLE_NO_ACTION = 3~%~%uint8 STEER_MCU_NO_ERROR = 0~%uint8 STEER_MCU_ERROR = 1~%uint8 STEER_MCU_ZERO_POINT_NOT_LEARNED = 2~%uint8 STEER_MCU_NO_ACTION = 3~%~%uint8 BRAKE_PEDAL_SWITCH_OFF = 0~%uint8 BRAKE_PEDAL_SWITCH_ON = 1~%uint8 BRAKE_PEDAL_SWITCH_NO_ACTION = 3~%~%uint8 BLINKER_TURN_OFF = 0~%uint8 BLINKER_TURN_RIGHT = 1~%uint8 BLINKER_TURN_LEFT = 2~%uint8 BLINKER_TURN_HAZARD = 3~%~%uint8 AEB_SET_INACTIVE = 0~%uint8 AEB_SET_ACTIVE = 1~%uint8 AEB_SET_DISALLOW = 2~%uint8 AEB_SET_NO_ACTION = 3~%~%uint8 AMT_GEAR_R = 0~%uint8 AMT_GEAR_R_SLOW = 1~%uint8 AMT_GEAR_N = 2~%uint8 AMT_GEAR_D_SLOW = 3~%uint8 AMT_GEAR_D = 4~%uint8 AMT_GEAR_NO_ACTION = 5~%~%float32 engine_speed~%uint8 gateway_keep_alive~%uint8 amt_gear_pos~%uint8 blinker~%uint8 aeb_set~%uint8 brake_cmd_fb~%uint8 accele_cmd_fb~%uint8 brake_pedal~%uint8 accele_pedal~%uint8 steer_mcu_error~%uint8 ctrl_switch_aeb~%uint8 ctrl_switch_amt~%uint8 ctrl_switch_blinker~%uint8 ctrl_switch_brake~%uint8 ctrl_switch_engine~%uint8 ctrl_switch_steer~%uint8 ctrl_switch_gear~%~%uint8 brake_req_check~%uint8 engine_req_check~%uint8 steer_req_check~%uint8 gear_req_check~%~%uint8 eme_button~%uint8 brake_active_flag~%uint8 dbw_counter~%uint8 requestCheck~%uint8 aebEnable~%uint8 speedCtrlStatus~%~%uint8 doorFR~%uint8 doorRR~%float32 brakePressure~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VehicleState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
     4
     1
     1
     4
     1
     1
     1
     1
     4
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
     1
     1
     1
     1
     1
     1
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VehicleState>))
  "Converts a ROS message object to a list"
  (cl:list 'VehicleState
    (cl:cons ':header (header msg))
    (cl:cons ':vehicle_ready_to_drive (vehicle_ready_to_drive msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':steering_angle (steering_angle msg))
    (cl:cons ':steering_torque (steering_torque msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':gear (gear msg))
    (cl:cons ':gear_state (gear_state msg))
    (cl:cons ':eps_state (eps_state msg))
    (cl:cons ':throttle_state (throttle_state msg))
    (cl:cons ':brake_state (brake_state msg))
    (cl:cons ':gear_mode (gear_mode msg))
    (cl:cons ':engine_speed (engine_speed msg))
    (cl:cons ':gateway_keep_alive (gateway_keep_alive msg))
    (cl:cons ':amt_gear_pos (amt_gear_pos msg))
    (cl:cons ':blinker (blinker msg))
    (cl:cons ':aeb_set (aeb_set msg))
    (cl:cons ':brake_cmd_fb (brake_cmd_fb msg))
    (cl:cons ':accele_cmd_fb (accele_cmd_fb msg))
    (cl:cons ':brake_pedal (brake_pedal msg))
    (cl:cons ':accele_pedal (accele_pedal msg))
    (cl:cons ':steer_mcu_error (steer_mcu_error msg))
    (cl:cons ':ctrl_switch_aeb (ctrl_switch_aeb msg))
    (cl:cons ':ctrl_switch_amt (ctrl_switch_amt msg))
    (cl:cons ':ctrl_switch_blinker (ctrl_switch_blinker msg))
    (cl:cons ':ctrl_switch_brake (ctrl_switch_brake msg))
    (cl:cons ':ctrl_switch_engine (ctrl_switch_engine msg))
    (cl:cons ':ctrl_switch_steer (ctrl_switch_steer msg))
    (cl:cons ':ctrl_switch_gear (ctrl_switch_gear msg))
    (cl:cons ':brake_req_check (brake_req_check msg))
    (cl:cons ':engine_req_check (engine_req_check msg))
    (cl:cons ':steer_req_check (steer_req_check msg))
    (cl:cons ':gear_req_check (gear_req_check msg))
    (cl:cons ':eme_button (eme_button msg))
    (cl:cons ':brake_active_flag (brake_active_flag msg))
    (cl:cons ':dbw_counter (dbw_counter msg))
    (cl:cons ':requestCheck (requestCheck msg))
    (cl:cons ':aebEnable (aebEnable msg))
    (cl:cons ':speedCtrlStatus (speedCtrlStatus msg))
    (cl:cons ':doorFR (doorFR msg))
    (cl:cons ':doorRR (doorRR msg))
    (cl:cons ':brakePressure (brakePressure msg))
))
