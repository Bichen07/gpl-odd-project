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

class GpsLocationData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.bearing = null;
      this.vNED = null;
      this.timestamp = null;
      this.altitude = null;
      this.longitude = null;
      this.source = null;
      this.speedAccuracy = null;
      this.flags = null;
      this.latitude = null;
      this.bearingAccuracy = null;
      this.speed = null;
      this.verticalAccuracy = null;
      this.accuracy = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('bearing')) {
        this.bearing = initObj.bearing
      }
      else {
        this.bearing = 0.0;
      }
      if (initObj.hasOwnProperty('vNED')) {
        this.vNED = initObj.vNED
      }
      else {
        this.vNED = [];
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0;
      }
      if (initObj.hasOwnProperty('altitude')) {
        this.altitude = initObj.altitude
      }
      else {
        this.altitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
      if (initObj.hasOwnProperty('speedAccuracy')) {
        this.speedAccuracy = initObj.speedAccuracy
      }
      else {
        this.speedAccuracy = 0.0;
      }
      if (initObj.hasOwnProperty('flags')) {
        this.flags = initObj.flags
      }
      else {
        this.flags = 0;
      }
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('bearingAccuracy')) {
        this.bearingAccuracy = initObj.bearingAccuracy
      }
      else {
        this.bearingAccuracy = 0.0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('verticalAccuracy')) {
        this.verticalAccuracy = initObj.verticalAccuracy
      }
      else {
        this.verticalAccuracy = 0.0;
      }
      if (initObj.hasOwnProperty('accuracy')) {
        this.accuracy = initObj.accuracy
      }
      else {
        this.accuracy = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GpsLocationData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [bearing]
    bufferOffset = _serializer.float32(obj.bearing, buffer, bufferOffset);
    // Serialize message field [vNED]
    bufferOffset = _arraySerializer.float32(obj.vNED, buffer, bufferOffset, null);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.int32(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [altitude]
    bufferOffset = _serializer.float32(obj.altitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float32(obj.longitude, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.uint32(obj.source, buffer, bufferOffset);
    // Serialize message field [speedAccuracy]
    bufferOffset = _serializer.float32(obj.speedAccuracy, buffer, bufferOffset);
    // Serialize message field [flags]
    bufferOffset = _serializer.int64(obj.flags, buffer, bufferOffset);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float32(obj.latitude, buffer, bufferOffset);
    // Serialize message field [bearingAccuracy]
    bufferOffset = _serializer.float32(obj.bearingAccuracy, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [verticalAccuracy]
    bufferOffset = _serializer.float32(obj.verticalAccuracy, buffer, bufferOffset);
    // Serialize message field [accuracy]
    bufferOffset = _serializer.float32(obj.accuracy, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GpsLocationData
    let len;
    let data = new GpsLocationData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [bearing]
    data.bearing = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vNED]
    data.vNED = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [altitude]
    data.altitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [speedAccuracy]
    data.speedAccuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [flags]
    data.flags = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [bearingAccuracy]
    data.bearingAccuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [verticalAccuracy]
    data.verticalAccuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [accuracy]
    data.accuracy = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.vNED.length;
    return length + 56;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/GpsLocationData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4424f612bc9ad1e23801532f061abcb5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 bearing
    float32[] vNED
    int32 timestamp
    float32 altitude
    float32 longitude
    uint32 source # enum const: SensorSource
    float32 speedAccuracy
    int64 flags
    float32 latitude
    float32 bearingAccuracy
    float32 speed
    float32 verticalAccuracy
    float32 accuracy
    
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
    const resolved = new GpsLocationData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.bearing !== undefined) {
      resolved.bearing = msg.bearing;
    }
    else {
      resolved.bearing = 0.0
    }

    if (msg.vNED !== undefined) {
      resolved.vNED = msg.vNED;
    }
    else {
      resolved.vNED = []
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0
    }

    if (msg.altitude !== undefined) {
      resolved.altitude = msg.altitude;
    }
    else {
      resolved.altitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    if (msg.speedAccuracy !== undefined) {
      resolved.speedAccuracy = msg.speedAccuracy;
    }
    else {
      resolved.speedAccuracy = 0.0
    }

    if (msg.flags !== undefined) {
      resolved.flags = msg.flags;
    }
    else {
      resolved.flags = 0
    }

    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.bearingAccuracy !== undefined) {
      resolved.bearingAccuracy = msg.bearingAccuracy;
    }
    else {
      resolved.bearingAccuracy = 0.0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.verticalAccuracy !== undefined) {
      resolved.verticalAccuracy = msg.verticalAccuracy;
    }
    else {
      resolved.verticalAccuracy = 0.0
    }

    if (msg.accuracy !== undefined) {
      resolved.accuracy = msg.accuracy;
    }
    else {
      resolved.accuracy = 0.0
    }

    return resolved;
    }
};

module.exports = GpsLocationData;
