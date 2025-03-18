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

class CalibrationFeatures {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.status = null;
      this.p0 = null;
      this.p1 = null;
      this.frameId = null;
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
        this.status = [];
      }
      if (initObj.hasOwnProperty('p0')) {
        this.p0 = initObj.p0
      }
      else {
        this.p0 = [];
      }
      if (initObj.hasOwnProperty('p1')) {
        this.p1 = initObj.p1
      }
      else {
        this.p1 = [];
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CalibrationFeatures
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _arraySerializer.int32(obj.status, buffer, bufferOffset, null);
    // Serialize message field [p0]
    bufferOffset = _arraySerializer.float32(obj.p0, buffer, bufferOffset, null);
    // Serialize message field [p1]
    bufferOffset = _arraySerializer.float32(obj.p1, buffer, bufferOffset, null);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CalibrationFeatures
    let len;
    let data = new CalibrationFeatures(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [p0]
    data.p0 = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [p1]
    data.p1 = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.status.length;
    length += 4 * object.p0.length;
    length += 4 * object.p1.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CalibrationFeatures';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'cfa74460f4a8fc86e73061d046065618';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32[] status
    float32[] p0
    float32[] p1
    int64 frameId
    
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
    const resolved = new CalibrationFeatures(null);
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
      resolved.status = []
    }

    if (msg.p0 !== undefined) {
      resolved.p0 = msg.p0;
    }
    else {
      resolved.p0 = []
    }

    if (msg.p1 !== undefined) {
      resolved.p1 = msg.p1;
    }
    else {
      resolved.p1 = []
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    return resolved;
    }
};

module.exports = CalibrationFeatures;
