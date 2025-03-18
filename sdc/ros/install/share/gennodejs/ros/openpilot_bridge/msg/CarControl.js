// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let CruiseControl = require('./CruiseControl.js');
let Actuators = require('./Actuators.js');
let HUDControl = require('./HUDControl.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class CarControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.brakeDEPRECATED = null;
      this.gasDEPRECATED = null;
      this.steeringTorqueDEPRECATED = null;
      this.cruiseControl = null;
      this.actuators = null;
      this.active = null;
      this.hudControl = null;
      this.enabled = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('brakeDEPRECATED')) {
        this.brakeDEPRECATED = initObj.brakeDEPRECATED
      }
      else {
        this.brakeDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('gasDEPRECATED')) {
        this.gasDEPRECATED = initObj.gasDEPRECATED
      }
      else {
        this.gasDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('steeringTorqueDEPRECATED')) {
        this.steeringTorqueDEPRECATED = initObj.steeringTorqueDEPRECATED
      }
      else {
        this.steeringTorqueDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('cruiseControl')) {
        this.cruiseControl = initObj.cruiseControl
      }
      else {
        this.cruiseControl = new CruiseControl();
      }
      if (initObj.hasOwnProperty('actuators')) {
        this.actuators = initObj.actuators
      }
      else {
        this.actuators = new Actuators();
      }
      if (initObj.hasOwnProperty('active')) {
        this.active = initObj.active
      }
      else {
        this.active = false;
      }
      if (initObj.hasOwnProperty('hudControl')) {
        this.hudControl = initObj.hudControl
      }
      else {
        this.hudControl = new HUDControl();
      }
      if (initObj.hasOwnProperty('enabled')) {
        this.enabled = initObj.enabled
      }
      else {
        this.enabled = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CarControl
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [brakeDEPRECATED]
    bufferOffset = _serializer.float32(obj.brakeDEPRECATED, buffer, bufferOffset);
    // Serialize message field [gasDEPRECATED]
    bufferOffset = _serializer.float32(obj.gasDEPRECATED, buffer, bufferOffset);
    // Serialize message field [steeringTorqueDEPRECATED]
    bufferOffset = _serializer.float32(obj.steeringTorqueDEPRECATED, buffer, bufferOffset);
    // Serialize message field [cruiseControl]
    bufferOffset = CruiseControl.serialize(obj.cruiseControl, buffer, bufferOffset);
    // Serialize message field [actuators]
    bufferOffset = Actuators.serialize(obj.actuators, buffer, bufferOffset);
    // Serialize message field [active]
    bufferOffset = _serializer.bool(obj.active, buffer, bufferOffset);
    // Serialize message field [hudControl]
    bufferOffset = HUDControl.serialize(obj.hudControl, buffer, bufferOffset);
    // Serialize message field [enabled]
    bufferOffset = _serializer.bool(obj.enabled, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CarControl
    let len;
    let data = new CarControl(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [brakeDEPRECATED]
    data.brakeDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gasDEPRECATED]
    data.gasDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steeringTorqueDEPRECATED]
    data.steeringTorqueDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cruiseControl]
    data.cruiseControl = CruiseControl.deserialize(buffer, bufferOffset);
    // Deserialize message field [actuators]
    data.actuators = Actuators.deserialize(buffer, bufferOffset);
    // Deserialize message field [active]
    data.active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [hudControl]
    data.hudControl = HUDControl.deserialize(buffer, bufferOffset);
    // Deserialize message field [enabled]
    data.enabled = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += CruiseControl.getMessageSize(object.cruiseControl);
    length += Actuators.getMessageSize(object.actuators);
    length += HUDControl.getMessageSize(object.hudControl);
    return length + 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CarControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5052bf96d04aed7d203247b76e13ddb3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 brakeDEPRECATED
    float32 gasDEPRECATED
    float32 steeringTorqueDEPRECATED
    CruiseControl cruiseControl
    Actuators actuators
    bool active
    HUDControl hudControl
    bool enabled
    
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
    MSG: openpilot_bridge/CruiseControl
    Header header
    
    bool cancel
    bool override
    float32 speedOverride
    float32 accelOverride
    
    ================================================================================
    MSG: openpilot_bridge/Actuators
    Header header
    
    float32 brake
    float32 gas
    float32 steerAngle
    float32 steer
    
    ================================================================================
    MSG: openpilot_bridge/HUDControl
    Header header
    
    bool leadVisible
    float32 setSpeed
    bool leftLaneDepart
    bool lanesVisible
    bool leftLaneVisible
    uint32 visualAlert # enum const: VisualAlert
    uint32 audibleAlert # enum const: AudibleAlert
    bool speedVisible
    bool rightLaneVisible
    bool rightLaneDepart
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CarControl(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.brakeDEPRECATED !== undefined) {
      resolved.brakeDEPRECATED = msg.brakeDEPRECATED;
    }
    else {
      resolved.brakeDEPRECATED = 0.0
    }

    if (msg.gasDEPRECATED !== undefined) {
      resolved.gasDEPRECATED = msg.gasDEPRECATED;
    }
    else {
      resolved.gasDEPRECATED = 0.0
    }

    if (msg.steeringTorqueDEPRECATED !== undefined) {
      resolved.steeringTorqueDEPRECATED = msg.steeringTorqueDEPRECATED;
    }
    else {
      resolved.steeringTorqueDEPRECATED = 0.0
    }

    if (msg.cruiseControl !== undefined) {
      resolved.cruiseControl = CruiseControl.Resolve(msg.cruiseControl)
    }
    else {
      resolved.cruiseControl = new CruiseControl()
    }

    if (msg.actuators !== undefined) {
      resolved.actuators = Actuators.Resolve(msg.actuators)
    }
    else {
      resolved.actuators = new Actuators()
    }

    if (msg.active !== undefined) {
      resolved.active = msg.active;
    }
    else {
      resolved.active = false
    }

    if (msg.hudControl !== undefined) {
      resolved.hudControl = HUDControl.Resolve(msg.hudControl)
    }
    else {
      resolved.hudControl = new HUDControl()
    }

    if (msg.enabled !== undefined) {
      resolved.enabled = msg.enabled;
    }
    else {
      resolved.enabled = false
    }

    return resolved;
    }
};

module.exports = CarControl;
