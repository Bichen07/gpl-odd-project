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

class OrbFeaturesSummary {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.timestampEof = null;
      this.featureCount = null;
      this.matchCount = null;
      this.timestampLastEof = null;
      this.computeNs = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('featureCount')) {
        this.featureCount = initObj.featureCount
      }
      else {
        this.featureCount = 0;
      }
      if (initObj.hasOwnProperty('matchCount')) {
        this.matchCount = initObj.matchCount
      }
      else {
        this.matchCount = 0;
      }
      if (initObj.hasOwnProperty('timestampLastEof')) {
        this.timestampLastEof = initObj.timestampLastEof
      }
      else {
        this.timestampLastEof = 0;
      }
      if (initObj.hasOwnProperty('computeNs')) {
        this.computeNs = initObj.computeNs
      }
      else {
        this.computeNs = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbFeaturesSummary
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [featureCount]
    bufferOffset = _serializer.int64(obj.featureCount, buffer, bufferOffset);
    // Serialize message field [matchCount]
    bufferOffset = _serializer.int64(obj.matchCount, buffer, bufferOffset);
    // Serialize message field [timestampLastEof]
    bufferOffset = _serializer.int64(obj.timestampLastEof, buffer, bufferOffset);
    // Serialize message field [computeNs]
    bufferOffset = _serializer.int64(obj.computeNs, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbFeaturesSummary
    let len;
    let data = new OrbFeaturesSummary(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [featureCount]
    data.featureCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [matchCount]
    data.matchCount = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [timestampLastEof]
    data.timestampLastEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [computeNs]
    data.computeNs = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbFeaturesSummary';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'afb40913cace05ea0c7922dff3fa207f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 timestampEof
    int64 featureCount
    int64 matchCount
    int64 timestampLastEof
    int64 computeNs
    
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
    const resolved = new OrbFeaturesSummary(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.featureCount !== undefined) {
      resolved.featureCount = msg.featureCount;
    }
    else {
      resolved.featureCount = 0
    }

    if (msg.matchCount !== undefined) {
      resolved.matchCount = msg.matchCount;
    }
    else {
      resolved.matchCount = 0
    }

    if (msg.timestampLastEof !== undefined) {
      resolved.timestampLastEof = msg.timestampLastEof;
    }
    else {
      resolved.timestampLastEof = 0
    }

    if (msg.computeNs !== undefined) {
      resolved.computeNs = msg.computeNs;
    }
    else {
      resolved.computeNs = 0
    }

    return resolved;
    }
};

module.exports = OrbFeaturesSummary;
