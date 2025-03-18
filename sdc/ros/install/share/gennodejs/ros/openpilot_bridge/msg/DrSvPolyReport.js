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

class DrSvPolyReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.xyzN = null;
      this.hasSbasIono = null;
      this.positionUncertainty = null;
      this.svId = null;
      this.elevationUncertainty = null;
      this.polyFromXtra = null;
      this.other = null;
      this.ionoDot = null;
      this.hasIono = null;
      this.frequencyIndex = null;
      this.velocityCoeff = null;
      this.elevation = null;
      this.ionoDelay = null;
      this.sbasIonoDelay = null;
      this.hasPosition = null;
      this.hasElevation = null;
      this.iode = null;
      this.elevationDot = null;
      this.t0 = null;
      this.xyz0 = null;
      this.hasTropo = null;
      this.tropoDelay = null;
      this.sbasIonoDot = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('xyzN')) {
        this.xyzN = initObj.xyzN
      }
      else {
        this.xyzN = [];
      }
      if (initObj.hasOwnProperty('hasSbasIono')) {
        this.hasSbasIono = initObj.hasSbasIono
      }
      else {
        this.hasSbasIono = false;
      }
      if (initObj.hasOwnProperty('positionUncertainty')) {
        this.positionUncertainty = initObj.positionUncertainty
      }
      else {
        this.positionUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('svId')) {
        this.svId = initObj.svId
      }
      else {
        this.svId = 0;
      }
      if (initObj.hasOwnProperty('elevationUncertainty')) {
        this.elevationUncertainty = initObj.elevationUncertainty
      }
      else {
        this.elevationUncertainty = 0.0;
      }
      if (initObj.hasOwnProperty('polyFromXtra')) {
        this.polyFromXtra = initObj.polyFromXtra
      }
      else {
        this.polyFromXtra = false;
      }
      if (initObj.hasOwnProperty('other')) {
        this.other = initObj.other
      }
      else {
        this.other = [];
      }
      if (initObj.hasOwnProperty('ionoDot')) {
        this.ionoDot = initObj.ionoDot
      }
      else {
        this.ionoDot = 0.0;
      }
      if (initObj.hasOwnProperty('hasIono')) {
        this.hasIono = initObj.hasIono
      }
      else {
        this.hasIono = false;
      }
      if (initObj.hasOwnProperty('frequencyIndex')) {
        this.frequencyIndex = initObj.frequencyIndex
      }
      else {
        this.frequencyIndex = 0;
      }
      if (initObj.hasOwnProperty('velocityCoeff')) {
        this.velocityCoeff = initObj.velocityCoeff
      }
      else {
        this.velocityCoeff = [];
      }
      if (initObj.hasOwnProperty('elevation')) {
        this.elevation = initObj.elevation
      }
      else {
        this.elevation = 0.0;
      }
      if (initObj.hasOwnProperty('ionoDelay')) {
        this.ionoDelay = initObj.ionoDelay
      }
      else {
        this.ionoDelay = 0.0;
      }
      if (initObj.hasOwnProperty('sbasIonoDelay')) {
        this.sbasIonoDelay = initObj.sbasIonoDelay
      }
      else {
        this.sbasIonoDelay = 0.0;
      }
      if (initObj.hasOwnProperty('hasPosition')) {
        this.hasPosition = initObj.hasPosition
      }
      else {
        this.hasPosition = false;
      }
      if (initObj.hasOwnProperty('hasElevation')) {
        this.hasElevation = initObj.hasElevation
      }
      else {
        this.hasElevation = false;
      }
      if (initObj.hasOwnProperty('iode')) {
        this.iode = initObj.iode
      }
      else {
        this.iode = 0;
      }
      if (initObj.hasOwnProperty('elevationDot')) {
        this.elevationDot = initObj.elevationDot
      }
      else {
        this.elevationDot = 0.0;
      }
      if (initObj.hasOwnProperty('t0')) {
        this.t0 = initObj.t0
      }
      else {
        this.t0 = 0.0;
      }
      if (initObj.hasOwnProperty('xyz0')) {
        this.xyz0 = initObj.xyz0
      }
      else {
        this.xyz0 = [];
      }
      if (initObj.hasOwnProperty('hasTropo')) {
        this.hasTropo = initObj.hasTropo
      }
      else {
        this.hasTropo = false;
      }
      if (initObj.hasOwnProperty('tropoDelay')) {
        this.tropoDelay = initObj.tropoDelay
      }
      else {
        this.tropoDelay = 0.0;
      }
      if (initObj.hasOwnProperty('sbasIonoDot')) {
        this.sbasIonoDot = initObj.sbasIonoDot
      }
      else {
        this.sbasIonoDot = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DrSvPolyReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [xyzN]
    bufferOffset = _arraySerializer.float32(obj.xyzN, buffer, bufferOffset, null);
    // Serialize message field [hasSbasIono]
    bufferOffset = _serializer.bool(obj.hasSbasIono, buffer, bufferOffset);
    // Serialize message field [positionUncertainty]
    bufferOffset = _serializer.float32(obj.positionUncertainty, buffer, bufferOffset);
    // Serialize message field [svId]
    bufferOffset = _serializer.int64(obj.svId, buffer, bufferOffset);
    // Serialize message field [elevationUncertainty]
    bufferOffset = _serializer.float32(obj.elevationUncertainty, buffer, bufferOffset);
    // Serialize message field [polyFromXtra]
    bufferOffset = _serializer.bool(obj.polyFromXtra, buffer, bufferOffset);
    // Serialize message field [other]
    bufferOffset = _arraySerializer.float32(obj.other, buffer, bufferOffset, null);
    // Serialize message field [ionoDot]
    bufferOffset = _serializer.float32(obj.ionoDot, buffer, bufferOffset);
    // Serialize message field [hasIono]
    bufferOffset = _serializer.bool(obj.hasIono, buffer, bufferOffset);
    // Serialize message field [frequencyIndex]
    bufferOffset = _serializer.int32(obj.frequencyIndex, buffer, bufferOffset);
    // Serialize message field [velocityCoeff]
    bufferOffset = _arraySerializer.float32(obj.velocityCoeff, buffer, bufferOffset, null);
    // Serialize message field [elevation]
    bufferOffset = _serializer.float32(obj.elevation, buffer, bufferOffset);
    // Serialize message field [ionoDelay]
    bufferOffset = _serializer.float32(obj.ionoDelay, buffer, bufferOffset);
    // Serialize message field [sbasIonoDelay]
    bufferOffset = _serializer.float32(obj.sbasIonoDelay, buffer, bufferOffset);
    // Serialize message field [hasPosition]
    bufferOffset = _serializer.bool(obj.hasPosition, buffer, bufferOffset);
    // Serialize message field [hasElevation]
    bufferOffset = _serializer.bool(obj.hasElevation, buffer, bufferOffset);
    // Serialize message field [iode]
    bufferOffset = _serializer.int64(obj.iode, buffer, bufferOffset);
    // Serialize message field [elevationDot]
    bufferOffset = _serializer.float32(obj.elevationDot, buffer, bufferOffset);
    // Serialize message field [t0]
    bufferOffset = _serializer.float32(obj.t0, buffer, bufferOffset);
    // Serialize message field [xyz0]
    bufferOffset = _arraySerializer.float32(obj.xyz0, buffer, bufferOffset, null);
    // Serialize message field [hasTropo]
    bufferOffset = _serializer.bool(obj.hasTropo, buffer, bufferOffset);
    // Serialize message field [tropoDelay]
    bufferOffset = _serializer.float32(obj.tropoDelay, buffer, bufferOffset);
    // Serialize message field [sbasIonoDot]
    bufferOffset = _serializer.float32(obj.sbasIonoDot, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DrSvPolyReport
    let len;
    let data = new DrSvPolyReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [xyzN]
    data.xyzN = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [hasSbasIono]
    data.hasSbasIono = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [positionUncertainty]
    data.positionUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [svId]
    data.svId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [elevationUncertainty]
    data.elevationUncertainty = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [polyFromXtra]
    data.polyFromXtra = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [other]
    data.other = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [ionoDot]
    data.ionoDot = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasIono]
    data.hasIono = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [frequencyIndex]
    data.frequencyIndex = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [velocityCoeff]
    data.velocityCoeff = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [elevation]
    data.elevation = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ionoDelay]
    data.ionoDelay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [sbasIonoDelay]
    data.sbasIonoDelay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hasPosition]
    data.hasPosition = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [hasElevation]
    data.hasElevation = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [iode]
    data.iode = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [elevationDot]
    data.elevationDot = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [t0]
    data.t0 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [xyz0]
    data.xyz0 = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [hasTropo]
    data.hasTropo = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [tropoDelay]
    data.tropoDelay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [sbasIonoDot]
    data.sbasIonoDot = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.xyzN.length;
    length += 4 * object.other.length;
    length += 4 * object.velocityCoeff.length;
    length += 4 * object.xyz0.length;
    return length + 82;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/DrSvPolyReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9cc05f066482fefea9be7e6ffcf5850f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32[] xyzN
    bool hasSbasIono
    float32 positionUncertainty
    int64 svId
    float32 elevationUncertainty
    bool polyFromXtra
    float32[] other
    float32 ionoDot
    bool hasIono
    int32 frequencyIndex
    float32[] velocityCoeff
    float32 elevation
    float32 ionoDelay
    float32 sbasIonoDelay
    bool hasPosition
    bool hasElevation
    int64 iode
    float32 elevationDot
    float32 t0
    float32[] xyz0
    bool hasTropo
    float32 tropoDelay
    float32 sbasIonoDot
    
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
    const resolved = new DrSvPolyReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.xyzN !== undefined) {
      resolved.xyzN = msg.xyzN;
    }
    else {
      resolved.xyzN = []
    }

    if (msg.hasSbasIono !== undefined) {
      resolved.hasSbasIono = msg.hasSbasIono;
    }
    else {
      resolved.hasSbasIono = false
    }

    if (msg.positionUncertainty !== undefined) {
      resolved.positionUncertainty = msg.positionUncertainty;
    }
    else {
      resolved.positionUncertainty = 0.0
    }

    if (msg.svId !== undefined) {
      resolved.svId = msg.svId;
    }
    else {
      resolved.svId = 0
    }

    if (msg.elevationUncertainty !== undefined) {
      resolved.elevationUncertainty = msg.elevationUncertainty;
    }
    else {
      resolved.elevationUncertainty = 0.0
    }

    if (msg.polyFromXtra !== undefined) {
      resolved.polyFromXtra = msg.polyFromXtra;
    }
    else {
      resolved.polyFromXtra = false
    }

    if (msg.other !== undefined) {
      resolved.other = msg.other;
    }
    else {
      resolved.other = []
    }

    if (msg.ionoDot !== undefined) {
      resolved.ionoDot = msg.ionoDot;
    }
    else {
      resolved.ionoDot = 0.0
    }

    if (msg.hasIono !== undefined) {
      resolved.hasIono = msg.hasIono;
    }
    else {
      resolved.hasIono = false
    }

    if (msg.frequencyIndex !== undefined) {
      resolved.frequencyIndex = msg.frequencyIndex;
    }
    else {
      resolved.frequencyIndex = 0
    }

    if (msg.velocityCoeff !== undefined) {
      resolved.velocityCoeff = msg.velocityCoeff;
    }
    else {
      resolved.velocityCoeff = []
    }

    if (msg.elevation !== undefined) {
      resolved.elevation = msg.elevation;
    }
    else {
      resolved.elevation = 0.0
    }

    if (msg.ionoDelay !== undefined) {
      resolved.ionoDelay = msg.ionoDelay;
    }
    else {
      resolved.ionoDelay = 0.0
    }

    if (msg.sbasIonoDelay !== undefined) {
      resolved.sbasIonoDelay = msg.sbasIonoDelay;
    }
    else {
      resolved.sbasIonoDelay = 0.0
    }

    if (msg.hasPosition !== undefined) {
      resolved.hasPosition = msg.hasPosition;
    }
    else {
      resolved.hasPosition = false
    }

    if (msg.hasElevation !== undefined) {
      resolved.hasElevation = msg.hasElevation;
    }
    else {
      resolved.hasElevation = false
    }

    if (msg.iode !== undefined) {
      resolved.iode = msg.iode;
    }
    else {
      resolved.iode = 0
    }

    if (msg.elevationDot !== undefined) {
      resolved.elevationDot = msg.elevationDot;
    }
    else {
      resolved.elevationDot = 0.0
    }

    if (msg.t0 !== undefined) {
      resolved.t0 = msg.t0;
    }
    else {
      resolved.t0 = 0.0
    }

    if (msg.xyz0 !== undefined) {
      resolved.xyz0 = msg.xyz0;
    }
    else {
      resolved.xyz0 = []
    }

    if (msg.hasTropo !== undefined) {
      resolved.hasTropo = msg.hasTropo;
    }
    else {
      resolved.hasTropo = false
    }

    if (msg.tropoDelay !== undefined) {
      resolved.tropoDelay = msg.tropoDelay;
    }
    else {
      resolved.tropoDelay = 0.0
    }

    if (msg.sbasIonoDot !== undefined) {
      resolved.sbasIonoDot = msg.sbasIonoDot;
    }
    else {
      resolved.sbasIonoDot = 0.0
    }

    return resolved;
    }
};

module.exports = DrSvPolyReport;
