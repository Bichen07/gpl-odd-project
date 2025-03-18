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

class OrbObservation {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.matchDistance = null;
      this.locationECEF = null;
      this.normalizedCoordinates = null;
      this.observationMonoTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('matchDistance')) {
        this.matchDistance = initObj.matchDistance
      }
      else {
        this.matchDistance = 0;
      }
      if (initObj.hasOwnProperty('locationECEF')) {
        this.locationECEF = initObj.locationECEF
      }
      else {
        this.locationECEF = [];
      }
      if (initObj.hasOwnProperty('normalizedCoordinates')) {
        this.normalizedCoordinates = initObj.normalizedCoordinates
      }
      else {
        this.normalizedCoordinates = [];
      }
      if (initObj.hasOwnProperty('observationMonoTime')) {
        this.observationMonoTime = initObj.observationMonoTime
      }
      else {
        this.observationMonoTime = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbObservation
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [matchDistance]
    bufferOffset = _serializer.int64(obj.matchDistance, buffer, bufferOffset);
    // Serialize message field [locationECEF]
    bufferOffset = _arraySerializer.float32(obj.locationECEF, buffer, bufferOffset, null);
    // Serialize message field [normalizedCoordinates]
    bufferOffset = _arraySerializer.float32(obj.normalizedCoordinates, buffer, bufferOffset, null);
    // Serialize message field [observationMonoTime]
    bufferOffset = _serializer.int64(obj.observationMonoTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbObservation
    let len;
    let data = new OrbObservation(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [matchDistance]
    data.matchDistance = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [locationECEF]
    data.locationECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [normalizedCoordinates]
    data.normalizedCoordinates = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [observationMonoTime]
    data.observationMonoTime = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.locationECEF.length;
    length += 4 * object.normalizedCoordinates.length;
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbObservation';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6de73ce37ca42db3178ce06f49587a3a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 matchDistance
    float32[] locationECEF
    float32[] normalizedCoordinates
    int64 observationMonoTime
    
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
    const resolved = new OrbObservation(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.matchDistance !== undefined) {
      resolved.matchDistance = msg.matchDistance;
    }
    else {
      resolved.matchDistance = 0
    }

    if (msg.locationECEF !== undefined) {
      resolved.locationECEF = msg.locationECEF;
    }
    else {
      resolved.locationECEF = []
    }

    if (msg.normalizedCoordinates !== undefined) {
      resolved.normalizedCoordinates = msg.normalizedCoordinates;
    }
    else {
      resolved.normalizedCoordinates = []
    }

    if (msg.observationMonoTime !== undefined) {
      resolved.observationMonoTime = msg.observationMonoTime;
    }
    else {
      resolved.observationMonoTime = 0
    }

    return resolved;
    }
};

module.exports = OrbObservation;
