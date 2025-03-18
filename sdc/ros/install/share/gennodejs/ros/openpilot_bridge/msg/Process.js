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

class Process {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.exe = null;
      this.name = null;
      this.cmdline = null;
      this.cpuUser = null;
      this.numThreads = null;
      this.memRss = null;
      this.pid = null;
      this.memVms = null;
      this.priority = null;
      this.cpuSystem = null;
      this.state = null;
      this.startTime = null;
      this.nice = null;
      this.cpuChildrenUser = null;
      this.ppid = null;
      this.processor = null;
      this.cpuChildrenSystem = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('exe')) {
        this.exe = initObj.exe
      }
      else {
        this.exe = [];
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = [];
      }
      if (initObj.hasOwnProperty('cmdline')) {
        this.cmdline = initObj.cmdline
      }
      else {
        this.cmdline = [];
      }
      if (initObj.hasOwnProperty('cpuUser')) {
        this.cpuUser = initObj.cpuUser
      }
      else {
        this.cpuUser = 0.0;
      }
      if (initObj.hasOwnProperty('numThreads')) {
        this.numThreads = initObj.numThreads
      }
      else {
        this.numThreads = 0;
      }
      if (initObj.hasOwnProperty('memRss')) {
        this.memRss = initObj.memRss
      }
      else {
        this.memRss = 0;
      }
      if (initObj.hasOwnProperty('pid')) {
        this.pid = initObj.pid
      }
      else {
        this.pid = 0;
      }
      if (initObj.hasOwnProperty('memVms')) {
        this.memVms = initObj.memVms
      }
      else {
        this.memVms = 0;
      }
      if (initObj.hasOwnProperty('priority')) {
        this.priority = initObj.priority
      }
      else {
        this.priority = 0;
      }
      if (initObj.hasOwnProperty('cpuSystem')) {
        this.cpuSystem = initObj.cpuSystem
      }
      else {
        this.cpuSystem = 0.0;
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = 0;
      }
      if (initObj.hasOwnProperty('startTime')) {
        this.startTime = initObj.startTime
      }
      else {
        this.startTime = 0.0;
      }
      if (initObj.hasOwnProperty('nice')) {
        this.nice = initObj.nice
      }
      else {
        this.nice = 0;
      }
      if (initObj.hasOwnProperty('cpuChildrenUser')) {
        this.cpuChildrenUser = initObj.cpuChildrenUser
      }
      else {
        this.cpuChildrenUser = 0.0;
      }
      if (initObj.hasOwnProperty('ppid')) {
        this.ppid = initObj.ppid
      }
      else {
        this.ppid = 0;
      }
      if (initObj.hasOwnProperty('processor')) {
        this.processor = initObj.processor
      }
      else {
        this.processor = 0;
      }
      if (initObj.hasOwnProperty('cpuChildrenSystem')) {
        this.cpuChildrenSystem = initObj.cpuChildrenSystem
      }
      else {
        this.cpuChildrenSystem = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Process
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [exe]
    bufferOffset = _arraySerializer.string(obj.exe, buffer, bufferOffset, null);
    // Serialize message field [name]
    bufferOffset = _arraySerializer.string(obj.name, buffer, bufferOffset, null);
    // Serialize message field [cmdline]
    bufferOffset = _arraySerializer.string(obj.cmdline, buffer, bufferOffset, null);
    // Serialize message field [cpuUser]
    bufferOffset = _serializer.float32(obj.cpuUser, buffer, bufferOffset);
    // Serialize message field [numThreads]
    bufferOffset = _serializer.int32(obj.numThreads, buffer, bufferOffset);
    // Serialize message field [memRss]
    bufferOffset = _serializer.int64(obj.memRss, buffer, bufferOffset);
    // Serialize message field [pid]
    bufferOffset = _serializer.int32(obj.pid, buffer, bufferOffset);
    // Serialize message field [memVms]
    bufferOffset = _serializer.int64(obj.memVms, buffer, bufferOffset);
    // Serialize message field [priority]
    bufferOffset = _serializer.int32(obj.priority, buffer, bufferOffset);
    // Serialize message field [cpuSystem]
    bufferOffset = _serializer.float32(obj.cpuSystem, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.int64(obj.state, buffer, bufferOffset);
    // Serialize message field [startTime]
    bufferOffset = _serializer.float32(obj.startTime, buffer, bufferOffset);
    // Serialize message field [nice]
    bufferOffset = _serializer.int32(obj.nice, buffer, bufferOffset);
    // Serialize message field [cpuChildrenUser]
    bufferOffset = _serializer.float32(obj.cpuChildrenUser, buffer, bufferOffset);
    // Serialize message field [ppid]
    bufferOffset = _serializer.int32(obj.ppid, buffer, bufferOffset);
    // Serialize message field [processor]
    bufferOffset = _serializer.int32(obj.processor, buffer, bufferOffset);
    // Serialize message field [cpuChildrenSystem]
    bufferOffset = _serializer.float32(obj.cpuChildrenSystem, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Process
    let len;
    let data = new Process(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [exe]
    data.exe = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [name]
    data.name = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [cmdline]
    data.cmdline = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [cpuUser]
    data.cpuUser = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [numThreads]
    data.numThreads = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [memRss]
    data.memRss = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [pid]
    data.pid = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [memVms]
    data.memVms = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [priority]
    data.priority = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [cpuSystem]
    data.cpuSystem = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [startTime]
    data.startTime = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [nice]
    data.nice = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [cpuChildrenUser]
    data.cpuChildrenUser = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ppid]
    data.ppid = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [processor]
    data.processor = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [cpuChildrenSystem]
    data.cpuChildrenSystem = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.exe.forEach((val) => {
      length += 4 + val.length;
    });
    object.name.forEach((val) => {
      length += 4 + val.length;
    });
    object.cmdline.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 80;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Process';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '85ebf2bd3669f9306e0aaee2bcc598b2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Process(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.exe !== undefined) {
      resolved.exe = msg.exe;
    }
    else {
      resolved.exe = []
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = []
    }

    if (msg.cmdline !== undefined) {
      resolved.cmdline = msg.cmdline;
    }
    else {
      resolved.cmdline = []
    }

    if (msg.cpuUser !== undefined) {
      resolved.cpuUser = msg.cpuUser;
    }
    else {
      resolved.cpuUser = 0.0
    }

    if (msg.numThreads !== undefined) {
      resolved.numThreads = msg.numThreads;
    }
    else {
      resolved.numThreads = 0
    }

    if (msg.memRss !== undefined) {
      resolved.memRss = msg.memRss;
    }
    else {
      resolved.memRss = 0
    }

    if (msg.pid !== undefined) {
      resolved.pid = msg.pid;
    }
    else {
      resolved.pid = 0
    }

    if (msg.memVms !== undefined) {
      resolved.memVms = msg.memVms;
    }
    else {
      resolved.memVms = 0
    }

    if (msg.priority !== undefined) {
      resolved.priority = msg.priority;
    }
    else {
      resolved.priority = 0
    }

    if (msg.cpuSystem !== undefined) {
      resolved.cpuSystem = msg.cpuSystem;
    }
    else {
      resolved.cpuSystem = 0.0
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = 0
    }

    if (msg.startTime !== undefined) {
      resolved.startTime = msg.startTime;
    }
    else {
      resolved.startTime = 0.0
    }

    if (msg.nice !== undefined) {
      resolved.nice = msg.nice;
    }
    else {
      resolved.nice = 0
    }

    if (msg.cpuChildrenUser !== undefined) {
      resolved.cpuChildrenUser = msg.cpuChildrenUser;
    }
    else {
      resolved.cpuChildrenUser = 0.0
    }

    if (msg.ppid !== undefined) {
      resolved.ppid = msg.ppid;
    }
    else {
      resolved.ppid = 0
    }

    if (msg.processor !== undefined) {
      resolved.processor = msg.processor;
    }
    else {
      resolved.processor = 0
    }

    if (msg.cpuChildrenSystem !== undefined) {
      resolved.cpuChildrenSystem = msg.cpuChildrenSystem;
    }
    else {
      resolved.cpuChildrenSystem = 0.0
    }

    return resolved;
    }
};

module.exports = Process;
