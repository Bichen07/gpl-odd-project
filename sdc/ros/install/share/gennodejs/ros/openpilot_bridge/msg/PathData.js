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

class PathData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.std = null;
      this.poly = null;
      this.points = null;
      this.prob = null;
      this.stds = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('std')) {
        this.std = initObj.std
      }
      else {
        this.std = 0.0;
      }
      if (initObj.hasOwnProperty('poly')) {
        this.poly = initObj.poly
      }
      else {
        this.poly = [];
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('prob')) {
        this.prob = initObj.prob
      }
      else {
        this.prob = 0.0;
      }
      if (initObj.hasOwnProperty('stds')) {
        this.stds = initObj.stds
      }
      else {
        this.stds = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [std]
    bufferOffset = _serializer.float32(obj.std, buffer, bufferOffset);
    // Serialize message field [poly]
    bufferOffset = _arraySerializer.float32(obj.poly, buffer, bufferOffset, null);
    // Serialize message field [points]
    bufferOffset = _arraySerializer.float32(obj.points, buffer, bufferOffset, null);
    // Serialize message field [prob]
    bufferOffset = _serializer.float32(obj.prob, buffer, bufferOffset);
    // Serialize message field [stds]
    bufferOffset = _arraySerializer.float32(obj.stds, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathData
    let len;
    let data = new PathData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [std]
    data.std = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [poly]
    data.poly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [points]
    data.points = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [prob]
    data.prob = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stds]
    data.stds = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.poly.length;
    length += 4 * object.points.length;
    length += 4 * object.stds.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/PathData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1768c20992cd12541202687a4eee607d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 std
    float32[] poly
    float32[] points
    float32 prob
    float32[] stds
    
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
    const resolved = new PathData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.std !== undefined) {
      resolved.std = msg.std;
    }
    else {
      resolved.std = 0.0
    }

    if (msg.poly !== undefined) {
      resolved.poly = msg.poly;
    }
    else {
      resolved.poly = []
    }

    if (msg.points !== undefined) {
      resolved.points = msg.points;
    }
    else {
      resolved.points = []
    }

    if (msg.prob !== undefined) {
      resolved.prob = msg.prob;
    }
    else {
      resolved.prob = 0.0
    }

    if (msg.stds !== undefined) {
      resolved.stds = msg.stds;
    }
    else {
      resolved.stds = []
    }

    return resolved;
    }
};

module.exports = PathData;
