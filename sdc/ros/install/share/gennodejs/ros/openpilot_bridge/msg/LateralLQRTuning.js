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

class LateralLQRTuning {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.a = null;
      this.c = null;
      this.scale = null;
      this.ki = null;
      this.l = null;
      this.b = null;
      this.dcGain = null;
      this.k = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('a')) {
        this.a = initObj.a
      }
      else {
        this.a = [];
      }
      if (initObj.hasOwnProperty('c')) {
        this.c = initObj.c
      }
      else {
        this.c = [];
      }
      if (initObj.hasOwnProperty('scale')) {
        this.scale = initObj.scale
      }
      else {
        this.scale = 0.0;
      }
      if (initObj.hasOwnProperty('ki')) {
        this.ki = initObj.ki
      }
      else {
        this.ki = 0.0;
      }
      if (initObj.hasOwnProperty('l')) {
        this.l = initObj.l
      }
      else {
        this.l = [];
      }
      if (initObj.hasOwnProperty('b')) {
        this.b = initObj.b
      }
      else {
        this.b = [];
      }
      if (initObj.hasOwnProperty('dcGain')) {
        this.dcGain = initObj.dcGain
      }
      else {
        this.dcGain = 0.0;
      }
      if (initObj.hasOwnProperty('k')) {
        this.k = initObj.k
      }
      else {
        this.k = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LateralLQRTuning
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [a]
    bufferOffset = _arraySerializer.float32(obj.a, buffer, bufferOffset, null);
    // Serialize message field [c]
    bufferOffset = _arraySerializer.float32(obj.c, buffer, bufferOffset, null);
    // Serialize message field [scale]
    bufferOffset = _serializer.float32(obj.scale, buffer, bufferOffset);
    // Serialize message field [ki]
    bufferOffset = _serializer.float32(obj.ki, buffer, bufferOffset);
    // Serialize message field [l]
    bufferOffset = _arraySerializer.float32(obj.l, buffer, bufferOffset, null);
    // Serialize message field [b]
    bufferOffset = _arraySerializer.float32(obj.b, buffer, bufferOffset, null);
    // Serialize message field [dcGain]
    bufferOffset = _serializer.float32(obj.dcGain, buffer, bufferOffset);
    // Serialize message field [k]
    bufferOffset = _arraySerializer.float32(obj.k, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LateralLQRTuning
    let len;
    let data = new LateralLQRTuning(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [a]
    data.a = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [c]
    data.c = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [scale]
    data.scale = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ki]
    data.ki = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [l]
    data.l = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [b]
    data.b = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [dcGain]
    data.dcGain = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [k]
    data.k = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.a.length;
    length += 4 * object.c.length;
    length += 4 * object.l.length;
    length += 4 * object.b.length;
    length += 4 * object.k.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LateralLQRTuning';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1a86dbdfea134b9e6760e87aaaceabc4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] a
    float32[] c
    float32 scale
    float32 ki
    float32[] l
    float32[] b
    float32 dcGain
    float32[] k
    
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
    const resolved = new LateralLQRTuning(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.a !== undefined) {
      resolved.a = msg.a;
    }
    else {
      resolved.a = []
    }

    if (msg.c !== undefined) {
      resolved.c = msg.c;
    }
    else {
      resolved.c = []
    }

    if (msg.scale !== undefined) {
      resolved.scale = msg.scale;
    }
    else {
      resolved.scale = 0.0
    }

    if (msg.ki !== undefined) {
      resolved.ki = msg.ki;
    }
    else {
      resolved.ki = 0.0
    }

    if (msg.l !== undefined) {
      resolved.l = msg.l;
    }
    else {
      resolved.l = []
    }

    if (msg.b !== undefined) {
      resolved.b = msg.b;
    }
    else {
      resolved.b = []
    }

    if (msg.dcGain !== undefined) {
      resolved.dcGain = msg.dcGain;
    }
    else {
      resolved.dcGain = 0.0
    }

    if (msg.k !== undefined) {
      resolved.k = msg.k;
    }
    else {
      resolved.k = []
    }

    return resolved;
    }
};

module.exports = LateralLQRTuning;
