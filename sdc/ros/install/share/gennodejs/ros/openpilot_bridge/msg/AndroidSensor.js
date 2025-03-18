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

class AndroidSensor {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.maxRange = null;
      this.stringType = null;
      this.maxDelay = null;
      this.handle = null;
      this.name = null;
      this.power = null;
      this.minDelay = null;
      this.resolution = null;
      this.fifoMaxEventCount = null;
      this.version = null;
      this.fifoReservedEventCount = null;
      this.vendor = null;
      this.type = null;
      this.id = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('maxRange')) {
        this.maxRange = initObj.maxRange
      }
      else {
        this.maxRange = 0.0;
      }
      if (initObj.hasOwnProperty('stringType')) {
        this.stringType = initObj.stringType
      }
      else {
        this.stringType = [];
      }
      if (initObj.hasOwnProperty('maxDelay')) {
        this.maxDelay = initObj.maxDelay
      }
      else {
        this.maxDelay = 0;
      }
      if (initObj.hasOwnProperty('handle')) {
        this.handle = initObj.handle
      }
      else {
        this.handle = 0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = [];
      }
      if (initObj.hasOwnProperty('power')) {
        this.power = initObj.power
      }
      else {
        this.power = 0.0;
      }
      if (initObj.hasOwnProperty('minDelay')) {
        this.minDelay = initObj.minDelay
      }
      else {
        this.minDelay = 0;
      }
      if (initObj.hasOwnProperty('resolution')) {
        this.resolution = initObj.resolution
      }
      else {
        this.resolution = 0.0;
      }
      if (initObj.hasOwnProperty('fifoMaxEventCount')) {
        this.fifoMaxEventCount = initObj.fifoMaxEventCount
      }
      else {
        this.fifoMaxEventCount = 0;
      }
      if (initObj.hasOwnProperty('version')) {
        this.version = initObj.version
      }
      else {
        this.version = 0;
      }
      if (initObj.hasOwnProperty('fifoReservedEventCount')) {
        this.fifoReservedEventCount = initObj.fifoReservedEventCount
      }
      else {
        this.fifoReservedEventCount = 0;
      }
      if (initObj.hasOwnProperty('vendor')) {
        this.vendor = initObj.vendor
      }
      else {
        this.vendor = [];
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AndroidSensor
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [maxRange]
    bufferOffset = _serializer.float32(obj.maxRange, buffer, bufferOffset);
    // Serialize message field [stringType]
    bufferOffset = _arraySerializer.string(obj.stringType, buffer, bufferOffset, null);
    // Serialize message field [maxDelay]
    bufferOffset = _serializer.int32(obj.maxDelay, buffer, bufferOffset);
    // Serialize message field [handle]
    bufferOffset = _serializer.int32(obj.handle, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _arraySerializer.string(obj.name, buffer, bufferOffset, null);
    // Serialize message field [power]
    bufferOffset = _serializer.float32(obj.power, buffer, bufferOffset);
    // Serialize message field [minDelay]
    bufferOffset = _serializer.int32(obj.minDelay, buffer, bufferOffset);
    // Serialize message field [resolution]
    bufferOffset = _serializer.float32(obj.resolution, buffer, bufferOffset);
    // Serialize message field [fifoMaxEventCount]
    bufferOffset = _serializer.int64(obj.fifoMaxEventCount, buffer, bufferOffset);
    // Serialize message field [version]
    bufferOffset = _serializer.int32(obj.version, buffer, bufferOffset);
    // Serialize message field [fifoReservedEventCount]
    bufferOffset = _serializer.int64(obj.fifoReservedEventCount, buffer, bufferOffset);
    // Serialize message field [vendor]
    bufferOffset = _arraySerializer.string(obj.vendor, buffer, bufferOffset, null);
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AndroidSensor
    let len;
    let data = new AndroidSensor(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [maxRange]
    data.maxRange = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [stringType]
    data.stringType = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [maxDelay]
    data.maxDelay = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [handle]
    data.handle = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [power]
    data.power = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [minDelay]
    data.minDelay = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [resolution]
    data.resolution = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fifoMaxEventCount]
    data.fifoMaxEventCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [version]
    data.version = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [fifoReservedEventCount]
    data.fifoReservedEventCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [vendor]
    data.vendor = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.stringType.forEach((val) => {
      length += 4 + val.length;
    });
    object.name.forEach((val) => {
      length += 4 + val.length;
    });
    object.vendor.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AndroidSensor';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '28a5145614ef6b4a40314b3f2013a478';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 maxRange
    string[] stringType
    int32 maxDelay
    int32 handle
    string[] name
    float32 power
    int32 minDelay
    float32 resolution
    int64 fifoMaxEventCount
    int32 version
    int64 fifoReservedEventCount
    string[] vendor
    int32 type
    int32 id
    
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
    const resolved = new AndroidSensor(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.maxRange !== undefined) {
      resolved.maxRange = msg.maxRange;
    }
    else {
      resolved.maxRange = 0.0
    }

    if (msg.stringType !== undefined) {
      resolved.stringType = msg.stringType;
    }
    else {
      resolved.stringType = []
    }

    if (msg.maxDelay !== undefined) {
      resolved.maxDelay = msg.maxDelay;
    }
    else {
      resolved.maxDelay = 0
    }

    if (msg.handle !== undefined) {
      resolved.handle = msg.handle;
    }
    else {
      resolved.handle = 0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = []
    }

    if (msg.power !== undefined) {
      resolved.power = msg.power;
    }
    else {
      resolved.power = 0.0
    }

    if (msg.minDelay !== undefined) {
      resolved.minDelay = msg.minDelay;
    }
    else {
      resolved.minDelay = 0
    }

    if (msg.resolution !== undefined) {
      resolved.resolution = msg.resolution;
    }
    else {
      resolved.resolution = 0.0
    }

    if (msg.fifoMaxEventCount !== undefined) {
      resolved.fifoMaxEventCount = msg.fifoMaxEventCount;
    }
    else {
      resolved.fifoMaxEventCount = 0
    }

    if (msg.version !== undefined) {
      resolved.version = msg.version;
    }
    else {
      resolved.version = 0
    }

    if (msg.fifoReservedEventCount !== undefined) {
      resolved.fifoReservedEventCount = msg.fifoReservedEventCount;
    }
    else {
      resolved.fifoReservedEventCount = 0
    }

    if (msg.vendor !== undefined) {
      resolved.vendor = msg.vendor;
    }
    else {
      resolved.vendor = []
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    return resolved;
    }
};

module.exports = AndroidSensor;
