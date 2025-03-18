// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let OpenDoorCmd = require('./OpenDoorCmd.js');
let turn_signal_cmd = require('./turn_signal_cmd.js');
let std_msgs = _finder('std_msgs');
let dbw_pacifica_msgs = _finder('dbw_pacifica_msgs');

//-----------------------------------------------------------

class UserInputReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.cruise_engage_button = null;
      this.cruise_resume_button = null;
      this.doorCmd = null;
      this.gearCmd = null;
      this.hornReq = null;
      this.turnSignalCmd = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('cruise_engage_button')) {
        this.cruise_engage_button = initObj.cruise_engage_button
      }
      else {
        this.cruise_engage_button = false;
      }
      if (initObj.hasOwnProperty('cruise_resume_button')) {
        this.cruise_resume_button = initObj.cruise_resume_button
      }
      else {
        this.cruise_resume_button = false;
      }
      if (initObj.hasOwnProperty('doorCmd')) {
        this.doorCmd = initObj.doorCmd
      }
      else {
        this.doorCmd = new OpenDoorCmd();
      }
      if (initObj.hasOwnProperty('gearCmd')) {
        this.gearCmd = initObj.gearCmd
      }
      else {
        this.gearCmd = new dbw_pacifica_msgs.msg.Gear();
      }
      if (initObj.hasOwnProperty('hornReq')) {
        this.hornReq = initObj.hornReq
      }
      else {
        this.hornReq = false;
      }
      if (initObj.hasOwnProperty('turnSignalCmd')) {
        this.turnSignalCmd = initObj.turnSignalCmd
      }
      else {
        this.turnSignalCmd = new turn_signal_cmd();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UserInputReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [cruise_engage_button]
    bufferOffset = _serializer.bool(obj.cruise_engage_button, buffer, bufferOffset);
    // Serialize message field [cruise_resume_button]
    bufferOffset = _serializer.bool(obj.cruise_resume_button, buffer, bufferOffset);
    // Serialize message field [doorCmd]
    bufferOffset = OpenDoorCmd.serialize(obj.doorCmd, buffer, bufferOffset);
    // Serialize message field [gearCmd]
    bufferOffset = dbw_pacifica_msgs.msg.Gear.serialize(obj.gearCmd, buffer, bufferOffset);
    // Serialize message field [hornReq]
    bufferOffset = _serializer.bool(obj.hornReq, buffer, bufferOffset);
    // Serialize message field [turnSignalCmd]
    bufferOffset = turn_signal_cmd.serialize(obj.turnSignalCmd, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UserInputReport
    let len;
    let data = new UserInputReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [cruise_engage_button]
    data.cruise_engage_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cruise_resume_button]
    data.cruise_resume_button = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [doorCmd]
    data.doorCmd = OpenDoorCmd.deserialize(buffer, bufferOffset);
    // Deserialize message field [gearCmd]
    data.gearCmd = dbw_pacifica_msgs.msg.Gear.deserialize(buffer, bufferOffset);
    // Deserialize message field [hornReq]
    data.hornReq = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [turnSignalCmd]
    data.turnSignalCmd = turn_signal_cmd.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += OpenDoorCmd.getMessageSize(object.doorCmd);
    length += turn_signal_cmd.getMessageSize(object.turnSignalCmd);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/UserInputReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a2e7897758032adfc464805e43cb89c4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Engage DBW
    bool cruise_engage_button
    
    # Start Self Driving when the DBW system engage
    bool cruise_resume_button
    
    # Door control
    OpenDoorCmd doorCmd
    
    # Gear control
    dbw_pacifica_msgs/Gear gearCmd
    
    # Horn control
    bool hornReq
    
    # Blinker
    turn_signal_cmd turnSignalCmd
    
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
    MSG: itri_msgs/OpenDoorCmd
    Header header
    
    uint8 CLOSE = 0
    uint8 OPEN = 1
    
    uint8 left_door
    uint8 right_door
    uint8 lift_gate
    
    ================================================================================
    MSG: dbw_pacifica_msgs/Gear
    uint8 gear
    
    uint8 NONE=0
    uint8 PARK=1
    uint8 REVERSE=2
    uint8 NEUTRAL=3
    uint8 DRIVE=4
    uint8 LOW=5
    
    ================================================================================
    MSG: itri_msgs/turn_signal_cmd
    Header header
    
    uint8 NONE = 0
    uint8 LEFT = 1
    uint8 RIGHT = 2
    
    uint8 turn_signal
    string source
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new UserInputReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.cruise_engage_button !== undefined) {
      resolved.cruise_engage_button = msg.cruise_engage_button;
    }
    else {
      resolved.cruise_engage_button = false
    }

    if (msg.cruise_resume_button !== undefined) {
      resolved.cruise_resume_button = msg.cruise_resume_button;
    }
    else {
      resolved.cruise_resume_button = false
    }

    if (msg.doorCmd !== undefined) {
      resolved.doorCmd = OpenDoorCmd.Resolve(msg.doorCmd)
    }
    else {
      resolved.doorCmd = new OpenDoorCmd()
    }

    if (msg.gearCmd !== undefined) {
      resolved.gearCmd = dbw_pacifica_msgs.msg.Gear.Resolve(msg.gearCmd)
    }
    else {
      resolved.gearCmd = new dbw_pacifica_msgs.msg.Gear()
    }

    if (msg.hornReq !== undefined) {
      resolved.hornReq = msg.hornReq;
    }
    else {
      resolved.hornReq = false
    }

    if (msg.turnSignalCmd !== undefined) {
      resolved.turnSignalCmd = turn_signal_cmd.Resolve(msg.turnSignalCmd)
    }
    else {
      resolved.turnSignalCmd = new turn_signal_cmd()
    }

    return resolved;
    }
};

module.exports = UserInputReport;
