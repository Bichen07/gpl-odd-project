Header header

uint8 MANUAL = 0
uint8 READY = 1
uint8 SPEED_ONLY = 2
uint8 STEER_ONLY = 3
uint8 AUTO = 4
uint8 JOYSTICK = 5

uint8 GEAR_NONE = 0
uint8 GEAR_P = 1
uint8 GEAR_R = 2
uint8 GEAR_N = 3
uint8 GEAR_D = 4

uint8 CONTROL_NOT_READY = 0
uint8 CONTROL_READY = 1
uint8 CONTROL_ENGAGED = 2
uint8 CONTROL_REJECT = 3
uint8 CONTROL_FAULT = 3

bool vehicle_ready_to_drive
float32 speed
float32 steering_angle
float32 steering_torque
uint8 mode
int8 gear
uint32 gear_state
uint8 eps_state
uint8 throttle_state
uint8 brake_state
uint8 gear_mode

uint8 DBW_ENABLE_SWITCH_OFF = 0
uint8 DBW_ENABLE_SWITCH_ON = 1
uint8 DBW_ENABLE_NO_ACTION = 3

uint8 STEER_MCU_NO_ERROR = 0
uint8 STEER_MCU_ERROR = 1
uint8 STEER_MCU_ZERO_POINT_NOT_LEARNED = 2
uint8 STEER_MCU_NO_ACTION = 3

uint8 BRAKE_PEDAL_SWITCH_OFF = 0
uint8 BRAKE_PEDAL_SWITCH_ON = 1
uint8 BRAKE_PEDAL_SWITCH_NO_ACTION = 3

uint8 BLINKER_TURN_OFF = 0
uint8 BLINKER_TURN_RIGHT = 1
uint8 BLINKER_TURN_LEFT = 2
uint8 BLINKER_TURN_HAZARD = 3

uint8 AEB_SET_INACTIVE = 0
uint8 AEB_SET_ACTIVE = 1
uint8 AEB_SET_DISALLOW = 2
uint8 AEB_SET_NO_ACTION = 3

uint8 AMT_GEAR_R = 0
uint8 AMT_GEAR_R_SLOW = 1
uint8 AMT_GEAR_N = 2
uint8 AMT_GEAR_D_SLOW = 3
uint8 AMT_GEAR_D = 4
uint8 AMT_GEAR_NO_ACTION = 5

float32 engine_speed
uint8 gateway_keep_alive
uint8 amt_gear_pos
uint8 blinker
uint8 aeb_set
uint8 brake_cmd_fb
uint8 accele_cmd_fb
uint8 brake_pedal
uint8 accele_pedal
uint8 steer_mcu_error
uint8 ctrl_switch_aeb
uint8 ctrl_switch_amt
uint8 ctrl_switch_blinker
uint8 ctrl_switch_brake
uint8 ctrl_switch_engine
uint8 ctrl_switch_steer
uint8 ctrl_switch_gear

uint8 brake_req_check
uint8 engine_req_check
uint8 steer_req_check
uint8 gear_req_check

uint8 eme_button
uint8 brake_active_flag
uint8 dbw_counter
uint8 requestCheck
uint8 aebEnable
uint8 speedCtrlStatus

uint8 doorFR
uint8 doorRR
float32 brakePressure
