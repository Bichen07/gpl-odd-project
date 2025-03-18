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

class CPUTimes {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.softirq = null;
      this.iowait = null;
      this.system = null;
      this.cpuNum = null;
      this.idle = null;
      this.user = null;
      this.irq = null;
      this.nice = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('softirq')) {
        this.softirq = initObj.softirq
      }
      else {
        this.softirq = 0.0;
      }
      if (initObj.hasOwnProperty('iowait')) {
        this.iowait = initObj.iowait
      }
      else {
        this.iowait = 0.0;
      }
      if (initObj.hasOwnProperty('system')) {
        this.system = initObj.system
      }
      else {
        this.system = 0.0;
      }
      if (initObj.hasOwnProperty('cpuNum')) {
        this.cpuNum = initObj.cpuNum
      }
      else {
        this.cpuNum = 0;
      }
      if (initObj.hasOwnProperty('idle')) {
        this.idle = initObj.idle
      }
      else {
        this.idle = 0.0;
      }
      if (initObj.hasOwnProperty('user')) {
        this.user = initObj.user
      }
      else {
        this.user = 0.0;
      }
      if (initObj.hasOwnProperty('irq')) {
        this.irq = initObj.irq
      }
      else {
        this.irq = 0.0;
      }
      if (initObj.hasOwnProperty('nice')) {
        this.nice = initObj.nice
      }
      else {
        this.nice = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CPUTimes
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [softirq]
    bufferOffset = _serializer.float32(obj.softirq, buffer, bufferOffset);
    // Serialize message field [iowait]
    bufferOffset = _serializer.float32(obj.iowait, buffer, bufferOffset);
    // Serialize message field [system]
    bufferOffset = _serializer.float32(obj.system, buffer, bufferOffset);
    // Serialize message field [cpuNum]
    bufferOffset = _serializer.int32(obj.cpuNum, buffer, bufferOffset);
    // Serialize message field [idle]
    bufferOffset = _serializer.float32(obj.idle, buffer, bufferOffset);
    // Serialize message field [user]
    bufferOffset = _serializer.float32(obj.user, buffer, bufferOffset);
    // Serialize message field [irq]
    bufferOffset = _serializer.float32(obj.irq, buffer, bufferOffset);
    // Serialize message field [nice]
    bufferOffset = _serializer.float32(obj.nice, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CPUTimes
    let len;
    let data = new CPUTimes(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [softirq]
    data.softirq = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [iowait]
    data.iowait = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [system]
    data.system = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cpuNum]
    data.cpuNum = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [idle]
    data.idle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [user]
    data.user = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [irq]
    data.irq = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [nice]
    data.nice = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CPUTimes';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dc9d293549a3f253ed6668df60faa73d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 softirq
    float32 iowait
    float32 system
    int32 cpuNum
    float32 idle
    float32 user
    float32 irq
    float32 nice
    
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
    const resolved = new CPUTimes(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.softirq !== undefined) {
      resolved.softirq = msg.softirq;
    }
    else {
      resolved.softirq = 0.0
    }

    if (msg.iowait !== undefined) {
      resolved.iowait = msg.iowait;
    }
    else {
      resolved.iowait = 0.0
    }

    if (msg.system !== undefined) {
      resolved.system = msg.system;
    }
    else {
      resolved.system = 0.0
    }

    if (msg.cpuNum !== undefined) {
      resolved.cpuNum = msg.cpuNum;
    }
    else {
      resolved.cpuNum = 0
    }

    if (msg.idle !== undefined) {
      resolved.idle = msg.idle;
    }
    else {
      resolved.idle = 0.0
    }

    if (msg.user !== undefined) {
      resolved.user = msg.user;
    }
    else {
      resolved.user = 0.0
    }

    if (msg.irq !== undefined) {
      resolved.irq = msg.irq;
    }
    else {
      resolved.irq = 0.0
    }

    if (msg.nice !== undefined) {
      resolved.nice = msg.nice;
    }
    else {
      resolved.nice = 0.0
    }

    return resolved;
    }
};

module.exports = CPUTimes;
