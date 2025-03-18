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

class Ephemeris {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.iodc = null;
      this.fitInterval = null;
      this.month = null;
      this.second = null;
      this.tgd = null;
      this.year = null;
      this.gpsWeek = null;
      this.cus = null;
      this.ionoCoeffsValid = null;
      this.svId = null;
      this.svAcc = null;
      this.cuc = null;
      this.m0 = null;
      this.toc = null;
      this.deltaN = null;
      this.toe = null;
      this.cic = null;
      this.ionoBeta = null;
      this.ecc = null;
      this.iDot = null;
      this.i0 = null;
      this.svHealth = null;
      this.codesL2 = null;
      this.omega = null;
      this.day = null;
      this.minute = null;
      this.a = null;
      this.crs = null;
      this.ionoAlpha = null;
      this.hour = null;
      this.iode = null;
      this.af1 = null;
      this.cis = null;
      this.crc = null;
      this.l2 = null;
      this.omegaDot = null;
      this.af0 = null;
      this.omega0 = null;
      this.af2 = null;
      this.transmissionTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('iodc')) {
        this.iodc = initObj.iodc
      }
      else {
        this.iodc = 0.0;
      }
      if (initObj.hasOwnProperty('fitInterval')) {
        this.fitInterval = initObj.fitInterval
      }
      else {
        this.fitInterval = 0.0;
      }
      if (initObj.hasOwnProperty('month')) {
        this.month = initObj.month
      }
      else {
        this.month = 0;
      }
      if (initObj.hasOwnProperty('second')) {
        this.second = initObj.second
      }
      else {
        this.second = 0.0;
      }
      if (initObj.hasOwnProperty('tgd')) {
        this.tgd = initObj.tgd
      }
      else {
        this.tgd = 0.0;
      }
      if (initObj.hasOwnProperty('year')) {
        this.year = initObj.year
      }
      else {
        this.year = 0;
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0.0;
      }
      if (initObj.hasOwnProperty('cus')) {
        this.cus = initObj.cus
      }
      else {
        this.cus = 0.0;
      }
      if (initObj.hasOwnProperty('ionoCoeffsValid')) {
        this.ionoCoeffsValid = initObj.ionoCoeffsValid
      }
      else {
        this.ionoCoeffsValid = false;
      }
      if (initObj.hasOwnProperty('svId')) {
        this.svId = initObj.svId
      }
      else {
        this.svId = 0;
      }
      if (initObj.hasOwnProperty('svAcc')) {
        this.svAcc = initObj.svAcc
      }
      else {
        this.svAcc = 0.0;
      }
      if (initObj.hasOwnProperty('cuc')) {
        this.cuc = initObj.cuc
      }
      else {
        this.cuc = 0.0;
      }
      if (initObj.hasOwnProperty('m0')) {
        this.m0 = initObj.m0
      }
      else {
        this.m0 = 0.0;
      }
      if (initObj.hasOwnProperty('toc')) {
        this.toc = initObj.toc
      }
      else {
        this.toc = 0.0;
      }
      if (initObj.hasOwnProperty('deltaN')) {
        this.deltaN = initObj.deltaN
      }
      else {
        this.deltaN = 0.0;
      }
      if (initObj.hasOwnProperty('toe')) {
        this.toe = initObj.toe
      }
      else {
        this.toe = 0.0;
      }
      if (initObj.hasOwnProperty('cic')) {
        this.cic = initObj.cic
      }
      else {
        this.cic = 0.0;
      }
      if (initObj.hasOwnProperty('ionoBeta')) {
        this.ionoBeta = initObj.ionoBeta
      }
      else {
        this.ionoBeta = [];
      }
      if (initObj.hasOwnProperty('ecc')) {
        this.ecc = initObj.ecc
      }
      else {
        this.ecc = 0.0;
      }
      if (initObj.hasOwnProperty('iDot')) {
        this.iDot = initObj.iDot
      }
      else {
        this.iDot = 0.0;
      }
      if (initObj.hasOwnProperty('i0')) {
        this.i0 = initObj.i0
      }
      else {
        this.i0 = 0.0;
      }
      if (initObj.hasOwnProperty('svHealth')) {
        this.svHealth = initObj.svHealth
      }
      else {
        this.svHealth = 0.0;
      }
      if (initObj.hasOwnProperty('codesL2')) {
        this.codesL2 = initObj.codesL2
      }
      else {
        this.codesL2 = 0.0;
      }
      if (initObj.hasOwnProperty('omega')) {
        this.omega = initObj.omega
      }
      else {
        this.omega = 0.0;
      }
      if (initObj.hasOwnProperty('day')) {
        this.day = initObj.day
      }
      else {
        this.day = 0;
      }
      if (initObj.hasOwnProperty('minute')) {
        this.minute = initObj.minute
      }
      else {
        this.minute = 0;
      }
      if (initObj.hasOwnProperty('a')) {
        this.a = initObj.a
      }
      else {
        this.a = 0.0;
      }
      if (initObj.hasOwnProperty('crs')) {
        this.crs = initObj.crs
      }
      else {
        this.crs = 0.0;
      }
      if (initObj.hasOwnProperty('ionoAlpha')) {
        this.ionoAlpha = initObj.ionoAlpha
      }
      else {
        this.ionoAlpha = [];
      }
      if (initObj.hasOwnProperty('hour')) {
        this.hour = initObj.hour
      }
      else {
        this.hour = 0;
      }
      if (initObj.hasOwnProperty('iode')) {
        this.iode = initObj.iode
      }
      else {
        this.iode = 0.0;
      }
      if (initObj.hasOwnProperty('af1')) {
        this.af1 = initObj.af1
      }
      else {
        this.af1 = 0.0;
      }
      if (initObj.hasOwnProperty('cis')) {
        this.cis = initObj.cis
      }
      else {
        this.cis = 0.0;
      }
      if (initObj.hasOwnProperty('crc')) {
        this.crc = initObj.crc
      }
      else {
        this.crc = 0.0;
      }
      if (initObj.hasOwnProperty('l2')) {
        this.l2 = initObj.l2
      }
      else {
        this.l2 = 0.0;
      }
      if (initObj.hasOwnProperty('omegaDot')) {
        this.omegaDot = initObj.omegaDot
      }
      else {
        this.omegaDot = 0.0;
      }
      if (initObj.hasOwnProperty('af0')) {
        this.af0 = initObj.af0
      }
      else {
        this.af0 = 0.0;
      }
      if (initObj.hasOwnProperty('omega0')) {
        this.omega0 = initObj.omega0
      }
      else {
        this.omega0 = 0.0;
      }
      if (initObj.hasOwnProperty('af2')) {
        this.af2 = initObj.af2
      }
      else {
        this.af2 = 0.0;
      }
      if (initObj.hasOwnProperty('transmissionTime')) {
        this.transmissionTime = initObj.transmissionTime
      }
      else {
        this.transmissionTime = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Ephemeris
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [iodc]
    bufferOffset = _serializer.float32(obj.iodc, buffer, bufferOffset);
    // Serialize message field [fitInterval]
    bufferOffset = _serializer.float32(obj.fitInterval, buffer, bufferOffset);
    // Serialize message field [month]
    bufferOffset = _serializer.int64(obj.month, buffer, bufferOffset);
    // Serialize message field [second]
    bufferOffset = _serializer.float32(obj.second, buffer, bufferOffset);
    // Serialize message field [tgd]
    bufferOffset = _serializer.float32(obj.tgd, buffer, bufferOffset);
    // Serialize message field [year]
    bufferOffset = _serializer.int64(obj.year, buffer, bufferOffset);
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.float32(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [cus]
    bufferOffset = _serializer.float32(obj.cus, buffer, bufferOffset);
    // Serialize message field [ionoCoeffsValid]
    bufferOffset = _serializer.bool(obj.ionoCoeffsValid, buffer, bufferOffset);
    // Serialize message field [svId]
    bufferOffset = _serializer.int64(obj.svId, buffer, bufferOffset);
    // Serialize message field [svAcc]
    bufferOffset = _serializer.float32(obj.svAcc, buffer, bufferOffset);
    // Serialize message field [cuc]
    bufferOffset = _serializer.float32(obj.cuc, buffer, bufferOffset);
    // Serialize message field [m0]
    bufferOffset = _serializer.float32(obj.m0, buffer, bufferOffset);
    // Serialize message field [toc]
    bufferOffset = _serializer.float32(obj.toc, buffer, bufferOffset);
    // Serialize message field [deltaN]
    bufferOffset = _serializer.float32(obj.deltaN, buffer, bufferOffset);
    // Serialize message field [toe]
    bufferOffset = _serializer.float32(obj.toe, buffer, bufferOffset);
    // Serialize message field [cic]
    bufferOffset = _serializer.float32(obj.cic, buffer, bufferOffset);
    // Serialize message field [ionoBeta]
    bufferOffset = _arraySerializer.float32(obj.ionoBeta, buffer, bufferOffset, null);
    // Serialize message field [ecc]
    bufferOffset = _serializer.float32(obj.ecc, buffer, bufferOffset);
    // Serialize message field [iDot]
    bufferOffset = _serializer.float32(obj.iDot, buffer, bufferOffset);
    // Serialize message field [i0]
    bufferOffset = _serializer.float32(obj.i0, buffer, bufferOffset);
    // Serialize message field [svHealth]
    bufferOffset = _serializer.float32(obj.svHealth, buffer, bufferOffset);
    // Serialize message field [codesL2]
    bufferOffset = _serializer.float32(obj.codesL2, buffer, bufferOffset);
    // Serialize message field [omega]
    bufferOffset = _serializer.float32(obj.omega, buffer, bufferOffset);
    // Serialize message field [day]
    bufferOffset = _serializer.int64(obj.day, buffer, bufferOffset);
    // Serialize message field [minute]
    bufferOffset = _serializer.int64(obj.minute, buffer, bufferOffset);
    // Serialize message field [a]
    bufferOffset = _serializer.float32(obj.a, buffer, bufferOffset);
    // Serialize message field [crs]
    bufferOffset = _serializer.float32(obj.crs, buffer, bufferOffset);
    // Serialize message field [ionoAlpha]
    bufferOffset = _arraySerializer.float32(obj.ionoAlpha, buffer, bufferOffset, null);
    // Serialize message field [hour]
    bufferOffset = _serializer.int64(obj.hour, buffer, bufferOffset);
    // Serialize message field [iode]
    bufferOffset = _serializer.float32(obj.iode, buffer, bufferOffset);
    // Serialize message field [af1]
    bufferOffset = _serializer.float32(obj.af1, buffer, bufferOffset);
    // Serialize message field [cis]
    bufferOffset = _serializer.float32(obj.cis, buffer, bufferOffset);
    // Serialize message field [crc]
    bufferOffset = _serializer.float32(obj.crc, buffer, bufferOffset);
    // Serialize message field [l2]
    bufferOffset = _serializer.float32(obj.l2, buffer, bufferOffset);
    // Serialize message field [omegaDot]
    bufferOffset = _serializer.float32(obj.omegaDot, buffer, bufferOffset);
    // Serialize message field [af0]
    bufferOffset = _serializer.float32(obj.af0, buffer, bufferOffset);
    // Serialize message field [omega0]
    bufferOffset = _serializer.float32(obj.omega0, buffer, bufferOffset);
    // Serialize message field [af2]
    bufferOffset = _serializer.float32(obj.af2, buffer, bufferOffset);
    // Serialize message field [transmissionTime]
    bufferOffset = _serializer.float32(obj.transmissionTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Ephemeris
    let len;
    let data = new Ephemeris(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [iodc]
    data.iodc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fitInterval]
    data.fitInterval = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [month]
    data.month = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [second]
    data.second = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tgd]
    data.tgd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [year]
    data.year = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cus]
    data.cus = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ionoCoeffsValid]
    data.ionoCoeffsValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [svId]
    data.svId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [svAcc]
    data.svAcc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cuc]
    data.cuc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [m0]
    data.m0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [toc]
    data.toc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [deltaN]
    data.deltaN = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [toe]
    data.toe = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cic]
    data.cic = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ionoBeta]
    data.ionoBeta = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [ecc]
    data.ecc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [iDot]
    data.iDot = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [i0]
    data.i0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [svHealth]
    data.svHealth = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [codesL2]
    data.codesL2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [omega]
    data.omega = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [day]
    data.day = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [minute]
    data.minute = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [a]
    data.a = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [crs]
    data.crs = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ionoAlpha]
    data.ionoAlpha = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [hour]
    data.hour = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [iode]
    data.iode = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [af1]
    data.af1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cis]
    data.cis = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [crc]
    data.crc = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [l2]
    data.l2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [omegaDot]
    data.omegaDot = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [af0]
    data.af0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [omega0]
    data.omega0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [af2]
    data.af2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [transmissionTime]
    data.transmissionTime = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.ionoBeta.length;
    length += 4 * object.ionoAlpha.length;
    return length + 181;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Ephemeris';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '50d32c9cb75750d1673e442b54a93a06';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Ephemeris(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.iodc !== undefined) {
      resolved.iodc = msg.iodc;
    }
    else {
      resolved.iodc = 0.0
    }

    if (msg.fitInterval !== undefined) {
      resolved.fitInterval = msg.fitInterval;
    }
    else {
      resolved.fitInterval = 0.0
    }

    if (msg.month !== undefined) {
      resolved.month = msg.month;
    }
    else {
      resolved.month = 0
    }

    if (msg.second !== undefined) {
      resolved.second = msg.second;
    }
    else {
      resolved.second = 0.0
    }

    if (msg.tgd !== undefined) {
      resolved.tgd = msg.tgd;
    }
    else {
      resolved.tgd = 0.0
    }

    if (msg.year !== undefined) {
      resolved.year = msg.year;
    }
    else {
      resolved.year = 0
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0.0
    }

    if (msg.cus !== undefined) {
      resolved.cus = msg.cus;
    }
    else {
      resolved.cus = 0.0
    }

    if (msg.ionoCoeffsValid !== undefined) {
      resolved.ionoCoeffsValid = msg.ionoCoeffsValid;
    }
    else {
      resolved.ionoCoeffsValid = false
    }

    if (msg.svId !== undefined) {
      resolved.svId = msg.svId;
    }
    else {
      resolved.svId = 0
    }

    if (msg.svAcc !== undefined) {
      resolved.svAcc = msg.svAcc;
    }
    else {
      resolved.svAcc = 0.0
    }

    if (msg.cuc !== undefined) {
      resolved.cuc = msg.cuc;
    }
    else {
      resolved.cuc = 0.0
    }

    if (msg.m0 !== undefined) {
      resolved.m0 = msg.m0;
    }
    else {
      resolved.m0 = 0.0
    }

    if (msg.toc !== undefined) {
      resolved.toc = msg.toc;
    }
    else {
      resolved.toc = 0.0
    }

    if (msg.deltaN !== undefined) {
      resolved.deltaN = msg.deltaN;
    }
    else {
      resolved.deltaN = 0.0
    }

    if (msg.toe !== undefined) {
      resolved.toe = msg.toe;
    }
    else {
      resolved.toe = 0.0
    }

    if (msg.cic !== undefined) {
      resolved.cic = msg.cic;
    }
    else {
      resolved.cic = 0.0
    }

    if (msg.ionoBeta !== undefined) {
      resolved.ionoBeta = msg.ionoBeta;
    }
    else {
      resolved.ionoBeta = []
    }

    if (msg.ecc !== undefined) {
      resolved.ecc = msg.ecc;
    }
    else {
      resolved.ecc = 0.0
    }

    if (msg.iDot !== undefined) {
      resolved.iDot = msg.iDot;
    }
    else {
      resolved.iDot = 0.0
    }

    if (msg.i0 !== undefined) {
      resolved.i0 = msg.i0;
    }
    else {
      resolved.i0 = 0.0
    }

    if (msg.svHealth !== undefined) {
      resolved.svHealth = msg.svHealth;
    }
    else {
      resolved.svHealth = 0.0
    }

    if (msg.codesL2 !== undefined) {
      resolved.codesL2 = msg.codesL2;
    }
    else {
      resolved.codesL2 = 0.0
    }

    if (msg.omega !== undefined) {
      resolved.omega = msg.omega;
    }
    else {
      resolved.omega = 0.0
    }

    if (msg.day !== undefined) {
      resolved.day = msg.day;
    }
    else {
      resolved.day = 0
    }

    if (msg.minute !== undefined) {
      resolved.minute = msg.minute;
    }
    else {
      resolved.minute = 0
    }

    if (msg.a !== undefined) {
      resolved.a = msg.a;
    }
    else {
      resolved.a = 0.0
    }

    if (msg.crs !== undefined) {
      resolved.crs = msg.crs;
    }
    else {
      resolved.crs = 0.0
    }

    if (msg.ionoAlpha !== undefined) {
      resolved.ionoAlpha = msg.ionoAlpha;
    }
    else {
      resolved.ionoAlpha = []
    }

    if (msg.hour !== undefined) {
      resolved.hour = msg.hour;
    }
    else {
      resolved.hour = 0
    }

    if (msg.iode !== undefined) {
      resolved.iode = msg.iode;
    }
    else {
      resolved.iode = 0.0
    }

    if (msg.af1 !== undefined) {
      resolved.af1 = msg.af1;
    }
    else {
      resolved.af1 = 0.0
    }

    if (msg.cis !== undefined) {
      resolved.cis = msg.cis;
    }
    else {
      resolved.cis = 0.0
    }

    if (msg.crc !== undefined) {
      resolved.crc = msg.crc;
    }
    else {
      resolved.crc = 0.0
    }

    if (msg.l2 !== undefined) {
      resolved.l2 = msg.l2;
    }
    else {
      resolved.l2 = 0.0
    }

    if (msg.omegaDot !== undefined) {
      resolved.omegaDot = msg.omegaDot;
    }
    else {
      resolved.omegaDot = 0.0
    }

    if (msg.af0 !== undefined) {
      resolved.af0 = msg.af0;
    }
    else {
      resolved.af0 = 0.0
    }

    if (msg.omega0 !== undefined) {
      resolved.omega0 = msg.omega0;
    }
    else {
      resolved.omega0 = 0.0
    }

    if (msg.af2 !== undefined) {
      resolved.af2 = msg.af2;
    }
    else {
      resolved.af2 = 0.0
    }

    if (msg.transmissionTime !== undefined) {
      resolved.transmissionTime = msg.transmissionTime;
    }
    else {
      resolved.transmissionTime = 0.0
    }

    return resolved;
    }
};

module.exports = Ephemeris;
