// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let IonoData = require('./IonoData.js');
let MeasurementReport = require('./MeasurementReport.js');
let Ephemeris = require('./Ephemeris.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class UbloxGnss {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.ionoData = null;
      this.measurementReport = null;
      this.ephemeris = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('ionoData')) {
        this.ionoData = initObj.ionoData
      }
      else {
        this.ionoData = new IonoData();
      }
      if (initObj.hasOwnProperty('measurementReport')) {
        this.measurementReport = initObj.measurementReport
      }
      else {
        this.measurementReport = new MeasurementReport();
      }
      if (initObj.hasOwnProperty('ephemeris')) {
        this.ephemeris = initObj.ephemeris
      }
      else {
        this.ephemeris = new Ephemeris();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UbloxGnss
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [ionoData]
    bufferOffset = IonoData.serialize(obj.ionoData, buffer, bufferOffset);
    // Serialize message field [measurementReport]
    bufferOffset = MeasurementReport.serialize(obj.measurementReport, buffer, bufferOffset);
    // Serialize message field [ephemeris]
    bufferOffset = Ephemeris.serialize(obj.ephemeris, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UbloxGnss
    let len;
    let data = new UbloxGnss(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [ionoData]
    data.ionoData = IonoData.deserialize(buffer, bufferOffset);
    // Deserialize message field [measurementReport]
    data.measurementReport = MeasurementReport.deserialize(buffer, bufferOffset);
    // Deserialize message field [ephemeris]
    data.ephemeris = Ephemeris.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += IonoData.getMessageSize(object.ionoData);
    length += MeasurementReport.getMessageSize(object.measurementReport);
    length += Ephemeris.getMessageSize(object.ephemeris);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/UbloxGnss';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '64057f9ece7684e899d76ef9539f0d83';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    IonoData ionoData
    MeasurementReport measurementReport
    Ephemeris ephemeris
    
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
    
    ================================================================================
    MSG: openpilot_bridge/IonoData
    Header header
    
    bool healthValid
    float32[] ionoAlpha
    float32 tow
    float32 gpsWeek
    float32[] ionoBeta
    int64 svHealth
    bool ionoCoeffsValid
    
    ================================================================================
    MSG: openpilot_bridge/MeasurementReport
    Header header
    
    Measurement[] measurements
    int64 gpsWeek
    int64 numMeas
    ReceiverStatus receiverStatus
    int64 leapSeconds
    float32 rcvTow
    
    ================================================================================
    MSG: openpilot_bridge/Measurement
    Header header
    
    int64 gnssId
    float32 carrierPhaseStdev
    float32 pseudorange
    float32 doppler
    int64 sigId
    int64 svId
    float32 carrierCycles
    float32 dopplerStdev
    float32 pseudorangeStdev
    int64 cno
    int64 locktime
    int64 glonassFrequencyIndex
    TrackingStatus trackingStatus
    
    ================================================================================
    MSG: openpilot_bridge/TrackingStatus
    Header header
    
    bool halfCycleSubtracted
    bool carrierPhaseValid
    bool pseudorangeValid
    bool halfCycleValid
    
    ================================================================================
    MSG: openpilot_bridge/ReceiverStatus
    Header header
    
    bool leapSecValid
    bool clkReset
    
    ================================================================================
    MSG: openpilot_bridge/Ephemeris
    Header header
    
    float32 iodc
    float32 fitInterval
    int64 month
    float32 second
    float32 tgd
    int64 year
    float32 gpsWeek
    float32 cus
    bool ionoCoeffsValid
    int64 svId
    float32 svAcc
    float32 cuc
    float32 m0
    float32 toc
    float32 deltaN
    float32 toe
    float32 cic
    float32[] ionoBeta
    float32 ecc
    float32 iDot
    float32 i0
    float32 svHealth
    float32 codesL2
    float32 omega
    int64 day
    int64 minute
    float32 a
    float32 crs
    float32[] ionoAlpha
    int64 hour
    float32 iode
    float32 af1
    float32 cis
    float32 crc
    float32 l2
    float32 omegaDot
    float32 af0
    float32 omega0
    float32 af2
    float32 transmissionTime
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new UbloxGnss(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.ionoData !== undefined) {
      resolved.ionoData = IonoData.Resolve(msg.ionoData)
    }
    else {
      resolved.ionoData = new IonoData()
    }

    if (msg.measurementReport !== undefined) {
      resolved.measurementReport = MeasurementReport.Resolve(msg.measurementReport)
    }
    else {
      resolved.measurementReport = new MeasurementReport()
    }

    if (msg.ephemeris !== undefined) {
      resolved.ephemeris = Ephemeris.Resolve(msg.ephemeris)
    }
    else {
      resolved.ephemeris = new Ephemeris()
    }

    return resolved;
    }
};

module.exports = UbloxGnss;
