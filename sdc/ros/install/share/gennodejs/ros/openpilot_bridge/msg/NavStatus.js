// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Address = require('./Address.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class NavStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.isNavigating = null;
      this.currentAddress = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('isNavigating')) {
        this.isNavigating = initObj.isNavigating
      }
      else {
        this.isNavigating = false;
      }
      if (initObj.hasOwnProperty('currentAddress')) {
        this.currentAddress = initObj.currentAddress
      }
      else {
        this.currentAddress = new Address();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [isNavigating]
    bufferOffset = _serializer.bool(obj.isNavigating, buffer, bufferOffset);
    // Serialize message field [currentAddress]
    bufferOffset = Address.serialize(obj.currentAddress, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavStatus
    let len;
    let data = new NavStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [isNavigating]
    data.isNavigating = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [currentAddress]
    data.currentAddress = Address.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += Address.getMessageSize(object.currentAddress);
    return length + 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/NavStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fd019d3ff14a21235dbb5ba7e40cd211';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool isNavigating
    Address currentAddress
    
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
    MSG: openpilot_bridge/Address
    Header header
    
    string[] city
    string[] title
    string[] house
    string[] state
    string[] street
    string[] address
    float32 lat
    float32 lng
    string[] country
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NavStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.isNavigating !== undefined) {
      resolved.isNavigating = msg.isNavigating;
    }
    else {
      resolved.isNavigating = false
    }

    if (msg.currentAddress !== undefined) {
      resolved.currentAddress = Address.Resolve(msg.currentAddress)
    }
    else {
      resolved.currentAddress = new Address()
    }

    return resolved;
    }
};

module.exports = NavStatus;
