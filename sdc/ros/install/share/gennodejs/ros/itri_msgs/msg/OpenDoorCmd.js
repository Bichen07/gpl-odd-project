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

class OpenDoorCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.left_door = null;
      this.right_door = null;
      this.lift_gate = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('left_door')) {
        this.left_door = initObj.left_door
      }
      else {
        this.left_door = 0;
      }
      if (initObj.hasOwnProperty('right_door')) {
        this.right_door = initObj.right_door
      }
      else {
        this.right_door = 0;
      }
      if (initObj.hasOwnProperty('lift_gate')) {
        this.lift_gate = initObj.lift_gate
      }
      else {
        this.lift_gate = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OpenDoorCmd
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [left_door]
    bufferOffset = _serializer.uint8(obj.left_door, buffer, bufferOffset);
    // Serialize message field [right_door]
    bufferOffset = _serializer.uint8(obj.right_door, buffer, bufferOffset);
    // Serialize message field [lift_gate]
    bufferOffset = _serializer.uint8(obj.lift_gate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OpenDoorCmd
    let len;
    let data = new OpenDoorCmd(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [left_door]
    data.left_door = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [right_door]
    data.right_door = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [lift_gate]
    data.lift_gate = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 3;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/OpenDoorCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '332bf344cd0038f6923ce7682ee1fd53';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint8 CLOSE = 0
    uint8 OPEN = 1
    
    uint8 left_door
    uint8 right_door
    uint8 lift_gate
    
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
    const resolved = new OpenDoorCmd(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.left_door !== undefined) {
      resolved.left_door = msg.left_door;
    }
    else {
      resolved.left_door = 0
    }

    if (msg.right_door !== undefined) {
      resolved.right_door = msg.right_door;
    }
    else {
      resolved.right_door = 0
    }

    if (msg.lift_gate !== undefined) {
      resolved.lift_gate = msg.lift_gate;
    }
    else {
      resolved.lift_gate = 0
    }

    return resolved;
    }
};

// Constants for message
OpenDoorCmd.Constants = {
  CLOSE: 0,
  OPEN: 1,
}

module.exports = OpenDoorCmd;
