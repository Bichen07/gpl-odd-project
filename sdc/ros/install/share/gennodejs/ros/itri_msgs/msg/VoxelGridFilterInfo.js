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

class VoxelGridFilterInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.filter_name = null;
      this.measurement_range = null;
      this.original_points_size = null;
      this.filtered_points_size = null;
      this.execution_time = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('filter_name')) {
        this.filter_name = initObj.filter_name
      }
      else {
        this.filter_name = '';
      }
      if (initObj.hasOwnProperty('measurement_range')) {
        this.measurement_range = initObj.measurement_range
      }
      else {
        this.measurement_range = 0.0;
      }
      if (initObj.hasOwnProperty('original_points_size')) {
        this.original_points_size = initObj.original_points_size
      }
      else {
        this.original_points_size = 0;
      }
      if (initObj.hasOwnProperty('filtered_points_size')) {
        this.filtered_points_size = initObj.filtered_points_size
      }
      else {
        this.filtered_points_size = 0;
      }
      if (initObj.hasOwnProperty('execution_time')) {
        this.execution_time = initObj.execution_time
      }
      else {
        this.execution_time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VoxelGridFilterInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [filter_name]
    bufferOffset = _serializer.string(obj.filter_name, buffer, bufferOffset);
    // Serialize message field [measurement_range]
    bufferOffset = _serializer.float32(obj.measurement_range, buffer, bufferOffset);
    // Serialize message field [original_points_size]
    bufferOffset = _serializer.int32(obj.original_points_size, buffer, bufferOffset);
    // Serialize message field [filtered_points_size]
    bufferOffset = _serializer.int32(obj.filtered_points_size, buffer, bufferOffset);
    // Serialize message field [execution_time]
    bufferOffset = _serializer.float32(obj.execution_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VoxelGridFilterInfo
    let len;
    let data = new VoxelGridFilterInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [filter_name]
    data.filter_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [measurement_range]
    data.measurement_range = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [original_points_size]
    data.original_points_size = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [filtered_points_size]
    data.filtered_points_size = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [execution_time]
    data.execution_time = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.filter_name.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/VoxelGridFilterInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a1652d8ba147b439694fc6c6bce138b7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    string filter_name
    float32 measurement_range
    int32 original_points_size
    int32 filtered_points_size
    float32 execution_time
    
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
    const resolved = new VoxelGridFilterInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.filter_name !== undefined) {
      resolved.filter_name = msg.filter_name;
    }
    else {
      resolved.filter_name = ''
    }

    if (msg.measurement_range !== undefined) {
      resolved.measurement_range = msg.measurement_range;
    }
    else {
      resolved.measurement_range = 0.0
    }

    if (msg.original_points_size !== undefined) {
      resolved.original_points_size = msg.original_points_size;
    }
    else {
      resolved.original_points_size = 0
    }

    if (msg.filtered_points_size !== undefined) {
      resolved.filtered_points_size = msg.filtered_points_size;
    }
    else {
      resolved.filtered_points_size = 0
    }

    if (msg.execution_time !== undefined) {
      resolved.execution_time = msg.execution_time;
    }
    else {
      resolved.execution_time = 0.0
    }

    return resolved;
    }
};

module.exports = VoxelGridFilterInfo;
