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

class CarEvent {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.enable = null;
      this.noEntry = null;
      this.name = null;
      this.immediateDisable = null;
      this.warning = null;
      this.permanent = null;
      this.softDisable = null;
      this.userDisable = null;
      this.preEnable = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('enable')) {
        this.enable = initObj.enable
      }
      else {
        this.enable = false;
      }
      if (initObj.hasOwnProperty('noEntry')) {
        this.noEntry = initObj.noEntry
      }
      else {
        this.noEntry = false;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = 0;
      }
      if (initObj.hasOwnProperty('immediateDisable')) {
        this.immediateDisable = initObj.immediateDisable
      }
      else {
        this.immediateDisable = false;
      }
      if (initObj.hasOwnProperty('warning')) {
        this.warning = initObj.warning
      }
      else {
        this.warning = false;
      }
      if (initObj.hasOwnProperty('permanent')) {
        this.permanent = initObj.permanent
      }
      else {
        this.permanent = false;
      }
      if (initObj.hasOwnProperty('softDisable')) {
        this.softDisable = initObj.softDisable
      }
      else {
        this.softDisable = false;
      }
      if (initObj.hasOwnProperty('userDisable')) {
        this.userDisable = initObj.userDisable
      }
      else {
        this.userDisable = false;
      }
      if (initObj.hasOwnProperty('preEnable')) {
        this.preEnable = initObj.preEnable
      }
      else {
        this.preEnable = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CarEvent
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [enable]
    bufferOffset = _serializer.bool(obj.enable, buffer, bufferOffset);
    // Serialize message field [noEntry]
    bufferOffset = _serializer.bool(obj.noEntry, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.uint32(obj.name, buffer, bufferOffset);
    // Serialize message field [immediateDisable]
    bufferOffset = _serializer.bool(obj.immediateDisable, buffer, bufferOffset);
    // Serialize message field [warning]
    bufferOffset = _serializer.bool(obj.warning, buffer, bufferOffset);
    // Serialize message field [permanent]
    bufferOffset = _serializer.bool(obj.permanent, buffer, bufferOffset);
    // Serialize message field [softDisable]
    bufferOffset = _serializer.bool(obj.softDisable, buffer, bufferOffset);
    // Serialize message field [userDisable]
    bufferOffset = _serializer.bool(obj.userDisable, buffer, bufferOffset);
    // Serialize message field [preEnable]
    bufferOffset = _serializer.bool(obj.preEnable, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CarEvent
    let len;
    let data = new CarEvent(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [enable]
    data.enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [noEntry]
    data.noEntry = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [immediateDisable]
    data.immediateDisable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [warning]
    data.warning = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [permanent]
    data.permanent = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [softDisable]
    data.softDisable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [userDisable]
    data.userDisable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [preEnable]
    data.preEnable = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CarEvent';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2f52d8ded2e13e6f9192006e63d11d91';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool enable
    bool noEntry
    uint32 name # enum const: EventName
    bool immediateDisable
    bool warning
    bool permanent
    bool softDisable
    bool userDisable
    bool preEnable
    
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
    const resolved = new CarEvent(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.enable !== undefined) {
      resolved.enable = msg.enable;
    }
    else {
      resolved.enable = false
    }

    if (msg.noEntry !== undefined) {
      resolved.noEntry = msg.noEntry;
    }
    else {
      resolved.noEntry = false
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = 0
    }

    if (msg.immediateDisable !== undefined) {
      resolved.immediateDisable = msg.immediateDisable;
    }
    else {
      resolved.immediateDisable = false
    }

    if (msg.warning !== undefined) {
      resolved.warning = msg.warning;
    }
    else {
      resolved.warning = false
    }

    if (msg.permanent !== undefined) {
      resolved.permanent = msg.permanent;
    }
    else {
      resolved.permanent = false
    }

    if (msg.softDisable !== undefined) {
      resolved.softDisable = msg.softDisable;
    }
    else {
      resolved.softDisable = false
    }

    if (msg.userDisable !== undefined) {
      resolved.userDisable = msg.userDisable;
    }
    else {
      resolved.userDisable = false
    }

    if (msg.preEnable !== undefined) {
      resolved.preEnable = msg.preEnable;
    }
    else {
      resolved.preEnable = false
    }

    return resolved;
    }
};

module.exports = CarEvent;
