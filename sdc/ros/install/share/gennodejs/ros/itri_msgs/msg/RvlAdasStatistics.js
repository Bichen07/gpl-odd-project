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

class RvlAdasStatistics {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.preProcessingTime = null;
      this.infernceTime = null;
      this.postProcessingTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('preProcessingTime')) {
        this.preProcessingTime = initObj.preProcessingTime
      }
      else {
        this.preProcessingTime = 0.0;
      }
      if (initObj.hasOwnProperty('infernceTime')) {
        this.infernceTime = initObj.infernceTime
      }
      else {
        this.infernceTime = 0.0;
      }
      if (initObj.hasOwnProperty('postProcessingTime')) {
        this.postProcessingTime = initObj.postProcessingTime
      }
      else {
        this.postProcessingTime = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RvlAdasStatistics
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [preProcessingTime]
    bufferOffset = _serializer.float32(obj.preProcessingTime, buffer, bufferOffset);
    // Serialize message field [infernceTime]
    bufferOffset = _serializer.float32(obj.infernceTime, buffer, bufferOffset);
    // Serialize message field [postProcessingTime]
    bufferOffset = _serializer.float32(obj.postProcessingTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RvlAdasStatistics
    let len;
    let data = new RvlAdasStatistics(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [preProcessingTime]
    data.preProcessingTime = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [infernceTime]
    data.infernceTime = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [postProcessingTime]
    data.postProcessingTime = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/RvlAdasStatistics';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f80e671674f1651c37ef74d50d290b0c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 preProcessingTime
    float32 infernceTime
    float32 postProcessingTime
    
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
    const resolved = new RvlAdasStatistics(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.preProcessingTime !== undefined) {
      resolved.preProcessingTime = msg.preProcessingTime;
    }
    else {
      resolved.preProcessingTime = 0.0
    }

    if (msg.infernceTime !== undefined) {
      resolved.infernceTime = msg.infernceTime;
    }
    else {
      resolved.infernceTime = 0.0
    }

    if (msg.postProcessingTime !== undefined) {
      resolved.postProcessingTime = msg.postProcessingTime;
    }
    else {
      resolved.postProcessingTime = 0.0
    }

    return resolved;
    }
};

module.exports = RvlAdasStatistics;
