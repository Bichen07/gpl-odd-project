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

class WifiScan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.is80211mcResponder = null;
      this.operatorFriendlyName = null;
      this.channelWidth = null;
      this.distanceSdCm = null;
      this.ssid = null;
      this.bssid = null;
      this.level = null;
      this.timestamp = null;
      this.capabilities = null;
      this.distanceCm = null;
      this.centerFreq0 = null;
      this.centerFreq1 = null;
      this.frequency = null;
      this.passpoint = null;
      this.venueName = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('is80211mcResponder')) {
        this.is80211mcResponder = initObj.is80211mcResponder
      }
      else {
        this.is80211mcResponder = false;
      }
      if (initObj.hasOwnProperty('operatorFriendlyName')) {
        this.operatorFriendlyName = initObj.operatorFriendlyName
      }
      else {
        this.operatorFriendlyName = [];
      }
      if (initObj.hasOwnProperty('channelWidth')) {
        this.channelWidth = initObj.channelWidth
      }
      else {
        this.channelWidth = 0;
      }
      if (initObj.hasOwnProperty('distanceSdCm')) {
        this.distanceSdCm = initObj.distanceSdCm
      }
      else {
        this.distanceSdCm = 0;
      }
      if (initObj.hasOwnProperty('ssid')) {
        this.ssid = initObj.ssid
      }
      else {
        this.ssid = [];
      }
      if (initObj.hasOwnProperty('bssid')) {
        this.bssid = initObj.bssid
      }
      else {
        this.bssid = [];
      }
      if (initObj.hasOwnProperty('level')) {
        this.level = initObj.level
      }
      else {
        this.level = 0;
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0;
      }
      if (initObj.hasOwnProperty('capabilities')) {
        this.capabilities = initObj.capabilities
      }
      else {
        this.capabilities = [];
      }
      if (initObj.hasOwnProperty('distanceCm')) {
        this.distanceCm = initObj.distanceCm
      }
      else {
        this.distanceCm = 0;
      }
      if (initObj.hasOwnProperty('centerFreq0')) {
        this.centerFreq0 = initObj.centerFreq0
      }
      else {
        this.centerFreq0 = 0;
      }
      if (initObj.hasOwnProperty('centerFreq1')) {
        this.centerFreq1 = initObj.centerFreq1
      }
      else {
        this.centerFreq1 = 0;
      }
      if (initObj.hasOwnProperty('frequency')) {
        this.frequency = initObj.frequency
      }
      else {
        this.frequency = 0;
      }
      if (initObj.hasOwnProperty('passpoint')) {
        this.passpoint = initObj.passpoint
      }
      else {
        this.passpoint = false;
      }
      if (initObj.hasOwnProperty('venueName')) {
        this.venueName = initObj.venueName
      }
      else {
        this.venueName = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WifiScan
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [is80211mcResponder]
    bufferOffset = _serializer.bool(obj.is80211mcResponder, buffer, bufferOffset);
    // Serialize message field [operatorFriendlyName]
    bufferOffset = _arraySerializer.string(obj.operatorFriendlyName, buffer, bufferOffset, null);
    // Serialize message field [channelWidth]
    bufferOffset = _serializer.uint32(obj.channelWidth, buffer, bufferOffset);
    // Serialize message field [distanceSdCm]
    bufferOffset = _serializer.int32(obj.distanceSdCm, buffer, bufferOffset);
    // Serialize message field [ssid]
    bufferOffset = _arraySerializer.string(obj.ssid, buffer, bufferOffset, null);
    // Serialize message field [bssid]
    bufferOffset = _arraySerializer.string(obj.bssid, buffer, bufferOffset, null);
    // Serialize message field [level]
    bufferOffset = _serializer.int32(obj.level, buffer, bufferOffset);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.int32(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [capabilities]
    bufferOffset = _arraySerializer.string(obj.capabilities, buffer, bufferOffset, null);
    // Serialize message field [distanceCm]
    bufferOffset = _serializer.int32(obj.distanceCm, buffer, bufferOffset);
    // Serialize message field [centerFreq0]
    bufferOffset = _serializer.int32(obj.centerFreq0, buffer, bufferOffset);
    // Serialize message field [centerFreq1]
    bufferOffset = _serializer.int32(obj.centerFreq1, buffer, bufferOffset);
    // Serialize message field [frequency]
    bufferOffset = _serializer.int32(obj.frequency, buffer, bufferOffset);
    // Serialize message field [passpoint]
    bufferOffset = _serializer.bool(obj.passpoint, buffer, bufferOffset);
    // Serialize message field [venueName]
    bufferOffset = _arraySerializer.string(obj.venueName, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WifiScan
    let len;
    let data = new WifiScan(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [is80211mcResponder]
    data.is80211mcResponder = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [operatorFriendlyName]
    data.operatorFriendlyName = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [channelWidth]
    data.channelWidth = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [distanceSdCm]
    data.distanceSdCm = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [ssid]
    data.ssid = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [bssid]
    data.bssid = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [level]
    data.level = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [capabilities]
    data.capabilities = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [distanceCm]
    data.distanceCm = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [centerFreq0]
    data.centerFreq0 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [centerFreq1]
    data.centerFreq1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [frequency]
    data.frequency = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [passpoint]
    data.passpoint = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [venueName]
    data.venueName = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.operatorFriendlyName.forEach((val) => {
      length += 4 + val.length;
    });
    object.ssid.forEach((val) => {
      length += 4 + val.length;
    });
    object.bssid.forEach((val) => {
      length += 4 + val.length;
    });
    object.capabilities.forEach((val) => {
      length += 4 + val.length;
    });
    object.venueName.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 54;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/WifiScan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6ba40279298cca39ad687f78eb902fd0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool is80211mcResponder
    string[] operatorFriendlyName
    uint32 channelWidth # enum const: ChannelWidth
    int32 distanceSdCm
    string[] ssid
    string[] bssid
    int32 level
    int32 timestamp
    string[] capabilities
    int32 distanceCm
    int32 centerFreq0
    int32 centerFreq1
    int32 frequency
    bool passpoint
    string[] venueName
    
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
    const resolved = new WifiScan(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.is80211mcResponder !== undefined) {
      resolved.is80211mcResponder = msg.is80211mcResponder;
    }
    else {
      resolved.is80211mcResponder = false
    }

    if (msg.operatorFriendlyName !== undefined) {
      resolved.operatorFriendlyName = msg.operatorFriendlyName;
    }
    else {
      resolved.operatorFriendlyName = []
    }

    if (msg.channelWidth !== undefined) {
      resolved.channelWidth = msg.channelWidth;
    }
    else {
      resolved.channelWidth = 0
    }

    if (msg.distanceSdCm !== undefined) {
      resolved.distanceSdCm = msg.distanceSdCm;
    }
    else {
      resolved.distanceSdCm = 0
    }

    if (msg.ssid !== undefined) {
      resolved.ssid = msg.ssid;
    }
    else {
      resolved.ssid = []
    }

    if (msg.bssid !== undefined) {
      resolved.bssid = msg.bssid;
    }
    else {
      resolved.bssid = []
    }

    if (msg.level !== undefined) {
      resolved.level = msg.level;
    }
    else {
      resolved.level = 0
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0
    }

    if (msg.capabilities !== undefined) {
      resolved.capabilities = msg.capabilities;
    }
    else {
      resolved.capabilities = []
    }

    if (msg.distanceCm !== undefined) {
      resolved.distanceCm = msg.distanceCm;
    }
    else {
      resolved.distanceCm = 0
    }

    if (msg.centerFreq0 !== undefined) {
      resolved.centerFreq0 = msg.centerFreq0;
    }
    else {
      resolved.centerFreq0 = 0
    }

    if (msg.centerFreq1 !== undefined) {
      resolved.centerFreq1 = msg.centerFreq1;
    }
    else {
      resolved.centerFreq1 = 0
    }

    if (msg.frequency !== undefined) {
      resolved.frequency = msg.frequency;
    }
    else {
      resolved.frequency = 0
    }

    if (msg.passpoint !== undefined) {
      resolved.passpoint = msg.passpoint;
    }
    else {
      resolved.passpoint = false
    }

    if (msg.venueName !== undefined) {
      resolved.venueName = msg.venueName;
    }
    else {
      resolved.venueName = []
    }

    return resolved;
    }
};

module.exports = WifiScan;
