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
let LowBeam = require('./LowBeam.js');
let WiperFront = require('./WiperFront.js');
let WiperRear = require('./WiperRear.js');
let Ignition = require('./Ignition.js');
let Door = require('./Door.js');
let DoorLock = require('./DoorLock.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ActuatorsReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.turn_signal_state = null;
      this.high_beam_headlights_state = null;
      this.low_beam_headlights_state = null;
      this.front_wiper_state = null;
      this.rear_wiper_state = null;
      this.rolling_counter = null;
      this.ignition_state = null;
      this.rear_left_door_state = null;
      this.rear_right_door_state = null;
      this.liftgate_state = null;
      this.door_lock_state = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('turn_signal_state')) {
        this.turn_signal_state = initObj.turn_signal_state
      }
      else {
        this.turn_signal_state = new TurnSignal();
      }
      if (initObj.hasOwnProperty('high_beam_headlights_state')) {
        this.high_beam_headlights_state = initObj.high_beam_headlights_state
      }
      else {
        this.high_beam_headlights_state = new HighBeam();
      }
      if (initObj.hasOwnProperty('low_beam_headlights_state')) {
        this.low_beam_headlights_state = initObj.low_beam_headlights_state
      }
      else {
        this.low_beam_headlights_state = new LowBeam();
      }
      if (initObj.hasOwnProperty('front_wiper_state')) {
        this.front_wiper_state = initObj.front_wiper_state
      }
      else {
        this.front_wiper_state = new WiperFront();
      }
      if (initObj.hasOwnProperty('rear_wiper_state')) {
        this.rear_wiper_state = initObj.rear_wiper_state
      }
      else {
        this.rear_wiper_state = new WiperRear();
      }
      if (initObj.hasOwnProperty('rolling_counter')) {
        this.rolling_counter = initObj.rolling_counter
      }
      else {
        this.rolling_counter = 0;
      }
      if (initObj.hasOwnProperty('ignition_state')) {
        this.ignition_state = initObj.ignition_state
      }
      else {
        this.ignition_state = new Ignition();
      }
      if (initObj.hasOwnProperty('rear_left_door_state')) {
        this.rear_left_door_state = initObj.rear_left_door_state
      }
      else {
        this.rear_left_door_state = new Door();
      }
      if (initObj.hasOwnProperty('rear_right_door_state')) {
        this.rear_right_door_state = initObj.rear_right_door_state
      }
      else {
        this.rear_right_door_state = new Door();
      }
      if (initObj.hasOwnProperty('liftgate_state')) {
        this.liftgate_state = initObj.liftgate_state
      }
      else {
        this.liftgate_state = new Door();
      }
      if (initObj.hasOwnProperty('door_lock_state')) {
        this.door_lock_state = initObj.door_lock_state
      }
      else {
        this.door_lock_state = new DoorLock();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ActuatorsReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [turn_signal_state]
    bufferOffset = TurnSignal.serialize(obj.turn_signal_state, buffer, bufferOffset);
    // Serialize message field [high_beam_headlights_state]
    bufferOffset = HighBeam.serialize(obj.high_beam_headlights_state, buffer, bufferOffset);
    // Serialize message field [low_beam_headlights_state]
    bufferOffset = LowBeam.serialize(obj.low_beam_headlights_state, buffer, bufferOffset);
    // Serialize message field [front_wiper_state]
    bufferOffset = WiperFront.serialize(obj.front_wiper_state, buffer, bufferOffset);
    // Serialize message field [rear_wiper_state]
    bufferOffset = WiperRear.serialize(obj.rear_wiper_state, buffer, bufferOffset);
    // Serialize message field [rolling_counter]
    bufferOffset = _serializer.uint8(obj.rolling_counter, buffer, bufferOffset);
    // Serialize message field [ignition_state]
    bufferOffset = Ignition.serialize(obj.ignition_state, buffer, bufferOffset);
    // Serialize message field [rear_left_door_state]
    bufferOffset = Door.serialize(obj.rear_left_door_state, buffer, bufferOffset);
    // Serialize message field [rear_right_door_state]
    bufferOffset = Door.serialize(obj.rear_right_door_state, buffer, bufferOffset);
    // Serialize message field [liftgate_state]
    bufferOffset = Door.serialize(obj.liftgate_state, buffer, bufferOffset);
    // Serialize message field [door_lock_state]
    bufferOffset = DoorLock.serialize(obj.door_lock_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ActuatorsReport
    let len;
    let data = new ActuatorsReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [turn_signal_state]
    data.turn_signal_state = TurnSignal.deserialize(buffer, bufferOffset);
    // Deserialize message field [high_beam_headlights_state]
    data.high_beam_headlights_state = HighBeam.deserialize(buffer, bufferOffset);
    // Deserialize message field [low_beam_headlights_state]
    data.low_beam_headlights_state = LowBeam.deserialize(buffer, bufferOffset);
    // Deserialize message field [front_wiper_state]
    data.front_wiper_state = WiperFront.deserialize(buffer, bufferOffset);
    // Deserialize message field [rear_wiper_state]
    data.rear_wiper_state = WiperRear.deserialize(buffer, bufferOffset);
    // Deserialize message field [rolling_counter]
    data.rolling_counter = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ignition_state]
    data.ignition_state = Ignition.deserialize(buffer, bufferOffset);
    // Deserialize message field [rear_left_door_state]
    data.rear_left_door_state = Door.deserialize(buffer, bufferOffset);
    // Deserialize message field [rear_right_door_state]
    data.rear_right_door_state = Door.deserialize(buffer, bufferOffset);
    // Deserialize message field [liftgate_state]
    data.liftgate_state = Door.deserialize(buffer, bufferOffset);
    // Deserialize message field [door_lock_state]
    data.door_lock_state = DoorLock.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 11;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/ActuatorsReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd66d15b164e1cf2d467650778182b722';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Turn Signal enumeration
    TurnSignal turn_signal_state
    
    # High beams
    HighBeam high_beam_headlights_state
    
    # Low beams
    LowBeam low_beam_headlights_state
    
    # Windshield Wipers enumeration
    WiperFront front_wiper_state
    WiperRear rear_wiper_state
    
    # Watchdog counter
    uint8 rolling_counter
    
    # Ignition
    Ignition ignition_state
    
    # HornState
    #HornState
    
    # Door status
    Door rear_left_door_state
    Door rear_right_door_state
    Door liftgate_state
    
    #Door lock
    DoorLock door_lock_state
    
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
    MSG: dbw_pacifica_msgs/LowBeam
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
    
    ================================================================================
    MSG: dbw_pacifica_msgs/WiperRear
    uint8 status
    
    uint8 OFF = 0
    uint8 INTERVAL_1 = 1
    uint8 CONSTANT_LOW = 11
    uint8 CONSTANT_HIGH = 12
    uint8 WASH_BRIEF = 13
    uint8 WASH_CONTINUOUS = 14
    
    ================================================================================
    MSG: dbw_pacifica_msgs/Ignition
    uint8 status
    
    uint8 NO_REQUEST = 0
    uint8 FORCE_OFF = 0
    uint8 ACCESSORY = 0
    uint8 RUN = 0
    uint8 CRANK = 0
    ================================================================================
    MSG: dbw_pacifica_msgs/Door
    uint8 value
    
    uint8 NO_REQUEST=0
    uint8 CLOSE_DOOR=1
    uint8 OPEN_DOOR=2
    
    ================================================================================
    MSG: dbw_pacifica_msgs/DoorLock
    uint8 value
    
    uint8 NOREQUEST=0
    uint8 UNLOCK=1
    uint8 LOCK=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ActuatorsReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.turn_signal_state !== undefined) {
      resolved.turn_signal_state = TurnSignal.Resolve(msg.turn_signal_state)
    }
    else {
      resolved.turn_signal_state = new TurnSignal()
    }

    if (msg.high_beam_headlights_state !== undefined) {
      resolved.high_beam_headlights_state = HighBeam.Resolve(msg.high_beam_headlights_state)
    }
    else {
      resolved.high_beam_headlights_state = new HighBeam()
    }

    if (msg.low_beam_headlights_state !== undefined) {
      resolved.low_beam_headlights_state = LowBeam.Resolve(msg.low_beam_headlights_state)
    }
    else {
      resolved.low_beam_headlights_state = new LowBeam()
    }

    if (msg.front_wiper_state !== undefined) {
      resolved.front_wiper_state = WiperFront.Resolve(msg.front_wiper_state)
    }
    else {
      resolved.front_wiper_state = new WiperFront()
    }

    if (msg.rear_wiper_state !== undefined) {
      resolved.rear_wiper_state = WiperRear.Resolve(msg.rear_wiper_state)
    }
    else {
      resolved.rear_wiper_state = new WiperRear()
    }

    if (msg.rolling_counter !== undefined) {
      resolved.rolling_counter = msg.rolling_counter;
    }
    else {
      resolved.rolling_counter = 0
    }

    if (msg.ignition_state !== undefined) {
      resolved.ignition_state = Ignition.Resolve(msg.ignition_state)
    }
    else {
      resolved.ignition_state = new Ignition()
    }

    if (msg.rear_left_door_state !== undefined) {
      resolved.rear_left_door_state = Door.Resolve(msg.rear_left_door_state)
    }
    else {
      resolved.rear_left_door_state = new Door()
    }

    if (msg.rear_right_door_state !== undefined) {
      resolved.rear_right_door_state = Door.Resolve(msg.rear_right_door_state)
    }
    else {
      resolved.rear_right_door_state = new Door()
    }

    if (msg.liftgate_state !== undefined) {
      resolved.liftgate_state = Door.Resolve(msg.liftgate_state)
    }
    else {
      resolved.liftgate_state = new Door()
    }

    if (msg.door_lock_state !== undefined) {
      resolved.door_lock_state = DoorLock.Resolve(msg.door_lock_state)
    }
    else {
      resolved.door_lock_state = new DoorLock()
    }

    return resolved;
    }
};

module.exports = ActuatorsReport;
