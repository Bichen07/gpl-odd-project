// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class VehicleState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.vehicle_ready_to_drive = null;
      this.speed = null;
      this.steering_angle = null;
      this.steering_torque = null;
      this.mode = null;
      this.gear = null;
      this.gear_state = null;
      this.eps_state = null;
      this.throttle_state = null;
      this.brake_state = null;
      this.gear_mode = null;
      this.engine_speed = null;
      this.gateway_keep_alive = null;
      this.amt_gear_pos = null;
      this.blinker = null;
      this.aeb_set = null;
      this.brake_cmd_fb = null;
      this.accele_cmd_fb = null;
      this.brake_pedal = null;
      this.accele_pedal = null;
      this.steer_mcu_error = null;
      this.ctrl_switch_aeb = null;
      this.ctrl_switch_amt = null;
      this.ctrl_switch_blinker = null;
      this.ctrl_switch_brake = null;
      this.ctrl_switch_engine = null;
      this.ctrl_switch_steer = null;
      this.ctrl_switch_gear = null;
      this.brake_req_check = null;
      this.engine_req_check = null;
      this.steer_req_check = null;
      this.gear_req_check = null;
      this.eme_button = null;
      this.brake_active_flag = null;
      this.dbw_counter = null;
      this.requestCheck = null;
      this.aebEnable = null;
      this.speedCtrlStatus = null;
      this.doorFR = null;
      this.doorRR = null;
      this.brakePressure = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('vehicle_ready_to_drive')) {
        this.vehicle_ready_to_drive = initObj.vehicle_ready_to_drive
      }
      else {
        this.vehicle_ready_to_drive = false;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('steering_angle')) {
        this.steering_angle = initObj.steering_angle
      }
      else {
        this.steering_angle = 0.0;
      }
      if (initObj.hasOwnProperty('steering_torque')) {
        this.steering_torque = initObj.steering_torque
      }
      else {
        this.steering_torque = 0.0;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
      if (initObj.hasOwnProperty('gear')) {
        this.gear = initObj.gear
      }
      else {
        this.gear = 0;
      }
      if (initObj.hasOwnProperty('gear_state')) {
        this.gear_state = initObj.gear_state
      }
      else {
        this.gear_state = 0;
      }
      if (initObj.hasOwnProperty('eps_state')) {
        this.eps_state = initObj.eps_state
      }
      else {
        this.eps_state = 0;
      }
      if (initObj.hasOwnProperty('throttle_state')) {
        this.throttle_state = initObj.throttle_state
      }
      else {
        this.throttle_state = 0;
      }
      if (initObj.hasOwnProperty('brake_state')) {
        this.brake_state = initObj.brake_state
      }
      else {
        this.brake_state = 0;
      }
      if (initObj.hasOwnProperty('gear_mode')) {
        this.gear_mode = initObj.gear_mode
      }
      else {
        this.gear_mode = 0;
      }
      if (initObj.hasOwnProperty('engine_speed')) {
        this.engine_speed = initObj.engine_speed
      }
      else {
        this.engine_speed = 0.0;
      }
      if (initObj.hasOwnProperty('gateway_keep_alive')) {
        this.gateway_keep_alive = initObj.gateway_keep_alive
      }
      else {
        this.gateway_keep_alive = 0;
      }
      if (initObj.hasOwnProperty('amt_gear_pos')) {
        this.amt_gear_pos = initObj.amt_gear_pos
      }
      else {
        this.amt_gear_pos = 0;
      }
      if (initObj.hasOwnProperty('blinker')) {
        this.blinker = initObj.blinker
      }
      else {
        this.blinker = 0;
      }
      if (initObj.hasOwnProperty('aeb_set')) {
        this.aeb_set = initObj.aeb_set
      }
      else {
        this.aeb_set = 0;
      }
      if (initObj.hasOwnProperty('brake_cmd_fb')) {
        this.brake_cmd_fb = initObj.brake_cmd_fb
      }
      else {
        this.brake_cmd_fb = 0;
      }
      if (initObj.hasOwnProperty('accele_cmd_fb')) {
        this.accele_cmd_fb = initObj.accele_cmd_fb
      }
      else {
        this.accele_cmd_fb = 0;
      }
      if (initObj.hasOwnProperty('brake_pedal')) {
        this.brake_pedal = initObj.brake_pedal
      }
      else {
        this.brake_pedal = 0;
      }
      if (initObj.hasOwnProperty('accele_pedal')) {
        this.accele_pedal = initObj.accele_pedal
      }
      else {
        this.accele_pedal = 0;
      }
      if (initObj.hasOwnProperty('steer_mcu_error')) {
        this.steer_mcu_error = initObj.steer_mcu_error
      }
      else {
        this.steer_mcu_error = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_aeb')) {
        this.ctrl_switch_aeb = initObj.ctrl_switch_aeb
      }
      else {
        this.ctrl_switch_aeb = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_amt')) {
        this.ctrl_switch_amt = initObj.ctrl_switch_amt
      }
      else {
        this.ctrl_switch_amt = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_blinker')) {
        this.ctrl_switch_blinker = initObj.ctrl_switch_blinker
      }
      else {
        this.ctrl_switch_blinker = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_brake')) {
        this.ctrl_switch_brake = initObj.ctrl_switch_brake
      }
      else {
        this.ctrl_switch_brake = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_engine')) {
        this.ctrl_switch_engine = initObj.ctrl_switch_engine
      }
      else {
        this.ctrl_switch_engine = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_steer')) {
        this.ctrl_switch_steer = initObj.ctrl_switch_steer
      }
      else {
        this.ctrl_switch_steer = 0;
      }
      if (initObj.hasOwnProperty('ctrl_switch_gear')) {
        this.ctrl_switch_gear = initObj.ctrl_switch_gear
      }
      else {
        this.ctrl_switch_gear = 0;
      }
      if (initObj.hasOwnProperty('brake_req_check')) {
        this.brake_req_check = initObj.brake_req_check
      }
      else {
        this.brake_req_check = 0;
      }
      if (initObj.hasOwnProperty('engine_req_check')) {
        this.engine_req_check = initObj.engine_req_check
      }
      else {
        this.engine_req_check = 0;
      }
      if (initObj.hasOwnProperty('steer_req_check')) {
        this.steer_req_check = initObj.steer_req_check
      }
      else {
        this.steer_req_check = 0;
      }
      if (initObj.hasOwnProperty('gear_req_check')) {
        this.gear_req_check = initObj.gear_req_check
      }
      else {
        this.gear_req_check = 0;
      }
      if (initObj.hasOwnProperty('eme_button')) {
        this.eme_button = initObj.eme_button
      }
      else {
        this.eme_button = 0;
      }
      if (initObj.hasOwnProperty('brake_active_flag')) {
        this.brake_active_flag = initObj.brake_active_flag
      }
      else {
        this.brake_active_flag = 0;
      }
      if (initObj.hasOwnProperty('dbw_counter')) {
        this.dbw_counter = initObj.dbw_counter
      }
      else {
        this.dbw_counter = 0;
      }
      if (initObj.hasOwnProperty('requestCheck')) {
        this.requestCheck = initObj.requestCheck
      }
      else {
        this.requestCheck = 0;
      }
      if (initObj.hasOwnProperty('aebEnable')) {
        this.aebEnable = initObj.aebEnable
      }
      else {
        this.aebEnable = 0;
      }
      if (initObj.hasOwnProperty('speedCtrlStatus')) {
        this.speedCtrlStatus = initObj.speedCtrlStatus
      }
      else {
        this.speedCtrlStatus = 0;
      }
      if (initObj.hasOwnProperty('doorFR')) {
        this.doorFR = initObj.doorFR
      }
      else {
        this.doorFR = 0;
      }
      if (initObj.hasOwnProperty('doorRR')) {
        this.doorRR = initObj.doorRR
      }
      else {
        this.doorRR = 0;
      }
      if (initObj.hasOwnProperty('brakePressure')) {
        this.brakePressure = initObj.brakePressure
      }
      else {
        this.brakePressure = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VehicleState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [vehicle_ready_to_drive]
    bufferOffset = _serializer.bool(obj.vehicle_ready_to_drive, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [steering_angle]
    bufferOffset = _serializer.float32(obj.steering_angle, buffer, bufferOffset);
    // Serialize message field [steering_torque]
    bufferOffset = _serializer.float32(obj.steering_torque, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.uint8(obj.mode, buffer, bufferOffset);
    // Serialize message field [gear]
    bufferOffset = _serializer.int8(obj.gear, buffer, bufferOffset);
    // Serialize message field [gear_state]
    bufferOffset = _serializer.uint32(obj.gear_state, buffer, bufferOffset);
    // Serialize message field [eps_state]
    bufferOffset = _serializer.uint8(obj.eps_state, buffer, bufferOffset);
    // Serialize message field [throttle_state]
    bufferOffset = _serializer.uint8(obj.throttle_state, buffer, bufferOffset);
    // Serialize message field [brake_state]
    bufferOffset = _serializer.uint8(obj.brake_state, buffer, bufferOffset);
    // Serialize message field [gear_mode]
    bufferOffset = _serializer.uint8(obj.gear_mode, buffer, bufferOffset);
    // Serialize message field [engine_speed]
    bufferOffset = _serializer.float32(obj.engine_speed, buffer, bufferOffset);
    // Serialize message field [gateway_keep_alive]
    bufferOffset = _serializer.uint8(obj.gateway_keep_alive, buffer, bufferOffset);
    // Serialize message field [amt_gear_pos]
    bufferOffset = _serializer.uint8(obj.amt_gear_pos, buffer, bufferOffset);
    // Serialize message field [blinker]
    bufferOffset = _serializer.uint8(obj.blinker, buffer, bufferOffset);
    // Serialize message field [aeb_set]
    bufferOffset = _serializer.uint8(obj.aeb_set, buffer, bufferOffset);
    // Serialize message field [brake_cmd_fb]
    bufferOffset = _serializer.uint8(obj.brake_cmd_fb, buffer, bufferOffset);
    // Serialize message field [accele_cmd_fb]
    bufferOffset = _serializer.uint8(obj.accele_cmd_fb, buffer, bufferOffset);
    // Serialize message field [brake_pedal]
    bufferOffset = _serializer.uint8(obj.brake_pedal, buffer, bufferOffset);
    // Serialize message field [accele_pedal]
    bufferOffset = _serializer.uint8(obj.accele_pedal, buffer, bufferOffset);
    // Serialize message field [steer_mcu_error]
    bufferOffset = _serializer.uint8(obj.steer_mcu_error, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_aeb]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_aeb, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_amt]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_amt, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_blinker]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_blinker, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_brake]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_brake, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_engine]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_engine, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_steer]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_steer, buffer, bufferOffset);
    // Serialize message field [ctrl_switch_gear]
    bufferOffset = _serializer.uint8(obj.ctrl_switch_gear, buffer, bufferOffset);
    // Serialize message field [brake_req_check]
    bufferOffset = _serializer.uint8(obj.brake_req_check, buffer, bufferOffset);
    // Serialize message field [engine_req_check]
    bufferOffset = _serializer.uint8(obj.engine_req_check, buffer, bufferOffset);
    // Serialize message field [steer_req_check]
    bufferOffset = _serializer.uint8(obj.steer_req_check, buffer, bufferOffset);
    // Serialize message field [gear_req_check]
    bufferOffset = _serializer.uint8(obj.gear_req_check, buffer, bufferOffset);
    // Serialize message field [eme_button]
    bufferOffset = _serializer.uint8(obj.eme_button, buffer, bufferOffset);
    // Serialize message field [brake_active_flag]
    bufferOffset = _serializer.uint8(obj.brake_active_flag, buffer, bufferOffset);
    // Serialize message field [dbw_counter]
    bufferOffset = _serializer.uint8(obj.dbw_counter, buffer, bufferOffset);
    // Serialize message field [requestCheck]
    bufferOffset = _serializer.uint8(obj.requestCheck, buffer, bufferOffset);
    // Serialize message field [aebEnable]
    bufferOffset = _serializer.uint8(obj.aebEnable, buffer, bufferOffset);
    // Serialize message field [speedCtrlStatus]
    bufferOffset = _serializer.uint8(obj.speedCtrlStatus, buffer, bufferOffset);
    // Serialize message field [doorFR]
    bufferOffset = _serializer.uint8(obj.doorFR, buffer, bufferOffset);
    // Serialize message field [doorRR]
    bufferOffset = _serializer.uint8(obj.doorRR, buffer, bufferOffset);
    // Serialize message field [brakePressure]
    bufferOffset = _serializer.float32(obj.brakePressure, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VehicleState
    let len;
    let data = new VehicleState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [vehicle_ready_to_drive]
    data.vehicle_ready_to_drive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steering_angle]
    data.steering_angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steering_torque]
    data.steering_torque = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [gear]
    data.gear = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [gear_state]
    data.gear_state = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [eps_state]
    data.eps_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [throttle_state]
    data.throttle_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_state]
    data.brake_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [gear_mode]
    data.gear_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [engine_speed]
    data.engine_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gateway_keep_alive]
    data.gateway_keep_alive = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [amt_gear_pos]
    data.amt_gear_pos = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [blinker]
    data.blinker = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [aeb_set]
    data.aeb_set = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_cmd_fb]
    data.brake_cmd_fb = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [accele_cmd_fb]
    data.accele_cmd_fb = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_pedal]
    data.brake_pedal = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [accele_pedal]
    data.accele_pedal = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [steer_mcu_error]
    data.steer_mcu_error = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_aeb]
    data.ctrl_switch_aeb = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_amt]
    data.ctrl_switch_amt = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_blinker]
    data.ctrl_switch_blinker = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_brake]
    data.ctrl_switch_brake = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_engine]
    data.ctrl_switch_engine = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_steer]
    data.ctrl_switch_steer = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ctrl_switch_gear]
    data.ctrl_switch_gear = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_req_check]
    data.brake_req_check = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [engine_req_check]
    data.engine_req_check = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [steer_req_check]
    data.steer_req_check = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [gear_req_check]
    data.gear_req_check = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [eme_button]
    data.eme_button = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brake_active_flag]
    data.brake_active_flag = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dbw_counter]
    data.dbw_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [requestCheck]
    data.requestCheck = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [aebEnable]
    data.aebEnable = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [speedCtrlStatus]
    data.speedCtrlStatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [doorFR]
    data.doorFR = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [doorRR]
    data.doorRR = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [brakePressure]
    data.brakePressure = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 59;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/VehicleState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '881a907f8805fbfdbd60729b6284d20c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new VehicleState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.vehicle_ready_to_drive !== undefined) {
      resolved.vehicle_ready_to_drive = msg.vehicle_ready_to_drive;
    }
    else {
      resolved.vehicle_ready_to_drive = false
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.steering_angle !== undefined) {
      resolved.steering_angle = msg.steering_angle;
    }
    else {
      resolved.steering_angle = 0.0
    }

    if (msg.steering_torque !== undefined) {
      resolved.steering_torque = msg.steering_torque;
    }
    else {
      resolved.steering_torque = 0.0
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    if (msg.gear !== undefined) {
      resolved.gear = msg.gear;
    }
    else {
      resolved.gear = 0
    }

    if (msg.gear_state !== undefined) {
      resolved.gear_state = msg.gear_state;
    }
    else {
      resolved.gear_state = 0
    }

    if (msg.eps_state !== undefined) {
      resolved.eps_state = msg.eps_state;
    }
    else {
      resolved.eps_state = 0
    }

    if (msg.throttle_state !== undefined) {
      resolved.throttle_state = msg.throttle_state;
    }
    else {
      resolved.throttle_state = 0
    }

    if (msg.brake_state !== undefined) {
      resolved.brake_state = msg.brake_state;
    }
    else {
      resolved.brake_state = 0
    }

    if (msg.gear_mode !== undefined) {
      resolved.gear_mode = msg.gear_mode;
    }
    else {
      resolved.gear_mode = 0
    }

    if (msg.engine_speed !== undefined) {
      resolved.engine_speed = msg.engine_speed;
    }
    else {
      resolved.engine_speed = 0.0
    }

    if (msg.gateway_keep_alive !== undefined) {
      resolved.gateway_keep_alive = msg.gateway_keep_alive;
    }
    else {
      resolved.gateway_keep_alive = 0
    }

    if (msg.amt_gear_pos !== undefined) {
      resolved.amt_gear_pos = msg.amt_gear_pos;
    }
    else {
      resolved.amt_gear_pos = 0
    }

    if (msg.blinker !== undefined) {
      resolved.blinker = msg.blinker;
    }
    else {
      resolved.blinker = 0
    }

    if (msg.aeb_set !== undefined) {
      resolved.aeb_set = msg.aeb_set;
    }
    else {
      resolved.aeb_set = 0
    }

    if (msg.brake_cmd_fb !== undefined) {
      resolved.brake_cmd_fb = msg.brake_cmd_fb;
    }
    else {
      resolved.brake_cmd_fb = 0
    }

    if (msg.accele_cmd_fb !== undefined) {
      resolved.accele_cmd_fb = msg.accele_cmd_fb;
    }
    else {
      resolved.accele_cmd_fb = 0
    }

    if (msg.brake_pedal !== undefined) {
      resolved.brake_pedal = msg.brake_pedal;
    }
    else {
      resolved.brake_pedal = 0
    }

    if (msg.accele_pedal !== undefined) {
      resolved.accele_pedal = msg.accele_pedal;
    }
    else {
      resolved.accele_pedal = 0
    }

    if (msg.steer_mcu_error !== undefined) {
      resolved.steer_mcu_error = msg.steer_mcu_error;
    }
    else {
      resolved.steer_mcu_error = 0
    }

    if (msg.ctrl_switch_aeb !== undefined) {
      resolved.ctrl_switch_aeb = msg.ctrl_switch_aeb;
    }
    else {
      resolved.ctrl_switch_aeb = 0
    }

    if (msg.ctrl_switch_amt !== undefined) {
      resolved.ctrl_switch_amt = msg.ctrl_switch_amt;
    }
    else {
      resolved.ctrl_switch_amt = 0
    }

    if (msg.ctrl_switch_blinker !== undefined) {
      resolved.ctrl_switch_blinker = msg.ctrl_switch_blinker;
    }
    else {
      resolved.ctrl_switch_blinker = 0
    }

    if (msg.ctrl_switch_brake !== undefined) {
      resolved.ctrl_switch_brake = msg.ctrl_switch_brake;
    }
    else {
      resolved.ctrl_switch_brake = 0
    }

    if (msg.ctrl_switch_engine !== undefined) {
      resolved.ctrl_switch_engine = msg.ctrl_switch_engine;
    }
    else {
      resolved.ctrl_switch_engine = 0
    }

    if (msg.ctrl_switch_steer !== undefined) {
      resolved.ctrl_switch_steer = msg.ctrl_switch_steer;
    }
    else {
      resolved.ctrl_switch_steer = 0
    }

    if (msg.ctrl_switch_gear !== undefined) {
      resolved.ctrl_switch_gear = msg.ctrl_switch_gear;
    }
    else {
      resolved.ctrl_switch_gear = 0
    }

    if (msg.brake_req_check !== undefined) {
      resolved.brake_req_check = msg.brake_req_check;
    }
    else {
      resolved.brake_req_check = 0
    }

    if (msg.engine_req_check !== undefined) {
      resolved.engine_req_check = msg.engine_req_check;
    }
    else {
      resolved.engine_req_check = 0
    }

    if (msg.steer_req_check !== undefined) {
      resolved.steer_req_check = msg.steer_req_check;
    }
    else {
      resolved.steer_req_check = 0
    }

    if (msg.gear_req_check !== undefined) {
      resolved.gear_req_check = msg.gear_req_check;
    }
    else {
      resolved.gear_req_check = 0
    }

    if (msg.eme_button !== undefined) {
      resolved.eme_button = msg.eme_button;
    }
    else {
      resolved.eme_button = 0
    }

    if (msg.brake_active_flag !== undefined) {
      resolved.brake_active_flag = msg.brake_active_flag;
    }
    else {
      resolved.brake_active_flag = 0
    }

    if (msg.dbw_counter !== undefined) {
      resolved.dbw_counter = msg.dbw_counter;
    }
    else {
      resolved.dbw_counter = 0
    }

    if (msg.requestCheck !== undefined) {
      resolved.requestCheck = msg.requestCheck;
    }
    else {
      resolved.requestCheck = 0
    }

    if (msg.aebEnable !== undefined) {
      resolved.aebEnable = msg.aebEnable;
    }
    else {
      resolved.aebEnable = 0
    }

    if (msg.speedCtrlStatus !== undefined) {
      resolved.speedCtrlStatus = msg.speedCtrlStatus;
    }
    else {
      resolved.speedCtrlStatus = 0
    }

    if (msg.doorFR !== undefined) {
      resolved.doorFR = msg.doorFR;
    }
    else {
      resolved.doorFR = 0
    }

    if (msg.doorRR !== undefined) {
      resolved.doorRR = msg.doorRR;
    }
    else {
      resolved.doorRR = 0
    }

    if (msg.brakePressure !== undefined) {
      resolved.brakePressure = msg.brakePressure;
    }
    else {
      resolved.brakePressure = 0.0
    }

    return resolved;
    }
};

