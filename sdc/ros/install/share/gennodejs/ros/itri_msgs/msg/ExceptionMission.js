// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ExceptionEvent = require('./ExceptionEvent.js');
let RequestState = require('./RequestState.js');
let MissionStatus = require('./MissionStatus.js');

//-----------------------------------------------------------

class ExceptionMission {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.exception_event = null;
      this.request = null;
      this.mission = null;
    }
    else {
      if (initObj.hasOwnProperty('exception_event')) {
        this.exception_event = initObj.exception_event
      }
      else {
        this.exception_event = new ExceptionEvent();
      }
      if (initObj.hasOwnProperty('request')) {
        this.request = initObj.request
      }
      else {
        this.request = new RequestState();
      }
      if (initObj.hasOwnProperty('mission')) {
        this.mission = initObj.mission
      }
      else {
        this.mission = new MissionStatus();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExceptionMission
    // Serialize message field [exception_event]
    bufferOffset = ExceptionEvent.serialize(obj.exception_event, buffer, bufferOffset);
    // Serialize message field [request]
    bufferOffset = RequestState.serialize(obj.request, buffer, bufferOffset);
    // Serialize message field [mission]
    bufferOffset = MissionStatus.serialize(obj.mission, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExceptionMission
    let len;
    let data = new ExceptionMission(null);
    // Deserialize message field [exception_event]
    data.exception_event = ExceptionEvent.deserialize(buffer, bufferOffset);
    // Deserialize message field [request]
    data.request = RequestState.deserialize(buffer, bufferOffset);
    // Deserialize message field [mission]
    data.mission = MissionStatus.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/ExceptionMission';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0471831326b1596371ad11eb9cb10158';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ExceptionEvent exception_event
    RequestState request
    MissionStatus mission
    
    ================================================================================
    MSG: itri_msgs/ExceptionEvent
    # exception event
    uint8 NORMAL = 0
    uint8 HARD_BRAKE = 1
    uint8 MILD_BRAKE = 2
    uint8 DETOUR     = 3
    uint8 PULL_OVER  = 4
    uint8 TIME_OUT  = 5
    
    uint32 event
    
    ================================================================================
    MSG: itri_msgs/RequestState
    # exception request_state
    uint8 NORMAL = 0
    uint8 REQUEST = 1
    uint8 RESUME = 2
    
    uint8 state
    
    ================================================================================
    MSG: itri_msgs/MissionStatus
    # exception misssion status
    uint8 NORMAL = 0
    uint8 EXECUTION = 1
    uint8 COMPLETED = 2
    uint8 REQUEST = 3
    
    uint8 status
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExceptionMission(null);
    if (msg.exception_event !== undefined) {
      resolved.exception_event = ExceptionEvent.Resolve(msg.exception_event)
    }
    else {
      resolved.exception_event = new ExceptionEvent()
    }

    if (msg.request !== undefined) {
      resolved.request = RequestState.Resolve(msg.request)
    }
    else {
      resolved.request = new RequestState()
    }

    if (msg.mission !== undefined) {
      resolved.mission = MissionStatus.Resolve(msg.mission)
    }
    else {
      resolved.mission = new MissionStatus()
    }

    return resolved;
    }
};

module.exports = ExceptionMission;
