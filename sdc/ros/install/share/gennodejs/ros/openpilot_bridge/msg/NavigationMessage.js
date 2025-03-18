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

class NavigationMessage {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.status = null;
      this.data = null;
      this.svId = null;
      this.messageId = null;
      this.submessageId = null;
      this.type = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = [];
      }
      if (initObj.hasOwnProperty('svId')) {
        this.svId = initObj.svId
      }
      else {
        this.svId = 0;
      }
      if (initObj.hasOwnProperty('messageId')) {
        this.messageId = initObj.messageId
      }
      else {
        this.messageId = 0;
      }
      if (initObj.hasOwnProperty('submessageId')) {
        this.submessageId = initObj.submessageId
      }
      else {
        this.submessageId = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavigationMessage
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.uint32(obj.status, buffer, bufferOffset);
    // Serialize message field [data]
    bufferOffset = _arraySerializer.string(obj.data, buffer, bufferOffset, null);
    // Serialize message field [svId]
    bufferOffset = _serializer.int32(obj.svId, buffer, bufferOffset);
    // Serialize message field [messageId]
    bufferOffset = _serializer.int32(obj.messageId, buffer, bufferOffset);
    // Serialize message field [submessageId]
    bufferOffset = _serializer.int32(obj.submessageId, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavigationMessage
    let len;
    let data = new NavigationMessage(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [svId]
    data.svId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [messageId]
    data.messageId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [submessageId]
    data.submessageId = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.data.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/NavigationMessage';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '569f54f20fd84534027c20594ae8f9bf';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint32 status # enum const: Status
    string[] data
    int32 svId
    int32 messageId
    int32 submessageId
    int32 type
    
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
    const resolved = new NavigationMessage(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = []
    }

    if (msg.svId !== undefined) {
      resolved.svId = msg.svId;
    }
    else {
      resolved.svId = 0
    }

    if (msg.messageId !== undefined) {
      resolved.messageId = msg.messageId;
    }
    else {
      resolved.messageId = 0
    }

    if (msg.submessageId !== undefined) {
      resolved.submessageId = msg.submessageId;
    }
    else {
      resolved.submessageId = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    return resolved;
    }
};

module.exports = NavigationMessage;
