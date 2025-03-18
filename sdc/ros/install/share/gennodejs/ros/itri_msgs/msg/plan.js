// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class plan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.bias = null;
      this.bias_rate = null;
      this.safe_distance = null;
      this.parking_start = null;
      this.type = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('bias')) {
        this.bias = initObj.bias
      }
      else {
        this.bias = 0.0;
      }
      if (initObj.hasOwnProperty('bias_rate')) {
        this.bias_rate = initObj.bias_rate
      }
      else {
        this.bias_rate = 0.0;
      }
      if (initObj.hasOwnProperty('safe_distance')) {
        this.safe_distance = initObj.safe_distance
      }
      else {
        this.safe_distance = 0.0;
      }
      if (initObj.hasOwnProperty('parking_start')) {
        this.parking_start = initObj.parking_start
      }
      else {
        this.parking_start = false;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type plan
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [bias]
    bufferOffset = _serializer.float32(obj.bias, buffer, bufferOffset);
    // Serialize message field [bias_rate]
    bufferOffset = _serializer.float32(obj.bias_rate, buffer, bufferOffset);
    // Serialize message field [safe_distance]
    bufferOffset = _serializer.float32(obj.safe_distance, buffer, bufferOffset);
    // Serialize message field [parking_start]
    bufferOffset = _serializer.bool(obj.parking_start, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint8(obj.type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type plan
    let len;
    let data = new plan(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [bias]
    data.bias = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [bias_rate]
    data.bias_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [safe_distance]
    data.safe_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [parking_start]
    data.parking_start = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/plan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4efb8b16e81fe1d48cfd91a5f58116e1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 bias
    float32 bias_rate
    float32 safe_distance
    bool parking_start
    
    uint8 OA = 0
    uint8 BUS = 1
    uint8 PARKING = 2
    uint8 LC = 3
    uint8 type
    
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
    const resolved = new plan(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.bias !== undefined) {
      resolved.bias = msg.bias;
    }
    else {
      resolved.bias = 0.0
    }

    if (msg.bias_rate !== undefined) {
      resolved.bias_rate = msg.bias_rate;
    }
    else {
      resolved.bias_rate = 0.0
    }

    if (msg.safe_distance !== undefined) {
      resolved.safe_distance = msg.safe_distance;
    }
    else {
      resolved.safe_distance = 0.0
    }

    if (msg.parking_start !== undefined) {
      resolved.parking_start = msg.parking_start;
    }
    else {
      resolved.parking_start = false
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    return resolved;
    }
};

// Constants for message
plan.Constants = {
  OA: 0,
  BUS: 1,
  PARKING: 2,
  LC: 3,
}

module.exports = plan;
