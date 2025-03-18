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

class SpeedControlState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.speed_control_enable = null;
      this.CANLostFromECU = null;
      this.CANLostFromEPS = null;
      this.faultDBW = null;
      this.readyAVCU = null;
      this.CANLostFromiBooster = null;
      this.CANLostFrom2024C = null;
      this.CANLostFromAVCU = null;
      this.velocityCmdState = null;
      this.speedCmdState = null;
      this.acceleration = null;
      this.forceComp = null;
      this.target_speed = null;
      this.current_speed = null;
      this.integral_term_action = null;
      this.p_term_action = null;
      this.feedforward_action = null;
      this.brake_pressure_f = null;
      this.brake_pressure_r = null;
      this.brake_pressure_f_tank = null;
      this.brake_pressure_r_tank = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('speed_control_enable')) {
        this.speed_control_enable = initObj.speed_control_enable
      }
      else {
        this.speed_control_enable = false;
      }
      if (initObj.hasOwnProperty('CANLostFromECU')) {
        this.CANLostFromECU = initObj.CANLostFromECU
      }
      else {
        this.CANLostFromECU = false;
      }
      if (initObj.hasOwnProperty('CANLostFromEPS')) {
        this.CANLostFromEPS = initObj.CANLostFromEPS
      }
      else {
        this.CANLostFromEPS = false;
      }
      if (initObj.hasOwnProperty('faultDBW')) {
        this.faultDBW = initObj.faultDBW
      }
      else {
        this.faultDBW = false;
      }
      if (initObj.hasOwnProperty('readyAVCU')) {
        this.readyAVCU = initObj.readyAVCU
      }
      else {
        this.readyAVCU = false;
      }
      if (initObj.hasOwnProperty('CANLostFromiBooster')) {
        this.CANLostFromiBooster = initObj.CANLostFromiBooster
      }
      else {
        this.CANLostFromiBooster = false;
      }
      if (initObj.hasOwnProperty('CANLostFrom2024C')) {
        this.CANLostFrom2024C = initObj.CANLostFrom2024C
      }
      else {
        this.CANLostFrom2024C = false;
      }
      if (initObj.hasOwnProperty('CANLostFromAVCU')) {
        this.CANLostFromAVCU = initObj.CANLostFromAVCU
      }
      else {
        this.CANLostFromAVCU = false;
      }
      if (initObj.hasOwnProperty('velocityCmdState')) {
        this.velocityCmdState = initObj.velocityCmdState
      }
      else {
        this.velocityCmdState = 0;
      }
      if (initObj.hasOwnProperty('speedCmdState')) {
        this.speedCmdState = initObj.speedCmdState
      }
      else {
        this.speedCmdState = 0;
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('forceComp')) {
        this.forceComp = initObj.forceComp
      }
      else {
        this.forceComp = 0.0;
      }
      if (initObj.hasOwnProperty('target_speed')) {
        this.target_speed = initObj.target_speed
      }
      else {
        this.target_speed = 0.0;
      }
      if (initObj.hasOwnProperty('current_speed')) {
        this.current_speed = initObj.current_speed
      }
      else {
        this.current_speed = 0.0;
      }
      if (initObj.hasOwnProperty('integral_term_action')) {
        this.integral_term_action = initObj.integral_term_action
      }
      else {
        this.integral_term_action = 0.0;
      }
      if (initObj.hasOwnProperty('p_term_action')) {
        this.p_term_action = initObj.p_term_action
      }
      else {
        this.p_term_action = 0.0;
      }
      if (initObj.hasOwnProperty('feedforward_action')) {
        this.feedforward_action = initObj.feedforward_action
      }
      else {
        this.feedforward_action = 0.0;
      }
      if (initObj.hasOwnProperty('brake_pressure_f')) {
        this.brake_pressure_f = initObj.brake_pressure_f
      }
      else {
        this.brake_pressure_f = 0.0;
      }
      if (initObj.hasOwnProperty('brake_pressure_r')) {
        this.brake_pressure_r = initObj.brake_pressure_r
      }
      else {
        this.brake_pressure_r = 0.0;
      }
      if (initObj.hasOwnProperty('brake_pressure_f_tank')) {
        this.brake_pressure_f_tank = initObj.brake_pressure_f_tank
      }
      else {
        this.brake_pressure_f_tank = 0.0;
      }
      if (initObj.hasOwnProperty('brake_pressure_r_tank')) {
        this.brake_pressure_r_tank = initObj.brake_pressure_r_tank
      }
      else {
        this.brake_pressure_r_tank = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpeedControlState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [speed_control_enable]
    bufferOffset = _serializer.bool(obj.speed_control_enable, buffer, bufferOffset);
    // Serialize message field [CANLostFromECU]
    bufferOffset = _serializer.bool(obj.CANLostFromECU, buffer, bufferOffset);
    // Serialize message field [CANLostFromEPS]
    bufferOffset = _serializer.bool(obj.CANLostFromEPS, buffer, bufferOffset);
    // Serialize message field [faultDBW]
    bufferOffset = _serializer.bool(obj.faultDBW, buffer, bufferOffset);
    // Serialize message field [readyAVCU]
    bufferOffset = _serializer.bool(obj.readyAVCU, buffer, bufferOffset);
    // Serialize message field [CANLostFromiBooster]
    bufferOffset = _serializer.bool(obj.CANLostFromiBooster, buffer, bufferOffset);
    // Serialize message field [CANLostFrom2024C]
    bufferOffset = _serializer.bool(obj.CANLostFrom2024C, buffer, bufferOffset);
    // Serialize message field [CANLostFromAVCU]
    bufferOffset = _serializer.bool(obj.CANLostFromAVCU, buffer, bufferOffset);
    // Serialize message field [velocityCmdState]
    bufferOffset = _serializer.uint8(obj.velocityCmdState, buffer, bufferOffset);
    // Serialize message field [speedCmdState]
    bufferOffset = _serializer.int8(obj.speedCmdState, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = _serializer.float32(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [forceComp]
    bufferOffset = _serializer.float32(obj.forceComp, buffer, bufferOffset);
    // Serialize message field [target_speed]
    bufferOffset = _serializer.float32(obj.target_speed, buffer, bufferOffset);
    // Serialize message field [current_speed]
    bufferOffset = _serializer.float32(obj.current_speed, buffer, bufferOffset);
    // Serialize message field [integral_term_action]
    bufferOffset = _serializer.float32(obj.integral_term_action, buffer, bufferOffset);
    // Serialize message field [p_term_action]
    bufferOffset = _serializer.float32(obj.p_term_action, buffer, bufferOffset);
    // Serialize message field [feedforward_action]
    bufferOffset = _serializer.float32(obj.feedforward_action, buffer, bufferOffset);
    // Serialize message field [brake_pressure_f]
    bufferOffset = _serializer.float32(obj.brake_pressure_f, buffer, bufferOffset);
    // Serialize message field [brake_pressure_r]
    bufferOffset = _serializer.float32(obj.brake_pressure_r, buffer, bufferOffset);
    // Serialize message field [brake_pressure_f_tank]
    bufferOffset = _serializer.float32(obj.brake_pressure_f_tank, buffer, bufferOffset);
    // Serialize message field [brake_pressure_r_tank]
    bufferOffset = _serializer.float32(obj.brake_pressure_r_tank, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpeedControlState
    let len;
    let data = new SpeedControlState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [speed_control_enable]
    data.speed_control_enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [CANLostFromECU]
    data.CANLostFromECU = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [CANLostFromEPS]
    data.CANLostFromEPS = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [faultDBW]
    data.faultDBW = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [readyAVCU]
    data.readyAVCU = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [CANLostFromiBooster]
    data.CANLostFromiBooster = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [CANLostFrom2024C]
    data.CANLostFrom2024C = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [CANLostFromAVCU]
    data.CANLostFromAVCU = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [velocityCmdState]
    data.velocityCmdState = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [speedCmdState]
    data.speedCmdState = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [forceComp]
    data.forceComp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [target_speed]
    data.target_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [current_speed]
    data.current_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [integral_term_action]
    data.integral_term_action = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [p_term_action]
    data.p_term_action = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [feedforward_action]
    data.feedforward_action = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brake_pressure_f]
    data.brake_pressure_f = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brake_pressure_r]
    data.brake_pressure_r = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brake_pressure_f_tank]
    data.brake_pressure_f_tank = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brake_pressure_r_tank]
    data.brake_pressure_r_tank = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 54;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/SpeedControlState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '78bc1c667e28edd5e1f5d662fd51ba0b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool speed_control_enable
    bool CANLostFromECU
    bool CANLostFromEPS
    bool faultDBW
    bool readyAVCU
    bool CANLostFromiBooster
    bool CANLostFrom2024C
    bool CANLostFromAVCU
    uint8 velocityCmdState
    int8 speedCmdState
    float32 acceleration
    float32 forceComp
    float32 target_speed
    float32 current_speed
    float32 integral_term_action
    float32 p_term_action
    float32 feedforward_action
    float32 brake_pressure_f
    float32 brake_pressure_r
    float32 brake_pressure_f_tank
    float32 brake_pressure_r_tank
    
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
    const resolved = new SpeedControlState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.speed_control_enable !== undefined) {
      resolved.speed_control_enable = msg.speed_control_enable;
    }
    else {
      resolved.speed_control_enable = false
    }

    if (msg.CANLostFromECU !== undefined) {
      resolved.CANLostFromECU = msg.CANLostFromECU;
    }
    else {
      resolved.CANLostFromECU = false
    }

    if (msg.CANLostFromEPS !== undefined) {
      resolved.CANLostFromEPS = msg.CANLostFromEPS;
    }
    else {
      resolved.CANLostFromEPS = false
    }

    if (msg.faultDBW !== undefined) {
      resolved.faultDBW = msg.faultDBW;
    }
    else {
      resolved.faultDBW = false
    }

    if (msg.readyAVCU !== undefined) {
      resolved.readyAVCU = msg.readyAVCU;
    }
    else {
      resolved.readyAVCU = false
    }

    if (msg.CANLostFromiBooster !== undefined) {
      resolved.CANLostFromiBooster = msg.CANLostFromiBooster;
    }
    else {
      resolved.CANLostFromiBooster = false
    }

    if (msg.CANLostFrom2024C !== undefined) {
      resolved.CANLostFrom2024C = msg.CANLostFrom2024C;
    }
    else {
      resolved.CANLostFrom2024C = false
    }

    if (msg.CANLostFromAVCU !== undefined) {
      resolved.CANLostFromAVCU = msg.CANLostFromAVCU;
    }
    else {
      resolved.CANLostFromAVCU = false
    }

    if (msg.velocityCmdState !== undefined) {
      resolved.velocityCmdState = msg.velocityCmdState;
    }
    else {
      resolved.velocityCmdState = 0
    }

    if (msg.speedCmdState !== undefined) {
      resolved.speedCmdState = msg.speedCmdState;
    }
    else {
      resolved.speedCmdState = 0
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = msg.acceleration;
    }
    else {
      resolved.acceleration = 0.0
    }

    if (msg.forceComp !== undefined) {
      resolved.forceComp = msg.forceComp;
    }
    else {
      resolved.forceComp = 0.0
    }

    if (msg.target_speed !== undefined) {
      resolved.target_speed = msg.target_speed;
    }
    else {
      resolved.target_speed = 0.0
    }

    if (msg.current_speed !== undefined) {
      resolved.current_speed = msg.current_speed;
    }
    else {
      resolved.current_speed = 0.0
    }

    if (msg.integral_term_action !== undefined) {
      resolved.integral_term_action = msg.integral_term_action;
    }
    else {
      resolved.integral_term_action = 0.0
    }

    if (msg.p_term_action !== undefined) {
      resolved.p_term_action = msg.p_term_action;
    }
    else {
      resolved.p_term_action = 0.0
    }

    if (msg.feedforward_action !== undefined) {
      resolved.feedforward_action = msg.feedforward_action;
    }
    else {
      resolved.feedforward_action = 0.0
    }

    if (msg.brake_pressure_f !== undefined) {
      resolved.brake_pressure_f = msg.brake_pressure_f;
    }
    else {
      resolved.brake_pressure_f = 0.0
    }

    if (msg.brake_pressure_r !== undefined) {
      resolved.brake_pressure_r = msg.brake_pressure_r;
    }
    else {
      resolved.brake_pressure_r = 0.0
    }

    if (msg.brake_pressure_f_tank !== undefined) {
      resolved.brake_pressure_f_tank = msg.brake_pressure_f_tank;
    }
    else {
      resolved.brake_pressure_f_tank = 0.0
    }

    if (msg.brake_pressure_r_tank !== undefined) {
      resolved.brake_pressure_r_tank = msg.brake_pressure_r_tank;
    }
    else {
      resolved.brake_pressure_r_tank = 0.0
    }

    return resolved;
    }
};

module.exports = SpeedControlState;
