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

class AndroidBuildInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.radioVersion = null;
      this.versionCodename = null;
      this.hardware = null;
      this.versionSecurityPatch = null;
      this.supportedAbis = null;
      this.id = null;
      this.board = null;
      this.type = null;
      this.product = null;
      this.tags = null;
      this.brand = null;
      this.host = null;
      this.user = null;
      this.fingerprint = null;
      this.device = null;
      this.bootloader = null;
      this.model = null;
      this.serial = null;
      this.manufacturer = null;
      this.versionRelease = null;
      this.time = null;
      this.versionSdk = null;
      this.display = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('radioVersion')) {
        this.radioVersion = initObj.radioVersion
      }
      else {
        this.radioVersion = [];
      }
      if (initObj.hasOwnProperty('versionCodename')) {
        this.versionCodename = initObj.versionCodename
      }
      else {
        this.versionCodename = [];
      }
      if (initObj.hasOwnProperty('hardware')) {
        this.hardware = initObj.hardware
      }
      else {
        this.hardware = [];
      }
      if (initObj.hasOwnProperty('versionSecurityPatch')) {
        this.versionSecurityPatch = initObj.versionSecurityPatch
      }
      else {
        this.versionSecurityPatch = [];
      }
      if (initObj.hasOwnProperty('supportedAbis')) {
        this.supportedAbis = initObj.supportedAbis
      }
      else {
        this.supportedAbis = [];
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = [];
      }
      if (initObj.hasOwnProperty('board')) {
        this.board = initObj.board
      }
      else {
        this.board = [];
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = [];
      }
      if (initObj.hasOwnProperty('product')) {
        this.product = initObj.product
      }
      else {
        this.product = [];
      }
      if (initObj.hasOwnProperty('tags')) {
        this.tags = initObj.tags
      }
      else {
        this.tags = [];
      }
      if (initObj.hasOwnProperty('brand')) {
        this.brand = initObj.brand
      }
      else {
        this.brand = [];
      }
      if (initObj.hasOwnProperty('host')) {
        this.host = initObj.host
      }
      else {
        this.host = [];
      }
      if (initObj.hasOwnProperty('user')) {
        this.user = initObj.user
      }
      else {
        this.user = [];
      }
      if (initObj.hasOwnProperty('fingerprint')) {
        this.fingerprint = initObj.fingerprint
      }
      else {
        this.fingerprint = [];
      }
      if (initObj.hasOwnProperty('device')) {
        this.device = initObj.device
      }
      else {
        this.device = [];
      }
      if (initObj.hasOwnProperty('bootloader')) {
        this.bootloader = initObj.bootloader
      }
      else {
        this.bootloader = [];
      }
      if (initObj.hasOwnProperty('model')) {
        this.model = initObj.model
      }
      else {
        this.model = [];
      }
      if (initObj.hasOwnProperty('serial')) {
        this.serial = initObj.serial
      }
      else {
        this.serial = [];
      }
      if (initObj.hasOwnProperty('manufacturer')) {
        this.manufacturer = initObj.manufacturer
      }
      else {
        this.manufacturer = [];
      }
      if (initObj.hasOwnProperty('versionRelease')) {
        this.versionRelease = initObj.versionRelease
      }
      else {
        this.versionRelease = [];
      }
      if (initObj.hasOwnProperty('time')) {
        this.time = initObj.time
      }
      else {
        this.time = 0;
      }
      if (initObj.hasOwnProperty('versionSdk')) {
        this.versionSdk = initObj.versionSdk
      }
      else {
        this.versionSdk = 0;
      }
      if (initObj.hasOwnProperty('display')) {
        this.display = initObj.display
      }
      else {
        this.display = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AndroidBuildInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [radioVersion]
    bufferOffset = _arraySerializer.string(obj.radioVersion, buffer, bufferOffset, null);
    // Serialize message field [versionCodename]
    bufferOffset = _arraySerializer.string(obj.versionCodename, buffer, bufferOffset, null);
    // Serialize message field [hardware]
    bufferOffset = _arraySerializer.string(obj.hardware, buffer, bufferOffset, null);
    // Serialize message field [versionSecurityPatch]
    bufferOffset = _arraySerializer.string(obj.versionSecurityPatch, buffer, bufferOffset, null);
    // Serialize message field [supportedAbis]
    bufferOffset = _arraySerializer.string(obj.supportedAbis, buffer, bufferOffset, null);
    // Serialize message field [id]
    bufferOffset = _arraySerializer.string(obj.id, buffer, bufferOffset, null);
    // Serialize message field [board]
    bufferOffset = _arraySerializer.string(obj.board, buffer, bufferOffset, null);
    // Serialize message field [type]
    bufferOffset = _arraySerializer.string(obj.type, buffer, bufferOffset, null);
    // Serialize message field [product]
    bufferOffset = _arraySerializer.string(obj.product, buffer, bufferOffset, null);
    // Serialize message field [tags]
    bufferOffset = _arraySerializer.string(obj.tags, buffer, bufferOffset, null);
    // Serialize message field [brand]
    bufferOffset = _arraySerializer.string(obj.brand, buffer, bufferOffset, null);
    // Serialize message field [host]
    bufferOffset = _arraySerializer.string(obj.host, buffer, bufferOffset, null);
    // Serialize message field [user]
    bufferOffset = _arraySerializer.string(obj.user, buffer, bufferOffset, null);
    // Serialize message field [fingerprint]
    bufferOffset = _arraySerializer.string(obj.fingerprint, buffer, bufferOffset, null);
    // Serialize message field [device]
    bufferOffset = _arraySerializer.string(obj.device, buffer, bufferOffset, null);
    // Serialize message field [bootloader]
    bufferOffset = _arraySerializer.string(obj.bootloader, buffer, bufferOffset, null);
    // Serialize message field [model]
    bufferOffset = _arraySerializer.string(obj.model, buffer, bufferOffset, null);
    // Serialize message field [serial]
    bufferOffset = _arraySerializer.string(obj.serial, buffer, bufferOffset, null);
    // Serialize message field [manufacturer]
    bufferOffset = _arraySerializer.string(obj.manufacturer, buffer, bufferOffset, null);
    // Serialize message field [versionRelease]
    bufferOffset = _arraySerializer.string(obj.versionRelease, buffer, bufferOffset, null);
    // Serialize message field [time]
    bufferOffset = _serializer.int32(obj.time, buffer, bufferOffset);
    // Serialize message field [versionSdk]
    bufferOffset = _serializer.int32(obj.versionSdk, buffer, bufferOffset);
    // Serialize message field [display]
    bufferOffset = _arraySerializer.string(obj.display, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AndroidBuildInfo
    let len;
    let data = new AndroidBuildInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [radioVersion]
    data.radioVersion = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [versionCodename]
    data.versionCodename = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [hardware]
    data.hardware = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [versionSecurityPatch]
    data.versionSecurityPatch = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [supportedAbis]
    data.supportedAbis = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [id]
    data.id = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [board]
    data.board = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [type]
    data.type = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [product]
    data.product = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [tags]
    data.tags = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [brand]
    data.brand = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [host]
    data.host = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [user]
    data.user = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [fingerprint]
    data.fingerprint = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [device]
    data.device = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [bootloader]
    data.bootloader = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [model]
    data.model = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [serial]
    data.serial = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [manufacturer]
    data.manufacturer = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [versionRelease]
    data.versionRelease = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [time]
    data.time = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [versionSdk]
    data.versionSdk = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [display]
    data.display = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.radioVersion.forEach((val) => {
      length += 4 + val.length;
    });
    object.versionCodename.forEach((val) => {
      length += 4 + val.length;
    });
    object.hardware.forEach((val) => {
      length += 4 + val.length;
    });
    object.versionSecurityPatch.forEach((val) => {
      length += 4 + val.length;
    });
    object.supportedAbis.forEach((val) => {
      length += 4 + val.length;
    });
    object.id.forEach((val) => {
      length += 4 + val.length;
    });
    object.board.forEach((val) => {
      length += 4 + val.length;
    });
    object.type.forEach((val) => {
      length += 4 + val.length;
    });
    object.product.forEach((val) => {
      length += 4 + val.length;
    });
    object.tags.forEach((val) => {
      length += 4 + val.length;
    });
    object.brand.forEach((val) => {
      length += 4 + val.length;
    });
    object.host.forEach((val) => {
      length += 4 + val.length;
    });
    object.user.forEach((val) => {
      length += 4 + val.length;
    });
    object.fingerprint.forEach((val) => {
      length += 4 + val.length;
    });
    object.device.forEach((val) => {
      length += 4 + val.length;
    });
    object.bootloader.forEach((val) => {
      length += 4 + val.length;
    });
    object.model.forEach((val) => {
      length += 4 + val.length;
    });
    object.serial.forEach((val) => {
      length += 4 + val.length;
    });
    object.manufacturer.forEach((val) => {
      length += 4 + val.length;
    });
    object.versionRelease.forEach((val) => {
      length += 4 + val.length;
    });
    object.display.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 92;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AndroidBuildInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4c98358a2334b0eb124ac03cd7ebfa27';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new AndroidBuildInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.radioVersion !== undefined) {
      resolved.radioVersion = msg.radioVersion;
    }
    else {
      resolved.radioVersion = []
    }

    if (msg.versionCodename !== undefined) {
      resolved.versionCodename = msg.versionCodename;
    }
    else {
      resolved.versionCodename = []
    }

    if (msg.hardware !== undefined) {
      resolved.hardware = msg.hardware;
    }
    else {
      resolved.hardware = []
    }

    if (msg.versionSecurityPatch !== undefined) {
      resolved.versionSecurityPatch = msg.versionSecurityPatch;
    }
    else {
      resolved.versionSecurityPatch = []
    }

    if (msg.supportedAbis !== undefined) {
      resolved.supportedAbis = msg.supportedAbis;
    }
    else {
      resolved.supportedAbis = []
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = []
    }

    if (msg.board !== undefined) {
      resolved.board = msg.board;
    }
    else {
      resolved.board = []
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = []
    }

    if (msg.product !== undefined) {
      resolved.product = msg.product;
    }
    else {
      resolved.product = []
    }

    if (msg.tags !== undefined) {
      resolved.tags = msg.tags;
    }
    else {
      resolved.tags = []
    }

    if (msg.brand !== undefined) {
      resolved.brand = msg.brand;
    }
    else {
      resolved.brand = []
    }

    if (msg.host !== undefined) {
      resolved.host = msg.host;
    }
    else {
      resolved.host = []
    }

    if (msg.user !== undefined) {
      resolved.user = msg.user;
    }
    else {
      resolved.user = []
    }

    if (msg.fingerprint !== undefined) {
      resolved.fingerprint = msg.fingerprint;
    }
    else {
      resolved.fingerprint = []
    }

    if (msg.device !== undefined) {
      resolved.device = msg.device;
    }
    else {
      resolved.device = []
    }

    if (msg.bootloader !== undefined) {
      resolved.bootloader = msg.bootloader;
    }
    else {
      resolved.bootloader = []
    }

    if (msg.model !== undefined) {
      resolved.model = msg.model;
    }
    else {
      resolved.model = []
    }

    if (msg.serial !== undefined) {
      resolved.serial = msg.serial;
    }
    else {
      resolved.serial = []
    }

    if (msg.manufacturer !== undefined) {
      resolved.manufacturer = msg.manufacturer;
    }
    else {
      resolved.manufacturer = []
    }

    if (msg.versionRelease !== undefined) {
      resolved.versionRelease = msg.versionRelease;
    }
    else {
      resolved.versionRelease = []
    }

    if (msg.time !== undefined) {
      resolved.time = msg.time;
    }
    else {
      resolved.time = 0
    }

    if (msg.versionSdk !== undefined) {
      resolved.versionSdk = msg.versionSdk;
    }
    else {
      resolved.versionSdk = 0
    }

    if (msg.display !== undefined) {
      resolved.display = msg.display;
    }
    else {
      resolved.display = []
    }

    return resolved;
    }
};

module.exports = AndroidBuildInfo;
