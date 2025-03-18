// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ChffrAndroidExtra = require('./ChffrAndroidExtra.js');
let Map = require('./Map.js');
let AndroidSensor = require('./AndroidSensor.js');
let PandaInfo = require('./PandaInfo.js');
let IosBuildInfo = require('./IosBuildInfo.js');
let AndroidBuildInfo = require('./AndroidBuildInfo.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class InitData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.kernelVersion = null;
      this.chffrAndroidExtra = null;
      this.androidProperties = null;
      this.androidSensors = null;
      this.pandaInfo = null;
      this.iosBuildInfo = null;
      this.gitRemote = null;
      this.androidBuildInfo = null;
      this.passive = null;
      this.params = null;
      this.version = null;
      this.deviceType = null;
      this.kernelArgs = null;
      this.gitCommit = null;
      this.gitBranch = null;
      this.dongleId = null;
      this.gctx = null;
      this.dirty = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('kernelVersion')) {
        this.kernelVersion = initObj.kernelVersion
      }
      else {
        this.kernelVersion = [];
      }
      if (initObj.hasOwnProperty('chffrAndroidExtra')) {
        this.chffrAndroidExtra = initObj.chffrAndroidExtra
      }
      else {
        this.chffrAndroidExtra = new ChffrAndroidExtra();
      }
      if (initObj.hasOwnProperty('androidProperties')) {
        this.androidProperties = initObj.androidProperties
      }
      else {
        this.androidProperties = new Map();
      }
      if (initObj.hasOwnProperty('androidSensors')) {
        this.androidSensors = initObj.androidSensors
      }
      else {
        this.androidSensors = [];
      }
      if (initObj.hasOwnProperty('pandaInfo')) {
        this.pandaInfo = initObj.pandaInfo
      }
      else {
        this.pandaInfo = new PandaInfo();
      }
      if (initObj.hasOwnProperty('iosBuildInfo')) {
        this.iosBuildInfo = initObj.iosBuildInfo
      }
      else {
        this.iosBuildInfo = new IosBuildInfo();
      }
      if (initObj.hasOwnProperty('gitRemote')) {
        this.gitRemote = initObj.gitRemote
      }
      else {
        this.gitRemote = [];
      }
      if (initObj.hasOwnProperty('androidBuildInfo')) {
        this.androidBuildInfo = initObj.androidBuildInfo
      }
      else {
        this.androidBuildInfo = new AndroidBuildInfo();
      }
      if (initObj.hasOwnProperty('passive')) {
        this.passive = initObj.passive
      }
      else {
        this.passive = false;
      }
      if (initObj.hasOwnProperty('params')) {
        this.params = initObj.params
      }
      else {
        this.params = new Map();
      }
      if (initObj.hasOwnProperty('version')) {
        this.version = initObj.version
      }
      else {
        this.version = [];
      }
      if (initObj.hasOwnProperty('deviceType')) {
        this.deviceType = initObj.deviceType
      }
      else {
        this.deviceType = 0;
      }
      if (initObj.hasOwnProperty('kernelArgs')) {
        this.kernelArgs = initObj.kernelArgs
      }
      else {
        this.kernelArgs = [];
      }
      if (initObj.hasOwnProperty('gitCommit')) {
        this.gitCommit = initObj.gitCommit
      }
      else {
        this.gitCommit = [];
      }
      if (initObj.hasOwnProperty('gitBranch')) {
        this.gitBranch = initObj.gitBranch
      }
      else {
        this.gitBranch = [];
      }
      if (initObj.hasOwnProperty('dongleId')) {
        this.dongleId = initObj.dongleId
      }
      else {
        this.dongleId = [];
      }
      if (initObj.hasOwnProperty('gctx')) {
        this.gctx = initObj.gctx
      }
      else {
        this.gctx = [];
      }
      if (initObj.hasOwnProperty('dirty')) {
        this.dirty = initObj.dirty
      }
      else {
        this.dirty = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type InitData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [kernelVersion]
    bufferOffset = _arraySerializer.string(obj.kernelVersion, buffer, bufferOffset, null);
    // Serialize message field [chffrAndroidExtra]
    bufferOffset = ChffrAndroidExtra.serialize(obj.chffrAndroidExtra, buffer, bufferOffset);
    // Serialize message field [androidProperties]
    bufferOffset = Map.serialize(obj.androidProperties, buffer, bufferOffset);
    // Serialize message field [androidSensors]
    // Serialize the length for message field [androidSensors]
    bufferOffset = _serializer.uint32(obj.androidSensors.length, buffer, bufferOffset);
    obj.androidSensors.forEach((val) => {
      bufferOffset = AndroidSensor.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [pandaInfo]
    bufferOffset = PandaInfo.serialize(obj.pandaInfo, buffer, bufferOffset);
    // Serialize message field [iosBuildInfo]
    bufferOffset = IosBuildInfo.serialize(obj.iosBuildInfo, buffer, bufferOffset);
    // Serialize message field [gitRemote]
    bufferOffset = _arraySerializer.string(obj.gitRemote, buffer, bufferOffset, null);
    // Serialize message field [androidBuildInfo]
    bufferOffset = AndroidBuildInfo.serialize(obj.androidBuildInfo, buffer, bufferOffset);
    // Serialize message field [passive]
    bufferOffset = _serializer.bool(obj.passive, buffer, bufferOffset);
    // Serialize message field [params]
    bufferOffset = Map.serialize(obj.params, buffer, bufferOffset);
    // Serialize message field [version]
    bufferOffset = _arraySerializer.string(obj.version, buffer, bufferOffset, null);
    // Serialize message field [deviceType]
    bufferOffset = _serializer.uint32(obj.deviceType, buffer, bufferOffset);
    // Serialize message field [kernelArgs]
    bufferOffset = _arraySerializer.string(obj.kernelArgs, buffer, bufferOffset, null);
    // Serialize message field [gitCommit]
    bufferOffset = _arraySerializer.string(obj.gitCommit, buffer, bufferOffset, null);
    // Serialize message field [gitBranch]
    bufferOffset = _arraySerializer.string(obj.gitBranch, buffer, bufferOffset, null);
    // Serialize message field [dongleId]
    bufferOffset = _arraySerializer.string(obj.dongleId, buffer, bufferOffset, null);
    // Serialize message field [gctx]
    bufferOffset = _arraySerializer.string(obj.gctx, buffer, bufferOffset, null);
    // Serialize message field [dirty]
    bufferOffset = _serializer.bool(obj.dirty, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type InitData
    let len;
    let data = new InitData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [kernelVersion]
    data.kernelVersion = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [chffrAndroidExtra]
    data.chffrAndroidExtra = ChffrAndroidExtra.deserialize(buffer, bufferOffset);
    // Deserialize message field [androidProperties]
    data.androidProperties = Map.deserialize(buffer, bufferOffset);
    // Deserialize message field [androidSensors]
    // Deserialize array length for message field [androidSensors]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.androidSensors = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.androidSensors[i] = AndroidSensor.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [pandaInfo]
    data.pandaInfo = PandaInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [iosBuildInfo]
    data.iosBuildInfo = IosBuildInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [gitRemote]
    data.gitRemote = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [androidBuildInfo]
    data.androidBuildInfo = AndroidBuildInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [passive]
    data.passive = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [params]
    data.params = Map.deserialize(buffer, bufferOffset);
    // Deserialize message field [version]
    data.version = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [deviceType]
    data.deviceType = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [kernelArgs]
    data.kernelArgs = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [gitCommit]
    data.gitCommit = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [gitBranch]
    data.gitBranch = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [dongleId]
    data.dongleId = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [gctx]
    data.gctx = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [dirty]
    data.dirty = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.kernelVersion.forEach((val) => {
      length += 4 + val.length;
    });
    length += ChffrAndroidExtra.getMessageSize(object.chffrAndroidExtra);
    length += Map.getMessageSize(object.androidProperties);
    object.androidSensors.forEach((val) => {
      length += AndroidSensor.getMessageSize(val);
    });
    length += PandaInfo.getMessageSize(object.pandaInfo);
    length += IosBuildInfo.getMessageSize(object.iosBuildInfo);
    object.gitRemote.forEach((val) => {
      length += 4 + val.length;
    });
    length += AndroidBuildInfo.getMessageSize(object.androidBuildInfo);
    length += Map.getMessageSize(object.params);
    object.version.forEach((val) => {
      length += 4 + val.length;
    });
    object.kernelArgs.forEach((val) => {
      length += 4 + val.length;
    });
    object.gitCommit.forEach((val) => {
      length += 4 + val.length;
    });
    object.gitBranch.forEach((val) => {
      length += 4 + val.length;
    });
    object.dongleId.forEach((val) => {
      length += 4 + val.length;
    });
    object.gctx.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 42;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/InitData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '76faf0d786e446ea0c4375f81f315e00';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    string[] kernelVersion
    ChffrAndroidExtra chffrAndroidExtra
    Map androidProperties
    AndroidSensor[] androidSensors
    PandaInfo pandaInfo
    IosBuildInfo iosBuildInfo
    string[] gitRemote
    AndroidBuildInfo androidBuildInfo
    bool passive
    Map params
    string[] version
    uint32 deviceType # enum const: DeviceType
    string[] kernelArgs
    string[] gitCommit
    string[] gitBranch
    string[] dongleId
    string[] gctx
    bool dirty
    
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
    MSG: openpilot_bridge/ChffrAndroidExtra
    Header header
    
    Map allCameraCharacteristics
    
    ================================================================================
    MSG: openpilot_bridge/Map
    Header header
    
    Entry[] entries
    
    ================================================================================
    MSG: openpilot_bridge/Entry
    Header header
    
    string value
    string key
    
    ================================================================================
    MSG: openpilot_bridge/AndroidSensor
    Header header
    
    float32 maxRange
    string[] stringType
    int32 maxDelay
    int32 handle
    string[] name
    float32 power
    int32 minDelay
    float32 resolution
    int64 fifoMaxEventCount
    int32 version
    int64 fifoReservedEventCount
    string[] vendor
    int32 type
    int32 id
    
    ================================================================================
    MSG: openpilot_bridge/PandaInfo
    Header header
    
    bool hasPanda
    string[] stVersion
    string[] dongleId
    string[] espVersion
    
    ================================================================================
    MSG: openpilot_bridge/IosBuildInfo
    Header header
    
    int64 appBuild
    string[] appVersion
    string[] osVersion
    string[] deviceModel
    
    ================================================================================
    MSG: openpilot_bridge/AndroidBuildInfo
    Header header
    
    string[] radioVersion
    string[] versionCodename
    string[] hardware
    string[] versionSecurityPatch
    string[] supportedAbis
    string[] id
    string[] board
    string[] type
    string[] product
    string[] tags
    string[] brand
    string[] host
    string[] user
    string[] fingerprint
    string[] device
    string[] bootloader
    string[] model
    string[] serial
    string[] manufacturer
    string[] versionRelease
    int32 time
    int32 versionSdk
    string[] display
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new InitData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.kernelVersion !== undefined) {
      resolved.kernelVersion = msg.kernelVersion;
    }
    else {
      resolved.kernelVersion = []
    }

    if (msg.chffrAndroidExtra !== undefined) {
      resolved.chffrAndroidExtra = ChffrAndroidExtra.Resolve(msg.chffrAndroidExtra)
    }
    else {
      resolved.chffrAndroidExtra = new ChffrAndroidExtra()
    }

    if (msg.androidProperties !== undefined) {
      resolved.androidProperties = Map.Resolve(msg.androidProperties)
    }
    else {
      resolved.androidProperties = new Map()
    }

    if (msg.androidSensors !== undefined) {
      resolved.androidSensors = new Array(msg.androidSensors.length);
      for (let i = 0; i < resolved.androidSensors.length; ++i) {
        resolved.androidSensors[i] = AndroidSensor.Resolve(msg.androidSensors[i]);
      }
    }
    else {
      resolved.androidSensors = []
    }

    if (msg.pandaInfo !== undefined) {
      resolved.pandaInfo = PandaInfo.Resolve(msg.pandaInfo)
    }
    else {
      resolved.pandaInfo = new PandaInfo()
    }

    if (msg.iosBuildInfo !== undefined) {
      resolved.iosBuildInfo = IosBuildInfo.Resolve(msg.iosBuildInfo)
    }
    else {
      resolved.iosBuildInfo = new IosBuildInfo()
    }

    if (msg.gitRemote !== undefined) {
      resolved.gitRemote = msg.gitRemote;
    }
    else {
      resolved.gitRemote = []
    }

    if (msg.androidBuildInfo !== undefined) {
      resolved.androidBuildInfo = AndroidBuildInfo.Resolve(msg.androidBuildInfo)
    }
    else {
      resolved.androidBuildInfo = new AndroidBuildInfo()
    }

    if (msg.passive !== undefined) {
      resolved.passive = msg.passive;
    }
    else {
      resolved.passive = false
    }

    if (msg.params !== undefined) {
      resolved.params = Map.Resolve(msg.params)
    }
    else {
      resolved.params = new Map()
    }

    if (msg.version !== undefined) {
      resolved.version = msg.version;
    }
    else {
      resolved.version = []
    }

    if (msg.deviceType !== undefined) {
      resolved.deviceType = msg.deviceType;
    }
    else {
      resolved.deviceType = 0
    }

    if (msg.kernelArgs !== undefined) {
      resolved.kernelArgs = msg.kernelArgs;
    }
    else {
      resolved.kernelArgs = []
    }

    if (msg.gitCommit !== undefined) {
      resolved.gitCommit = msg.gitCommit;
    }
    else {
      resolved.gitCommit = []
    }

    if (msg.gitBranch !== undefined) {
      resolved.gitBranch = msg.gitBranch;
    }
    else {
      resolved.gitBranch = []
    }

    if (msg.dongleId !== undefined) {
      resolved.dongleId = msg.dongleId;
    }
    else {
      resolved.dongleId = []
    }

    if (msg.gctx !== undefined) {
      resolved.gctx = msg.gctx;
    }
    else {
      resolved.gctx = []
    }

    if (msg.dirty !== undefined) {
      resolved.dirty = msg.dirty;
    }
    else {
      resolved.dirty = false
    }

    return resolved;
    }
};

module.exports = InitData;
