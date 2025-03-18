// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class LowVoltageSystemReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.dbw_battery_volts = null;
      this.vehicle_battery_volts = null;
      this.vehicle_battery_current = null;
      this.vehicle_alternator_current = null;
      this.dcdc_current = null;
      this.alternator_current = null;
      this.aux_battery_contactor = null;
      this.aux_inverter_contactor = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('dbw_battery_volts')) {
        this.dbw_battery_volts = initObj.dbw_battery_volts
      }
      else {
        this.dbw_battery_volts = 0.0;
      }
      if (initObj.hasOwnProperty('vehicle_battery_volts')) {
        this.vehicle_battery_volts = initObj.vehicle_battery_volts
      }
      else {
        this.vehicle_battery_volts = 0.0;
      }
      if (initObj.hasOwnProperty('vehicle_battery_current')) {
        this.vehicle_battery_current = initObj.vehicle_battery_current
      }
      else {
        this.vehicle_battery_current = 0.0;
      }
      if (initObj.hasOwnProperty('vehicle_alternator_current')) {
        this.vehicle_alternator_current = initObj.vehicle_alternator_current
      }
      else {
        this.vehicle_alternator_current = 0.0;
      }
      if (initObj.hasOwnProperty('dcdc_current')) {
        this.dcdc_current = initObj.dcdc_current
      }
      else {
        this.dcdc_current = 0.0;
      }
      if (initObj.hasOwnProperty('alternator_current')) {
        this.alternator_current = initObj.alternator_current
      }
      else {
        this.alternator_current = 0.0;
      }
      if (initObj.hasOwnProperty('aux_battery_contactor')) {
        this.aux_battery_contactor = initObj.aux_battery_contactor
      }
      else {
        this.aux_battery_contactor = false;
      }
      if (initObj.hasOwnProperty('aux_inverter_contactor')) {
        this.aux_inverter_contactor = initObj.aux_inverter_contactor
      }
      else {
        this.aux_inverter_contactor = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LowVoltageSystemReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [dbw_battery_volts]
    bufferOffset = _serializer.float32(obj.dbw_battery_volts, buffer, bufferOffset);
    // Serialize message field [vehicle_battery_volts]
    bufferOffset = _serializer.float32(obj.vehicle_battery_volts, buffer, bufferOffset);
    // Serialize message field [vehicle_battery_current]
    bufferOffset = _serializer.float32(obj.vehicle_battery_current, buffer, bufferOffset);
    // Serialize message field [vehicle_alternator_current]
    bufferOffset = _serializer.float32(obj.vehicle_alternator_current, buffer, bufferOffset);
    // Serialize message field [dcdc_current]
    bufferOffset = _serializer.float32(obj.dcdc_current, buffer, bufferOffset);
    // Serialize message field [alternator_current]
    bufferOffset = _serializer.float32(obj.alternator_current, buffer, bufferOffset);
    // Serialize message field [aux_battery_contactor]
    bufferOffset = _serializer.bool(obj.aux_battery_contactor, buffer, bufferOffset);
    // Serialize message field [aux_inverter_contactor]
    bufferOffset = _serializer.bool(obj.aux_inverter_contactor, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LowVoltageSystemReport
    let len;
    let data = new LowVoltageSystemReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [dbw_battery_volts]
    data.dbw_battery_volts = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vehicle_battery_volts]
    data.vehicle_battery_volts = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vehicle_battery_current]
    data.vehicle_battery_current = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vehicle_alternator_current]
    data.vehicle_alternator_current = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dcdc_current]
    data.dcdc_current = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [alternator_current]
    data.alternator_current = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aux_battery_contactor]
    data.aux_battery_contactor = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [aux_inverter_contactor]
    data.aux_inverter_contactor = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 26;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/LowVoltageSystemReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c352ea40227e6ba399244c0eeed0064c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 dbw_battery_volts # Volts
    float32 vehicle_battery_volts # Volts 
    float32 vehicle_battery_current # Amps
    float32 vehicle_alternator_current #Amps
    
    float32 dcdc_current # Amps
    float32 alternator_current # Amps
    
    bool aux_battery_contactor # On/Off
    bool aux_inverter_contactor # On/Off
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
    const resolved = new LowVoltageSystemReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.dbw_battery_volts !== undefined) {
      resolved.dbw_battery_volts = msg.dbw_battery_volts;
    }
    else {
      resolved.dbw_battery_volts = 0.0
    }

    if (msg.vehicle_battery_volts !== undefined) {
      resolved.vehicle_battery_volts = msg.vehicle_battery_volts;
    }
    else {
      resolved.vehicle_battery_volts = 0.0
    }

    if (msg.vehicle_battery_current !== undefined) {
      resolved.vehicle_battery_current = msg.vehicle_battery_current;
    }
    else {
      resolved.vehicle_battery_current = 0.0
    }

    if (msg.vehicle_alternator_current !== undefined) {
      resolved.vehicle_alternator_current = msg.vehicle_alternator_current;
    }
    else {
      resolved.vehicle_alternator_current = 0.0
    }

    if (msg.dcdc_current !== undefined) {
      resolved.dcdc_current = msg.dcdc_current;
    }
    else {
      resolved.dcdc_current = 0.0
    }

    if (msg.alternator_current !== undefined) {
      resolved.alternator_current = msg.alternator_current;
    }
    else {
      resolved.alternator_current = 0.0
    }

    if (msg.aux_battery_contactor !== undefined) {
      resolved.aux_battery_contactor = msg.aux_battery_contactor;
    }
    else {
      resolved.aux_battery_contactor = false
    }

    if (msg.aux_inverter_contactor !== undefined) {
      resolved.aux_inverter_contactor = msg.aux_inverter_contactor;
    }
    else {
      resolved.aux_inverter_contactor = false
    }

    return resolved;
    }
};

module.exports = LowVoltageSystemReport;
