// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TurnSignal = require('./TurnSignal.js');
let HighBeam = require('./HighBeam.js');
let WiperFront = require('./WiperFront.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class DriverInputReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.turn_signal = null;
      this.high_beam_headlights = null;
      this.wiper = null;
      this.cruise_resume_button = null;
      this.cruise_cancel_button = null;
      this.cruise_accel_button = null;
      this.cruise_decel_button = null;
      this.cruise_on_off_button = null;
      this.adaptive_cruise_on_off_button = null;
      this.adaptive_cruise_increase_distance_button = null;
      this.adaptive_cruise_decrease_distance_button = null;
      this.driver_door_ajar = null;
      this.passenger_door_ajar = null;
      this.rear_left_door_ajar = null;
      this.rear_right_door_ajar = null;
      this.liftgate_ajar = null;
      this.any_seatbelt_unbuckled = null;
      this.airbag_deployed = null;
      this.door_or_hood_ajar = null;
      this.drive_str_whl_button_a = null;
      this.drive_str_whl_button_b = null;
      this.drive_str_whl_button_c = null;
      this.drive_str_whl_button_d = null;
      this.drive_str_whl_button_e = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('turn_signal')) {
        this.turn_signal = initObj.turn_signal
      }
      else {
        this.turn_signal = new TurnSignal();
      }
      if (initObj.hasOwnProperty('high_beam_headlights')) {
        this.high_beam_headlights = initObj.high_beam_headlights
      }
      else {
        this.high_beam_headlights = new HighBeam();
      }
      if (initObj.hasOwnProperty('wiper')) {
        this.wiper = initObj.wiper
      }
      else {
        this.wiper = new WiperFront();
      }
      if (initObj.hasOwnProperty('cruise_resume_button')) {
        this.cruise_resume_button = initObj.cruise_resume_button
      }
      else {
        this.cruise_resume_button = false;
      }
      if (initObj.hasOwnProperty('cruise_cancel_button')) {
        this.cruise_cancel_button = initObj.cruise_cancel_button
      }
      else {
        this.cruise_cancel_button = false;
      }
      if (initObj.hasOwnProperty('cruise_accel_button')) {
        this.cruise_accel_button = initObj.cruise_accel_button
      }
      else {
        this.cruise_accel_button = false;
      }
      if (initObj.hasOwnProperty('cruise_decel_button')) {
        this.cruise_decel_button = initObj.cruise_decel_button
      }
      else {
        this.cruise_decel_button = false;
      }
      if (initObj.hasOwnProperty('cruise_on_off_button')) {
        this.cruise_on_off_button = initObj.cruise_on_off_button
      }
      else {
        this.cruise_on_off_button = false;
      }
      if (initObj.hasOwnProperty('adaptive_cruise_on_off_button')) {
        this.adaptive_cruise_on_off_button = initObj.adaptive_cruise_on_off_button
      }
      else {
        this.adaptive_cruise_on_off_button = false;
      }
      if (initObj.hasOwnProperty('adaptive_cruise_increase_distance_button')) {
        this.adaptive_cruise_increase_distance_button = initObj.adaptive_cruise_increase_distance_button
      }
      else {
        this.adaptive_cruise_increase_distance_button = false;
      }
      if (initObj.hasOwnProperty('adaptive_cruise_decrease_distance_button')) {
        this.adaptive_cruise_decrease_distance_button = initObj.adaptive_cruise_decrease_distance_button
      }
      else {
        this.adaptive_cruise_decrease_distance_button = false;
      }
      if (initObj.hasOwnProperty('driver_door_ajar')) {
        this.driver_door_ajar = initObj.driver_door_ajar
      }
      else {
        this.driver_door_ajar = false;
      }
      if (initObj.hasOwnProperty('passenger_door_ajar')) {
        this.passenger_door_ajar = initObj.passenger_door_ajar
      }
      else {
        this.passenger_door_ajar = false;
      }
      if (initObj.hasOwnProperty('rear_left_door_ajar')) {
        this.rear_left_door_ajar = initObj.rear_left_door_ajar
      }
      else {
        this.rear_left_door_ajar = false;
      }
      if (initObj.hasOwnProperty('rear_right_door_ajar')) {
        this.rear_right_door_ajar = initObj.rear_right_door_ajar
      }
      else {
        this.rear_right_door_ajar = false;
      }
      if (initObj.hasOwnProperty('liftgate_ajar')) {
        this.liftgate_ajar = initObj.liftgate_ajar
      }
      else {
        this.liftgate_ajar = false;
      }
      if (initObj.hasOwnProperty('any_seatbelt_unbuckled')) {
        this.any_seatbelt_unbuckled = initObj.any_seatbelt_unbuckled
      }
      else {
        this.any_seatbelt_unbuckled = false;
      }
      if (initObj.hasOwnProperty('airbag_deployed')) {
        this.airbag_deployed = initObj.airbag_deployed
      }
      else {
        this.airbag_deployed = false;
      }
      if (initObj.hasOwnProperty('door_or_hood_ajar')) {
        this.door_or_hood_ajar = initObj.door_or_hood_ajar
      }
      else {
        this.door_or_hood_ajar = false;
      }
      if (initObj.hasOwnProperty('drive_str_whl_button_a')) {
        this.drive_str_whl_button_a = initObj.drive_str_whl_button_a
      }
      else {
        this.drive_str_whl_button_a = false;
      }
      if (initObj.hasOwnProperty('drive_str_whl_button_b')) {
        this.drive_str_whl_button_b = initObj.drive_str_whl_button_b
      }
      else {
        this.drive_str_whl_button_b = false;
      }
      if (initObj.hasOwnProperty('drive_str_whl_button_c')) {
        this.drive_str_whl_button_c = initObj.drive_str_whl_button_c
      }
      else {
        this.drive_str_whl_button_c = false;
      }
      if (initObj.hasOwnProperty('drive_str_whl_button_d')) {
        this.drive_str_whl_button_d = initObj.drive_str_whl_button_d
      }
      else {
        this.drive_str_whl_button_d = false;
      }
      if (initObj.hasOwnProperty('drive_str_whl_button_e')) {
        this.drive_str_whl_button_e = initObj.drive_str_whl_button_e
      }
      else {
        this.drive_str_whl_button_e = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DriverInputReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [turn_signal]
    bufferOffset = TurnSignal.serialize(obj.turn_signal, buffer, bufferOffset);
    // Serialize message field [high_beam_headlights]
    bufferOffset = HighBeam.serialize(obj.high_beam_headlights, buffer, bufferOffset);
    // Serialize message field [wiper]
    bufferOffset = WiperFront.serialize(obj.wiper, buffer, bufferOffset);
    // Serialize message field [cruise_resume_button]
    bufferOffset = _serializer.bool(obj.cruise_resume_button, buffer, bufferOffset);
    // Serialize message field [cruise_cancel_button]
    bufferOffset = _serializer.bool(obj.cruise_cancel_button, buffer, bufferOffset);
    // Serialize message field [cruise_accel_button]
    bufferOffset = _serializer.bool(obj.cruise_accel_button, buffer, bufferOffset);
    // Serialize message field [cruise_decel_button]
    bufferOffset = _serializer.bool(obj.cruise_decel_button, buffer, bufferOffset);
    // Serialize message field [cruise_on_off_button]
    bufferOffset = _serializer.bool(obj.cruise_on_off_button, buffer, bufferOffset);
    // Serialize message field [adaptive_cruise_on_off_button]
    bufferOffset = _serializer.bool(obj.adaptive_cruise_on_off_button, buffer, bufferOffset);
    // Serialize message field [adaptive_cruise_increase_distance_button]
    bufferOffset = _serializer.bool(obj.adaptive_cruise_increase_distance_button, buffer, bufferOffset);
    // Serialize message field [adaptive_cruise_decrease_distance_button]
    bufferOffset = _serializer.bool(obj.adaptive_cruise_decrease_distance_button, buffer, bufferOffset);
    // Serialize message field [driver_door_ajar]
    bufferOffset = _serializer.bool(obj.driver_door_ajar, buffer, bufferOffset);
    // Serialize message field [passenger_door_ajar]
    bufferOffset = _serializer.bool(obj.passenger_door_ajar, buffer, bufferOffset);
    // Serialize message field [rear_left_door_ajar]
    bufferOffset = _serializer.bool(obj.rear_left_door_ajar, buffer, bufferOffset);
    // Serialize message field [rear_right_door_ajar]
    bufferOffset = _serializer.bool(obj.rear_right_door_ajar, buffer, bufferOffset);
    // Serialize message field [liftgate_ajar]
    bufferOffset = _serializer.bool(obj.liftgate_ajar, buffer, bufferOffset);
    // Serialize message field [any_seatbelt_unbuckled]
    bufferOffset = _serializer.bool(obj.any_seatbelt_unbuckled, buffer, bufferOffset);
    // Serialize message field [airbag_deployed]
    bufferOffset = _serializer.bool(obj.airbag_deployed, buffer, bufferOffset);
    // Serialize message field [door_or_hood_ajar]
    bufferOffset = _serializer.bool(obj.door_or_hood_ajar, buffer, bufferOffset);
    // Serialize message field [drive_str_whl_button_a]
    bufferOffset = _serializer.bool(obj.drive_str_whl_button_a, buffer, bufferOffset);
    // Serialize message field [drive_str_whl_button_b]
    bufferOffset = _serializer.bool(obj.drive_str_whl_button_b, buffer, bufferOffset);
    // Serialize message field [drive_str_whl_button_c]
    bufferOffset = _serializer.bool(obj.drive_str_whl_button_c, buffer, bufferOffset);
    // Serialize message field [drive_str_whl_button_d]
    bufferOffset = _serializer.bool(obj.drive_str_whl_button_d, buffer, bufferOffset);
    // Serialize message field [drive_str_whl_button_e]
    bufferOffset = _serializer.bool(obj.drive_str_whl_button_e, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DriverInputReport
    let len;
    let data = new DriverInputReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [turn_signal]
    data.turn_signal = TurnSignal.deserialize(buffer, bufferOffset);
    // Deserialize message field [high_beam_headlights]
    data.high_beam_headlights = HighBeam.deserialize(buffer, bufferOffset);
    // Deserialize message field [wiper]
    data.wiper = WiperFront.deserialize(buffer, bufferOffset);
    // Deserialize message field [cruise_resume_button]
    data.cruise_resume_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruise_cancel_button]
    data.cruise_cancel_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruise_accel_button]
    data.cruise_accel_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruise_decel_button]
    data.cruise_decel_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruise_on_off_button]
    data.cruise_on_off_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [adaptive_cruise_on_off_button]
    data.adaptive_cruise_on_off_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [adaptive_cruise_increase_distance_button]
    data.adaptive_cruise_increase_distance_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [adaptive_cruise_decrease_distance_button]
    data.adaptive_cruise_decrease_distance_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [driver_door_ajar]
    data.driver_door_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [passenger_door_ajar]
    data.passenger_door_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rear_left_door_ajar]
    data.rear_left_door_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rear_right_door_ajar]
    data.rear_right_door_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [liftgate_ajar]
    data.liftgate_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [any_seatbelt_unbuckled]
    data.any_seatbelt_unbuckled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [airbag_deployed]
    data.airbag_deployed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [door_or_hood_ajar]
    data.door_or_hood_ajar = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [drive_str_whl_button_a]
    data.drive_str_whl_button_a = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [drive_str_whl_button_b]
    data.drive_str_whl_button_b = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [drive_str_whl_button_c]
    data.drive_str_whl_button_c = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [drive_str_whl_button_d]
    data.drive_str_whl_button_d = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [drive_str_whl_button_e]
    data.drive_str_whl_button_e = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/DriverInputReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7d92e8189302532750bc994bbf345e99';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Turn Signal enumeration
    TurnSignal turn_signal
    
    # High beams
    HighBeam high_beam_headlights
    
    # Front Windshield Wipers enumeration
    WiperFront wiper
    
    # Buttons
    bool cruise_resume_button
    bool cruise_cancel_button
    bool cruise_accel_button
    bool cruise_decel_button
    bool cruise_on_off_button
    bool adaptive_cruise_on_off_button
    bool adaptive_cruise_increase_distance_button
    bool adaptive_cruise_decrease_distance_button
    
    # Door status
    bool driver_door_ajar
    bool passenger_door_ajar
    bool rear_left_door_ajar
    bool rear_right_door_ajar
    bool liftgate_ajar
    bool any_seatbelt_unbuckled
    bool airbag_deployed
    bool door_or_hood_ajar
    
    bool drive_str_whl_button_a
    bool drive_str_whl_button_b
    bool drive_str_whl_button_c
    bool drive_str_whl_button_d
    bool drive_str_whl_button_e
    
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
    
    ================================================================================
    MSG: dbw_pacifica_msgs/TurnSignal
    uint8 value
    
    uint8 NONE=0
    uint8 LEFT=1
    uint8 RIGHT=2
    
    ================================================================================
    MSG: dbw_pacifica_msgs/HighBeam
    uint8 status
    
    uint8 OFF = 0
    uint8 ON = 1
    uint8 FLASH = 2
    
    ================================================================================
    MSG: dbw_pacifica_msgs/WiperFront
    uint8 status
    
    uint8 OFF = 0
    uint8 INTERVAL_1 = 1
    uint8 INTERVAL_2 = 2
    uint8 INTERVAL_3 = 3
    uint8 INTERVAL_4 = 4
    uint8 INTERVAL_5 = 5
    uint8 INTERVAL_6 = 6
    uint8 CONSTANT_LOW = 11
    uint8 CONSTANT_HIGH = 12
    uint8 WASH_BRIEF = 13
    uint8 WASH_CONTINUOUS = 14
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DriverInputReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.turn_signal !== undefined) {
      resolved.turn_signal = TurnSignal.Resolve(msg.turn_signal)
    }
    else {
      resolved.turn_signal = new TurnSignal()
    }

    if (msg.high_beam_headlights !== undefined) {
      resolved.high_beam_headlights = HighBeam.Resolve(msg.high_beam_headlights)
    }
    else {
      resolved.high_beam_headlights = new HighBeam()
    }

    if (msg.wiper !== undefined) {
      resolved.wiper = WiperFront.Resolve(msg.wiper)
    }
    else {
      resolved.wiper = new WiperFront()
    }

    if (msg.cruise_resume_button !== undefined) {
      resolved.cruise_resume_button = msg.cruise_resume_button;
    }
    else {
      resolved.cruise_resume_button = false
    }

    if (msg.cruise_cancel_button !== undefined) {
      resolved.cruise_cancel_button = msg.cruise_cancel_button;
    }
    else {
      resolved.cruise_cancel_button = false
    }

    if (msg.cruise_accel_button !== undefined) {
      resolved.cruise_accel_button = msg.cruise_accel_button;
    }
    else {
      resolved.cruise_accel_button = false
    }

    if (msg.cruise_decel_button !== undefined) {
      resolved.cruise_decel_button = msg.cruise_decel_button;
    }
    else {
      resolved.cruise_decel_button = false
    }

    if (msg.cruise_on_off_button !== undefined) {
      resolved.cruise_on_off_button = msg.cruise_on_off_button;
    }
    else {
      resolved.cruise_on_off_button = false
    }

    if (msg.adaptive_cruise_on_off_button !== undefined) {
      resolved.adaptive_cruise_on_off_button = msg.adaptive_cruise_on_off_button;
    }
    else {
      resolved.adaptive_cruise_on_off_button = false
    }

    if (msg.adaptive_cruise_increase_distance_button !== undefined) {
      resolved.adaptive_cruise_increase_distance_button = msg.adaptive_cruise_increase_distance_button;
    }
    else {
      resolved.adaptive_cruise_increase_distance_button = false
    }

    if (msg.adaptive_cruise_decrease_distance_button !== undefined) {
      resolved.adaptive_cruise_decrease_distance_button = msg.adaptive_cruise_decrease_distance_button;
    }
    else {
      resolved.adaptive_cruise_decrease_distance_button = false
    }

    if (msg.driver_door_ajar !== undefined) {
      resolved.driver_door_ajar = msg.driver_door_ajar;
    }
    else {
      resolved.driver_door_ajar = false
    }

    if (msg.passenger_door_ajar !== undefined) {
      resolved.passenger_door_ajar = msg.passenger_door_ajar;
    }
    else {
      resolved.passenger_door_ajar = false
    }

    if (msg.rear_left_door_ajar !== undefined) {
      resolved.rear_left_door_ajar = msg.rear_left_door_ajar;
    }
    else {
      resolved.rear_left_door_ajar = false
    }

    if (msg.rear_right_door_ajar !== undefined) {
      resolved.rear_right_door_ajar = msg.rear_right_door_ajar;
    }
    else {
      resolved.rear_right_door_ajar = false
    }

    if (msg.liftgate_ajar !== undefined) {
      resolved.liftgate_ajar = msg.liftgate_ajar;
    }
    else {
      resolved.liftgate_ajar = false
    }

    if (msg.any_seatbelt_unbuckled !== undefined) {
      resolved.any_seatbelt_unbuckled = msg.any_seatbelt_unbuckled;
    }
    else {
      resolved.any_seatbelt_unbuckled = false
    }

    if (msg.airbag_deployed !== undefined) {
      resolved.airbag_deployed = msg.airbag_deployed;
    }
    else {
      resolved.airbag_deployed = false
    }

    if (msg.door_or_hood_ajar !== undefined) {
      resolved.door_or_hood_ajar = msg.door_or_hood_ajar;
    }
    else {
      resolved.door_or_hood_ajar = false
    }

    if (msg.drive_str_whl_button_a !== undefined) {
      resolved.drive_str_whl_button_a = msg.drive_str_whl_button_a;
    }
    else {
      resolved.drive_str_whl_button_a = false
    }

    if (msg.drive_str_whl_button_b !== undefined) {
      resolved.drive_str_whl_button_b = msg.drive_str_whl_button_b;
    }
    else {
      resolved.drive_str_whl_button_b = false
    }

    if (msg.drive_str_whl_button_c !== undefined) {
      resolved.drive_str_whl_button_c = msg.drive_str_whl_button_c;
    }
    else {
      resolved.drive_str_whl_button_c = false
    }

    if (msg.drive_str_whl_button_d !== undefined) {
      resolved.drive_str_whl_button_d = msg.drive_str_whl_button_d;
    }
    else {
      resolved.drive_str_whl_button_d = false
    }

    if (msg.drive_str_whl_button_e !== undefined) {
      resolved.drive_str_whl_button_e = msg.drive_str_whl_button_e;
    }
    else {
      resolved.drive_str_whl_button_e = false
    }

    return resolved;
    }
};

module.exports = DriverInputReport;
