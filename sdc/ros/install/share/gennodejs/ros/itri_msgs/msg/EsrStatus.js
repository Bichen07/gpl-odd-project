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

class EsrStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.esr_curvature = null;
      this.esr_yaw_rate = null;
      this.esr_vehicle_speed = null;
      this.esr_max_track_targets = null;
      this.esr_power_mode = null;
      this.esr_mr_lr_mode = null;
      this.esr_grouping_mode = null;
      this.esr_temperature = null;
      this.esr_scan_id = null;
      this.esr_raw_data_mode = null;
      this.esr_partial_blockage = null;
      this.esr_side_lobe_blockage = null;
      this.esr_found_target = null;
      this.esr_comm_error = null;
      this.esr_overheat_error = null;
      this.esr_range_perf_error = null;
      this.esr_internal_error = null;
      this.esr_xcvr_operational = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('esr_curvature')) {
        this.esr_curvature = initObj.esr_curvature
      }
      else {
        this.esr_curvature = 0;
      }
      if (initObj.hasOwnProperty('esr_yaw_rate')) {
        this.esr_yaw_rate = initObj.esr_yaw_rate
      }
      else {
        this.esr_yaw_rate = 0.0;
      }
      if (initObj.hasOwnProperty('esr_vehicle_speed')) {
        this.esr_vehicle_speed = initObj.esr_vehicle_speed
      }
      else {
        this.esr_vehicle_speed = 0.0;
      }
      if (initObj.hasOwnProperty('esr_max_track_targets')) {
        this.esr_max_track_targets = initObj.esr_max_track_targets
      }
      else {
        this.esr_max_track_targets = 0;
      }
      if (initObj.hasOwnProperty('esr_power_mode')) {
        this.esr_power_mode = initObj.esr_power_mode
      }
      else {
        this.esr_power_mode = 0;
      }
      if (initObj.hasOwnProperty('esr_mr_lr_mode')) {
        this.esr_mr_lr_mode = initObj.esr_mr_lr_mode
      }
      else {
        this.esr_mr_lr_mode = 0;
      }
      if (initObj.hasOwnProperty('esr_grouping_mode')) {
        this.esr_grouping_mode = initObj.esr_grouping_mode
      }
      else {
        this.esr_grouping_mode = 0;
      }
      if (initObj.hasOwnProperty('esr_temperature')) {
        this.esr_temperature = initObj.esr_temperature
      }
      else {
        this.esr_temperature = 0;
      }
      if (initObj.hasOwnProperty('esr_scan_id')) {
        this.esr_scan_id = initObj.esr_scan_id
      }
      else {
        this.esr_scan_id = 0;
      }
      if (initObj.hasOwnProperty('esr_raw_data_mode')) {
        this.esr_raw_data_mode = initObj.esr_raw_data_mode
      }
      else {
        this.esr_raw_data_mode = false;
      }
      if (initObj.hasOwnProperty('esr_partial_blockage')) {
        this.esr_partial_blockage = initObj.esr_partial_blockage
      }
      else {
        this.esr_partial_blockage = false;
      }
      if (initObj.hasOwnProperty('esr_side_lobe_blockage')) {
        this.esr_side_lobe_blockage = initObj.esr_side_lobe_blockage
      }
      else {
        this.esr_side_lobe_blockage = false;
      }
      if (initObj.hasOwnProperty('esr_found_target')) {
        this.esr_found_target = initObj.esr_found_target
      }
      else {
        this.esr_found_target = false;
      }
      if (initObj.hasOwnProperty('esr_comm_error')) {
        this.esr_comm_error = initObj.esr_comm_error
      }
      else {
        this.esr_comm_error = false;
      }
      if (initObj.hasOwnProperty('esr_overheat_error')) {
        this.esr_overheat_error = initObj.esr_overheat_error
      }
      else {
        this.esr_overheat_error = false;
      }
      if (initObj.hasOwnProperty('esr_range_perf_error')) {
        this.esr_range_perf_error = initObj.esr_range_perf_error
      }
      else {
        this.esr_range_perf_error = false;
      }
      if (initObj.hasOwnProperty('esr_internal_error')) {
        this.esr_internal_error = initObj.esr_internal_error
      }
      else {
        this.esr_internal_error = false;
      }
      if (initObj.hasOwnProperty('esr_xcvr_operational')) {
        this.esr_xcvr_operational = initObj.esr_xcvr_operational
      }
      else {
        this.esr_xcvr_operational = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsrStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [esr_curvature]
    bufferOffset = _serializer.int16(obj.esr_curvature, buffer, bufferOffset);
    // Serialize message field [esr_yaw_rate]
    bufferOffset = _serializer.float32(obj.esr_yaw_rate, buffer, bufferOffset);
    // Serialize message field [esr_vehicle_speed]
    bufferOffset = _serializer.float32(obj.esr_vehicle_speed, buffer, bufferOffset);
    // Serialize message field [esr_max_track_targets]
    bufferOffset = _serializer.uint8(obj.esr_max_track_targets, buffer, bufferOffset);
    // Serialize message field [esr_power_mode]
    bufferOffset = _serializer.uint8(obj.esr_power_mode, buffer, bufferOffset);
    // Serialize message field [esr_mr_lr_mode]
    bufferOffset = _serializer.uint8(obj.esr_mr_lr_mode, buffer, bufferOffset);
    // Serialize message field [esr_grouping_mode]
    bufferOffset = _serializer.uint8(obj.esr_grouping_mode, buffer, bufferOffset);
    // Serialize message field [esr_temperature]
    bufferOffset = _serializer.int8(obj.esr_temperature, buffer, bufferOffset);
    // Serialize message field [esr_scan_id]
    bufferOffset = _serializer.uint8(obj.esr_scan_id, buffer, bufferOffset);
    // Serialize message field [esr_raw_data_mode]
    bufferOffset = _serializer.bool(obj.esr_raw_data_mode, buffer, bufferOffset);
    // Serialize message field [esr_partial_blockage]
    bufferOffset = _serializer.bool(obj.esr_partial_blockage, buffer, bufferOffset);
    // Serialize message field [esr_side_lobe_blockage]
    bufferOffset = _serializer.bool(obj.esr_side_lobe_blockage, buffer, bufferOffset);
    // Serialize message field [esr_found_target]
    bufferOffset = _serializer.bool(obj.esr_found_target, buffer, bufferOffset);
    // Serialize message field [esr_comm_error]
    bufferOffset = _serializer.bool(obj.esr_comm_error, buffer, bufferOffset);
    // Serialize message field [esr_overheat_error]
    bufferOffset = _serializer.bool(obj.esr_overheat_error, buffer, bufferOffset);
    // Serialize message field [esr_range_perf_error]
    bufferOffset = _serializer.bool(obj.esr_range_perf_error, buffer, bufferOffset);
    // Serialize message field [esr_internal_error]
    bufferOffset = _serializer.bool(obj.esr_internal_error, buffer, bufferOffset);
    // Serialize message field [esr_xcvr_operational]
    bufferOffset = _serializer.bool(obj.esr_xcvr_operational, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsrStatus
    let len;
    let data = new EsrStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [esr_curvature]
    data.esr_curvature = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [esr_yaw_rate]
    data.esr_yaw_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [esr_vehicle_speed]
    data.esr_vehicle_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [esr_max_track_targets]
    data.esr_max_track_targets = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [esr_power_mode]
    data.esr_power_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [esr_mr_lr_mode]
    data.esr_mr_lr_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [esr_grouping_mode]
    data.esr_grouping_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [esr_temperature]
    data.esr_temperature = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [esr_scan_id]
    data.esr_scan_id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [esr_raw_data_mode]
    data.esr_raw_data_mode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_partial_blockage]
    data.esr_partial_blockage = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_side_lobe_blockage]
    data.esr_side_lobe_blockage = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_found_target]
    data.esr_found_target = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_comm_error]
    data.esr_comm_error = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_overheat_error]
    data.esr_overheat_error = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_range_perf_error]
    data.esr_range_perf_error = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_internal_error]
    data.esr_internal_error = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [esr_xcvr_operational]
    data.esr_xcvr_operational = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 25;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/EsrStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6576074bb36351e24411f4c33b02aeac';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    int16 esr_curvature
    float32 esr_yaw_rate
    float32 esr_vehicle_speed
    uint8 esr_max_track_targets
    uint8 esr_power_mode
    uint8 esr_mr_lr_mode
    uint8 esr_grouping_mode
    int8 esr_temperature
    uint8 esr_scan_id
    bool esr_raw_data_mode
    bool esr_partial_blockage
    bool esr_side_lobe_blockage
    bool esr_found_target
    bool esr_comm_error
    bool esr_overheat_error
    bool esr_range_perf_error
    bool esr_internal_error
    bool esr_xcvr_operational
    
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
    const resolved = new EsrStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.esr_curvature !== undefined) {
      resolved.esr_curvature = msg.esr_curvature;
    }
    else {
      resolved.esr_curvature = 0
    }

    if (msg.esr_yaw_rate !== undefined) {
      resolved.esr_yaw_rate = msg.esr_yaw_rate;
    }
    else {
      resolved.esr_yaw_rate = 0.0
    }

    if (msg.esr_vehicle_speed !== undefined) {
      resolved.esr_vehicle_speed = msg.esr_vehicle_speed;
    }
    else {
      resolved.esr_vehicle_speed = 0.0
    }

    if (msg.esr_max_track_targets !== undefined) {
      resolved.esr_max_track_targets = msg.esr_max_track_targets;
    }
    else {
      resolved.esr_max_track_targets = 0
    }

    if (msg.esr_power_mode !== undefined) {
      resolved.esr_power_mode = msg.esr_power_mode;
    }
    else {
      resolved.esr_power_mode = 0
    }

    if (msg.esr_mr_lr_mode !== undefined) {
      resolved.esr_mr_lr_mode = msg.esr_mr_lr_mode;
    }
    else {
      resolved.esr_mr_lr_mode = 0
    }

    if (msg.esr_grouping_mode !== undefined) {
      resolved.esr_grouping_mode = msg.esr_grouping_mode;
    }
    else {
      resolved.esr_grouping_mode = 0
    }

    if (msg.esr_temperature !== undefined) {
      resolved.esr_temperature = msg.esr_temperature;
    }
    else {
      resolved.esr_temperature = 0
    }

    if (msg.esr_scan_id !== undefined) {
      resolved.esr_scan_id = msg.esr_scan_id;
    }
    else {
      resolved.esr_scan_id = 0
    }

    if (msg.esr_raw_data_mode !== undefined) {
      resolved.esr_raw_data_mode = msg.esr_raw_data_mode;
    }
    else {
      resolved.esr_raw_data_mode = false
    }

    if (msg.esr_partial_blockage !== undefined) {
      resolved.esr_partial_blockage = msg.esr_partial_blockage;
    }
    else {
      resolved.esr_partial_blockage = false
    }

    if (msg.esr_side_lobe_blockage !== undefined) {
      resolved.esr_side_lobe_blockage = msg.esr_side_lobe_blockage;
    }
    else {
      resolved.esr_side_lobe_blockage = false
    }

    if (msg.esr_found_target !== undefined) {
      resolved.esr_found_target = msg.esr_found_target;
    }
    else {
      resolved.esr_found_target = false
    }

    if (msg.esr_comm_error !== undefined) {
      resolved.esr_comm_error = msg.esr_comm_error;
    }
    else {
      resolved.esr_comm_error = false
    }

    if (msg.esr_overheat_error !== undefined) {
      resolved.esr_overheat_error = msg.esr_overheat_error;
    }
    else {
      resolved.esr_overheat_error = false
    }

    if (msg.esr_range_perf_error !== undefined) {
      resolved.esr_range_perf_error = msg.esr_range_perf_error;
    }
    else {
      resolved.esr_range_perf_error = false
    }

    if (msg.esr_internal_error !== undefined) {
      resolved.esr_internal_error = msg.esr_internal_error;
    }
    else {
      resolved.esr_internal_error = false
    }

    if (msg.esr_xcvr_operational !== undefined) {
      resolved.esr_xcvr_operational = msg.esr_xcvr_operational;
    }
    else {
      resolved.esr_xcvr_operational = false
    }

    return resolved;
    }
};

module.exports = EsrStatus;
