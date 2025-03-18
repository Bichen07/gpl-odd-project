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

class UiLayoutState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.activeApp = null;
      this.mapEnabled = null;
      this.sidebarCollapsed = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('activeApp')) {
        this.activeApp = initObj.activeApp
      }
      else {
        this.activeApp = 0;
      }
      if (initObj.hasOwnProperty('mapEnabled')) {
        this.mapEnabled = initObj.mapEnabled
      }
      else {
        this.mapEnabled = false;
      }
      if (initObj.hasOwnProperty('sidebarCollapsed')) {
        this.sidebarCollapsed = initObj.sidebarCollapsed
      }
      else {
        this.sidebarCollapsed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UiLayoutState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [activeApp]
    bufferOffset = _serializer.uint32(obj.activeApp, buffer, bufferOffset);
    // Serialize message field [mapEnabled]
    bufferOffset = _serializer.bool(obj.mapEnabled, buffer, bufferOffset);
    // Serialize message field [sidebarCollapsed]
    bufferOffset = _serializer.bool(obj.sidebarCollapsed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UiLayoutState
    let len;
    let data = new UiLayoutState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [activeApp]
    data.activeApp = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [mapEnabled]
    data.mapEnabled = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [sidebarCollapsed]
    data.sidebarCollapsed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/UiLayoutState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '15f553c11275eeabf5a5565d40667440';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint32 activeApp # enum const: App
    bool mapEnabled
    bool sidebarCollapsed
    
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
    const resolved = new UiLayoutState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.activeApp !== undefined) {
      resolved.activeApp = msg.activeApp;
    }
    else {
      resolved.activeApp = 0
    }

    if (msg.mapEnabled !== undefined) {
      resolved.mapEnabled = msg.mapEnabled;
    }
    else {
      resolved.mapEnabled = false
    }

    if (msg.sidebarCollapsed !== undefined) {
      resolved.sidebarCollapsed = msg.sidebarCollapsed;
    }
    else {
      resolved.sidebarCollapsed = false
    }

    return resolved;
    }
};

module.exports = UiLayoutState;
