// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ExceptionMission = require('./ExceptionMission.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ExceptionMissions {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.mission = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('mission')) {
        this.mission = initObj.mission
      }
      else {
        this.mission = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExceptionMissions
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [mission]
    // Serialize the length for message field [mission]
    bufferOffset = _serializer.uint32(obj.mission.length, buffer, bufferOffset);
    obj.mission.forEach((val) => {
      bufferOffset = ExceptionMission.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExceptionMissions
    let len;
    let data = new ExceptionMissions(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [mission]
    // Deserialize array length for message field [mission]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.mission = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.mission[i] = ExceptionMission.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 6 * object.mission.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/ExceptionMissions';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0b319236f3f70b2499cfecac4de7a18f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    ExceptionMission[] mission
    
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
    MSG: itri_msgs/ExceptionMission
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
    const resolved = new ExceptionMissions(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.mission !== undefined) {
      resolved.mission = new Array(msg.mission.length);
      for (let i = 0; i < resolved.mission.length; ++i) {
        resolved.mission[i] = ExceptionMission.Resolve(msg.mission[i]);
      }
    }
    else {
      resolved.mission = []
    }

    return resolved;
    }
};

module.exports = ExceptionMissions;
