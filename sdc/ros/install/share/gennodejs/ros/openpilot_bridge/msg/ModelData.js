// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LongitudinalData = require('./LongitudinalData.js');
let LeadData = require('./LeadData.js');
let ModelSettings = require('./ModelSettings.js');
let PathData = require('./PathData.js');
let MetaData = require('./MetaData.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ModelData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.longitudinal = null;
      this.leadFuture = null;
      this.lead = null;
      this.settings = null;
      this.leftLane = null;
      this.timestampEof = null;
      this.frameId = null;
      this.rightLane = null;
      this.meta = null;
      this.path = null;
      this.speed = null;
      this.freePath = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('longitudinal')) {
        this.longitudinal = initObj.longitudinal
      }
      else {
        this.longitudinal = new LongitudinalData();
      }
      if (initObj.hasOwnProperty('leadFuture')) {
        this.leadFuture = initObj.leadFuture
      }
      else {
        this.leadFuture = new LeadData();
      }
      if (initObj.hasOwnProperty('lead')) {
        this.lead = initObj.lead
      }
      else {
        this.lead = new LeadData();
      }
      if (initObj.hasOwnProperty('settings')) {
        this.settings = initObj.settings
      }
      else {
        this.settings = new ModelSettings();
      }
      if (initObj.hasOwnProperty('leftLane')) {
        this.leftLane = initObj.leftLane
      }
      else {
        this.leftLane = new PathData();
      }
      if (initObj.hasOwnProperty('timestampEof')) {
        this.timestampEof = initObj.timestampEof
      }
      else {
        this.timestampEof = 0;
      }
      if (initObj.hasOwnProperty('frameId')) {
        this.frameId = initObj.frameId
      }
      else {
        this.frameId = 0;
      }
      if (initObj.hasOwnProperty('rightLane')) {
        this.rightLane = initObj.rightLane
      }
      else {
        this.rightLane = new PathData();
      }
      if (initObj.hasOwnProperty('meta')) {
        this.meta = initObj.meta
      }
      else {
        this.meta = new MetaData();
      }
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = new PathData();
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = [];
      }
      if (initObj.hasOwnProperty('freePath')) {
        this.freePath = initObj.freePath
      }
      else {
        this.freePath = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ModelData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [longitudinal]
    bufferOffset = LongitudinalData.serialize(obj.longitudinal, buffer, bufferOffset);
    // Serialize message field [leadFuture]
    bufferOffset = LeadData.serialize(obj.leadFuture, buffer, bufferOffset);
    // Serialize message field [lead]
    bufferOffset = LeadData.serialize(obj.lead, buffer, bufferOffset);
    // Serialize message field [settings]
    bufferOffset = ModelSettings.serialize(obj.settings, buffer, bufferOffset);
    // Serialize message field [leftLane]
    bufferOffset = PathData.serialize(obj.leftLane, buffer, bufferOffset);
    // Serialize message field [timestampEof]
    bufferOffset = _serializer.int64(obj.timestampEof, buffer, bufferOffset);
    // Serialize message field [frameId]
    bufferOffset = _serializer.int64(obj.frameId, buffer, bufferOffset);
    // Serialize message field [rightLane]
    bufferOffset = PathData.serialize(obj.rightLane, buffer, bufferOffset);
    // Serialize message field [meta]
    bufferOffset = MetaData.serialize(obj.meta, buffer, bufferOffset);
    // Serialize message field [path]
    bufferOffset = PathData.serialize(obj.path, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _arraySerializer.float32(obj.speed, buffer, bufferOffset, null);
    // Serialize message field [freePath]
    bufferOffset = _arraySerializer.float32(obj.freePath, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ModelData
    let len;
    let data = new ModelData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [longitudinal]
    data.longitudinal = LongitudinalData.deserialize(buffer, bufferOffset);
    // Deserialize message field [leadFuture]
    data.leadFuture = LeadData.deserialize(buffer, bufferOffset);
    // Deserialize message field [lead]
    data.lead = LeadData.deserialize(buffer, bufferOffset);
    // Deserialize message field [settings]
    data.settings = ModelSettings.deserialize(buffer, bufferOffset);
    // Deserialize message field [leftLane]
    data.leftLane = PathData.deserialize(buffer, bufferOffset);
    // Deserialize message field [timestampEof]
    data.timestampEof = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [frameId]
    data.frameId = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [rightLane]
    data.rightLane = PathData.deserialize(buffer, bufferOffset);
    // Deserialize message field [meta]
    data.meta = MetaData.deserialize(buffer, bufferOffset);
    // Deserialize message field [path]
    data.path = PathData.deserialize(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [freePath]
    data.freePath = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += LongitudinalData.getMessageSize(object.longitudinal);
    length += LeadData.getMessageSize(object.leadFuture);
    length += LeadData.getMessageSize(object.lead);
    length += ModelSettings.getMessageSize(object.settings);
    length += PathData.getMessageSize(object.leftLane);
    length += PathData.getMessageSize(object.rightLane);
    length += MetaData.getMessageSize(object.meta);
    length += PathData.getMessageSize(object.path);
    length += 4 * object.speed.length;
    length += 4 * object.freePath.length;
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ModelData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9f8b0d877672d1e2fbed816c428d4d5c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    LongitudinalData longitudinal
    LeadData leadFuture
    LeadData lead
    ModelSettings settings
    PathData leftLane
    int64 timestampEof
    int64 frameId
    PathData rightLane
    MetaData meta
    PathData path
    float32[] speed
    float32[] freePath
    
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
    MSG: openpilot_bridge/LongitudinalData
    Header header
    
    float32[] accelerations
    float32[] speeds
    
    ================================================================================
    MSG: openpilot_bridge/LeadData
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
    MSG: openpilot_bridge/ModelSettings
    Header header
    
    int64 bigBoxX
    int64 bigBoxY
    float32[] inputTransform
    int64 bigBoxHeight
    int64 bigBoxWidth
    float32[] boxProjection
    float32[] yuvCorrection
    
    ================================================================================
    MSG: openpilot_bridge/PathData
    Header header
    
    float32 std
    float32[] poly
    float32[] points
    float32 prob
    float32[] stds
    
    ================================================================================
    MSG: openpilot_bridge/MetaData
    Header header
    
    float32 gasDisengageProb
    float32 brakeDisengageProb
    float32 steerOverrideProb
    float32 engagedProb
    float32[] desirePrediction
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ModelData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.longitudinal !== undefined) {
      resolved.longitudinal = LongitudinalData.Resolve(msg.longitudinal)
    }
    else {
      resolved.longitudinal = new LongitudinalData()
    }

    if (msg.leadFuture !== undefined) {
      resolved.leadFuture = LeadData.Resolve(msg.leadFuture)
    }
    else {
      resolved.leadFuture = new LeadData()
    }

    if (msg.lead !== undefined) {
      resolved.lead = LeadData.Resolve(msg.lead)
    }
    else {
      resolved.lead = new LeadData()
    }

    if (msg.settings !== undefined) {
      resolved.settings = ModelSettings.Resolve(msg.settings)
    }
    else {
      resolved.settings = new ModelSettings()
    }

    if (msg.leftLane !== undefined) {
      resolved.leftLane = PathData.Resolve(msg.leftLane)
    }
    else {
      resolved.leftLane = new PathData()
    }

    if (msg.timestampEof !== undefined) {
      resolved.timestampEof = msg.timestampEof;
    }
    else {
      resolved.timestampEof = 0
    }

    if (msg.frameId !== undefined) {
      resolved.frameId = msg.frameId;
    }
    else {
      resolved.frameId = 0
    }

    if (msg.rightLane !== undefined) {
      resolved.rightLane = PathData.Resolve(msg.rightLane)
    }
    else {
      resolved.rightLane = new PathData()
    }

    if (msg.meta !== undefined) {
      resolved.meta = MetaData.Resolve(msg.meta)
    }
    else {
      resolved.meta = new MetaData()
    }

    if (msg.path !== undefined) {
      resolved.path = PathData.Resolve(msg.path)
    }
    else {
      resolved.path = new PathData()
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = []
    }

    if (msg.freePath !== undefined) {
      resolved.freePath = msg.freePath;
    }
    else {
      resolved.freePath = []
    }

    return resolved;
    }
};

module.exports = ModelData;
