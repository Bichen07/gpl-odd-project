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

class LeadData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.dRel = null;
      this.yRel = null;
      this.vRel = null;
      this.aRel = null;
      this.vLead = null;
      this.aLeadDEPRECATED = null;
      this.dPath = null;
      this.vLat = null;
      this.vLeadK = null;
      this.aLeadK = null;
      this.fcw = null;
      this.status = null;
      this.aLeadTau = null;
      this.modelProb = null;
      this.radar = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('dRel')) {
        this.dRel = initObj.dRel
      }
      else {
        this.dRel = 0.0;
      }
      if (initObj.hasOwnProperty('yRel')) {
        this.yRel = initObj.yRel
      }
      else {
        this.yRel = 0.0;
      }
      if (initObj.hasOwnProperty('vRel')) {
        this.vRel = initObj.vRel
      }
      else {
        this.vRel = 0.0;
      }
      if (initObj.hasOwnProperty('aRel')) {
        this.aRel = initObj.aRel
      }
      else {
        this.aRel = 0.0;
      }
      if (initObj.hasOwnProperty('vLead')) {
        this.vLead = initObj.vLead
      }
      else {
        this.vLead = 0.0;
      }
      if (initObj.hasOwnProperty('aLeadDEPRECATED')) {
        this.aLeadDEPRECATED = initObj.aLeadDEPRECATED
      }
      else {
        this.aLeadDEPRECATED = 0.0;
      }
      if (initObj.hasOwnProperty('dPath')) {
        this.dPath = initObj.dPath
      }
      else {
        this.dPath = 0.0;
      }
      if (initObj.hasOwnProperty('vLat')) {
        this.vLat = initObj.vLat
      }
      else {
        this.vLat = 0.0;
      }
      if (initObj.hasOwnProperty('vLeadK')) {
        this.vLeadK = initObj.vLeadK
      }
      else {
        this.vLeadK = 0.0;
      }
      if (initObj.hasOwnProperty('aLeadK')) {
        this.aLeadK = initObj.aLeadK
      }
      else {
        this.aLeadK = 0.0;
      }
      if (initObj.hasOwnProperty('fcw')) {
        this.fcw = initObj.fcw
      }
      else {
        this.fcw = false;
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = false;
      }
      if (initObj.hasOwnProperty('aLeadTau')) {
        this.aLeadTau = initObj.aLeadTau
      }
      else {
        this.aLeadTau = 0.0;
      }
      if (initObj.hasOwnProperty('modelProb')) {
        this.modelProb = initObj.modelProb
      }
      else {
        this.modelProb = 0.0;
      }
      if (initObj.hasOwnProperty('radar')) {
        this.radar = initObj.radar
      }
      else {
        this.radar = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LeadData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [dRel]
    bufferOffset = _serializer.float32(obj.dRel, buffer, bufferOffset);
    // Serialize message field [yRel]
    bufferOffset = _serializer.float32(obj.yRel, buffer, bufferOffset);
    // Serialize message field [vRel]
    bufferOffset = _serializer.float32(obj.vRel, buffer, bufferOffset);
    // Serialize message field [aRel]
    bufferOffset = _serializer.float32(obj.aRel, buffer, bufferOffset);
    // Serialize message field [vLead]
    bufferOffset = _serializer.float32(obj.vLead, buffer, bufferOffset);
    // Serialize message field [aLeadDEPRECATED]
    bufferOffset = _serializer.float32(obj.aLeadDEPRECATED, buffer, bufferOffset);
    // Serialize message field [dPath]
    bufferOffset = _serializer.float32(obj.dPath, buffer, bufferOffset);
    // Serialize message field [vLat]
    bufferOffset = _serializer.float32(obj.vLat, buffer, bufferOffset);
    // Serialize message field [vLeadK]
    bufferOffset = _serializer.float32(obj.vLeadK, buffer, bufferOffset);
    // Serialize message field [aLeadK]
    bufferOffset = _serializer.float32(obj.aLeadK, buffer, bufferOffset);
    // Serialize message field [fcw]
    bufferOffset = _serializer.bool(obj.fcw, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.bool(obj.status, buffer, bufferOffset);
    // Serialize message field [aLeadTau]
    bufferOffset = _serializer.float32(obj.aLeadTau, buffer, bufferOffset);
    // Serialize message field [modelProb]
    bufferOffset = _serializer.float32(obj.modelProb, buffer, bufferOffset);
    // Serialize message field [radar]
    bufferOffset = _serializer.bool(obj.radar, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LeadData
    let len;
    let data = new LeadData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [dRel]
    data.dRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yRel]
    data.yRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vRel]
    data.vRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aRel]
    data.aRel = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vLead]
    data.vLead = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aLeadDEPRECATED]
    data.aLeadDEPRECATED = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dPath]
    data.dPath = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vLat]
    data.vLat = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vLeadK]
    data.vLeadK = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aLeadK]
    data.aLeadK = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fcw]
    data.fcw = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [aLeadTau]
    data.aLeadTau = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [modelProb]
    data.modelProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [radar]
    data.radar = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 51;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LeadData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2267c1a294f8eb3e2cb2f5c2e4aba833';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 dRel
    float32 yRel
    float32 vRel
    float32 aRel
    float32 vLead
    float32 aLeadDEPRECATED
    float32 dPath
    float32 vLat
    float32 vLeadK
    float32 aLeadK
    bool fcw
    bool status
    float32 aLeadTau
    float32 modelProb
    bool radar
    
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
    const resolved = new LeadData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.dRel !== undefined) {
      resolved.dRel = msg.dRel;
    }
    else {
      resolved.dRel = 0.0
    }

    if (msg.yRel !== undefined) {
      resolved.yRel = msg.yRel;
    }
    else {
      resolved.yRel = 0.0
    }

    if (msg.vRel !== undefined) {
      resolved.vRel = msg.vRel;
    }
    else {
      resolved.vRel = 0.0
    }

    if (msg.aRel !== undefined) {
      resolved.aRel = msg.aRel;
    }
    else {
      resolved.aRel = 0.0
    }

    if (msg.vLead !== undefined) {
      resolved.vLead = msg.vLead;
    }
    else {
      resolved.vLead = 0.0
    }

    if (msg.aLeadDEPRECATED !== undefined) {
      resolved.aLeadDEPRECATED = msg.aLeadDEPRECATED;
    }
    else {
      resolved.aLeadDEPRECATED = 0.0
    }

    if (msg.dPath !== undefined) {
      resolved.dPath = msg.dPath;
    }
    else {
      resolved.dPath = 0.0
    }

    if (msg.vLat !== undefined) {
      resolved.vLat = msg.vLat;
    }
    else {
      resolved.vLat = 0.0
    }

    if (msg.vLeadK !== undefined) {
      resolved.vLeadK = msg.vLeadK;
    }
    else {
      resolved.vLeadK = 0.0
    }

    if (msg.aLeadK !== undefined) {
      resolved.aLeadK = msg.aLeadK;
    }
    else {
      resolved.aLeadK = 0.0
    }

    if (msg.fcw !== undefined) {
      resolved.fcw = msg.fcw;
    }
    else {
      resolved.fcw = false
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = false
    }

    if (msg.aLeadTau !== undefined) {
      resolved.aLeadTau = msg.aLeadTau;
    }
    else {
      resolved.aLeadTau = 0.0
    }

    if (msg.modelProb !== undefined) {
      resolved.modelProb = msg.modelProb;
    }
    else {
      resolved.modelProb = 0.0
    }

    if (msg.radar !== undefined) {
      resolved.radar = msg.radar;
    }
    else {
      resolved.radar = false
    }

    return resolved;
    }
};

module.exports = LeadData;
