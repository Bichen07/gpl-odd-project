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

class LiveMpcData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.psi = null;
      this.qpIterations = null;
      this.cost = null;
      this.delta = null;
      this.y = null;
      this.x = null;
      this.calculationTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('psi')) {
        this.psi = initObj.psi
      }
      else {
        this.psi = [];
      }
      if (initObj.hasOwnProperty('qpIterations')) {
        this.qpIterations = initObj.qpIterations
      }
      else {
        this.qpIterations = 0;
      }
      if (initObj.hasOwnProperty('cost')) {
        this.cost = initObj.cost
      }
      else {
        this.cost = 0.0;
      }
      if (initObj.hasOwnProperty('delta')) {
        this.delta = initObj.delta
      }
      else {
        this.delta = [];
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = [];
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = [];
      }
      if (initObj.hasOwnProperty('calculationTime')) {
        this.calculationTime = initObj.calculationTime
      }
      else {
        this.calculationTime = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveMpcData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [psi]
    bufferOffset = _arraySerializer.float32(obj.psi, buffer, bufferOffset, null);
    // Serialize message field [qpIterations]
    bufferOffset = _serializer.int64(obj.qpIterations, buffer, bufferOffset);
    // Serialize message field [cost]
    bufferOffset = _serializer.float32(obj.cost, buffer, bufferOffset);
    // Serialize message field [delta]
    bufferOffset = _arraySerializer.float32(obj.delta, buffer, bufferOffset, null);
    // Serialize message field [y]
    bufferOffset = _arraySerializer.float32(obj.y, buffer, bufferOffset, null);
    // Serialize message field [x]
    bufferOffset = _arraySerializer.float32(obj.x, buffer, bufferOffset, null);
    // Serialize message field [calculationTime]
    bufferOffset = _serializer.int64(obj.calculationTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveMpcData
    let len;
    let data = new LiveMpcData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [psi]
    data.psi = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [qpIterations]
    data.qpIterations = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cost]
    data.cost = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta]
    data.delta = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [y]
    data.y = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [x]
    data.x = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [calculationTime]
    data.calculationTime = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.psi.length;
    length += 4 * object.delta.length;
    length += 4 * object.y.length;
    length += 4 * object.x.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveMpcData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '311969c98af5c48778808efefe644446';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] psi
    int64 qpIterations
    float32 cost
    float32[] delta
    float32[] y
    float32[] x
    int64 calculationTime
    
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
    const resolved = new LiveMpcData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.psi !== undefined) {
      resolved.psi = msg.psi;
    }
    else {
      resolved.psi = []
    }

    if (msg.qpIterations !== undefined) {
      resolved.qpIterations = msg.qpIterations;
    }
    else {
      resolved.qpIterations = 0
    }

    if (msg.cost !== undefined) {
      resolved.cost = msg.cost;
    }
    else {
      resolved.cost = 0.0
    }

    if (msg.delta !== undefined) {
      resolved.delta = msg.delta;
    }
    else {
      resolved.delta = []
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = []
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = []
    }

    if (msg.calculationTime !== undefined) {
      resolved.calculationTime = msg.calculationTime;
    }
    else {
      resolved.calculationTime = 0
    }

    return resolved;
    }
};

module.exports = LiveMpcData;
