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

class EsrDetection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.path_id_acc_stat = null;
      this.path_id_acc = null;
      this.path_id_cmbb_move = null;
      this.path_id_cmbb_stat = null;
      this.path_id_fcw_move = null;
      this.path_id_fcw_stat = null;
      this.water_spray_target_id = null;
      this.filtered_xohp_acc_cipv = null;
      this.path_id_acc_2 = null;
      this.path_id_acc_3 = null;
      this.lr_only_grating_lobe_det = null;
      this.truck_target_det = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('path_id_acc_stat')) {
        this.path_id_acc_stat = initObj.path_id_acc_stat
      }
      else {
        this.path_id_acc_stat = 0;
      }
      if (initObj.hasOwnProperty('path_id_acc')) {
        this.path_id_acc = initObj.path_id_acc
      }
      else {
        this.path_id_acc = 0;
      }
      if (initObj.hasOwnProperty('path_id_cmbb_move')) {
        this.path_id_cmbb_move = initObj.path_id_cmbb_move
      }
      else {
        this.path_id_cmbb_move = 0;
      }
      if (initObj.hasOwnProperty('path_id_cmbb_stat')) {
        this.path_id_cmbb_stat = initObj.path_id_cmbb_stat
      }
      else {
        this.path_id_cmbb_stat = 0;
      }
      if (initObj.hasOwnProperty('path_id_fcw_move')) {
        this.path_id_fcw_move = initObj.path_id_fcw_move
      }
      else {
        this.path_id_fcw_move = 0;
      }
      if (initObj.hasOwnProperty('path_id_fcw_stat')) {
        this.path_id_fcw_stat = initObj.path_id_fcw_stat
      }
      else {
        this.path_id_fcw_stat = 0;
      }
      if (initObj.hasOwnProperty('water_spray_target_id')) {
        this.water_spray_target_id = initObj.water_spray_target_id
      }
      else {
        this.water_spray_target_id = 0;
      }
      if (initObj.hasOwnProperty('filtered_xohp_acc_cipv')) {
        this.filtered_xohp_acc_cipv = initObj.filtered_xohp_acc_cipv
      }
      else {
        this.filtered_xohp_acc_cipv = 0.0;
      }
      if (initObj.hasOwnProperty('path_id_acc_2')) {
        this.path_id_acc_2 = initObj.path_id_acc_2
      }
      else {
        this.path_id_acc_2 = 0;
      }
      if (initObj.hasOwnProperty('path_id_acc_3')) {
        this.path_id_acc_3 = initObj.path_id_acc_3
      }
      else {
        this.path_id_acc_3 = 0;
      }
      if (initObj.hasOwnProperty('lr_only_grating_lobe_det')) {
        this.lr_only_grating_lobe_det = initObj.lr_only_grating_lobe_det
      }
      else {
        this.lr_only_grating_lobe_det = false;
      }
      if (initObj.hasOwnProperty('truck_target_det')) {
        this.truck_target_det = initObj.truck_target_det
      }
      else {
        this.truck_target_det = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsrDetection
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [path_id_acc_stat]
    bufferOffset = _serializer.uint8(obj.path_id_acc_stat, buffer, bufferOffset);
    // Serialize message field [path_id_acc]
    bufferOffset = _serializer.uint8(obj.path_id_acc, buffer, bufferOffset);
    // Serialize message field [path_id_cmbb_move]
    bufferOffset = _serializer.uint8(obj.path_id_cmbb_move, buffer, bufferOffset);
    // Serialize message field [path_id_cmbb_stat]
    bufferOffset = _serializer.uint8(obj.path_id_cmbb_stat, buffer, bufferOffset);
    // Serialize message field [path_id_fcw_move]
    bufferOffset = _serializer.uint8(obj.path_id_fcw_move, buffer, bufferOffset);
    // Serialize message field [path_id_fcw_stat]
    bufferOffset = _serializer.uint8(obj.path_id_fcw_stat, buffer, bufferOffset);
    // Serialize message field [water_spray_target_id]
    bufferOffset = _serializer.uint8(obj.water_spray_target_id, buffer, bufferOffset);
    // Serialize message field [filtered_xohp_acc_cipv]
    bufferOffset = _serializer.float32(obj.filtered_xohp_acc_cipv, buffer, bufferOffset);
    // Serialize message field [path_id_acc_2]
    bufferOffset = _serializer.uint8(obj.path_id_acc_2, buffer, bufferOffset);
    // Serialize message field [path_id_acc_3]
    bufferOffset = _serializer.uint8(obj.path_id_acc_3, buffer, bufferOffset);
    // Serialize message field [lr_only_grating_lobe_det]
    bufferOffset = _serializer.bool(obj.lr_only_grating_lobe_det, buffer, bufferOffset);
    // Serialize message field [truck_target_det]
    bufferOffset = _serializer.bool(obj.truck_target_det, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsrDetection
    let len;
    let data = new EsrDetection(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [path_id_acc_stat]
    data.path_id_acc_stat = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_acc]
    data.path_id_acc = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_cmbb_move]
    data.path_id_cmbb_move = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_cmbb_stat]
    data.path_id_cmbb_stat = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_fcw_move]
    data.path_id_fcw_move = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_fcw_stat]
    data.path_id_fcw_stat = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [water_spray_target_id]
    data.water_spray_target_id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [filtered_xohp_acc_cipv]
    data.filtered_xohp_acc_cipv = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [path_id_acc_2]
    data.path_id_acc_2 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [path_id_acc_3]
    data.path_id_acc_3 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [lr_only_grating_lobe_det]
    data.lr_only_grating_lobe_det = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [truck_target_det]
    data.truck_target_det = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 15;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/EsrDetection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3accabc22902f1ec54cb36c33644a9c0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    uint8 path_id_acc_stat
    uint8 path_id_acc
    uint8 path_id_cmbb_move
    uint8 path_id_cmbb_stat
    uint8 path_id_fcw_move
    uint8 path_id_fcw_stat
    uint8 water_spray_target_id
    float32 filtered_xohp_acc_cipv
    uint8 path_id_acc_2
    uint8 path_id_acc_3
    bool lr_only_grating_lobe_det
    bool truck_target_det
    
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
    const resolved = new EsrDetection(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.path_id_acc_stat !== undefined) {
      resolved.path_id_acc_stat = msg.path_id_acc_stat;
    }
    else {
      resolved.path_id_acc_stat = 0
    }

    if (msg.path_id_acc !== undefined) {
      resolved.path_id_acc = msg.path_id_acc;
    }
    else {
      resolved.path_id_acc = 0
    }

    if (msg.path_id_cmbb_move !== undefined) {
      resolved.path_id_cmbb_move = msg.path_id_cmbb_move;
    }
    else {
      resolved.path_id_cmbb_move = 0
    }

    if (msg.path_id_cmbb_stat !== undefined) {
      resolved.path_id_cmbb_stat = msg.path_id_cmbb_stat;
    }
    else {
      resolved.path_id_cmbb_stat = 0
    }

    if (msg.path_id_fcw_move !== undefined) {
      resolved.path_id_fcw_move = msg.path_id_fcw_move;
    }
    else {
      resolved.path_id_fcw_move = 0
    }

    if (msg.path_id_fcw_stat !== undefined) {
      resolved.path_id_fcw_stat = msg.path_id_fcw_stat;
    }
    else {
      resolved.path_id_fcw_stat = 0
    }

    if (msg.water_spray_target_id !== undefined) {
      resolved.water_spray_target_id = msg.water_spray_target_id;
    }
    else {
      resolved.water_spray_target_id = 0
    }

    if (msg.filtered_xohp_acc_cipv !== undefined) {
      resolved.filtered_xohp_acc_cipv = msg.filtered_xohp_acc_cipv;
    }
    else {
      resolved.filtered_xohp_acc_cipv = 0.0
    }

    if (msg.path_id_acc_2 !== undefined) {
      resolved.path_id_acc_2 = msg.path_id_acc_2;
    }
    else {
      resolved.path_id_acc_2 = 0
    }

    if (msg.path_id_acc_3 !== undefined) {
      resolved.path_id_acc_3 = msg.path_id_acc_3;
    }
    else {
      resolved.path_id_acc_3 = 0
    }

    if (msg.lr_only_grating_lobe_det !== undefined) {
      resolved.lr_only_grating_lobe_det = msg.lr_only_grating_lobe_det;
    }
    else {
      resolved.lr_only_grating_lobe_det = false
    }

    if (msg.truck_target_det !== undefined) {
      resolved.truck_target_det = msg.truck_target_det;
    }
    else {
      resolved.truck_target_det = false
    }

    return resolved;
    }
};

module.exports = EsrDetection;
