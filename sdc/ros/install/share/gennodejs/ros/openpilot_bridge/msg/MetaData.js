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

class MetaData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gasDisengageProb = null;
      this.brakeDisengageProb = null;
      this.steerOverrideProb = null;
      this.engagedProb = null;
      this.desirePrediction = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gasDisengageProb')) {
        this.gasDisengageProb = initObj.gasDisengageProb
      }
      else {
        this.gasDisengageProb = 0.0;
      }
      if (initObj.hasOwnProperty('brakeDisengageProb')) {
        this.brakeDisengageProb = initObj.brakeDisengageProb
      }
      else {
        this.brakeDisengageProb = 0.0;
      }
      if (initObj.hasOwnProperty('steerOverrideProb')) {
        this.steerOverrideProb = initObj.steerOverrideProb
      }
      else {
        this.steerOverrideProb = 0.0;
      }
      if (initObj.hasOwnProperty('engagedProb')) {
        this.engagedProb = initObj.engagedProb
      }
      else {
        this.engagedProb = 0.0;
      }
      if (initObj.hasOwnProperty('desirePrediction')) {
        this.desirePrediction = initObj.desirePrediction
      }
      else {
        this.desirePrediction = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MetaData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gasDisengageProb]
    bufferOffset = _serializer.float32(obj.gasDisengageProb, buffer, bufferOffset);
    // Serialize message field [brakeDisengageProb]
    bufferOffset = _serializer.float32(obj.brakeDisengageProb, buffer, bufferOffset);
    // Serialize message field [steerOverrideProb]
    bufferOffset = _serializer.float32(obj.steerOverrideProb, buffer, bufferOffset);
    // Serialize message field [engagedProb]
    bufferOffset = _serializer.float32(obj.engagedProb, buffer, bufferOffset);
    // Serialize message field [desirePrediction]
    bufferOffset = _arraySerializer.float32(obj.desirePrediction, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MetaData
    let len;
    let data = new MetaData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gasDisengageProb]
    data.gasDisengageProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [brakeDisengageProb]
    data.brakeDisengageProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [steerOverrideProb]
    data.steerOverrideProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [engagedProb]
    data.engagedProb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [desirePrediction]
    data.desirePrediction = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.desirePrediction.length;
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/MetaData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'edac01773b36419f37d774b07e331e9b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 gasDisengageProb
    float32 brakeDisengageProb
    float32 steerOverrideProb
    float32 engagedProb
    float32[] desirePrediction
    
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
    const resolved = new MetaData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gasDisengageProb !== undefined) {
      resolved.gasDisengageProb = msg.gasDisengageProb;
    }
    else {
      resolved.gasDisengageProb = 0.0
    }

    if (msg.brakeDisengageProb !== undefined) {
      resolved.brakeDisengageProb = msg.brakeDisengageProb;
    }
    else {
      resolved.brakeDisengageProb = 0.0
    }

    if (msg.steerOverrideProb !== undefined) {
      resolved.steerOverrideProb = msg.steerOverrideProb;
    }
    else {
      resolved.steerOverrideProb = 0.0
    }

    if (msg.engagedProb !== undefined) {
      resolved.engagedProb = msg.engagedProb;
    }
    else {
      resolved.engagedProb = 0.0
    }

    if (msg.desirePrediction !== undefined) {
      resolved.desirePrediction = msg.desirePrediction;
    }
    else {
      resolved.desirePrediction = []
    }

    return resolved;
    }
};

module.exports = MetaData;
