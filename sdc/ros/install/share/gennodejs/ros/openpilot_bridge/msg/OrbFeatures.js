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

class OrbFeatures {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.octaves = null;
      this.matches = null;
      this.descriptors = null;
      this.timestampEof = null;
      this.timestampLastEof = null;
      this.xs = null;
      this.ys = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('octaves')) {
        this.octaves = initObj.octaves
      }
      else {
        this.octaves = [];
      }
      if (initObj.hasOwnProperty('matches')) {
        this.matches = initObj.matches
      }
      else {
        this.matches = [];
      }
      if (initObj.hasOwnProperty('descriptors')) {
        this.descriptors = initObj.descriptors
      }
      else {
        this.descriptors = [];
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('timestampLastEof')) {
        this.timestampLastEof = initObj.timestampLastEof
      }
      else {
        this.timestampLastEof = 0;
      }
      if (initObj.hasOwnProperty('xs')) {
        this.xs = initObj.xs
      }
      else {
        this.xs = [];
      }
      if (initObj.hasOwnProperty('ys')) {
        this.ys = initObj.ys
      }
      else {
        this.ys = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbFeatures
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [octaves]
    bufferOffset = _arraySerializer.int32(obj.octaves, buffer, bufferOffset, null);
    // Serialize message field [matches]
    bufferOffset = _arraySerializer.int32(obj.matches, buffer, bufferOffset, null);
    // Serialize message field [descriptors]
    bufferOffset = _arraySerializer.string(obj.descriptors, buffer, bufferOffset, null);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [timestampLastEof]
    bufferOffset = _serializer.int64(obj.timestampLastEof, buffer, bufferOffset);
    // Serialize message field [xs]
    bufferOffset = _arraySerializer.float32(obj.xs, buffer, bufferOffset, null);
    // Serialize message field [ys]
    bufferOffset = _arraySerializer.float32(obj.ys, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbFeatures
    let len;
    let data = new OrbFeatures(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [octaves]
    data.octaves = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [matches]
    data.matches = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [descriptors]
    data.descriptors = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [timestampLastEof]
    data.timestampLastEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [xs]
    data.xs = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [ys]
    data.ys = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.octaves.length;
    length += 4 * object.matches.length;
    object.descriptors.forEach((val) => {
      length += 4 + val.length;
    });
    length += 4 * object.xs.length;
    length += 4 * object.ys.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbFeatures';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c1391d81b99a78f3f4c88eddd0353256';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32[] octaves
    int32[] matches
    string[] descriptors
    int64 timestampEof
    int64 timestampLastEof
    float32[] xs
    float32[] ys
    
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
    const resolved = new OrbFeatures(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.octaves !== undefined) {
      resolved.octaves = msg.octaves;
    }
    else {
      resolved.octaves = []
    }

    if (msg.matches !== undefined) {
      resolved.matches = msg.matches;
    }
    else {
      resolved.matches = []
    }

    if (msg.descriptors !== undefined) {
      resolved.descriptors = msg.descriptors;
    }
    else {
      resolved.descriptors = []
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.timestampLastEof !== undefined) {
      resolved.timestampLastEof = msg.timestampLastEof;
    }
    else {
      resolved.timestampLastEof = 0
    }

    if (msg.xs !== undefined) {
      resolved.xs = msg.xs;
    }
    else {
      resolved.xs = []
    }

    if (msg.ys !== undefined) {
      resolved.ys = msg.ys;
    }
    else {
      resolved.ys = []
    }

    return resolved;
    }
};

module.exports = OrbFeatures;
