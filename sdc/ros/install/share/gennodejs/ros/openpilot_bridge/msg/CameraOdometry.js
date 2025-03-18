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

class CameraOdometry {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.transStd = null;
      this.timestampEof = null;
      this.frameId = null;
      this.rotStd = null;
      this.trans = null;
      this.rot = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('transStd')) {
        this.transStd = initObj.transStd
      }
      else {
        this.transStd = [];
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
      if (initObj.hasOwnProperty('rotStd')) {
        this.rotStd = initObj.rotStd
      }
      else {
        this.rotStd = [];
      }
      if (initObj.hasOwnProperty('trans')) {
        this.trans = initObj.trans
      }
      else {
        this.trans = [];
      }
      if (initObj.hasOwnProperty('rot')) {
        this.rot = initObj.rot
      }
      else {
        this.rot = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraOdometry
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [transStd]
    bufferOffset = _arraySerializer.float32(obj.transStd, buffer, bufferOffset, null);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    // Serialize message field [rotStd]
    bufferOffset = _arraySerializer.float32(obj.rotStd, buffer, bufferOffset, null);
    // Serialize message field [trans]
    bufferOffset = _arraySerializer.float32(obj.trans, buffer, bufferOffset, null);
    // Serialize message field [rot]
    bufferOffset = _arraySerializer.float32(obj.rot, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraOdometry
    let len;
    let data = new CameraOdometry(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [transStd]
    data.transStd = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [rotStd]
    data.rotStd = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [trans]
    data.trans = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [rot]
    data.rot = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.transStd.length;
    length += 4 * object.rotStd.length;
    length += 4 * object.trans.length;
    length += 4 * object.rot.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CameraOdometry';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '64230caa35d768ea103ac189eaf3f493';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] transStd
    int64 timestampEof
    int64 frameId
    float32[] rotStd
    float32[] trans
    float32[] rot
    
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
    const resolved = new CameraOdometry(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.transStd !== undefined) {
      resolved.transStd = msg.transStd;
    }
    else {
      resolved.transStd = []
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    if (msg.rotStd !== undefined) {
      resolved.rotStd = msg.rotStd;
    }
    else {
      resolved.rotStd = []
    }

    if (msg.trans !== undefined) {
      resolved.trans = msg.trans;
    }
    else {
      resolved.trans = []
    }

    if (msg.rot !== undefined) {
      resolved.rot = msg.rot;
    }
    else {
      resolved.rot = []
    }

    return resolved;
    }
};

module.exports = CameraOdometry;