// Constants for message
VehicleState.Constants = {
  MANUAL: 0,
  READY: 1,
  SPEED_ONLY: 2,
  STEER_ONLY: 3,
  AUTO: 4,
  JOYSTICK: 5,
  GEAR_NONE: 0,
  GEAR_P: 1,
  GEAR_R: 2,
  GEAR_N: 3,
  GEAR_D: 4,
  CONTROL_NOT_READY: 0,
  CONTROL_READY: 1,
  CONTROL_ENGAGED: 2,
  CONTROL_REJECT: 3,
  CONTROL_FAULT: 3,
  DBW_ENABLE_SWITCH_OFF: 0,
  DBW_ENABLE_SWITCH_ON: 1,
  DBW_ENABLE_NO_ACTION: 3,
  STEER_MCU_NO_ERROR: 0,
  STEER_MCU_ERROR: 1,
  STEER_MCU_ZERO_POINT_NOT_LEARNED: 2,
  STEER_MCU_NO_ACTION: 3,
  BRAKE_PEDAL_SWITCH_OFF: 0,
  BRAKE_PEDAL_SWITCH_ON: 1,
  BRAKE_PEDAL_SWITCH_NO_ACTION: 3,
  BLINKER_TURN_OFF: 0,
  BLINKER_TURN_RIGHT: 1,
  BLINKER_TURN_LEFT: 2,
  BLINKER_TURN_HAZARD: 3,
  AEB_SET_INACTIVE: 0,
  AEB_SET_ACTIVE: 1,
  AEB_SET_DISALLOW: 2,
  AEB_SET_NO_ACTION: 3,
  AMT_GEAR_R: 0,
  AMT_GEAR_R_SLOW: 1,
  AMT_GEAR_N: 2,
  AMT_GEAR_D_SLOW: 3,
  AMT_GEAR_D: 4,
  AMT_GEAR_NO_ACTION: 5,
}

module.exports = VehicleState;
