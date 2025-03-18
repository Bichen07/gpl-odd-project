// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let OpenPilotLine = require('./OpenPilotLine.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class OpenPilotLines {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.left_line = null;
      this.right_line = null;
      this.desired_line = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('left_line')) {
        this.left_line = initObj.left_line
      }
      else {
        this.left_line = new OpenPilotLine();
      }
      if (initObj.hasOwnProperty('right_line')) {
        this.right_line = initObj.right_line
      }
      else {
        this.right_line = new OpenPilotLine();
      }
      if (initObj.hasOwnProperty('desired_line')) {
        this.desired_line = initObj.desired_line
      }
      else {
        this.desired_line = new OpenPilotLine();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OpenPilotLines
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [left_line]
    bufferOffset = OpenPilotLine.serialize(obj.left_line, buffer, bufferOffset);
    // Serialize message field [right_line]
    bufferOffset = OpenPilotLine.serialize(obj.right_line, buffer, bufferOffset);
    // Serialize message field [desired_line]
    bufferOffset = OpenPilotLine.serialize(obj.desired_line, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OpenPilotLines
    let len;
    let data = new OpenPilotLines(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [left_line]
    data.left_line = OpenPilotLine.deserialize(buffer, bufferOffset);
    // Deserialize message field [right_line]
    data.right_line = OpenPilotLine.deserialize(buffer, bufferOffset);
    // Deserialize message field [desired_line]
    data.desired_line = OpenPilotLine.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += OpenPilotLine.getMessageSize(object.left_line);
    length += OpenPilotLine.getMessageSize(object.right_line);
    length += OpenPilotLine.getMessageSize(object.desired_line);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/OpenPilotLines';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9096eb6f351b82a595c1de88685f239b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    OpenPilotLine left_line
    OpenPilotLine right_line
    OpenPilotLine desired_line
    
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
    MSG: itri_msgs/OpenPilotLine
    std_msgs/Header header
    
    uint8 probability
    float32[] coefficient
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OpenPilotLines(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.left_line !== undefined) {
      resolved.left_line = OpenPilotLine.Resolve(msg.left_line)
    }
    else {
      resolved.left_line = new OpenPilotLine()
    }

    if (msg.right_line !== undefined) {
      resolved.right_line = OpenPilotLine.Resolve(msg.right_line)
    }
    else {
      resolved.right_line = new OpenPilotLine()
    }

    if (msg.desired_line !== undefined) {
      resolved.desired_line = OpenPilotLine.Resolve(msg.desired_line)
    }
    else {
      resolved.desired_line = new OpenPilotLine()
    }

    return resolved;
    }
};

module.exports = OpenPilotLines;
