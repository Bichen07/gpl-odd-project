// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WheelSpeeds = require('./WheelSpeeds.js');
let CarEvent = require('./CarEvent.js');
let CruiseState = require('./CruiseState.js');
let ButtonEvent = require('./ButtonEvent.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class CarState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gearShifter = null;
      this.seatbeltUnlatched = null;
      this.clutchPressed = null;
      this.vEgoRaw = null;
      this.errorsDEPRECATED = null;
      this.brake = null;
      this.vEgo = null;
      this.steeringAngle = null;
      this.leftBlinker = null;
      this.wheelSpeeds = null;
      this.steeringRateLimited = null;
      this.stockFcw = null;
      this.doorOpen = null;
      this.steeringRate = null;
      this.events = null;
      this.steeringPressed = null;
      this.canValid = null;
      this.cruiseState = null;
      this.yawRate = null;
      this.steeringTorqueEps = null;
      this.gas = null;
      this.steeringTorque = null;
      this.genericToggle = null;
      this.brakeLights = null;
      this.buttonEvents = null;
      this.standstill = null;
      this.gasPressed = null;
      this.stockAeb = null;
      this.rightBlinker = null;
      this.brakePressed = null;
      this.aEgo = null;
      this.canMonoTimes = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gearShifter')) {
        this.gearShifter = initObj.gearShifter
      }
      else {
        this.gearShifter = 0;
      }
      if (initObj.hasOwnProperty('seatbeltUnlatched')) {
        this.seatbeltUnlatched = initObj.seatbeltUnlatched
      }
      else {
        this.seatbeltUnlatched = false;
      }
      if (initObj.hasOwnProperty('clutchPressed')) {
        this.clutchPressed = initObj.clutchPressed
      }
      else {
        this.clutchPressed = false;
      }
      if (initObj.hasOwnProperty('vEgoRaw')) {
        this.vEgoRaw = initObj.vEgoRaw
      }
      else {
        this.vEgoRaw = 0.0;
      }
      if (initObj.hasOwnProperty('errorsDEPRECATED')) {
        this.errorsDEPRECATED = initObj.errorsDEPRECATED
      }
      else {
        this.errorsDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('brake')) {
        this.brake = initObj.brake
      }
      else {
        this.brake = 0.0;
      }
      if (initObj.hasOwnProperty('vEgo')) {
        this.vEgo = initObj.vEgo
      }
      else {
        this.vEgo = 0.0;
      }
      if (initObj.hasOwnProperty('steeringAngle')) {
        this.steeringAngle = initObj.steeringAngle
      }
      else {
        this.steeringAngle = 0.0;
      }
      if (initObj.hasOwnProperty('leftBlinker')) {
        this.leftBlinker = initObj.leftBlinker
      }
      else {
        this.leftBlinker = false;
      }
      if (initObj.hasOwnProperty('wheelSpeeds')) {
        this.wheelSpeeds = initObj.wheelSpeeds
      }
      else {
        this.wheelSpeeds = new WheelSpeeds();
      }
      if (initObj.hasOwnProperty('steeringRateLimited')) {
        this.steeringRateLimited = initObj.steeringRateLimited
      }
      else {
        this.steeringRateLimited = false;
      }
      if (initObj.hasOwnProperty('stockFcw')) {
        this.stockFcw = initObj.stockFcw
      }
      else {
        this.stockFcw = false;
      }
      if (initObj.hasOwnProperty('doorOpen')) {
        this.doorOpen = initObj.doorOpen
      }
      else {
        this.doorOpen = false;
      }
      if (initObj.hasOwnProperty('steeringRate')) {
        this.steeringRate = initObj.steeringRate
      }
      else {
        this.steeringRate = 0.0;
      }
      if (initObj.hasOwnProperty('events')) {
        this.events = initObj.events
      }
      else {
        this.events = [];
      }
      if (initObj.hasOwnProperty('steeringPressed')) {
        this.steeringPressed = initObj.steeringPressed
      }
      else {
        this.steeringPressed = false;
      }
      if (initObj.hasOwnProperty('canValid')) {
        this.canValid = initObj.canValid
      }
      else {
        this.canValid = false;
      }
      if (initObj.hasOwnProperty('cruiseState')) {
        this.cruiseState = initObj.cruiseState
      }
      else {
        this.cruiseState = new CruiseState();
      }
      if (initObj.hasOwnProperty('yawRate')) {
        this.yawRate = initObj.yawRate
      }
      else {
        this.yawRate = 0.0;
      }
      if (initObj.hasOwnProperty('steeringTorqueEps')) {
        this.steeringTorqueEps = initObj.steeringTorqueEps
      }
      else {
        this.steeringTorqueEps = 0.0;
      }
      if (initObj.hasOwnProperty('gas')) {
        this.gas = initObj.gas
      }
      else {
        this.gas = 0.0;
      }
      if (initObj.hasOwnProperty('steeringTorque')) {
        this.steeringTorque = initObj.steeringTorque
      }
      else {
        this.steeringTorque = 0.0;
      }
      if (initObj.hasOwnProperty('genericToggle')) {
        this.genericToggle = initObj.genericToggle
      }
      else {
        this.genericToggle = false;
      }
      if (initObj.hasOwnProperty('brakeLights')) {
        this.brakeLights = initObj.brakeLights
      }
      else {
        this.brakeLights = false;
      }
      if (initObj.hasOwnProperty('buttonEvents')) {
        this.buttonEvents = initObj.buttonEvents
      }
      else {
        this.buttonEvents = [];
      }
      if (initObj.hasOwnProperty('standstill')) {
        this.standstill = initObj.standstill
      }
      else {
        this.standstill = false;
      }
      if (initObj.hasOwnProperty('gasPressed')) {
        this.gasPressed = initObj.gasPressed
      }
      else {
        this.gasPressed = false;
      }
      if (initObj.hasOwnProperty('stockAeb')) {
        this.stockAeb = initObj.stockAeb
      }
      else {
        this.stockAeb = false;
      }
      if (initObj.hasOwnProperty('rightBlinker')) {
        this.rightBlinker = initObj.rightBlinker
      }
      else {
        this.rightBlinker = false;
      }
      if (initObj.hasOwnProperty('brakePressed')) {
        this.brakePressed = initObj.brakePressed
      }
      else {
        this.brakePressed = false;
      }
      if (initObj.hasOwnProperty('aEgo')) {
        this.aEgo = initObj.aEgo
      }
      else {
        this.aEgo = 0.0;
      }
      if (initObj.hasOwnProperty('canMonoTimes')) {
        this.canMonoTimes = initObj.canMonoTimes
      }
      else {
        this.canMonoTimes = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CarState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gearShifter]
    bufferOffset = _serializer.uint32(obj.gearShifter, buffer, bufferOffset);
    // Serialize message field [seatbeltUnlatched]
    bufferOffset = _serializer.bool(obj.seatbeltUnlatched, buffer, bufferOffset);
    // Serialize message field [clutchPressed]
    bufferOffset = _serializer.bool(obj.clutchPressed, buffer, bufferOffset);
    // Serialize message field [vEgoRaw]
    bufferOffset = _serializer.float32(obj.vEgoRaw, buffer, bufferOffset);
    // Serialize message field [errorsDEPRECATED]
    bufferOffset = _arraySerializer.uint32(obj.errorsDEPRECATED, buffer, bufferOffset, null);
    // Serialize message field [brake]
    bufferOffset = _serializer.float32(obj.brake, buffer, bufferOffset);
    // Serialize message field [vEgo]
    bufferOffset = _serializer.float32(obj.vEgo, buffer, bufferOffset);
    // Serialize message field [steeringAngle]
    bufferOffset = _serializer.float32(obj.steeringAngle, buffer, bufferOffset);
    // Serialize message field [leftBlinker]
    bufferOffset = _serializer.bool(obj.leftBlinker, buffer, bufferOffset);
    // Serialize message field [wheelSpeeds]
    bufferOffset = WheelSpeeds.serialize(obj.wheelSpeeds, buffer, bufferOffset);
    // Serialize message field [steeringRateLimited]
    bufferOffset = _serializer.bool(obj.steeringRateLimited, buffer, bufferOffset);
    // Serialize message field [stockFcw]
    bufferOffset = _serializer.bool(obj.stockFcw, buffer, bufferOffset);
    // Serialize message field [doorOpen]
    bufferOffset = _serializer.bool(obj.doorOpen, buffer, bufferOffset);
    // Serialize message field [steeringRate]
    bufferOffset = _serializer.float32(obj.steeringRate, buffer, bufferOffset);
    // Serialize message field [events]
    // Serialize the length for message field [events]
    bufferOffset = _serializer.uint32(obj.events.length, buffer, bufferOffset);
    obj.events.forEach((val) => {
      bufferOffset = CarEvent.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [steeringPressed]
    bufferOffset = _serializer.bool(obj.steeringPressed, buffer, bufferOffset);
    // Serialize message field [canValid]
    bufferOffset = _serializer.bool(obj.canValid, buffer, bufferOffset);
    // Serialize message field [cruiseState]
    bufferOffset = CruiseState.serialize(obj.cruiseState, buffer, bufferOffset);
    // Serialize message field [yawRate]
    bufferOffset = _serializer.float32(obj.yawRate, buffer, bufferOffset);
    // Serialize message field [steeringTorqueEps]
    bufferOffset = _serializer.float32(obj.steeringTorqueEps, buffer, bufferOffset);
    // Serialize message field [gas]
    bufferOffset = _serializer.float32(obj.gas, buffer, bufferOffset);
    // Serialize message field [steeringTorque]
    bufferOffset = _serializer.float32(obj.steeringTorque, buffer, bufferOffset);
    // Serialize message field [genericToggle]
    bufferOffset = _serializer.bool(obj.genericToggle, buffer, bufferOffset);
    // Serialize message field [brakeLights]
    bufferOffset = _serializer.bool(obj.brakeLights, buffer, bufferOffset);
    // Serialize message field [buttonEvents]
    // Serialize the length for message field [buttonEvents]
    bufferOffset = _serializer.uint32(obj.buttonEvents.length, buffer, bufferOffset);
    obj.buttonEvents.forEach((val) => {
      bufferOffset = ButtonEvent.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [standstill]
    bufferOffset = _serializer.bool(obj.standstill, buffer, bufferOffset);
    // Serialize message field [gasPressed]
    bufferOffset = _serializer.bool(obj.gasPressed, buffer, bufferOffset);
    // Serialize message field [stockAeb]
    bufferOffset = _serializer.bool(obj.stockAeb, buffer, bufferOffset);
    // Serialize message field [rightBlinker]
    bufferOffset = _serializer.bool(obj.rightBlinker, buffer, bufferOffset);
    // Serialize message field [brakePressed]
    bufferOffset = _serializer.bool(obj.brakePressed, buffer, bufferOffset);
    // Serialize message field [aEgo]
    bufferOffset = _serializer.float32(obj.aEgo, buffer, bufferOffset);
    // Serialize message field [canMonoTimes]
    bufferOffset = _arraySerializer.int64(obj.canMonoTimes, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CarState
    let len;
    let data = new CarState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gearShifter]
    data.gearShifter = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [seatbeltUnlatched]
    data.seatbeltUnlatched = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [clutchPressed]
    data.clutchPressed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [vEgoRaw]
    data.vEgoRaw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [errorsDEPRECATED]
    data.errorsDEPRECATED = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [brake]
    data.brake = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vEgo]
    data.vEgo = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steeringAngle]
    data.steeringAngle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [leftBlinker]
    data.leftBlinker = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [wheelSpeeds]
    data.wheelSpeeds = WheelSpeeds.deserialize(buffer, bufferOffset);
    // Deserialize message field [steeringRateLimited]
    data.steeringRateLimited = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [stockFcw]
    data.stockFcw = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [doorOpen]
    data.doorOpen = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [steeringRate]
    data.steeringRate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [events]
    // Deserialize array length for message field [events]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.events = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.events[i] = CarEvent.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [steeringPressed]
    data.steeringPressed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [canValid]
    data.canValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruiseState]
    data.cruiseState = CruiseState.deserialize(buffer, bufferOffset);
    // Deserialize message field [yawRate]
    data.yawRate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steeringTorqueEps]
    data.steeringTorqueEps = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gas]
    data.gas = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steeringTorque]
    data.steeringTorque = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [genericToggle]
    data.genericToggle = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [brakeLights]
    data.brakeLights = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [buttonEvents]
    // Deserialize array length for message field [buttonEvents]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.buttonEvents = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.buttonEvents[i] = ButtonEvent.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [standstill]
    data.standstill = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gasPressed]
    data.gasPressed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [stockAeb]
    data.stockAeb = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rightBlinker]
    data.rightBlinker = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [brakePressed]
    data.brakePressed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [aEgo]
    data.aEgo = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [canMonoTimes]
    data.canMonoTimes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.errorsDEPRECATED.length;
    length += WheelSpeeds.getMessageSize(object.wheelSpeeds);
    object.events.forEach((val) => {
      length += CarEvent.getMessageSize(val);
    });
    length += CruiseState.getMessageSize(object.cruiseState);
    object.buttonEvents.forEach((val) => {
      length += ButtonEvent.getMessageSize(val);
    });
    length += 8 * object.canMonoTimes.length;
    return length + 75;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CarState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'aa82270c536e806e4bbbc48f00d9d6a7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint32 gearShifter # enum const: GearShifter
    bool seatbeltUnlatched
    bool clutchPressed
    float32 vEgoRaw
    uint32[] errorsDEPRECATED # enum const: EventName
    float32 brake
    float32 vEgo
    float32 steeringAngle
    bool leftBlinker
    WheelSpeeds wheelSpeeds
    bool steeringRateLimited
    bool stockFcw
    bool doorOpen
    float32 steeringRate
    CarEvent[] events
    bool steeringPressed
    bool canValid
    CruiseState cruiseState
    float32 yawRate
    float32 steeringTorqueEps
    float32 gas
    float32 steeringTorque
    bool genericToggle
    bool brakeLights
    ButtonEvent[] buttonEvents
    bool standstill
    bool gasPressed
    bool stockAeb
    bool rightBlinker
    bool brakePressed
    float32 aEgo
    int64[] canMonoTimes
    
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
    MSG: openpilot_bridge/WheelSpeeds
    Header header
    
    float32 rl
    float32 fr
    float32 fl
    float32 rr
    
    ================================================================================
    MSG: openpilot_bridge/CarEvent
    Header header
    
    bool enable
    bool noEntry
    uint32 name # enum const: EventName
    bool immediateDisable
    bool warning
    bool permanent
    bool softDisable
    bool userDisable
    bool preEnable
    
    ================================================================================
    MSG: openpilot_bridge/CruiseState
    Header header
    
    bool available
    float32 speed
    float32 speedOffset
    bool enabled
    bool standstill
    
    ================================================================================
    MSG: openpilot_bridge/ButtonEvent
    Header header
    
    uint32 type # enum const: Type
    bool pressed
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CarState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gearShifter !== undefined) {
      resolved.gearShifter = msg.gearShifter;
    }
    else {
      resolved.gearShifter = 0
    }

    if (msg.seatbeltUnlatched !== undefined) {
      resolved.seatbeltUnlatched = msg.seatbeltUnlatched;
    }
    else {
      resolved.seatbeltUnlatched = false
    }

    if (msg.clutchPressed !== undefined) {
      resolved.clutchPressed = msg.clutchPressed;
    }
    else {
      resolved.clutchPressed = false
    }

    if (msg.vEgoRaw !== undefined) {
      resolved.vEgoRaw = msg.vEgoRaw;
    }
    else {
      resolved.vEgoRaw = 0.0
    }

    if (msg.errorsDEPRECATED !== undefined) {
      resolved.errorsDEPRECATED = msg.errorsDEPRECATED;
    }
    else {
      resolved.errorsDEPRECATED = []
    }

    if (msg.brake !== undefined) {
      resolved.brake = msg.brake;
    }
    else {
      resolved.brake = 0.0
    }

    if (msg.vEgo !== undefined) {
      resolved.vEgo = msg.vEgo;
    }
    else {
      resolved.vEgo = 0.0
    }

    if (msg.steeringAngle !== undefined) {
      resolved.steeringAngle = msg.steeringAngle;
    }
    else {
      resolved.steeringAngle = 0.0
    }

    if (msg.leftBlinker !== undefined) {
      resolved.leftBlinker = msg.leftBlinker;
    }
    else {
      resolved.leftBlinker = false
    }

    if (msg.wheelSpeeds !== undefined) {
      resolved.wheelSpeeds = WheelSpeeds.Resolve(msg.wheelSpeeds)
    }
    else {
      resolved.wheelSpeeds = new WheelSpeeds()
    }

    if (msg.steeringRateLimited !== undefined) {
      resolved.steeringRateLimited = msg.steeringRateLimited;
    }
    else {
      resolved.steeringRateLimited = false
    }

    if (msg.stockFcw !== undefined) {
      resolved.stockFcw = msg.stockFcw;
    }
    else {
      resolved.stockFcw = false
    }

    if (msg.doorOpen !== undefined) {
      resolved.doorOpen = msg.doorOpen;
    }
    else {
      resolved.doorOpen = false
    }

    if (msg.steeringRate !== undefined) {
      resolved.steeringRate = msg.steeringRate;
    }
    else {
      resolved.steeringRate = 0.0
    }

    if (msg.events !== undefined) {
      resolved.events = new Array(msg.events.length);
      for (let i = 0; i < resolved.events.length; ++i) {
        resolved.events[i] = CarEvent.Resolve(msg.events[i]);
      }
    }
    else {
      resolved.events = []
    }

    if (msg.steeringPressed !== undefined) {
      resolved.steeringPressed = msg.steeringPressed;
    }
    else {
      resolved.steeringPressed = false
    }

    if (msg.canValid !== undefined) {
      resolved.canValid = msg.canValid;
    }
    else {
      resolved.canValid = false
    }

    if (msg.cruiseState !== undefined) {
      resolved.cruiseState = CruiseState.Resolve(msg.cruiseState)
    }
    else {
      resolved.cruiseState = new CruiseState()
    }

    if (msg.yawRate !== undefined) {
      resolved.yawRate = msg.yawRate;
    }
    else {
      resolved.yawRate = 0.0
    }

    if (msg.steeringTorqueEps !== undefined) {
      resolved.steeringTorqueEps = msg.steeringTorqueEps;
    }
    else {
      resolved.steeringTorqueEps = 0.0
    }

    if (msg.gas !== undefined) {
      resolved.gas = msg.gas;
    }
    else {
      resolved.gas = 0.0
    }

    if (msg.steeringTorque !== undefined) {
      resolved.steeringTorque = msg.steeringTorque;
    }
    else {
      resolved.steeringTorque = 0.0
    }

    if (msg.genericToggle !== undefined) {
      resolved.genericToggle = msg.genericToggle;
    }
    else {
      resolved.genericToggle = false
    }

    if (msg.brakeLights !== undefined) {
      resolved.brakeLights = msg.brakeLights;
    }
    else {
      resolved.brakeLights = false
    }

    if (msg.buttonEvents !== undefined) {
      resolved.buttonEvents = new Array(msg.buttonEvents.length);
      for (let i = 0; i < resolved.buttonEvents.length; ++i) {
        resolved.buttonEvents[i] = ButtonEvent.Resolve(msg.buttonEvents[i]);
      }
    }
    else {
      resolved.buttonEvents = []
    }

    if (msg.standstill !== undefined) {
      resolved.standstill = msg.standstill;
    }
    else {
      resolved.standstill = false
    }

    if (msg.gasPressed !== undefined) {
      resolved.gasPressed = msg.gasPressed;
    }
    else {
      resolved.gasPressed = false
    }

    if (msg.stockAeb !== undefined) {
      resolved.stockAeb = msg.stockAeb;
    }
    else {
      resolved.stockAeb = false
    }

    if (msg.rightBlinker !== undefined) {
      resolved.rightBlinker = msg.rightBlinker;
    }
    else {
      resolved.rightBlinker = false
    }

    if (msg.brakePressed !== undefined) {
      resolved.brakePressed = msg.brakePressed;
    }
    else {
      resolved.brakePressed = false
    }

    if (msg.aEgo !== undefined) {
      resolved.aEgo = msg.aEgo;
    }
    else {
      resolved.aEgo = 0.0
    }

    if (msg.canMonoTimes !== undefined) {
      resolved.canMonoTimes = msg.canMonoTimes;
    }
    else {
      resolved.canMonoTimes = []
    }

    return resolved;
    }
};

module.exports = CarState;
