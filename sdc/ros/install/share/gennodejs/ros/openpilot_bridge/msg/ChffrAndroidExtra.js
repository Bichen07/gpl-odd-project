// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Map = require('./Map.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ChffrAndroidExtra {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.allCameraCharacteristics = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('allCameraCharacteristics')) {
        this.allCameraCharacteristics = initObj.allCameraCharacteristics
      }
      else {
        this.allCameraCharacteristics = new Map();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ChffrAndroidExtra
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [allCameraCharacteristics]
    bufferOffset = Map.serialize(obj.allCameraCharacteristics, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ChffrAndroidExtra
    let len;
    let data = new ChffrAndroidExtra(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [allCameraCharacteristics]
    data.allCameraCharacteristics = Map.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += Map.getMessageSize(object.allCameraCharacteristics);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ChffrAndroidExtra';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b43d42df107e761f273426529e592a9c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    Map allCameraCharacteristics
    
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
    MSG: openpilot_bridge/Map
    Header header
    
    Entry[] entries
    
    ================================================================================
    MSG: openpilot_bridge/Entry
    Header header
    
    string value
    string key
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ChffrAndroidExtra(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.allCameraCharacteristics !== undefined) {
      resolved.allCameraCharacteristics = Map.Resolve(msg.allCameraCharacteristics)
    }
    else {
      resolved.allCameraCharacteristics = new Map()
    }

    return resolved;
    }
};

module.exports = ChffrAndroidExtra;
