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

class NdtStatistics {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.execution_time = null;
      this.fitness_score = null;
      this.fitness_score_valid = null;
      this.invalid_points_number = null;
      this.iteration = null;
      this.map_coverage = null;
      this.matching_score = null;
      this.matching_score_valid = null;
      this.regulate_matching_score = null;
      this.scan_valid_ratio = null;
      this.source_points_number = null;
      this.valid_points_number = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('execution_time')) {
        this.execution_time = initObj.execution_time
      }
      else {
        this.execution_time = 0.0;
      }
      if (initObj.hasOwnProperty('fitness_score')) {
        this.fitness_score = initObj.fitness_score
      }
      else {
        this.fitness_score = 0.0;
      }
      if (initObj.hasOwnProperty('fitness_score_valid')) {
        this.fitness_score_valid = initObj.fitness_score_valid
      }
      else {
        this.fitness_score_valid = 0.0;
      }
      if (initObj.hasOwnProperty('invalid_points_number')) {
        this.invalid_points_number = initObj.invalid_points_number
      }
      else {
        this.invalid_points_number = 0;
      }
      if (initObj.hasOwnProperty('iteration')) {
        this.iteration = initObj.iteration
      }
      else {
        this.iteration = 0;
      }
      if (initObj.hasOwnProperty('map_coverage')) {
        this.map_coverage = initObj.map_coverage
      }
      else {
        this.map_coverage = 0.0;
      }
      if (initObj.hasOwnProperty('matching_score')) {
        this.matching_score = initObj.matching_score
      }
      else {
        this.matching_score = 0.0;
      }
      if (initObj.hasOwnProperty('matching_score_valid')) {
        this.matching_score_valid = initObj.matching_score_valid
      }
      else {
        this.matching_score_valid = 0.0;
      }
      if (initObj.hasOwnProperty('regulate_matching_score')) {
        this.regulate_matching_score = initObj.regulate_matching_score
      }
      else {
        this.regulate_matching_score = 0.0;
      }
      if (initObj.hasOwnProperty('scan_valid_ratio')) {
        this.scan_valid_ratio = initObj.scan_valid_ratio
      }
      else {
        this.scan_valid_ratio = 0;
      }
      if (initObj.hasOwnProperty('source_points_number')) {
        this.source_points_number = initObj.source_points_number
      }
      else {
        this.source_points_number = 0;
      }
      if (initObj.hasOwnProperty('valid_points_number')) {
        this.valid_points_number = initObj.valid_points_number
      }
      else {
        this.valid_points_number = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NdtStatistics
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [execution_time]
    bufferOffset = _serializer.float32(obj.execution_time, buffer, bufferOffset);
    // Serialize message field [fitness_score]
    bufferOffset = _serializer.float32(obj.fitness_score, buffer, bufferOffset);
    // Serialize message field [fitness_score_valid]
    bufferOffset = _serializer.float32(obj.fitness_score_valid, buffer, bufferOffset);
    // Serialize message field [invalid_points_number]
    bufferOffset = _serializer.uint32(obj.invalid_points_number, buffer, bufferOffset);
    // Serialize message field [iteration]
    bufferOffset = _serializer.uint32(obj.iteration, buffer, bufferOffset);
    // Serialize message field [map_coverage]
    bufferOffset = _serializer.float32(obj.map_coverage, buffer, bufferOffset);
    // Serialize message field [matching_score]
    bufferOffset = _serializer.float32(obj.matching_score, buffer, bufferOffset);
    // Serialize message field [matching_score_valid]
    bufferOffset = _serializer.float32(obj.matching_score_valid, buffer, bufferOffset);
    // Serialize message field [regulate_matching_score]
    bufferOffset = _serializer.float32(obj.regulate_matching_score, buffer, bufferOffset);
    // Serialize message field [scan_valid_ratio]
    bufferOffset = _serializer.uint32(obj.scan_valid_ratio, buffer, bufferOffset);
    // Serialize message field [source_points_number]
    bufferOffset = _serializer.uint32(obj.source_points_number, buffer, bufferOffset);
    // Serialize message field [valid_points_number]
    bufferOffset = _serializer.uint32(obj.valid_points_number, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NdtStatistics
    let len;
    let data = new NdtStatistics(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [execution_time]
    data.execution_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fitness_score]
    data.fitness_score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fitness_score_valid]
    data.fitness_score_valid = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [invalid_points_number]
    data.invalid_points_number = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [iteration]
    data.iteration = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [map_coverage]
    data.map_coverage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [matching_score]
    data.matching_score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [matching_score_valid]
    data.matching_score_valid = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [regulate_matching_score]
    data.regulate_matching_score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [scan_valid_ratio]
    data.scan_valid_ratio = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [source_points_number]
    data.source_points_number = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [valid_points_number]
    data.valid_points_number = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/NdtStatistics';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b21481a49aaae81584b34de5ce8cef65';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 execution_time
    float32 fitness_score
    float32 fitness_score_valid
    uint32 invalid_points_number
    uint32 iteration
    float32 map_coverage
    float32 matching_score
    float32 matching_score_valid
    float32 regulate_matching_score
    uint32 scan_valid_ratio
    uint32 source_points_number
    uint32 valid_points_number
    
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
    const resolved = new NdtStatistics(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.execution_time !== undefined) {
      resolved.execution_time = msg.execution_time;
    }
    else {
      resolved.execution_time = 0.0
    }

    if (msg.fitness_score !== undefined) {
      resolved.fitness_score = msg.fitness_score;
    }
    else {
      resolved.fitness_score = 0.0
    }

    if (msg.fitness_score_valid !== undefined) {
      resolved.fitness_score_valid = msg.fitness_score_valid;
    }
    else {
      resolved.fitness_score_valid = 0.0
    }

    if (msg.invalid_points_number !== undefined) {
      resolved.invalid_points_number = msg.invalid_points_number;
    }
    else {
      resolved.invalid_points_number = 0
    }

    if (msg.iteration !== undefined) {
      resolved.iteration = msg.iteration;
    }
    else {
      resolved.iteration = 0
    }

    if (msg.map_coverage !== undefined) {
      resolved.map_coverage = msg.map_coverage;
    }
    else {
      resolved.map_coverage = 0.0
    }

    if (msg.matching_score !== undefined) {
      resolved.matching_score = msg.matching_score;
    }
    else {
      resolved.matching_score = 0.0
    }

    if (msg.matching_score_valid !== undefined) {
      resolved.matching_score_valid = msg.matching_score_valid;
    }
    else {
      resolved.matching_score_valid = 0.0
    }

    if (msg.regulate_matching_score !== undefined) {
      resolved.regulate_matching_score = msg.regulate_matching_score;
    }
    else {
      resolved.regulate_matching_score = 0.0
    }

    if (msg.scan_valid_ratio !== undefined) {
      resolved.scan_valid_ratio = msg.scan_valid_ratio;
    }
    else {
      resolved.scan_valid_ratio = 0
    }

    if (msg.source_points_number !== undefined) {
      resolved.source_points_number = msg.source_points_number;
    }
    else {
      resolved.source_points_number = 0
    }

    if (msg.valid_points_number !== undefined) {
      resolved.valid_points_number = msg.valid_points_number;
    }
    else {
      resolved.valid_points_number = 0
    }

    return resolved;
    }
};

module.exports = NdtStatistics;
