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

class LiveUI {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rearViewCam = null;
      this.awarenessStatus = null;
      this.alertText2 = null;
      this.alertText1 = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rearViewCam')) {
        this.rearViewCam = initObj.rearViewCam
      }
      else {
        this.rearViewCam = false;
      }
      if (initObj.hasOwnProperty('awarenessStatus')) {
        this.awarenessStatus = initObj.awarenessStatus
      }
      else {
        this.awarenessStatus = 0.0;
      }
      if (initObj.hasOwnProperty('alertText2')) {
        this.alertText2 = initObj.alertText2
      }
      else {
        this.alertText2 = [];
      }
      if (initObj.hasOwnProperty('alertText1')) {
        this.alertText1 = initObj.alertText1
      }
      else {
        this.alertText1 = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveUI
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rearViewCam]
    bufferOffset = _serializer.bool(obj.rearViewCam, buffer, bufferOffset);
    // Serialize message field [awarenessStatus]
    bufferOffset = _serializer.float32(obj.awarenessStatus, buffer, bufferOffset);
    // Serialize message field [alertText2]
    bufferOffset = _arraySerializer.string(obj.alertText2, buffer, bufferOffset, null);
    // Serialize message field [alertText1]
    bufferOffset = _arraySerializer.string(obj.alertText1, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveUI
    let len;
    let data = new LiveUI(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rearViewCam]
    data.rearViewCam = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [awarenessStatus]
    data.awarenessStatus = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alertText2]
    data.alertText2 = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [alertText1]
    data.alertText1 = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.alertText2.forEach((val) => {
      length += 4 + val.length;
    });
    object.alertText1.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveUI';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd29f5a921a14307ce3b00a6621ee4f4a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool rearViewCam
    float32 awarenessStatus
    string[] alertText2
    string[] alertText1
    
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
    const resolved = new LiveUI(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rearViewCam !== undefined) {
      resolved.rearViewCam = msg.rearViewCam;
    }
    else {
      resolved.rearViewCam = false
    }

    if (msg.awarenessStatus !== undefined) {
      resolved.awarenessStatus = msg.awarenessStatus;
    }
    else {
      resolved.awarenessStatus = 0.0
    }

    if (msg.alertText2 !== undefined) {
      resolved.alertText2 = msg.alertText2;
    }
    else {
      resolved.alertText2 = []
    }

    if (msg.alertText1 !== undefined) {
      resolved.alertText1 = msg.alertText1;
    }
    else {
      resolved.alertText1 = []
    }

    return resolved;
    }
};

module.exports = LiveUI;
