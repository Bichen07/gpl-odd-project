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

class VehicleECUState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.accel_pedal_pos1 = null;
      this.accel_pedal_pos2 = null;
      this.engine_speed = null;
      this.engine_average_fuel_economy = null;
      this.engine_instantaneous_fuel_economy = null;
      this.engine_fuel_rate = null;
      this.remote_accel_pedal_pos = null;
      this.est_engine_power_kw = null;
      this.total_vehicle_distance = null;
      this.trip_distance = null;
      this.actual_engine_percentage_torque = null;
      this.act_max_available_eng_percent_torque = null;
      this.drivers_demand_eng_percent_torque = null;
      this.engine_demand_percent_torque = null;
      this.est_pumping_percent_torque = null;
      this.est_eng_prsitic_losses_percent_torque = null;
      this.nominal_friction_percent_torque = null;
      this.DPF_thermal_management_active = null;
      this.engine_percent_load_at_current_speed = null;
      this.engine_reference_torque = null;
      this.momntary_eng_max_power_enable_feedback = null;
      this.SCR_thermal_management_active = null;
      this.vehicle_acceleration_rate_limit_status = null;
      this.fuel_level1_percentage = null;
      this.fuel_level2_percentage = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('accel_pedal_pos1')) {
        this.accel_pedal_pos1 = initObj.accel_pedal_pos1
      }
      else {
        this.accel_pedal_pos1 = 0.0;
      }
      if (initObj.hasOwnProperty('accel_pedal_pos2')) {
        this.accel_pedal_pos2 = initObj.accel_pedal_pos2
      }
      else {
        this.accel_pedal_pos2 = 0.0;
      }
      if (initObj.hasOwnProperty('engine_speed')) {
        this.engine_speed = initObj.engine_speed
      }
      else {
        this.engine_speed = 0.0;
      }
      if (initObj.hasOwnProperty('engine_average_fuel_economy')) {
        this.engine_average_fuel_economy = initObj.engine_average_fuel_economy
      }
      else {
        this.engine_average_fuel_economy = 0.0;
      }
      if (initObj.hasOwnProperty('engine_instantaneous_fuel_economy')) {
        this.engine_instantaneous_fuel_economy = initObj.engine_instantaneous_fuel_economy
      }
      else {
        this.engine_instantaneous_fuel_economy = 0.0;
      }
      if (initObj.hasOwnProperty('engine_fuel_rate')) {
        this.engine_fuel_rate = initObj.engine_fuel_rate
      }
      else {
        this.engine_fuel_rate = 0.0;
      }
      if (initObj.hasOwnProperty('remote_accel_pedal_pos')) {
        this.remote_accel_pedal_pos = initObj.remote_accel_pedal_pos
      }
      else {
        this.remote_accel_pedal_pos = 0.0;
      }
      if (initObj.hasOwnProperty('est_engine_power_kw')) {
        this.est_engine_power_kw = initObj.est_engine_power_kw
      }
      else {
        this.est_engine_power_kw = 0.0;
      }
      if (initObj.hasOwnProperty('total_vehicle_distance')) {
        this.total_vehicle_distance = initObj.total_vehicle_distance
      }
      else {
        this.total_vehicle_distance = 0.0;
      }
      if (initObj.hasOwnProperty('trip_distance')) {
        this.trip_distance = initObj.trip_distance
      }
      else {
        this.trip_distance = 0.0;
      }
      if (initObj.hasOwnProperty('actual_engine_percentage_torque')) {
        this.actual_engine_percentage_torque = initObj.actual_engine_percentage_torque
      }
      else {
        this.actual_engine_percentage_torque = 0;
      }
      if (initObj.hasOwnProperty('act_max_available_eng_percent_torque')) {
        this.act_max_available_eng_percent_torque = initObj.act_max_available_eng_percent_torque
      }
      else {
        this.act_max_available_eng_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('drivers_demand_eng_percent_torque')) {
        this.drivers_demand_eng_percent_torque = initObj.drivers_demand_eng_percent_torque
      }
      else {
        this.drivers_demand_eng_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('engine_demand_percent_torque')) {
        this.engine_demand_percent_torque = initObj.engine_demand_percent_torque
      }
      else {
        this.engine_demand_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('est_pumping_percent_torque')) {
        this.est_pumping_percent_torque = initObj.est_pumping_percent_torque
      }
      else {
        this.est_pumping_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('est_eng_prsitic_losses_percent_torque')) {
        this.est_eng_prsitic_losses_percent_torque = initObj.est_eng_prsitic_losses_percent_torque
      }
      else {
        this.est_eng_prsitic_losses_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('nominal_friction_percent_torque')) {
        this.nominal_friction_percent_torque = initObj.nominal_friction_percent_torque
      }
      else {
        this.nominal_friction_percent_torque = 0;
      }
      if (initObj.hasOwnProperty('DPF_thermal_management_active')) {
        this.DPF_thermal_management_active = initObj.DPF_thermal_management_active
      }
      else {
        this.DPF_thermal_management_active = 0;
      }
      if (initObj.hasOwnProperty('engine_percent_load_at_current_speed')) {
        this.engine_percent_load_at_current_speed = initObj.engine_percent_load_at_current_speed
      }
      else {
        this.engine_percent_load_at_current_speed = 0;
      }
      if (initObj.hasOwnProperty('engine_reference_torque')) {
        this.engine_reference_torque = initObj.engine_reference_torque
      }
      else {
        this.engine_reference_torque = 0;
      }
      if (initObj.hasOwnProperty('momntary_eng_max_power_enable_feedback')) {
        this.momntary_eng_max_power_enable_feedback = initObj.momntary_eng_max_power_enable_feedback
      }
      else {
        this.momntary_eng_max_power_enable_feedback = 0;
      }
      if (initObj.hasOwnProperty('SCR_thermal_management_active')) {
        this.SCR_thermal_management_active = initObj.SCR_thermal_management_active
      }
      else {
        this.SCR_thermal_management_active = 0;
      }
      if (initObj.hasOwnProperty('vehicle_acceleration_rate_limit_status')) {
        this.vehicle_acceleration_rate_limit_status = initObj.vehicle_acceleration_rate_limit_status
      }
      else {
        this.vehicle_acceleration_rate_limit_status = 0;
      }
      if (initObj.hasOwnProperty('fuel_level1_percentage')) {
        this.fuel_level1_percentage = initObj.fuel_level1_percentage
      }
      else {
        this.fuel_level1_percentage = 0;
      }
      if (initObj.hasOwnProperty('fuel_level2_percentage')) {
        this.fuel_level2_percentage = initObj.fuel_level2_percentage
      }
      else {
        this.fuel_level2_percentage = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VehicleECUState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [accel_pedal_pos1]
    bufferOffset = _serializer.float32(obj.accel_pedal_pos1, buffer, bufferOffset);
    // Serialize message field [accel_pedal_pos2]
    bufferOffset = _serializer.float32(obj.accel_pedal_pos2, buffer, bufferOffset);
    // Serialize message field [engine_speed]
    bufferOffset = _serializer.float32(obj.engine_speed, buffer, bufferOffset);
    // Serialize message field [engine_average_fuel_economy]
    bufferOffset = _serializer.float32(obj.engine_average_fuel_economy, buffer, bufferOffset);
    // Serialize message field [engine_instantaneous_fuel_economy]
    bufferOffset = _serializer.float32(obj.engine_instantaneous_fuel_economy, buffer, bufferOffset);
    // Serialize message field [engine_fuel_rate]
    bufferOffset = _serializer.float32(obj.engine_fuel_rate, buffer, bufferOffset);
    // Serialize message field [remote_accel_pedal_pos]
    bufferOffset = _serializer.float32(obj.remote_accel_pedal_pos, buffer, bufferOffset);
    // Serialize message field [est_engine_power_kw]
    bufferOffset = _serializer.float32(obj.est_engine_power_kw, buffer, bufferOffset);
    // Serialize message field [total_vehicle_distance]
    bufferOffset = _serializer.float32(obj.total_vehicle_distance, buffer, bufferOffset);
    // Serialize message field [trip_distance]
    bufferOffset = _serializer.float32(obj.trip_distance, buffer, bufferOffset);
    // Serialize message field [actual_engine_percentage_torque]
    bufferOffset = _serializer.int8(obj.actual_engine_percentage_torque, buffer, bufferOffset);
    // Serialize message field [act_max_available_eng_percent_torque]
    bufferOffset = _serializer.int8(obj.act_max_available_eng_percent_torque, buffer, bufferOffset);
    // Serialize message field [drivers_demand_eng_percent_torque]
    bufferOffset = _serializer.int8(obj.drivers_demand_eng_percent_torque, buffer, bufferOffset);
    // Serialize message field [engine_demand_percent_torque]
    bufferOffset = _serializer.int8(obj.engine_demand_percent_torque, buffer, bufferOffset);
    // Serialize message field [est_pumping_percent_torque]
    bufferOffset = _serializer.int8(obj.est_pumping_percent_torque, buffer, bufferOffset);
    // Serialize message field [est_eng_prsitic_losses_percent_torque]
    bufferOffset = _serializer.int8(obj.est_eng_prsitic_losses_percent_torque, buffer, bufferOffset);
    // Serialize message field [nominal_friction_percent_torque]
    bufferOffset = _serializer.int8(obj.nominal_friction_percent_torque, buffer, bufferOffset);
    // Serialize message field [DPF_thermal_management_active]
    bufferOffset = _serializer.uint8(obj.DPF_thermal_management_active, buffer, bufferOffset);
    // Serialize message field [engine_percent_load_at_current_speed]
    bufferOffset = _serializer.uint8(obj.engine_percent_load_at_current_speed, buffer, bufferOffset);
    // Serialize message field [engine_reference_torque]
    bufferOffset = _serializer.uint8(obj.engine_reference_torque, buffer, bufferOffset);
    // Serialize message field [momntary_eng_max_power_enable_feedback]
    bufferOffset = _serializer.uint8(obj.momntary_eng_max_power_enable_feedback, buffer, bufferOffset);
    // Serialize message field [SCR_thermal_management_active]
    bufferOffset = _serializer.uint8(obj.SCR_thermal_management_active, buffer, bufferOffset);
    // Serialize message field [vehicle_acceleration_rate_limit_status]
    bufferOffset = _serializer.uint8(obj.vehicle_acceleration_rate_limit_status, buffer, bufferOffset);
    // Serialize message field [fuel_level1_percentage]
    bufferOffset = _serializer.uint8(obj.fuel_level1_percentage, buffer, bufferOffset);
    // Serialize message field [fuel_level2_percentage]
    bufferOffset = _serializer.uint8(obj.fuel_level2_percentage, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VehicleECUState
    let len;
    let data = new VehicleECUState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [accel_pedal_pos1]
    data.accel_pedal_pos1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accel_pedal_pos2]
    data.accel_pedal_pos2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [engine_speed]
    data.engine_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [engine_average_fuel_economy]
    data.engine_average_fuel_economy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [engine_instantaneous_fuel_economy]
    data.engine_instantaneous_fuel_economy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [engine_fuel_rate]
    data.engine_fuel_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [remote_accel_pedal_pos]
    data.remote_accel_pedal_pos = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [est_engine_power_kw]
    data.est_engine_power_kw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [total_vehicle_distance]
    data.total_vehicle_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [trip_distance]
    data.trip_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [actual_engine_percentage_torque]
    data.actual_engine_percentage_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [act_max_available_eng_percent_torque]
    data.act_max_available_eng_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [drivers_demand_eng_percent_torque]
    data.drivers_demand_eng_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [engine_demand_percent_torque]
    data.engine_demand_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [est_pumping_percent_torque]
    data.est_pumping_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [est_eng_prsitic_losses_percent_torque]
    data.est_eng_prsitic_losses_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [nominal_friction_percent_torque]
    data.nominal_friction_percent_torque = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [DPF_thermal_management_active]
    data.DPF_thermal_management_active = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [engine_percent_load_at_current_speed]
    data.engine_percent_load_at_current_speed = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [engine_reference_torque]
    data.engine_reference_torque = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [momntary_eng_max_power_enable_feedback]
    data.momntary_eng_max_power_enable_feedback = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [SCR_thermal_management_active]
    data.SCR_thermal_management_active = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [vehicle_acceleration_rate_limit_status]
    data.vehicle_acceleration_rate_limit_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [fuel_level1_percentage]
    data.fuel_level1_percentage = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [fuel_level2_percentage]
    data.fuel_level2_percentage = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 55;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/VehicleECUState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '283d54a284611771e67b738b33b81ee0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 accel_pedal_pos1
    float32 accel_pedal_pos2
    float32 engine_speed
    float32 engine_average_fuel_economy
    float32 engine_instantaneous_fuel_economy
    float32 engine_fuel_rate
    float32 remote_accel_pedal_pos
    float32 est_engine_power_kw
    float32 total_vehicle_distance
    float32 trip_distance
    int8 actual_engine_percentage_torque
    int8 act_max_available_eng_percent_torque
    int8 drivers_demand_eng_percent_torque
    int8 engine_demand_percent_torque
    int8 est_pumping_percent_torque
    int8 est_eng_prsitic_losses_percent_torque
    int8 nominal_friction_percent_torque
    uint8 DPF_thermal_management_active
    uint8 engine_percent_load_at_current_speed
    uint8 engine_reference_torque
    uint8 momntary_eng_max_power_enable_feedback
    uint8 SCR_thermal_management_active
    uint8 vehicle_acceleration_rate_limit_status
    uint8 fuel_level1_percentage
    uint8 fuel_level2_percentage
    
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
    const resolved = new VehicleECUState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.accel_pedal_pos1 !== undefined) {
      resolved.accel_pedal_pos1 = msg.accel_pedal_pos1;
    }
    else {
      resolved.accel_pedal_pos1 = 0.0
    }

    if (msg.accel_pedal_pos2 !== undefined) {
      resolved.accel_pedal_pos2 = msg.accel_pedal_pos2;
    }
    else {
      resolved.accel_pedal_pos2 = 0.0
    }

    if (msg.engine_speed !== undefined) {
      resolved.engine_speed = msg.engine_speed;
    }
    else {
      resolved.engine_speed = 0.0
    }

    if (msg.engine_average_fuel_economy !== undefined) {
      resolved.engine_average_fuel_economy = msg.engine_average_fuel_economy;
    }
    else {
      resolved.engine_average_fuel_economy = 0.0
    }

    if (msg.engine_instantaneous_fuel_economy !== undefined) {
      resolved.engine_instantaneous_fuel_economy = msg.engine_instantaneous_fuel_economy;
    }
    else {
      resolved.engine_instantaneous_fuel_economy = 0.0
    }

    if (msg.engine_fuel_rate !== undefined) {
      resolved.engine_fuel_rate = msg.engine_fuel_rate;
    }
    else {
      resolved.engine_fuel_rate = 0.0
    }

    if (msg.remote_accel_pedal_pos !== undefined) {
      resolved.remote_accel_pedal_pos = msg.remote_accel_pedal_pos;
    }
    else {
      resolved.remote_accel_pedal_pos = 0.0
    }

    if (msg.est_engine_power_kw !== undefined) {
      resolved.est_engine_power_kw = msg.est_engine_power_kw;
    }
    else {
      resolved.est_engine_power_kw = 0.0
    }

    if (msg.total_vehicle_distance !== undefined) {
      resolved.total_vehicle_distance = msg.total_vehicle_distance;
    }
    else {
      resolved.total_vehicle_distance = 0.0
    }

    if (msg.trip_distance !== undefined) {
      resolved.trip_distance = msg.trip_distance;
    }
    else {
      resolved.trip_distance = 0.0
    }

    if (msg.actual_engine_percentage_torque !== undefined) {
      resolved.actual_engine_percentage_torque = msg.actual_engine_percentage_torque;
    }
    else {
      resolved.actual_engine_percentage_torque = 0
    }

    if (msg.act_max_available_eng_percent_torque !== undefined) {
      resolved.act_max_available_eng_percent_torque = msg.act_max_available_eng_percent_torque;
    }
    else {
      resolved.act_max_available_eng_percent_torque = 0
    }

    if (msg.drivers_demand_eng_percent_torque !== undefined) {
      resolved.drivers_demand_eng_percent_torque = msg.drivers_demand_eng_percent_torque;
    }
    else {
      resolved.drivers_demand_eng_percent_torque = 0
    }

    if (msg.engine_demand_percent_torque !== undefined) {
      resolved.engine_demand_percent_torque = msg.engine_demand_percent_torque;
    }
    else {
      resolved.engine_demand_percent_torque = 0
    }

    if (msg.est_pumping_percent_torque !== undefined) {
      resolved.est_pumping_percent_torque = msg.est_pumping_percent_torque;
    }
    else {
      resolved.est_pumping_percent_torque = 0
    }

    if (msg.est_eng_prsitic_losses_percent_torque !== undefined) {
      resolved.est_eng_prsitic_losses_percent_torque = msg.est_eng_prsitic_losses_percent_torque;
    }
    else {
      resolved.est_eng_prsitic_losses_percent_torque = 0
    }

    if (msg.nominal_friction_percent_torque !== undefined) {
      resolved.nominal_friction_percent_torque = msg.nominal_friction_percent_torque;
    }
    else {
      resolved.nominal_friction_percent_torque = 0
    }

    if (msg.DPF_thermal_management_active !== undefined) {
      resolved.DPF_thermal_management_active = msg.DPF_thermal_management_active;
    }
    else {
      resolved.DPF_thermal_management_active = 0
    }

    if (msg.engine_percent_load_at_current_speed !== undefined) {
      resolved.engine_percent_load_at_current_speed = msg.engine_percent_load_at_current_speed;
    }
    else {
      resolved.engine_percent_load_at_current_speed = 0
    }

    if (msg.engine_reference_torque !== undefined) {
      resolved.engine_reference_torque = msg.engine_reference_torque;
    }
    else {
      resolved.engine_reference_torque = 0
    }

    if (msg.momntary_eng_max_power_enable_feedback !== undefined) {
      resolved.momntary_eng_max_power_enable_feedback = msg.momntary_eng_max_power_enable_feedback;
    }
    else {
      resolved.momntary_eng_max_power_enable_feedback = 0
    }

    if (msg.SCR_thermal_management_active !== undefined) {
      resolved.SCR_thermal_management_active = msg.SCR_thermal_management_active;
    }
    else {
      resolved.SCR_thermal_management_active = 0
    }

    if (msg.vehicle_acceleration_rate_limit_status !== undefined) {
      resolved.vehicle_acceleration_rate_limit_status = msg.vehicle_acceleration_rate_limit_status;
    }
    else {
      resolved.vehicle_acceleration_rate_limit_status = 0
    }

    if (msg.fuel_level1_percentage !== undefined) {
      resolved.fuel_level1_percentage = msg.fuel_level1_percentage;
    }
    else {
      resolved.fuel_level1_percentage = 0
    }

    if (msg.fuel_level2_percentage !== undefined) {
      resolved.fuel_level2_percentage = msg.fuel_level2_percentage;
    }
    else {
      resolved.fuel_level2_percentage = 0
    }

    return resolved;
    }
};

module.exports = VehicleECUState;
