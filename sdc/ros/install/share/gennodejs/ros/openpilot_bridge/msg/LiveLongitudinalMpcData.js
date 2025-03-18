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

class LiveLongitudinalMpcData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.aLeadTau = null;
      this.vLead = null;
      this.aLead = null;
      this.xEgo = null;
      this.xLead = null;
      this.mpcId = null;
      this.cost = null;
      this.aEgo = null;
      this.calculationTime = null;
      this.qpIterations = null;
      this.vEgo = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('aLeadTau')) {
        this.aLeadTau = initObj.aLeadTau
      }
      else {
        this.aLeadTau = 0.0;
      }
      if (initObj.hasOwnProperty('vLead')) {
        this.vLead = initObj.vLead
      }
      else {
        this.vLead = [];
      }
      if (initObj.hasOwnProperty('aLead')) {
        this.aLead = initObj.aLead
      }
      else {
        this.aLead = [];
      }
      if (initObj.hasOwnProperty('xEgo')) {
        this.xEgo = initObj.xEgo
      }
      else {
        this.xEgo = [];
      }
      if (initObj.hasOwnProperty('xLead')) {
        this.xLead = initObj.xLead
      }
      else {
        this.xLead = [];
      }
      if (initObj.hasOwnProperty('mpcId')) {
        this.mpcId = initObj.mpcId
      }
      else {
        this.mpcId = 0;
      }
      if (initObj.hasOwnProperty('cost')) {
        this.cost = initObj.cost
      }
      else {
        this.cost = 0.0;
      }
      if (initObj.hasOwnProperty('aEgo')) {
        this.aEgo = initObj.aEgo
      }
      else {
        this.aEgo = [];
      }
      if (initObj.hasOwnProperty('calculationTime')) {
        this.calculationTime = initObj.calculationTime
      }
      else {
        this.calculationTime = 0;
      }
      if (initObj.hasOwnProperty('qpIterations')) {
        this.qpIterations = initObj.qpIterations
      }
      else {
        this.qpIterations = 0;
      }
      if (initObj.hasOwnProperty('vEgo')) {
        this.vEgo = initObj.vEgo
      }
      else {
        this.vEgo = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LiveLongitudinalMpcData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [aLeadTau]
    bufferOffset = _serializer.float32(obj.aLeadTau, buffer, bufferOffset);
    // Serialize message field [vLead]
    bufferOffset = _arraySerializer.float32(obj.vLead, buffer, bufferOffset, null);
    // Serialize message field [aLead]
    bufferOffset = _arraySerializer.float32(obj.aLead, buffer, bufferOffset, null);
    // Serialize message field [xEgo]
    bufferOffset = _arraySerializer.float32(obj.xEgo, buffer, bufferOffset, null);
    // Serialize message field [xLead]
    bufferOffset = _arraySerializer.float32(obj.xLead, buffer, bufferOffset, null);
    // Serialize message field [mpcId]
    bufferOffset = _serializer.int64(obj.mpcId, buffer, bufferOffset);
    // Serialize message field [cost]
    bufferOffset = _serializer.float32(obj.cost, buffer, bufferOffset);
    // Serialize message field [aEgo]
    bufferOffset = _arraySerializer.float32(obj.aEgo, buffer, bufferOffset, null);
    // Serialize message field [calculationTime]
    bufferOffset = _serializer.int64(obj.calculationTime, buffer, bufferOffset);
    // Serialize message field [qpIterations]
    bufferOffset = _serializer.int64(obj.qpIterations, buffer, bufferOffset);
    // Serialize message field [vEgo]
    bufferOffset = _arraySerializer.float32(obj.vEgo, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LiveLongitudinalMpcData
    let len;
    let data = new LiveLongitudinalMpcData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [aLeadTau]
    data.aLeadTau = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vLead]
    data.vLead = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [aLead]
    data.aLead = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [xEgo]
    data.xEgo = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [xLead]
    data.xLead = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [mpcId]
    data.mpcId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [cost]
    data.cost = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aEgo]
    data.aEgo = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [calculationTime]
    data.calculationTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [qpIterations]
    data.qpIterations = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [vEgo]
    data.vEgo = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.vLead.length;
    length += 4 * object.aLead.length;
    length += 4 * object.xEgo.length;
    length += 4 * object.xLead.length;
    length += 4 * object.aEgo.length;
    length += 4 * object.vEgo.length;
    return length + 56;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/LiveLongitudinalMpcData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4c7abc357e4c77b07789c23a2bc077f9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 aLeadTau
    float32[] vLead
    float32[] aLead
    float32[] xEgo
    float32[] xLead
    int64 mpcId
    float32 cost
    float32[] aEgo
    int64 calculationTime
    int64 qpIterations
    float32[] vEgo
    
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
    const resolved = new LiveLongitudinalMpcData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.aLeadTau !== undefined) {
      resolved.aLeadTau = msg.aLeadTau;
    }
    else {
      resolved.aLeadTau = 0.0
    }

    if (msg.vLead !== undefined) {
      resolved.vLead = msg.vLead;
    }
    else {
      resolved.vLead = []
    }

    if (msg.aLead !== undefined) {
      resolved.aLead = msg.aLead;
    }
    else {
      resolved.aLead = []
    }

    if (msg.xEgo !== undefined) {
      resolved.xEgo = msg.xEgo;
    }
    else {
      resolved.xEgo = []
    }

    if (msg.xLead !== undefined) {
      resolved.xLead = msg.xLead;
    }
    else {
      resolved.xLead = []
    }

    if (msg.mpcId !== undefined) {
      resolved.mpcId = msg.mpcId;
    }
    else {
      resolved.mpcId = 0
    }

    if (msg.cost !== undefined) {
      resolved.cost = msg.cost;
    }
    else {
      resolved.cost = 0.0
    }

    if (msg.aEgo !== undefined) {
      resolved.aEgo = msg.aEgo;
    }
    else {
      resolved.aEgo = []
    }

    if (msg.calculationTime !== undefined) {
      resolved.calculationTime = msg.calculationTime;
    }
    else {
      resolved.calculationTime = 0
    }

    if (msg.qpIterations !== undefined) {
      resolved.qpIterations = msg.qpIterations;
    }
    else {
      resolved.qpIterations = 0
    }

    if (msg.vEgo !== undefined) {
      resolved.vEgo = msg.vEgo;
    }
    else {
      resolved.vEgo = []
    }

    return resolved;
    }
};

module.exports = LiveLongitudinalMpcData;
