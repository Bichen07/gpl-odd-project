// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let CPUTimes = require('./CPUTimes.js');
let Mem = require('./Mem.js');
let Process = require('./Process.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ProcLog {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.cpuTimes = null;
      this.mem = null;
      this.procs = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('cpuTimes')) {
        this.cpuTimes = initObj.cpuTimes
      }
      else {
        this.cpuTimes = [];
      }
      if (initObj.hasOwnProperty('mem')) {
        this.mem = initObj.mem
      }
      else {
        this.mem = new Mem();
      }
      if (initObj.hasOwnProperty('procs')) {
        this.procs = initObj.procs
      }
      else {
        this.procs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProcLog
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [cpuTimes]
    // Serialize the length for message field [cpuTimes]
    bufferOffset = _serializer.uint32(obj.cpuTimes.length, buffer, bufferOffset);
    obj.cpuTimes.forEach((val) => {
      bufferOffset = CPUTimes.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [mem]
    bufferOffset = Mem.serialize(obj.mem, buffer, bufferOffset);
    // Serialize message field [procs]
    // Serialize the length for message field [procs]
    bufferOffset = _serializer.uint32(obj.procs.length, buffer, bufferOffset);
    obj.procs.forEach((val) => {
      bufferOffset = Process.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProcLog
    let len;
    let data = new ProcLog(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [cpuTimes]
    // Deserialize array length for message field [cpuTimes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.cpuTimes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.cpuTimes[i] = CPUTimes.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [mem]
    data.mem = Mem.deserialize(buffer, bufferOffset);
    // Deserialize message field [procs]
    // Deserialize array length for message field [procs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.procs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.procs[i] = Process.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.cpuTimes.forEach((val) => {
      length += CPUTimes.getMessageSize(val);
    });
    length += Mem.getMessageSize(object.mem);
    object.procs.forEach((val) => {
      length += Process.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ProcLog';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '21eae07decb56f4048af9c9c8680083d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    CPUTimes[] cpuTimes
    Mem mem
    Process[] procs
    
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
    MSG: openpilot_bridge/CPUTimes
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
    MSG: openpilot_bridge/Mem
    Header header
    
    int64 available
    int64 cached
    int64 free
    int64 inactive
    int64 active
    int64 shared
    int64 total
    int64 buffers
    
    ================================================================================
    MSG: openpilot_bridge/Process
    Header header
    
    string[] exe
    string[] name
    string[] cmdline
    float32 cpuUser
    int32 numThreads
    int64 memRss
    int32 pid
    int64 memVms
    int32 priority
    float32 cpuSystem
    int64 state
    float32 startTime
    int32 nice
    float32 cpuChildrenUser
    int32 ppid
    int32 processor
    float32 cpuChildrenSystem
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProcLog(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.cpuTimes !== undefined) {
      resolved.cpuTimes = new Array(msg.cpuTimes.length);
      for (let i = 0; i < resolved.cpuTimes.length; ++i) {
        resolved.cpuTimes[i] = CPUTimes.Resolve(msg.cpuTimes[i]);
      }
    }
    else {
      resolved.cpuTimes = []
    }

    if (msg.mem !== undefined) {
      resolved.mem = Mem.Resolve(msg.mem)
    }
    else {
      resolved.mem = new Mem()
    }

    if (msg.procs !== undefined) {
      resolved.procs = new Array(msg.procs.length);
      for (let i = 0; i < resolved.procs.length; ++i) {
        resolved.procs[i] = Process.Resolve(msg.procs[i]);
      }
    }
    else {
      resolved.procs = []
    }

    return resolved;
    }
};

module.exports = ProcLog;
