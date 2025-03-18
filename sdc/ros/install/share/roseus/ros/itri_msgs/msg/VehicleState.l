;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::VehicleState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'VehicleState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::VEHICLESTATE")
  (make-package "ITRI_MSGS::VEHICLESTATE"))

(in-package "ROS")
;;//! \htmlinclude VehicleState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*MANUAL*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*MANUAL* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*MANUAL* 0)
(intern "*READY*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*READY* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*READY* 1)
(intern "*SPEED_ONLY*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*SPEED_ONLY* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*SPEED_ONLY* 2)
(intern "*STEER_ONLY*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*STEER_ONLY* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*STEER_ONLY* 3)
(intern "*AUTO*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AUTO* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AUTO* 4)
(intern "*JOYSTICK*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*JOYSTICK* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*JOYSTICK* 5)
(intern "*GEAR_NONE*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*GEAR_NONE* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*GEAR_NONE* 0)
(intern "*GEAR_P*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*GEAR_P* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*GEAR_P* 1)
(intern "*GEAR_R*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*GEAR_R* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*GEAR_R* 2)
(intern "*GEAR_N*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*GEAR_N* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*GEAR_N* 3)
(intern "*GEAR_D*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*GEAR_D* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*GEAR_D* 4)
(intern "*CONTROL_NOT_READY*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*CONTROL_NOT_READY* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*CONTROL_NOT_READY* 0)
(intern "*CONTROL_READY*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*CONTROL_READY* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*CONTROL_READY* 1)
(intern "*CONTROL_ENGAGED*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*CONTROL_ENGAGED* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*CONTROL_ENGAGED* 2)
(intern "*CONTROL_REJECT*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*CONTROL_REJECT* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*CONTROL_REJECT* 3)
(intern "*CONTROL_FAULT*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*CONTROL_FAULT* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*CONTROL_FAULT* 3)
(intern "*DBW_ENABLE_SWITCH_OFF*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*DBW_ENABLE_SWITCH_OFF* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*DBW_ENABLE_SWITCH_OFF* 0)
(intern "*DBW_ENABLE_SWITCH_ON*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*DBW_ENABLE_SWITCH_ON* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*DBW_ENABLE_SWITCH_ON* 1)
(intern "*DBW_ENABLE_NO_ACTION*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*DBW_ENABLE_NO_ACTION* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*DBW_ENABLE_NO_ACTION* 3)
(intern "*STEER_MCU_NO_ERROR*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*STEER_MCU_NO_ERROR* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*STEER_MCU_NO_ERROR* 0)
(intern "*STEER_MCU_ERROR*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*STEER_MCU_ERROR* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*STEER_MCU_ERROR* 1)
(intern "*STEER_MCU_ZERO_POINT_NOT_LEARNED*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*STEER_MCU_ZERO_POINT_NOT_LEARNED* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*STEER_MCU_ZERO_POINT_NOT_LEARNED* 2)
(intern "*STEER_MCU_NO_ACTION*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*STEER_MCU_NO_ACTION* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*STEER_MCU_NO_ACTION* 3)
(intern "*BRAKE_PEDAL_SWITCH_OFF*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BRAKE_PEDAL_SWITCH_OFF* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BRAKE_PEDAL_SWITCH_OFF* 0)
(intern "*BRAKE_PEDAL_SWITCH_ON*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BRAKE_PEDAL_SWITCH_ON* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BRAKE_PEDAL_SWITCH_ON* 1)
(intern "*BRAKE_PEDAL_SWITCH_NO_ACTION*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BRAKE_PEDAL_SWITCH_NO_ACTION* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BRAKE_PEDAL_SWITCH_NO_ACTION* 3)
(intern "*BLINKER_TURN_OFF*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BLINKER_TURN_OFF* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BLINKER_TURN_OFF* 0)
(intern "*BLINKER_TURN_RIGHT*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BLINKER_TURN_RIGHT* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BLINKER_TURN_RIGHT* 1)
(intern "*BLINKER_TURN_LEFT*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BLINKER_TURN_LEFT* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BLINKER_TURN_LEFT* 2)
(intern "*BLINKER_TURN_HAZARD*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*BLINKER_TURN_HAZARD* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*BLINKER_TURN_HAZARD* 3)
(intern "*AEB_SET_INACTIVE*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AEB_SET_INACTIVE* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AEB_SET_INACTIVE* 0)
(intern "*AEB_SET_ACTIVE*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AEB_SET_ACTIVE* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AEB_SET_ACTIVE* 1)
(intern "*AEB_SET_DISALLOW*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AEB_SET_DISALLOW* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AEB_SET_DISALLOW* 2)
(intern "*AEB_SET_NO_ACTION*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AEB_SET_NO_ACTION* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AEB_SET_NO_ACTION* 3)
(intern "*AMT_GEAR_R*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_R* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_R* 0)
(intern "*AMT_GEAR_R_SLOW*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_R_SLOW* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_R_SLOW* 1)
(intern "*AMT_GEAR_N*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_N* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_N* 2)
(intern "*AMT_GEAR_D_SLOW*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_D_SLOW* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_D_SLOW* 3)
(intern "*AMT_GEAR_D*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_D* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_D* 4)
(intern "*AMT_GEAR_NO_ACTION*" (find-package "ITRI_MSGS::VEHICLESTATE"))
(shadow '*AMT_GEAR_NO_ACTION* (find-package "ITRI_MSGS::VEHICLESTATE"))
(defconstant itri_msgs::VehicleState::*AMT_GEAR_NO_ACTION* 5)
(defclass itri_msgs::VehicleState
  :super ros::object
  :slots (_header _vehicle_ready_to_drive _speed _steering_angle _steering_torque _mode _gear _gear_state _eps_state _throttle_state _brake_state _gear_mode _engine_speed _gateway_keep_alive _amt_gear_pos _blinker _aeb_set _brake_cmd_fb _accele_cmd_fb _brake_pedal _accele_pedal _steer_mcu_error _ctrl_switch_aeb _ctrl_switch_amt _ctrl_switch_blinker _ctrl_switch_brake _ctrl_switch_engine _ctrl_switch_steer _ctrl_switch_gear _brake_req_check _engine_req_check _steer_req_check _gear_req_check _eme_button _brake_active_flag _dbw_counter _requestCheck _aebEnable _speedCtrlStatus _doorFR _doorRR _brakePressure ))

(defmethod itri_msgs::VehicleState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vehicle_ready_to_drive __vehicle_ready_to_drive) nil)
    ((:speed __speed) 0.0)
    ((:steering_angle __steering_angle) 0.0)
    ((:steering_torque __steering_torque) 0.0)
    ((:mode __mode) 0)
    ((:gear __gear) 0)
    ((:gear_state __gear_state) 0)
    ((:eps_state __eps_state) 0)
    ((:throttle_state __throttle_state) 0)
    ((:brake_state __brake_state) 0)
    ((:gear_mode __gear_mode) 0)
    ((:engine_speed __engine_speed) 0.0)
    ((:gateway_keep_alive __gateway_keep_alive) 0)
    ((:amt_gear_pos __amt_gear_pos) 0)
    ((:blinker __blinker) 0)
    ((:aeb_set __aeb_set) 0)
    ((:brake_cmd_fb __brake_cmd_fb) 0)
    ((:accele_cmd_fb __accele_cmd_fb) 0)
    ((:brake_pedal __brake_pedal) 0)
    ((:accele_pedal __accele_pedal) 0)
    ((:steer_mcu_error __steer_mcu_error) 0)
    ((:ctrl_switch_aeb __ctrl_switch_aeb) 0)
    ((:ctrl_switch_amt __ctrl_switch_amt) 0)
    ((:ctrl_switch_blinker __ctrl_switch_blinker) 0)
    ((:ctrl_switch_brake __ctrl_switch_brake) 0)
    ((:ctrl_switch_engine __ctrl_switch_engine) 0)
    ((:ctrl_switch_steer __ctrl_switch_steer) 0)
    ((:ctrl_switch_gear __ctrl_switch_gear) 0)
    ((:brake_req_check __brake_req_check) 0)
    ((:engine_req_check __engine_req_check) 0)
    ((:steer_req_check __steer_req_check) 0)
    ((:gear_req_check __gear_req_check) 0)
    ((:eme_button __eme_button) 0)
    ((:brake_active_flag __brake_active_flag) 0)
    ((:dbw_counter __dbw_counter) 0)
    ((:requestCheck __requestCheck) 0)
    ((:aebEnable __aebEnable) 0)
    ((:speedCtrlStatus __speedCtrlStatus) 0)
    ((:doorFR __doorFR) 0)
    ((:doorRR __doorRR) 0)
    ((:brakePressure __brakePressure) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _vehicle_ready_to_drive __vehicle_ready_to_drive)
   (setq _speed (float __speed))
   (setq _steering_angle (float __steering_angle))
   (setq _steering_torque (float __steering_torque))
   (setq _mode (round __mode))
   (setq _gear (round __gear))
   (setq _gear_state (round __gear_state))
   (setq _eps_state (round __eps_state))
   (setq _throttle_state (round __throttle_state))
   (setq _brake_state (round __brake_state))
   (setq _gear_mode (round __gear_mode))
   (setq _engine_speed (float __engine_speed))
   (setq _gateway_keep_alive (round __gateway_keep_alive))
   (setq _amt_gear_pos (round __amt_gear_pos))
   (setq _blinker (round __blinker))
   (setq _aeb_set (round __aeb_set))
   (setq _brake_cmd_fb (round __brake_cmd_fb))
   (setq _accele_cmd_fb (round __accele_cmd_fb))
   (setq _brake_pedal (round __brake_pedal))
   (setq _accele_pedal (round __accele_pedal))
   (setq _steer_mcu_error (round __steer_mcu_error))
   (setq _ctrl_switch_aeb (round __ctrl_switch_aeb))
   (setq _ctrl_switch_amt (round __ctrl_switch_amt))
   (setq _ctrl_switch_blinker (round __ctrl_switch_blinker))
   (setq _ctrl_switch_brake (round __ctrl_switch_brake))
   (setq _ctrl_switch_engine (round __ctrl_switch_engine))
   (setq _ctrl_switch_steer (round __ctrl_switch_steer))
   (setq _ctrl_switch_gear (round __ctrl_switch_gear))
   (setq _brake_req_check (round __brake_req_check))
   (setq _engine_req_check (round __engine_req_check))
   (setq _steer_req_check (round __steer_req_check))
   (setq _gear_req_check (round __gear_req_check))
   (setq _eme_button (round __eme_button))
   (setq _brake_active_flag (round __brake_active_flag))
   (setq _dbw_counter (round __dbw_counter))
   (setq _requestCheck (round __requestCheck))
   (setq _aebEnable (round __aebEnable))
   (setq _speedCtrlStatus (round __speedCtrlStatus))
   (setq _doorFR (round __doorFR))
   (setq _doorRR (round __doorRR))
   (setq _brakePressure (float __brakePressure))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vehicle_ready_to_drive
   (&optional __vehicle_ready_to_drive)
   (if __vehicle_ready_to_drive (setq _vehicle_ready_to_drive __vehicle_ready_to_drive)) _vehicle_ready_to_drive)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:steering_angle
   (&optional __steering_angle)
   (if __steering_angle (setq _steering_angle __steering_angle)) _steering_angle)
  (:steering_torque
   (&optional __steering_torque)
   (if __steering_torque (setq _steering_torque __steering_torque)) _steering_torque)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:gear
   (&optional __gear)
   (if __gear (setq _gear __gear)) _gear)
  (:gear_state
   (&optional __gear_state)
   (if __gear_state (setq _gear_state __gear_state)) _gear_state)
  (:eps_state
   (&optional __eps_state)
   (if __eps_state (setq _eps_state __eps_state)) _eps_state)
  (:throttle_state
   (&optional __throttle_state)
   (if __throttle_state (setq _throttle_state __throttle_state)) _throttle_state)
  (:brake_state
   (&optional __brake_state)
   (if __brake_state (setq _brake_state __brake_state)) _brake_state)
  (:gear_mode
   (&optional __gear_mode)
   (if __gear_mode (setq _gear_mode __gear_mode)) _gear_mode)
  (:engine_speed
   (&optional __engine_speed)
   (if __engine_speed (setq _engine_speed __engine_speed)) _engine_speed)
  (:gateway_keep_alive
   (&optional __gateway_keep_alive)
   (if __gateway_keep_alive (setq _gateway_keep_alive __gateway_keep_alive)) _gateway_keep_alive)
  (:amt_gear_pos
   (&optional __amt_gear_pos)
   (if __amt_gear_pos (setq _amt_gear_pos __amt_gear_pos)) _amt_gear_pos)
  (:blinker
   (&optional __blinker)
   (if __blinker (setq _blinker __blinker)) _blinker)
  (:aeb_set
   (&optional __aeb_set)
   (if __aeb_set (setq _aeb_set __aeb_set)) _aeb_set)
  (:brake_cmd_fb
   (&optional __brake_cmd_fb)
   (if __brake_cmd_fb (setq _brake_cmd_fb __brake_cmd_fb)) _brake_cmd_fb)
  (:accele_cmd_fb
   (&optional __accele_cmd_fb)
   (if __accele_cmd_fb (setq _accele_cmd_fb __accele_cmd_fb)) _accele_cmd_fb)
  (:brake_pedal
   (&optional __brake_pedal)
   (if __brake_pedal (setq _brake_pedal __brake_pedal)) _brake_pedal)
  (:accele_pedal
   (&optional __accele_pedal)
   (if __accele_pedal (setq _accele_pedal __accele_pedal)) _accele_pedal)
  (:steer_mcu_error
   (&optional __steer_mcu_error)
   (if __steer_mcu_error (setq _steer_mcu_error __steer_mcu_error)) _steer_mcu_error)
  (:ctrl_switch_aeb
   (&optional __ctrl_switch_aeb)
   (if __ctrl_switch_aeb (setq _ctrl_switch_aeb __ctrl_switch_aeb)) _ctrl_switch_aeb)
  (:ctrl_switch_amt
   (&optional __ctrl_switch_amt)
   (if __ctrl_switch_amt (setq _ctrl_switch_amt __ctrl_switch_amt)) _ctrl_switch_amt)
  (:ctrl_switch_blinker
   (&optional __ctrl_switch_blinker)
   (if __ctrl_switch_blinker (setq _ctrl_switch_blinker __ctrl_switch_blinker)) _ctrl_switch_blinker)
  (:ctrl_switch_brake
   (&optional __ctrl_switch_brake)
   (if __ctrl_switch_brake (setq _ctrl_switch_brake __ctrl_switch_brake)) _ctrl_switch_brake)
  (:ctrl_switch_engine
   (&optional __ctrl_switch_engine)
   (if __ctrl_switch_engine (setq _ctrl_switch_engine __ctrl_switch_engine)) _ctrl_switch_engine)
  (:ctrl_switch_steer
   (&optional __ctrl_switch_steer)
   (if __ctrl_switch_steer (setq _ctrl_switch_steer __ctrl_switch_steer)) _ctrl_switch_steer)
  (:ctrl_switch_gear
   (&optional __ctrl_switch_gear)
   (if __ctrl_switch_gear (setq _ctrl_switch_gear __ctrl_switch_gear)) _ctrl_switch_gear)
  (:brake_req_check
   (&optional __brake_req_check)
   (if __brake_req_check (setq _brake_req_check __brake_req_check)) _brake_req_check)
  (:engine_req_check
   (&optional __engine_req_check)
   (if __engine_req_check (setq _engine_req_check __engine_req_check)) _engine_req_check)
  (:steer_req_check
   (&optional __steer_req_check)
   (if __steer_req_check (setq _steer_req_check __steer_req_check)) _steer_req_check)
  (:gear_req_check
   (&optional __gear_req_check)
   (if __gear_req_check (setq _gear_req_check __gear_req_check)) _gear_req_check)
  (:eme_button
   (&optional __eme_button)
   (if __eme_button (setq _eme_button __eme_button)) _eme_button)
  (:brake_active_flag
   (&optional __brake_active_flag)
   (if __brake_active_flag (setq _brake_active_flag __brake_active_flag)) _brake_active_flag)
  (:dbw_counter
   (&optional __dbw_counter)
   (if __dbw_counter (setq _dbw_counter __dbw_counter)) _dbw_counter)
  (:requestCheck
   (&optional __requestCheck)
   (if __requestCheck (setq _requestCheck __requestCheck)) _requestCheck)
  (:aebEnable
   (&optional __aebEnable)
   (if __aebEnable (setq _aebEnable __aebEnable)) _aebEnable)
  (:speedCtrlStatus
   (&optional __speedCtrlStatus)
   (if __speedCtrlStatus (setq _speedCtrlStatus __speedCtrlStatus)) _speedCtrlStatus)
  (:doorFR
   (&optional __doorFR)
   (if __doorFR (setq _doorFR __doorFR)) _doorFR)
  (:doorRR
   (&optional __doorRR)
   (if __doorRR (setq _doorRR __doorRR)) _doorRR)
  (:brakePressure
   (&optional __brakePressure)
   (if __brakePressure (setq _brakePressure __brakePressure)) _brakePressure)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _vehicle_ready_to_drive
    1
    ;; float32 _speed
    4
    ;; float32 _steering_angle
    4
    ;; float32 _steering_torque
    4
    ;; uint8 _mode
    1
    ;; int8 _gear
    1
    ;; uint32 _gear_state
    4
    ;; uint8 _eps_state
    1
    ;; uint8 _throttle_state
    1
    ;; uint8 _brake_state
    1
    ;; uint8 _gear_mode
    1
    ;; float32 _engine_speed
    4
    ;; uint8 _gateway_keep_alive
    1
    ;; uint8 _amt_gear_pos
    1
    ;; uint8 _blinker
    1
    ;; uint8 _aeb_set
    1
    ;; uint8 _brake_cmd_fb
    1
    ;; uint8 _accele_cmd_fb
    1
    ;; uint8 _brake_pedal
    1
    ;; uint8 _accele_pedal
    1
    ;; uint8 _steer_mcu_error
    1
    ;; uint8 _ctrl_switch_aeb
    1
    ;; uint8 _ctrl_switch_amt
    1
    ;; uint8 _ctrl_switch_blinker
    1
    ;; uint8 _ctrl_switch_brake
    1
    ;; uint8 _ctrl_switch_engine
    1
    ;; uint8 _ctrl_switch_steer
    1
    ;; uint8 _ctrl_switch_gear
    1
    ;; uint8 _brake_req_check
    1
    ;; uint8 _engine_req_check
    1
    ;; uint8 _steer_req_check
    1
    ;; uint8 _gear_req_check
    1
    ;; uint8 _eme_button
    1
    ;; uint8 _brake_active_flag
    1
    ;; uint8 _dbw_counter
    1
    ;; uint8 _requestCheck
    1
    ;; uint8 _aebEnable
    1
    ;; uint8 _speedCtrlStatus
    1
    ;; uint8 _doorFR
    1
    ;; uint8 _doorRR
    1
    ;; float32 _brakePressure
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _vehicle_ready_to_drive
       (if _vehicle_ready_to_drive (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steering_angle
       (sys::poke _steering_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steering_torque
       (sys::poke _steering_torque (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _mode
       (write-byte _mode s)
     ;; int8 _gear
       (write-byte _gear s)
     ;; uint32 _gear_state
       (write-long _gear_state s)
     ;; uint8 _eps_state
       (write-byte _eps_state s)
     ;; uint8 _throttle_state
       (write-byte _throttle_state s)
     ;; uint8 _brake_state
       (write-byte _brake_state s)
     ;; uint8 _gear_mode
       (write-byte _gear_mode s)
     ;; float32 _engine_speed
       (sys::poke _engine_speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _gateway_keep_alive
       (write-byte _gateway_keep_alive s)
     ;; uint8 _amt_gear_pos
       (write-byte _amt_gear_pos s)
     ;; uint8 _blinker
       (write-byte _blinker s)
     ;; uint8 _aeb_set
       (write-byte _aeb_set s)
     ;; uint8 _brake_cmd_fb
       (write-byte _brake_cmd_fb s)
     ;; uint8 _accele_cmd_fb
       (write-byte _accele_cmd_fb s)
     ;; uint8 _brake_pedal
       (write-byte _brake_pedal s)
     ;; uint8 _accele_pedal
       (write-byte _accele_pedal s)
     ;; uint8 _steer_mcu_error
       (write-byte _steer_mcu_error s)
     ;; uint8 _ctrl_switch_aeb
       (write-byte _ctrl_switch_aeb s)
     ;; uint8 _ctrl_switch_amt
       (write-byte _ctrl_switch_amt s)
     ;; uint8 _ctrl_switch_blinker
       (write-byte _ctrl_switch_blinker s)
     ;; uint8 _ctrl_switch_brake
       (write-byte _ctrl_switch_brake s)
     ;; uint8 _ctrl_switch_engine
       (write-byte _ctrl_switch_engine s)
     ;; uint8 _ctrl_switch_steer
       (write-byte _ctrl_switch_steer s)
     ;; uint8 _ctrl_switch_gear
       (write-byte _ctrl_switch_gear s)
     ;; uint8 _brake_req_check
       (write-byte _brake_req_check s)
     ;; uint8 _engine_req_check
       (write-byte _engine_req_check s)
     ;; uint8 _steer_req_check
       (write-byte _steer_req_check s)
     ;; uint8 _gear_req_check
       (write-byte _gear_req_check s)
     ;; uint8 _eme_button
       (write-byte _eme_button s)
     ;; uint8 _brake_active_flag
       (write-byte _brake_active_flag s)
     ;; uint8 _dbw_counter
       (write-byte _dbw_counter s)
     ;; uint8 _requestCheck
       (write-byte _requestCheck s)
     ;; uint8 _aebEnable
       (write-byte _aebEnable s)
     ;; uint8 _speedCtrlStatus
       (write-byte _speedCtrlStatus s)
     ;; uint8 _doorFR
       (write-byte _doorFR s)
     ;; uint8 _doorRR
       (write-byte _doorRR s)
     ;; float32 _brakePressure
       (sys::poke _brakePressure (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _vehicle_ready_to_drive
     (setq _vehicle_ready_to_drive (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steering_angle
     (setq _steering_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steering_torque
     (setq _steering_torque (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int8 _gear
     (setq _gear (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _gear 127) (setq _gear (- _gear 256)))
   ;; uint32 _gear_state
     (setq _gear_state (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _eps_state
     (setq _eps_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _throttle_state
     (setq _throttle_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _brake_state
     (setq _brake_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _gear_mode
     (setq _gear_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _engine_speed
     (setq _engine_speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _gateway_keep_alive
     (setq _gateway_keep_alive (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _amt_gear_pos
     (setq _amt_gear_pos (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _blinker
     (setq _blinker (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _aeb_set
     (setq _aeb_set (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _brake_cmd_fb
     (setq _brake_cmd_fb (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _accele_cmd_fb
     (setq _accele_cmd_fb (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _brake_pedal
     (setq _brake_pedal (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _accele_pedal
     (setq _accele_pedal (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _steer_mcu_error
     (setq _steer_mcu_error (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_aeb
     (setq _ctrl_switch_aeb (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_amt
     (setq _ctrl_switch_amt (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_blinker
     (setq _ctrl_switch_blinker (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_brake
     (setq _ctrl_switch_brake (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_engine
     (setq _ctrl_switch_engine (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_steer
     (setq _ctrl_switch_steer (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ctrl_switch_gear
     (setq _ctrl_switch_gear (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _brake_req_check
     (setq _brake_req_check (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _engine_req_check
     (setq _engine_req_check (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _steer_req_check
     (setq _steer_req_check (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _gear_req_check
     (setq _gear_req_check (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _eme_button
     (setq _eme_button (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _brake_active_flag
     (setq _brake_active_flag (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _dbw_counter
     (setq _dbw_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _requestCheck
     (setq _requestCheck (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _aebEnable
     (setq _aebEnable (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _speedCtrlStatus
     (setq _speedCtrlStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _doorFR
     (setq _doorFR (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _doorRR
     (setq _doorRR (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _brakePressure
     (setq _brakePressure (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::VehicleState :md5sum-) "881a907f8805fbfdbd60729b6284d20c")
(setf (get itri_msgs::VehicleState :datatype-) "itri_msgs/VehicleState")
(setf (get itri_msgs::VehicleState :definition-)
      "Header header

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

")



(provide :itri_msgs/VehicleState "881a907f8805fbfdbd60729b6284d20c")


