// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PathPlan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.angleSteers = null;
      this.commIssue = null;
      this.lPoly = null;
      this.laneChangeState = null;
      this.sensorValid = null;
      this.mpcSolutionValid = null;
      this.lProb = null;
      this.modelValidDEPRECATED = null;
      this.rProb = null;
      this.cProb = null;
      this.rPoly = null;
      this.laneWidth = null;
      this.angleOffset = null;
      this.rateSteers = null;
      this.laneChangeDirection = null;
      this.paramsValid = null;
      this.cPoly = null;
      this.posenetValid = null;
      this.dPoly = null;
      this.desire = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('angleSteers')) {
        this.angleSteers = initObj.angleSteers
      }
      else {
        this.angleSteers = 0.0;
      }
      if (initObj.hasOwnProperty('commIssue')) {
        this.commIssue = initObj.commIssue
      }
      else {
        this.commIssue = false;
      }
      if (initObj.hasOwnProperty('lPoly')) {
        this.lPoly = initObj.lPoly
      }
      else {
        this.lPoly = [];
      }
      if (initObj.hasOwnProperty('laneChangeState')) {
        this.laneChangeState = initObj.laneChangeState
      }
      else {
        this.laneChangeState = 0;
      }
      if (initObj.hasOwnProperty('sensorValid')) {
        this.sensorValid = initObj.sensorValid
      }
      else {
        this.sensorValid = false;
      }
      if (initObj.hasOwnProperty('mpcSolutionValid')) {
        this.mpcSolutionValid = initObj.mpcSolutionValid
      }
      else {
        this.mpcSolutionValid = false;
      }
      if (initObj.hasOwnProperty('lProb')) {
        this.lProb = initObj.lProb
      }
      else {
        this.lProb = 0.0;
      }
      if (initObj.hasOwnProperty('modelValidDEPRECATED')) {
        this.modelValidDEPRECATED = initObj.modelValidDEPRECATED
      }
      else {
        this.modelValidDEPRECATED = false;
      }
      if (initObj.hasOwnProperty('rProb')) {
        this.rProb = initObj.rProb
      }
      else {
        this.rProb = 0.0;
      }
      if (initObj.hasOwnProperty('cProb')) {
        this.cProb = initObj.cProb
      }
      else {
        this.cProb = 0.0;
      }
      if (initObj.hasOwnProperty('rPoly')) {
        this.rPoly = initObj.rPoly
      }
      else {
        this.rPoly = [];
      }
      if (initObj.hasOwnProperty('laneWidth')) {
        this.laneWidth = initObj.laneWidth
      }
      else {
        this.laneWidth = 0.0;
      }
      if (initObj.hasOwnProperty('angleOffset')) {
        this.angleOffset = initObj.angleOffset
      }
      else {
        this.angleOffset = 0.0;
      }
      if (initObj.hasOwnProperty('rateSteers')) {
        this.rateSteers = initObj.rateSteers
      }
      else {
        this.rateSteers = 0.0;
      }
      if (initObj.hasOwnProperty('laneChangeDirection')) {
        this.laneChangeDirection = initObj.laneChangeDirection
      }
      else {
        this.laneChangeDirection = 0;
      }
      if (initObj.hasOwnProperty('paramsValid')) {
        this.paramsValid = initObj.paramsValid
      }
      else {
        this.paramsValid = false;
      }
      if (initObj.hasOwnProperty('cPoly')) {
        this.cPoly = initObj.cPoly
      }
      else {
        this.cPoly = [];
      }
      if (initObj.hasOwnProperty('posenetValid')) {
        this.posenetValid = initObj.posenetValid
      }
      else {
        this.posenetValid = false;
      }
      if (initObj.hasOwnProperty('dPoly')) {
        this.dPoly = initObj.dPoly
      }
      else {
        this.dPoly = [];
      }
      if (initObj.hasOwnProperty('desire')) {
        this.desire = initObj.desire
      }
      else {
        this.desire = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathPlan
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [angleSteers]
    bufferOffset = _serializer.float32(obj.angleSteers, buffer, bufferOffset);
    // Serialize message field [commIssue]
    bufferOffset = _serializer.bool(obj.commIssue, buffer, bufferOffset);
    // Serialize message field [lPoly]
    bufferOffset = _arraySerializer.float32(obj.lPoly, buffer, bufferOffset, null);
    // Serialize message field [laneChangeState]
    bufferOffset = _serializer.uint32(obj.laneChangeState, buffer, bufferOffset);
    // Serialize message field [sensorValid]
    bufferOffset = _serializer.bool(obj.sensorValid, buffer, bufferOffset);
    // Serialize message field [mpcSolutionValid]
    bufferOffset = _serializer.bool(obj.mpcSolutionValid, buffer, bufferOffset);
    // Serialize message field [lProb]
    bufferOffset = _serializer.float32(obj.lProb, buffer, bufferOffset);
    // Serialize message field [modelValidDEPRECATED]
    bufferOffset = _serializer.bool(obj.modelValidDEPRECATED, buffer, bufferOffset);
    // Serialize message field [rProb]
    bufferOffset = _serializer.float32(obj.rProb, buffer, bufferOffset);
    // Serialize message field [cProb]
    bufferOffset = _serializer.float32(obj.cProb, buffer, bufferOffset);
    // Serialize message field [rPoly]
    bufferOffset = _arraySerializer.float32(obj.rPoly, buffer, bufferOffset, null);
    // Serialize message field [laneWidth]
    bufferOffset = _serializer.float32(obj.laneWidth, buffer, bufferOffset);
    // Serialize message field [angleOffset]
    bufferOffset = _serializer.float32(obj.angleOffset, buffer, bufferOffset);
    // Serialize message field [rateSteers]
    bufferOffset = _serializer.float32(obj.rateSteers, buffer, bufferOffset);
    // Serialize message field [laneChangeDirection]
    bufferOffset = _serializer.uint32(obj.laneChangeDirection, buffer, bufferOffset);
    // Serialize message field [paramsValid]
    bufferOffset = _serializer.bool(obj.paramsValid, buffer, bufferOffset);
    // Serialize message field [cPoly]
    bufferOffset = _arraySerializer.float32(obj.cPoly, buffer, bufferOffset, null);
    // Serialize message field [posenetValid]
    bufferOffset = _serializer.bool(obj.posenetValid, buffer, bufferOffset);
    // Serialize message field [dPoly]
    bufferOffset = _arraySerializer.float32(obj.dPoly, buffer, bufferOffset, null);
    // Serialize message field [desire]
    bufferOffset = _serializer.uint32(obj.desire, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathPlan
    let len;
    let data = new PathPlan(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [angleSteers]
    data.angleSteers = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [commIssue]
    data.commIssue = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lPoly]
    data.lPoly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [laneChangeState]
    data.laneChangeState = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [sensorValid]
    data.sensorValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mpcSolutionValid]
    data.mpcSolutionValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [lProb]
    data.lProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [modelValidDEPRECATED]
    data.modelValidDEPRECATED = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rProb]
    data.rProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cProb]
    data.cProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rPoly]
    data.rPoly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [laneWidth]
    data.laneWidth = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angleOffset]
    data.angleOffset = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rateSteers]
    data.rateSteers = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [laneChangeDirection]
    data.laneChangeDirection = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [paramsValid]
    data.paramsValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cPoly]
    data.cPoly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [posenetValid]
    data.posenetValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [dPoly]
    data.dPoly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [desire]
    data.desire = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.lPoly.length;
    length += 4 * object.rPoly.length;
    length += 4 * object.cPoly.length;
    length += 4 * object.dPoly.length;
    return length + 62;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/PathPlan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '39d44bb8d0ae27698feefef0dbe76a71';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 angleSteers
    bool commIssue
    float32[] lPoly
    uint32 laneChangeState # enum const: LaneChangeState
    bool sensorValid
    bool mpcSolutionValid
    float32 lProb
    bool modelValidDEPRECATED
    float32 rProb
    float32 cProb
    float32[] rPoly
    float32 laneWidth
    float32 angleOffset
    float32 rateSteers
    uint32 laneChangeDirection # enum const: LaneChangeDirection
    bool paramsValid
    float32[] cPoly
    bool posenetValid
    float32[] dPoly
    uint32 desire # enum const: Desire
    
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
    const resolved = new PathPlan(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.angleSteers !== undefined) {
      resolved.angleSteers = msg.angleSteers;
    }
    else {
      resolved.angleSteers = 0.0
    }

    if (msg.commIssue !== undefined) {
      resolved.commIssue = msg.commIssue;
    }
    else {
      resolved.commIssue = false
    }

    if (msg.lPoly !== undefined) {
      resolved.lPoly = msg.lPoly;
    }
    else {
      resolved.lPoly = []
    }

    if (msg.laneChangeState !== undefined) {
      resolved.laneChangeState = msg.laneChangeState;
    }
    else {
      resolved.laneChangeState = 0
    }

    if (msg.sensorValid !== undefined) {
      resolved.sensorValid = msg.sensorValid;
    }
    else {
      resolved.sensorValid = false
    }

    if (msg.mpcSolutionValid !== undefined) {
      resolved.mpcSolutionValid = msg.mpcSolutionValid;
    }
    else {
      resolved.mpcSolutionValid = false
    }

    if (msg.lProb !== undefined) {
      resolved.lProb = msg.lProb;
    }
    else {
      resolved.lProb = 0.0
    }

    if (msg.modelValidDEPRECATED !== undefined) {
      resolved.modelValidDEPRECATED = msg.modelValidDEPRECATED;
    }
    else {
      resolved.modelValidDEPRECATED = false
    }

    if (msg.rProb !== undefined) {
      resolved.rProb = msg.rProb;
    }
    else {
      resolved.rProb = 0.0
    }

    if (msg.cProb !== undefined) {
      resolved.cProb = msg.cProb;
    }
    else {
      resolved.cProb = 0.0
    }

    if (msg.rPoly !== undefined) {
      resolved.rPoly = msg.rPoly;
    }
    else {
      resolved.rPoly = []
    }

    if (msg.laneWidth !== undefined) {
      resolved.laneWidth = msg.laneWidth;
    }
    else {
      resolved.laneWidth = 0.0
    }

    if (msg.angleOffset !== undefined) {
      resolved.angleOffset = msg.angleOffset;
    }
    else {
      resolved.angleOffset = 0.0
    }

    if (msg.rateSteers !== undefined) {
      resolved.rateSteers = msg.rateSteers;
    }
    else {
      resolved.rateSteers = 0.0
    }

    if (msg.laneChangeDirection !== undefined) {
      resolved.laneChangeDirection = msg.laneChangeDirection;
    }
    else {
      resolved.laneChangeDirection = 0
    }

    if (msg.paramsValid !== undefined) {
      resolved.paramsValid = msg.paramsValid;
    }
    else {
      resolved.paramsValid = false
    }

    if (msg.cPoly !== undefined) {
      resolved.cPoly = msg.cPoly;
    }
    else {
      resolved.cPoly = []
    }

    if (msg.posenetValid !== undefined) {
      resolved.posenetValid = msg.posenetValid;
    }
    else {
      resolved.posenetValid = false
    }

    if (msg.dPoly !== undefined) {
      resolved.dPoly = msg.dPoly;
    }
    else {
      resolved.dPoly = []
    }

    if (msg.desire !== undefined) {
      resolved.desire = msg.desire;
    }
    else {
      resolved.desire = 0
    }

    return resolved;
    }
};

module.exports = PathPlan;
