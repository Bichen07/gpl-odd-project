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

class IosBuildInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.appBuild = null;
      this.appVersion = null;
      this.osVersion = null;
      this.deviceModel = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('appBuild')) {
        this.appBuild = initObj.appBuild
      }
      else {
        this.appBuild = 0;
      }
      if (initObj.hasOwnProperty('appVersion')) {
        this.appVersion = initObj.appVersion
      }
      else {
        this.appVersion = [];
      }
      if (initObj.hasOwnProperty('osVersion')) {
        this.osVersion = initObj.osVersion
      }
      else {
        this.osVersion = [];
      }
      if (initObj.hasOwnProperty('deviceModel')) {
        this.deviceModel = initObj.deviceModel
      }
      else {
        this.deviceModel = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IosBuildInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [appBuild]
    bufferOffset = _serializer.int64(obj.appBuild, buffer, bufferOffset);
    // Serialize message field [appVersion]
    bufferOffset = _arraySerializer.string(obj.appVersion, buffer, bufferOffset, null);
    // Serialize message field [osVersion]
    bufferOffset = _arraySerializer.string(obj.osVersion, buffer, bufferOffset, null);
    // Serialize message field [deviceModel]
    bufferOffset = _arraySerializer.string(obj.deviceModel, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IosBuildInfo
    let len;
    let data = new IosBuildInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [appBuild]
    data.appBuild = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [appVersion]
    data.appVersion = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [osVersion]
    data.osVersion = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [deviceModel]
    data.deviceModel = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.appVersion.forEach((val) => {
      length += 4 + val.length;
    });
    object.osVersion.forEach((val) => {
      length += 4 + val.length;
    });
    object.deviceModel.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/IosBuildInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e054f580a75e5ffd7d3c3d10ffbadbfd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 appBuild
    string[] appVersion
    string[] osVersion
    string[] deviceModel
    
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
    const resolved = new IosBuildInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.appBuild !== undefined) {
      resolved.appBuild = msg.appBuild;
    }
    else {
      resolved.appBuild = 0
    }

    if (msg.appVersion !== undefined) {
      resolved.appVersion = msg.appVersion;
    }
    else {
      resolved.appVersion = []
    }

    if (msg.osVersion !== undefined) {
      resolved.osVersion = msg.osVersion;
    }
    else {
      resolved.osVersion = []
    }

    if (msg.deviceModel !== undefined) {
      resolved.deviceModel = msg.deviceModel;
    }
    else {
      resolved.deviceModel = []
    }

    return resolved;
    }
};

module.exports = IosBuildInfo;
